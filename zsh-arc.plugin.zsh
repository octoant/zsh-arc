#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# This file is part of Arc Plugin for zsh, the Z-Shell.
#
# Copyright (c) 2023 Bobur Zakirov <bmzakirov@yantex-team.ru>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the “Software”), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ------------------------------------------------------------------------------

# Handle $0 according to the standard:
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

source "${0:A:h}/zsh-arc.zsh"

# Copy the function in order to override it
functions -c git_prompt_info git_prompt_info_original

# Override the function to support Arc, in addition to the Git
#
# No more than one version control prompt info can be displayed at a time
# The priority is the following: Git, Arc
git_prompt_info() {
  local prompt_info

  if [[ -z $prompt_info ]]; then
    prompt_info=$(git_prompt_info_original)
  fi
  if [[ -z $prompt_info ]]; then
    prompt_info=$(arc_prompt_info)
  fi

  echo "$prompt_info"
}
