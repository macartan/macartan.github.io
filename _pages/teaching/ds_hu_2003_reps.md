---
title: "Development strategies: replication starter kits"
output: 
  html_document:
    code_folding: hide
    toc: true
    toc_depth: 2
    toc_float: true
    keep_md: yes
date: "2023-05-09"
bibliography: bib.bib
---




#   {.tabset}

This page provides starter code for replication of the following readings: https://macartan.github.io/teaching/ds-hu-2023#3-the-readings

## Macro processes  {.tabset}

The first readings focus on longer term historical processes and on order and violence. They include studies of the impact of slavery and colonization and studies of the drivers of civil conflict and democratization.

### AJR

@acemoglu2001colonial

Main result is in  Table 4:


```r
ajr_data_4 <- haven::read_dta("1_1_acemoglu_johnson_robinson/in/maketable4.dta")


ajr_table_4 <- 
  list(
 base_1 = iv_robust(logpgp95 ~ avexpr | logem4, data = filter(ajr_data_4, baseco == 1)),
 base_2 = iv_robust(logpgp95 ~ avexpr + lat_abst | logem4 + lat_abst, data = filter(ajr_data_4, baseco == 1))
 )

htmlreg(ajr_table_4)
```

<table class="texreg" style="margin: 10px auto;border-collapse: collapse;border-spacing: 0px;caption-side: bottom;color: #000000;border-top: 2px solid #000000;">
<caption>Statistical models</caption>
<thead>
<tr>
<th style="padding-left: 5px;padding-right: 5px;">&nbsp;</th>
<th style="padding-left: 5px;padding-right: 5px;">base_1</th>
<th style="padding-left: 5px;padding-right: 5px;">base_2</th>
</tr>
</thead>
<tbody>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">(Intercept)</td>
<td style="padding-left: 5px;padding-right: 5px;">1.91</td>
<td style="padding-left: 5px;padding-right: 5px;">1.69</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.52; 4.34]</td>
<td style="padding-left: 5px;padding-right: 5px;">[-1.34; 4.73]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">avexpr</td>
<td style="padding-left: 5px;padding-right: 5px;">0.94<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">1.00<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 0.58; 1.31]</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 0.49; 1.50]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">lat_abst</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.65</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-3.24; 1.95]</td>
</tr>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.19</td>
<td style="padding-left: 5px;padding-right: 5px;">0.10</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Adj. R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.17</td>
<td style="padding-left: 5px;padding-right: 5px;">0.07</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Num. obs.</td>
<td style="padding-left: 5px;padding-right: 5px;">64</td>
<td style="padding-left: 5px;padding-right: 5px;">64</td>
</tr>
<tr style="border-bottom: 2px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">RMSE</td>
<td style="padding-left: 5px;padding-right: 5px;">0.95</td>
<td style="padding-left: 5px;padding-right: 5px;">1.00</td>
</tr>
</tbody>
<tfoot>
<tr>
<td style="font-size: 0.8em;" colspan="3"><sup>&#42;</sup> Null hypothesis value outside the confidence interval.</td>
</tr>
</tfoot>
</table>



### FL

@fearon2003ethnicity

The data is in dataverse but the original code is not there. The original code for Table 1 in stata is short and I have saved it here:


```r
/* .do File to produce Table 1 results from replication data set */

use repdata ,clear

/* Model #1 */
logit onset warl gdpenl lpopl lmtnest ncontig Oil nwstate instab polity2l ethfrac relfrac ,nolog

/* Model #2 */
logit ethonset warl gdpenl lpopl lmtnest ncontig Oil nwstate instab polity2l ethfrac relfrac if second > .049999,nolog

/* Model #3 */
logit onset warl gdpenl lpopl lmtnest ncontig Oil nwstate instab anocl deml ethfrac relfrac ,nolog

/* Model #4 */
logit emponset empwarl empgdpenl emplpopl emplmtnest empncontig Oil nwstate instab empethfrac ,nolog

/* Model #5 */
logit cowonset cowwarl gdpenl lpopl lmtnest ncontig Oil nwstate instab anocl deml ethfrac relfrac ,nolog
```


Main result is in  Table 4:


