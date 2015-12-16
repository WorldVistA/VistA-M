DGPT101P ;ALB/MTC,HIOFO/FT - Parse 101 record ;12/8/2014 1:22pm
 ;;5.3;Registration;**164,678,664,884**;Aug 13, 1993;Build 31
 ;;
SET ; Parse 101 record
 D:DGPTFMT=2 SET9
 D:DGPTFMT=3 SET10
 Q
SET9 ;record layout before icd10 turned on
 S DGPTDTS=$$FMDT^DGPT101($E(DGPTSTR,15,20))_"."_$E(DGPTSTR,21,24)
 S DGPTPS=$E(DGPTSTR,5) ;pseudo ssn
 S DGPTSSN=$E(DGPTSTR,6,14) ;social security number
 S DGPTDTA=$E(DGPTSTR,15,24) ;admission date (mmddyy) and time (2400 clock)
 S DGPTFAC=$E(DGPTSTR,25,30) ;facility number and suffix
 S DGPTLN=$E(DGPTSTR,31,42) ;patient's last name
 S DGPTFI=$E(DGPTSTR,43) ;patient's first initial
 S DGPTMI=$E(DGPTSTR,44) ;patient's middle initial
 S DGPTSRA=$E(DGPTSTR,45,46) ;source of admission
 S DGPTTF=$E(DGPTSTR,47,52) ;transferring facility & suffix
 S DGPTSRP=$E(DGPTSTR,53) ;source of payment
 S DGPTPOW=$E(DGPTSTR,54) ;prisoner of war
 S DGPTMRS=$E(DGPTSTR,55) ;marital status
 S DGPTGEN=$E(DGPTSTR,56) ;sex indicator
 S DGPTDOB=$E(DGPTSTR,57,64) ;date of birth
 ;S DGPTBY=$E(DGPTSTR,61,64) ;year of birth <-not used. DGPT10CB sets DGPTBYR instead. ft 11/3/14
 S DGPTPOS1=$E(DGPTSTR,65) ;space, not used
 S DGPTPOS2=$E(DGPTSTR,66) ;period of service indicator
 S DGPTEXA=$E(DGPTSTR,67) ;agent orange indicator
 S DGPTEXI=$E(DGPTSTR,68) ;ionizing radiation indicator
 S DGPTSTE=$E(DGPTSTR,69,70) ;state of residence indicator
 S DGPTCTY=$E(DGPTSTR,71,73) ;county of residence indicator
 S DGPTZIP=$E(DGPTSTR,74,78) ;zip code
 S DGPTMTC=$E(DGPTSTR,79,80) ;means test indicator
 S DGPTINC=$E(DGPTSTR,81,86) ;income
 S DGPTERI=$E(DGPTSTR,96) ;emergency response indicator
 S DGPTCTRY=$E(DGPTSTR,97,99) ;country code
 Q
SET10 ;record layout after icd10 turned on
 S DGPTDTS=$$FMDT^DGPT101($E(DGPTSTR,15,20))_"."_$E(DGPTSTR,21,24)
 S DGPTPS=$E(DGPTSTR,5) ;pseudo ssn
 S DGPTSSN=$E(DGPTSTR,6,14) ;social security number
 S DGPTDTA=$E(DGPTSTR,15,24) ;admission date (mmddyy) and time (2400 clock)
 S DGPTFAC=$E(DGPTSTR,25,30) ;facility number and suffix
 S DGPTLN=$E(DGPTSTR,31,42) ;patient's last name
 S DGPTFI=$E(DGPTSTR,43) ;patient's first initial
 S DGPTMI=$E(DGPTSTR,44) ;patient's middle initial
 S DGPTSRA=$E(DGPTSTR,45,46) ;source of admission
 S DGPTTF=$E(DGPTSTR,47,52) ;transferring facility & suffix
 S DGPTSRP=$E(DGPTSTR,53) ;source of payment
 S DGPTPOW=$E(DGPTSTR,54) ;prisoner of war
 S DGPTMRS=$E(DGPTSTR,55) ;marital status
 S DGPTGEN=$E(DGPTSTR,56) ;sex indicator
 S DGPTDOB=$E(DGPTSTR,57,64) ;date of birth
 S DGPTPOS1=$E(DGPTSTR,65) ;space, not used
 S DGPTPOS2=$E(DGPTSTR,66) ;period of service indicator
 S DGPTEXA=$E(DGPTSTR,67) ;agent orange indicator
 S DGPTEXI=$E(DGPTSTR,68) ;ionizing radiation indicator
 S DGPTSTE=$E(DGPTSTR,69,70) ;state of residence indicator
 S DGPTCTY=$E(DGPTSTR,71,73) ;county of residence indicator
 S DGPTZIP=$E(DGPTSTR,74,78) ;zip code
 S DGPTMTC=$E(DGPTSTR,79,80) ;means test indicator
 S DGPTINC=$E(DGPTSTR,81,86) ;income
 S DGPTMST=$E(DGPTSTR,87) ;military sexual trauma
 S DGPTCOMVET=$E(DGPTSTR,88) ;combat vet
 S DGPTCOMVETDT=$E(DGPTSTR,89,94) ;combat vet date mmddyy
 S DGPTSHAD=$E(DGPTSTR,95) ;shad indicator
 S DGPTERI=$E(DGPTSTR,96) ;emergency response indicator
 S DGPTCTRY=$E(DGPTSTR,97,99) ;country code
 Q
