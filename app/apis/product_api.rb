class ProductAPI < Grape::API
  include Grape::Kaminari

  resources :products do
    desc '获取商品列表', notes: '
            kaminari的分页信息将会包含在返回信息的header中，以下是信息的说明:
            X-Total: 查询出的总条数
            X-Total-Pages: 总共的页数
            X-Page: 当前在第几页
            X-Per-Page: 每页显示的条数
            X-Next-Page: 下一页的页数
            X-Prev-Page: 上一页的页数'
    paginate offset: false
    params do
      optional :page, type: Integer, desc: '查询的页数,默认是1'
      optional :per_page, type: Integer, desc: '每页显示的数量,默认是25'
    end
    get do
      products = Product.all
      present products: paginate(products)
    end

    route_param :id do
      desc '获取商品详情'
      get do
        product = Product.find(params[:id])
        present product: product
      end
    end
  end
end
