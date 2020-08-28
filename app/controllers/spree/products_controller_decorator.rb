module Spree::ProductsControllerDecorator

    def show
      redirect_if_legacy_path

      @taxon = params[:taxon_id].present? ? Spree::Taxon.find(params[:taxon_id]) : @product.taxons.first

      if stale?(etag: product_etag, last_modified: @product.updated_at.utc, public: true)
        @product_summary = Spree::ProductSummaryPresenter.new(@product).call
        @product_properties = @product.product_properties.includes(:property)
        @product_price = @product.price_in(current_currency).amount
        load_variants
        @product_images = product_images(@product, @variants)
        @product_group_buys = @product.active_group_buys
      end
    end

    def product_etag
      [
        store_etag,
        @product,
        @taxon,
        @product.possible_promotion_ids,
        @product.possible_promotions.maximum(:updated_at),
        @product.active_group_buys.ids,
        @product.active_group_buys.maximum(:updated_at),
      ]
    end
end

Spree::ProductsController.prepend Spree::ProductsControllerDecorator