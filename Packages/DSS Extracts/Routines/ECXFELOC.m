ECXFELOC ;BIR/DMA,CML-Print Feeder Locations; [ 05/07/96  8:41 AM ] ;5/20/19  11:24
 ;;3.0;DSS EXTRACTS;**1,8,105,132,136,149,174**;Dec 22, 1997;Build 33
EN ;entry point from option
 W !!,"Print list of feeder locations.",! S QFLG=1
 N ECXPORT,CNT,DIR,X,Y,DTOUT,DUOUT,ZTDESC,ZTRTN,ZTSAVE,ECY,SIEN,DIRUT ;149,174
 S DIR("?")="Select one or more feeder key systems to display" ;174
 S DIR("A")="Enter a list or range of numbers (1-9) or hit enter for all: ",DIR("B")="1-9" ;174
 W !,"Select : 1. CLI",!,?9,"2. ECS",!,?9,"3. IVP",!,?9,"4. LAB",!,?9,"5. PRE",!,?9,"6. PRO",!,?9,"7. RAD",!,?9,"8. SUR",!,?9,"9. UDP",! S DIR(0)="LA^1:9" D ^DIR Q:$D(DIRUT)  ;136,149,174
 K DIR S ECY=Y ;174
 S ECXPORT=$$EXPORT^ECXUTL1 Q:ECXPORT=-1  ;149
 I $G(ECXPORT) D  Q  ;Section added in 149
 .K ^TMP($J)
 .S ^TMP($J,"ECXPORT",0)="FEEDER SYSTEM^FEEDER LOCATION^DIVISION^DESCRIPTION",CNT=1 ;174
 .D START
 .D EXPDISP^ECXUTL1
 K %ZIS S %ZIS="Q" D ^%ZIS Q:POP 
 I $D(IO("Q")) S ZTDESC="Feeder Location List (DSS)",ZTRTN="START^ECXFELOC",ZTSAVE("ECY")="" D ^%ZTLOAD D ^%ZISC G OUT ;174
START ;queued entry point
 N ECLIST,EC ;174
 I '$D(DT) S DT=$$HTFM^XLFDT(+$H)
 K:'$G(ECXPORT) ^TMP($J) S (QFLG,PG)=0,$P(LN,"-",81)="" ;149
 F ECLIST=1:1 S EC=$P(ECY,",",ECLIST) Q:EC=""  D:EC=1 CLI D:EC=2 ECS D:EC=3 IV D:EC=4 LAB D:EC=5 PRE D:EC=6 PRO D:EC=7 RAD D:EC=8 SUR D:EC=9 UDP ;174
 U IO D PRINT ;174
 Q  ;174
LAB S EC=0 F  S EC=$O(^LRO(68,EC)) Q:'EC  S SIEN=0 F  S SIEN=$O(^LRO(68,EC,3,SIEN)) Q:'+SIEN  S EC1=$G(^LRO(68,EC,0)),^TMP($J,"LAB",$P(EC1,U,11),EC)=$$RADDIV^ECXDEPT($P(^LRO(68,EC,3,SIEN,0),U))_U_$P(EC1,U) ;174
 Q  ;174
ECS S EC=0 F  S EC=$O(^ECJ(EC)) Q:'EC  I $D(^(EC,0)) S EC1=$P(^(0),"-",1,2),EC2=$P($G(^ECD(+$P(EC1,"-",2),0)),U),^TMP($J,"ECS",EC1,EC1)=$$RADDIV^ECXDEPT($P(EC1,"-"))_U_EC2 ;174
 F  S EC=$O(^ECK(EC)) Q:'EC  I $D(^(EC,0)) S EC1=$P(^(0),"-",1,2),EC2=$P($G(^ECD(+$P(EC1,"-",2),0)),U),^TMP($J,"ECS",EC1,EC1)=EC2
 Q  ;174
IV S EC=0 F  S EC=$O(^DG(40.8,EC)) Q:'EC  I $D(^DG(40.8,EC,0)) S EC1=$E($P(^(0),U),1,30),^TMP($J,"IVP","IVP"_EC,EC)=$$GETDIV^ECXDEPT(EC)_U_"IV Pharmacy-"_EC1 ;174
 Q  ;174
