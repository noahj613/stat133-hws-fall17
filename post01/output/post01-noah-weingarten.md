Delving Deeper into 'dplyr'
================
Noah Weingarten

### Introduction

Data wrangling is often one of the very first things one learns when beginning to code using R; and 'dplyr' is a package that is often used for this task. On the surface, the functions provided through this package are useful tools to have access to. You think, *"Of course this package will come in handy whenever I need to manipulate a data set!"* Indeed, this is similar to my thought process when I was first introduced to 'dplyr'. But as I've progressed through the earlier stages of this class, I've come to recognize that 'dplyr' and the data wrangling functions therein are arguably the most vital part of an R-programmer's repertoire. My hope is that, after reading this post, you feel inspired to re-visit the basics of data wrangling and gain mastery of the 'dplyr' package.

> "As the variety of data continues to increase, data wrangling will become more important and having good tools to do this will be a key differentiator for data scientists."
> <center>
> *Amyn Rajan, GM of Connectivity Solutions for Magnitude Software, inc.*

### Data Example

To illustrate just how important 'dplyr' is for an R-programmer, let's take a look at a data set that I have personally used and wrangled in the past. A friend of mine runs a catering service that caters lunches for multiple schools in the East Bay and this is an example of the raw data that she may receive through the website where parents order the food for their kids.

    ##    Order.ID              Campus                  Name          Classroom
    ## 1     41920 Blue Jays and Doves          Mal Brown IV              Doves
    ## 2     44871 Blue Jays and Doves         Dominic Carey              Doves
    ## 3     24328 Blue Jays and Doves         Victor Powers              Doves
    ## 4        -- Blue Jays and Doves         Victor Powers              Doves
    ## 5     41920 Blue Jays and Doves          Mal Brown IV              Doves
    ## 6     44871 Blue Jays and Doves         Dominic Carey              Doves
    ## 7     19956             Encinal              Uta Tsai         Front Desk
    ## 8     48046             Encinal     Ziyaan Fitzgerald         Front Desk
    ## 9     44649             Encinal Will Hoadley-Wetstone         Front Desk
    ## 10    43183      GISSV Berkeley         Reijker Moore Default Class Room
    ##         Grade Payment.Status                   Item    Size
    ## 1       Doves           Paid   Please Choose a Side Regular
    ## 2       Doves           Paid   Please Choose a Side Regular
    ## 3       Doves           Paid   Please Choose a Side Regular
    ## 4       Doves           Paid      Chicken Chow Mein Regular
    ## 5       Doves           Paid      Chicken Chow Mein Regular
    ## 6       Doves           Paid   Vegetarian Chow Mein Regular
    ## 7  Front Desk           Paid   Vegetarian Chow Mein Regular
    ## 8  Front Desk           Paid      Chicken Chow Mein Regular
    ## 9  Front Desk           Paid Hamburger with Ketchup Regular
    ## 10  1st Grade           Paid Hamburger with Ketchup Regular
    ##                                                               Addons
    ## 1                                       (1) --- Seasonal Fruit Salad
    ## 2                                       (1) --- Seasonal Fruit Salad
    ## 3                                                                 --
    ## 4                                                                 --
    ## 5                                                                 --
    ## 6                                                                 --
    ## 7                                                                 --
    ## 8                                                                 --
    ## 9  (1) --- GLUTEN FREE BUN\n\n(1) --- Tomato\n\n(1) --- Salad Greens
    ## 10                                                                --
    ##                  Vendor Quantity Received
    ## 1  Flo's Friendly Foods        1     <NA>
    ## 2  Flo's Friendly Foods        1     <NA>
    ## 3  Flo's Friendly Foods        1     <NA>
    ## 4  Flo's Friendly Foods        1     <NA>
    ## 5  Flo's Friendly Foods        1     <NA>
    ## 6  Flo's Friendly Foods        1     <NA>
    ## 7  Flo's Friendly Foods        1     <NA>
    ## 8  Flo's Friendly Foods        1     <NA>
    ## 9  Flo's Friendly Foods        1     <NA>
    ## 10 Flo's Friendly Foods        1     <NA>

Pretty gnarly, right? I mean, fruit is considered an *addon* to your child's order of *please choose a side*? It's convoluted and nonsensical to say the least, and that's just one example. This is what raw data is often like, and without competent data wrangling, it can be flat-out unusable.

### The basics of dplyr

dplyr breaks everything down into 5 primary functions that can be used to solve the majority of your data wrangling problems.

`select()` selects only the columns you specify<br> `filter()` filters the data to include cases that fit the criteria you specify<br> `arrange()` changes the order of the rows<br> `mutate()` adds new variables that are functions of existing variables<br> `summarise()` summarises the values to a single value

Finally, the almighty pipe operator `%>%` provides an intuitive way of chaining multiple dplyr commands together.

These 5 functions are very simple and straightforward and I will now use them to clean up our data.

``` r
#Many of the variables included in the raw data are irrelevant.
#We can use select() to select the useful ones

data.1 <- data %>%
  select(c(2, 3, 7, 9))

head(data.frame(data.1), 10)
```

    ##                 Campus                  Name                   Item
    ## 1  Blue Jays and Doves          Mal Brown IV   Please Choose a Side
    ## 2  Blue Jays and Doves         Dominic Carey   Please Choose a Side
    ## 3  Blue Jays and Doves         Victor Powers   Please Choose a Side
    ## 4  Blue Jays and Doves         Victor Powers      Chicken Chow Mein
    ## 5  Blue Jays and Doves          Mal Brown IV      Chicken Chow Mein
    ## 6  Blue Jays and Doves         Dominic Carey   Vegetarian Chow Mein
    ## 7              Encinal              Uta Tsai   Vegetarian Chow Mein
    ## 8              Encinal     Ziyaan Fitzgerald      Chicken Chow Mein
    ## 9              Encinal Will Hoadley-Wetstone Hamburger with Ketchup
    ## 10      GISSV Berkeley         Reijker Moore Hamburger with Ketchup
    ##                                                               Addons
    ## 1                                       (1) --- Seasonal Fruit Salad
    ## 2                                       (1) --- Seasonal Fruit Salad
    ## 3                                                                 --
    ## 4                                                                 --
    ## 5                                                                 --
    ## 6                                                                 --
    ## 7                                                                 --
    ## 8                                                                 --
    ## 9  (1) --- GLUTEN FREE BUN\n\n(1) --- Tomato\n\n(1) --- Salad Greens
    ## 10                                                                --

