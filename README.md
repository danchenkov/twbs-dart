# README

**Benchmark**: 0-2s (almost immediate, no need to page update)
**Purpose:** move to proshaft, but avoid using Node, use `dartsass` and `esbuild`
**Asset pipeline:** propshaft, importmaps
**Technologies:** foreman, assets bundling with node, bootstrap from node_modules

I am trying to choose the best of at least approproate Asset Pipeline for my apps.

The project is using Bootstrap 5, not so much for styles and perks, but mainly because it illustrates the use of external library with JS and CSS components. JS part has dependency on popper.js and CSS part has optional config for Sass.

| Technology      | Description                   |
| --------------- | ----------------------------- |
| Asset Pipeline  | propshaft                     |
| Bootstrap       | source                        |
| Sass processing | dartsass (standalone)         |
| CSS minificaton | propshaft                     |
| JS minification | esbuild (standalone)          |
| Naming          | importmaps                    |
| Bundling        | deemed unnecessary for http/2 |

### Basic needs for a quick start

- bundled and minified Bootstrap 5: use the minified version from the gem
- Sass compilation: dartsass handles that
- CSS and JS minification for production: CSS is minified by dartsass already, JS is not minified and not bundled
- assets fingerprinting for production: propshaft

#### JS handling

Importmaps is included. It allows simpler reference providing a nickname to imported JS assets (whether CDN or gem or vendor folder or local folder). JS libraries have to be modularized. References can be quickly swapped (say, from gem to CDN) without changing a nickname.
JS source folder with umninified, unbundled assets is currently under `app/javascript`, not `app/assets/javascript`.

#### Sass / CSS handling

There are essentially two libraries to handle Sass files - sassc and Dart Sass. I will always be using Dart Sass in my projects. For that to work in development, a Sass stylesheet changes must be watched. So one has to have `foreman` gem to watch changes.
Dartsass takes Sass source from `app/assets/stylesheets/application.scss` and compiles it to  `app/assets/builds/application.css`. Compiling vendor styles separately is also possible as defined in `config/initializers/dartsass.rb`
See: [https://dev.to/coorasse/rails-7-bootstrap-5-and-importmaps-without-nodejs-4g8]

#### Asset Pipeline

Propshaft does not minify assets, it only handles assets paths and digital stamping / fingerprinting. Since if handles paths, it decodes `url(asset)` to `url(digested-asset)` in CSS files. Apparently CSS files do not have to be ERB for that to work.
