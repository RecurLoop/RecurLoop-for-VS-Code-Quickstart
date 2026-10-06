include "probe.rl"

link shared "c"
extern printf(format:u8*, ...) -> i64 abi sysv-amd64

let Probe:main = fn () -> i64 {
    var distance:i64 = 0
    var tick:i64 = 1
    while tick <= 3 {
        distance = Probe:advance(distance, 10)
        printf("Tick %lld: %lld km\n", tick, distance)
        tick += 1
    }
    return 0
}

let abecadki = fn () -> i64 {
    printf("aaa bbb ccc\n")
    return 0
}
