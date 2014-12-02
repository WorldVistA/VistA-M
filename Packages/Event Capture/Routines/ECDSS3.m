ECDSS3 ;BIR/RHK,JPW-Active/Inactive Category Report ;11/7/12  12:09
 ;;2.0;EVENT CAPTURE;**25,95,119**;8 May 96;Build 12
 ; Routine to report active and inactive procedures
START ; Routine execution
 N ECRAS S ECRAS=1  ;roll and scroll flag
 S DIR(0)="SO^A:Active Categories;I:Inactive Categories;B:Both"
 S DIR("A")="Select Report"
 S DIR("?",1)="Enter an A for Active Categories, I for Inactive Categories,"
 S DIR("?")="B for a consolidated report of all categories, or ^ to quit."
 S DIR("??")="ECDSS3^"
 D ^DIR K DIR I $D(DIRUT) G END
 S ECRTN=Y
ACT ;list active cats (LISTA)
INACT ;list inactive cats (LISTI)
ALL ;list all cats (LISTB)
 W ! D PRINT W @IOF
 Q
PRINT ;starts print for RPC
 I $G(ECPTYP)="E" D EXPORT,^ECKILL Q  ;119
 I ECRTN="A" D LISTA
 I ECRTN="I" D LISTI
 I ECRTN="B" D LISTB
END ; Kill variables and exit
 D ^ECKILL
 Q
LISTA ;list active categories
 K DIC S DIC="^EC(726,",FLDS=".01",BY=".01",(FR,TO)="",L=0,DHD="CATEGORY REPORT - ACTIVE",DIS(0)="I '$P(^EC(726,D0,0),""^"",3)" D EN1^DIP
 I $D(ECRAS) W !!,"Press <RET> to continue   " R X:DTIME
 Q
LISTI ;list inactive categories
 K DIC S DIC="^EC(726,",FLDS=".01,2;""INACTIVE DATE""",BY=".01",(FR,TO)="",L=0,DHD="CATEGORY REPORT - INACTIVE",DIS(0)="I +$P(^EC(726,D0,0),""^"",3)" D EN1^DIP
 I $D(ECRAS) W !!,"Press <RET> to continue   " R X:DTIME
 Q
LISTB ;list all cats
 K DIC S DIC="^EC(726,",FLDS=".01,2;""INACTIVE DATE""",BY=".01",(FR,TO)="",L=0,DHD="CATEGORY REPORT - BOTH ACTIVE AND INACTIVE" D EN1^DIP
 I $D(ECRAS) W !!,"Press <RET> to continue   " R X:DTIME
 Q
 ;
EXPORT ;Section added in patch 119
 N CNT,I,NM,NODE
 S CNT=1
 S ^TMP($J,"ECRPT",CNT)="NAME"_$S(ECRTN'="A":(U_"INACTIVE DATE"),1:"")
 S NM="" F  S NM=$O(^EC(726,"B",NM)) Q:NM=""  S I=0 F  S I=$O(^EC(726,"B",NM,I)) Q:'+I  D
 .S NODE=$G(^EC(726,I,0)) Q:NODE=""
 .I ECRTN="A" I $P(NODE,U,3)="" S CNT=CNT+1,^TMP($J,"ECRPT",CNT)=$P(NODE,U) Q
 .I ECRTN="B" S CNT=CNT+1,^TMP($J,"ECRPT",CNT)=$P(NODE,U)_U_$$FMTE^XLFDT($P(NODE,U,3)) Q
 .I ECRTN="I" I $P(NODE,U,3)'="" S CNT=CNT+1,^TMP($J,"ECRPT",CNT)=$P(NODE,U)_U_$$FMTE^XLFDT($P(NODE,U,3))
 Q
