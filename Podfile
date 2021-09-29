# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'GitHubExplorer' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for GitHubExplorer
  pod 'SwiftLint'
  pod 'Alamofire', '~> 5.4'
  pod 'SDWebImage', '~> 5.0'
  
  target 'GitHubExplorerTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
        end
    end
end
