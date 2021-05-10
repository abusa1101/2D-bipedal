# 2D-bipedal
Simulate animation of 2D bipedal robot walking

1. Extract ZIP into any directory and "cd" into the extracted directory.

2. Type "pop" and then select an option for controlling the 2D walker. Once you select this option, pop will create several variables in the Matlab global workspace. This process first defines book-keeping variables (modeldir and wd), after which model-specific variables are found in the modeldir (e.g., /pointfoot-midlegmass/passive). These variables must exist and be defined inside the global workspace for the simulation to work.

3. Type "walk2(xi, 10)" and the simulation will return the last state after 10 steps. Note that the state vector for this model is a Matlab array defined as follows: ["stance angle" "swing angle" "stance angular velocity" "swing angular velocity"].

4. Now enter "walk2([1 1 1 1], 10)". The simulation will complain that the robot walker did not make contact with the ground within the default ode45 integration time; your initial condition [1 1 1 1] does not lead to a stable limit cycle and the simulation aborts.

5. Now type "walk2(xi, 10, 1)" and study the graphs that appear.

6. "walk2(xi, 10, 2)" will produce an animation of the bipedal walking.

7. Type "help walk2" for a detailed summary of operational instructions, including movie recording options.

8. Type "opp" to clear the global workspace and start over.
