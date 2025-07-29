return {
  autostart = true,
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { 'class\\s*=\\s*"([^"]*)',     1 },
          { 'className\\s*=\\s*"([^"]*)', 1 },
        },
      },
    },
  },
}