```r
fl_data <- haven::read_dta("1_2_fearon_laitin/in/repdata.dta")

# One odd observation, Russia 1947
# with(fl_data, table(onset, ethonset))

fl_data <- fl_data |>
  mutate(onset =ifelse(onset ==4, 1, onset),
         ethonset =ifelse(ethonset ==4, 1, ethonset))

fl_table_1 <- 
  list(
 all =  glm(onset ~ warl +  gdpenl +  lpopl1  + lmtnest  + ncontig  + Oil  + nwstate  + instab  + 
              polity2l  + ethfrac  + relfrac, 
            data = fl_data, family = 'binomial'),
 ethnic =  glm(ethonset ~ warl +  gdpenl +  lpopl1  + lmtnest  + ncontig  + Oil  + nwstate  + instab  + 
                 polity2l  + ethfrac  + relfrac, 
               data = fl_data |> filter(second > 0.049999), family = 'binomial')
 )

htmlreg(fl_table_1)
```

<table class="texreg" style="margin: 10px auto;border-collapse: collapse;border-spacing: 0px;caption-side: bottom;color: #000000;border-top: 2px solid #000000;">
<caption>Statistical models</caption>
<thead>
<tr>
<th style="padding-left: 5px;padding-right: 5px;">&nbsp;</th>
<th style="padding-left: 5px;padding-right: 5px;">all</th>
<th style="padding-left: 5px;padding-right: 5px;">ethnic</th>
</tr>
</thead>
<tbody>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">(Intercept)</td>
<td style="padding-left: 5px;padding-right: 5px;">-6.73<sup>&#42;&#42;&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">-8.45<sup>&#42;&#42;&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.74)</td>
<td style="padding-left: 5px;padding-right: 5px;">(1.09)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">warl</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.95<sup>&#42;&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">-0.85<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.31)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.39)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">gdpenl</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.34<sup>&#42;&#42;&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">-0.38<sup>&#42;&#42;&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.07)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.10)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">lpopl1</td>
<td style="padding-left: 5px;padding-right: 5px;">0.26<sup>&#42;&#42;&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.39<sup>&#42;&#42;&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.07)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.11)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">lmtnest</td>
<td style="padding-left: 5px;padding-right: 5px;">0.22<sup>&#42;&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.12</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.08)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.11)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">ncontig</td>
<td style="padding-left: 5px;padding-right: 5px;">0.44</td>
<td style="padding-left: 5px;padding-right: 5px;">0.48</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.27)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.40)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Oil</td>
<td style="padding-left: 5px;padding-right: 5px;">0.86<sup>&#42;&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.81<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.28)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.35)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">nwstate</td>
<td style="padding-left: 5px;padding-right: 5px;">1.71<sup>&#42;&#42;&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">1.78<sup>&#42;&#42;&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.34)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.41)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">instab</td>
<td style="padding-left: 5px;padding-right: 5px;">0.62<sup>&#42;&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.38</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.24)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.32)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">polity2l</td>
<td style="padding-left: 5px;padding-right: 5px;">0.02</td>
<td style="padding-left: 5px;padding-right: 5px;">0.01</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.02)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.02)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">ethfrac</td>
<td style="padding-left: 5px;padding-right: 5px;">0.17</td>
<td style="padding-left: 5px;padding-right: 5px;">0.15</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.37)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.58)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">relfrac</td>
<td style="padding-left: 5px;padding-right: 5px;">0.29</td>
<td style="padding-left: 5px;padding-right: 5px;">1.53<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.51)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.72)</td>
</tr>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">AIC</td>
<td style="padding-left: 5px;padding-right: 5px;">984.80</td>
<td style="padding-left: 5px;padding-right: 5px;">630.35</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">BIC</td>
<td style="padding-left: 5px;padding-right: 5px;">1065.83</td>
<td style="padding-left: 5px;padding-right: 5px;">709.00</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Log Likelihood</td>
<td style="padding-left: 5px;padding-right: 5px;">-480.40</td>
<td style="padding-left: 5px;padding-right: 5px;">-303.18</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Deviance</td>
<td style="padding-left: 5px;padding-right: 5px;">960.80</td>
<td style="padding-left: 5px;padding-right: 5px;">606.35</td>
</tr>
<tr style="border-bottom: 2px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">Num. obs.</td>
<td style="padding-left: 5px;padding-right: 5px;">6327</td>
<td style="padding-left: 5px;padding-right: 5px;">5186</td>
</tr>
</tbody>
<tfoot>
<tr>
<td style="font-size: 0.8em;" colspan="3"><sup>&#42;&#42;&#42;</sup>p &lt; 0.001; <sup>&#42;&#42;</sup>p &lt; 0.01; <sup>&#42;</sup>p &lt; 0.05</td>
</tr>
</tfoot>
</table>


