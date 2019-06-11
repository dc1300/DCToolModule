Pod::Spec.new do |s|

  s.name         = 'DCToolModule'
  s.version      = '1'
  s.summary      = 'DCToolModule.'

  s.description  = <<-DESC
                    this is DCToolModule
                   DESC

  s.homepage     = 'https://github.com/dc1300/DCToolModule'
  s.license      = { :type => 'MIT', :file => 'FILE_LICENSE' }
  s.author       = 'DC'
  s.platform     = :ios, '8.0'
  s.source       = { :git => 'https://github.com/dc1300/DCToolModule.git', :tag => s.version.to_s }

  s.prefix_header_contents = '#import <Foundation/Foundation.h>', '#import <UIKit/UIKit.h>', '#import "DCToolModuleConfig.h"'

  s.public_header_files = 'DCToolModule/DCToolModule/**/DCToolModuleModule.h'

  s.source_files  = 'DCToolModule/DCToolModule/**/*.{h,m,swift}'

s.resources = ['PRBaseDependTool/Assets/**/*.bundle']


#---------------------------文件分级---------------------------#

s.subspec 'DependToolHeader' do |ss| #宏定义公共头文件
ss.source_files = 'PRBaseDependTool/Classes/DependToolHeader/*'
ss.dependency 'PRBaseDependTool/FunctionTool/PRMarketManager'
end

s.subspec 'Category' do |ss|

ss.subspec 'PRBassCategoryHeader' do |sss| #类别公共头文件
sss.source_files = 'PRBaseDependTool/Classes/Category/PRBassCategoryHeader/*'

sss.dependency 'PRBaseDependTool/Category/NSCalendarCategroy'
sss.dependency 'PRBaseDependTool/Category/NSDateCategroy'
sss.dependency 'PRBaseDependTool/Category/NSNumberFormatterCategroy'
sss.dependency 'PRBaseDependTool/Category/NSStringCategroy'
sss.dependency 'PRBaseDependTool/Category/NSUrlCategroy'
sss.dependency 'PRBaseDependTool/Category/UIButtonCategroy'
sss.dependency 'PRBaseDependTool/Category/UIBarButtonCategroy'
sss.dependency 'PRBaseDependTool/Category/UIColorCategroy'
sss.dependency 'PRBaseDependTool/Category/UIDeviceCategroy'
sss.dependency 'PRBaseDependTool/Category/UIImageCategroy'
sss.dependency 'PRBaseDependTool/Category/UILabelCategroy'
sss.dependency 'PRBaseDependTool/Category/UIPickerViewCategroy'
sss.dependency 'PRBaseDependTool/Category/UITextfieldCategroy'
sss.dependency 'PRBaseDependTool/Category/UITextViewCategroy'
sss.dependency 'PRBaseDependTool/Category/UIViewCategroy'
sss.dependency 'PRBaseDependTool/Category/UIViewControllerCategroy'
end


ss.subspec 'NSCalendarCategroy' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/Category/NSCalendarCategroy/*'
end

ss.subspec 'NSDateCategroy' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/Category/NSDateCategroy/*'
end

ss.subspec 'NSNumberFormatterCategroy' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/Category/NSNumberFormatterCategroy/*'
end

ss.subspec 'NSStringCategroy' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/Category/NSStringCategroy/*'
end

ss.subspec 'NSUrlCategroy' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/Category/NSUrlCategroy/*'
end

ss.subspec 'UIButtonCategroy' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/Category/UIButtonCategroy/*'
end

ss.subspec 'UIBarButtonCategroy' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/Category/UIBarButtonCategroy/*'
sss.dependency 'PRBaseDependTool/Category/UIButtonCategroy'
end

ss.subspec 'UIColorCategroy' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/Category/UIColorCategroy/*'
end

ss.subspec 'UIDeviceCategroy' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/Category/UIDeviceCategroy/*'
end

ss.subspec 'UIImageCategroy' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/Category/UIImageCategroy/*'
end

ss.subspec 'UILabelCategroy' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/Category/UILabelCategroy/*'
end

ss.subspec 'UIPickerViewCategroy' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/Category/UIPickerViewCategroy/*'
end

ss.subspec 'UITextfieldCategroy' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/Category/UITextfieldCategroy/*'
end

ss.subspec 'UITextViewCategroy' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/Category/UITextViewCategroy/*'
end

ss.subspec 'UIViewCategroy' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/Category/UIViewCategroy/*'
end

ss.subspec 'UIViewControllerCategroy' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/Category/UIViewControllerCategroy/*'
end

end

s.subspec 'LoginStatue' do |ss|
ss.source_files = 'PRBaseDependTool/Classes/LoginStatue/*'
end

s.subspec 'FunctionTool' do |ss|

ss.subspec 'MBProgressHUD+WL' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/FunctionTool/MBProgressHUD+WL/*'
sss.resources = 'PRBaseDependTool/Classes/FunctionTool/MBProgressHUD+WL/MBProgressHUD.bundle'
end

ss.subspec 'PRMarketManager' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/FunctionTool/PRMarketManager/*'
end

ss.subspec 'SSKeychain' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/FunctionTool/SSKeychain/*'
end

ss.subspec 'AlertView' do |sss|
sss.dependency 'PRBaseDependTool/DependToolHeader'
sss.source_files = 'PRBaseDependTool/Classes/FunctionTool/AlertView/*'
end

ss.subspec 'PurangUITextFieldExPand' do |sss|
sss.dependency 'PRBaseDependTool/Category/UIViewCategroy'
sss.dependency 'PRBaseDependTool/Category/UITextfieldCategroy'
sss.dependency 'PRBaseDependTool/DependToolHeader'
sss.source_files = 'PRBaseDependTool/Classes/FunctionTool/PurangUITextFieldExPand/*'
end

ss.subspec 'XLImageViewer' do |sss|
sss.source_files = 'PRBaseDependTool/Classes/FunctionTool/XLImageViewer/*'
end

ss.subspec 'Utils' do |sss|
sss.dependency 'PRBaseDependTool/Category/NSStringCategroy'
sss.dependency 'PRBaseDependTool/Category/UIColorCategroy'
sss.dependency 'PRBaseDependTool/FunctionTool/SSKeychain'
sss.source_files = 'PRBaseDependTool/Classes/FunctionTool/Utils/*'
end

end

s.subspec 'TMRouter' do |ss|
ss.source_files = 'PRBaseDependTool/Classes/TMRouter/*'
ss.dependency 'PRBaseDependTool/Category/UIImageCategroy'
end

s.dependency 'SDWebImage', '~> 4.4.6'
s.dependency 'MBProgressHUD', '~> 1.1.0'
s.dependency 'MJRefresh'
s.dependency 'YTKNetwork'
s.dependency 'YYModel'
s.dependency 'DZNEmptyDataSet'
s.dependency 'SDAutoLayout'
s.dependency 'Masonry'
    

end
