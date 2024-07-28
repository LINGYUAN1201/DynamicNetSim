## DynamicNetSim

`DynamicNetSim` is an R package designed for simulating dynamic networks and game-theoretic interactions. This package provides a set of tools that facilitate the creation, manipulation, and visualization of dynamic networks, as well as the simulation of game-theoretic scenarios within these networks.

## Dependencies

DynamicNetSim imports the following R packages:
- igraph
- stats

Make sure these packages are installed and up to date.

## Functions
DynamicNetSim includes the following main functions:

- `generate_network(nodes, p)`: Generates a random network with a specified number of nodes and probability of edge creation.

- `initialize_payoff_matrix(type, size)`: Initializes the payoff matrix for game-theoretic interactions.

- `initialize_strategies(network, strategies)`: Assigns initial strategies to nodes in the network.

- `validate_parameters(network, payoff_matrix, strategies)`: Validates the parameters to ensure they are compatible.

- `simulate_games(network, payoff_matrix, strategies, iterations)`: Simulates a series of game-theoretic interactions over a specified number of iterations.

- `visualize_network(network, strategies)`: Visualizes the network and the strategies of the nodes.
