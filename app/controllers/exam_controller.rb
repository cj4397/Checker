class ExamController < ApplicationController
    require 'selenium-webdriver'


def verify_site
  driver = Selenium::WebDriver.for :chrome
    begin
      driver.get(params[:website])
      if driver.title==params[:title]
         driver.quit
      render json: {site:"working"}
      else
      driver.quit
      render json: {site:"working but wrong title"}
      end
    rescue 
      driver.quit
      render json: {site:'not working'}
    end   
end

def home
  driver = Selenium::WebDriver.for :chrome
   begin
      driver.get(params[:website])
      if driver.title==params[:title]
        copy=driver.find_element(tag_name: 'h1')
        
        render json: {site:"Working",article:copy.text}
        driver.quit
      else
        driver.quit
        render json: {site:"working but not working"}
      end
    rescue 
      driver.quit
      render json: {site:'not working'}
      
      
    end   
 
end


def get_matched
  driver = Selenium::WebDriver.for :chrome
   begin
      driver.get(params[:website])
      if driver.title==params[:title]
        home_button = driver.find_element(class: 'btn-home-getmatched')
        home_button.click
        if driver.current_url==params[:match]
          buy_button = driver.find_element(class: 'ga-quiz-buying')
          buy_button.click
          driver.quit
          render json: {site:"Working"}
        else
          driver.quit
          render json: {site:"Working but wrong matching URL"}
        end
    else
      driver.quit
      render json: {site:"Wrong title"}
    end
    rescue 
      driver.quit
      render json: {site:'not working'}
    end   
 
end

def find_agent
  driver = Selenium::WebDriver.for :chrome
    begin
      driver.get(params[:website])
      if driver.title==params[:title] 
        submit = driver.find_element(xpath: '/html/body/div[2]/div/div[1]/div/div[2]/div[2]/form/div/span/button')
        clickable = driver.find_element(xpath: '/html/body/div[2]/div/div[1]/div/div[2]/div[2]/form/div/input')
        
        clickable.send_keys(params[:find])
        submit.click

        result=driver.find_element(xpath:'/html/body/div[4]/div/div/div[1]')
        if result.displayed?
            driver.quit
            render json: {site:"working with result"}
        else
            driver.quit
            render json: {site:"working without result"}
        end
      else
        driver.quit
        render json: {site:"working but wrong title"}
      end
    rescue 
      driver.quit
      render json: {site:'not working',error:(params[:website])}
    end   
end

end
