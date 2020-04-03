load_data <-
  function(url, ccaa_code = NULL) {
    corona <-
      vroom(url,
        col_types = list(
          date = col_date(format = "%d/%m/%Y"),
          ccaa = "c",
          cases = "d",
          hospitalised = "d",
          icu = "d",
          deaths = "d",
          released = "d"
        ),
        col_names = c("ccaa", "date", "cases", "hospitalised", "icu", "deaths", "released")
      )


    corona <- corona[2:nrow(corona), ]

    if (is.null(ccaa_code)) {
      corona <- aggregate(corona["cases"], corona["date"], sum)
    } else {
      corona <- aggregate(
        filter(corona, ccaa == ccaa_code)["cases"],
        filter(corona, ccaa == ccaa_code)["date"],
        sum
      )
    }

    corona <-
      corona %>%
      mutate(daily_cases = cases - lag(cases)) %>%
      filter(!is.na(daily_cases), daily_cases > 10)

    tibble(corona)
  }

