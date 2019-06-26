library(officer)
library(magrittr)
library(tidyverse)
library(devEMF)
library(ggplot2)
library(flextable)

read_pptx() %>% 
  add_slide(layout = "Title and Content", master = "Office Theme") %>% 
  ph_with(value = "Brewry Concentrations in US", location = ph_location_type(type = "title")) %>%
  ph_with(external_img(src = filename, width = 8, height = 4.5), 
          #location = ph_location_type(type = "body"), use_loc_size = TRUE ) %>% 
          location = ph_location(left = 1, top = 2, width = 8, height = 4.5)) %>% 
  add_slide(layout = "Title Only", master = "Office Theme") %>% 
  ph_with(external_img(src = filename, width = 10, height = 6), 
          location = ph_location(left = 0, top = 2, width = 10, height = 6) ) %>% 
  print(target = "demo_emf.pptx")

#Read baseline PowerPoint file
my_pres <- read_pptx('presentation.pptx') 
view(layout_summary(my_pres))
view(layout_properties(my_pres))
#create title slide


myftr<-"Copyright Blake and Schwan 2019"

# Graphic Slide
filename = "IBU.jpg"
my_pres <- add_slide(x=my_pres, layout = "Title and Content", master = "Office Theme") %>% 
  ph_with(value = "Brewry Concentrations in US", location = ph_location_type(type = "title")) %>%
  ph_with(external_img(src = filename, width = 8, height = 4.5), 
          location = ph_location(left = 1, top = 2, width = 8, height = 4.5)) 
my_pres <- add_slide(x=my_pres, layout = "Title and Content", master = "Office Theme") %>% 
  ph_with(value = "Brewry Concentrations in US", location = ph_location_type(type = "title")) %>%
  ph_with(value = 'ft', location = ph_location_type(type = "body"))
    # Print to save powerpoint
  extension <- format(Sys.time(),'%b%d%H%M%S')
  print(my_pres, target = paste(".\\test", extension, "v2.pptx", sep='') )

  # ggplot example
  gg <- ggplot(mtcars, aes(x = mpg , y = wt, colour = qsec)) + geom_point() + theme_minimal()
  
  # produce an emf file containing the ggplot
  filename <- tempfile(fileext = ".emf")
  
  emf(file = 'demo', width = 6, height = 7)
  print(gg)
  dev.off()
  
#Table slide
  data = structure(list(Status = c("Alive", "Alive", "Alive", "Alive","Melanoma", "Melanoma","Melanoma", "Melanoma", "Non-melanoma","Non-melanoma", "Non-melanoma", "Non-melanoma"), Gender = c("Female","Female", "Male", "Male", "Female", "Female", "Male", "Male","Female", "Female", "Male", "Male"), Ulceration = c("Absent","Present", "Absent", "Present", "Absent", "Present", "Absent","Present", "Absent", "Present", "Absent", "Present"), n = c(68L,23L, 24L, 19L, 8L, 20L, 8L, 21L, 3L, 4L, 4L, 3L), Mean = c(1.693,2.972, 1.468, 4.319, 2.139, 4.724, 3.266, 5.143, 1.667, 3.302,2.42, 8.053), SD = c(2.004, 2.593, 1.719, 2.423, 1.184, 4.128,4.681, 2.862, 1.141, 3.713, 2.499, 4.019)), class = "data.frame", .Names = c("Status","Gender", "Ulceration", "n", "Mean", "SD"), row.names = c(NA,-12L))
  data
  ft <- flextable(data = data) %>% 
    theme_booktabs() %>% 
    set_header_labels( n = "#", Mean = "\u03D1", SD = "\u03C3") %>% 
    color(i = ~ n < 4, color = "wheat") %>% 
    autofit() 
  read_pptx() %>% 
    # add_slide(layout = "Title and Content", master = "Office Theme") %>% 
    # ph_with(ft, location = ph_location_type(type = "body")) %>% 
    add_slide(layout = "Title Only", master = "Office Theme") %>% 
    ph_with(ft, location = ph_location(left = 3, top = 3)) %>% 
    print(target = "flextable.pptx")
  
  
  
  
  # This code produces a custom Powerpoint generating slides with data calculated and plotted above
  
  ```{r generation of PowerPoint slides, echo=TRUE}
  
  #Read baseline PowerPoint file
  my_pres <- read_pptx('presentation.pptx') 
  #view(layout_summary(my_pres))
  #view(layout_properties(my_pres))
  
  # States with the most brewries
  my_pres <- add_slide(x=my_pres, layout = "Title and Content", master = "Office Theme") %>%
    ph_with(value = "States With the Most Breweries", location = ph_location(left = 3, top = .5, width = 8, height = 1)) %>%
    ph_with_table_at(value = top_brewstate,
                     height = 5, width = 8, left = 3, top = 2,
                     last_row = FALSE, last_column = FALSE, first_row = TRUE)
  
  filename = "IBU.jpg"
  my_pres <- add_slide(x=my_pres, layout = "Title and Content", master = "Office Theme") %>% 
    ph_with(value = "Brewry Concentrations in US", location = ph_location(left = 3, top = .5, width = 8, height = 1)) %>%
    ph_with(external_img(src = filename, width = 8, height = 4.5), 
            location = ph_location(left = 3, top = 2, width = 8, height = 4.5)) 
  
  
  
  # Print to save powerpoint
  extension <- format(Sys.time(),'%b%d%H%M%S')
  print(my_pres, target = paste(".\\test", extension, "v2.pptx", sep='') )
  
  
  ```