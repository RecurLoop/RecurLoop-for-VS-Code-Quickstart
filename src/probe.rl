// Used by both the application and the RecurLoop project terminal.
let Probe = phrase { dictionary = true permanent = true }

let Probe:advance = fn (distance:i64, speed:i64) -> i64 {
    return distance + speed
}
