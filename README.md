# Shiny earthworm distribution

Visualize maps of earthworm distribution in Europe.


### Prerequisites

Requirements for the software:
- 15.9 GB memory
- R version 4.5.2
- R packages: tidyverse_2.0.0 with stringr_1.6.0, dplyr_1.2.0, readr_2.2.0, tidyr_1.3.2, tibble_3.3.1, and ggplot2_4.0.2; and shiny_1.14.0

Size of the respository (zip-file): 62.3 MB



## Set up

- Run `renv::restore()` to reconstruct package environment based on renv.lock file.
- If you added packages, please use `renv::snapshot` to update the lockfile accordingly.


## Executing program

- Open the project file *Shiny-earthworm-distribution.Rproj* in Rstudio.
- Open the app.R script in the project folder.
- Run the app.

Note: Defining file name before download when saving plots as PNG does not yet work. 

Files in the ~/data/ folder contain data that will be loaded to show maps. Unpublished files in ~/data/ were used for data preparation only.


## Authors

  - **Romy Zeiss** - Provided README file, R code and data -
    [JeMaNd_r](https://github.com/jemand-r)

See also coauthors in Zeiss et al. (2023) Conservation Biology who participated in this project.


## License

This project is licensed under the [MIT license](LICENSE.md) - see the [LICENSE.md](LICENSE.md) file for details.


## Reference

Zeiss, R., Briones, M. J., Mathieu, J., Lomba, A., Dahlke, J., Heptner, L. F., ... & Guerra, C. A. (2023). Climate effects on the distribution and conservation of commonly observed European earthworms. Conservation Biology.
