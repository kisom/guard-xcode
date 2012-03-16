require 'test/unit'
require 'guard/xcode'

class TestBuild < Test::Unit::TestCase
  def setup
    @xcode_test_path = 'test/GuardXcodeTest'
    @toplevel = Dir.pwd
    @builder = Guard::Xcode.new [], :quiet => true, :clean => true, :all => true
  end

  def teardown
    @res = nil
    @builder = nil
    Dir.chdir @toplevel
    `cp test/data/main.m "#{@xcode_test_path}/GuardXcodeTest/main.m"`
  end

  def run_with_new_main(mainfile)
    `cp "#{mainfile}" "#{@xcode_test_path}/GuardXcodeTest/main.m"`
    assert $? == 0, "copy of #{mainfile} failed: returned #{$?}, expected 0"
    Dir.chdir(@xcode_test_path)
    return @builder.run_build(@builder.get_build_line)
  end

  def test_good
    res = run_with_new_main 'test/data/main_good.m'
    assert res.empty?
  end

  def test_warnings
    res = run_with_new_main 'test/data/main_warnings.m'
    assert res == [:warnings], "expected: #{[:warnings]}, got #{res}"
  end

  def test_errors
    res = run_with_new_main 'test/data/main_error.m'
    assert res == [:errors], "expected: #{[:warnings]}, got #{res}"
  end

  def test_warnings_and_errors
    res = run_with_new_main 'test/data/main_warnings_error.m'
    assert res == [:errors, :warnings], "expected: #{[:errors, :warnings]}, got #{res}"
  end    
end