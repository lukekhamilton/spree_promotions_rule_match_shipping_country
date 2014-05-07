 module Spree
  class Promotion
    module Rules
      class Country < Spree::PromotionRule
        has_and_belongs_to_many :country, class_name: '::Spree::Country', join_table: 'spree_countries_promotion_rules', foreign_key: 'promotion_rule_id'
        
        def eligible_countries
          country
        end

        def applicable?(promotable)
          promotable.is_a?(Spree::Order)
        end

        def eligible?(order, options = {})    
          eligible_countries.include?(order.shipping_address.country) if order.state != 'cart'
        end

        def country_ids_string
          country_ids.join(',')
        end

        def country_ids_string=(s)
          self.country_ids = s.to_s.split(',').map(&:strip)
        end

      end
    end
  end   
end
 
