plan <- drake_plan(
  # Load data
  corona_data = map(names(iso_codes),
                    ~load_data(url = "https://covid19.isciii.es/resources/serie_historica_acumulados.csv", ccaa_code = .)),
  
  # Run truncated normal model
  model_data = map(corona_data, ~truncated_normal_model(.$daily_cases, dates = .$date)),
  
  # Make plots
  make_plots = map2(model_data, names(iso_codes), ~plot_model(data_ = .x, ccaa_code = .y)),
  
  # Save plot
  save_plots =  map2(make_plots, names(iso_codes), ~save_plot(plot = .x, ccaa_code = .y))
  
)


