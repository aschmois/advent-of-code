
var fs = require('fs')

function compare(a, b) {
    return (a > b) - (a < b)
}

async function main() {
    const contents = fs.readFileSync('input.txt', 'utf8').split('\n')
    const states = []
    for (let i = 0; i < contents.length; i++) {
        const line = contents[i].replace('[', '')
        const words = line.split(']')
        const date = new Date(words[0])
        const action = words[1].substring(1)
        states.push({ date, action })
    }
    states.sort((a, b) => compare(a.date, b.date))
    let currentGuard = null
    let lastFellAsleep = null
    const dates = {} // {'minutes': {'guardId': int}}
    // const guards = {} // {'guardId': int}
    for (let i = 0; i < states.length; i++) {
        const state = states[i]
        if (state.action.indexOf('#') > -1) {
            currentGuard = state.action.split(' ')[1].replace('#', '')
        } else {
            switch (state.action) {
                case 'falls asleep':
                    lastFellAsleep = state.date
                    break
                case 'wakes up':
                    // const existingTime = guards[currentGuard] || 0
                    // guards[currentGuard] = existingTime + ((state.date - lastFellAsleep) / 60 / 1000)
                    for (let x = lastFellAsleep.getMinutes(); x < state.date.getMinutes(); x++) {
                        const existingDates = dates[x + ''] || {}
                        const existingGuardDates = existingDates[currentGuard] || 0
                        existingDates[currentGuard] = existingGuardDates + 1
                        dates[x + ''] = existingDates
                    }
                    break
            }
        }
    }
    // const lazyGuard = Object.keys(guards).reduce((prev, curr) => {
    //     const guardId = curr
    //     const minutesAsleep = guards[guardId]
    //     if (!prev.asleep || prev.asleep < minutesAsleep) {
    //         return { asleep: minutesAsleep, guardId: guardId }
    //     } else {
    //         return prev
    //     }
    // }, {})
    // console.log('lazy guard:', lazyGuard)
    const minute = Object.keys(dates).reduce((prev, curr) => {
        const guardIds = Object.keys(dates[curr])
        const dateCurr = guardIds.reduce((prev1, guardId) => {
            const numberOfTimesAsleep = dates[curr][guardId]
            console.log('guard:', guardId)
            console.log('numberOfTimesAsleep:', numberOfTimesAsleep)
            console.log('curr:', curr)
            if (!prev1.asleep || prev1.asleep < numberOfTimesAsleep) {
                return { asleep: numberOfTimesAsleep, minute: curr, guardId }
            } else {
                return prev1
            }
        })
        if (!prev.asleep || prev.asleep < dateCurr.minute) {
            return dateCurr
        } else {
            return prev
        }
    }, {})
    console.log('lazy guard minute:', minute)
    console.log(parseInt(minute.guardId) * parseInt(minute.minute))
}

main()