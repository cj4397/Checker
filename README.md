# README

* Ruby version
    ► ruby "3.3.0"
* System dependencies
    ► simplecov
    ► selenium-devtools
    ► rspec-rails

* Deployment instructions

    ► rails s

* Content
  
    ○ Verify Site

        ► http://127.0.0.1:3000/verify_site

        - This check if the website is operational and has correct title
            ☺ if operational it will have a JSON response of `site:"working"`
            ☻ if website cannot be reached or not operational it will have JSON response of `site:'not working'`
            ☻ if website is operational but has wrong title it will have a JSON response of `site:"working but wrong title"`
        ↔ Has parameters:
            ► website : string         => the website to check
            ► title : string           => title of the website

    ○ Home

        ► http://127.0.0.1:3000/home
  
        - This visits the website and gets the first articles's title and responses with JSON `site:"Working"` and the title it got
        ↔ Has parameters:
            ► website : string          => the website to check
            ► title : string            => title of the website

    ○ Get Matched

        ► http://127.0.0.1:3000/get_matched
  
        - This checks and visits the website and click the "Get Matched Now" button and visit the correct page
            ☺ if it works and visited the correct address after the click it response JSON `site:"Working"`
            ☻ if it works but visited the wrong page it response JSON site: 'Working but wrong matching URL'
        ↔ Has parameters:
            ► website : string          => the website to check
            ► title : string            => title of the website
            ► match : string            => the address after the click

    ○ Find Agent

        ► http://127.0.0.1:3000/find_agent
  
        - This uses the search bar to search an agent in the website
            ☺ if it has a search result it response JSON `site:"working with result"`
            ☻ if it has no result it response JSON `site:"working without result"`
        ↔ Has parameters:
            ► website : string          => the website to check
            ► title : string            => title of the website
            ► find : string             => the agent to find
