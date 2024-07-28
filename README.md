## DynamicNetSim

`DynamicNetSim` is an R package designed for simulating dynamic networks and game-theoretic interactions. This package provides a set of tools that facilitate the creation, manipulation, and visualization of dynamic networks, as well as the simulation of game-theoretic scenarios within these networks.

## Dependencies

DynamicNetSim imports the following R packages:
- igraph
- stats

Make sure these packages are installed and up to date.

## Functions
DynamicNetSim includes the following main functions:

- `gen_dynamic(N, L, aver_k, net_type, game_type, visualize)`: Generates a dynamic network and simulates game-theoretic interactions.

## Usage

Here is a detailed example of how to use DynamicNetSim:

```r
# Load DynamicNetSim package
library(DynamicNetSim)

# Set parameters
N <- 100              # Number of nodes
L <- 10               # Number of iterations
aver_k <- 6           # Average degree
net_type <- "BA"      # Network type ("BA", "ER", "SW")
game_type <- "PDG"    # Game type ("PDG", "SDG", "DG", "SUG", "CG", "SG", "EG", "SeqG", "RG", "ZZG", "NCG", "IIG")
visualize <- TRUE     # Whether to visualize the network

# Generate dynamic network and simulate game
results <- gen_dynamic(N, L, aver_k, net_type, game_type, visualize)

# Print results
print(results)

# View initial adjacency matrix
initial_adj <- results$initial_adj
print(initial_adj)

# View final adjacency matrix
final_adj <- results$final_adj
print(final_adj)

# View game results
game_results <- results$game_results
print(game_results)

# View strategies
strategies <- results$strategies
print(strategies)

```
