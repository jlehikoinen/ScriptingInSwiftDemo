# Swift Script GUI App Demo

"Scripting in Swift" demo for FinMacAdmin meetup 25.04.2019.

Note that scripts are missing all the constraints related things.

## Requirements

* Xcode 9/10 or Xcode Command Line Tools installed

## Setup

Install Xcode or Xcode Command Line Tools.

Install Xcode Command Line Tools by running `swift` in Terminal app.

## Wrapper script

`script_wrapper.sh` can be used for running Swift GUI scripts in current user context e.g. with Jamf Pro or Munki. Most of the management tools execute scripts with `root` privileges hence the wrapper script.

Replace `# >>> Add script contents here <<<` with Swift script and test:

`$ sudo path/to/script_wrapper.sh`