Pod::Spec.new do |s|

    s.name              = 'YOURPROJECT'
    s.version           = '0.0.1'
    s.summary           = 'Description of your project'
    s.homepage          = 'https://github.com/YOURNAME/YOURPROJECT'
    s.license           = {
        :type => 'MIT',
        :file => 'LICENSE'
    }
    s.author            = {
        'YOURNAME' => 'YOUREMAILADDRESS'
    }
    s.source            = {
        :git => 'https://github.com/YOURNAME/YOURPROJECT.git',
        :tag => s.version.to_s
    }
    s.source_files      = 'YOURPROJECT/*.{m,h}', 'AnotherFolder/*.{m,h}'
    s.requires_arc      = true

end