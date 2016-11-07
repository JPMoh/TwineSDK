Pod::Spec.new do |s|

    s.name              = 'TwineSDK'
    s.version           = '1.0'
    s.summary           = 'Description of your project'
    s.ios.deployment_target  = '8.0'
    s.homepage          = 'https://github.com/JPMoh/TwineSDK'
    s.license           = {
        :type => 'MIT',
        :file => 'LICENSE'
    }
    s.author            = {
        'YOURNAME' => 'jp@wirelessregistry.com'
    }
    s.source            = {
        :git => 'https://github.com/JPMoh/TwineSDK.git',
        :tag => s.version.to_s
    }
    s.source_files      = 'Sources/TwineSDK/TwineIdentityViewController.swift'
    s.requires_arc      = true

end