# mastermind
Mastermind Game based on the Swaszek algorithm

## How play
Play on repl.it

[![](https://repl.it/badge/github/gabrielsenaco/mastermind)](https://repl.it/@gabrielsenaco/mastermind)
## Tutorial
This game is played by two players: a codemaker and a codebreaker.
- The codemaker's goal is to make a secret color combination
- The goal of the codebreaker is to try to decipher the colors that the codemaker made.

### Valid colors
- The permitted colors are:
| Initials | Real name |
|----------|-----------|
| R        | Red       |
| G        | Green     |
| B        | Blue      |
| O        | Orange    |
| C        | Cyan      |
| M        | Magenta   |


### Starting the game

To play, the codemaker starts by saying 4 colors, example:
> ROMG

Soon after, the codebreaker will try to guess the colors. He will have 12 chances to find out.
When choosing the 4 colors he thinks he is, he shows feedback in the right corner. In the feedback you will have:
- white ball  - it represents that you got the color right, but it is in the wrong position.
- whitespaces - represents that you missed the color, there is no color.
- gray ball   - represents that you got the color and position right.


