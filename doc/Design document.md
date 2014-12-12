Native-App-Studio-iOS-Evil-Hangman
==================================
Design document
---------------
Rick Buchter <br>
10829911 <br>
Last update: 12-12-2014


## Goal 
The goal of the Evel Hangman Game is to dodge user's guess as best as possible. 
After every new guess switch to the most words. To maximize ability to cheat. 
	
## Classes and public methods 
The frist value inbetween brackets ('[...]') is the return type of the method and the second value says if it is a public of private method.

### Classes
#### GameViewController (start)
***
##### FUNCTIONS
- **viewDidLoad**, checks if basic values of UserDefaults are set. If not the values of 'numberOfLetters' and 'numberOfIncorrectGuesses' are set and newGame function is called. In al other situations the last game will be loaded.[void] [private]
- **newGame**, function to start a new game with the last inputed settings. [action] [private]
- **touchesBegan**, removes keyboard if touched outside keyboard. [void] [private]
- **textFieldShouldReturn**, removes keyboard and process input of user when return is pressed. Calls main game functions. [BOOL] [private]
- **inputAlerts**, handels all input alerts based on results of inputSizeCheck, inputFormatCheck and inputLettersArrayCheck functions. [void] [private]
- **winAlerts**, handels win alert, based on result of winCheck function. [void] [private]
- **loseAlerts**, handles lose alert based on result of loseCheck function. [void] [private]
- **alertView**, add call to new game function to second button of alert views[void] [private]
- **updateLabels**, updates all labels. [void] [private]

##### OUTLETS
- **livesStateLabel**, reference to the label with the amount of lives left.
- **guessStateLabel**, reference to the label with the current state of the game.
- **guessedLettersStateLabel**, reference to the label with the letters already guessed by the user.
- **letterInput**, reference to the input field where the last letter will be displayed.


#### SettingsViewController
***
##### FUNCTIONS
- **viewDidLoad**, checks the values of UserDefaults and update the corrosponding labels and sliders. [void] [private]
- **sliderNumberOfLettersChanged**, action called when slider is moved, will update UserDefaults. [action] [private]
- **sliderNumberOfIncorrectGuessesChanged**, action called when slider is moved, will update UserDefaults. [action] [private]

##### OUTLETS
- **sliderNumerOfLettersLabel**, reference to the label with the amount of letters to guess.
- **sliderNumberOfIncorrectGuessesLabel**, reference to the label with the amount of incorrect guess before losing.
- **sliderNumberOfLetters**, reference to the slider with the amount of letters to guess. 
- **sliderNumberOfIncorrectGuesses**, reference to the slider with the amount of incorrect guess before losing.


#### GameEngineController
***
##### GAME FUNCTIONS
- **mainGame**, function called on every new input of the user. Removes input form letters. Generate dictionary based on the input. Search for the main item in the dictionary. Updates word list and the word displayed to the user. [void] [public] 
- **newGame**, sets all UserDefaults to start a new game based on the last input on the settingsview. [void] [public]
- **initUserDefaults**, initalise UserDefaults object. [void] [public]
- **winCheck**, checks if user has won game. [BOOL] [public]
- **loseCheck**, check if user has lose the game. [BOOL] [public]

##### INPUT CHECK FUNCTIONS 
- **inputSizeCheck**, checks if input is the right size of 1 character. [BOOL] [public]
- **inputFormatCheck**, checks if input only contains alphabetical characters (A-Z). [BOOL] [public]
- **inputLettersArrayCheck**, checks if input is in array 'currentLettersState' in UserDefaults. [BOOL] [public] 

##### DICTIONARY FUNCTIONS
- **wordsListLoad**, loads words.plist into array and extract array with words of right size. [void] [private]
- **keyWordDictionary**, loops through characters of word and creates key for word, based on input. Example '_A_A_'. [string] [private]
- **wordDictionary**, function generating dictionary with keys based on input and values as word arrays. [dictionary] [private]
- **mainWordDictionary**, search for biggest opbject in dictionary. [string] [private]

##### LETTERS FUNCTIONS
- **newLetterArray**, sets 'currentLettersState' to value of array with characters A-Z in UserDefauls. [void] [private]
- **newLetterString**, creates string of array of 'currentLettersState' in UserDefaults. [string] [public]
- **lettersUpdate**, updates 'currentLettersState' in UserDefaults by removing guessed letter form array. [void] [private]

##### WORD FUNCTIONS
- **newWordArray**, sets 'currentWordState' to array with placeholders '_' for the letters to be guessed, based on 'numberOfLetters' in UserDefaults. [void] [private]
- **newWordString**, creates string of array 'currentWordState' in UserDefaults. [string] [public]
- **wordUpdate**, updates 'currentWordState' in UserDefaults based on the largest key in dictionary. [void] [private]

##### LIVES FUNCTIONS 
- **newLivesInteger**, sets 'currentLives' to value of 'numberOfIncorrectGuesses' in UserDefauls. [void] [private]
- **newLivesString**, creates string of 'currentLives' in UserDefaults. [string] [public]
- **livesUpdate**, updates 'currentLives' in UserDefaults with lives decreased by 1. [void] [private]


#### NSUserDefauts 
***
- **numberOfLetters** [integer], on start app does it have a value of 5.
- **numberOfIncorrectGuesses** [integer], on start app does it have a value of 7.
- **currentWordState** [object], array with characters holding the guess state of the current game.
- **currentLives** [integer], holding the lives state of the current game.
- **currentLettersState** [object], array with letters holding the guessed letters state of the current game. 
- **currentWordArray** [object], array with words currenlty used in the game. 


## Sketches 
![alt text][id]

[id]: 20141114UXopzet.jpeg "14-11-2014 UX opzet"

On the setting-screen both the 'number of letters' and 'number of incorrect guesses' will be sliders with a corresponding label 


## API's and frameworks
No needed, using the basics of the Object-C framework.

## Database tabels and fields
The words.plist part of the Evil-Hangman assignment. After the settings are changed there will be created a sub words list with ony the words with the right length. 
