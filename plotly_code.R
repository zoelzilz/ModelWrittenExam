library(plotly)
library(calecopal)

# plot????
sp1_plot <- plot_ly(data = eq_rg, x = ~rho_store1, y = ~zeta_store1, z = ~tau_store1, color = ~as.integer(N1eq_rg),
                    colors = c(cal_palette(name = "bigsur", type = "continuous"))) %>%
  add_markers()
sp1_plot

#c('#DAF7A6', '#FF5733', '#900C3F')
sp2_plot <- plot_ly(data = eq_rg, x = ~rho_store2, y = ~zeta_store2, z = ~tau_store2, color = ~as.integer(N2eq_rg), 
                    colors = c(cal_palette(name = "lake", type = "continuous"))) %>% 
  add_markers()
sp2_plot

spp_plot <- plot_ly(data = eq_rg, x = ~rho_ratio, y = ~zeta_ratio, z = ~tau_ratio, color = ~eq_ratio, colors = c("#EDEDED", "#0073DA")) %>% 
  add_markers()
spp_plot