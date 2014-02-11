#![](https://raw.github.com/proxygear/exo_cms/master/docs/exo_logo.png)

EXO is a [Rails Engine](http://guides.rubyonrails.org/engines.html) that deliver CMS vanillia.
It can be used as a standalone to create small sites or used other an existing application to allow content edition.
Whatever your usage, It was designed to work in symbios with Rails.
It's not a closed box, but something made to be easily customisable and extensible.

It looks like this out of the box:
![](https://raw.github.com/proxygear/exo_cms/master/docs/exo_demo.png)

##Before continuing

It's an beta version.
Things can change a lot while polishing the solution.

##This README contains

* A get started Guide
* Some Advanced documentation
* The roadmap
* Feedbacks and questions
* Lycence
* Usage warning

##Get started guide

This guide covers basic usage of EXO.
Following it you will be able to creating a little blog:

* Installation
* Site creation
* Views
* Block Helpers
* Tick object
* Meta models

###Installation
 
EXO run over Rails >= 4.0.0 and Mongodb >= 4.0.0 ([quick install guide](https://github.com/proxygear/exo_cms/blob/master/docs/quick_mongoid_4_install.md)).

    # Create a new rails app without active record, let’s call it: my_blog
    $ rails new my_blog --skip-active-record
    
    # Add exo_cms to your Gemfile
    $ gem 'exo_cms'
    
    # Go in the app folder and bundle
    $ cd my_blog && bundle
    
    # Let’s install the exo engine into your fresh app 
    $ rails 
    $ rails generate devise:install
    $ rails generate mongoid:config
    $ rails generate exo:engine:install

The generator did:

* added couple additional gems (for development purpose)
* required the exo_cms from your application
* generated an initializer
* add a route

###Site creation

    # Add an admin localy to be able to manage the content 
    $ rake exo:contributors:new[your_email@something.com,a_password] 

    # Let’s generate a site config file
    $ rake exo:generate[my_blog] 

It generated couple of folders and a config file `config/exo/my_blog.yml`.
Let's take a look to it.

    ---
    theme: 'my_blog'
    main_host: 'my_blog.com'
    hosts: 
    contributors: 
    resources: 
    routes: 

* theme is the path that gonna be used for loading views
* main_host is the host that will be used, replace it by `localhost` since we are working localy
* hosts: is an array of accepted domain that will be redirected to the main_host
* contributors: list of contributors to link automagicaly
* resources: meta model description
* routes: routing of your site

Let's modify this file as following:

    ---
    theme: 'my_blog'
    main_host: localhost
    hosts:
    contributors: 
    - your_email@something.com
    resources:
      post:
        short_intro:
           type: text
           required: true
        text:
           type: text
    routes:
      root:
         path: /
         to: /home
      home:
         path: /home
         view: /home
      post:
         path: /post/:post_slug_id
         view: /posts/show

Let's continue and seed our app.

    $ rake exo:seed[my_app]
    # Finally start the rails server 
    $ rails s

Definitions were saved in the database and couple of views where generated.
Try in your browser http://localhost:3000 and you should be redirected to your home page.
You can also access the admin via http://localhost:3000/admin and login with your email/password.
 
###Views & Helpers

Let's dig a little bit more.

Now I already prepare some views and assets [here](https://github.com/proxygear/exo_resources)
Replace all the files in your app.

CSS and JS are here only to proide some prettyness, so let's focus on the views.

####Exposed objects

Open `layouts/my_blog/application.html.haml`.
You'll see in the head the following line: `= stylesheet_link_tag    exo_site.nest_path(:application), media: "all", "data-turbolinks-track" => true`

`exo_site` is a decorated site object that allow you to access resources, settings and more ...

As you can see it has a `nest_path` method.
It will change `/assets/application.css` into `/assets/my_blog/application.css`

You may also access to the current route object : `exo_route`.

####BlockHelper

Open `views/my_blog/home.html` and look at the first two lines:

    = exo_block_tag(:tag_line) do
      %h1 My super blog tag line

This is an exo block tag.
Only the first parameter is required, it's an ID that should be unique to the page.
This ID will be use to trace this block to data base.
You can provide additional option like a usual rails html_tag:

    = exo_block_tag(:tag, class: [:a, :b], custom_attr: 'something') do
      %h1 Blabla
      %p and voila!

The content of the block is a fall back if nothing is found in the DB.
Go ahead on your admin and edit the home page.

####Access resources (models)

So you remember in the config file `my_blog.yml` the resources:

    resources:
      post:
        short_intro
           type: text
           required: true
        text:
           type: text

Exo::Resource emulate a more or less a model, except their definition is store in the BD.
When you did run the seed task, it registered the post resource.

You can access the resource obect this way: `resource = exo_site.resource(:post)` where :post is the resource identifier.
Then if you wan to get a mongoid scope on the items of the resource: `resource.items`.

Resource items always have a name and a publication date (name and plublished_at).
Then the extra fields.

See `views/my_blog/home.html` for a detailed usage exemple.

##Keep digging (Advanced doc)

### Multi sites

Exo can run multiple sites at a time.
Just create add config yml file and setup different domains.
Not that multiple site may use same 'theme' aka view folder.

###Multi contributors

You can generate contributors for your exo engine.
Contributor has_many sites and vice versa.
A contributor can access only to those sites with the same credentials on the site.main_host /admin url.

For now only 'user' features are enable.
Later on, I plan to add features to manage models, fields and routes directly via the interface with different contributor right levels (see Roadmap).

### Resource fields

Check again the config yml file and let's focus on fields

    resources:
      post:
        short_intro:
           type: text
           required: true
        text:
           type: text

Remember that before adding anything, an item has a publish_at date and a name.
The name is used to generate the item slug_id (that can be used as an url id).
So name have to be unique.

Eeach additional field has a unique id withing the resource (for example short_intro).
It contains at least a type and options, for instance required.
Base types are [defined here](https://github.com/proxygear/exo_cms/tree/master/app/models/exo/resource/item)

* SimpleValue: string, text, date, ...
* AssetValue: file and pictures
* ListValue: select type
* Markdown
* BelongsTo: (not reflected belongs_to relation)
* HasMany: (not reflected has_many relation)

They all inherit from AbtractValue or AbstractRelation.
If you want to implement your own, you need to inherit one of them.

And let me time to implement a hook for that.

###Assets (pictures and files)

Assets upload is made through carrier wave and fogs.
Localy (Dev/Test) it use the mongoid grid_fs.
In production, it use by default AWS S3 but you can customize this through the initializer.
See also carrier wave documentation.

##Dependencies

Main stuff used by EXO CMS, check the [gemspec](https://github.com/proxygear/exo_cms/blob/master/exod.gemspec) for more details:

* Zurb Foundation 5
* Font Awesome
* Rails >= 4.0.0
* Mongoid >= 3.0.0
* Decent Exposure
* Devise
* Simple Form
* CarrierWave/Fog
* Pygments

##Roadmap

What I will be comming soon.
If you have ideas or want to participate, contact me or create an issue ;)

* More spec
* More docs
* Master admin: an admin to rule them all
* Replace CKEditor: by something lighter
* Meta Data Import/Export
* Theme Import/Export

##Feedbacks or Questions ?

Feel free to create [an issue](https://github.com/proxygear/exo_cms/issues) and/or to [contact me](mailto:benoit@proxygear.com).

##Lycence

First this project is under MIT lycence.
This may change, but basicaly, do whatever you want with it as long as:
* You give credit of it's usage
* You do not sell unmodified version rot13("ZBGURESHPXRE")
* You speack about it to your fellows

##Usage warning

I warn you that using this peace of tech is your entire responsability.
No use to come back yelling at me for security or whatever trouble in production.
I wish nobody fall in such unconfortable situation and will be honestly really sad for you.
But nothing more.
And do not pretend you haven't read it because it's at the end of the file !