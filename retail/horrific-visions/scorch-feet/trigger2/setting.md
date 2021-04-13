### Trigger

* Type: `Aura`
* Unit: `Player`
* Aura Type: `Debuff`
* Exact Spells: `315385`, `313963`, `306275`, `306255`
* Show On: `Always`

### Conditions

#### Condition 1

* `If`
 * `Trigger 2`: `Auras Found` -> `True`
* `Then`:
 * `Color` -> `White`

#### Condition 2

* `If All of`:
 - `Trigger 1`: `Active` -> `false`
 - `And Trigger 2`: `Aura(s) found` -> `true`
* `Then`:
 * `1. Border``Color`
