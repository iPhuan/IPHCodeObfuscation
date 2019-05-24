#  V1.0.0
#  Created by iPhuan on 2017/11/20.

#!/usr/bin/env bash


#是否测试使用
TEST_ONLY=0

TABLE_NAME=symbols
SYMBOL_DB_FILE="symbols"
HEAD_FILE="$PROJECT_DIR/SymbolsHeader/IPHObfuscationSymbols.h"
SYMBOL_FILE="$PROJECT_DIR/IPHObfuscationTools/ObfuscationList.h"

if [ $TEST_ONLY -eq 1 ]; then
TABLE_NAME=symbols_test
SYMBOL_DB_FILE="symbols_test"
HEAD_FILE="$PROJECT_DIR/IPHCodeObfuscation/Test/IPHObfuscationSymbols-test.h"
SYMBOL_FILE="$PROJECT_DIR/IPHCodeObfuscation/Test/ObfuscationList-test.h"
fi


export LC_CTYPE=C


#维护数据库方便日后作排重
createTable()
{
echo "create table $TABLE_NAME(src text, des text);" | sqlite3 $SYMBOL_DB_FILE
}

insertValue()
{
echo "insert into $TABLE_NAME values('$1' ,'$2');" | sqlite3 $SYMBOL_DB_FILE
}

query()
{
echo "select * from $TABLE_NAME where src='$1';" | sqlite3 $SYMBOL_DB_FILE
}

#生成随机字符串
ramdomString()
{
openssl rand -base64 64 | tr -cd 'a-zA-Z' |head -c 16
}

#获取set方法名
getSetMethod()
{
arg=$1
firstLetter=${arg:0:1}
firstLetter=`echo $firstLetter | tr '[:lower:]' '[:upper:]'`
name=${arg:1}
echo "set${firstLetter}${name}"
}

#处理属性混淆
handleProperty()
{
outPutSymbol $1 $2

outPutSymbol _$1 _$2 #处理私有变量

setMethod=`getSetMethod $1`
setSymbol=`getSetMethod $2`
outPutSymbol $setMethod $setSymbol #处理set方法
}

#输出symbol
outPutSymbol()
{
echo $1 $2
insertValue $1 $2
echo "#ifndef $1" >> $HEAD_FILE
echo "#define $1 $2" >> $HEAD_FILE
echo "#endif" >> $HEAD_FILE
}


rm -f $SYMBOL_DB_FILE
rm -f $HEAD_FILE
createTable

touch $HEAD_FILE
echo '#ifndef IPHObfuscationSymbols_h
#define IPHObfuscationSymbols_h' >> $HEAD_FILE
echo "//Confuse string at `date`\n" >> $HEAD_FILE

#处理代码混淆
cat "$SYMBOL_FILE" | while read line; do

ramdom=`ramdomString`

if [[ -z "$line" ]]; then                       #空格处理
echo "" >> $HEAD_FILE
elif echo $line|grep -qe '^//'; then            #注释处理
line=${line#*//}
echo "$line has been annotated"
#elif [[ $line == *"@"* ]]; then
elif echo $line|grep -qe '^@'; then             #属性处理
line=${line#*@}                                 #删除左边到@的所有字符
handleProperty $line $ramdom
elif echo $line|grep -qe '^#pragma mark'; then  #pragma mark处理
echo $line >> $HEAD_FILE
echo "/*=========================================================================*/" >> $HEAD_FILE
elif echo $line|grep -qe '^initWith'; then      #init方法处理
outPutSymbol $line initWith$ramdom
else
outPutSymbol $line $ramdom
fi


done


echo "\n" >> $HEAD_FILE
echo "#endif" >> $HEAD_FILE


sqlite3 $SYMBOL_DB_FILE .dump  
