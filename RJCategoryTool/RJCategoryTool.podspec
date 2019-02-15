Pod::Spec.new do |s|

  s.name         = "RJCategoryTool"
  s.version      = "0.0.1"
  s.summary      = "A iOS Fast integration of custom classifications, macro definitions and tool classes"
  s.homepage     = "https://github.com/Jack424/RJCategoryTool.git"
  s.license      = "MIT"
  s.author       = { "Jack_Gu" => "gu_ruijie@163.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/Jack424/RJCategoryTool.git", :tag => s.version}
  s.source_files = "RJCategoryTool/RJCategoryTool/RJCategoryTool/**/*.{h,m}"
  # s.resources    = "RJCategoryTool/RJCategoryTool/resource/*.png"
  s.requires_arc = true


end