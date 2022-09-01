class ApplicationController < Sinatra::Base
  set default_content_type: "application/json"
  
  get '/bakeries' do
    bakeries = Bakery.all
    bakeries.to_json
  end
  
  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.to_json(include: :baked_goods)
  end

  get '/baked_goods/by_price' do
    # see the BakedGood class for the  method definition of `.by_price`
    baked_goods = BakedGood.by_price
    baked_goods.to_json
  end

  get '/baked_goods/most_expensive' do
    # see the BakedGood class for the  method definition of `.by_price`
    baked_good = BakedGood.by_price.first
    baked_good.to_json
  end

  # define route for new baked goods in the db and return data for newly created baked good as JSON
  post '/baked_goods' do
    baked_good = BakedGood.create(
      name: params[:name],
      price: params[:price],
      bakery_id: params[:bakery_id]
    )
    baked_good.to_json
  end

  #define route which updates bakery name in the db and returns data for updated bakery as JSON
  patch '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.update(name: params[:name])
    bakery.to_json
  end

  # delete baked good from db
  delete '/baked_goods/:id' do
    baked_good = BakedGood.find(params[:id])
    baked_good.destroy
    baked_good.to_json
  end

end
