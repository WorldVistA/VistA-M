DGPT701P ;ALB/MTC,HIOFO/FT - Parse 701 Record String ;2/23/15 9:20am
 ;;5.3;Registration;**164,415,884**;Aug 13, 1993;Build 31
 ;
EN ;
PARSE ; Parse record string
 D:DGPTFMT=2 SET9
 D:DGPTFMT=3 SET10
 Q
SET9 ;record layout before icd10 turned on
 S DGPTDDTD=$E(DGPTSTR,31,40) ;date of disposition
 S DGPTDDS=$$FMDT^DGPT101($E(DGPTDDTD,1,6))_"."_$E(DGPTDDTD,7,10)
 S DGPTDSP=$E(DGPTSTR,41,42) ;discharge specialty code
 S DGPTDTY=$E(DGPTSTR,43) ;type of disposition
 S DGPTDOP=$E(DGPTSTR,44) ;outpatient care status
 S DGPTDVA=$E(DGPTSTR,45) ;under va auspices
 S DGPTDPD=$E(DGPTSTR,46) ;place of disposition
 S DGPTDRF=$E(DGPTSTR,47,52) ;receiving facility number and suffix
 S DGPTDAS=$E(DGPTSTR,53,55) ;extended care days - absent sick in hospital
 S DGPTDCP=$E(DGPTSTR,57) ;compensation & pension status
 S DGPTDDXE=$E(DGPTSTR,58,64) ;dxls for entire stay
 S DGPTDDXO=$E(DGPTSTR,65) ;present on admission (poa) for dxls
 S DGPTDLR=$E(DGPTSTR,66,71) ;physical location cdr code
 S DGPTDLC=$E(DGPTSTR,72,73) ;physical location code
 S DGPTDSC=$E(DGPTSTR,74,76) ;percentage of service connection
 S DGPT70LG=$E(DGPTSTR,77) ;legionnaires
 S DGPT70SU=$E(DGPTSTR,78) ;suicide indicator
 S DGPT70DR=$E(DGPTSTR,79,82) ;substance abuse
 S DGPT70X4=$E(DGPTSTR,83) ;physical axis class
 S DGPTDXV1=$E(DGPTSTR,84,85) ;physical axis assessment-1
 S DGPTDXV2=$E(DGPTSTR,86,87) ;physical axis assessment-2
 Q
SET10 ;record layout after icd10 turn on
 S DGPTDDTD=$E(DGPTSTR,31,40) ;date of disposition
 S DGPTDDS=$$FMDT^DGPT101($E(DGPTDDTD,1,6))_"."_$E(DGPTDDTD,7,10)
 S DGPTDSP=$E(DGPTSTR,41,42) ;discharge specialty code
 S DGPTDTY=$E(DGPTSTR,43) ;type of disposition
 S DGPTDOP=$E(DGPTSTR,44) ;outpatient care status
 S DGPTDVA=$E(DGPTSTR,45) ;under va auspices
 S DGPTDPD=$E(DGPTSTR,46) ;place of disposition
 S DGPTDRF=$E(DGPTSTR,47,52) ;receiving facility number and suffix
 S DGPTDAS=$E(DGPTSTR,53,55) ;extended care days - absent sick in hospital
 S DGPT70RACE=$E(DGPTSTR,56) ;race
 S DGPTDCP=$E(DGPTSTR,57) ;compensation & pension status
 S DGPTDDXE=$E(DGPTSTR,58,64) ;dxls for entire stay
 S DGPTDXLSPOA=$E(DGPTSTR,65) ;poa for dxls
 S DGPTDDXO=$E(DGPTSTR,66) ;dxls only no other codes
 S DGPTDLR=$E(DGPTSTR,67,72) ;physical location cdr code
 S DGPTDLC=$E(DGPTSTR,73,74) ;physical location code
 S DGPTDSC=$E(DGPTSTR,75,77) ;percentage of service connection
 S DGPT70LG=$E(DGPTSTR,78) ;legionnaires
 S DGPT70SU=$E(DGPTSTR,79) ;suicide indicator
 S DGPT70DR=$E(DGPTSTR,80,83) ;substance abuse
 S DGPT70X4=$E(DGPTSTR,84) ;physical axis class                <-no longer used with ICD10, should be a space. ft 11/3/14
 S DGPTDXV2=$E(DGPTSTR,85,88) ;physical axis assessment 1 & 2  <-no longer used with ICD10, should be 4 spaces. ft 11/3/14
 S DGPT70TSC=$E(DGPTSTR,89) ;treated for service condition
 S DGPT70AO=$E(DGPTSTR,90) ;treated for agent orange condition
 S DGPT70IR=$E(DGPTSTR,91) ;treated for ionizing radiation
 S DGPT70SWA=$E(DGPTSTR,92) ;treated for sw asia condition
 S DGPT70MST=$E(DGPTSTR,93) ;military sexual trauma care
 S DGPT70HNC=$E(DGPTSTR,94) ;head neck cancer
 S DGPT70ETHNIC=$E(DGPTSTR,95,96) ;ethnicity
 S DGPT70RACE1=$E(DGPTSTR,97,98) ;race-1
 S DGPT70RACE2=$E(DGPTSTR,99,100) ;race-2
 S DGPT70RACE3=$E(DGPTSTR,101,102) ;race-3
 S DGPT70RACE4=$E(DGPTSTR,103,104) ;race-4
 S DGPT70RACE5=$E(DGPTSTR,105,106) ;race-5
 S DGPT70RACE6=$E(DGPTSTR,107,108) ;race-6
 S DGPT70COMVET=$E(DGPTSTR,109) ;combat veteran
 S DGPT70SHAD=$E(DGPTSTR,110) ;shipboard hazard and defense
 Q
