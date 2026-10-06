// Load definitions; run the application only when a target is requested.
include "src/main.rl"
let "Probe:main()" = phrase {
    type = <phrase-types:elaborate>
    action = fn (state:Context*, called:Phrase*) -> void {
        Probe:main()
    }
}
var i = 5
target check {
    assert Probe:advance(10, 0) == 10
    print "OK: a stationary probe keeps its distance."
}

target prepare {
    mkdir -p .cache/recurloop
}

// Run and Debug share one executable built with source debugging enabled.
target build depends [prepare, check] {
    emit executable debug ".cache/recurloop/probe" probe_main = fn () -> i64 {
        return Probe:main()
    }
}

target run depends [build] {
    ./.cache/recurloop/probe
}

target debug depends [build] debug executable ".cache/recurloop/probe" {
    ./.cache/recurloop/probe
}
