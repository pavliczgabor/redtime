class PageController < ApplicationController
  def show
#   Adatok mookolasa csak minta celjabol  
    datas=Array.new
    datas<<DataItem.new("Pisti",Date.today,[4, 2, 0, 2])
    datas<<DataItem.new("Pisti",Date.today-1,[0, 0, 2])
    datas<<DataItem.new("Pisti",Date.today-2,[0, 1, 7, 0])
    datas<<DataItem.new("Mari",Date.today,[6, 0, 0, 2])
    datas<<DataItem.new("Mari",Date.today-1,[0, 0, 6, 2])
    datas<<DataItem.new("Mari",Date.today-2,[2, 0, 4, 2])
    sprints=["1.Sprint","2.Sprint","3.Sprint","4.Sprint"]
    @dataToShow=DataStructure.new(datas,sprints,"valami")
    render template: "pages/#{params[:page]}"
  end
end
