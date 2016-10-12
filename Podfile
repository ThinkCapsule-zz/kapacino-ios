target 'Kapacino' do

platform :ios, '8.0'
pod 'Firebase'
pod 'FirebaseUI'

use_frameworks!
pod 'AFNetworking'
pod 'Mantle'
pod 'HexColors'
pod 'KeepLayout', :git => 'https://github.com/iMartinKiss/KeepLayout.git'
pod 'INSPullToRefresh'
pod 'SDWebImage'
pod 'FBSDKLoginKit'
pod 'FBSDKCoreKit'
pod 'Contentful'
pod 'MMMarkdown'
pod 'BuddyBuildSDK'
pod 'FSImageViewer'
pod 'TTGSnackbar'
pod 'DACircularProgress'

#pod 'Material'

post_install do |installer|
  installer.pods_project.targets.each do |target|
  	puts "Processing: #{target}"
  	#if !target.to_s().start_with?("Material")
  		puts "\tForcing Swift version to 2.3"
	    target.build_configurations.each do |config|
	      config.build_settings['SWIFT_VERSION'] = '2.3'
	    end
    #else
	    #puts "\tForcing Swift version to 3.0"
	    #target.build_configurations.each do |config|
	      #config.build_settings['SWIFT_VERSION'] = '3.0'
	    #end
    #end
  end
end
end
