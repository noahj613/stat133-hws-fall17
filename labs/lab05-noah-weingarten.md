Lab 5: First contact with dplyr and ggplot2
================
Noah Weingarten

> ### Learning Objectives:
>
> -   Get started with `"dplyr"`
> -   Get to know the basic dplyr verbs:
> -   `slice()`, `filter()`, `select()`
> -   `mutate()`
> -   `arrange()`
> -   `summarise()`
> -   `group_by()`
> -   Get started with `"ggplot2"`
> -   Produce basic plots with `ggplot()`

------------------------------------------------------------------------

Manipulating and Visualizing Data Frames
----------------------------------------

Last week you started to manipulate data tables (under the class of `"data.frame"` objects) using bracket notation, `dat[ , ]`, and the dollar operator, `dat$name`, in order to select specific rows, columns, or cells. In addition, you have been creating charts with functions like `plot()`, `boxplot()`, and `barplot()`, which are part of the `"graphics"` package.

In this lab, you will start learning about other approaches to manipulate tables and create statistical charts. We are going to use the functionality of the package `"dplyr"` to work with tabular data in a more consistent way. This is a fairly recent package introduced a couple of years ago, but it is based on more than a decade of research and work lead by Hadley Wickham.

Likewise, to create graphics in a more consistent and visually pleasing way, we are going to use the package `"ggplot2"`, also originally authored by Hadley Wickham, and developed as part of his PhD more than a decade ago.

Use the first hour of the lab to get as far as possible with the material associated to `"dplyr"`. Then use the second hour of the lab to work on graphics with `"ggplot2"` (all the material is in this file).

While you follow this lab, you may want to open these cheat sheets:

-   [dplyr cheatsheet](../cheat-sheets/data-transformation-cheatsheet.pdf)
-   [ggplot2 cheatsheet](../cheat-sheets/ggplot2-cheatsheet-2.1.pdf)

### Installing packages

I'm assuming that you already installed the packages `"dplyr"` and `"ggplot2"`. If that's not the case then run on the console the command below (do NOT include this in your `Rmd`):

``` r
# don't worry too much if you get a warning message
#install.packages(c("dplyr", "ggplot2"))
```

Remember that you only need to install a package once! After a package has been installed in your machine, there is no need to call `install.packages()` again on the same package. What you should always invoke in order to use the functions in a package is the `library()` function:

``` r
# don't forget to load the packages
library(dplyr)
library(ggplot2)
```

**About loading packages:** Another rule to keep in mind is to always load any required packages at the very top of your script files (`.R` or `.Rmd` or `.Rnw` files). Avoid calling the `library()` function in the middle of a script. Instead, load all the packages before anything else.

------------------------------------------------------------------------

NBA Players Data
----------------

The data file for this lab is the same you used last week: `nba2017-players.csv`, whic is located in the `data/` folder of the course github repository. I assume that you already downloaded a copy of the csv file to your computer. If that is not the case, here's one option to get your own copy:

``` r
# download RData file into your working directory
github <- "https://github.com/ucb-stat133/stat133-fall-2017/raw/master/"
csv <- "data/nba2017-players.csv"
download.file(url = paste0(github, csv), destfile = 'nba2017-players.csv')
```

To import the data in R you can use the base function `read.csv()`, or you can also use `read_csv()` from the package `"readr"`:

``` r
# with "base" read.csv()
dat <- read.csv('nba2017-players.csv', stringsAsFactors = FALSE)

# with "readr" read_csv()
#dat <- read_csv('nba2017-players.csv')
```

------------------------------------------------------------------------

Basic `"dplyr"` verbs
---------------------

To make the learning process of `"dplyr"` gentler, Hadley Wickham proposes beginning with a set of five *basic verbs* or operations for data frames (each verb corresponds to a function in `"dplyr"`):

-   **filter**: keep rows matching criteria
-   **select**: pick columns by name
-   **mutate**: add new variables
-   **arrange**: reorder rows
-   **summarise**: reduce variables to values

I've modified Hadley's list of verbs a little bit:

