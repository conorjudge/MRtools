

extract_significant_SNPs <- function(filename_in,pval_exposure_name,pval_exposure_name_and_cutoff,filename_out) {

  print(paste0("Extract SNP/Exposure associations with p<", p_cutoff))
  print(paste0("From: ", filename_in))

  if (file.exists(filename_in)){

    exposure_dat_dt <- data.table::fread(filename_in)

    data.table::setnames(exposure_dat_dt, paste0(pval_exposure_name), "pvalue")
    data.table::setkey(exposure_dat_dt, pvalue)

    #https://cran.r-project.org/web/packages/data.table/vignettes/datatable-keys-fast-subset.html
    #Binary search for speed
    exposure_dat_dt_significant <- exposure_dat_dt[pvalue < 0.00000005,]

    print(nrow(exposure_dat_dt_significant))

    return(exposure_dat_dt_significant)

  }

}

#extract_significant_SNPs("./data-raw/20171016_MW_eGFR_overall_ALL_nstud61.dbgap.txt","P-value","SNP_eGFR_overall.txt")

more_file <- function(filename_in,num_rows) {
  if (file.exists(filename_in)){
    exposure_dat_dt_nrows <- data.table::fread(filename_in, nrows=num_rows)

    return(exposure_dat_dt_nrows)
  }
}

#more_file("./data-raw/20171016_MW_eGFR_overall_ALL_nstud61.dbgap.txt",1)

