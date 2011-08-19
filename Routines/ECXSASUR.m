ECXSASUR ;BIR/DMA-SAS Report from Surgery Extract; 19 Jul 95 / 11:13 AM
 ;;3.0;DSS EXTRACTS;**8**;Dec 22, 1997
EN ;entry point from menu option
 W @IOF,!!,"Surgery Extract SAS Report",!!
 ;ecxaud=1 for 'sas' audit
 S ECXHEAD="SUR",ECXAUD=1
 ;select extract
 D AUDIT^ECXUTLA(ECXHEAD,.ECXERR,.ECXARRAY,ECXAUD)
 I ECXERR D AUDIT^ECXKILL Q
 ;select all surgery sites/divisions
 S ECXALL=1 D SUR^ECXDVSN2(.ECXDIV,ECXALL,.ECXERR)
 I ECXERR D AUDIT^ECXKILL Q
 W !!
 S ECXPGM="PROCESS^ECXSASUR",ECXDESC="Surgery Extract SAS Report"
 S ECXSAVE("ECXHEAD")="",ECXSAVE("ECXDIV(")="",ECXSAVE("ECXARRAY(")=""
 W !
 D DEVICE^ECXUTLA(ECXPGM,ECXDESC,.ECXSAVE)
 I ECXSAVE("POP")=1 D  Q
 .W !!,?5,"Try agian later... exiting.",!
 .D AUDIT^ECXKILL
 I ECXSAVE("ZTSK")=0 D
 .K ECXSAVE,ECXPGM,ECXDESC
 .D PROCESS
 I IO'=IO(0) D ^%ZISC
 D HOME^%ZIS
 D AUDIT^ECXKILL
 Q
 ;