-   `filter()`, `slice()`, and `select()`: subsetting and selecting rows and columns
-   `mutate()`: add new variables
-   `arrange()`: reorder rows
-   `summarise()`: reduce variables to values
-   `group_by()`: grouped (aggregate) operations

------------------------------------------------------------------------

Filtering, slicing, and selecting
---------------------------------

`slice()` allows you to select rows by position:

``` r
# first three rows
three_rows <- slice(dat, 1:3)
three_rows
```

    ## # A tibble: 3 x 15
    ##          player  team position height weight   age experience
    ##           <chr> <chr>    <chr>  <int>  <int> <int>      <int>
    ## 1    Al Horford   BOS        C     82    245    30          9
    ## 2  Amir Johnson   BOS       PF     81    240    29         11
    ## 3 Avery Bradley   BOS       SG     74    180    26          6
    ## # ... with 8 more variables: college <chr>, salary <dbl>, games <int>,
    ## #   minutes <int>, points <int>, points3 <int>, points2 <int>,
    ## #   points1 <int>

`filter()` allows you to select rows by condition:

``` r
# subset rows given a condition
# (height greater than 85 inches)
gt_85 <- filter(dat, height > 85)
gt_85
```

    ##               player team position height weight age experience
    ## 1        Edy Tavares  CLE        C     87    260  24          1
    ## 2   Boban Marjanovic  DET        C     87    290  28          1
    ## 3 Kristaps Porzingis  NYK       PF     87    240  21          1
    ## 4        Roy Hibbert  DEN        C     86    270  30          8
    ## 5      Alexis Ajinca  NOP        C     86    248  28          6
    ##                 college  salary games minutes points points3 points2
    ## 1                          5145     1      24      6       0       3
    ## 2                       7000000    35     293    191       0      72
    ## 3                       4317720    66    2164   1196     112     331
    ## 4 Georgetown University 5000000     6      11      4       0       2
    ## 5                       4600000    39     584    207       0      89
    ##   points1
    ## 1       0
    ## 2      47
    ## 3     198
    ## 4       0
    ## 5      29

`select()` allows you to select columns by name:

``` r
# columns by name
player_height <- select(dat, player, height)
```

### Your turn:

``` r
#- use `slice()` to subset the data by selecting the first 5 rows.
first_five <- slice(dat, 1:5)

#- use `slice()` to subset the data by selecting rows 10, 15, 20, ..., 50.
dat.subset <- slice(dat, c(10, 15, 20, 25, 30, 35, 40, 45, 50))

#- use `slice()` to subset the data by selecting the last 5 rows.
last_five <- slice(dat, 437:441)

#- use `filter()` to subset those players with height less than 70 inches tall.
less_than_70 <- filter(dat, height < 70)

#- use `filter()` to subset rows of Golden State Warriors ('GSW').
gsw <- filter(dat, team == "GSW")

#- use `filter()` to subset rows of GSW centers ('C').
gsw_c <- filter(gsw, position == "C")

#- use `filter()` and then `select()`, to subset rows of lakers ('LAL'), and 
#then display their names.
lal <- filter(dat, team == "LAL")
lal_names <- select(lal, player)

#- use `filter()` and then `select()`, to display the name and salary, 
#of GSW point guards
gsw_pg <- filter(gsw, position == "PG")
gsw_pg_names_salary <- select(gsw_pg, player, salary)

#- find how to select the name, age, and team, of players with more than 
#10 years of experience, making 10 million dollars or less.
more_10y <- filter(dat, experience > 10) %>%
  select(player, age, team)
#- find how to select the name, team, height, and weight, of rookie players, 
#20 years old, displaying only the first five occurrences (i.e. rows)
rookies <- filter(dat, experience == 0)
r_age20 <- filter(rookies, age == 20) %>%
  select(player, team, height, weight)
slice(r_age20, 1:5)
```

    ## # A tibble: 5 x 4
    ##              player  team height weight
    ##               <chr> <chr>  <int>  <int>
    ## 1      Jaylen Brown   BOS     79    225
    ## 2    Henry Ellenson   DET     83    245
    ## 3 Stephen Zimmerman   ORL     84    240
    ## 4   Dejounte Murray   SAS     77    170
    ## 5    Chinanu Onuaku   HOU     82    245

