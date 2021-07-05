# JuliaCon 2021: Adaptive and extendable numerical simulations with Trixi.jl

[![License: MIT](https://img.shields.io/badge/License-MIT-success.svg)](https://opensource.org/licenses/MIT)
[![nbviewer](https://raw.githubusercontent.com/jupyter/design/master/logos/Badges/nbviewer_badge.svg)](https://nbviewer.jupyter.org/github/trixi-framework/talk-2021-juliacon/blob/main/demo.ipynb)
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/trixi-framework/talk-2021-juliacon/HEAD?filepath=demo.ipynb)

This is the companion repository for the talk

**Adaptive and extendable numerical simulations with Trixi.jl**</br>
*Michael Schlottke-Lakemper and Hendrik Ranocha*</br>
[JuliaCon 2021](https://juliacon.org/2021)

(see abstract [below](#abstract)). Here you can find the presentation slides
[talk.pdf](talk.pdf) as well as the [Jupyter](https://jupyter.org) notebook
[demo.ipynb](demo.ipynb), which was used during the talk for a live
demonstration of [Trixi.jl](https://github.com/trixi-framework/Trixi.jl).
Note that to play the video linked in the presentation, you also need to
download the [media/](media/) directory and place it in the same folder as the
PDF. There are also some additional Trixi elixirs (simulation setups) in the
[examples](examples/) directory.


## Abstract

Trixi.jl is a numerical simulation framework for adaptive, high-order
discretizations of conservation laws. It has a modular architecture that allows
users to easily extend its functionality and was designed to be useful to
experienced researchers and new users alike. In this talk, we will give an
overview of Trixi’s current features, present a typical workflow for creating
and running a simulation, and show how to add new capabilities for your own
research projects.

### More detailed description

When doing research on numerical discretization methods, scientists are often
faced with a dilemma when choosing the appropriate simulation tool: In the
beginning of a project, you often want a code that is nimble and with low
overhead, which allows rapid prototyping to assist you in experimenting with
different approaches. Later on, however, you want to evaluate your newly
developed methods and algorithms in a production setting and require a
high-performance implementation, support for parallelization, and a full
toolchain for postprocessing and visualizing your results.

With [Trixi.jl](https://github.com/trixi-framework/Trixi.jl), we try to bridge
this gap by using a simple but modular architecture, which allows us to easily
extend Trixi beyond the existing functionality. The main components, such as
the mesh, the solvers, or the equations, can each be selected and combined
individually in a library-like manner. At the same time, Trixi is a
comprehensive numerical simulation framework for hyperbolic PDEs and comes with
all necessary ingredients to set up a simulation, run it in parallel, and
visualize the results.

At its core, various systems of equations are solved on hierarchical
quadtree/octree grids that provide adaptive mesh refinement via solution-based
indicators. The equations, e.g., compressible Euler, ideal MHD, or hyperbolic
diffusion, are discretized with high-order discontinuous Galerkin spectral
element methods, with support for entropy-stable shock capturing. Trixi puts an
emphasis on having a fast implementation with shared memory parallelization,
and integrates well with other packages of the Julia ecosystem, such as
[OrdinaryDiffEq.jl](https://github.com/SciML/OrdinaryDiffEq.jl) for time
integration, [ForwardDiff.jl](https://github.com/JuliaDiff/ForwardDiff.jl) for
automatic differentiation, or [Plots.jl](https://github.com/JuliaPlots/Plots.jl)
for visualization. One of the key goals of Trixi is to be useful to experienced
researchers while remaining accessible for new users or students. Thus, we
continuously strive to keep the implementation as simple as reasonably possible.

Due to Julia’s unique capabilities and ecosystem including
[LoopVectorization.jl](https://github.com/JuliaSIMD/LoopVectorization.jl),
serial performance of Trixi can be on par with large-scale C++ and Fortran
projects in performance benchmarks using a subset of optimized methods. At the
same time, the general framework is simple and extendable enough to allow
porting new solver infrastructures within a few hours.

In this talk, we will give an overview of the currently implemented features
and discuss the overall architecture of Trixi. We will show a typical workflow
for creating and running a simulation, and present scientific results that were
obtained with Trixi. Finally, we will demonstrate how to add new capabilities to
Trixi for your own research projects.


## Getting started

You can view a static version of the Jupyter notebook [`demo.ipynb`](demo.ipynb)

- directly on GitHub (select the notebook; this may fail sometimes)
- or on [nbviewer.jupyter.org](https://nbviewer.jupyter.org/)
  (select the "render" badge at the top of this README)

These static versions do not contain output of the code cells.

### Using mybinder.org
The easiest way to get started is to click on the *Launch Binder* badge above.
This launches the notebook for interactive use in your browser without the need
to download or install anything locally.

In this case, you can skip the rest of this *Getting started* section. A
Jupyter instance will be started automagically in the cloud via
[mybinder.org](https://mybinder.org), and the notebook will loaded directly from
this repository.

*Note:*  Depending on current usage and available resources, it typically takes
a few minutes to launch a notebook with [mybinder.org](https://mybinder.org)
(sometimes a little longer), so try to remain patient. Similarly, the first two
cells of the notebook take much longer to execute than usual (around 1.5 minutes
for the first Trixi simulation and about 1 minute for the first plot), since
Julia compiles all methods "just-ahead-of-time" at first use. Subsequent runs
will be much faster.

### Setting up a local Julia/Jupyter installation
Alternatively, you can also clone this repository and open the notebook on your
local machine. This is recommended if you already have a Julia + Jupyter setup
or if you plan to try out Julia anyways.

#### Installing Julia and IJulia
To obtain Julia, go to https://julialang.org/downloads/ and download the latest
stable release (v1.6.1 as of 2021-06-28; neither use the LTS release nor
Julia Pro). Then, follow the
[platform-specific instructions](https://julialang.org/downloads/platform/)
to install Julia on your machine. Note that there is no need to compile anything
if you are using Linux, MacOS, or Windows.

After the installation, open a terminal and start the Julia *REPL*
(i.e., the interactive prompt) with
```shell
julia
```
To use the notebook, you also need to get the
[IJulia](https://github.com/JuliaLang/IJulia.jl) package, which provides a Julia
backend for Jupyter. In the REPL, execute
```julia
using Pkg
Pkg.add("IJulia")
```
to install IJulia. For more details, especially on how to use an existing Jupyter
installation, please refer to the
[IJulia documentation](https://julialang.github.io/IJulia.jl/stable/).
From here on, we assume that you have a working installation of Julia, Jupyter,
and the Julia kernel for Jupyter.

#### Installing the required Julia packages
To make the notebook fully reproducible, we have used Julia's package manager
to pin all packages to a fixed release. This ensures that you always have a
Julia environment in which all examples in this notebook work. Later you can
always install the latest versions of Trixi and its dependencies by following
the instructions in the Trixi
[documentation](https://trixi-framework.github.io/Trixi.jl/stable/).

If you have not done it yet, clone the repository where this notebook is stored:
```shell
git clone https://github.com/trixi-framework/talk-2021-juliacon.git
```
Then, navigate to your repository folder and install the required packages:
```shell
cd talk-2021-juliacon
julia --project=. -e 'using Pkg; Pkg.instantiate()'
```
This will download and build all required packages, including the ODE package
[OrdinaryDiffEq](https://github.com/SciML/OrdinaryDiffEq.jl), the visualization
package [Plots](https://github.com/JuliaPlots/Plots.jl), and of course
[Trixi](https://github.com/trixi-framework/Trixi.jl).
The `--project=.` argument tells Julia to use the `Project.toml`
and `Manifest.toml` files from this repository to figure out which packages to install.

As an alternative to running the examples in the notebook directly, you may
also just view the notebook *statically* by opening it within
[Jupyter NBViewer](https://nbviewer.jupyter.org/github/trixi-framework/talk-2021-Introduction_to_Julia_and_Trixi/blob/main/Talk.ipynb?flush_cache=true).

*General note:* Make sure that you execute the examples (either in the notebook
or in the REPL) *in order*, at least for the first time. Both the notebook and
the Julia REPL maintain an internal state and and some snippets depend on
earlier statements having been executed.

#### Displaying the presentation

To display the presentation as in the talk (skipping some cells/slides that
provide further information), you need the
[Jupyter extension RISE](https://rise.readthedocs.io/en/stable),
that you can install via
```shell
pip3 install --user RISE
```
After opening the Jupyter notebook, you can enter the RISE presentation mode
with `Alt + R`.


## Authors
This repository was initiated by
[Michael Schlottke-Lakemper](https://www.mi.uni-koeln.de/NumSim/schlottke-lakemper)
and [Hendrik Ranocha](https://ranocha.de).


## License
The contents of this repository are licensed under the MIT license
(see [LICENSE.md](LICENSE.md)).
