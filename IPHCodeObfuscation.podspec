#
# Be sure to run `pod lib lint Categories.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "IPHCodeObfuscation"
  s.version          = "1.0.3"
  s.summary          = "Code Obfuscation."
  s.description      = <<-DESC
                        This pod provides a IPHCodeObfuscation module;.
                       DESC
  s.homepage         = "https://github.com/iPhuan"
   s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = "iPhuan"
  s.source           = { :git => "https://github.com/iPhuan/IPHCodeObfuscation.git", :tag => s.version }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.public_header_files = "SymbolsHeader/*.h"
  s.source_files = "SymbolsHeader/*.h"

end