### Nunn

@nunn2008long

The Nunn archive includes data but not replication code.

#### OLS


```r
df_Nunn_2008 <-  haven::read_dta("1_3_Nunn/in/slave_trade_QJE.dta") 


nunn_table_2 <-
  list(base = 
         lm_robust(ln_maddison_pcgdp2000~ ln_export_area + colony1 + colony2 +colony3+colony4+colony5 + colony6 + colony7,
          data = df_Nunn_2008, se_type = "stata"),
       controls = 
         lm_robust(ln_maddison_pcgdp2000~ ln_export_area +  colony1 + colony2 +colony3+colony4+colony5 + colony6  + colony7+
                      abs_latitude + longitude + rain_min + humid_max + low_temp +  ln_coastline_area,
          data = df_Nunn_2008, se_type = "stata"))


htmlreg(nunn_table_2)
```

<table class="texreg" style="margin: 10px auto;border-collapse: collapse;border-spacing: 0px;caption-side: bottom;color: #000000;border-top: 2px solid #000000;">
<caption>Statistical models</caption>
<thead>
<tr>
<th style="padding-left: 5px;padding-right: 5px;">&nbsp;</th>
<th style="padding-left: 5px;padding-right: 5px;">base</th>
<th style="padding-left: 5px;padding-right: 5px;">controls</th>
</tr>
</thead>
<tbody>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">(Intercept)</td>
<td style="padding-left: 5px;padding-right: 5px;">7.22<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">5.94<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 6.91;  7.52]</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 4.24;  7.65]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">ln_export_area</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.11<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">-0.08<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.17; -0.06]</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.13; -0.02]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">colony1</td>
<td style="padding-left: 5px;padding-right: 5px;">0.36<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.84<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 0.06;  0.66]</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 0.09;  1.59]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">colony2</td>
<td style="padding-left: 5px;padding-right: 5px;">0.31</td>
<td style="padding-left: 5px;padding-right: 5px;">0.77</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.01;  0.63]</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.13;  1.66]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">colony3</td>
<td style="padding-left: 5px;padding-right: 5px;">0.21</td>
<td style="padding-left: 5px;padding-right: 5px;">0.45</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.18;  0.60]</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.38;  1.28]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">colony4</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.89<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.08</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-1.24; -0.54]</td>
<td style="padding-left: 5px;padding-right: 5px;">[-1.14;  1.30]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">colony5</td>
<td style="padding-left: 5px;padding-right: 5px;">1.66<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">2.14<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 1.30;  2.01]</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 1.16;  3.12]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">colony6</td>
<td style="padding-left: 5px;padding-right: 5px;">0.86<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">1.34<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 0.48;  1.24]</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 0.41;  2.27]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">colony7</td>
<td style="padding-left: 5px;padding-right: 5px;">0.72<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.75</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 0.50;  0.93]</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.07;  1.57]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">abs_latitude</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.02</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.02;  0.05]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">longitude</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.00</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.01;  0.01]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">rain_min</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.00</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.02;  0.02]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">humid_max</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.01</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.01;  0.03]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">low_temp</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.02</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.08;  0.04]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">ln_coastline_area</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.08<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 0.01;  0.16]</td>
</tr>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.50</td>
<td style="padding-left: 5px;padding-right: 5px;">0.60</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Adj. R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.41</td>
<td style="padding-left: 5px;padding-right: 5px;">0.45</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Num. obs.</td>
<td style="padding-left: 5px;padding-right: 5px;">52</td>
<td style="padding-left: 5px;padding-right: 5px;">52</td>
</tr>
<tr style="border-bottom: 2px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">RMSE</td>
<td style="padding-left: 5px;padding-right: 5px;">0.63</td>
<td style="padding-left: 5px;padding-right: 5px;">0.61</td>
</tr>
</tbody>
<tfoot>
<tr>
<td style="font-size: 0.8em;" colspan="3"><sup>&#42;</sup> Null hypothesis value outside the confidence interval.</td>
</tr>
</tfoot>
</table>

#### First stage:


```r
lm_robust(ln_export_area ~ atlantic_distance_minimum + indian_distance_minimum + saharan_distance_minimum + red_sea_distance_minimum ,
          data = df_Nunn_2008, se_type = "stata") |> htmlreg()
```

