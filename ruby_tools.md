# Ruby Installation

"Ruby installation" refers to how the Ruby programming language ends up on your development environment. 
The *"development environment"* can refer to either the machine you're working on or the cloud-based environment you're working on, like cloud9.

MacOS usually comes with Ruby already on it. 
You can check what version of Ruby is installed on your Mac machine using the terminal command: 
`/usr/bin/ruby -v`

This is usually not optimal though, as the version of Ruby installed with MacOS is probably outdated. On top of this, the Ruby that is on your Mac needs root access to make any modifications to other Ruby components you may have installed. Ideally developers want to avoid directly logging in as root user, and sometimes developers don't have access to root user privelages which can make this hard to use.

# Terminology

"**DSL (Domain Specific Language)**"
> Is a language that is designed to be used and fit a specific need. It isn't a **General Programming Language** *(like Ruby, JavaScript, Python, etc...)* because it can't be used in a wider more broad sense. This is language designed specifically for a certain task or problem.

# MiniTest

This is the standard testing software for Ruby. 

There is also RSpec, but Minitest is Ruby's standard testing library.

To install MiniTest run the command: `gem install minitest`

To check what version you have run command: `gem list minitest`

To install a specific version of minitest run: `gem install minitest -v <version number>`

