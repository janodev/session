![Swift](https://github.com/janodev/session/workflows/Swift/badge.svg?branch=master)

A Session protocol that mimics URLSession, so we can stub responses. See [why](https://github.com/janodev/session/wiki), [how](https://github.com/janodev/session/wiki#usage-example). 

Example: go from
```swift
let client = YourAPIClient(session: URLSession.shared)
client.people(page: 0, pageSize: 10) { result in ... }
```
to
```swift
let sessionStub = JSONSessionStub.success(data: "{...10 users...}".data(using: .utf8), url: someURL)
let client = YourAPIClient(session: sessionStub)
client.people(page: 0, pageSize: 10) { result in ... }
```
