RCAM ;WASH-ISC@ALTOONA,PA/RGY-Manager Debtor Information ;12/19/96  12:48 PM
V ;;4.5;Accounts Receivable;**34,190,198,223,359,438,441,443**;Mar 20, 1995;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRCA*4.5*359 Ensure displayed phone is correct format: 111-222-3333
 ;
 NEW DIC,DIE,DIR,DIRUT,DUOUT,DTOUT,DR,DA,Y
 F  W ! S DIC="^RCD(340,",DIC(0)="QEAM" D ^DIC Q:Y<0  S DA=+Y,DR=$S($P(Y,U,2)["DPT(":".02;",$P(Y,U,2)[";DIC(36,":".05;",$P(Y,U,2)[";DIC(4,":".05;",1:"")_2,DIE="^RCD(340," D ^DIE
 Q
EDT ;Select AR Debtor address information
 NEW DIC,Y,RCDB
 N DPTNOFZY,DPTNOFZK S (DPTNOFZY,DPTNOFZK)=1
 F  W ! S DIC="^RCD(340,",DIC(0)="QEAM" D ^DIC Q:Y<0  D EN1($P(^RCD(340,+Y,0),U)) Q:$D(DTOUT)
 Q
EN1(RCDB) ;Edit Debtor address  PRCA*4.5*443
 N AUDFLG,RCDB0
 S RCDB0=$O(^RCD(340,"B",RCDB,0))
 S AUDFLG=$S(RCDB["DPT(":$$ASKAUD(),1:0) Q:AUDFLG<0
 D DIS(RCDB)
 I AUDFLG D GETAUD(340,RCDB0),DISPAUD
 I $$ASKEDT()'>0 Q
 I RCDB["VA(200" D PER(RCDB) Q
 I RCDB["DPT(" D PAT(RCDB) Q
 I RCDB["PRC(440" D VEN(RCDB) Q
 I RCDB["DIC(4" D INST(RCDB) Q
 I RCDB["DIC(36" D INSUR(RCDB)
 Q
PER(RCDB) ;Edit person address
 NEW DA,DIE,DR
 S DA=+RCDB,DIE="^VA(200,",DR=".111;.112;.113;.114;.115;.116;.131" D ^DIE
 Q
INSUR(RCDB) ;Edit insurance address
 W !!,"Sorry, edit to the insurance file must be done via MAS",!!
 Q
PAT(RCDB) ;Edit Patient Address
 N RCAD,DIR,DIRUT,DUOUT,DIROUT,DA,DIE,DR,ADR1,ADR2,ADR3
 S ADR1=$$PAT^RCAMADD(+RCDB,0) ;permanent address
 S ADR2=$$PAT^RCAMADD(+RCDB,1) ;confidential mailing address
 S ADR3=$$ARDEB^RCAMADD(RCDB0) ;accounts receivable address
 W !,"Address from Patient file: " I ADR2'="" W ?40,"Confidential Address from Patient file:"
 W ! D DIS2(ADR1,ADR2)
 W !,"Address from AR Debtor file: "
 W ! D DIS2(ADR3,"")
 I '$D(^XUSEC("PRCA MED DEBTOR EDIT",DUZ)) D  Q  ; PRCA*4.5*438
 .W !,"Unable to edit this debtor's AR Debtor Address."
 .W !,"A Medical Debtor's address is locked by the PRCA MED DEBTOR EDIT security key."
 .W !,"Please contact Enrollment to have the Debtor's Confidential Address updated.",!
 .Q
PAT1 S DA=RCDB0
 N RCDA,X1,X2 ;  PRCA*4.5*443
 S DIR("B")=$S($P($G(^RCD(340,+RCDB0,1)),U,9):"YES",1:"NO")
 S DIR(0)="340,1.09^AO" D ^DIR
 G:$D(DIRUT) Q1
 S DIE="^RCD(340,",DR="1.09////"_Y D ^DIE ;  PRCA*4.5*443
 S DR="[RCAM ADDRESS EDIT]" D ^DIE ;  PRCA*4.5*443
 I $P($G(^RCD(340,+RCDB0,1)),U,9) D
 .N DIK,DA,DR
 .S DA=$O(^RC(341,"AD",+RCDB0,2,0))
 .Q:'DA  S DA=$O(^RC(341,"AD",+RCDB0,2,DA,0))
 .Q:'DA
 .Q:'$P($G(^RC(341,+DA,0)),U,7)
 .S RCDA=DA
 .S X1=DT,X2=$P($G(^RC(341,+DA,0)),U,7) D ^%DTC
 .Q:X>90
 .S DA=RCDA
 .S DIK="^RC(341,"
 .D ^DIK
 .S DA="" F  S DA=$O(^PRCA(430,"AS",+RCDB0,16,DA)) Q:'DA  I $G(^PRCA(430,+DA,6)) S $P(^PRCA(430,+DA,6),U,7)="" F DA(1)=1:1:3 S $P(^PRCA(430,+DA,6),U,DA(1))=""
CHK ;Check Address for patients
 S Y=0,RCAD=$G(^RCD(340,RCDB0,1)) F X=1,4,5,6 I $P(RCAD,U,X)]"" S Y=Y+1
 I $P(RCAD,U,8)]"" S Y=Y+1
 I Y=4!'Y G Q1
 I $P(RCAD,U)]"",$P(RCAD,U,4)]"",$P(RCAD,U,5)]"",$P(RCAD,U,6)]"" G Q1
 I $P(RCAD,U)]"",$P(RCAD,U,4)]"",$P(RCAD,U,5)]"",$P(RCAD,U,8)]"" G Q1
 W !!,"*** WARNING: There appears to be incomplete address information",!
 I $D(DTOUT) D DELA S DTOUT=1 G Q1
 W ! S DIR(0)="YA",DIR("B")="YES",DIR("A")="Do you want to re-edit the information? " D ^DIR
 G:Y PAT1 D DELA
