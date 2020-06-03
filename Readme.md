# < Facebook Comment Volume Analysis >

### Groups
* < 蔡漢龍, 107753006 >
* < 林賦安, 103703042 >
* < 方品謙, 105304028 >
* < 杜明軒, 105304032 >
* < 徐安安, 105304045 >

### Goal
分析Facebook 貼文資料集，目的希望能建立預測留言數量的模型，並且用於評估貼文成效好壞。
### Demo 
```R
Rscript model_rf.R --data data.csv
```
* Shiny App Link:https://mulderfang.shinyapps.io/shinyapp/

## Folder organization and its related information

### docs
* Your presentation, 1072_datascience_FP_<yourID|groupName>.ppt/pptx/pdf, by **Jun. 25**
* Any related document for the final project
  * papers
  * software user guide

### data

* Source(from UCI):
http://archive.ics.uci.edu/ml/datasets/Facebook+Comment+Volume+Dataset?fbclid=IwAR3s-QeEUKL4pzURY_CL6KK8x3yoUQQZaJztk2V3wNenQHLlI5xflSNHAxU

* Input format:.csv
* Data preprocessing:
  * Feture Selection
  * Feature Classification

### code

* method: Random Forests
* How do your perform evaluation? >>Cross-validation

### results

* Which metric do you use : Accuracy only (Since our data is balanced among different categories)
* Our improvement is not significant but with more applicability. 
* What is the challenge part of your project?
  * The original data is messy and exists lots of missing value, and our target variable(comments) is widely distributed
  * It's not that difficult to build a model to predict any variables in our dataset, but we think to make the conclusion applicable is the point.

## Reference
* Code/implementation which you include/reference 
* Packages you use
caret/randomForest/shiny/ggbiplot/shinythemes/shinydashboard/tibble/dplyr/highcharter/DT/lubridate/tidyr/shinyWidgets/tychobratools/openxlsx/ggplot2
* Related publications


