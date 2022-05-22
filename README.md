# ESCAPE FROM THE CASTLE
This is a game design in ``bash`` where you try to escape from a castle. Is a random values based game, it means that every value is randomly setted.

The rules are simple, you need to run throught the castle that have a random number of steps necesary to escape. In your way to freedom, you may encounter a set of monsters that would try to kill you.

You can choose between 3 types of characters:
- **The barbarian**: He has 4 dices of defense and life, and 2 dices of attack. Is the tank of the game.
- **The assassin**: He has 2 dices of defense and life, and 3 dices of attack. Is the DPS of the game.
- **The pariah**: He is the hardcore character. He has 1 dice of defense, life and attack, which it means you will need luck to win the game.

When you select your character, the life is randomly set depending on the number of life's dices your character have. Every time you walk throught the castle, you walk a random number of steps between 2 and 12. When you end moving, there is a 33% chance of fighting a monster.

There are 3 types of monsters:
- **The skeleton**: Is the easiest monster of the game. It has 1 dice of defense and attack.
- **The goblin**: It has 2 dices of defense and 1 of attack.
- **The troll**: It has 2 dices of defense and 3 dices of attack.

Every monster you encounter will have only 1 point of life, which means that you only need to hit them only once.

When you are ready to go out of the castle, there is a 50% chance of find the boss of the castle, that is **SHREK**.
**SHREK** is the final monster of the castle and the most difficult one. It has 4 dices of defense and attack. He only can appear on the last turn.

When you entered in a combat, you can attack or deffend. On your first defense move, you got an extra defense's dice.
Then the monster will try to attack you. If its attack is greater than your defense, you will get damage. Else you will avoid it.

It works the same if you select to attack, if your attack is greater than the monster's defense, you will kill the monster. Else if the monster's defense is greater than your attack