<table class="texreg" style="margin: 10px auto;border-collapse: collapse;border-spacing: 0px;caption-side: bottom;color: #000000;border-top: 2px solid #000000;">
<caption>Statistical models</caption>
<thead>
<tr>
<th style="padding-left: 5px;padding-right: 5px;">&nbsp;</th>
<th style="padding-left: 5px;padding-right: 5px;">Model 1</th>
</tr>
</thead>
<tbody>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">(Intercept)</td>
<td style="padding-left: 5px;padding-right: 5px;">29.11<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[15.56; 42.66]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">atlantic_distance_minimum</td>
<td style="padding-left: 5px;padding-right: 5px;">-1.31<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-2.02; -0.61]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">indian_distance_minimum</td>
<td style="padding-left: 5px;padding-right: 5px;">-1.10<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-1.86; -0.33]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">saharan_distance_minimum</td>
<td style="padding-left: 5px;padding-right: 5px;">-2.43<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-4.07; -0.80]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">red_sea_distance_minimum</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.00</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-1.46;  1.46]</td>
</tr>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.28</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Adj. R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.22</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Num. obs.</td>
<td style="padding-left: 5px;padding-right: 5px;">52</td>
</tr>
<tr style="border-bottom: 2px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">RMSE</td>
<td style="padding-left: 5px;padding-right: 5px;">3.45</td>
</tr>
</tbody>
<tfoot>
<tr>
<td style="font-size: 0.8em;" colspan="2"><sup>&#42;</sup> 0 outside the confidence interval.</td>
</tr>
</tfoot>
</table>

#### IV


```r
nunn_table_4 <-
  list(base = 
         iv_robust(ln_maddison_pcgdp2000~ ln_export_area | atlantic_distance_minimum + indian_distance_minimum + saharan_distance_minimum + red_sea_distance_minimum,
          data = df_Nunn_2008, se_type = "stata"),
       controls = 
         iv_robust(ln_maddison_pcgdp2000 ~ ln_export_area + colony1 + colony2 +colony3+colony4+colony5 + colony6  + colony7 | 
                     atlantic_distance_minimum +  indian_distance_minimum + saharan_distance_minimum + red_sea_distance_minimum +
                     colony1 + colony2 +colony3+colony4+colony5 + colony6  + colony7,
          data = df_Nunn_2008, se_type = "stata"))


htmlreg(nunn_table_4)
```

<table class="texreg" style="margin: 10px auto;border-collapse: collapse;border-spacing: 0px;caption-side: bottom;color: #000000;border-top: 2px solid #000000;">
<caption>Statistical models</caption>
<thead>
<tr>
<th style="padding-left: 5px;padding-right: 5px;">&nbsp;</th>
<th style="padding-left: 5px;padding-right: 5px;">base</th>
<th style="padding-left: 5px;padding-right: 5px;">controls</th>
</tr>
</thead>
<tbody>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">(Intercept)</td>
<td style="padding-left: 5px;padding-right: 5px;">7.81<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">7.72<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 7.46;  8.16]</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 7.07;  8.36]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">ln_export_area</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.21<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">-0.20<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.30; -0.12]</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.31; -0.09]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">colony1</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.15</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.31;  0.61]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">colony2</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.14</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.33;  0.62]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">colony3</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.04</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.79;  0.87]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">colony4</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">-1.25<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-1.78; -0.72]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">colony5</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">1.07<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 0.32;  1.81]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">colony6</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.23</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.57;  1.03]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">colony7</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.36</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.13;  0.85]</td>
</tr>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.13</td>
<td style="padding-left: 5px;padding-right: 5px;">0.34</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Adj. R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.11</td>
<td style="padding-left: 5px;padding-right: 5px;">0.22</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Num. obs.</td>
<td style="padding-left: 5px;padding-right: 5px;">52</td>
<td style="padding-left: 5px;padding-right: 5px;">52</td>
</tr>
<tr style="border-bottom: 2px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">RMSE</td>
<td style="padding-left: 5px;padding-right: 5px;">0.78</td>
<td style="padding-left: 5px;padding-right: 5px;">0.73</td>
</tr>
</tbody>
<tfoot>
<tr>
<td style="font-size: 0.8em;" colspan="3"><sup>&#42;</sup> Null hypothesis value outside the confidence interval.</td>
</tr>
</tfoot>
</table>

