#########################################
#Functions for hw04
#########################################

#Function remove_missing()
remove_missing <- function(x) {
  x <- x[!is.na(x)]
  return(x)
}
a <- c(1, 4, 7, NA, 10)
remove_missing(a)

b <- c(1, 4, 7, NA, 10, 13, 16, NA, 19, NA, 22, NA)
remove_missing(b)

#Function get_minimum()
get_minimum <- function(x, na.rm = FALSE) {
  if (na.rm == TRUE) {
    x <- remove_missing(x)
    x <- sort(x)
  return(x[1])
  } else {
    x <- sort(x)
    return(x[1])
  }
}

c <- c(NA, NA, 4, 5, 1, NA)
get_minimum(c, na.rm = TRUE)

#Function get_maximum()
get_maximum <- function(x, na.rm = FALSE) {
  if (na.rm == TRUE) {
    x <- remove_missing(x)
    x <- sort(x, decreasing = TRUE)
    return(x[1])
  } else {
    x <- sort(x, decreasing = TRUE)
    return(x[1])
  }
}

c <- c(NA, NA, 4, 5, 1, NA)
get_maximum(c, na.rm = TRUE)

#Function get_range()
get_range <- function(x) {
  get_maximum(x, na.rm = TRUE) - get_minimum(x, na.rm = TRUE)
}

get_range(c)

#Function get_median()
get_median <- function(x, na.rm = FALSE) {
  if (na.rm == TRUE) {
    x <- remove_missing(x)
    x <- sort(x)
    if (length(x) %% 2 == 1) {
      return(x[(length(x)/2) + 0.5])
    } else {
      return((x[(length(x)/2)] + x[(length(x)/2) + 1])/2)
    }
  } else {
    x <- sort(x)
    if (length(x) %% 2 == 1) {
      return(x[(length(x)/2) + 0.5])
    } else {
      return((x[(length(x)/2)] + x[(length(x)/2) + 1])/2)
    }
  }
}

get_median(a, na.rm = TRUE)

#Function get_average()
get_average <- function(x, na.rm = FALSE) {
  if(na.rm == TRUE) {
    x <- remove_missing(x)
    j <- 0
    for (i in 1:length(x)) {
      j <- j + x[i]
    }
    return(j/length(x))
  } else {
    j <- 0
    for (i in 1:length(x)) {
      j <- j + x[i]
    }
    return(j/length(x))
  }
}

get_average(a, na.rm = TRUE)

#Function get_stdev()
get_stdev <- function(x, na.rm = FALSE) {
  if(na.rm == TRUE) {
    x <- remove_missing(x)
    m <- get_average(x)
    k <- 0
    for (i in 1:length(x)) {
      k <- k + (x[i] - get_average(x))^2
    }
    return(sqrt(k/(length(x)-1)))
  } else {
    m <- get_average(x)
    k <- 0
    for (i in 1:length(x)) {
      k <- k + (x[i] - get_average(x))^2
    }
    return(sqrt(k/(length(x)-1)))
  }
}

get_stdev(a, na.rm = TRUE)

#Function get_quartile1()
get_quartile1 <- function(x, na.rm = FALSE) {
  if (na.rm == TRUE) {
    x <- remove_missing(x)
    return((quantile(x, 1/4))[[1]])
  } else {
    return((quantile(x, 1/4))[[1]])
  }
}

get_quartile1(a, na.rm = TRUE)

#Function get_quartile3()
get_quartile3 <- function(x, na.rm = FALSE) {
  if (na.rm == TRUE) {
    x <- remove_missing(x)
    return((quantile(x, 3/4))[[1]])
  } else {
    return((quantile(x, 3/4))[[1]])
  }
}

get_quartile3(a, na.rm = TRUE)

#Function count_missing()
count_missing <- function(x) {
  count <- 0
  for (i in 1:length(x)) {
    if (is.na(x[i]) == TRUE) {
      count <- count + 1
    }
  }
  return(count)
}

count_missing(b)

#Function summary_stats()
summary_stats <- function(x) {
  as.list(c("minimum" = get_minimum(x, na.rm = TRUE),
            "quartile1" = get_quartile1(x, na.rm = TRUE),
            "median" = get_median(x, na.rm = TRUE),
            "mean" = get_average(x, na.rm = TRUE),
            "quartile3" = get_quartile3(x, na.rm = TRUE),
            "maximum" = get_maximum(x, na.rm = TRUE),
            "range" = get_range(x),
            "stdev" = get_stdev(x, na.rm = TRUE),
            "missing" = count_missing(x)))
}

summary_stats(a)

#Function print_stats()

#Function rescale100()
rescale100 <- function(x, xmin, xmax) {
  100 * (x - xmin)/(xmax - xmin)
}

d <- c(18, 15, 16, 4, 17, 9)
rescale100(d, xmin = 0, xmax = 20)

#Function drop_lowest()
drop_lowest <- function(x) {
  min <- get_minimum(x)
  x <- x[-min]
  x
}

drop_lowest(d)

#Function score_homework()
score_homework <- function(hws, drop = FALSE) {
  if (drop == TRUE) {
    hws <- drop_lowest(hws)
    return(get_average(hws))
  } else {
    return(get_average(hws))
  }
}

hws <- c(100, 80, 30, 70, 75, 85)

score_homework(hws, drop = TRUE)
score_homework(hws, drop = FALSE)

#Function score_quiz()
score_quiz <- function(quizzes, drop = FALSE) {
  if (drop == TRUE) {
    quizzes <- drop_lowest(quizzes)
    return(get_average(quizzes))
  } else {
    return(get_average(quizzes))
  }
}

quizzes <- c(100, 80, 70, 0)

score_quiz(quizzes, drop = TRUE)
score_quiz(quizzes, drop = FALSE)

#Function score_lab()
score_lab <- function(x) {
  if (x == 12) {
    print(100)
  } else if (x == 11) {
    print(100)
  } else if (x == 10) {
    print(80)
  } else if (x == 9) {
    print(60)
  } else if (x == 8) {
    print(40)
  } else if (x == 7) {
    print(20)
  } else {
    print(0)
  }
}

score_lab(12)
score_lab(10)
score_lab(6)


