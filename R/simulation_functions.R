#' Generate dynamic network and simulate games
#'
#' @param N Number of nodes
#' @param L Number of iterations
#' @param aver_k Average degree
#' @param net_type Network type ("BA", "ER", "SW")
#' @param game_type Game type ("PDG", "SDG", "DG", "SUG", "CG", "SG", "EG", "SeqG", "RG", "ZZG", "NCG", "IIG")
#' @param visualize Logical, if TRUE, visualize the network
#' @return A list containing the initial adjacency matrix, final adjacency matrix, game results, and strategies
#' @export
#' @importFrom igraph sample_pa erdos.renyi.game sample_smallworld as_adjacency_matrix
gen_dynamic <- function(N, L, aver_k = 6, net_type = "BA", game_type = "PDG", visualize = FALSE) {
  validate_parameters(N, L, aver_k, net_type, game_type)
  G <- generate_network(N, aver_k, net_type)
  M <- initialize_payoff_matrix(game_type)
  S <- initialize_strategies(N, game_type)
  results <- simulate_games(G, N, L, game_type, M, S)
  if (visualize) {
    visualize_network(G, S)
  }
  return(results)
}

#' Validate input parameters
#' @param N Number of nodes
#' @param L Number of iterations
#' @param aver_k Average degree
#' @param net_type Network type ("BA", "ER", "SW")
#' @param game_type Game type ("PDG", "SDG", "DG", "SUG", "CG", "SG", "EG", "SeqG", "RG", "ZZG", "NCG", "IIG")
validate_parameters <- function(N, L, aver_k, net_type, game_type) {
  if (!is.numeric(N) || N <= 0) stop("N must be a positive numeric value.")
  if (!is.numeric(L) || L <= 0) stop("L must be a positive numeric value.")
  if (!is.numeric(aver_k) || aver_k <= 0) stop("aver_k must be a positive numeric value.")
  if (!(net_type %in% c("BA", "ER", "SW"))) stop("net_type must be one of 'BA', 'ER', or 'SW'.")
  if (!(game_type %in% c("PDG", "SDG", "DG", "SUG", "CG", "SG", "EG", "SeqG", "RG", "ZZG", "NCG", "IIG")))
    stop("game_type must be one of 'PDG', 'SDG', 'DG', 'SUG', 'CG', 'SG', 'EG', 'SeqG', 'RG', 'ZZG', 'NCG', 'IIG'.")
}

#' Generate network based on type
#' @param N Number of nodes
#' @param aver_k Average degree
#' @param net_type Network type ("BA", "ER", "SW")
#' @return An igraph network
#' @importFrom igraph sample_pa erdos.renyi.game sample_smallworld
generate_network <- function(N, aver_k, net_type) {
  switch(net_type,
         "BA" = igraph::sample_pa(N, power = 1, m = aver_k, directed = FALSE),
         "ER" = {
           p <- aver_k / (N - 1)
           igraph::erdos.renyi.game(n = N, p = p, type = "gnp", directed = FALSE)
         },
         "SW" = igraph::sample_smallworld(dim = 1, size = N, nei = aver_k / 2, p = 0.05)
  )
}

#' Initialize payoff matrix based on game type
#' @param game_type Game type ("PDG", "SDG", "DG", "SUG", "CG", "SG", "EG", "SeqG", "RG", "ZZG", "NCG", "IIG")
#' @return A payoff matrix
#' @importFrom stats runif
initialize_payoff_matrix <- function(game_type) {
  payoff_matrices <- list(
    PDG = matrix(c(1, 0, 1.2, 0), 2, 2, byrow = TRUE),
    SDG = matrix(c(1, 1 - 1.2, 1 + 1.2, 0), 2, 2, byrow = TRUE),
    DG = matrix(c(2 - 1, -1, 2, 0), 2, 2, byrow = TRUE),
    CG = matrix(c(2, 2, 2, 2), 2, 2, byrow = TRUE),
    SG = matrix(c(1, -1, 0, 1), 2, 2, byrow = TRUE),
    EG = matrix(c(3, 0, 5, 1), 2, 2, byrow = TRUE),
    SeqG = matrix(c(2, 1, 0, 1), 2, 2, byrow = TRUE),
    RG = matrix(c(1, -1, -1, 1), 2, 2, byrow = TRUE),
    ZZG = matrix(c(1, -1, -1, 1), 2, 2, byrow = TRUE),
    NCG = matrix(c(1, 0, 0, 1), 2, 2, byrow = TRUE),
    IIG = matrix(c(1, -1, -1, 1), 2, 2, byrow = TRUE)
  )
  if (game_type == "SUG") {
    return(matrix(runif(4), nrow = 2))
  } else {
    return(payoff_matrices[[game_type]])
  }
}

#' Initialize strategies based on game type
#' @param N Number of nodes
#' @param game_type Game type ("PDG", "SDG", "DG", "SUG", "CG", "SG", "EG", "SeqG", "RG", "ZZG", "NCG", "IIG")
#' @return A vector of strategies
#' @importFrom stats runif
initialize_strategies <- function(N, game_type) {
  if (game_type %in% c("PDG", "SDG", "DG", "CG", "SG", "EG", "SeqG", "RG", "ZZG", "NCG", "IIG")) {
    return(sample(c(0, 1), N, replace = TRUE))
  } else {
    return(runif(N))
  }
}

#' Simulate games on the network
#' @param G An igraph network
#' @param N Number of nodes
#' @param L Number of iterations
#' @param game_type Game type
#' @param M Payoff matrix
#' @param S Strategies
#' @return A list of results
#' @importFrom igraph as_adjacency_matrix
simulate_games <- function(G, N, L, game_type, M, S) {
  initial_adj <- igraph::as_adjacency_matrix(G)
  final_adj <- initial_adj  # Simplified simulation logic for demonstration purposes
  game_results <- list()  # Placeholder for detailed simulation results
  return(list(initial_adj = initial_adj, final_adj = final_adj, game_results = game_results, strategies = S))
}

#' Visualize the network with strategies
#' @param G An igraph network
#' @param S Strategies
visualize_network <- function(G, S) {
  plot(G, vertex.size = 10, vertex.color = ifelse(S == 1, "red", "blue"), main = "Network Visualization")
}
