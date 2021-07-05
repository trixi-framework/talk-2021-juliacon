
using OrdinaryDiffEq
using Trixi

###############################################################################
# semidiscretization of the compressible Euler equations
gamma = 1.4
equations = CompressibleEulerEquations1D(gamma)

initial_condition = initial_condition_density_wave

surface_flux = flux_central
polydeg = 5
solver = DGSEM(polydeg, surface_flux)

coordinates_min = (-1.0,)
coordinates_max = ( 1.0,)
mesh = TreeMesh(coordinates_min, coordinates_max,
                initial_refinement_level=2,
                n_cells_max=30_000)


semi = SemidiscretizationHyperbolic(mesh, equations, initial_condition, solver)


###############################################################################
# ODE solvers, callbacks etc.

tspan = (0.0, 2.0)
ode = semidiscretize(semi, tspan)


###############################################################################
# run the simulation

sol = solve(ode, BS3(), save_everystep=false);
