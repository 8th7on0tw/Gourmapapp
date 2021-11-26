# Uncomment this line to define a global platform for your project
platform :ios, '10.0' #10.0以上指定してください

target "Gourmap" do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'NCMB', :git => 'https://github.com/NIFCLOUD-mbaas/ncmb_swift.git'
  pod 'SDWebImage', '~> 5.0'
  pod 'RealmSwift'
  pod 'KeychainAccess', :git => 'https://github.com/kishikawakatsumi/KeychainAccess.git'
  
  target 'GourmapTests' dopost_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
    pod 'SDWebImage', '~> 5.0'
  end
  
  target 'GourmapUITests' do
    pod 'SDWebImage', '~> 5.0'
  end
  
  post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
  
end

