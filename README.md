# Swift Script GUI App Demo

"Scripting in Swift" demo for FinMacAdmin meetup 25.04.2019.

The demo script `CompleteScript.swift` can be used for setting up default email application (macOS Mail or MS Outlook).

_Note that scripts are missing all the constraints related things._

## Requirements

* Xcode 9/10 or Xcode Command Line Tools installed

## Setup

Install Xcode or Xcode Command Line Tools.

Install Xcode Command Line Tools by running `swift` in Terminal app.

Clone this repo.

## Usage

Empty window example:

`$ ./EmptyWindow.swift`

GUI example (button functionality disabled):

`$ ./UIScript.swift`

Choose default email app example:

`$ ./CompleteScript.swift`

## Default email app configuration

https://developer.apple.com/documentation/coreservices/launch_services

MS Outlook Launch Services handlers:

```
com.apple.mail.email:                   com.microsoft.outlook
com.microsoft.outlook16.email-message:  com.microsoft.outlook
public.vcard:                           com.microsoft.outlook
com.apple.ical.ics:                     com.microsoft.outlook
com.microsoft.outlook16.icalendar:      com.microsoft.outlook
```

macOS Mail Launch Services handlers:

```
com.apple.mail.email:   com.apple.mail
public.vcard:           com.apple.AddressBook
com.apple.ical.ics:     com.apple.CalendarFileHandler
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

`script_wrapper.sh` can be used for running Swift GUI scripts in current user context e.g. with Jamf Pro or Munki. Most of the management tools execute scripts with `root` privileges hence the wrapper script.

Replace `# >>> Add script contents here <<<` with Swift script and test:

`$ sudo path/to/script_wrapper.sh`