### AJRY

@acemoglu2008income


```r
df_AJRY_5_yr <- read_csv("1_4_acemoglu_johnson_robinson_yared/in/five_year_panel.csv", show_col_types = FALSE)


df_AJRY_5_yr <- df_AJRY_5_yr |>
  group_by(code_numeric) |>
  mutate(
    l_lrgdpch = lag(lrgdpch, order_by =year_numeric),
    l_fhpolrigaug = lag(fhpolrigaug, order_by =year_numeric))


ajry_table_2 <- list(
    
  pooled =  
    lm_robust(fhpolrigaug ~  l_lrgdpch + l_fhpolrigaug, 
            fixed_effects=  ~ year_numeric, 
            data = filter(df_AJRY_5_yr, sample == 1), 
            cluster = code_numeric), 
  
  
  fe = 
    lm_robust(fhpolrigaug ~  l_lrgdpch + l_fhpolrigaug, 
            fixed_effects=  ~ year_numeric + code_numeric, 
            data = filter(df_AJRY_5_yr, sample == 1), 
            cluster = code_numeric) 
  )



htmlreg(ajry_table_2)
```

<table class="texreg" style="margin: 10px auto;border-collapse: collapse;border-spacing: 0px;caption-side: bottom;color: #000000;border-top: 2px solid #000000;">
<caption>Statistical models</caption>
<thead>
<tr>
<th style="padding-left: 5px;padding-right: 5px;">&nbsp;</th>
<th style="padding-left: 5px;padding-right: 5px;">pooled</th>
<th style="padding-left: 5px;padding-right: 5px;">fe</th>
</tr>
</thead>
<tbody>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">l_lrgdpch</td>
<td style="padding-left: 5px;padding-right: 5px;">0.07<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.01</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[0.05; 0.09]</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.05; 0.07]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">l_fhpolrigaug</td>
<td style="padding-left: 5px;padding-right: 5px;">0.71<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.38<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[0.64; 0.78]</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 0.28; 0.47]</td>
</tr>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.73</td>
<td style="padding-left: 5px;padding-right: 5px;">0.80</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Adj. R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.72</td>
<td style="padding-left: 5px;padding-right: 5px;">0.75</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Num. obs.</td>
<td style="padding-left: 5px;padding-right: 5px;">945</td>
<td style="padding-left: 5px;padding-right: 5px;">945</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">RMSE</td>
<td style="padding-left: 5px;padding-right: 5px;">0.19</td>
<td style="padding-left: 5px;padding-right: 5px;">0.18</td>
</tr>
<tr style="border-bottom: 2px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">N Clusters</td>
<td style="padding-left: 5px;padding-right: 5px;">150</td>
<td style="padding-left: 5px;padding-right: 5px;">150</td>
</tr>
</tbody>
<tfoot>
<tr>
<td style="font-size: 0.8em;" colspan="3"><sup>&#42;</sup> Null hypothesis value outside the confidence interval.</td>
</tr>
</tfoot>
</table>

## Group politics  {.tabset}

Readings focus on between group politics, gender based inequalities and ways to address these.

### AGN

@alesina2013origins

### CD

@chattopadhyay2004women

### Mousa

@mousa2020building

### GHP

@gulzar2020does

Replication of Table 2



```r
df_india <-  haven::read_dta("2_4_gulzer_haas_pasquale/in/Data.dta") 


Gulzar_Table_2 <- 
  list(
lm_robust(jobcards ~ sch +
            yv + yv2 + yv3 + yv4 +
            xv  +   xv2    + xv3    + xvyv   + xvyv2  + xv2yv  + xv4  +   xv3yv  + xv2yv2 + xvyv3 +
            pop_index_2001 + min_index_2001  + vul_index_2001  +  educ_index_2001  +  med_index_2001  +  water_index_2001  +  comm_index_2001  +  bank_index_2001  + 
            road_index_2001  +  urban_index_2001  +  irrigation_index_2001  +  agworker_index_2001  + margworker_index_2001  +  nonagworker_index_2001  + sharesc91  + 
            sharesc01  +   sharest91  +  sharest01, data = df_india |> filter(km_to_nid <= 10 & samp == 1), fixed_effects = ~ state, cluster = idgp, se_type = "stata"),



lm_robust(jobcards_st ~ sch +
            yv + yv2 + yv3 + yv4 +
            pop_index_2001 + min_index_2001  + vul_index_2001  +  educ_index_2001  +  med_index_2001  +  water_index_2001  +  comm_index_2001  +  bank_index_2001  + 
            road_index_2001  +  urban_index_2001  +  irrigation_index_2001  +  agworker_index_2001  + margworker_index_2001  +  nonagworker_index_2001  + sharesc91  + 
            sharesc01  +   sharest91  +  sharest01, data = df_india |> filter(km_to_nid <= 10 & samp == 1), fixed_effects = ~ state, cluster = idgp, se_type = "stata"))

htmlreg(Gulzar_Table_2)
```

