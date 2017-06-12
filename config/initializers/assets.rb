# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w(image_favorite.js edit_girl_thumbnail.js)
Rails.application.config.assets.precompile += %w(thumbnail.css.scss girl_image.css.scss)
Rails.application.config.assets.precompile += %w(girl_block.css.scss)
Rails.application.config.assets.precompile += %w(navbar.css.scss)
Rails.application.config.assets.precompile += %w(masonry.pkgd.min.js)
Rails.application.config.assets.precompile += %w(jquery.infinitescroll.min.js)
Rails.application.config.assets.precompile += %w(imagesloaded.pkgd.min.js)
Rails.application.config.assets.precompile += %w(show_girl_images.js)
Rails.application.config.assets.precompile += %w(header_scroll.js)
