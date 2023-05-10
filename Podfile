# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

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
#pod 'RIBs'

  # Pods for RxSwiftStudyInUIkit

  target 'RxSwiftStudyInUIkitTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxTest'
  end

  target 'DataLayer' do
    network_libs
    end
end


