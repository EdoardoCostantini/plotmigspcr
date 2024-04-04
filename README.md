# Shiny app: plot mi-gscpr results

An interactive dashboard to interact with the results of a research paper.

## Code Example

To start the shiny apps and interact with the plots, open an R session and load the package:

```
library("plotmigspcr")
```

Then, run the following command in the R console:

```
start_app()
```

The app interface will explain how to interact with it.

## Motivation

This Shiny app allows you to interact with the results of the research paper asosciated with the GitHub project [Multiple Imputation with GSPCR: A Case Study](https://github.com/EdoardoCostantini/mi-gspcr-evs).

## Installation

You can install the Shiny app as an R package by using one of the methods described below.

### Install from GitHub

1. Open an R session.

2. Install `devtools`, an R package that provides a way to install other R packages directly from GitHub. Run the following R command in the console:

    ```
    install.packages("devtools")
    ```

3. Run the following command:

    ```
    devtools::install_github("https://github.com/EdoardoCostantini/plotmigspcr")
    ```

### Install from a local folder

1. Download the package from GitHub or [Zenodo](https://doi.org/10.5281/zenodo.7879867).

2. Unzip the package.

3. Open an R session, and run the following command.

    ```
    install.packages(
        "path to the folder containing the package",
        repos = NULL,
        type = "source"
    )
    ```

    For example, on a Windows computer, this could be

    ```
    install.packages(
        "C:/Users/Name/Downloads/plotmigspcr/",
        repos = NULL,
        type = "source"
    )
    ```

## Tests

### Unit tests

This software uses **unit tests** to test whether the functions behave as expected. These tests are performed by using the `check()` function from the `devtools` R package.
The workflow is the one established by the `testthat` R package.
To run these tests:

1. Install the `devtools` R package, if you do not have it already.

    ``` r
    install.packages("devtools")
    ```

2. Then, you can test with the following command in the R console:

    ``` r
    devtools::check()
    ```

## Contributors

- [Edoardo Costantini](https://github.com/EdoardoCostantini)

## License

MIT License.