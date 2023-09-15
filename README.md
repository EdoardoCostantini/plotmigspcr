# Shiny app: plot mi-gscpr results

This Shiny app allows you to interact with the results in the study [Multiple Imputation with GSPCR: A Case Study](https://github.com/EdoardoCostantini/mi-gspcr-evs).

## 1. Installing the Shiny app as an R package

You can install the Shiny app by using one of the methods described below.

### 1.1 Install from GitHub

1. Open an R session.

2. Install `devtools`, an R package that provides a way to install other R packages directly from GitHub. Run the following R command in the console:

    ```
    install.packages("devtools")
    ```

3. Run the following command:

    ```
    devtools::install_github("https://github.com/EdoardoCostantini/plotmigspcr")
    ```

### 1.2 Install from a local folder

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

## 2. Using the Shiny app

To start the shiny apps and interact with the plots, open an R session and load the package:

```
library("plotmigspcr")
```

Then, run the following command in the R console:

```
start_app()
```

The app interface will explain how to interact with it.