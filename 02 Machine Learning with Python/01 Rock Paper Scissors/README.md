### Rock Paper Scissors

In the file `RPS.py` you are provided with a function called `player`. The function takes an argument that is a string describing the last move of the opponent ("R", "P", or "S"). The function should return a string representing the next move for it to play ("R", "P", or "S").

A player function will receive an empty string as an argument for the first game in a match since there is no previous play.

The file `RPS.py` shows an example function that you will need to update. The example function is defined with two arguments (`player(prev_play, opponent_history = [])`). The function is never called with a second argument so that one is completely optional. The reason why the example function contains a second argument (`opponent_history = []`) is because that is the only way to save state between consecutive calls of the `player` function. You only need the `opponent_history` argument if you want to keep track of the opponent_history.

*Hint: To defeat all four opponents, your program may need to have multiple strategies that change depending on the plays of the opponent.*

Full instructions [here](https://www.freecodecamp.org/learn/machine-learning-with-python/machine-learning-with-python-projects/rock-paper-scissors).

---

### Solution outline

The solution implement a Python code for the Rock-Paper-Scissors game, employing the Q-learning algorithm. The Q-learning algorithm is a technique of Reinforcement Learning, which acquires an optimal strategy for an agent (AI) by approximating the expected rewards associated with every state-action combination. This technique is different than many of the other machine learning techniques because, rather than feeding our machine learning model with millions of examples, we let our model come up with its own examples by exploring an environment. The concept is simple: humans learn by exploring and learning from mistakes and past experiences, so let's have our algorithm do the same.

This algorithm is based on updating a table, called Q-Table or Q-Matrix, in which it can measure the amount of reward that it will get for a certain action in a certain state. The matrix is in shape (*number of possible states*, *number of possible actions*) where each value at matrix $[n_i, m_j]$ represents the agents expected reward given they are in state **$n_i$** and take action $m_j$. The Q-learning algorithm defines the way we update the values in the matrix and decide what action to take at each state. The idea is that after a succesful training/learning of this Q-Table/matrix we can determine the action an agent should take in any state by looking at that states row in the matrix and taking the maximium value column as the action [1].

Q-larning can also be viewed as a method of asynchronous dynamic programming. The formula for updating the Q-Table after each action is as follows:

$ Q(S_t, A_t) \leftarrow Q(S_t, A_t) + \alpha * (R_t + \gamma * \max_{a} Q(S_{t+1}, a) - Q(S_t, A_t) $,

where:

- $S_t$: state at step $t$
- $S_{t+1}$: state at step $t+1$
- $A_t$: action at sept $t$
- $\alpha$: learning rate
- $R_t$: reward at step $t$
- $\gamma$: discount factor

In this case, the Q-Table takes the form:

|            | Action 1 | Action 2 | Action 3 |
| ---------- |:--------:|:--------:|:--------:|
| **State**  | **R**    | **P**    | **S**    |
| **(R, R)** | ...      | ...      | ...      |
| **(R, P)** | ...      | ...      | ...      |
| **(R, S)** | ...      | ...      | ...      |
| **(P, R)** | ...      | ...      | ...      |
| **(P, P)** | ...      | ...      | ...      |
| **(P, S)** | ...      | ...      | ...      |
| **(S, R)** | ...      | ...      | ...      |
| **(S, P)** | ...      | ...      | ...      |
| **(S, S)** | ...      | ...      | ...      |

The Q-learning algorithm is shown below in procedural form [2]:

> Algorithm parameters: $\alpha \in (0, 1], \gamma \in [0, 1]$
> 
> -  Initialize $Q(S, A)$ arbitrarily
> 
> - Repeat (for each episode):
>   
>   - Initialize $S$
>   
>   - Repeat (for each step of episode):
>     
>     - Choose $A$ from $S$ using policy derived from $Q$
>     
>     - Take action $A$, observe $R$, $S'$
>     
>     - $Q(S, A) \leftarrow Q(S, A) + \alpha * (R + \gamma * \max_{a} Q(S', a) - Q(S, A)$
>     
>     - $S \leftarrow S'$
>   
>   - until $S$ is terminal



##### References

[1] FreeCodeCamp course notes.

[2] Sutton, R. S., Barto, A. G.:Reinforcement Learning: An Introduction, Cambridge, MA: MIT Press (1998).
