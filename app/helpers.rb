# Helper methods defined here can be accessed in any controller or view in the application

Alegato.helpers do
  # def simple_helper_method
  #  ...
  # end
  def markup_fragment(fragment)
    fr = fragment.extract()
    ret = fragment.dup
    nombres_propios = fr.nombres_propios
    fechas = fr.fechas
    direcciones = fr.direcciones

    nombres_propios.sort_by{|n| n.length}.reverse.each{|n|
      ret.gsub!(n,"<span class='name' id='#{n.fragment_id}'>#{n}</span>")
    }
    fechas.each{|n|
      ret.gsub!(n.context(0),"<time class='date' datetime='#{n.to_s}' id='#{n.fragment_id}'>#{n.context(0)}</time>")
    }
    direcciones.each{|n|
      if n.geocodificar
        lat,lon = n.geocodificar.ll.split(",",2)
        markup="<span class='address' id='#{n.fragment_id}'><span class='geo' style='display:none' itemprop='geo' itemscope='itemscope' itemtype='http://data-vocabulary.org/Geo/'>
        <abbr class='latitude' itemprop='latitude' title='#{lat}'>#{lat}</abbr>
        <abbr class='longitude' itemprop='longitude' title='#{lon}'>#{lon}</abbr>
        </span>#{n}</span>"
        ret.gsub!(n,markup)
      end
    }
    ret.gsub!("\n","<br />")
    ret
  end
end