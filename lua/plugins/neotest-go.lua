return {
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "fredrikaverpil/neotest-golang",
    },
    opts = {
      go_test_args = {
        "-v",
        "-race",
        "-count=1",
      },
      env = {
        DOCKER_HOST = "unix:///var/run/docker.sock",
      },
      adapters = {
        -- 1. Explicitly disable neotest-go by setting it to nil
        ["neotest-go"] = nil,
        -- 2. Configure neotest-golang as your primary
        ["neotest-golang"] = {
          -- You can add specific config here, like enabling delve for debugging
          dap_adapter = "go",
        },
      },
    },
  },
}
