class AddSpreeCountryPromotionRulesTable < ActiveRecord::Migration
  def change
    create_table "spree_countries_promotion_rules", id: false, force: true do |t|
      t.integer "country_id"
      t.integer "promotion_rule_id"      
    end

    add_index "spree_countries_promotion_rules", ["country_id"], name: "index_countries_promotion_rules_country_id", using: :btree
    add_index "spree_countries_promotion_rules", ["promotion_rule_id"], name: "index_countries_promotion_rules_promotion_rule_id", using: :btree
  end
end
