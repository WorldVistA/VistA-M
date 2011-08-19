DGL ;ALB/MJK - Utility for RAD ; 24 JAN 91 12:00 am
 ;;5.3;Registration;;Aug 13, 1993
 ;
 Q
LOSS ; -- utility to determine if pt was an inpatient
 ;    at time NOW ; obsolete in version 5.1
 ;    input:     NOW := inverse date/time
 ;               DFN
 ;   output:       L := 0 not inpatient ; 1 is inpatient
 S VAINDT=9999999.9999-NOW D ADM^VADPT2 S L=$S(VADMVT:1,1:0)
 K VAINDT,VADMVT,NOW Q
