IB20R244 ;ISP/TDP - Restoral routine for IB*2.0*244 ;10/14/2003
 ;;2.0;INTEGRATED BILLING;**244**;21-MAR-94
 ; This routine is to restore data to the SUBSCRIBER ID (#1) field
 ; of the INSURANCE TYPE SUB-FIELD (#2.312) file of the PATIENT (#2)
 ; file and to the IB DM EXTRACT DATA (#351.71) file that was removed
 ; during the data conversion by post-init routine IB20P244 in patch
 ; IB*2.0*244.  Data can only be restored if the ^XTMP("IB20P244" file
 ; still exists.
 Q
UNDOALL ;Undoes all the changes made by the post-init routine, based on what
 ;is stored in ^XTMP("IB20P244".
 N ALL,IBDIK
 S ALL=1,IBDIK=0
 I '$D(^XTMP("IB20P244",0)) W !,"There is no data to restore." Q
 D UNDOP
 D UNDOF
 D UNDOSUB
 W !!,"Data restoral complete."
 Q
UNDOP ;Restore the past date entries in file 351.71 which were deleted.
 N IBJ,PCNT,PDATE
 I '$G(ALL),'$D(^XTMP("IB20P244",0)) W !,"There is no data to restore." Q
 S PCNT=0
 S IBJ=""
 F  S IBJ=$O(^XTMP("IB20P244",IBJ),-1) Q:IBJ=""  D
 . S PDATE=""
 . F  S PDATE=$O(^XTMP("IB20P244",IBJ,"INS","PST",PDATE)) Q:PDATE=""  D
 .. S PCNT=PCNT+1
 .. D MDATE(PDATE,"PST","RSTP")
 W !
 I PCNT=0 W !,"There are no past date entries to restore for file 351.71."
 I PCNT'=0 S IBDIK=1 I '$G(ALL) D RENDX K IBDIK
 Q
UNDOF ;Restore the future date entries in file 351.71 which were deleted.
 N IBJ,FCNT,FDATE
 I '$G(ALL),'$D(^XTMP("IB20P244",0)) W !,"There is no data to restore." Q
 S FCNT=0
 S IBJ=""
 F  S IBJ=$O(^XTMP("IB20P244",IBJ),-1) Q:IBJ=""  D
 . S FDATE=""
 . F  S FDATE=$O(^XTMP("IB20P244",IBJ,"INS","FUT",FDATE)) Q:FDATE=""  D
 .. S FCNT=FCNT+1
 .. D MDATE(FDATE,"FUT","RSTF")
 W !
 I FCNT=0 W !,"There are no future date entries to restore for file 351.71."
 I FCNT'=0!($G(IBDIK)) D RENDX
 Q
RENDX ;Re-index file 351.71.
 W !!,"Re-indexing file 351.71..."
 S DIK="^IBE(351.71," D IXALL^DIK K DIK
 W "Done"
 Q
MDATE(DATE,DTYP,DRTYP) ;Common date functionality merge/kill
 I $O(^IBE(351.71,DATE,""))'="" W !,"Entry already exists for "_DATE_".  Skipping restoral of this date entry." Q
 M ^IBE(351.71,DATE)=^XTMP("IB20P244",IBJ,"INS",DTYP,DATE)
 M ^XTMP("IB20P244",IBJ,"INS",DRTYP,DATE)=^XTMP("IB20P244",IBJ,"INS",DTYP,DATE)
 K ^XTMP("IB20P244",IBJ,"INS",DTYP,DATE)
 W !,"The entry for "_DATE_" has been restored."
 Q
UNDOSUB ;Restore original SUBSCRIBER ID'S modified in the INSURANCE TYPE
 ;SUB-FIELD (#2.312) file of the PATIENT (#2) file.
 N DA,DFN,DIE,DR,IBDATE,IBINS,IBINSCO,IBINSNM,IBJ,IBJN,IBNAME,IBNODATA
 N IBSSN,IBSUB,IBSUB1,SCNT,SEL,X,Y
 I '$G(ALL),'$D(^XTMP("IB20P244",0)) W !,"There is no data to restore." Q
 I $G(ALL) W ! G ALL
CHOICE S DIR("A")="DO YOU WANT TO RESTORE (A)LL OR (S)ELECTED SUBSCRIBER ID'S? "
 S DIR("B")="QUIT"
 S DIR("T")=300
 S DIR("?")="Choose ALL to restore all subscriber id's, or choose SELECTED to choose individual patient's for restoral."
 S DIR(0)="FAO^1:8^"
 D ^DIR
 I $E(X,1)="S" S Y="SELECTED"
 I $E(X,1)="A" S Y="ALL"
 I Y="QUIT"!(Y="")!($D(DTOUT))!($D(DUOUT)) G SUBEXIT
 I Y'="ALL",Y'="SELECTED" G CHOICE
 I Y="ALL" W ! G ALL
CHOICE1 S DIR("A")="DO YOU WANT TO RESTORE BY (P)ATIENT OR BY (I)NSURANCE COMPANY? "
 S DIR("B")="QUIT"
 S DIR("T")=300
 S DIR("?")="Choose PATIENT to restore specific patient subscriber id's, or choose INSURANCE COMPANY to choose specific insurance companies for restoral."
 S DIR(0)="FAO^1:8^"
 D ^DIR
 S IBNODATA=0
 I $E(X,1)="P" S Y="PATIENT"
 I $E(X,1)="I" S Y="INSURANCE COMPANY"
 I Y="QUIT"!(Y="")!($D(DTOUT))!($D(DUOUT)) G CHOICE
 I Y'="PATIENT",Y'="INSURANCE COMPANY" G CHOICE1
 I Y="PATIENT" W ! S SEL="PAT" G SELPAT
 W !
 S SEL="INS"
SELINS D GATHER I IBNODATA Q
SELECT1 S DIC("A")="SELECT INSURANCE COMPANY TO RESTORE SUBSCRIBER ID'S FOR: "
 S DIC(0)="AENQ"
 S DIC("S")="I $D(^TMP(""IB20P244"",$J,""SUB"",$P($G(Y),U,1)))"
 S DIC="^DIC(36,"
 D ^DIC
 I $D(DTOUT)!($D(DUOUT))!((X="")&('$D(^TMP("IB20P244",$J,"SEL")))) G CHOICE1
 I X="" W ! G SEL1
 S IBINS=$P($G(Y),U,1)
 M ^TMP("IB20P244",$J,"SEL",IBINS)=^TMP("IB20P244",$J,"SUB",IBINS)
 S (X,Y)="" G SELECT1
SEL1 ;RESTORE SELECTED INSURANCE COMPANY SUBSCRIBER ID'S
 S IBINSCO=""
 F  S IBINSCO=$O(^TMP("IB20P244",$J,"SEL",IBINSCO)) Q:IBINSCO=""  D
 . S IBINSNM=$P($G(^DIC(36,IBINSCO,0)),U,1)
 . S IBJ=""
 . F  S IBJ=$O(^TMP("IB20P244",$J,"SEL",IBINSCO,IBJ)) Q:IBJ=""  D
 .. S IBJN=-IBJ
 .. S Y=IBJN D DD^%DT S IBDATE=Y
 .. S DFN=""
 .. F  S DFN=$O(^TMP("IB20P244",$J,"SEL",IBINSCO,IBJ,DFN)) Q:DFN=""  D
 ... S IBNAME=$P($G(^DPT(DFN,0)),U,1)
 ... S IBSSN=$P($G(^DPT(DFN,0)),U,9)
 ... S IBINS=""
 ... F  S IBINS=$O(^TMP("IB20P244",$J,"SEL",IBINSCO,IBJ,DFN,IBINS)) Q:IBINS=""  D
 .... D MSUB(IBJN)
 W !
 G SELINS
SELPAT D GATHER I IBNODATA Q
SELECT S DIC("A")="SELECT PATIENT TO RESTORE SUBSCRIBER ID'S FOR: "
 S DIC(0)="AEINQ"
 S DIC("S")="I $D(^TMP(""IB20P244"",$J,""SUB"",$P($G(Y),U,1)))"
 S DIC="^DPT("
 D ^DIC
 I $D(DTOUT)!($D(DUOUT))!((X="")&('$D(^TMP("IB20P244",$J,"SEL")))) G CHOICE1
 I X="" W ! G SEL
 S DFN=$P($G(Y),U,1)
 M ^TMP("IB20P244",$J,"SEL",DFN)=^TMP("IB20P244",$J,"SUB",DFN)
 S (X,Y)="" G SELECT
SEL ;RESTORE SELECTED PATIENTS SUBSCRIBER ID'S
 S DFN=""
 F  S DFN=$O(^TMP("IB20P244",$J,"SEL",DFN)) Q:DFN=""  D
 . S IBNAME=$P($G(^DPT(DFN,0)),U,1)
 . S IBSSN=$P($G(^DPT(DFN,0)),U,9)
 . S IBJ=""
 . F  S IBJ=$O(^TMP("IB20P244",$J,"SEL",DFN,IBJ)) Q:IBJ=""  D
 .. S IBJN=-IBJ
 .. S Y=IBJN D DD^%DT S IBDATE=Y
 .. S IBINS=""
 .. F  S IBINS=$O(^TMP("IB20P244",$J,"SEL",DFN,IBJ,IBINS)) Q:IBINS=""  D
 ... S IBINSNM=$P($G(^DIC(36,$P($G(^DPT(DFN,.312,IBINS,0)),U,1),0)),U,1)
 ... D MSUB(IBJN)
 W !
 G SELPAT
SUBEXIT ;Cleans up temp globals
 K ^TMP("IB20P244",$J)
 K DIC,DIR,DTOUT,DUOUT
 Q
GATHER K ^TMP("IB20P244",$J)
 S IBJ=""
 F  S IBJ=$O(^XTMP("IB20P244",IBJ),-1) Q:IBJ=""  D
 . S DFN=""
 . F  S DFN=$O(^XTMP("IB20P244",IBJ,"SUB",DFN)) Q:DFN=""  D
 .. S IBINS=""
 .. F  S IBINS=$O(^XTMP("IB20P244",IBJ,"SUB",DFN,IBINS)) Q:IBINS=""  D
 ... I SEL="PAT" S ^TMP("IB20P244",$J,"SUB",DFN,-IBJ,IBINS)="" Q
 ... S IBINSCO=$P($G(^DPT(DFN,.312,IBINS,0)),U,1)
 ... S ^TMP("IB20P244",$J,"SUB",IBINSCO,-IBJ,DFN,IBINS)=""
 I '$D(^TMP("IB20P244")) W !,"There is no subscriber id data to restore!" S IBNODATA=1
 Q
ALL S SCNT=0
 S IBJ=""
 F  S IBJ=$O(^XTMP("IB20P244",IBJ),-1) Q:IBJ=""  D
 . S Y=IBJ D DD^%DT S IBDATE=Y
 . S DFN=""
 . F  S DFN=$O(^XTMP("IB20P244",IBJ,"SUB",DFN)) Q:DFN=""  D
 .. S IBNAME=$P($G(^DPT(DFN,0)),U,1)
 .. S IBSSN=$P($G(^DPT(DFN,0)),U,9)
 .. S IBINS=""
 .. F  S IBINS=$O(^XTMP("IB20P244",IBJ,"SUB",DFN,IBINS)) Q:IBINS=""  D
 ... S SCNT=SCNT+1
 ... S IBINSNM=$P($G(^DIC(36,$P($G(^DPT(DFN,.312,IBINS,0)),U,1),0)),U,1)
 ... D MSUB(IBJ)
 W !
 I SCNT=0 W !,"There are no SUBSCRIBER ID entries to restore in the INSURANCE TYPE",!,"     SUB-FIELD (#2.312) file of the PATIENT (#2) file."
 Q
MSUB(IBJN) ;Common subscriber id functionality merge/kill
 S IBSUB=$P($G(^XTMP("IB20P244",IBJN,"SUB",DFN,IBINS)),"^",1)
 I IBSUB=$P($G(^DPT(DFN,.312,IBINS,0)),U,2) W !,"SUBSCRIBER ID for "_IBNAME_" ("_IBSSN_"), entry "_IBINSNM_",",!,"     has already been restored!" D  Q
 . M ^XTMP("IB20P244",IBJN,"RSTS",DFN,IBINS)=^XTMP("IB20P244",IBJN,"SUB",DFN,IBINS)
 . K ^XTMP("IB20P244",IBJN,"SUB",DFN,IBINS)
 S IBSUB1=$P($G(^XTMP("IB20P244",IBJN,"SUB",DFN,IBINS)),"^",2)
 I IBSUB1'=$P($G(^DPT(DFN,.312,IBINS,0)),U,2) W !,"SUBSCRIBER ID for "_IBNAME_" ("_IBSSN_"), entry "_IBINSNM_", has been",!,"     changed since data conversion.  Skipping restoral of this SUBSCRIBER ID." Q
 I IBSUB[";" W !!,"Original SUBSCRIBER ID contains a semi-colon (;).  Unable to restore",!,"     SUBSCRIBER ID for "_IBNAME_" ("_IBSSN_"), insurance",!,"     company "_IBINSNM_".  Use Fileman to enter",!,"     ID of """_IBSUB_""".",! Q
 S DA=IBINS,DA(1)=DFN,DR="1////"_IBSUB,DIE="^DPT(DFN,.312," D ^DIE
 W !,"The SUBSCRIBER ID for "_IBNAME_" ("_IBSSN_"),",!,"     insurance company "_IBINSNM_", has been restored",!,"     from the "_IBDATE_" data conversion."
 M ^XTMP("IB20P244",IBJN,"RSTS",DFN,IBINS)=^XTMP("IB20P244",IBJN,"SUB",DFN,IBINS)
 K ^XTMP("IB20P244",IBJN,"SUB",DFN,IBINS)
 Q
SUBPRNT ;Allows user to print an excel friendly list of subscriber id's changed
 N DFN,IBINS,IBINSNM,IBJ,IBNAME
 K ^TMP("IB20P244",$J)
 S IBJ=""
 F  S IBJ=$O(^XTMP("IB20P244",IBJ),-1) Q:IBJ=""  D
 . S DFN=""
 . F  S DFN=$O(^XTMP("IB20P244",IBJ,"SUB",DFN)) Q:DFN=""  D
 .. S IBNAME=$P($G(^DPT(DFN,0)),U,1)_"("_$P($G(^DPT(DFN,0)),U,9)_")"
 .. I IBNAME="" S IBNAME="*** UNKNOWN ***"
 .. S IBINS=""
 .. F  S IBINS=$O(^XTMP("IB20P244",IBJ,"SUB",DFN,IBINS)) Q:IBINS=""  D
 ... S IBINSNM=$P($G(^DIC(36,$P($G(^DPT(DFN,.312,IBINS,0)),U,1),0)),U,1)
 ... I IBINSNM="" S IBINSNM="*** UNKNOWN ***"
 ... S ^TMP("IB20P244",$J,"SUB",IBINSNM,IBNAME,-IBJ,IBINS)=$G(^XTMP("IB20P244",IBJ,"SUB",DFN,IBINS))
 I '$D(^TMP("IB20P244",$J,"SUB")) W !,"THERE IS NO DATA TO DISPLAY" Q
 S IBINSNM=""
 F  S IBINSNM=$O(^TMP("IB20P244",$J,"SUB",IBINSNM)) Q:IBINSNM=""  D
 . S IBNAME=""
 . F  S IBNAME=$O(^TMP("IB20P244",$J,"SUB",IBINSNM,IBNAME)) Q:IBNAME=""  D
 .. S IBJ=""
 .. F  S IBJ=$O(^TMP("IB20P244",$J,"SUB",IBINSNM,IBNAME,IBJ)) Q:IBJ=""  D
 ... S IBINS=""
 ... F  S IBINS=$O(^TMP("IB20P244",$J,"SUB",IBINSNM,IBNAME,IBJ,IBINS)) Q:IBINS=""  D
 .... W !,IBINSNM_"^"_IBNAME_"^"_$G(^TMP("IB20P244",$J,"SUB",IBINSNM,IBNAME,IBJ,IBINS))
 K ^TMP("IB20P244",$J)
 Q