------------------------------------------------------------------------

Adding new variables: `mutate()`
--------------------------------

Another basic verb is `mutate()` which allows you to add new variables. Let's create a small data frame for the warriors with three columns: `player`, `height`, and `weight`:

``` r
# creating a small data frame step by step
gsw <- filter(dat, team == 'GSW')
gsw <- select(gsw, player, height, weight)
gsw <- slice(gsw, c(4, 8, 10, 14, 15))
gsw
```

    ## # A tibble: 5 x 3
    ##           player height weight
    ##            <chr>  <int>  <int>
    ## 1 Draymond Green     79    230
    ## 2   Kevin Durant     81    240
    ## 3  Klay Thompson     79    215
    ## 4  Stephen Curry     75    190
    ## 5  Zaza Pachulia     83    270

Now, let's use `mutate()` to (temporarily) add a column with the ratio `height / weight`:

``` r
mutate(gsw, height / weight)
```

    ## # A tibble: 5 x 4
    ##           player height weight `height/weight`
    ##            <chr>  <int>  <int>           <dbl>
    ## 1 Draymond Green     79    230       0.3434783
    ## 2   Kevin Durant     81    240       0.3375000
    ## 3  Klay Thompson     79    215       0.3674419
    ## 4  Stephen Curry     75    190       0.3947368
    ## 5  Zaza Pachulia     83    270       0.3074074

You can also give a new name, like: `ht_wt = height / weight`:

``` r
mutate(gsw, ht_wt = height / weight)
```

    ## # A tibble: 5 x 4
    ##           player height weight     ht_wt
    ##            <chr>  <int>  <int>     <dbl>
    ## 1 Draymond Green     79    230 0.3434783
    ## 2   Kevin Durant     81    240 0.3375000
    ## 3  Klay Thompson     79    215 0.3674419
    ## 4  Stephen Curry     75    190 0.3947368
    ## 5  Zaza Pachulia     83    270 0.3074074

In order to permanently change the data, you need to assign the changes to an object:

``` r
gsw2 <- mutate(gsw, ht_m = height * 0.0254, wt_kg = weight * 0.4536)
gsw2
```

    ## # A tibble: 5 x 5
    ##           player height weight   ht_m   wt_kg
    ##            <chr>  <int>  <int>  <dbl>   <dbl>
    ## 1 Draymond Green     79    230 2.0066 104.328
    ## 2   Kevin Durant     81    240 2.0574 108.864
    ## 3  Klay Thompson     79    215 2.0066  97.524
    ## 4  Stephen Curry     75    190 1.9050  86.184
    ## 5  Zaza Pachulia     83    270 2.1082 122.472

Reordering rows: `arrange()`
----------------------------

The next basic verb of `"dplyr"` is `arrange()` which allows you to reorder rows. For example, here's how to arrange the rows of `gsw` by `height`

``` r
# order rows by height (increasingly)
arrange(gsw, height)
```

    ## # A tibble: 5 x 3
    ##           player height weight
    ##            <chr>  <int>  <int>
    ## 1  Stephen Curry     75    190
    ## 2 Draymond Green     79    230
    ## 3  Klay Thompson     79    215
    ## 4   Kevin Durant     81    240
    ## 5  Zaza Pachulia     83    270

By default `arrange()` sorts rows in increasing. To arrande rows in descending order you need to use the auxiliary function `desc()`.

``` r
# order rows by height (decreasingly)
arrange(gsw, desc(height))
```

    ## # A tibble: 5 x 3
    ##           player height weight
    ##            <chr>  <int>  <int>
    ## 1  Zaza Pachulia     83    270
    ## 2   Kevin Durant     81    240
    ## 3 Draymond Green     79    230
    ## 4  Klay Thompson     79    215
    ## 5  Stephen Curry     75    190

