# options_ev

```
ruby runner.rb
```
```
args = {credit: 0.1, strike: 2, stance: :short}
```
```
p = Put.new args
```
```
args = {credit: 0.05, strike: 1, stance: :long}
```
```
p2 = Put.new args
```
```
pos = CompositePosition.new(positions: [p, p2])
```
```
args= {spot: 3, sd: 0.5, position: pos}
```
```
calc = Calculator.new args
```
```
calc.expected_value
```
