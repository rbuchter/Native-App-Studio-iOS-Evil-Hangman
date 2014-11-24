Native-App-Studio-iOS-Evil-Hangman
==================================
Design document
---------------
Rick Buchter <br>
10829911 <br>
Last update: 17-11-2014


## Goal 
The goal of the Evel Hangman Game is to dodge user's guess as best as possible. 
After every new guess switch to the most words. To maximize ability to cheat. 
	
## Classes and public methods 

### Classes
#### GameViewController
- newGame, function to start a new game with the last inputed settings. DONE
- <del>switchToSettings, action to go the settings screen.</del>
- <del>newGameButonPressed, action to start a new game.</del>
- livesStateLabel, reference to the label with the amount of lives left. DONE
- guessStateLabel, reference to the label with the current state of the game. DONE
- guessedLettersStateLabel, reference to the label with the letters already guessed by the user. DONE
- letterInput, reference to the input field where the last letter will be displayed.

#### SettingsViewController
- switchToGame, action to return to the current game and save changed settings for next game. 
- saveSetting, function to save updated data of settings
- lettersGuesses, reference to the label that displays the current state of the slider
- incorrentGuesses, reference to the label that displays the current state of the slider. 

#### GameEngineController
- updateAmountOfGuesses, function update amount of guesses after last guess.
- updateWordList, update word list after new guess
- updateGuesses, update het label with the guessed letters. 

#### NSUserDefauts 
- numberOfLetters [integer], on start app does it have a value of 5. DONE
- numberOfIncorrectGuesses [integer], on start app does it have a value of 7. DONE
- currentGuessState [object], holding the guess state of the current game. DONE
- currentLivesState [integer], holding the lives stte of the current game. DONE
- currentGuessedLettersState [object], holding the guessed letters state of the current game. DONE


## Sketches 
![alt text][id]

[id]: 20141114UXopzet.jpeg "14-11-2014 UX opzet"

On the setting-screen both the 'number of letters' and 'number of incorrect guesses' will be sliders with a corresponding label 


## API's and frameworks
No needed, using the basics of the Object-C framework.

## Database tabels and fields
The words.plist part of the Evil-Hangman assignment. After the settings are changed there will be created a sub words list with ony the words with the right length. 