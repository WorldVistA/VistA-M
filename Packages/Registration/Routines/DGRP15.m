DGRP15 ;ALB/MTC - TRICARE DEMOGRAPHIC DATA ;03/05/2004
 ;;5.3;Registration;**114,239,568**;Aug 13, 1993
 ;
EN ;
 N X,Y,DGSA
1 S DGSA=""
 ;-- get sponsor info
 D GET
 ;-- draw header
 S (DGRPS,DGRPW)=15 D H^DGRPU
 ;--
 S Z=1 D WW^DGRPV W " Sponsor Information:"
 I DGSA D
 . S Y=1,X=0 F  S X=$O(DGSA(X)) Q:'X  D DISPON(X) S Y=Y+1 Q:Y>2
 E   W !,!,"No Sponsor Information available."
 ;
 W !
2 ;-- Primary Care Manager
 ;
 ;-- get primary care data
 D
 .N CT,GBL S GBL="GBL"
 .D TDATA^DGSDUTL(DFN,.CT,DT)
 .I CT>12 S GBL(11,0)="" D
 ..S GBL(12,0)="      *** Additional assignment information exists ***"
 .S CT=0 F  S CT=$O(GBL(CT)) Q:'CT!(CT>12)  W !,GBL(CT,0)
 .Q
 ;
 ;-- goto main registration screen processing routine
 G ^DGRPP
 ;
 Q
 ;
DISPON(SPON) ;-- This function will display the Sponsor designated by
 ;  SPON.
 ;
 W !,!,"    Name : " S Z=$P(DGSA(SPON,"SPON"),U),Z1=30 D WW1^DGRPV
 W ?40,"Military Status : ",$P(DGSA(SPON,"SPON"),U,4)
 W !,"     DOB : " S Z=$P(DGSA(SPON,"SPON"),U,2),Z1=28 D WW1^DGRPV
 W ?35,"Branch of Service : ",$P(DGSA(SPON,"SPON"),U,5)
 W !,"     SSN : " S Z=$P(DGSA(SPON,"SPON"),U,3),Z1=15 D WW1^DGRPV
 W ?52,"Rank : ",$P(DGSA(SPON,"SPON"),U,6)
 W !,"  Prefix : " S Z=$P(DGSA(SPON,"REL"),U,2),Z1=12 D WW1^DGRPV
 W ?52,"Type : ",$P(DGSA(SPON,"REL"),U,3)
 S Y=$P(DGSA(SPON,"REL"),U,4) X ^DD("DD")
 W !,"   Effective Date : ",Y
 S Y=$P(DGSA(SPON,"REL"),U,5) X ^DD("DD")
 W ?35,"Expiration Date: ",Y
 Q
 ;
GET ;-- get sponsor information and populate the DGSA array.
 D GET^IBCNSU4(DFN,.DGSA)
GETQ Q
 ;
EDIT ;-- edit sponsor or primary care ... called from DGRPE
 I DGRPANN["1" D
 . D SPON^IBCNSU41(DFN)
 I DGRPANN["2" D
 . W !,"Edit Primary Provider information." H 3 Q
 ;
 Q
 ;