Q1 Q
DELA ;Delete AR debtor address information
 S DA=RCDB0,DIE="^RCD(340,",DR="1.01///@;1.02///@;1.03///@;1.04///@;1.05///@;1.06///@" D ^DIE W !,"*** Old address information deleted from AR address file ***",!
 Q
INST(RCDB) ;Edit institution
 W !!,"You are not authorized to edit Institution file",!!  ; PRCA*4.5*441
 Q
VEN(RCDB) ;Edit Vendor file
 NEW DA,DIE,DR
 S DA=+RCDB,DIE="^PRC(440,",DR="22.1;22.2;22.3;22.4;22.5;22.6;22.7" D ^DIE
 Q
DIS(RCDB) ;Display address information
 N RCCONF,ADR1,ADR2,RCNAM
 G:'$D(^RCD(340,+RCDB0,0)) Q3
 S RCNAM=$$NAM^RCFN01(RCDB0) ;debtor name
 S ADR1=$$DADD^RCAMADD(RCDB),ADR2=""
 I RCDB["DPT(" S ADR2=$$PAT^RCAMADD(+RCDB,1) ;get veteran's confidential address, if any
 W @IOF,!,"Address Accounts Receivable will use: "
 I ADR2'="" W ?40,"Address for mailing to veteran:"
 W !!
 W ?3,RCNAM I ADR2'="" W ?42,RCNAM
 D DIS2(ADR1,ADR2)
 I $P($G(^RCD(340,RCDB0,0)),U,7)=1 D
 . W ?3,"Large print needed on statements: YES",!
Q3 Q
DIS1 ;
 I $L($P(X,U,6))>5 S $P(X,U,6)=$E($P(X,U,6),1,5)_"-"_$E($P(X,U,6),6,9)   ;PRCA*4.5*359
 W !?5,$P(X,U) W:$P(X,U,2)]"" !?5,$P(X,U,2) W:$P(X,U,3)]"" !?5,$P(X,U,3) W:$P(X,U,4)]"" !?5,$P(X,U,4),", ",$P(X,U,5)," ",$P(X,U,6) W:$P(X,U,7)'="" !?5,"Phone: ",$P(X,U,7) W !
 Q
 ; Display two addresses in two columns.
DIS2(ADR1,ADR2) N TAB1,TAB2
 S TAB1=3,TAB2=42
 I ($P(ADR1,U,1)'="")!($P(ADR2,U,1)'="") W !?TAB1,$P(ADR1,U,1) I $P(ADR2,U,1)'="" W " ",?TAB2,$P(ADR2,U,1)
 I ($P(ADR1,U,2)'="")!($P(ADR2,U,2)'="") W !?TAB1,$P(ADR1,U,2) I $P(ADR2,U,2)'="" W " ",?TAB2,$P(ADR2,U,2)
 I ($P(ADR1,U,3)'="")!($P(ADR2,U,3)'="") W !?TAB1,$P(ADR1,U,3) I $P(ADR2,U,3)'="" W " ",?TAB2,$P(ADR2,U,3)
 I ($P(ADR1,U,4)'="")!($P(ADR2,U,4)'="") W ! D
 . I $L($P(ADR1,U,6))>5,$P(ADR1,U,6)'["-" S $P(ADR1,U,6)=$E($P(ADR1,U,6),1,5)_"-"_$E($P(ADR1,U,6),6,9)   ;PRCA*4.5*359
 . W:$P(ADR1,U,4)'="" ?TAB1,$P(ADR1,U,4),", ",$P(ADR1,U,5)," ",$P(ADR1,U,6)
 . W:$P(ADR2,U,4)'="" " ",?TAB2,$P(ADR2,U,4),", ",$P(ADR2,U,5)," ",$P(ADR2,U,6)
 I $P(ADR1,U,7)?10N D    ;PRCA*4.5*359
 . N RCPHN
 . S RCPHN=$P(ADR1,U,7),RCPHN=$E(RCPHN,1,3)_"-"_$E(RCPHN,4,6)_"-"_$E(RCPHN,7,10)
 . S $P(ADR1,U,7)=RCPHN
 W:$P(ADR1,U,7)'="" !?TAB1,"Phone: ",$P(ADR1,U,7) ; conf address doesn't have phone no.
 W !
 Q
