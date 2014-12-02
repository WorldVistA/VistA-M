DGRP15 ;ALB/MTC - TRICARE DEMOGRAPHIC DATA ;03/05/2004
 ;;5.3;Registration;**114,239,568,867**;Aug 13, 1993;Build 59
 ;
EN ;
 N X,Y,DGSA,SPFLAG,NEWBAR,LINE,NN,CNT
1 S DGSA=""
 ;-- get sponsor info
 S SPFLAG=0
 D GET
 ;-- draw header
 S (DGRPS,DGRPW)=15 D H^DGRPU
 ;--
 S Z=1 D WW^DGRPV W " Sponsor Information:"
 I DGSA D
 . S Y=1,X=0 F  S X=$O(DGSA(X)) Q:'X  D DISPON(X) S Y=Y+1 Q:Y>2
 E   W:'SPFLAG !,!,"No Sponsor Information available."
 I SPFLAG W !?4,"Sponsored Newborn:" D
 . S NN="",CNT=0 F  S NN=$O(NEWBAR(NN)) Q:(NN="")!(CNT=2)  D
 .. S SPN=""
 .. F  S SPN=$O(NEWBAR(NN,SPN)) Q:(SPN="")!(CNT=2)  D
 ... S CNT=CNT+1
 ... W !?7,"NAME : ",$P(NEWBAR(NN,SPN),"^")
 ... W !?8,"DOB : " S Y=$P(NEWBAR(NN,SPN),"^",2) X ^DD("DD") W Y
 ... W !?8,"SSN : ",$P(NEWBAR(NN,SPN),"^",3)
 ... W !?6,"Effective Date : " S Y=$P(NEWBAR(NN,SPN),"^",4) X ^DD("DD") W Y
 ... W ?38,"Expiration Date : " S Y=$P(NEWBAR(NN,SPN),"^",5) X ^DD("DD") W Y
 ... W !
 I SPFLAG>2 W "Sponsor has ",SPFLAG," sponsored newborn children."
 W !
2 ;-- Primary Care  
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
 ;  SPON.^
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
 N NEWB,SPON1,X,SPN,HDT,LINE,N,AA,BDOB
 D GET^IBCNSU4(DFN,.DGSA)
 ; -- Find the Newborn sponsored info
 ; -- look at all of the patient's sponsor relationships
 S X=0 F  S X=$O(^IBA(355.8,"B",X)) Q:X=""  D
 . Q:+X'=DFN
 . S N="" F  S N=$O(^IBA(355.8,"B",X,N)) Q:N=""  D
 .. S AA=0 F  S AA=$O(^IBA(355.81,AA)) Q:(AA="")!(AA="B")  D
 ... I $P(^IBA(355.81,AA,0),"^",2)=N D
 .... S SPN=$P(^IBA(355.81,AA,0),"^",1)
 .... S EFFDT=$P(^IBA(355.81,AA,0),"^",5)
 .... S EXPDT=$P(^IBA(355.81,AA,0),"^",6)
 .... Q:'$D(^DPT(SPN,0))
 .... S BDOB=$P(^DPT(SPN,0),"^",3)
 .... Q:$P(^DPT(SPN,0),"^",16)-BDOB>365        ; Baby's Registration date minus DOB
 .... S LINE=^DPT(SPN,0)
 .... ; The last baby will be printed first
 .... S SPFLAG=SPFLAG+1,NEWBAR(9999999-BDOB,SPN)=$P(LINE,"^",1)_"^"_BDOB_"^"_$P(LINE,"^",9)_"^"_EFFDT_"^"_EXPDT
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
NEWBDT(DFN) ;-- Get baby's DOB, check if DOB <1 year, returns FLAG and DOB
 N DOB,FLAG,NOW
 S FLAG=0
 S DOB=$P(^DPT(DFN,0),"^",3)
 D NOW^%DTC S NOW=X
 I $$FMDIFF^XLFDT(NOW,DOB,1)>365 Q  ;patient is not a newborn
 S FLAG=1
 Q FLAG_"^"_DOB
