# Shiny earthworm distribution

Visualize maps of earthworm distribution in Europe.


### Prerequisites

Requirements for the software:
- 15.9 GB memory
- R version 4.5.2
- R packages
  - tidyverse_2.0.0 with stringr_1.6.0, dplyr_1.2.0, readr_2.2.0, tidyr_1.3.2, tibble_3.3.1, and ggplot2_4.0.2
  - shiny_1.14.0
  - maps_3.4.4 and dependencies
  - renv_1.3.1
  - testthat_3.3.2 and dependencies
  - here_1.0.2
  - lintr_3.4.0 and styler_1.11.0
  - shinytest2_0.5.1 and dependencies

Size of the repository (zip-file): 62.3 MB



## Set up

- Run `renv::restore()` to reconstruct package environment based on renv.lock file.
- If you added packages, please use `renv::snapshot` to update the lockfile accordingly.


## Executing program

- Open the project file *Shiny-earthworm-distribution.Rproj* in Rstudio.
- Open the app.R script in the project folder.
- Run the app.

> [!NOTE] 
> Defining file name before download when saving plots as PNG does not yet work. 

Files in the ~/data/ folder contain data that will be loaded to show maps. Unpublished files in ~/data/ were used for data preparation only.


## Testing

Test functions only

```{r}
testthat::test_dir("tests/testthat")
```

Check style and linting

```{r}
styler::style_dir()
lintr::lint_dir()
```

Test interface and functions

```{r}
shinytest2::test_app()
```


## Troubleshooting

In case of an error in memory allocation, try cleaning your environment with `gc()`. Loading the spatial data does require a lot of memory.

It can also help to close and open the RStudio session, and/or close other applications.


## Authors

  - **Romy Zeiss** ([JeMaNd_r](https://github.com/jemand-r)) - Provided README file, R code and data
    

See also coauthors in Zeiss et al. (2024) Conservation Biology who participated in this project.


## License

This project is licensed under the [MIT license](LICENSE.md) - see the [LICENSE.md](LICENSE.md) file for details.


## Reference

Zeiss, R., Briones, M. J. I., Mathieu, J., Lomba, A., Dahlke, J., Heptner, L., Salako, G., Eisenhauer, N., & Guerra, C. A. (2024). Effects of climate on the distribution and conservation of commonly observed European earthworms. Conservation Biology, 38, e14187. https://doi.org/10.1111/cobi.14187
