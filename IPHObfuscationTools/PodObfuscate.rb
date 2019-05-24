#  V1.0.1
#  Created by iPhuan on 2017/11/22.
#  处理Pod代码混淆脚本


def do_obfuscate
	post_install do |installer|
        puts "
准备为所有Pod添加代码混淆IPHObfuscationSymbolsHeader.h头文件引用"
        puts "================================================================"
        
		installer.pods_project.targets.each do |target|
			# 如果target在白名单当中则执行混淆
			target.build_configurations.each do |target_config|
				# target_config有Release和Debug两种情况，此处只随意处理一种情况，避免多次import头文件
				if target_config.name == "Release"
					prefix_header = target_config.build_settings['GCC_PREFIX_HEADER']
					if prefix_header
#                        puts "\nTarget: #{target}"

						path = "Pods/" + "#{prefix_header}"
#                        puts "Prefix Header Path: #{path}"

						# 打开文件在末尾追加内容
						file = File.new("#{path}", "a")
						file.puts "#import \"IPHObfuscationSymbolsHeader.h\""
                        
                        puts "#{target} -->Done"
						
						# 获取pch文件名
#                        paths = prefix_header.split("/")
#                        puts "Add `#import "IPHObfuscationSymbolsHeader.h"` in #{paths.last}"

						file.close
					end
				end
			end
		end
        
        puts "================================================================"
        puts "所有Pod代码混淆头文件引用添加成功！
        
        "
	end
end

