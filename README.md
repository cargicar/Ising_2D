# Ising_2D
Monte Carlo 2D Ising simulator NN and NNN model. 

For an in deep explanation of the Ising Model, you are invited and very welcome to visit my blog http://carlos-cardona.com , feel free to leave comments and 
corrections. I value the interaction with others. 

Here you can find the files correspoding to a simple simulator for a simplified Ising model in two dimensions. We have used a very well known Monte Carlo algorithm 
to sample the space of states and generate the simulation in a short time. 

The easiest way to use the files is by running the Jupyter notebook Simple_Ising_simulator.ipynb which contains the basic code, including the Fortran code 
and its compilation.  To run the notebook sucesfully you need python installed locally as well as fortran. Most OS distributions UNIX based come with a version 
of them two, but the installation is pretty straightforward either way. 

I have also include a file Ising_simulador_NNN.f90 that generilizes the simulator to a Next-to-Next-to-Next interactions model, as well as a function 
magnetization.f90 that simulates de magnetization as a function of the temperature, andtherefore allows to see the phase transitions quite transparently.


