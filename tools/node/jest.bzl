load("@npm//jest-cli:index.bzl", _jest_test = "jest_test")

def jest_test(name, srcs, deps, jest_config = None, **kwargs):
    "A macro around the autogeneratd jest_test rule"
    if (jest_config == None):
        jest_config = "//:jest.config.js"

    templated_args = [
        "--no-cache",
        "--no-watchman",
        "--ci",
        "--colors",
    ]

    templated_args.extend(["--config", "$(rootpath %s)" % jest_config])

    data = [jest_config] + srcs + deps + ["@npm//ts-jest"]

    _jest_test(
        name = name,
        data = data + [
            "//:tsconfig.json",
        ],
        templated_args = templated_args,
        **kwargs
    )
