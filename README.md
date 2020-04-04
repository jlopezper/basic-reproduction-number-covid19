
## Basic reproductive number (R0) of the COVID-19 outbreak in Spain

Code repository with the aim of having an estimate of the evolution of
the COVID-19 outbreak in the Spanish regions.

The code is developed entirely in R. The `drake` package is used to
manage the workflow. This analysis can be run by cloning the repository
and running the `make.R` file.

### Disclaimer(\!)

This analysis is developed by an inexperienced person and has the
**sole** objective of having a minimum idea of the potential evolution
of the outbreak in Spain. **Under no circumstances** this is intended to
be a reference study with which to take any health decision. If you are
a person with some responsibility in this regard, you do better by
leaving this site and taking a look at the [excellent
work](https://cmmid.github.io/topics/covid19/current-patterns-transmission/global-time-varying-transmission.html)
that the London School of Hygiene and Tropical Medicine (among many
others) is doing.

### Assumptions

The analysis focuses on the estimation of the [basic reproduction
number](https://en.wikipedia.org/wiki/Basic_reproduction_number) for the
Spanish regions. The
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
    analysis a normal distribution with
    <img src="http://www.sciweavers.org/tex2img.php?eq=%5Cmu%20%5Csim%20%7B%5Csf%20N%7D%283.96%2C%202%29&bc=White&fc=Black&im=jpg&fs=12&ff=modern&edit=0" align="center" border="0" alt="\mu \sim {\sf N}(3.96, 2)" width="104" height="19" />
    truncated at
    <img src="http://www.sciweavers.org/tex2img.php?eq=%281%2C%206%29&bc=White&fc=Black&im=jpg&fs=12&ff=modern&edit=0" align="center" border="0" alt="(1, 6)" width="39" height="19" />
    and
    <img src="http://www.sciweavers.org/tex2img.php?eq=%5Csigma%20%5Csim%20%7B%5Csf%20N%7D%284.75%2C%201%29&bc=White&fc=Black&im=jpg&fs=12&ff=modern&edit=0" align="center" border="0" alt="\sigma \sim {\sf N}(4.75, 1)" width="103" height="19" />
    truncated at
    <img src="http://www.sciweavers.org/tex2img.php?eq=%282.5%2C%206%29&bc=White&fc=Black&im=jpg&fs=12&ff=modern&edit=0" align="center" border="0" alt="(2.5, 6)" width="51" height="19" />
    is considered.

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

Enter the container:

    docker exec -it basic-reproduction-number-covid19_analysis_1 bash

When the process ends, exit the container:

    exit
    docker-compose down

Finally, you will find the results within the `plots` directory\!

![Image](https://i.imgur.com/K2XFYBQ.png)

### Useful resources

  - [Docker and
    Packrat](https://www.joelnitta.com/post/docker-and-packrat/)