CLI S EC=0 F  S EC=$O(^SC(EC)) Q:'EC  I $D(^(EC,0)) S EC1=^(0),ECS=$P(EC1,U,15),ECSC=$P($G(^DIC(40.7,+$P(EC1,U,7),0)),U,2),ECD=$P(EC1,U) S:'ECS ECS=1 D
 .I $P(EC1,U,17)'="Y",$P(EC1,U,3)="C" S DAT=$G(^SC(EC,"I")),ID=+DAT,RD=$P(DAT,U,2) I 'ID!(ID>DT)!(RD&(RD<DT)) S ^TMP($J,"CLI",ECS_ECSC,EC)=$$GETDIV^ECXDEPT(ECS)_U_ECD ;174
 Q  ;174
PRE N ARRAY S ARRAY="^TMP($J,""ECXDSS"")" K @ARRAY D PSS^PSO59(,"??","ECXDSS") I @ARRAY@(0)>0 G V6
 ;dbia (#4689)
 S EC=0 F  S EC=$O(^DIC(59,EC)) Q:'EC  I $D(^(EC,0)) S EC1=$E($P(^(0),U),1,30),^TMP($J,"PRE","PRE"_EC,EC)="Prescriptions-"_EC1
 Q  ;174
V6 S EC=0 F  S EC=$O(@ARRAY@(EC)) Q:'EC  I $D(^(EC)) S EC1=$E(@ARRAY@(EC,.01),1,30),^TMP($J,"PRE","PRE"_EC,EC)=$G(@ARRAY@(EC,.06))_U_"Prescriptions-"_EC1 ;174
 K @ARRAY
 Q  ;174
RAD S EC=0 F  S EC=$O(^RA(79,EC)),EC1=0 Q:'EC  I $D(^(EC,0)) S ECD=$P(^(0),U) F  S EC1=$O(^RA(79.2,EC1)) Q:'EC1  I $D(^(EC1,0)) S ECD1=$P(^(0),U),^TMP($J,"RAD",EC_"-"_EC1,EC_"-"_EC1)=$$RADDIV^ECXDEPT(ECD)_U_ECD_"-"_ECD1 ;174
 Q  ;174
NUR ;S EC=0 F  S EC=$O(^NURSF(211.4,EC)) Q:'EC  I $D(^(EC,0)) S EC1=$P(^(0),U),EC1=$P($G(^SC(+EC1,0)),U),^TMP($J,"NUR",EC,EC)=EC1 ;132
 Q  ;174
SUR ;174, Updated surgery section
 N J,X,DIV,EC,EC31,ECF1,ECFL,ECFLX,ECFX,F1,F1SUB,F1NM,F2,F2SUB,F2NM,FL
 K ^TMP($J,"ECXAUD")
 ;setup array of feeder location names
 F F1=1:1:14 S X=$P($T(FEED1+F1),";",3),F1SUB=$P(X,U,1),F1NM=$P(X,U,2) S ^TMP($J,"ECXFL","OR"_F1SUB)=F1NM D
 .F F2=1:1:7 S X=$P($T(FEED2+F2),";",3),F2SUB=$P(X,U,1),F2NM=$P(X,U,2) S ^TMP($J,"ECXFL","OR"_F1SUB_F2SUB)=F1NM_" - "_F2NM,FL(F2SUB)=F2NM
 ;process extract records
 ;type='p'rimary or 's'econdary or 'i'mplant
 ;ignore type=secondary
 S J=0 F  S J=$O(^ECX(727.811,J)) Q:'J  I $D(^ECX(727.811,J,0)) S EC=^(0),DIV=$P(EC,U,4) I $P(EC,U,17)'="S",$P(EC,U,28)'="C" D
 .;determine feeder location
 .S ECF1=$E($P(EC,U,32),1,4)
 .I ECF1="" D
 ..S ECF1=$P(EC,U,30),ECF1="OR"_$E("GEORCANECNAMINENCYWACLDEOT",ECF1*2-1,ECF1*2)
 ..S:ECF1="OR" ECF1="ORNO"
 ..I $P(EC,U,30)="",$P(EC,U,12)="",$P(EC,U,11)="059" S ECF1="ORCY"
 .S ECFL=DIV_ECF1
 .;type=implant generates one product record; volume is always at least 1
 .I $P(EC,U,17)="I" D  Q
 ..S ECFLX=ECFL_"I"
 ..S ^TMP($J,"SUR",ECFLX,ECFLX)=$$RADDIV^ECXDEPT(DIV)_U_$S($G(^TMP($J,"ECXFL",ECF1_"I"))'="":^TMP($J,"ECXFL",ECF1_"I"),1:"NON-OR"_" - "_$G(FL("I")))
 .;type=primary generates four or five product records, but only two are of interest here
 .;anesthesia time product
 .S ECQ=+$P(EC,U,22) I ECQ>0 D
 ..S ECFLX=ECFL_"A"
 ..S ^TMP($J,"SUR",ECFLX,ECFLX)=$$RADDIV^ECXDEPT(DIV)_U_$S($G(^TMP($J,"ECXFL",ECF1_"A"))'="":^TMP($J,"ECXFL",ECF1_"A"),1:"NON-OR"_" - "_$G(FL("A")))
 .;surgeon time product
 .S ECQ=+$P(EC,U,21) I ECQ>0 D
 ..S EC31=+$P(EC,U,31),ECFX=$S(EC31=10:"D",EC31=24:"M",EC31=32:"P",EC31=43:"C",1:"S")
 ..S ECFLX=ECFL_ECFX
 ..S ^TMP($J,"SUR",ECFLX,ECFLX)=$$RADDIV^ECXDEPT(DIV)_U_$S($G(^TMP($J,"ECXFL",ECF1_ECFX))'="":^TMP($J,"ECXFL",ECF1_ECFX),1:"NON-OR"_" - "_$G(FL(ECFX)))
 .;patient time product
 .S ECQ=+$P(EC,U,20) I ECQ>0 D
 ..S ^TMP($J,"SUR",ECFL,ECFL)=$$RADDIV^ECXDEPT(DIV)_U_$S($G(^TMP($J,"ECXFL",ECF1))'="":^TMP($J,"ECXFL",ECF1),1:"NON-OR")
 .;recovery room time product only if not cystoscopy and not non-or
 .I ECFL'="ORCY",$P(EC,U,32)="" D
 ..S ECQ=+$P(EC,U,33) I ECQ>0 D
 ...S ^TMP($J,"SUR",ECFL,ECFL)=$$RADDIV^ECXDEPT(DIV)_U_$S($G(^TMP($J,"ECXFL",ECF1))'="":^TMP($J,"ECXFL",ECF1),1:"NON-OR")
 .;technician time product, only for cystoscopy
 .I ECFL="ORCY" D
 ..S ECQ=+$P(EC,U,20) S:($P(EC,U,22)>$P(EC,U,20)) ECQ=+$P(EC,U,22) I ECQ>0 D
 ...S ^TMP($J,"SUR",ECFL,ECFL)=$$RADDIV^ECXDEPT(DIV)_U_$S($G(^TMP($J,"ECXFL",ECF1))'="":^TMP($J,"ECXFL",ECF1),1:"NON-OR")
 .S ^TMP($J,"SUR",ECFL,ECFL)=$$RADDIV^ECXDEPT(DIV)_U_$S($G(^TMP($J,"ECXFL",ECF1))'="":^TMP($J,"ECXFL",ECF1),1:"NON-OR")
 K ^TMP($J,"ECXFL")
 Q
 ;
UDP S EC=0 F  S EC=$O(^DG(40.8,EC)) Q:'EC  I $D(^DG(40.8,EC,0)) S EC1=$E($P(^(0),U),1,30),^TMP($J,"UDP","UDP"_EC,EC)=$$GETDIV^ECXDEPT(EC)_U_"Unit Dose Medications-"_EC1 ;174
 Q  ;174
DEN ;S EC=0 F  S EC=$O(^DENT(225,EC)) Q:'EC  I $D(^(EC,0)) S EC1=$P(^(0),U),^TMP($J,"DEN",EC1,EC)="Dental "_EC1
PRO ;Prosthetics Location Information. API added in patch 136
 N IEN,LOC,DIV,X,ORDER
 S IEN=0 F  S IEN=$O(^ECX(727.826,IEN)) Q:'+IEN  S LOC=$P($G(^ECX(727.826,IEN,0)),U,10) I LOC'="" S:'$D(LOC(LOC)) LOC(LOC)=""
 S LOC="" F  S LOC=$O(LOC(LOC)) Q:LOC=""  D
 .S DIV=$P(LOC,$S(LOC["NONL":"NONL",LOC["ORD":"ORD",LOC["HO2":"HO2",LOC["LAB":"LAB",1:""),1) I DIV="" S DIV=+LOC
 .S DIC=4,DIC(0)="MXQ",X=DIV D ^DIC Q:Y=-1
 .S ORDER=$P(LOC,DIV,2)
 .S ^TMP($J,"PRO",LOC,LOC)=$$RADDIV^ECXDEPT(DIV)_U_$P(Y,U,2)_" "_$S(ORDER="HO2":"Home Oxygen",ORDER="NONL":"Non Lab Location",ORDER="LAB":"Prosthetics Lab",ORDER="ORD":"Ordering Location",1:"") ;174
 Q  ;174
 ;
PRINT ;
 S EC="" F  S EC=$O(^TMP($J,EC)),EC1="" Q:EC=""  Q:QFLG  D:'$G(ECXPORT) HEAD Q:QFLG  F  S EC1=$O(^TMP($J,EC,EC1)),EC2=""  Q:EC1=""  Q:QFLG  F  S EC2=$O(^TMP($J,EC,EC1,EC2)) Q:EC2=""  Q:QFLG  D  ;149
 .I $G(ECXPORT) S ^TMP($J,"ECXPORT",CNT)=EC_U_EC1_U_^(EC2),CNT=CNT+1 Q  ;149
 .W !,EC1,?18,$P(^(EC2),U),?28,$P(^(EC2),U,2) I $Y+3>IOSL D HEAD Q:QFLG  ;174
OUT I '$G(ECXPORT) I $E(IOST)="C"&('QFLG) S DIR(0)="E" D  D ^DIR K DIR ;149
 .S SS=22-$Y F JJ=1:1:SS W !
 K:'$G(ECXPORT) ^TMP($J) K DAT,EC,EC1,EC2,EC3,ECD,ECD1,ECS,ECSC,ID,JJ,LN,PG,POP,QFLG,RD,SS,X,Y ;149
 I '$G(ECXPORT) W:$E(IOST)'="C" @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" Q  ;149
 Q  ;149
HEAD ;
 I $E(IOST)="C" S SS=22-$Y F JJ=1:1:SS W !
 I $E(IOST)="C",PG>0 S DIR(0)="E" W ! D ^DIR K DIR I 'Y S QFLG=1 Q
 S PG=PG+1 W:$Y!($E(IOST)="C") @IOF W !,?15,"Feeder Location List For Feeder System ",EC,?70,"Page: ",PG,!!,"FEEDER LOCATION",?18,"DIVISION",?28,"DESCRIPTION",!,LN ;174
 Q
 ;
FEED1 ;or location names
 ;;AM^AMBULATORY OR
 ;;CA^CARDIAC OR
 ;;CL^CLINIC
 ;;CN^CARDIAC/NEURO OR
 ;;CY^CYSTOSCOPY RM.
 ;;DE^DEDICATED RM.
 ;;EN^ENDOSCOPY RM.
 ;;GE^GENERAL OR
 ;;IN^ICU
 ;;NE^NEUROSURGERY OR
 ;;NO^UNKNOWN
 ;;OR^ORTHOPEDIC OR
 ;;OT^OTHER LOCATION
 ;;WA^WARD
 ;
FEED2 ;service location names
 ;;A^ANESTHESIA
 ;;I^IMPLANTS
 ;;C^SPINAL CORD
 ;;D^DENTAL
 ;;M^MEDICINE
 ;;P^PSYCH
 ;;S^SURGERY
 ;
