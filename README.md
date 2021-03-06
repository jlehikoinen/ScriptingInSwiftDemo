# Scripting in Swift Demo

"Scripting in Swift" demo for FinMacAdmin meetup 25.04.2019.

The demo script `DefaultMailApp.swift` can be used for setting up default email application (macOS Mail or MS Outlook). Try `DefaultMailAppOnlyUI.swift` if you only want test the UI.

## Requirements

* Xcode 9/10 or Xcode Command Line Tools installed

## Setup

Install Xcode or Xcode Command Line Tools.

> Tip: Install Xcode Command Line Tools by running `swift` in Terminal app.

Download or `git clone` this repo.

## Usage

Hello Cleveland example:

`$ ./Hello.swift`

Arguments example:

`$ ./Arguments.swift`

Empty window example:

`$ ./EmptyWindow.swift`

Popup button example:

`$ ./PopUpButton.swift`

GUI example (button functionality disabled):

`$ ./DefaultMailAppOnlyUI.swift`

Choose default email app example:

`$ ./DefaultMailApp.swift`

SwiftUI example (work in progress):

`$ ./SwiftUI-DefaultMailAppOnlyUI.swift`

## Default email app

![Demo app](DemoApp.png)

## Default email app configuration

`DefaultMailApp.swift` struct `DefaultApp` uses Launch Services API for changing default email application. See details below.

Apple documentation: https://developer.apple.com/documentation/coreservices/launch_services

macOS Mail Launch Services handlers:

```
com.apple.mail.email:   com.apple.mail
public.vcard:           com.apple.AddressBook
com.apple.ical.ics:     com.apple.CalendarFileHandler
```

MS Outlook Launch Services handlers:

```
com.apple.mail.email:                   com.microsoft.outlook
com.microsoft.outlook16.email-message:  com.microsoft.outlook
public.vcard:                           com.microsoft.outlook
com.apple.ical.ics:                     com.microsoft.outlook
com.microsoft.outlook16.icalendar:      com.microsoft.outlook
```

macOS Mail URL Scheme:

```
mailto: com.apple.mail
```

MS Outlook URL Scheme:

```
mailto: com.microsoft.outlook
```

## Wrapper script

Most of the macOS management tools execute scripts with `root` privileges. If you want to run scripts with management tool in current user context you can use the `script_wrapper.sh` script.

Replace `# >>> Add script contents here <<<` row in `script_wrapper.sh` script with Swift script and test:

`$ sudo path/to/script_wrapper.sh`

### Munki makepkginfo command example

```
$ makepkginfo --name SwiftScriptTest \
--displayname "Swift Script Test" \
--nopkg --pkgvers=1.0 \
--postinstall_script=script_wrapper.sh \
--OnDemand > swift_test.pkginfo
```

## Additional information

* GUI scripts are missing all the constraints related things
* Menu bar displays the active app name as "swift" in GUI scripts
* Scripts have been tested on 10.14 & 10.13
