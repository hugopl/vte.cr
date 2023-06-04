require "../src/vte"

def default_shell : String
  ENV["SHELL"]? || "/usr/bin/sh"
end

class BasicTerminalApp < Gtk::Application
  @[GObject::Virtual]
  def activate
    window = Gtk::ApplicationWindow.new(self)
    window.title = "Basic Terminal"
    window.set_default_size(1024, 480)

    terminal = Vte::Terminal.new
    terminal.feed("Crystal VTE bindings! 🎉️\n\n\r")
    terminal.spawn_async(
      pty_flags: :default,
      working_directory: nil,
      argv: [default_shell, "-#{default_shell}"],
      envv: nil,
      spawn_flags: :file_and_argv_zero,
      child_setup: nil,
      child_setup_data: nil,
      child_setup_data_destroy: nil,
      timeout: -1,
      cancellable: nil,
      callback: nil,
      user_data: nil
    )
    terminal.child_exited_signal.connect do
      window.destroy
    end

    window.child = terminal
    window.present
  end
end

exit(BasicTerminalApp.new.run)
