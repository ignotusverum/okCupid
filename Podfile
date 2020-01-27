platform :ios, '11.0'
use_frameworks!
use_modular_headers!
inhibit_all_warnings! # supresses pods project warnings

def common
  pod 'RxDataSources'
  pod 'MERLin', :git => 'https://github.com/gringoireDM/MERLin.git', :branch => 'master'
end

target 'OkCupid' do
  common  
end

abstract_target 'Modules' do
  common
  
  target 'OCFoundation'
  target 'MatchesModule'
end

