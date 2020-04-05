
## Basic reproduction number (R0) of the COVID-19 outbreak in Spain

Code repository with the aim of having an estimate of the evolution of
the COVID-19 outbreak in the Spanish regions.

The code is developed entirely in R. The `drake` package is used to
manage the workflow. This analysis can be run by cloning the repository
and running the `make.R` file.

### Disclaimer (\!)

This analysis is developed by a layman and has the **sole** objective of
having a minimum idea of the potential evolution of the outbreak in
Spain. **Under no circumstances** this is intended to be a reliable
study with which to take any health decision. If you want to figure out
how experts are modelling this, I strongly recommend taking a look at
the [excellent
work](https://cmmid.github.io/topics/covid19/current-patterns-transmission/global-time-varying-transmission.html)
that the London School of Hygiene and Tropical Medicine is doing.

### Assumptions

The analysis focuses on the estimation of the [basic reproduction
number](https://en.wikipedia.org/wiki/Basic_reproduction_number) for the
Spanish regions based on the **confirmed cases** by region. The
[`EpiEstim`](https://cran.r-project.org/web/packages/EpiEstim/index.html)
package is used for this purporse. In particular, this
[package](https://cran.r-project.org/web/packages/EpiEstim/vignettes/demo.html)
has a method (`uncertain_si`) in order to account for uncertainty on the
serial interval distribution. Why was this method chosen?

1.  It’s a new virus so a lot of research will be done in the coming
    months. There’s no absolute evidence about the serial interval
    distribution.
2.  Although many epidemiological models for viruses with *similar
    behaviour* are modelled with a serial interval under a Gamma or
    Weibull distributions, this doesn’t seem to be entirely clear [in
    this case](https://wwwnc.cdc.gov/eid/article/26/6/20-0357_article).
3.  It’s true, as discussed in the article linked in point 2, that the
    virus can have a normally distributed serial interval and therefore
    not restricted to positive values. In this case, `EpiEstim` doesn’t
    consider distributions with real domain [for the time
    being](https://github.com/annecori/EpiEstim/issues/90), so in this
    analysis the following normal distribution is
    considered:

<!-- end list -->

  - ![equation](https://latex.codecogs.com/gif.latex?%5Cmu%20%5Csim%20N%283.96%2C%202%29)
    truncated at
    ![equation](https://latex.codecogs.com/gif.latex?%5B1%2C%206%5D)

  - ![equation](https://latex.codecogs.com/gif.latex?%5Csigma%20%5Csim%20N%284.75%2C%201%29)
    truncated at
    ![equation](https://latex.codecogs.com/gif.latex?%5B2.5%2C%206%5D)

### Reproducible analysis with Docker

To run the analysis, a Docker image is provided that reproduces the
results using the most updated information from the [Instituto de Salud
Carlos III](https://covid19.isciii.es).

*Note:* Depending on your configuration you might need to run the
following commands with root privileges (with `sudo`).

First [install docker](https://docs.docker.com/install/) and clone this
repository:

    git clone https://github.com/jlopezper/basic-reproduction-number-covid19.git

Navigate to the cloned repository on your own machine, and launch the
container:

    cd /path/to/repo
    docker-compose up -d

Enter the container and run the `make.R` file:

    docker exec -it basic-reproduction-number-covid19_analysis_1 bash
    Rscript make.R

When the process ends, exit the container:

    exit
    docker-compose down

Finally, you will find the results within the `plots` directory\!

![Image](https://i.imgur.com/GQNCv8M.png)

### Useful resources

  - [Docker and
    Packrat](https://www.joelnitta.com/post/docker-and-packrat/)
