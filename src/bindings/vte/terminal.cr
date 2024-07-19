module Vte
  class Terminal < Gtk::Widget
    def feed(data : String) : Nil
      LibVte.vte_terminal_feed(to_unsafe, data, data.bytesize)
    end

    def feed_child(data : String) : Nil
      LibVte.vte_terminal_feed_child(to_unsafe, data, data.bytesize)
    end

    # Workaround for https://gitlab.gnome.org/GNOME/vte/-/issues/2794
    struct HyperlinkHoverUriChangedSignal < GObject::Signal
      def connect(handler : Proc(::String?, Gdk::Rectangle?, Nil), *, after : Bool = false) : GObject::SignalConnection
        _box = ::Box.box(handler)
        handler = ->(_lib_sender : Pointer(Void), lib_uri : Pointer(LibC::Char), lib_bbox : Pointer(Void), _lib_box : Pointer(Void)) {
          # Generator::BuiltInTypeArgPlan
          uri = ::String.new(lib_uri) if lib_uri
          # Generator::BuiltInTypeArgPlan
          bbox = Gdk::Rectangle.new(lib_bbox, GICrystal::Transfer::None) if lib_bbox
          ::Box(Proc(::String?, Gdk::Rectangle?, Nil)).unbox(_lib_box).call(uri, bbox)
        }.pointer

        handler_id = LibGObject.g_signal_connect_data(@source, name, handler,
          GICrystal::ClosureDataManager.register(_box), ->GICrystal::ClosureDataManager.deregister, after.to_unsafe)
        GObject::SignalConnection.new(@source, handler_id)
      end

      def connect(handler : Proc(Vte::Terminal, ::String?, Gdk::Rectangle?, Nil), *, after : Bool = false) : GObject::SignalConnection
        _box = ::Box.box(handler)
        handler = ->(_lib_sender : Pointer(Void), lib_uri : Pointer(LibC::Char), lib_bbox : Pointer(Void), _lib_box : Pointer(Void)) {
          _sender = Vte::Terminal.new(_lib_sender, GICrystal::Transfer::None)
          # Generator::BuiltInTypeArgPlan
          uri = ::String.new(lib_uri) if lib_uri
          # Generator::BuiltInTypeArgPlan
          bbox = Gdk::Rectangle.new(lib_bbox, GICrystal::Transfer::None) if lib_bbox
          ::Box(Proc(Vte::Terminal, ::String?, Gdk::Rectangle?, Nil)).unbox(_lib_box).call(_sender, uri, bbox)
        }.pointer

        handler_id = LibGObject.g_signal_connect_data(@source, name, handler,
          GICrystal::ClosureDataManager.register(_box), ->GICrystal::ClosureDataManager.deregister, after.to_unsafe)
        GObject::SignalConnection.new(@source, handler_id)
      end
    end
  end
end
