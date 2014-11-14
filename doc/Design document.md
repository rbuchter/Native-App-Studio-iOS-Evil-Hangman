Native-App-Studio-iOS-Evil-Hangman
==================================
Design document
---------------
Rick Buchter <br>
10829911 <br>
Last update: 14-11-2014


## Classes and public methods 
### Actions 
- newGame, action to start a new game with the last inputed settings. <br>
- changeSettings, action to go the settings screen. <br>
- returnToGame, action to return to the current game and save changed settings for next game. <br>

### Outlets
- livesLeft, reference to the label with the amount of lives left. <br>
- guessState, reference to the label with the current state of the game. <br>
- guessedLetters, reference to the label with the letters already guessed by the user. <br>
- letterInput, reference to the input field where the last letter will be displayed. <br>
- incorrentGuesses, reference to the label that displays the current state of the slider. 

## Sketches 
![alt text][id]

[id]: 20141114UXopzet.jpeg "14-11-2014 UX opzet"


## API's and frameworks
No needed I think 

## Database tabels and fields
The words.plist part of the Evil-Hangman assigment. After the settings are changed there will be created a sub words list with ony the words with the right length. 



