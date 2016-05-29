---
layout: page
title: BookemDanno
hide: true
---

### URL
[https://bookemdanno.herokuapp.com/](https://bookemdanno.herokuapp.com/)

### Github URL
[https://github.com/builditdan/bookemdanno](https://github.com/builditdan/bookemdanno)

### Background and General Information
I built this application during my Ruby on Rails training with [bloc.io](https://bloc.io).

It is a website that will help you manage your bookmarks. You can add them by topic and either enter them manually or email them to danny@app2bdc20b5d5664f50a03f2e8f7c61280a.mailgun.org. Bookmarks can be made public or private. They can be previewed and searched.

### Design Information
I used [bootstrap](http://getbootstrap.com/) to aide in design and layout. It is a responsive site and should work on mobile devices as well as computer screens.

One big challenge in this project was to limit the number of topics that would display per page. I did not use a paginate plugin but instead did it manually using the params hash to track next and previous pages. I don't think my solution was elegant but I learned much along the way about how web pages interact (or don't) with each other. It made me really appreciate how easy a tool like [will_paginate](https://github.com/mislav/will_paginate) makes it. You can really get into that mindset of, "it must already be created before I start to write it myself :smile:".  


### Highlights on Gem's used
* [rspec](https://github.com/rspec/rspec-rails) for testing
* [postgres](http://www.postgresql.org/) for my production database, mysql for development
* [devise](https://github.com/plataformatec/devise) to aide in account management
* [pundit](https://github.com/elabs/pundit) to aide in security policies
* [embedly](http://embed.ly/) for bookmark previews
* [mailgun](https://www.mailgun.com/) to scrape emails for users that email their bookmarks

### Additional comments
I need to update the logic so that when links are emailed the preview image is updated. This only occurs when you edit or add a new bookmark.

I need to limit the number of bookmarks that can be viewed on one page, i.e. need to paginate. I am only doing that by topic at the moment. I should allow the user to set the number of topics/bookmarks that appear per page (currently at 5 for all users).

### Disclaimer
I provide this Web site as an example of my work. It is **not a production site** and subject to **removal** along with any content that you may have created. If you are interested in using this site or the code - feel free to download or contact me with your questions.
