# nvim-lazy_load-custom

`nvim-lazy_load-custom` is a starter kit for Neovim that primarily focuses on plugin management and optimizing startup time. It comes pre-setup with various plugins.

## Features

- Fast startup time
- Easy and intuitive plugin management
- Delayed loading based on `lazy.nvim`

## Installation

You can install `nvim-lazy_load-custom` with the following steps:

```bash
git clone https://github.com/garchomp-game/nvim-lazy_load-custom ~/.config/nvim
```

## Usage

After installation, you can start using it immediately with nvim.

Plugins can be added as follows:

```lua
return {
  'username/repositoryname',
  opts = function()
    -- more options...
  end,
}
```

If there are dependencies for specific plugins, you can group them together like this:
```lua
return {
  {
    'username/repositoryname',
    opts = function()
      -- more options...
    end,
  },
  {
    'username/repositoryname2',
    opts = function()
      -- more options...
    end,
  }
}
```

## Project Structure and Settings

### Plugin Management

- **plugins folder**: In this project, plugins such as `treesitter`, `mason`, `null-ls` are managed within the `plugins` folder. The configuration for each plugin is done in the corresponding files within this folder.

### Key Mappings

- **Plugin-related key mappings**: Key mappings related to plugins are primarily set in the `plugins` folder.
- **Basic key mappings and options**: General key mappings and Neovim options are listed in `lua/config/mappings.lua` and `lua/config/option.lua`.

### LSP and Treesitter Settings

- **LSP (Language Server Protocol)**: LSP related settings are managed in the `mason-lspconfig` within the `plugins/mason.lua` file. Additionally, configurations not covered by `mason-lspconfig` are handled in `null-ls.lua`.
- **Treesitter**: The settings for `nvim-treesitter` are defined within its configuration file, including custom settings such as `blade`.

### Plugin Usage

- For detailed usage and configuration of plugins, please refer to the official websites of each plugin. They often provide more comprehensive information and examples.

## Dependencies

- Neovim (version 0.7.0 or higher recommended)
- Git: Necessary for installing and updating plugins
- ripgrep (rg): Used for enhancing search capabilities in `telescope` and other plugins
- Node.js: Required for `nvim-treesitter` and Node.js based LSP
- Python: Needed for Python-based LSP and plugins
- Neovim Python Client: Required for Python plugins as indicated by `:checkhealth` warnings
- Neovim Ruby Client: Necessary for Ruby-based plugins
- Neovim Node.js Client: Required for Node.js-based plugins

## Contributing

If you are interested in contributing to the project, please do so through GitHub Issues or Pull Requests.

## License

This project is released under the [MIT License](LICENSE).

## Contact

For any questions, please contact us through GitHub Issues.
