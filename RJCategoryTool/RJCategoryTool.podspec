Pod::Spec.new do |s|

  s.name         = "RJCategoryTool"
  s.version      = "0.4.2"
  s.summary      = "A iOS Fast integration of custom classifications, macro definitions and tool classes"
  s.homepage     = "https://github.com/Jack424/RJCategoryTool.git"
  s.license      = "MIT"
  s.author       = { "Jack_Gu" => "gu_ruijie@163.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/Jack424/RJCategoryTool.git", :tag => s.version}
  s.source_files = "RJCategoryTool/RJCategoryTool/RJCategoryTool/**/*.{h,m}"
  s.resources    = "RJCategoryTool/RJCategoryTool/RJCategoryTool/Resource/*.{png,xib,nib,bundle,json}"
  s.requires_arc = true

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

  s.dependency 'ReactiveObjC'

  s.dependency 'FMDB'

  s.dependency 'GTMBase64'

  s.dependency 'LYEmptyView'

  s.dependency 'UITableView+FDTemplateLayoutCell'

  # GRJDatePickerView.xib  city.json
  # s.resources    = 'PhotoBrowser/resource/*.{png,xib,nib,bundle}'
  # s.frameworks   = 'UIKit','Photos','PhotosUI'
  # s.vendored_libraries = 'HBThirdParty/HBThirdParty/FrameWork/libWeChatSDK.a'
  # s.vendored_frameworks = 'HBThirdParty/HBThirdParty/FrameWork/AlipaySDK.framework'
  # s.dependency 'UMengUShare/Social/ReducedWeChat', '~> 6.4.8.2'
end