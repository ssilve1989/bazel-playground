"""ts_library macro that includes eslint testing"""

# load("@npm//eslint:index.bzl", "eslint_test")
load("@npm//@bazel/typescript:index.bzl", _ts_project = "ts_project")

ESLINT_DATA = [
  "//:.eslintrc.js",
  "//:.eslintignore",
  "//:tsconfig.json",
  "@npm//@typescript-eslint/eslint-plugin",
  "@npm//@typescript-eslint/parser",
  "@npm//eslint-config-prettier"
]

def ts_project(name, **kwargs):
    """ts_project macro wrapper. provides sensible defaults to ts_project

    Args:
        name: target name
        **kwargs: passthrough args
    """

    srcs = kwargs.pop("srcs")
    deps = kwargs.pop("deps", [])
    tsconfig = kwargs.pop("tsconfig", "//:tsconfig.json")

    _ts_project(
        name = name,
        srcs = srcs,
        deps = deps,
        tsconfig = tsconfig,
        **kwargs
    )

    # TODO: Get eslint working
    # eslint_test(
    #     name = "eslint",
    #     args = [
    #       "--quiet"
    #     ] + srcs,
    #     data = ESLINT_DATA + deps + [":" + name]
    # )
