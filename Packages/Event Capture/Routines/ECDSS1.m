ECDSS1 ;BIR/RHK,JPW-Active/Inactive Procedure Report ;11/7/12  12:10
 ;;2.0;EVENT CAPTURE;**4,25,95,119**;8 May 96;Build 12
 ; Routine to report active and inactive procedures
START ; Routine execution
 N ECRAS S ECRAS=1  ;roll and scroll
 S DIR(0)="SO^A:Active Procedures;I:Inactive Procedures"
 S DIR("A")="Select Report"
 S DIR("?")="Enter an A for active procedures, I for inactive procedures, or ^ to quit."
 S DIR("??")="ECDSS1^"
 D ^DIR K DIR I $D(DIRUT) G END
 S ECRTN=Y
INACT ;list inact procs
 I ECRTN="I" D LISTI G END
ASK ;
 S DIR(0)="SO^N:National;L:Local;B:Both",DIR("A")="Select Preferred Report"
 S DIR("?,1")="Enter an N for National Procedures only, L for Local Procedures only,"
 S DIR("?")="B for a combined report, or ^ to quit."
 S DIR("??")="ECDSAC^" D ^DIR K DIR I $D(DIRUT) G END
 S ECRN=Y
SORT ;ask sort
 S DIR(0)="SO^P:Procedure Name;N:National Number",DIR("A")="Select Sort Method"
 S DIR("?")="Enter N to sort by National Number, P by Procedure Name, or ^ to quit."
 S DIR("??")="ECDSAC1^" D ^DIR K DIR I $D(DIRUT) G END
 S ECRD=Y
PRT ;start prints
 I $G(ECPTYP)="E" D EXPORT,^ECKILL Q  ;119
 I ECRN="N",ECRD="N" D LISTNN G END
 I ECRN="N",ECRD="P" D LISTNP G END
 I ECRN="L",ECRD="N" D LISTPN G END
 I ECRN="L",ECRD="P" D LISTPP G END
 I ECRN="B",ECRD="N" D LISTBN G END
 I ECRN="B",ECRD="P" D LISTBP
END ;kills var and quit
 W @IOF D ^ECKILL
 Q
LISTI ;all inact proc
 I $G(ECPTYP)="E" D EXPORT,^ECKILL Q  ;119
 W ! K DIC S DIC="^EC(725,",FLDS=".01,1,4,2",BY=".01",(FR,TO)="",L=0,DHD="NATIONAL/LOCAL PROCEDURE REPORT - INACTIVE",DIS(0)="I +$P(^EC(725,D0,0),""^"",3)" D EN1^DIP
 D MSG
 Q
LISTNN ;nat only by nat num
 W ! K DIC S DIC="^EC(725,",FLDS="1,4,.01",BY="1",(FR,TO)="",L=0,DHD="NATIONAL/LOCAL PROCEDURE REPORT - ACTIVE NATIONAL BY NATIONAL NUMBER",DIS(0)="I D0<90000,'$P(^EC(725,D0,0),""^"",3)" D EN1^DIP
 D MSG
 Q
LISTNP ;nat only by proc
 W ! K DIC S DIC="^EC(725,",FLDS=".01,1,4",BY=".01",(FR,TO)="",L=0,DHD="NATIONAL/LOCAL PROCEDURE REPORT - ACTIVE NATIONAL BY PROCEDURE",DIS(0)="I D0<90000,'$P(^EC(725,D0,0),""^"",3)" D EN1^DIP
 D MSG
 Q
LISTPN ;loc by nat num
 W ! K DIC S DIC="^EC(725,",FLDS="1,4,.01",BY="1",(FR,TO)="",L=0,DHD="NATIONAL/LOCAL PROCEDURE REPORT - ACTIVE LOCAL BY NATIONAL NUMBER",DIS(0)="I D0>89999,'$P(^EC(725,D0,0),""^"",3)" D EN1^DIP
 D MSG
 Q
LISTPP ;loc by proc
 W ! K DIC S DIC="^EC(725,",FLDS=".01,1,4",BY=".01",(FR,TO)="",L=0,DHD="NATIONAL/LOCAL PROCEDURE REPORT - ACTIVE LOCAL BY PROCEDURE",DIS(0)="I D0>89999,'$P(^EC(725,D0,0),""^"",3)" D EN1^DIP
 D MSG
 Q
LISTBN ;both by nat num
 W ! K DIC S DIC="^EC(725,",FLDS="1,4,.01",BY="1",(FR,TO)="",L=0,DHD="NATIONAL/LOCAL PROCEDURE REPORT - ACTIVE NATIONAL AND LOCAL BY NATIONAL NUMBER",DIS(0)="I '$P(^EC(725,D0,0),""^"",3)" D EN1^DIP
 D MSG
 Q
LISTBP ;both by proc
 W ! K DIC S DIC="^EC(725,",FLDS=".01,1,4",BY=".01",(FR,TO)="",L=0,DHD="NATIONAL/LOCAL PROCEDURE REPORT - ACTIVE NATIONAL AND LOCAL BY PROCEDURE",DIS(0)="I '$P(^EC(725,D0,0),""^"",3)" D EN1^DIP
 D MSG
 Q
MSG I $D(ECRAS) W !!,"Press <RET> to continue  " R X:DTIME
 Q
 ;
EXPORT ;Section added in patch 119
 N CNT,I,NM,DATA,IEN,INDEX
 S CNT=1,^TMP($J,"ECRPT",CNT)=$S($G(ECRD)="N":"NATIONAL NUMBER^CPT^NAME",1:"NAME^NATIONAL NUMBER^CPT")_$S($G(ECRTN)="I":"^INACTIVE DATE",1:"")
 S NM="",INDEX=$S($G(ECRD)="N":"E",1:"B") F  S NM=$O(^EC(725,INDEX,NM)) Q:NM=""  S I=0 F  S I=$O(^EC(725,INDEX,NM,I)) Q:'+I  D  K DATA
 .S IEN=I_","
 .D GETS^DIQ(725,IEN,".01;1;2;4",,"DATA")
 .I $G(ECRTN)="I"&(DATA(725,IEN,2)'="") S CNT=CNT+1,^TMP($J,"ECRPT",CNT)=DATA(725,IEN,.01)_U_DATA(725,IEN,1)_U_DATA(725,IEN,4)_U_DATA(725,IEN,2) Q  ;If sort by inactive and entry is inactive, store record
 .I $G(ECRTN)="A"&(DATA(725,IEN,2)="") D  ;If sort by active and entry is active, continue processing
 ..I $G(ECRN)="N"&(I>89999) Q  ;If looking for nation entries and entry has a local number, quit
 ..I $G(ECRN)="L"&(I<90000) Q  ;If looking for local entries and entry has a national number, quit
 ..;assume record should be counted
 ..S CNT=CNT+1,^TMP($J,"ECRPT",CNT)=$S($G(ECRD)="N":DATA(725,IEN,1)_U_DATA(725,IEN,4)_U_DATA(725,IEN,.01),1:DATA(725,IEN,.01)_U_DATA(725,IEN,1)_U_DATA(725,IEN,4))
 Q
