# hubot-stackoverflow-search

Search on Stack Overflow via Hubot.

See [`src/stackoverflow-search.coffee`](src/stackoverflow-search.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-stackoverflow-search --save`

Then add **hubot-stackoverflow-search** to your `external-scripts.json`:

```json
[
  "hubot-stackoverflow-search"
]
```

## Configuration

You need to set the `HUBOT_STACK_OVERFLOW_API_KEY` environment variable which can be obtained from http://stackapps.com/apps/oauth/register

## Sample Interaction

```
user1>> hubot so me test
hubot>> Here are the top 3 results for "test" on Stack Overflow:

1. How to test a class that has private methods, fields or inner classes:
http://stackoverflow.com/questions/34571/how-to-test-a-class-that-has-private-methods-fields-or-inner-classes

2. JavaScript unit test tools for TDD:
http://stackoverflow.com/questions/300855/javascript-unit-test-tools-for-tdd

3. What is Unit test, Integration Test, Smoke test, Regression Test?:
http://stackoverflow.com/questions/520064/what-is-unit-test-integration-test-smoke-test-regression-test
```
