class AdminProduct < Product
  accepts_nested_attributes_for :product_meta_tag

  def self.policy_class=(policy)
    @admin_product_policy_class = policy
  end

  def self.policy_class
    @admin_product_policy_class ||= AdminProductPolicy
  end
end
