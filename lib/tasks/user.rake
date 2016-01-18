namespace :user do
  desc "TODO"
  task set_all_incomplete: :environment do
    User.all.each do |user|
      user.update_attribute :lot_id, nil
    end
  end

  task set_users_address: :environment do
    progress = 1
    total = User.all.count
    User.all.each do |user|
      p "#{progress}/#{total}"
      if !user.cep.blank?
        if !user.cep1.nil?
          begin
            if get_cep = BuscaEndereco.cep(user.cep1)
              user.update_attributes cep: user.cep, state: get_cep[:uf], city: get_cep[:cidade], street: get_cep[:logradouro]
            end
          rescue
          end
        else
          p "     CEP do usuário #{user.email} é inválido."
        end
      end
      progress += 1
    end
  end

  task set_billets_links: :environment do
    Payment.where(link_1: "LINK").each do |payment|
      portions = payment.portions
      method = payment.method
      p "portions #{portions}"
      p "method #{method}"

      payment.change_method method, portions if !payment.user.nil? && !payment.user.lot.nil?

      p "AFTER"
      p "portions #{portions}"
      p "method #{method}"
      payment.save
    end
  end

end
