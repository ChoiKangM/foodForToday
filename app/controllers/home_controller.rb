class HomeController < ApplicationController
  def index
    # 먹고 싶은 메뉴를 적자
    foods = ["라면", "족발", "짜장면", "짬뽕"]
    # 하나를 뽑자
    @food = foods.sample
  end
end
