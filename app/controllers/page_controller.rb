# class PageController < ApplicationController
#   def show
#     projects = ["Asd", "Qwe"]
#     sprints = ["Sprint1", "Sprint2"]
#     names = ["Foo", "Bar", "Baz"]
#     @options = SubmitOptions.new(projects, sprints, names)
#
# #   Adatok mookolasa csak minta celjabol
#     datas=Array.new
#     datas<<DataItem.new("Pisti",Date.today,[4, 2, 0, 2])
#     datas<<DataItem.new("Pisti",Date.today-1,[0, 0, 2, 1])
#     datas<<DataItem.new("Pisti",Date.today-2,[0, 1, 7, 0])
#     datas<<DataItem.new("Mari",Date.today,[6, 0, 0, 2])
#     datas<<DataItem.new("Mari",Date.today-1,[0, 0, 6, 2])
#     datas<<DataItem.new("Mari",Date.today-2,[2, 0, 4, 2])
#     sprints=["1.Sprint","2.Sprint","3.Sprint","4.Sprint"]
#     @dataToShow = DataStructure.new(datas,sprints,"valami")
#     render template: "pages/#{params[:page]}"
#   end
# end

class PageController < ApplicationController
  def show

#   Adatok mookolasa csak minta celjabol
    datas=Array.new
    datas<<EstimatedData.new("2017.11.24",20,4, 16)
    datas<<EstimatedData.new("2017.11.25",20,4, 12)
    datas<<EstimatedData.new("2017.11.26",20,4, 8)
    datas<<EstimatedData.new("2017.11.27",20,2, 6)
    datas<<EstimatedData.new("2017.11.28",18,1, 5)
    datas<<EstimatedData.new("2017.11.29",12,1, 4)
    datas<<EstimatedData.new("2017.11.30",0,4, 0)
    datas<<EstimatedData.new("2017.11.31",0,4, -4)

    sprints=["Dátum","Becslés","Tény","Hátralévő"]
    @dataToShow = DataStructure.new(datas,sprints,"valami")
    render template: "pages/#{params[:page]}"
  end
end