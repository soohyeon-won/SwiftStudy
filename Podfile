# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def test_pods
    pod 'RxTest'
    pod 'RxBlocking'
    pod 'Nimble'
end

def network_libs
  pod 'Alamofire'
  pod 'Moya/RxSwift'
end

target 'RxSwiftStudyInUIkit' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

pod 'RxSwift'
pod 'RxCocoa'
pod 'SnapKit'
pod 'Then'
pod 'ReactorKit'

  # Pods for RxSwiftStudyInUIkit

  target 'RxSwiftStudyInUIkitTests' do
    inherit! :search_paths
    # Pods for testing
    test_pods
  end
end

target 'DataLayer' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    network_libs
    
    target 'DataLayerTests' do
        inherit! :search_paths
        test_pods
    end
end
