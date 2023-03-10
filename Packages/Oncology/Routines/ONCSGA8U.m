ONCSGA8U ;HINES OIFO/RTK - AJCC 8th Ed Staging Utilities ;02/04/19
 ;;2.2;ONCOLOGY;**10,12,13**;Jul 31, 2013;Build 7
 ;
 ;
TNMSET ;Set the value of 8th Ed+ TNM in HIERTNM variable, but don't display
 D GETFLD
 S HIERTNM=T_$S(TSFX'="":TSFX,1:"")_" "_N_$S(NSFX'="":NSFX,1:"")_" "_M
 Q
TNMDSP ;Display the 8th Ed TNM fields
 D GETFLD
 W T,$S(TSFX'="":TSFX,1:"")," ",N,$S(NSFX'="":NSFX,1:"")," ",M
 Q
GETFLD ;Get the TNM (Clin/Path/Post-Th) from the record
 I STGIND="C" D
 .S T=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",2)
 .S TSFX=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",14)
 .S N=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",3)
 .S NSFX=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",15)
 .S M=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",4)
 I STGIND="P" D
 .S T=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",6)
 .S TSFX=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",16)
 .S N=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",7)
 .S NSFX=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",17)
 .S M=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",8)
 I STGIND="Y" D
 .S T=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",20)
 .S TSFX=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",24)
 .S N=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",21)
 .S NSFX=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",25)
 .S M=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",22)
 I STGIND="T" D
 .S T=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",10)
 .S TSFX=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",18)
 .S N=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",11)
 .S NSFX=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",19)
 .S M=$P($G(^ONCO(165.5,IEN,"AJCC8")),"^",12)
 Q
