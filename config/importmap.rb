# Pin npm packages by running ./bin/importmap

pin "administrate/components/table.js", to: "administrate/components/table.js"
pin "administrate/components/associative.js", to: "administrate/components/associative.js"
pin "administrate/components/select.js", to: "administrate/components/select.js"

pin "administrate/application", preload: true

pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.7.0/dist/jquery.js"
pin "jquery-ujs", to: "https://ga.jspm.io/npm:jquery-ujs@1.2.3/src/rails.js"
pin "selectize", to: "https://ga.jspm.io/npm:selectize.js@0.12.12/dist/js/selectize.js"
pin "microplugin", to: "https://ga.jspm.io/npm:microplugin@0.0.3/src/microplugin.js"
pin "sifter", to: "https://ga.jspm.io/npm:sifter@0.5.3/sifter.js"