``` r
#Now that we are working with fewer variables, let's use filter()
#to select only the cases where the parent orders a side for their child.

data.2 <- data.1 %>%
  filter(Item == "Please Choose a Side")
head(data.frame(data.2), 10)
```

    ##                     Campus            Name                 Item
    ## 1      Blue Jays and Doves    Mal Brown IV Please Choose a Side
    ## 2      Blue Jays and Doves   Dominic Carey Please Choose a Side
    ## 3      Blue Jays and Doves   Victor Powers Please Choose a Side
    ## 4  Quails and Hummingbirds  Colton Ruecker Please Choose a Side
    ## 5  Quails and Hummingbirds     DD Henfield Please Choose a Side
    ## 6  Quails and Hummingbirds  Caroline Baird Please Choose a Side
    ## 7  Quails and Hummingbirds     Adalyn Chen Please Choose a Side
    ## 8  Quails and Hummingbirds     Noella Chen Please Choose a Side
    ## 9      Robins and Sparrows Weston Gottlieb Please Choose a Side
    ## 10     Robins and Sparrows Cadence Kienitz Please Choose a Side
    ##                                Addons
    ## 1        (1) --- Seasonal Fruit Salad
    ## 2        (1) --- Seasonal Fruit Salad
    ## 3                                  --
    ## 4                                  --
    ## 5        (1) --- Seasonal Fruit Salad
    ## 6                                  --
    ## 7        (1) --- Seasonal Fruit Salad
    ## 8        (1) --- Seasonal Fruit Salad
    ## 9  (1) --- Celery with Sun Nut Butter
    ## 10       (1) --- Seasonal Fruit Salad

``` r
#So we've narrowed the data to only include side orders.
#We will use arrange() to order the Addons column alphabetically

data.3 <- data.2 %>%
  arrange(Addons)

head(data.frame(data.3), 10)
```

    ##                     Campus            Name                 Item
    ## 1      Blue Jays and Doves   Victor Powers Please Choose a Side
    ## 2  Quails and Hummingbirds  Colton Ruecker Please Choose a Side
    ## 3  Quails and Hummingbirds  Caroline Baird Please Choose a Side
    ## 4      Robins and Sparrows    Cody Enomoto Please Choose a Side
    ## 5      Robins and Sparrows Weston Gottlieb Please Choose a Side
    ## 6      Robins and Sparrows   Alexis Byrnes Please Choose a Side
    ## 7      Robins and Sparrows    Ari Fassluke Please Choose a Side
    ## 8      Blue Jays and Doves    Mal Brown IV Please Choose a Side
    ## 9      Blue Jays and Doves   Dominic Carey Please Choose a Side
    ## 10 Quails and Hummingbirds     DD Henfield Please Choose a Side
    ##                                                     Addons
    ## 1                                                       --
    ## 2                                                       --
    ## 3                                                       --
    ## 4                                                       --
    ## 5                       (1) --- Celery with Sun Nut Butter
    ## 6  (1) --- Organic Shredded Carrots with Organic Ranch Dip
    ## 7  (1) --- Organic Shredded Carrots with Organic Ranch Dip
    ## 8                             (1) --- Seasonal Fruit Salad
    ## 9                             (1) --- Seasonal Fruit Salad
    ## 10                            (1) --- Seasonal Fruit Salad

``` r
#With this we have all the different side orders grouped together.
#The names are quite confusing. Let's use mutate() to create a new
#variable called 'Side' to differentiate it from the other addons.
#Then we can use select() again to get rid of the Addons and Item 
#columns as they are no longer needed

data.4 <- data.3 %>%
  mutate("Side" = Addons) %>%
  select(c(1, 2, 5))

head(data.frame(data.4), 10)
```

    ##                     Campus            Name
    ## 1      Blue Jays and Doves   Victor Powers
    ## 2  Quails and Hummingbirds  Colton Ruecker
    ## 3  Quails and Hummingbirds  Caroline Baird
    ## 4      Robins and Sparrows    Cody Enomoto
    ## 5      Robins and Sparrows Weston Gottlieb
    ## 6      Robins and Sparrows   Alexis Byrnes
    ## 7      Robins and Sparrows    Ari Fassluke
    ## 8      Blue Jays and Doves    Mal Brown IV
    ## 9      Blue Jays and Doves   Dominic Carey
    ## 10 Quails and Hummingbirds     DD Henfield
    ##                                                       Side
    ## 1                                                       --
    ## 2                                                       --
    ## 3                                                       --
    ## 4                                                       --
    ## 5                       (1) --- Celery with Sun Nut Butter
    ## 6  (1) --- Organic Shredded Carrots with Organic Ranch Dip
    ## 7  (1) --- Organic Shredded Carrots with Organic Ranch Dip
    ## 8                             (1) --- Seasonal Fruit Salad
    ## 9                             (1) --- Seasonal Fruit Salad
    ## 10                            (1) --- Seasonal Fruit Salad

``` r
#Finally, let's use summarise() to display the sides with more
#reasonable names.
```
