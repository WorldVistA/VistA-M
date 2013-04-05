DGYPREG2 ;ALB/REW - POST INIT CONVERSION/REPORTING ;2-APR-93
 ;;5.3;Registration;;Aug 13, 1993
HEAD(REP) ;
 Q:'$G(REP)
 N DGTAG,DGTXT,DGX1
 S DGTAG="HD"_REP
 F DGXM=1:1 S DGTXT=$P($T(HEAD1+DGXM),";;",2) Q:DGTXT']""  D
 .S @DGROOT@(DGXM,0)="    "_DGTXT
 F DGX1=1:1 S DGTXT=$P($T(@DGTAG+DGX1),";;",2) Q:DGTXT']""   D
 .S DGXM=DGXM+1
 .S @DGROOT@(DGXM,0)="    "_DGTXT
 Q
PRHEAD1 ;
 F DGXM=1:1 S DGTXT=$P($T(HEAD1+DGXM^DGYPREG2),";;",2) Q:DGTXT']""  D
 .W !?5,DGTXT
 Q
HEAD1 ;
 ;; NOTE:
 ;; 
 ;;A)  Last Activity Date is the last date a patient had one
 ;;    of the following:
 ;;  
 ;;    1) Registration
 ;;    2) Scheduled clinic appointment (can be in future)
 ;;    3) Scheduled Admission (can be in future)
 ;;    4) Patient Movement
 ;;    5) Inhouse Patient status
 ;; 
 ;;B)  Active Patients have a Last Activity Date within a year
 ;;    of today.
 ;;  
HD1 ;
 ;;C)  Convertible fields start with a valid station number
 ;;  
HD2 ;
 ;;C)  Convertible fields have exactly 1 non-zero entry in the
 ;;    following fields:
 ;; 
 ;;          AMOUNT OF AID & ATTENDANCE
 ;;          AMOUNT OF HOUSEBOUND
 ;;          AMOUNT OF VA DISABILITY
 ;;          AMOUNT OF VA PENSION
 ;; 
