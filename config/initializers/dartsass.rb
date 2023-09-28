Rails.application.config.dartsass.builds = {
  "application.scss" => "application.css.erb",
  "bootstrap.scss" => "bootstrap.css"
}
#
## By default, sass is invoked with `--style=compressed --no-source-map`
# Rails.application.config.dartsass.build_options << " --quiet-deps"
