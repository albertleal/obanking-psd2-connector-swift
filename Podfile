def global_deps
	pod 'RxSwift',    	 '~> 4.1'
	pod 'RxAlamofire',   '~> 4.0'
end

def testing_deps
	pod 'RxBlocking', '~> 4.1'
	pod 'RxTest',     '~> 4.1'
end

target 'OBankingConnector-iOS' do
  platform :ios, '8.0'

  use_frameworks!

  global_deps

  target 'OBankingConnectorTests-iOS' do
    inherit! :search_paths
    
    testing_deps
  end
end

target 'OBankingConnector-macOS' do
  platform :osx, '10.10'
  
  use_frameworks!

  global_deps

  target 'OBankingConnectorTests-macOS' do
    inherit! :search_paths
    
    testing_deps
  end
end