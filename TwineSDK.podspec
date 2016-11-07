Pod::Spec.new do |s|

    s.name              = 'TwineSDK'
    s.version           = ''
    s.summary           = 'Description of your project'
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
    s.source_files      = 'Sources/TwineSDK/**/*.swift'
    s.requires_arc      = true

end