``` r
# order rows by height, and then weight
arrange(gsw, height, weight)
```

    ## # A tibble: 5 x 3
    ##           player height weight
    ##            <chr>  <int>  <int>
    ## 1  Stephen Curry     75    190
    ## 2  Klay Thompson     79    215
    ## 3 Draymond Green     79    230
    ## 4   Kevin Durant     81    240
    ## 5  Zaza Pachulia     83    270

------------------------------------------------------------------------

### Your Turn

-   using the data frame `gsw`, add a new variable `product` with the product of `height` and `weight`.

``` r
mutate(gsw, product = height * weight)
```

    ## # A tibble: 5 x 4
    ##           player height weight product
    ##            <chr>  <int>  <int>   <int>
    ## 1 Draymond Green     79    230   18170
    ## 2   Kevin Durant     81    240   19440
    ## 3  Klay Thompson     79    215   16985
    ## 4  Stephen Curry     75    190   14250
    ## 5  Zaza Pachulia     83    270   22410

-   create a new data frame `gsw3`, by adding columns `log_height` and `log_weight` with the log transformations of `height` and `weight`.

``` r
gsw3 <- mutate(gsw, log_height = log(height), log_weight = log(weight))
gsw3
```

    ## # A tibble: 5 x 5
    ##           player height weight log_height log_weight
    ##            <chr>  <int>  <int>      <dbl>      <dbl>
    ## 1 Draymond Green     79    230   4.369448   5.438079
    ## 2   Kevin Durant     81    240   4.394449   5.480639
    ## 3  Klay Thompson     79    215   4.369448   5.370638
    ## 4  Stephen Curry     75    190   4.317488   5.247024
    ## 5  Zaza Pachulia     83    270   4.418841   5.598422

-   use the original data frame to `filter()` and `arrange()` those players with height less than 71 inches tall, in increasing order.

``` r
filter(dat, height < 71) %>%
  arrange(height)
```

    ##          player team position height weight age experience
    ## 1 Isaiah Thomas  BOS       PG     69    185  27          5
    ## 2    Kay Felder  CLE       PG     69    176  21          0
    ## 3    Tyler Ulis  PHO       PG     70    150  21          0
    ##                    college  salary games minutes points points3 points2
    ## 1 University of Washington 6587132    76    2569   2199     245     437
    ## 2       Oakland University  543471    42     386    166       7      55
    ## 3   University of Kentucky  918369    61    1123    444      21     163
    ##   points1
    ## 1     590
    ## 2      35
    ## 3      55

-   display the name, team, and salary, of the top-5 highest paid players

``` r
top5_salary <- select(dat, player, team, salary) %>%
  arrange(desc(salary)) %>%
  slice(1:5)
top5_salary
```

    ## # A tibble: 5 x 3
    ##          player  team   salary
    ##           <chr> <chr>    <dbl>
    ## 1  LeBron James   CLE 30963450
    ## 2    Al Horford   BOS 26540100
    ## 3 DeMar DeRozan   TOR 26540100
    ## 4  Kevin Durant   GSW 26540100
    ## 5  James Harden   HOU 26540100

-   display the name, team, and points3, of the top 10 three-point players

``` r
top10_3pt <- select(dat, player, team, points3) %>%
  arrange(desc(points3)) %>%
  slice(1:10)
top10_3pt
```

    ## # A tibble: 10 x 3
    ##            player  team points3
    ##             <chr> <chr>   <int>
    ##  1  Stephen Curry   GSW     324
    ##  2  Klay Thompson   GSW     268
    ##  3   James Harden   HOU     262
    ##  4    Eric Gordon   HOU     246
    ##  5  Isaiah Thomas   BOS     245
    ##  6   Kemba Walker   CHO     240
    ##  7   Bradley Beal   WAS     223
    ##  8 Damian Lillard   POR     214
    ##  9  Ryan Anderson   HOU     204
    ## 10    J.J. Redick   LAC     201