FOL ;Called by input transform from 341,4.02
 I X<$P($G(^RC(341,DA,0)),U,6) W !!,*7,"Follow-up Date is before Date of Contact",! K X Q
 I $P($G(^RC(341,DA,0)),U,6)="" W !!,*7,"Date of Contact does not exist!",! K X Q
 Q
 ;
ASKEDT() ; display "edit address" prompt  PRCA*4.5*443
 ;
 ; returns 1 for "yes", 0 for "no", or -1 for user exit / timeout
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 W !
 S DIR("A")="Would you like to Edit the AR Debtor Address? (Y/N): "
 S DIR(0)="YA"
 D ^DIR
 I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q $S(+Y=1:1,1:0)
 ;
ASKAUD() ; display "view audit history" prompt  PRCA*4.5*443
 ;
 ; returns 1 for "yes", 0 for "no", or -1 for user exit / timeout
 ;
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 W !
 S DIR("A")="Do you wish to view the AR Debtor Address change history? (Y/N): "
 S DIR(0)="YA"
 D ^DIR
 I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q $S(+Y=1:1,1:0)
 ;
GETAUD(FILE,IEN) ; get audit file data  PRCA*4.5*443
 ;
 ; FILE - file # to get audit data for
 ; IEN - ien in FILE to get audit data for
 ;
 ; sets global ^TMP("AUD",$J,n) = user (1.1/.04) ^ field changed (1.1/.03) ^ old value (1.1/2) ^ new value (1.1/3), where n is a sequential counter
 ; sets global ^TMP("AUD",$J,"IDX",timestamp (1.1/.02),n)=""
 ;
 N AUDIEN,N0,TSTAMP
 I $G(FILE)'>0 Q
 I $G(IEN)'>0 Q
 K ^TMP("AUD",$J)
 S (AUDIEN,CNT)=0 F  S AUDIEN=$O(^DIA(FILE,"B",IEN,AUDIEN)) Q:'AUDIEN  D
 .S N0=$G(^DIA(FILE,AUDIEN,0)),TSTAMP=$P(N0,U,2)
 .S CNT=CNT+1,^TMP("AUD",$J,CNT)=$P(N0,U,4)_U_$P(N0,U,3)_U_$G(^DIA(FILE,AUDIEN,2))_U_$G(^DIA(FILE,AUDIEN,3))
 .S ^TMP("AUD",$J,"IDX",TSTAMP,CNT)=""
 .Q
 Q
 ;
DISPAUD ; display audit file data  PRCA*4.5*443
 ;
 ; uses global ^TMP("AUD",$J) that is populated by tag GETAUD
 ;
 N CNT,DATA,FLD,LN,NEWVAL,OLDVAL,PAGE,TSTAMP
 S PAGE=0
 D AUDHDR
 I '$D(^TMP("AUD",$J)) W !!,$$CJ^XLFSTR("No address change history found.",80) Q
 S TSTAMP="" F  S TSTAMP=$O(^TMP("AUD",$J,"IDX",TSTAMP),-1) Q:TSTAMP=""  D
 .S CNT=0 F  S CNT=$O(^TMP("AUD",$J,"IDX",TSTAMP,CNT)) Q:'CNT  D
 ..S DATA=^TMP("AUD",$J,CNT)
 ..D FIELD^DID(340,$P(DATA,U,2),,"LABEL","FLD")
 ..I LN>(IOSL-7) D AUDHDR
 ..W !,$$FMTE^XLFDT(TSTAMP,"2Z"),?20,$$EXTERNAL^DILFD(1.1,.04,,$P(DATA,U)),?40,FLD("LABEL")
 ..S OLDVAL=$P(DATA,U,3) S:OLDVAL="" OLDVAL="<no value>"
 ..S NEWVAL=$P(DATA,U,4) S:NEWVAL="" NEWVAL="<deleted>"
 ..W !!,?5,"  Original value: ",OLDVAL
 ..W !,?5,"Value changed to: ",NEWVAL,!
 ..S LN=LN+5
 ..Q
 .Q
 K ^TMP("AUD",$J)
 Q
 ;
AUDHDR ; print audit file data header  PRCA*4.5*443
 I PAGE>0 D PAUSE^RCRPRPU
 S PAGE=PAGE+1,LN=3
 W !,"AR Debtor Address change history",?68,"Page: ",PAGE
 W !!,"Date/Time           User                Field"
 W ! D DASH^RCRPRPU(80)
 Q
