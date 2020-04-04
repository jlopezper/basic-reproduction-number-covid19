truncated_normal_model <- 
  function(cases, dates) {
    # set initial configuration
    config <- make_config(list(mean_si = 3.96, std_mean_si = 2,
                               min_mean_si = 1, max_mean_si = 6,
                               std_si = 4.75, std_std_si = 1,
                               min_std_si = 2.5, max_std_si = 6
    ))
    
    
    # run defined model
    # model specs can be checked in the docs
    res_uncertain_si <- estimate_R(cases,
                                   method = "uncertain_si",
                                   config = config)
    
    # create data.farme with mean and quantiles 
    # in order to create credible intervals
    df <- 
      tibble::tibble(
        R = res_uncertain_si$R$`Mean(R)`,
        lower_5 = res_uncertain_si$R$`Quantile.0.025(R)`,
        upper_5 = res_uncertain_si$R$`Quantile.0.975(R)`,
        lower_10 = res_uncertain_si$R$`Quantile.0.05(R)`,
        upper_10 = res_uncertain_si$R$`Quantile.0.95(R)`,
        date = as.Date(dates[res_uncertain_si$R$t_start])
      )
    
    df
  }





plot_model <- 
  function(data_, ccaa_code) {
    last_value <- slice(.data = data_, which.max(data_$date))
    
    p <-
      data_ %>% 
      ggplot(aes(date)) +
      geom_ribbon(aes(ymin = lower_5, ymax = upper_5), fill = "grey", alpha = .4) +
      geom_ribbon(aes(ymin = lower_10, ymax = upper_10), fill = "grey", alpha = .6) +
      geom_line(aes(y = R), alpha = 0.6, size = 1) +
      geom_point(data = last_value, aes(x = date, y = R), col = "black", shape = 21, fill = "white", size = 1.2, stroke = 1) +
      #geom_text(data = last_value, aes(x = date, y = R, label = sprintf("%0.2f", round(R, digits = 2))), size = 4, hjust = -.12, vjust = 0.3) +
      theme_minimal() +
      # annotate("text", x = as.Date('2020-03-16'), y = 1.08, label = "Infección se expande", color = 'red', size = 3) +
      # annotate("text", x = as.Date('2020-03-16'), y = 0.92, label = "Infección se contrae", color = 'red',  size = 3) +
      # annotate("text", x = as.Date('2020-03-15'), y = 3.5, label = "Estado de alarma", color = 'darkblue', size = 3) +
      ylim(0, ceiling(max(data_$upper_5))) +
      geom_hline(
        yintercept = 1, linetype = "longdash",
        color = "red", 
        size = .5,
        alpha = .5
      ) +
      # geom_vline(
      #   xintercept = as.Date('2020-03-14'), 
      #   linetype = "dotted",
      #   color = "darkblue", size = .5
      # ) + 
      scale_x_date(date_breaks = "3 day", date_labels = "%d %b") +
      labs(title = paste0("Evolución del número básico reproductivo en ", iso_codes[[ccaa_code]]),
           caption = 'Fuente: ISCIII. Elaboración: @jlopezper',
           x = "Fecha",
           subtitle = "Distribución normal truncada con media ~ N(3.96, 2) truncada en (1, 6) y desviación típica ~ N(4.75, 1) truncada en (2.5, 6)") +
      theme(
        plot.title = element_text(size = 18),
        plot.subtitle = element_text(size = 12),
        axis.text = element_text(size = 14),
        axis.title = element_text(size = 14),
        axis.text.x = element_text(angle = 0, hjust = 1)
      ) 
    
    p
  }




save_plot <- 
  function(plot, ccaa_code = NULL) {
    if (!dir.exists(here('plots'))){
      dir.create(here('plots'))
    }
    
    if (is.null(ccaa_code)) ccaa_code <- "all"
    ggsave(plot = plot, filename = here("plots", paste0("basic_reproduction_number_", ccaa_code, ".png")), width = 10, height = 7)
  }


