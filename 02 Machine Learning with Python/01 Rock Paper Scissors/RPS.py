# The example function below keeps track of the opponent's history and plays whatever the opponent played two plays ago. It is not a very good player so you will need to change the code to pass the challenge.

# --------------------------------------
# def player(prev_play, opponent_history=[]):
#     opponent_history.append(prev_play)

#     guess = "R"
#     if len(opponent_history) > 2:
#       guess = opponent_history[-2]

#     return guess

# --------------------------------------
# Defeat quincy 100%
# def player(prev_play, counter=[0]):

#     counter[0] += 1
#     choices = ["P", "P", "S", "S", "R"]
#     return choices[counter[0] % len(choices)]

# Defeat kris 100%
# def player(prev_opponent_play, opponent_history=[]):

#     if prev_opponent_play == '':
#         prev_opponent_play = "R"
#     ideal_response = {'P': 'R', 'R': 'S', 'S': 'P'}
#     guess = ideal_response[prev_opponent_play]
#     return guess

# --------------------------------------
# Defeat mrugesh 50%
# def player(prev_opponent_play, opponent_history=[]):
#     opponent_history.append(prev_opponent_play)
#     last_ten = opponent_history[-10:]
#     most_frequent = max(set(last_ten), key=last_ten.count)

#     if most_frequent == '':
#         most_frequent = "R"

#     ideal_response = {'P': 'S', 'R': 'P', 'S': 'R'}
#     return ideal_response[most_frequent]

# --------------------------------------
# Final version - Reinforcement learning
import numpy as np

# Def some functions
def determine_reward(you, opponent): # 1: win; 0: tie; -1: loss
  winning_situations = [['R','S'],['S','P'],['P','R']]
  if [you, opponent] in winning_situations:
      return 1
  elif you == opponent:
      return 0
  else:
      return -1

def num_to_sym(num_action):
  if num_action == 0:
    return 'R'
  elif num_action == 1:
    return 'P'
  else:
    return 'S'

def sym_to_num(sym_action):
  if sym_action == 'R':
    return 0
  elif sym_action == 'P':
    return 1
  elif sym_action == 'S':
    return 2

# Initialize variables (within each episode)
STATES = {('R', 'R'): 0,
          ('R', 'P'): 1,
          ('R', 'S'): 2,
          ('P', 'R'): 3,
          ('P', 'P'): 4,
          ('P', 'S'): 5,
          ('S', 'R'): 6,
          ('S', 'P'): 7,
          ('S', 'S'): 8}

Q = np.zeros((9, 3))
alpha = 0.25
gamma = 0.3
S = 0
n = 1 # steps for episode (each game is considered one episode)

# Q-Learning
def player(prev_opponent_play, opponent_history=[]):

  global STATES
  global Q
  global alpha
  global gamma
  global S
  global A

  opponent_history.append(prev_opponent_play)

  if prev_opponent_play == '':
    A = 'P'
    return A
  else:
    for _ in range(n):
      R = determine_reward(A, prev_opponent_play)
      Sn = STATES[(A, prev_opponent_play)] # S_{t+1}
      a = int(Q[Sn,:].argmax())
      A_idx = sym_to_num(A)
      
      Q[S, A_idx] = Q[S, A_idx] + alpha*(R + gamma*Q[Sn, a] - Q[S, A_idx])
    
      A = num_to_sym(int(Q[Sn,:].argmax()))
      S = Sn
    return A
