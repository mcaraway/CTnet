Slim::Engine.set_options shortcut: {
            '#' => {attr: 'id'},
            '.' => {attr: 'class'},
            'c' => {tag: 'container'},
            '&' => {tag: 'input', attr: 'type'}, 
            '@' => {attr: 'role'},
            '^' => {attr: %w(data-role role)}
           }