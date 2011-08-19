FHMADM2 ; HISC/AAC - Multidivisional Enter/Edit Served Meals ;10/9/03  09:53
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Enter/Edit Served Meals
 D NOW^%DTC S DT=%\1 K %,%H,%I
 S (ZZOUT,COMM)=0,ZOUT=$P($G(^FH(119.6,0)),"^",4)
 ;
E1 S %DT="AEPX",%DT("A")="SERVED MEALS Date: " W ! D ^%DT G KIL^FHMADM21:"^"[X!$D(DTOUT),E1:Y<1
 ;
 S DA=+Y,(FHRM,FHSM,FHGM)=DA I DA'<DT W *7,!!,"** Input must be for a date before today in order to collect ADT data!",! G E1
 ;
 ;Enter Communications Office 
 K DIC,DIE S DIE="^FH(117," I '$D(^FH(117,DA,0)) S ^FH(117,DA,0)=DA,^FH(117,"B",DA,DA)="",X0=^FH(117,0),$P(^FH(117,0),"^",3,4)=DA_"^"_($P(X0,"^",4)+1)
 S DA=+Y I $G(^FH(117,DA,"I"))="Y" W !," ** INACTIVE COMM OFFICE **" Q
 S ^FH(117,DA,0)=DA
 S DR="[FHMADM2]" D ^DIE
 Q
 ;
C1 ;
 K FHN W !!,"Calculating Census Values ...",!
 F W1=0:0 S W1=$O(^DG(41.9,W1)) Q:W1'>0  D C2
        W !,"Calculating Outpatient Values ...",! D CALCOP
 Q
C2 ;
 I '$D(^DG(41.9,W1,"C",DA(1))) Q
 S X0=^DG(41.9,W1,"C",DA(1),0),X1=$G(^(1)) I $D(^DIC(42,W1,0)) S FHWARD=$O(^FH(119.6,"AW",W1,"")) Q:FHWARD=""
 S FHCOM19=$P($G(^FH(119.6,FHWARD,0)),"^",8) Q:FHCOMM'=FHCOM19
 S TYP=$P(^DIC(42,W1,0),"^",3),TYP=$S(TYP="D":"D",TYP="NH":"N",1:"H")
 I '$D(FHN(TYP)) S FHN(TYP,0)=0,FHN(TYP,1)=0
 S Y0=$P(X0,"^",2),Y1=$P(X1,"^",5)
 S:Y0 FHN(TYP,0)=FHN(TYP,0)+Y0 S:Y1 FHN(TYP,1)=FHN(TYP,1)+Y1 Q
 Q
DT ; Get From/To Dates
D1 S %DT="AEPX",%DT("A")="Starting Date: " W ! D ^%DT S:$D(DTOUT) X="^" Q:U[X  G:Y<1 D1 S SDT=+Y
 I SDT'<DT W *7,"  [Must Start before Today!] " G D1
D2 S %DT="AEPX",%DT("A")=" Ending Date: " D ^%DT S:$D(DTOUT) X="^" Q:U[X  G:Y<1 D2 S EDT=+Y
 I EDT'<DT W *7,"  [Must End before Today!] " G D2
 I EDT<SDT W *7,"  [End before Start?] " G D1
 Q
CALCOP ; Calculate Outpatient totals (Recurring and Special Meals) for the
 ; selected Communication Office
 ;
 K FHOPC S FHEND=FHRM_.9999,X1=FHRM,X2=-1 D C^%DTC S FHRM=X
 F IX="B","N","E" S FHOPC(IX)=0 F FC="E","G","O","P","V" S FHOPC(FC,IX)=0
 ; Count recurring meals totals in FHOPC(INDX)
 F FHRM=FHRM:0 S FHRM=$O(^FHPT("RM",FHRM)) Q:FHRM=""!(FHRM'<FHEND)  D
 .F FHDFN=0:0 S FHDFN=$O(^FHPT("RM",FHRM,FHDFN)) Q:FHDFN=""  D
 ..F FHRNUM=0:0 S FHRNUM=$O(^FHPT("RM",FHRM,FHDFN,FHRNUM)) Q:FHRNUM=""  D
 ...S FHLOC=$P($G(^FHPT(FHDFN,"OP",FHRNUM,0)),U,3)
 ...I $P($G(^FH(119.6,FHLOC,0)),U,8)'=FHCOMM Q
 ...S FHMEAL=$P($G(^FHPT(FHDFN,"OP",FHRNUM,0)),U,4)
 ...Q:"BNE"'[FHMEAL!(FHMEAL="")
 ...I $P($G(^FHPT(FHDFN,"OP",FHRNUM,0)),U,15)="C" Q
 ...S FHOPC(FHMEAL)=FHOPC(FHMEAL)+1
 ; Add special meals to recurring meals totals in FHOPC(INDX)
 F FHSM=FHSM:0 S FHSM=$O(^FHPT("SM",FHSM)) Q:FHSM>FHEND!(FHSM="")  D
 .F FHDFN=0:0 S FHDFN=$O(^FHPT("SM",FHSM,FHDFN)) Q:FHDFN'>0  D
 ..S FHLOC=$P($G(^FHPT(FHDFN,"SM",FHSM,0)),U,3)
 ..I $P($G(^FH(119.6,FHLOC,0)),U,8)'=FHCOMM Q
 ..S FHMEAL=$P($G(^FHPT(FHDFN,"SM",FHSM,0)),U,9)
 ..Q:"BNE"'[FHMEAL!(FHMEAL="")
 ..S FHOPC(FHMEAL)=FHOPC(FHMEAL)+1
 ; Calculate Employee, Paid, OOD, Grat and Volunteer totals (Guest Meals)
 F FHGM=FHGM:0 S FHGM=$O(^FHPT("GM",FHGM)) Q:FHGM>FHEND!(FHGM="")  D
 .F FHDFN=0:0 S FHDFN=$O(^FHPT("GM",FHGM,FHDFN)) Q:FHDFN'>0  D
 ..S FHLOC=$P($G(^FHPT(FHDFN,"GM",FHGM,0)),U,5)
 ..I $P($G(^FH(119.6,FHLOC,0)),U,8)'=FHCOMM Q
 ..S FHCLASS=$P($G(^FHPT(FHDFN,"GM",FHGM,0)),U,2)
 ..Q:"EGOPV"'[FHCLASS!(FHCLASS="")
 ..S FHMEAL=$P($G(^FHPT(FHDFN,"GM",FHGM,0)),U,3)
 ..Q:"BNE"'[FHMEAL!(FHMEAL="")
 ..S FHOPC(FHCLASS,FHMEAL)=FHOPC(FHCLASS,FHMEAL)+1
 Q
