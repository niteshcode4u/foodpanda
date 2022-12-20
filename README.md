# Foodpanda

### How to start this application:
  * Do git clone this repo into your loca with `git clone https://github.com/niteshcode4u/foodpanda.git`
  * Go inside the repo with `cd foodpanda`
  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


### List View

![Screenshot 2022-12-07 at 8 08 25 AM](https://user-images.githubusercontent.com/20892499/206077239-e0fc167a-d590-4ed5-8293-5675fa9cf73d.png)


### Details View

![Screenshot 2022-12-07 at 8 08 38 AM](https://user-images.githubusercontent.com/20892499/206077254-bceda2d4-f2e2-47d7-a0f4-bd25a2d1c5e7.png)

### Test coverage

Note: Skipped UI related files from coverage 

![image](https://user-images.githubusercontent.com/20892499/206077560-38049d4d-4311-491a-83f9-b4414bfbf48b.png)


### Area of Enhancement

  1. Here response of content API can be Cached or saved to database specially static part of the recipe like: Name, Chef, details etc. 
    But to complete this challange I am fetching on every request however it's not recommeded for large amount of data.
  2. Assumed response structure will same as we are getting here like `{"includes: [], items: []}`. Also, when we are not having data for `chef` or `tags`
    I kept it like `Not Available`
  3. Used `Phoenix LiveView` to complete UI for this challange but can be acheived using normal way of using views 