<table class="texreg" style="margin: 10px auto;border-collapse: collapse;border-spacing: 0px;caption-side: bottom;color: #000000;border-top: 2px solid #000000;">
<caption>Statistical models</caption>
<thead>
<tr>
<th style="padding-left: 5px;padding-right: 5px;">&nbsp;</th>
<th style="padding-left: 5px;padding-right: 5px;">Model 1</th>
<th style="padding-left: 5px;padding-right: 5px;">Model 2</th>
</tr>
</thead>
<tbody>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">sch</td>
<td style="padding-left: 5px;padding-right: 5px;">0.00</td>
<td style="padding-left: 5px;padding-right: 5px;">0.19<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[    -0.03;     0.03]</td>
<td style="padding-left: 5px;padding-right: 5px;">[    0.14;    0.24]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">yv</td>
<td style="padding-left: 5px;padding-right: 5px;">-8064.17<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">797.61<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-11652.80; -4475.53]</td>
<td style="padding-left: 5px;padding-right: 5px;">[  398.80; 1196.41]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">yv2</td>
<td style="padding-left: 5px;padding-right: 5px;">1098.25</td>
<td style="padding-left: 5px;padding-right: 5px;">-1193.66<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[ -1226.70;  3423.19]</td>
<td style="padding-left: 5px;padding-right: 5px;">[-1875.69; -511.62]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">yv3</td>
<td style="padding-left: 5px;padding-right: 5px;">-965.97</td>
<td style="padding-left: 5px;padding-right: 5px;">797.31<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[ -1954.80;    22.86]</td>
<td style="padding-left: 5px;padding-right: 5px;">[  280.53; 1314.09]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">yv4</td>
<td style="padding-left: 5px;padding-right: 5px;">-11.02</td>
<td style="padding-left: 5px;padding-right: 5px;">-202.07<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[   -95.07;    73.03]</td>
<td style="padding-left: 5px;padding-right: 5px;">[ -348.57;  -55.57]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">xv</td>
<td style="padding-left: 5px;padding-right: 5px;">-180.28</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[ -3205.37;  2844.82]</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">xv2</td>
<td style="padding-left: 5px;padding-right: 5px;">-862.77</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[ -2106.70;   381.16]</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">xv3</td>
<td style="padding-left: 5px;padding-right: 5px;">384.44<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[   137.84;   631.04]</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">xvyv</td>
<td style="padding-left: 5px;padding-right: 5px;">6966.26<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[  4417.47;  9515.04]</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">xvyv2</td>
<td style="padding-left: 5px;padding-right: 5px;">170.24</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[  -695.90;  1036.37]</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">xv2yv</td>
<td style="padding-left: 5px;padding-right: 5px;">-2237.55<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[ -2944.82; -1530.28]</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">xv4</td>
<td style="padding-left: 5px;padding-right: 5px;">-48.61<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[   -68.86;   -28.35]</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">xv3yv</td>
<td style="padding-left: 5px;padding-right: 5px;">267.73<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[   193.29;   342.17]</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">xv2yv2</td>
<td style="padding-left: 5px;padding-right: 5px;">-172.35<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[  -299.76;   -44.95]</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">xvyv3</td>
<td style="padding-left: 5px;padding-right: 5px;">322.88<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[    95.84;   549.92]</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">pop_index_2001</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.04<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">-0.31<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[    -0.07;    -0.01]</td>
<td style="padding-left: 5px;padding-right: 5px;">[   -0.39;   -0.22]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">min_index_2001</td>
<td style="padding-left: 5px;padding-right: 5px;">0.07<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.44<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[     0.05;     0.09]</td>
<td style="padding-left: 5px;padding-right: 5px;">[    0.39;    0.49]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">vul_index_2001</td>
<td style="padding-left: 5px;padding-right: 5px;">0.02<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">-0.02</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[     0.01;     0.04]</td>
<td style="padding-left: 5px;padding-right: 5px;">[   -0.05;    0.00]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">educ_index_2001</td>
<td style="padding-left: 5px;padding-right: 5px;">0.04<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.12<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[     0.02;     0.05]</td>
<td style="padding-left: 5px;padding-right: 5px;">[    0.08;    0.15]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">med_index_2001</td>
<td style="padding-left: 5px;padding-right: 5px;">0.00</td>
<td style="padding-left: 5px;padding-right: 5px;">0.04</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[    -0.01;     0.02]</td>
<td style="padding-left: 5px;padding-right: 5px;">[   -0.00;    0.08]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">water_index_2001</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.04<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">-0.02</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[    -0.06;    -0.03]</td>
<td style="padding-left: 5px;padding-right: 5px;">[   -0.05;    0.01]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">comm_index_2001</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.06<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">-0.12<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[    -0.07;    -0.05]</td>
<td style="padding-left: 5px;padding-right: 5px;">[   -0.15;   -0.09]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">bank_index_2001</td>
<td style="padding-left: 5px;padding-right: 5px;">0.03<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.05<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[     0.02;     0.04]</td>
<td style="padding-left: 5px;padding-right: 5px;">[    0.03;    0.08]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">road_index_2001</td>
<td style="padding-left: 5px;padding-right: 5px;">0.03<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.07<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[     0.01;     0.04]</td>
<td style="padding-left: 5px;padding-right: 5px;">[    0.05;    0.10]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">urban_index_2001</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.01<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.01</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[    -0.02;    -0.00]</td>
<td style="padding-left: 5px;padding-right: 5px;">[   -0.01;    0.03]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">irrigation_index_2001</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.02</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.08<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[    -0.04;     0.00]</td>
<td style="padding-left: 5px;padding-right: 5px;">[   -0.13;   -0.04]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">agworker_index_2001</td>
<td style="padding-left: 5px;padding-right: 5px;">0.15<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.02</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[     0.13;     0.17]</td>
<td style="padding-left: 5px;padding-right: 5px;">[   -0.03;    0.06]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">margworker_index_2001</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.00</td>
<td style="padding-left: 5px;padding-right: 5px;">0.02<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[    -0.01;     0.01]</td>
<td style="padding-left: 5px;padding-right: 5px;">[    0.00;    0.04]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">nonagworker_index_2001</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.00</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.04</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[    -0.02;     0.02]</td>
<td style="padding-left: 5px;padding-right: 5px;">[   -0.08;    0.01]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">sharesc91</td>
<td style="padding-left: 5px;padding-right: 5px;">0.10</td>
<td style="padding-left: 5px;padding-right: 5px;">0.33<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[    -0.03;     0.22]</td>
<td style="padding-left: 5px;padding-right: 5px;">[    0.07;    0.59]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">sharesc01</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.11</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.40<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[    -0.25;     0.03]</td>
<td style="padding-left: 5px;padding-right: 5px;">[   -0.67;   -0.12]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">sharest91</td>
<td style="padding-left: 5px;padding-right: 5px;">0.26<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">1.09<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[     0.17;     0.35]</td>
<td style="padding-left: 5px;padding-right: 5px;">[    0.86;    1.32]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">sharest01</td>
<td style="padding-left: 5px;padding-right: 5px;">0.00</td>
<td style="padding-left: 5px;padding-right: 5px;">0.96<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[    -0.09;     0.09]</td>
<td style="padding-left: 5px;padding-right: 5px;">[    0.73;    1.20]</td>
</tr>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.44</td>
<td style="padding-left: 5px;padding-right: 5px;">0.47</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Adj. R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.44</td>
<td style="padding-left: 5px;padding-right: 5px;">0.46</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Num. obs.</td>
<td style="padding-left: 5px;padding-right: 5px;">32641</td>
<td style="padding-left: 5px;padding-right: 5px;">32641</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">RMSE</td>
<td style="padding-left: 5px;padding-right: 5px;">0.70</td>
<td style="padding-left: 5px;padding-right: 5px;">1.31</td>
</tr>
<tr style="border-bottom: 2px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">N Clusters</td>
<td style="padding-left: 5px;padding-right: 5px;">14933</td>
<td style="padding-left: 5px;padding-right: 5px;">14933</td>
</tr>
</tbody>
<tfoot>
<tr>
<td style="font-size: 0.8em;" colspan="3"><sup>&#42;</sup> Null hypothesis value outside the confidence interval.</td>
</tr>
</tfoot>
</table>


