# Uncomment the next line to define a global platform for your project
# platform :ios, '10.0'

target 'DeenOverDose' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DeenOverDose

  # add the Firebase pod for Google Analytics
  pod 'Firebase/Analytics'
  pod 'Firebase/Firestore'
  pod 'Firebase/Auth'
  pod 'GoogleSignIn'
  pod 'FirebaseFirestoreSwift'

  # https://firebase.google.com/docs/ios/setup#available-pods
  post_install do |installer|
     installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
           if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 9.0
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
           end
        end
     end
  end
		
end