PROCESS ;queued entry
 N J,JJ,X,Y,SS,LN,PG,DIV,EC,EC16,EC31,ECF1,ECFK,ECFL,ECFLNM,ECFLX,ECFX,QFLG,TOT,F1,F1SUB,F1NM,F2,F2SUB,F2NM,FL,DIQ,DR,DA,DIR,DIRUT,DTOUT,DUOUT
 K ^TMP($J,"ECXAUD")
 S ECXEXT=ECXARRAY("EXTRACT"),ECXDEF=ECXARRAY("DEF")
 S (QFLG,PG)=0,$P(LN,"-",80)=""
 ;get run date in external format
 D NOW^%DTC S Y=$E(%,1,12) D DD^%DT S ECXRUN=Y
 ;setup array of feeder location names
 F F1=1:1:14 S X=$P($T(FEED1+F1),";",3),F1SUB=$P(X,U,1),F1NM=$P(X,U,2) S ^TMP($J,"ECXFL","OR"_F1SUB)=F1NM D
 .F F2=1:1:7 S X=$P($T(FEED2+F2),";",3),F2SUB=$P(X,U,1),F2NM=$P(X,U,2) S ^TMP($J,"ECXFL","OR"_F1SUB_F2SUB)=F1NM_" - "_F2NM,FL(F2SUB)=F2NM
 ;process extract records
 ;type='p'rimary or 's'econdary or 'i'mplant
 ;ignore type=secondary
 S J="" F  S J=$O(^ECX(727.811,"AC",ECXEXT,J)) Q:'J  I $D(^ECX(727.811,J,0)) S EC=^(0),DIV=$P(EC,U,4) I $P(EC,U,17)'="S",$P(EC,U,28)'="C" D
 .;determine feeder location
 .S ECF1=$E($P(EC,U,32),1,4)
 .I ECF1="" D
 ..S ECF1=$P(EC,U,30),ECF1="OR"_$E("GEORCANECNAMINENCYWACLDEOT",ECF1*2-1,ECF1*2)
 ..S:ECF1="OR" ECF1="ORNO"
 ..I $P(EC,U,30)="",$P(EC,U,12)="",$P(EC,U,11)="059" S ECF1="ORCY"
 .S ECFL=DIV_ECF1
 .;determine surgical specialty
 .S ECSS=$P(EC,U,11) S:ECSS="" ECSS=999 I $P(EC,U,32)'="" S ECSS="NON"
 .;type=implant generates one product record; volume is always at least 1
 .I $P(EC,U,17)="I" D  Q
 ..S ECFLX=ECFL_"I",ECFK=ECSS_"-"_$$RJ^XLFSTR($P(EC,U,23),5,0)
 ..S ECQ=$P(EC,U,24) S:'ECQ ECQ=1
 ..S ^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFLX,ECFK))+ECQ
 .;type=primary generates four or five product records, but only two are of interest here
 .;anesthesia time product
 .S ECQ=+$P(EC,U,22) I ECQ>0 D
 ..S ECFLX=ECFL_"A",EC16=$P(EC,U,16)
 ..S ECD=$S(EC16="G":1,EC16="L":3,EC16="S":4,EC16="E":4,EC16="M":7,EC16="":6,1:5)
 ..S ECFK=ECSS_"-"_"2"_ECD
 ..S ^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFLX,ECFK))+ECQ
 .;surgeon time product
 .S ECQ=+$P(EC,U,21) I ECQ>0 D
 ..S EC31=+$P(EC,U,31),ECFX=$S(EC31=10:"D",EC31=24:"M",EC31=32:"P",EC31=43:"C",1:"S")
 ..S ECFLX=ECFL_ECFX
 ..S ECFK=ECSS_"-40"
 ..S ^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFLX,ECFK))+ECQ
 .;patient time product
 .S ECQ=+$P(EC,U,20) I ECQ>0 D
 ..S ECFK=ECSS_"-10"
 ..S ^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+ECQ
 .;recovery room time product only if not cystoscopy and not non-or
 .I ECFL'="ORCY",$P(EC,U,32)="" D
 ..S ECQ=+$P(EC,U,33) I ECQ>0 D
 ...S ECFK=ECSS_"-60"
 ...S ^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+ECQ
 .;technician time product, only for cystoscopy
 .I ECFL="ORCY" D
 ..S ECQ=+$P(EC,U,20) S:($P(EC,U,22)>$P(EC,U,20)) ECQ=+$P(EC,U,22) I ECQ>0 D
 ...S ECFK=ECSS_"-70"
 ...S ^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+ECQ
 .;cleanup time product
 .S ECQ=2 D
 ..S ECFK=ECSS_"-30"
 ..S ^(ECFK)=$G(^TMP($J,"ECXAUD",DIV,ECFL,ECFK))+ECQ
 ;print the report
 U IO
 S DIV="" F  S DIV=$O(^TMP($J,"ECXAUD",DIV)) Q:DIV=""  D  Q:QFLG
 .D HEADER
 .S ECFL="" F  S ECFL=$O(^TMP($J,"ECXAUD",DIV,ECFL)) Q:ECFL=""  D  Q:QFLG
 ..S DIVL=$L(DIV),ECFLX=$E(ECFL,DIVL+1,99),ECFLNM=$G(^TMP($J,"ECXFL",ECFLX)) S:ECFLNM="" ECFLNM="NON-OR"
 ..I ECFLNM="NON-OR" D
 ...S F2SUB=$E(ECFLX,5),F2NM=""
 ...S:F2SUB]"" F2NM=$G(FL(F2SUB)) S:F2NM]"" ECFLNM=ECFLNM_" - "_F2NM
 ..D:($Y+3>IOSL) HEADER Q:QFLG  W !,ECFL,?12,ECFLNM
 ..S ECFK="" F  S ECFK=$O(^TMP($J,"ECXAUD",DIV,ECFL,ECFK)) Q:ECFK=""  S TOT=^(ECFK) D  Q:QFLG
 ...D:($Y+3>IOSL) HEADER Q:QFLG  W ?48,ECFK,?68,$$RJ^XLFSTR(TOT,6," "),!
 ;close
 I $E(IOST)'="C" W @IOF
 I $E(IOST)="C",'QFLG D
 .S SS=22-$Y F JJ=1:1:SS W !
 .S DIR(0)="E" W ! D ^DIR K DIR
 D AUDIT^ECXKILL
 Q
HEADER ;print the header
 N ECXTAB
 S ECXTAB=48
 D SASHEAD^ECXUTLA(DIV,ECXHEAD,.ECXDIV,.ECXARRAY,.PG,ECXTAB)
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
