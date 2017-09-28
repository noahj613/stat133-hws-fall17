Homework 1
================

``` r
load("nba2017-salary-points.RData")
new.salary <- salary/1000000
new.experience <- replace(experience, experience == "R", "0")
new.position <- factor(x = position, c("C", "PF", "SG", "PG", "SF"), c("Center", "Power Forward", "Shooting Guard", "Point Guard", "Small Forward"))

table(new.position)
```

    ## new.position
    ##         Center  Power Forward Shooting Guard    Point Guard  Small Forward 
    ##             89             89             95             85             83

``` r
plot(points, new.salary)
```

![](hw01-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-2-1.png)

There does seem to be a positive trend in the data. The majority of the points are clustered around low salary and low point totals.

``` r
n <- 441
xbar <- sum(points)/n
ybar <- sum(new.salary)/n
varx <- (1/(n-1))*sum((points-xbar)^2)
vary <- (1/(n-1))*sum((new.salary-ybar)^2)
sdx <- sqrt(varx)
sdy <- sqrt(vary)
covxy <- (1/(n-1))*sum((points-xbar)*(new.salary-ybar))
corrxy <- covxy/(sdx*sdy)
n
```

    ## [1] 441

``` r
xbar
```

    ## [1] 546.6054

``` r
ybar
```

    ## [1] 6.187014

``` r
varx
```

    ## [1] 239136.2

``` r
vary
```

    ## [1] 43.18973

``` r
sdx
```

    ## [1] 489.0156

``` r
sdy
```

    ## [1] 6.57189

``` r
covxy
```

    ## [1] 2046.213

``` r
corrxy
```

    ## [1] 0.6367043

``` r
b1 <- corrxy*(sdy/sdx)
b0 <- ybar-b1*xbar
yhat <- b0+b1*points

summary(yhat)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##   1.510   2.845   5.206   6.187   8.184  23.398

The regression equation is yhat = 1.5098856 + 0.0085567x

The slope positive which indicates that salaries increase as points increase. Literally, I think it means that a player is predicted to earn approximately $8556.68 per point.

The intercept is the amount a player in the NBA is predicted to earn should they score 0 points. \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

\*\*Note: this happens when I try to use inline code to answer this part of Q4. Not sure how to fix

The predicted salary for a player who scores...

...0 points is $1.509885610^{6} \_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_

``` r
y0 <- (b0+b1*0)*1000000
y100 <- (b0+b1*100)*1000000
y500 <- (b0+b1*500)*1000000
y1000 <- (b0+b1*1000)*1000000
y2000 <- (b0+b1*2000)*1000000
```

The predicted salary for a player who scores...

...0 points is $1.509885610^{6}.

...100 points is $2.365553710^{6}.

...500 points is $5.788226110^{6}.

...1000 points is $1.006656610^{7}.

...2000 points is $1.862324710^{7}.

``` r
plot(points, salary)
abline()
```

![](hw01-noah-weingarten_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-1.png)