-   create a data frame `gsw_mpg` of GSW players, that contains variables for player name, experience, and `min_per_game` (minutes per game), sorted by `min_per_game` (in descending order)

``` r
gsw_mpg <- select(filter(dat, team == "GSW"), player, experience, minutes, games) %>%
  mutate(min_per_game = minutes/games) %>%
  arrange(desc(min_per_game))
```

------------------------------------------------------------------------

Summarizing values with `summarise()`
-------------------------------------

The next verb is `summarise()`. Conceptually, this involves applying a function on one or more columns, in order to summarize values. This is probably easier to understand with one example.

Say you are interested in calculating the average salary of all NBA players. To do this "a la dplyr" you use `summarise()`, or its synonym function `summarize()`:

``` r
# average salary of NBA players
summarise(dat, avg_salary = mean(salary))
```

    ##   avg_salary
    ## 1    6187014

Calculating an average like this seems a bit *verbose*, especially when you can directly use `mean()` like this:

``` r
mean(dat$salary)
```

    ## [1] 6187014

So let's make things a bit more interessting. What if you want to calculate some summary statistics for `salary`: min, median, mean, and max?

``` r
# some stats for salary (dplyr)
summarise(
  dat, 
  min = min(salary),
  median = median(salary),
  avg = mean(salary),
  max = max(salary)
)
```

    ##    min  median     avg      max
    ## 1 5145 3500000 6187014 30963450

Well, this may still look like not much. You can do the same in base R (there are actually better ways to do this):

``` r
# some stats for salary (base R)
c(min = min(dat$salary), 
  median = median(dat$salary),
  median = mean(dat$salary),
  max = max(dat$salary))
```

    ##      min   median   median      max 
    ##     5145  3500000  6187014 30963450

Grouped operations
------------------

To actually appreciate the power of `summarise()`, we need to introduce the other major basic verb in `"dplyr"`: `group_by()`. This is the function that allows you to do perform data aggregations, or *grouped operations*.

Let's see the combination of `summarise()` and `group_by()` to calculate the average salary by team:

``` r
# average salary, grouped by team
summarise(
  group_by(dat, team),
  avg_salary = mean(salary)
)
```

    ## # A tibble: 30 x 2
    ##     team avg_salary
    ##    <chr>      <dbl>
    ##  1   ATL    6491893
    ##  2   BOS    6127673
    ##  3   BRK    4363414
    ##  4   CHI    6138459
    ##  5   CHO    6683086
    ##  6   CLE    8386014
    ##  7   DAL    6139880
    ##  8   DEN    5225533
    ##  9   DET    6871594
    ## 10   GSW    6579394
    ## # ... with 20 more rows

Here's a similar example with the average salary by position:

``` r
# average salary, grouped by position
summarise(
  group_by(dat, position),
  avg_salary = mean(salary)
)
```

    ## # A tibble: 5 x 2
    ##   position avg_salary
    ##      <chr>      <dbl>
    ## 1        C    6987682
    ## 2       PF    5890363
    ## 3       PG    6069029
    ## 4       SF    6513374
    ## 5       SG    5535260

Here's a more fancy example: average weight and height, by position, displayed in desceding order by average height:

``` r
arrange(
  summarise(
    group_by(dat, position),
    avg_height = mean(height),
    avg_weight = mean(weight)),
  desc(avg_height)
)
```

    ## # A tibble: 5 x 3
    ##   position avg_height avg_weight
    ##      <chr>      <dbl>      <dbl>
    ## 1        C   83.25843   250.7978
    ## 2       PF   81.50562   235.8539
    ## 3       SF   79.63855   220.4699
    ## 4       SG   77.02105   204.7684
    ## 5       PG   74.30588   188.5765

### Your turn:

-   use `summarise()` to get the largest height value.

``` r
summarise(dat, largest_height_value = max(height))
```

    ##   largest_height_value
    ## 1                   87

-   use `summarise()` to get the standard deviation of `points3`.

``` r
summarise(dat, points3_sd = sd(points3))
```

    ##   points3_sd
    ## 1    55.9721

