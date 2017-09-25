up02-Noah-Weingarten.Rmd
================

``` r
# assembling url (so it fits on the screen)
github <- 'https://github.com/ucb-stat133/stat133-hws-fall17/'
repo <- 'raw/master/warmup02/data/nba2017-salary-points.RData'

download.file(
  url = paste0(github, repo),
  destfile = "nba2017-salary-points.RData")
```

``` r
# load the objects
load("nba2017-salary-points.RData")

# list the available objects
ls()
```

    ##  [1] "experience" "github"     "player"     "points"     "points1"   
    ##  [6] "points2"    "points3"    "position"   "repo"       "salary"    
    ## [11] "team"

Qualitative: "position" Quantitative: "salry"

``` r
summary(salary)
```

    ##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
    ##     5145  1286160  3500000  6187014  9250000 30963450

``` r
hist(salary)
```

![](up02-Noah-Weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-3-1.png) The data is heavily skewed to the right

``` r
summary(position)
```

    ##    Length     Class      Mode 
    ##       441 character character

``` r
table(position)
```

    ## position
    ##  C PF PG SF SG 
    ## 89 89 85 83 95
