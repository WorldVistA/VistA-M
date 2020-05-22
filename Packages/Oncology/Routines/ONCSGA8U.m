ONCSGA8U ;Hines OIFO/RTK - AJCC 8th Ed Staging Utilities ;02/04/19
 ;;2.2;ONCOLOGY;**10**;Jul 31, 2013;Build 20
 ;
 ;
TNMDSP ;Display the 8th Ed TNM fields
 D GETFLD
 W T,$S(TSFX'="":TSFX,1:"")," ",N,$S(NSFX'="":NSFX,1:"")," ",M
 Q
GETFLD ;Get the TNM (Clin/Path/Post-Th) from the record
 I STGIND="C" D
 .S T=$P($G(^ONCO(165.5,D0,"AJCC8")),"^",2)
 .S TSFX=$P($G(^ONCO(165.5,D0,"AJCC8")),"^",14)
 .S N=$P($G(^ONCO(165.5,D0,"AJCC8")),"^",3)
 .S NSFX=$P($G(^ONCO(165.5,D0,"AJCC8")),"^",15)
 .S M=$P($G(^ONCO(165.5,D0,"AJCC8")),"^",4)
 I STGIND="P" D
 .S T=$P($G(^ONCO(165.5,D0,"AJCC8")),"^",6)
 .S TSFX=$P($G(^ONCO(165.5,D0,"AJCC8")),"^",16)
 .S N=$P($G(^ONCO(165.5,D0,"AJCC8")),"^",7)
 .S NSFX=$P($G(^ONCO(165.5,D0,"AJCC8")),"^",17)
 .S M=$P($G(^ONCO(165.5,D0,"AJCC8")),"^",8)
 I STGIND="T" D
 .S T=$P($G(^ONCO(165.5,D0,"AJCC8")),"^",10)
 .S TSFX=$P($G(^ONCO(165.5,D0,"AJCC8")),"^",18)
 .S N=$P($G(^ONCO(165.5,D0,"AJCC8")),"^",11)
 .S NSFX=$P($G(^ONCO(165.5,D0,"AJCC8")),"^",19)
 .S M=$P($G(^ONCO(165.5,D0,"AJCC8")),"^",12)
 Q
