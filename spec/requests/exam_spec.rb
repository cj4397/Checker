require 'rails_helper'
require 'selenium-webdriver'

WINDOWS_HOST = `cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }'`.strip
CHROMEDRIVER_URL = "http://#{WINDOWS_HOST}:9515/"



RSpec.describe "Exams", type: :request do

    describe "POST /verify_site" do
      it "renders a successful response" do
          post '/verify_site',params: {
            website:"https://www.rate-my-agent.com/",
            title:"❤️Top Rated Real Estate Agents & Reviews of the Best Realtors in Canada & USA in 2024"}
                
          json_response = JSON.parse(response.body)
          expect(json_response).to eq ({'site' =>'working'})
      end
      it "renders an unsuccessful response" do
      post '/verify_site',params: {
                      website:"selenium.dev/selenium/web/web-form",
                      title:"❤️Top Rated Real Estate Agents & Reviews of the Best Realtors in Canada & USA in 2024"
                    }
                    json_response = JSON.parse(response.body)
        expect(json_response).to eq ({'site'=> 'not working'})
      end

    end

    describe "POST /home" do
      it "gets the title of the first article " do
          post '/home',params: {
              website:"https://www.rate-my-agent.com/",
              title:"❤️Top Rated Real Estate Agents & Reviews of the Best Realtors in Canada & USA in 2024"
            }
          json_response = JSON.parse(response.body)
          expect(json_response.keys).to match_array(["site","article"])
      end
    end

    describe "POST /get_matched" do
      it "click the Get Matched Now button and visit the correct page" do
          post '/get_matched',params: {
              website:"https://www.rate-my-agent.com/",
              title:"❤️Top Rated Real Estate Agents & Reviews of the Best Realtors in Canada & USA in 2024",
              match:"https://www.rate-my-agent.com/quiz?cta=take-quiz-home"
            }

          json_response = JSON.parse(response.body)
           expect(json_response).to eq ({'site'=> 'Working'})
      end

      it "click the Get Matched Now button but visit the wrong page" do
          post '/get_matched',params: {
              website:"https://www.rate-my-agent.com/",
              title:"❤️Top Rated Real Estate Agents & Reviews of the Best Realtors in Canada & USA in 2024",
              match:"https://www.rate-my-agent.com/quiz"
            }

          json_response = JSON.parse(response.body)
           expect(json_response).to eq ({'site'=> 'Working but wrong matching URL'})
      end
    end

    describe "POST /find_agent" do
      it "type the agent's name in the search bar and submit to find agent and it has result" do
          post '/find_agent',params: {
              website:"https://www.rate-my-agent.com/",
              title:"❤️Top Rated Real Estate Agents & Reviews of the Best Realtors in Canada & USA in 2024",
              find: "mike"
            }

          json_response = JSON.parse(response.body)
           expect(json_response).to eq ({'site'=> 'working with result'})
      end

      it "type the agent's name in the search bar and submit to find agent and it has no result" do
          post '/find_agent',params: {
              website:"https://www.rate-my-agent.com/",
              title:"❤️Top Rated Real Estate Agents & Reviews of the Best Realtors in Canada & USA in 2024",
              find: "0000000"
            }

          json_response = JSON.parse(response.body)
           expect(json_response).to eq ({'site'=> 'working without result'})
      end
    end

end
