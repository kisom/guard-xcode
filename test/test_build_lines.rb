require 'test/unit'
require 'guard/xcode'

class XcodeTest < Test::Unit::TestCase
    def test_target_build_line
        target = 'xcodebuild -target MyApp build'
        targetGuard = Guard::Xcode.new [], :target =>'MyApp'
        assert target == targetGuard.get_build_line
    end

    def test_config_build_line
        config = 'xcodebuild -configuration MyConfig build'
        configGuard = Guard::Xcode.new [], :configuration => 'MyConfig'
        assert config == configGuard.get_build_line, "expected #{config} but got #{configGuard.get_build_line}"
    end

    def test_scheme_build_line
        scheme = 'xcodebuild -scheme MyScheme build'
        schemeGuard = Guard::Xcode.new [], :scheme => 'MyScheme'
        assert scheme == schemeGuard.get_build_line
    end

    def test_arch_build_line
        arch = 'xcodebuild -arch x86_64 build'
        archGuard = Guard::Xcode.new [], :arch => 'x86_64'
        assert arch == archGuard.get_build_line
    end
end