-   use `summarise()` and `group_by()` to display the median of three-points, by team.

``` r
arrange(
  summarise(
    group_by(dat, position),
    med = median(points3)),
  desc(med)
  )
```

    ## # A tibble: 5 x 2
    ##   position   med
    ##      <chr> <int>
    ## 1       SG    73
    ## 2       SF    45
    ## 3       PG    40
    ## 4       PF    20
    ## 5        C     0

-   display the average triple points by team, in ascending order, of the bottom-5 teams (worst 3pointer teams)

``` r
slice(
  arrange(
  summarise(
    group_by(dat, team),
    points3_avg = mean(points3)),
  points3_avg),
  1:5
)
```

    ## # A tibble: 5 x 2
    ##    team points3_avg
    ##   <chr>       <dbl>
    ## 1   NOP    36.64286
    ## 2   SAC    37.20000
    ## 3   PHO    37.60000
    ## 4   CHI    37.66667
    ## 5   LAL    39.46667

-   obtain the mean and standard deviation of `age`, for Power Forwards, with 5 and 10 years (including) years of experience.

``` r
filter(dat, position == "PF") %>%
  filter(experience == 5:10) %>%
  summarise(avg_age = mean(age), sd_age = sd(age))
```

    ## Warning in experience == 5:10: longer object length is not a multiple of
    ## shorter object length

    ##   avg_age   sd_age
    ## 1   27.25 1.832251

------------------------------------------------------------------------

First contact with `ggplot()`
-----------------------------

The package `"ggplot2"` is probably the most popular package in R to create *beautiful* graphics. In contrast to the functions in the base package `"graphcics"`, the package `"ggplot2`" follows a somewhat different philosophy, and it tries to be more consistent and modular as possible.

-   The main function in `"ggplot2"` is `ggplot()`
-   The main input to `ggplot()` is a data frame object.
-   You can use the internal function `aes()` to specify what columns of the data frame will be used for the graphical elements of the plot.
-   You must specify what kind of *geometric objects* or **geoms** will be displayed: e.g. `geom_point()`, `geom_bar()`, `geom_boxpot()`.
-   Pretty much anything else that you want to add to your plot is controlled by auxiliary functions, especially those things that have to with the format, rather than the underlying data.
-   The construction of a ggplot is done by *adding layers* with the `+` operator.

### Scatterplots

Let's start with a scatterplot of `salary` and `points`

``` r
# scatterplot (option 1)
ggplot(data = dat) +
  geom_point(aes(x = points, y = salary))
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-33-1.png)

-   `ggplot()` creates an object of class `"ggplot"`
-   the main input for `ggplot()` is `data` which must be a data frame
-   then we use the `"+"` operator to add a layer
-   the geometric object (geom) are points: `geom_points()`
-   `aes()` is used to specify the `x` and `y` coordinates, by taking columns `points` and `salary` from the data frame

The same scatterplot can also be created with this alternative, and more common use of `ggplot()`

``` r
# scatterplot (option 2)
ggplot(data = dat, aes(x = points, y = salary)) +
  geom_point()
```

Say you want to color code the points in terms of the `position`

``` r
# colored scatterplot 
ggplot(data = dat, aes(x = points, y = salary)) +
  geom_point(aes(color = position))
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-35-1.png)

Maybe you wan to modify the size of the dots in terms of `points3`:

``` r
# sized and colored scatterplot 
ggplot(data = dat, aes(x = points, y = salary)) +
  geom_point(aes(color = position, size = points3))
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-36-1.png)

To add some transparency effect to the dots, you can use the `alpha` parameter

``` r
# sized and colored scatterplot 
ggplot(data = dat, aes(x = points, y = salary)) +
  geom_point(aes(color = position, size = points3), alpha = 0.7)
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-37-1.png)

Notice that `alpha` was specified outside `aes()`. This is because we are not using any column for the `alpha` transparency values.

### Your turn:

-   Use the data frame `gsw` to make a scatterplot of `height` and `weight`

