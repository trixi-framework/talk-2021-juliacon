# Load necessary packages
using OrdinaryDiffEq
using Trixi
using Plots


###############################################################################
# semidiscretization of the linear advection equation

# Create equations
advectionvelocity = (1.0, 0.1)
equations = LinearScalarAdvectionEquation2D(advectionvelocity)

# Create DGSEM solver for polynomial degree = 3
solver = DGSEM(3, flux_lax_friedrichs)

# Create a uniformely refined mesh with periodic boundaries
coordinates_min = (-1, -1) # minimum coordinates
coordinates_max = ( 1,  1) # maximum coordinates
mesh_amr = TreeMesh(coordinates_min, coordinates_max,
                    initial_refinement_level=2,
                    n_cells_max=30_000)

# Create new initial condition for cosine pulse
function cosine_pulse(x, t, equations::LinearScalarAdvectionEquation2D)
  halfwidth = 0.3
  radius = sqrt(x[1]^2 + x[2]^2)

  if radius > halfwidth
    u = 0.0
  else
    u = 0.2 * cos(pi/2 * radius / halfwidth)
  end

  return Trixi.@SVector [u]
end

# Create semidiscretization with all spatial discretization-related components
semi = SemidiscretizationHyperbolic(mesh_amr, equations,
                                    cosine_pulse,
                                    solver)


###############################################################################
# ODE solvers, callbacks etc.

# Create ODE problem with time span from 0.0 to 1.7
ode = semidiscretize(semi, (0.0, 1.7));

# Use a simple AMR controller that to refine cells between level 4 and level 6, based on the maximum value of the solution in an element
amr_controller = ControllerThreeLevel(semi,
                                      IndicatorMax(semi, variable=first),
                                      base_level=4,
                                      med_level=5, med_threshold=0.05,
                                      max_level=6, max_threshold=0.15);

# Create the AMR callback that will be called every 5 time steps
amr_callback = AMRCallback(semi, amr_controller,
                           interval=5);

# Create visualization callback for in-situ visualization
visualization_callback = VisualizationCallback(interval=50, seriescolor=:heat);

# Create callback set to combine all created callbacks
callback_set = CallbackSet(visualization_callback, amr_callback)


###############################################################################
# run the simulation

# Create and solve ODE problem, using the previously constructed callback set
sol = solve(ode, CarpenterKennedy2N54(williamson_condition=false), dt=2.5e-2
            callback=callback_set);

nothing
