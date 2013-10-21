# encoding: utf-8

module ApplicationHelper
    
    def full_title(page_title)
		
		base_title = "Rede de pesquisadores"
		
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

    def link_to_add_fields(name, f, association)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        fields = f.fields_for(association, new_object, child_index: id) do |builder|
        render('shared/' + association.to_s.singularize + "_fields", f: builder)
        end
        link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
    end

    def decide_kudo_string_for_input(input)
        if current_user.gave_kudo_to input
            total = input.kudos.count - 1 #retirei o Kudo do usuário atual
            return "Você parabenizou, e outra pessoa também" if total == 1
            return "Você parabenizou, e outras " + total.to_s + " pessoas também" if total > 0
            return "Você parabenizou"
        else
            return "#{input.kudos.count} pessoa parabenizou" if input.kudos.count == 1
            return "#{input.kudos.count} pessoas parabenizaram" if input.kudos.count > 0
            return ""
        end
    end
end
