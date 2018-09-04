# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
def rxswift_pods
    pod 'RxSwift',    '~> 4.0'
    pod 'RxCocoa',    '~> 4.0'
#    pod 'RxAlamofire'
#    pod 'RxDataSources'
end

target 'GallaryApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for GallaryApp
  pod 'Kingfisher'
  pod 'ALCameraViewController'
  pod 'HGPlaceholders'
  rxswift_pods
  pod 'NVActivityIndicatorView'
  pod 'AlamofireImage'

end

target 'GallaryAppTests' do
  inherit! :search_paths
  # Pods for testing
end

target 'GallaryAppUITests' do
  inherit! :search_paths
  # Pods for testing
end