``` r
ggplot(data = gsw, aes(x = height, y = weight)) + geom_point()
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-38-1.png)

-   Find out how to make another scatterplot of `height` and `weight`, using `geom_text()` to display the names of the players

``` r
ggplot(data = gsw, aes(x = height, y = weight)) + geom_point() + geom_text(aes(label = player))
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-39-1.png)

-   Get a scatter plot of `height` and `weight`, for ALL the warriors, displaying their names with `geom_label()`

``` r
ggplot(data = gsw, aes(x = height, y = weight)) + geom_point() + geom_label(aes(label = player))
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-40-1.png) - Get a density plot of `salary` (for all NBA players)

``` r
ggplot(data = dat, aes(x = salary)) + geom_density()
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-41-1.png)

-   Get a histogram of `points2` with binwidth of 50 (for all NBA players)

``` r
ggplot(data = dat, aes(x = points2)) + geom_histogram(binwidth = 50)
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-42-1.png)

-   Get a barchart of the `position` frequencies (for all NBA players)

``` r
ggplot(data = dat, aes(x = position)) + geom_bar()
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-43-1.png)

-   Make a scatterplot of `experience` and `salary` of all centers, and use `geom_smooth()` to add a regression line

``` r
ggplot(data = filter(dat, position == "C"), aes(x = experience, y = salary)) + geom_point() + 
  geom_smooth(method = "lm")
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-44-1.png)

-   Repeat the same scatterplot of `experience` and `salary` of all centers, but now use `geom_smooth()` to add a loess line

``` r
ggplot(data = filter(dat, position == "C"), aes(x = experience, y = salary)) + geom_point() + 
  geom_smooth()
```

    ## `geom_smooth()` using method = 'loess'

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-45-1.png)

Faceting
--------

One of the most attractive features of `"ggplot2"` is the ability to display multiple **facets**. The idea of facets is to divide a plot into subplots based on the values of one or more categorical (or discrete) variables.

Here's an example. What if you want to get scatterplots of `points` and `salary` separated (or grouped) by `position`? This is where faceting comes handy, and you can use `facet_warp()` for this purpose:

``` r
# scatterplot by position
ggplot(data = dat, aes(x = points, y = salary)) +
  geom_point() +
  facet_wrap(~ position)
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-46-1.png)

The other faceting function is `facet_grid()`, which allows you to control the layout of the facets (by rows, by columns, etc)

``` r
# scatterplot by position
ggplot(data = dat, aes(x = points, y = salary)) +
  geom_point(aes(color = position), alpha = 0.7) +
  facet_grid(~ position) +
  geom_smooth(method = loess)
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-47-1.png)

``` r
# scatterplot by position
ggplot(data = dat, aes(x = points, y = salary)) +
  geom_point(aes(color = position), alpha = 0.7) +
  facet_grid(position ~ .) +
  geom_smooth(method = loess)
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-47-2.png)

### Your turn:

-   Make scatterplots of `experience` and `salary` faceting by `position`

``` r
ggplot(data = dat, aes(x = experience, y = salary)) +
         geom_point() +
         facet_wrap(~ position)
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-48-1.png)

-   Make scatterplots of `experience` and `salary` faceting by `team`

``` r
ggplot(data = dat, aes(x = experience, y = salary)) +
         geom_point() +
         facet_wrap(~ team)
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-49-1.png)

-   Make density plots of `age` faceting by `team`

``` r
ggplot(data = dat, aes(x = age)) +
  facet_wrap(~ team) +
  geom_density()
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-50-1.png)

-   Make scatterplots of `height` and `weight` faceting by `position`

``` r
ggplot(data = dat, aes(x = height, y = weight)) +
  geom_point() +
  facet_wrap(~ position)
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-51-1.png)

-   Make scatterplots of `height` and `weight`, with a 2-dimensional density, `geom_density2d()`, faceting by `position`

``` r
ggplot(data = dat, aes(x = height, y = weight)) +
  geom_density2d() +
  facet_grid(~ position)
```

![](lab05-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-52-1.png)
