# Load necessary packages
using OrdinaryDiffEq
using Trixi

# Create equations
advectionvelocity = (1.0, 1.0)
equations = LinearScalarAdvectionEquation2D(advectionvelocity)

# Create DGSEM solver for polynomial degree = 3
solver = DGSEM(3, flux_lax_friedrichs)

# Create a uniformely refined mesh with periodic boundaries
coordinates_min = (-1, -1) # minimum coordinates
coordinates_max = ( 1,  1) # maximum coordinates
mesh_static = TreeMesh(coordinates_min, coordinates_max,
                       initial_refinement_level=4,
                       n_cells_max=30_000)

# Create semidiscretization with all spatial discretization-related components
semi = SemidiscretizationHyperbolic(mesh_static, equations,
                                    initial_condition_convergence_test,
                                    solver)

# Create ODE problem from semidiscretization with time span from 0.0 to 1.0
ode = semidiscretize(semi, (0.0, 1.0))

# Evolve ODE problem in time using OrdinaryDiffEq's `solve` method
sol = solve(ode, BS3(), save_everystep=false);

nothing # To suppress output when include'ing this file in the REPL (otherwise `sol` is printed)
