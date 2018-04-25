# 오늘 뭐 먹지?

>  레일즈 MVC 패턴 중 View와 Controller만 사용해 만들어봅니다.

## 레일즈 프로젝트 생성하기
레일즈 프로젝트를 만듭니다.
```bash
$ rail new foodForToday
```
생성된 Rails 프로젝트 폴더로 이동합니다.
```bash
$ cd foodForToday
```

## controller 생성하기
$ 표시가 있으면 cmd 혹은 bash에 입력하는 명령어입니다. 
```bash
$ rails genetate controller home
```
혹은
```bash
$ rails g controller home
```
사용할 수 있습니다.

`g`는 `generate`의 약자입니다.

> 레일즈야 만들자 컨트롤러 이름은 home  


생성한 콘트롤러는 아래의 명령어로 삭제할 수 있습니다.

```bash
$ rails delete controller home
```

```bash
$ rails d controller home
```
`d`는 `delete`의 약자입니다.

> 레일즈야 지우자 컨트롤러 이름은 home


```bash
$ rails g controller home index
```
> 레일즈야 만들자 컨트롤러 이름은 home이고 index 액션도 만들어

## 액션?

Controller 안에는 사용자가 보내는 요청을 처리하는 여러 액션들이 있습니다.  
게시판 만들기를 할때 자세히 이야기하도록 하고  
`액션.html.erb` 이름의 View 파일의 요청은 해당 액션에서 처리됩니다.    
`액션.html.erb` 파일은 우리가 알고 있는 HTML과 CSS로 이루어진 파일입니다.  
`/app/views/컨트롤러/액션.html.erb`에 위치해 있습니다.

## controller 내부 로직을 만들자

먹고 싶은 메뉴의 사진을 크롬에서 검색해 저장합니다.
파일의 이름은 다르되 확장자는 동일하게 저장합니다.
(ex - 라면.jpeg, 족발.jpeg, 짜장면.jpeg, 짬뽕.jpeg)
`assets` 폴더 안에 사진 파일을 넣습니다.  
아래 형태의 폴더 트리로 만듭니다.
```
assets
  ├── config
  ├── javascript
  ├── stylesheets
  ├── images
        ├── 라면.jpeg
        ├── 족발.jpeg
        ├── 짜장면.jpeg
        └── 짬뽕.jpeg
```

## `home_controller.rb`
```ruby
class HomeController < ApplicationController
  def index
    # 먹고 싶은 메뉴를 적자
    foods = ["라면", "족발", "짜장면", "짬뽕"]
    # 하나를 뽑자
    @food = foods.sample
  end
end
```
#### `foods`와 `@food`의 차이
`foods`는 `home_controller.rb` controller 내부에서만 사용 가능하고  
`@food`는 `home_controller.rb`와 `index.html.erb` view 파일에서 사용 가능합니다.

#### `sample`
배열의 메소드 중 하나로 랜덤하게 요소 1개를 선택합니다.

## `index.html.erb`
```erb
<h1>오늘 뭐 먹지?</h1>
<img src="/assets/<%= @food%>" alt="">
<p>오늘 먹을 건 <%= @food %>입니다.</p>
```

## `routes.rb`
```ruby
Rails.application.routes.draw do
  # 웹페이지로 들어오는 순간 home controller의 index 액션으로 이동합니다
  # 메인 페이지는 home controller의 index 액션이다 하기도 합니다.
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
```

## 서버 실행하기
```bash
$ rails s
```

크롬 브라우저로 http://localhost:3000 에 접속합니다.  
새로고침해 메뉴가 바뀌는지 확인합니다.

## Bootstrap

Bootstrap CDN 붙이고 마음껏 씁니다.
 
`/app/views/layouts/application.html.erb`
```erb
<!DOCTYPE html>
<html>
  <head>
    <title>FoodForToday</title>
    <%= csrf_meta_tags %>
    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
    <!-- Boostrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
  </head>

  <body>
    <%= yield %>
    <!-- Boostrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
  </body>
</html>

```