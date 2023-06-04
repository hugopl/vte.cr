module Vte
  class Terminal < Gtk::Widget
    def feed(data : String) : Nil
      LibVte.vte_terminal_feed(to_unsafe, data, data.bytesize)
    end

    def feed_child(data : String) : Nil
      LibVte.vte_terminal_feed_child(to_unsafe, data, data.bytesize)
    end
  end
end