## Accountability  {.tabset}

Readings look at drivers of political responsiveness to citizen demands. We look at one observational piece and three experimental interventions. 

### FF

@ferraz2011electoral


```r
df_ff_corruption <- haven::read_dta("3_2_ferraz_finan/in/corruptiondata_aer.dta")

ff_table_4 <-
  list(
    base = lm_robust(pcorrupt ~ first, data =  df_ff_corruption |> filter( esample2==1)),
    controls = lm_robust(pcorrupt ~ first + pref_masc +  pref_idade_tse + pref_escola + 
                       party_d1  +  party_d3 + party_d4 + party_d5 + party_d6 + party_d7 + 
                       party_d8 + party_d9 + party_d10 + party_d11 + party_d12 +
                       party_d13 + party_d14 + party_d15  + party_d16 + party_d17 + party_d18, data
                     =  df_ff_corruption |> filter( esample2==1)))

htmlreg(ff_table_4)
```

<table class="texreg" style="margin: 10px auto;border-collapse: collapse;border-spacing: 0px;caption-side: bottom;color: #000000;border-top: 2px solid #000000;">
<caption>Statistical models</caption>
<thead>
<tr>
<th style="padding-left: 5px;padding-right: 5px;">&nbsp;</th>
<th style="padding-left: 5px;padding-right: 5px;">base</th>
<th style="padding-left: 5px;padding-right: 5px;">controls</th>
</tr>
</thead>
<tbody>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">(Intercept)</td>
<td style="padding-left: 5px;padding-right: 5px;">0.07<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.18<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 0.06;  0.09]</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 0.09;  0.27]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">first</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.02<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">-0.02<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.04; -0.00]</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.04; -0.00]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">pref_masc</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.03</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.09;  0.02]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">pref_idade_tse</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.00</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.00;  0.00]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">pref_escola</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.01<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.01; -0.00]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">party_d1</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.03<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.06; -0.00]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">party_d3</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.03</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.02;  0.08]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">party_d4</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.01</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.04;  0.02]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">party_d5</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.00</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.04;  0.04]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">party_d6</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.00</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.05;  0.04]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">party_d7</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.01</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.02;  0.03]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">party_d8</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.19<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 0.16;  0.21]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">party_d9</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.04</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.03;  0.12]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">party_d10</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.01</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.06;  0.08]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">party_d11</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.03</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.07;  0.01]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">party_d12</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.01</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.04;  0.01]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">party_d13</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.05</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.08;  0.17]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">party_d14</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.04<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.06; -0.01]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">party_d15</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.05<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.08; -0.03]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">party_d16</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.24<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[ 0.22;  0.27]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">party_d17</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.00</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.06;  0.06]</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">party_d18</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.03</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">[-0.00;  0.06]</td>
</tr>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.01</td>
<td style="padding-left: 5px;padding-right: 5px;">0.08</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Adj. R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.01</td>
<td style="padding-left: 5px;padding-right: 5px;">0.03</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Num. obs.</td>
<td style="padding-left: 5px;padding-right: 5px;">476</td>
<td style="padding-left: 5px;padding-right: 5px;">476</td>
</tr>
<tr style="border-bottom: 2px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">RMSE</td>
<td style="padding-left: 5px;padding-right: 5px;">0.10</td>
<td style="padding-left: 5px;padding-right: 5px;">0.10</td>
</tr>
</tbody>
<tfoot>
<tr>
<td style="font-size: 0.8em;" colspan="3"><sup>&#42;</sup> Null hypothesis value outside the confidence interval.</td>
</tr>
</tfoot>
</table>

### Grossman et al

@grossman2021effect

### Raffler

@raffler2022does

### Fujiwara and Wantchekon

@fujiwara2013can

## Interventions  {.tabset}

We look at macro and micro interventions including international peacekeeping, development aid, and state-led innovations.  


### Blair et al

@blair2022peacekeeping

### Nunn & Qian

@nunn2014us

### Muralidharan et al

@muralidharan2016building

### Blattman & Annan

@blattman2016can

## References
