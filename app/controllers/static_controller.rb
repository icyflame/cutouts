class StaticController < ApplicationController
  def index
    if user_signed_in?
      redirect_to "/users/"
    else
      heading = "Cutouts - File away articles you love, forever"
      desc = "Cutouts is an online bookmarking application which allows you to cut out parts of online articles and store them forever. It is hosted on Heroku. It is completely free and the code is open source on github"

      set_meta_tags og: { title: heading,
                          description: desc,
                          url: fully_qualified_root_url,
                          type: "website",
                          image: cutouts_show_image_url },
                          twitter: {
                            card: "summary",
                            site: "@CutoutsApp",
                            title: heading,
                            description: desc,
                            image: {
                              _: cutouts_show_image_url,
                              alt: "Scissors"
                            }
                          },
                          title: heading,
                          description: desc,
                          reverse: true
    end
  end

  def about
      heading = "Cutouts - File away articles you love, forever"
      desc = "Cutouts is an online bookmarking application which allows you to cut out parts of online articles and store them forever. It is hosted on Heroku. It is completely free and the code is open source on github"

      set_meta_tags og: { title: heading,
                          description: desc,
                          url: about_page_url,
                          type: "website",
                          image: cutouts_show_image_url },
                          twitter: {
                            card: "summary",
                            site: "@CutoutsApp",
                            title: heading,
                            description: desc,
                            image: {
                              _: cutouts_show_image_url,
                              alt: "Scissors"
                            }
                          },
                          title: heading,
                          description: desc,
                          reverse: true
  end
end
