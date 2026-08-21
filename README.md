# TimeStack

[![Flutter](https://img.shields.io/badge/Flutter-Dart%203.13%2B-blue?logo=flutter)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A stack of independant timers on a single screen ( for now ). Each card is either a stopwatch ( starts at 00:00:00 and counts up) or a pomodoro (starts from a set duration and counts down), the mode follows the duration, zero means stopwatch, anything else means countdown.

## Usage

|   Gesture    |    Action   |
|-------------|--------------|
|   **+** (FAB)    |    Add a timer |
|   play/pause button  |   Start/stop  |
|   reset button | reset to zero |
|   **Tap** on the card | Edit the label and duration |
| **long press** | Delete the timer |

In the edit leaving the the duration at **00:00:00** keeps or set the card as a stopwatch, setting duration turn it into a pomodoro.

## Run

```sh
flutter pub get
flutter run
```

Dart SDK '^3.13.0'.<br>
external dependency : 
[`wheel_picker`](https://pub.dev/packages/wheel_picker) for the hours/minutes/seconds wheels.


## Roadmap

- **v1** : working stopwatch and pomodoro, editing, deletion. Chronos are persisted.
- **v1.1** : move to [Riverpod](https://riverpod.dev): timer state moves out of the widgets into a store, which also fixes state being lost when the `listView` recycles a card.

## License

MIT License [LICENSE](LICENSE)