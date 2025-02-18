# Copyright 2024 dterazhao, Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

def algo_deps():
    _rules_cc()
    _build_bazel_apple_support()
    _libtommath()
    _heu()
    _spu()
    _gmp()

def _rules_cc():
    maybe(
        http_archive,
        name = "rules_cc",
        sha256 = "906e89286acc67c20819c3c88b3283de0d5868afda33635d70acae0de9777bb7",
        strip_prefix = "rules_cc-0.0.14",
        url = "https://github.com/bazelbuild/rules_cc/releases/download/0.0.14/rules_cc-0.0.14.tar.gz",
    )

def _build_bazel_apple_support():
    maybe(
        http_archive,
        name = "build_bazel_apple_support",
        sha256 = "b53f6491e742549f13866628ddffcc75d1f3b2d6987dc4f14a16b242113c890b",
        url = "https://github.com/bazelbuild/apple_support/releases/download/1.17.1/apple_support.1.17.1.tar.gz",
    )

def _libtommath():
    maybe(
        http_archive,
        name = "libtommath",
        sha256 = "7cfbdb64431129de4257e7d3349200fdbd4f229b470ff3417b30d0f39beed41f",
        type = "tar.gz",
        strip_prefix = "libtommath-42b3fb07e7d504f61a04c7fca12e996d76a25251",
        patch_args = ["-p1"],
        patches = [
            "//bazel:patches/libtommath.patch",
        ],
        urls = [
            "https://github.com/libtom/libtommath/archive/42b3fb07e7d504f61a04c7fca12e996d76a25251.tar.gz",
        ],
    )

def _heu():
    git_repository(
        name = "com_dtera_heu",
        commit = "f6e6e4110414d947f23c984fe9194d91f13b1573",
        remote = "https://github.com/dtera/heu.git",
    )

def _spu():
    maybe(
        http_archive,
        name = "spu",
        urls = [
            "https://github.com/secretflow/spu/archive/refs/tags/0.9.2b0.tar.gz",
        ],
        strip_prefix = "spu-0.9.2b0",
        sha256 = "50ec6132b86d8b20ccf55fe75412b8ecd3a00dd9475783605f2f8de12afa896f",
    )

def _gmp():
    maybe(
        http_archive,
        name = "gmp",
        build_file = "//bazel/third_party:gmp.BUILD",
        #url = "https://gmplib.org/download/gmp/gmp-6.3.0.tar.xz",
        url = "https://github.com/dtera/algorithm/raw/refs/heads/master/bazel/third_party/src/gmp-6.3.0.tar.xz",
        strip_prefix = "gmp-6.3.0",
        type = "tar.xz",
        sha256 = "a3c2b80201b89e68616f4ad30bc66aee4927c3ce50e33929ca819d5c43538898",
    )
