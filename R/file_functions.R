

extract_significant_SNPs <- function(filename_in,pval_exposure_name,filename_out) {

  print(paste0("Extract SNP/Exposure associations with p<0.00000005"))
  print(paste0("From: ", filename_in))

  if (file.exists(filename_in)){

    exposure_dat_dt <- data.table::fread(filename_in,fill=TRUE)

    data.table::setnames(exposure_dat_dt, paste0(pval_exposure_name), "pvalue")
    data.table::setkey(exposure_dat_dt, pvalue)

    #https://cran.r-project.org/web/packages/data.table/vignettes/datatable-keys-fast-subset.html
    #Binary search for speed
    exposure_dat_dt_significant <- exposure_dat_dt[pvalue < 0.00000005,]

    print(nrow(exposure_dat_dt_significant))

    data.table::fwrite(exposure_dat_dt_significant,filename_out)
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

read_exposure_data_CKDGen <- function(filename_in) {
  print(filename_in)

  filename_in2=deparse(substitute(filename_in))

  #Map column names from CKDGEN file to TwoSampleMR spec
  exposure_dat <- TwoSampleMR::read_exposure_data(
    filename = filename_in2,
    sep = ",",
    snp_col = "RSID",
    beta_col = "Effect",
    se_col = "StdErr",
    effect_allele_col = "Allele1",
    other_allele_col = "Allele2",
    eaf_col = "Freq1",
    pval_col = "pvalue",
    samplesize_col = "n_total_sum"
  )

  return(exposure_dat)
}

