Pod::Spec.new do |s|
  s.name         = "JFDownload"
  s.version      = "0.0.2"
  s.summary      = "JFDownload - a real download"

  s.description  = <<-DESC
                   ##JFDownload

                   Simple util for downloading.

                   DESC

  s.homepage     = "https://github.com/jfwork"

  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }

  s.author             = { "djajcevic" => "denis.jajcevic@gmail.com" }
  s.social_media_url = "hr.linkedin.com/pub/denis-jajčević/52/a4a/a11/"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.platform     = :ios, '6.0'

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :git => "https://github.com/jfwork/JFDownload.git", :tag => "0.0.2" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = 'Classes', 'JFDownload/Classes/**/*.{h,m}'
  s.exclude_files = 'JFDownload/Classes/Exclude'

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.frameworks = 'Foundation', 'UIKit', 'CFNetwork'

  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.requires_arc = true
end
