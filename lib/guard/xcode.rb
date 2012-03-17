require 'guard'
require 'guard/guard'

module Guard
  class Xcode < ::Guard::Guard
    # Build an Xcode project on file change
    #
    # Should be initialised with 'guard xcode' in the target project's 
    # directory

    attr_reader :options

    # Initialize a Guard.
    # @param [Array<Guard::Watcher>] watchers the Guard file watchers
    # @param [Hash] options the custom Guard options
    def initialize(watchers = [], options = {})
      super
      @target = options[:target]
      @config = options[:configuration]
      @scheme = options[:scheme]
      @arch = options[:arch]
      
      if true == options[:all]
        @all = true
        @target = nil
      else
        @all = false
      end

      if true == options[:quiet]
        @quiet = true
      else
        @quiet = false
      end

      if true == options[:clean]
        @clean = true
      else
        @clean = false
      end
    end

    def get_build_line
      # generate the build line from the initialised options
      build_line = 'xcodebuild '

      ## configure build options
      unless nil == @config
        build_line += "-configuration #{@config} "
      end

      unless nil == @target
        build_line += "-target #{@target} "
      end

      if @all
        build_line += "-alltargets "
      end

      unless nil == @scheme
        build_line += "-scheme #{@scheme} "
      end

      unless nil == @arch
        build_line += "-arch #{@arch} "
      end
      
      unless false == @clean
        build_line += "clean "
      end

      build_line += "build"
    end

    def run_build(build_line)
      # run the build, returning a list of alerts
      #
      # returns:
      # a list of symbols; possible values include :errors and :warnings which
      # indicate the build included warnings or errors. Returning an empty list
      # means no errors were detected.
      alerts = []
      
      unless @quiet
        Notifier.notify("kicking off build with:\n#{build_line}")
      end

      output = `#{build_line}`

      unless @quiet
        Notifier.notify("build finished.")
      end

      puts output

      if output =~ /errors? generated/
        Notifier.notify("xcode: errors in build!")
        alerts.push :errors
      end

      if output =~ /warning/
        Notifier.notify("xcode: warnings in build!")
        alerts.push :warnings
      end

      alerts
    end

    # Call once when Guard starts. Please override initialize method to init stuff.
    # @raise [:task_has_failed] when start has failed
    def start
    end

    # Called when `stop|quit|exit|s|q|e + enter` is pressed (when Guard quits).
    # @raise [:task_has_failed] when stop has failed
    def stop
    end

    # Called when `reload|r|z + enter` is pressed.
    # This method should be mainly used for "reload" (really!) actions like reloading passenger/spork/bundler/...
    # @raise [:task_has_failed] when reload has failed
    def reload
    end

    # Called when just `enter` is pressed
    # This method should be principally used for long action like running all specs/tests/...
    # @raise [:task_has_failed] when run_all has failed
    def run_all
      run_build(get_build_line)
    end

    # Called on file(s) modifications that the Guard watches.
    # @param [Array<String>] paths the changes files or paths
    # @raise [:task_has_failed] when run_on_change has failed
    def run_on_change(paths)
      run_build(get_build_line)
    end

    # Called on file(s) deletions that the Guard watches.
    # @param [Array<String>] paths the deleted files or paths
    # @raise [:task_has_failed] when run_on_change has failed
    def run_on_deletion(paths)
      run_build(get_build_line)
    end

  end
end