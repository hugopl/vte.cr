# Crystal VTE bindings

[VTE](https://developer-old.gnome.org/vte/unstable/index.html) is a GTK library that provides a GTK Widget for terminal emulators.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     vte:
       github: hugopl/vte.cr
   ```

2. Run `shards install`

## Usage

```crystal
require "vte"

class BasicTerminalApp < Gtk::Application
  @[GObject::Virtual]
  def activate
    window = Gtk::ApplicationWindow.new(self)
    window.title = "Basic Terminal"
    window.set_default_size(1024, 480)

    terminal = Vte::Terminal.new
    terminal.feed("Crystal VTE bindings! 🎉️")

    window.child = terminal
    window.present
  end
end

exit(BasicTerminalApp.new.run)
```

To spawn a process, e.g. `bash`, use the `Terminal#spawn_async` method, see [examples/basic_terminal.cr](examples/basic_terminal.cr).


## Contributing

1. Fork it (<https://github.com/hugopl/vte.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Hugo Parente Lima](https://github.com/hugopl) - creator and maintainer
