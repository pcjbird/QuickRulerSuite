Pod::Spec.new do |s|
    s.name             = "QuickRulerSuite"
    s.version          = "1.0.0"
    s.summary          = "A suite to quick create ruler control on iOS, which seems to be attractive. iOS上标尺控件的集合。"
    s.description      = <<-DESC
    A suite to quick create ruler control on iOS, which seems to be attractive. iOS上标尺控件的集合，该项目支持 Cocoapods 的 subspec。
    DESC
    s.homepage         = "https://github.com/pcjbird/QuickRulerSuite"
    s.license          = 'MIT'
    s.author           = {"pcjbird" => "pcjbird@hotmail.com"}
    s.source           = {:git => "https://github.com/pcjbird/QuickRulerSuite.git", :tag => s.version.to_s}
    s.social_media_url = 'http://www.lessney.com'
    s.requires_arc     = true
    s.documentation_url = 'https://github.com/pcjbird/QuickRulerSuite/blob/master/README.md'
    s.screenshot       = 'https://github.com/pcjbird/QuickRulerSuite/blob/master/logo.png'

    s.platform         = :ios, '8.0'
    s.frameworks       = 'Foundation', 'UIKit', 'CoreGraphics'
#s.preserve_paths   = ''
    s.source_files     = 'QuickRulerSuite/QuickRulerSuite.h'
    s.public_header_files = 'QuickRulerSuite/QuickRulerSuite.h'
    s.resource_bundles = {
        'QuickRulerSuite' => ['QuickRulerBundles/*.*'],
    }

    s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }

    s.subspec 'QuickSportsRuler' do |ss|
        ss.source_files = 'QuickRulerSuite/QuickSportsRuler/*.{h,m}'
        ss.public_header_files = 'QuickRulerSuite/QuickSportsRuler/QuickSportsRuler.h', 'QuickRulerSuite/QuickSportsRuler/QuickSportsRulerStyle.h'
    end

end
