Pod::Spec.new do |spec|
  spec.name         = 'MultiImageRow'
  spec.homepage     = "https://github.com/Machipla/MultiImageRow"
  spec.version      = '1.0.0'
  spec.platform     = :ios, "9.0"
  spec.authors      = 'Mario Chinchilla'
  spec.summary      = 'A multi image row for Eureka pod!'
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.source       = { :git => 'https://Machipla@github.com/Machipla/MultiImageRow.git', :tag => "#{spec.version}" }
  spec.swift_version = '4.0'
  
  spec.source_files     = "Sources/**/*.swift"
  spec.resource_bundle  = { "MultiImageRow" => "Sources/*.bundle/**/*.xib" }

  spec.dependency 'Eureka', '~> 4.1'
  spec.dependency 'AlamofireImage', '~> 3.3'
  spec.dependency 'ImagePickerCoordinator'
end