Pod::Spec.new do |s|

  s.name         = "RJCategoryTool"
  s.version      = "0.1.6"
  s.summary      = "A iOS Fast integration of custom classifications, macro definitions and tool classes"
  s.homepage     = "https://github.com/Jack424/RJCategoryTool.git"
  s.license      = "MIT"
  s.author       = { "Jack_Gu" => "gu_ruijie@163.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/Jack424/RJCategoryTool.git", :tag => s.version}
  
  # s.resources    = "RJCategoryTool/RJCategoryTool/RJCategoryTool/Resource/*.{png,xib,nib,bundle,json}"
  s.requires_arc = true

  s.source_files = "RJCategoryTool/RJCategoryTool/RJCategoryTool/*.{h,m}"
  # s.source_files = "RJCategoryTool/RJCategoryTool/RJCategoryTool/**/*.{h,m}"

  s.default_subspec  = 'Resource'
  s.subspec 'Resource' do |resource|
    resource.resources    = "RJCategoryTool/RJCategoryTool/RJCategoryTool/Resource/*.{png,xib,nib,bundle,json}"
  end

  s.default_subspec  = 'Tool'
  s.subspec 'Tool' do |tool|
    tool.source_files = "RJCategoryTool/RJCategoryTool/RJCategoryTool/Tool/*.{h,m}"
  end


  s.default_subspec  = 'Category'
  s.subspec 'Category' do |category|
    category.source_files = "RJCategoryTool/RJCategoryTool/RJCategoryTool/Category/*.{h,m}"
  end

  s.default_subspec  = 'Macros'
  s.subspec 'Macros' do |macros|
    macros.source_files = "RJCategoryTool/RJCategoryTool/RJCategoryTool/Macros/*.{h,m}"
  end

  s.dependency 'Masonry'
  s.dependency 'AFNetworking'
  s.dependency 'SDWebImage'
  s.dependency 'MJExtension'
  s.dependency 'MJRefresh'
  s.dependency 'SDCycleScrollView'
  s.dependency 'MBProgressHUD'
  s.dependency 'Toast'
  s.dependency 'ZLPhotoBrowser'
  s.dependency 'RTRootNavigationController'


  # GRJDatePickerView.xib  city.json
  # s.resources    = 'PhotoBrowser/resource/*.{png,xib,nib,bundle}'
  # s.frameworks   = 'UIKit','Photos','PhotosUI'
  # s.vendored_libraries = 'HBThirdParty/HBThirdParty/FrameWork/libWeChatSDK.a'
  # s.vendored_frameworks = 'HBThirdParty/HBThirdParty/FrameWork/AlipaySDK.framework'
  # s.dependency 'UMengUShare/Social/ReducedWeChat', '~> 6.4.8.2'
end