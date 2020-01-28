platform :ios, '11.0'
use_frameworks!
use_modular_headers!
inhibit_all_warnings! # supresses pods project warnings

def common
  pod 'RxDataSources'
  pod 'SwiftGen', '~> 5.3.0'
  pod 'MERLin', :git => 'https://github.com/gringoireDM/MERLin.git', :branch => 'master'
end

target 'OkCupid' do
  common  
end

def imageLoading
  pod 'OKImageDownloader'
end

def tests
    pod 'Quick'
    pod 'Nimble'
    pod 'RxTest'
end

abstract_target 'Modules' do
  common
  
  target 'OCFoundation' do
    target 'OCFoundationTests' do
      inherit! :search_paths
      tests
    end
  end
  
  target 'MatchesModule' do
    imageLoading
    target 'MatchesModuleTests' do
      inherit! :search_paths
      tests
    end
  end
end

