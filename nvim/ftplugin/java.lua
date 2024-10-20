local jdtls = require 'jdtls'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '/Users/mchurch/jdtls_projects/' .. project_name
vim.o.tabstop = 2
vim.o.shiftwidth = 2
local bundles = { vim.fn.glob('/Users/mchurch/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar', true) }
vim.list_extend(bundles, vim.split(vim.fn.glob('/Users/mchurch/vscode-java-test/server/*.jar', true), '\n'))
local root_markers = { 'gradlew', 'pom.xml' }
local root_dir = require('jdtls.setup').find_root(root_markers)

local on_attach = function(client, bufnr)
  client.server_capabilities.semanticTokensProvider = nil
end

local config = {
  settings = {
    java = {
      references = {
        includeDecompiledSources = true,
      },
      eclipse = {
        downloadSources = true,
      },
      maven = {
        downloadSources = true,
      },
      signatureHelp = { enabled = true },

      completion = {
        favoriteStaticMembers = {
          'org.hamcrest.MatcherAssert.assertThat',
          'org.hamcrest.Matchers.*',
          'org.hamcrest.CoreMatchers.*',
          'org.junit.jupiter.api.Assertions.*',
          'java.util.Objects.requireNonNull',
          'java.util.Objects.requireNonNullElse',
          'org.mockito.Mockito.*',
        },
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      inlayHints = { parameterNames = { enabled = 'all' } },

      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
        },
        useBlocks = true,
      },
    },
  },
  cmd = {
    '/Users/mchurch/.sdkman/candidates/java/current/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.level=ALL',
    '-Xmx1G',
    '-javaagent:/Users/mchurch/lombok.jar',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    '/Users/mchurch/jdtls-new/jdt-language-server-1.34.0-202404031240/plugins/org.eclipse.equinox.launcher_1.6.800.v20240304-1850.jar',
    '-configuration',
    '/Users/mchurch/jdtls-new/jdt-language-server-1.34.0-202404031240/config_mac',
    '-data',
    workspace_dir,
  },
  -- root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
  root_dir = root_dir,

  init_options = {
    bundles = bundles,
    extendedCapabilitites = jdtls.extendedClientCapabilities,
  },
  on_attach = on_attach,
}

vim.keymap.set('n', '<leader>tc', jdtls.test_class, { desc = '[T]est [C]lass' })
vim.keymap.set('n', '<leader>tr', jdtls.test_nearest_method, { desc = '[T]est [R]un' })

jdtls.start_or_attach(config)
