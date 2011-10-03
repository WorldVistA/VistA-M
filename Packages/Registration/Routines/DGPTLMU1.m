DGPTLMU1 ;ALM/MTC - Utilities used for the List Manager; 9-17-92
 ;;5.3;Registration;;Aug 13, 1993
 ;
 ;
EXINT ;-- init routine to call List Manager
 N X
 K ^TMP("ARCPTF",$J,"LIST")
 S X=$P($G(^DGP(45.62,DGTMP,0)),U)
 S:X]"" VALMCNT=$$EXPTF(X)
 ;-- if no entries then delete PTF A/P Template
 I X]"",'VALMCNT D
 . W !,">>> No entries found... Deleting PTF A/P Template" H 1
 . S DIK="^DIBT(",DA=$P(^DGP(45.62,DGTMP,0),U,8) D ^DIK K DA,DIK
 . S DIK="^DGP(45.62,",DA=DGTMP D ^DIK K DA,DIK
 . S VALMQUIT=""
EXINTQ Q
 ;
EXQ ;-- exit function call from List Manager
 I $D(^TMP("ARCPTF",$J,"LIST","DEL")),$$MAKPER D UPST(DGTMP)
 K ^TMP("ARCPTF",$J,"LIST")
 D CLEAR^VALM1
 Q
 ;
EXHDR ;-- header function for Editing List.
 N X,Y
 S VALMHDR(1)="PTF Records Selected from "_$$FTIME^VALM1($P(^DGP(45.62,DGTMP,0),U,10))_" thru "_$$FTIME^VALM1($P(^DGP(45.62,DGTMP,0),U,11))_"."
 S VALMHDR(2)="Total Number of PTF records Selected: "_VALMCNT
 S Y=$$STATUS^DGPTLMU2(DGTMP)
 S VALMHDR(3)="Status: "_$S(Y="P":"PURGED",Y="A":"ARCHIVED",1:"ACTIVE")
 Q
 ;
EXPTF(FNAME) ;-- This function will take the entries in the search
 ; template FNAME and expand them for display using the List Manager.
 ; The global that will contain the display items is:
 ;       ^TMP("ARCPTF",$J,"LIST")
 ; INPUT : FNAME - PTF Archive/Purge File entry
 ; OUTPUT: Total Number of entries
 ;
 ; Format of display string:
 ; <ptf #> <patient name> <admission date> <discharge date>
 N NUMREC,REC,DGX,DGY,X,AREC
 S NUMREC=0
 ;-- get a/p entry
 S DGX=$O(^DGP(45.62,"B",FNAME,0)) I 'DGX G EXPTFQ
 S REC=$P(^DGP(45.62,DGX,0),U,8) G:'$D(^DIBT(REC)) EXPTFQ
 S AREC=$P(^DGP(45.62,DGX,0),U,9)
 S DGX=0 F  S DGX=$O(^DIBT(REC,1,DGX)) Q:'DGX  D
 .;-- if records does not exist then clean-up search template
 . I '$D(^DGPT(DGX)) K ^DIBT(REC,1,DGX) Q
 . S NUMREC=NUMREC+1,X=""
 . S X=$$SETSTR^VALM1("*",X,6,1)
 . S X=$$SETSTR^VALM1(DGX,X,8,6)
 . S X=$$SETSTR^VALM1($P(^DPT(+^DGPT(DGX,0),0),U),X,15,20)
 . S X=$$SETSTR^VALM1($$FTIME^VALM1($P(^DGPT(DGX,0),U,2)),X,37,18)
 . S DGY=+$G(^DGPT(DGX,70))
 . S X=$$SETSTR^VALM1($S(DGY:$$FTIME^VALM1(DGY),1:"<UNKNOWN>"),X,56,18)
 . S ^TMP("ARCPTF",$J,"LIST",NUMREC,0)=$$LOWER^VALM1(X)
 . S ^TMP("ARCPTF",$J,"LIST","IDX",NUMREC,DGX)=""
 . S ^TMP("ARCPTF",$J,"LIST","REC",DGX,NUMREC)=""
 . D FLDCTRL^VALM10(NUMREC)
 I NUMREC'=AREC S DA=REC,DIE="^DGP(45.62,",DR=".09///^S X=NUMREC" D ^DIE K DIE,DR,DA
EXPTFQ Q NUMREC
 ;
DELEX ;-- tag entries to delete in the search template.
 N DGI,DGJ,Y,X
 D SEL^DGPTLMU3
 ;-- mark entries as deleted from search teplate
 S DGI=0 F  S DGI=$O(VALMY(DGI)) Q:'DGI  I $D(^TMP("ARCPTF",$J,"LIST","REC",DGI)) D
 . S ^TMP("ARCPTF",$J,"LIST","DEL",DGI)=""
 . S DGJ=$O(^TMP("ARCPTF",$J,"LIST","REC",DGI,0))
 . D SAVE^VALM10(DGJ),KILL^VALM10(DGJ)
 . S X=^TMP("ARCPTF",$J,"LIST",DGJ,0)
 . S X=$$SETSTR^VALM1(" ",X,6,1),^TMP("ARCPTF",$J,"LIST",DGJ,0)=X
 . D WRITE^VALM10(DGJ)
 S VALMBCK=$S(VALMCC:"",1:"R")
 K VALMY
 Q
 ;
ADDEX ;-- if an entry has been un-selected for a/p this function will
 ; re-activate for the a/p process.
 N DGI,DGJ
 D SEL^DGPTLMU3
 ;-- unmark entries as deleted from search teplate
 S DGI=0 F  S DGI=$O(VALMY(DGI)) Q:'DGI  I $D(^TMP("ARCPTF",$J,"LIST","REC",DGI)) D
 . K ^TMP("ARCPTF",$J,"LIST","DEL",DGI)
 . S DGJ=$O(^TMP("ARCPTF",$J,"LIST","REC",DGI,0))
 . D RESTORE^VALM10(DGJ)
 . S X=^TMP("ARCPTF",$J,"LIST",DGJ,0)
 . S X=$$SETSTR^VALM1("*",X,6,1),^TMP("ARCPTF",$J,"LIST",DGJ,0)=X
 . D FLDCTRL^VALM10(DGJ)
 . D WRITE^VALM10(DGJ)
 S VALMBCK=$S(VALMCC:"",1:"R")
 K VALMY
 Q
 ;
MAKPER() ;-- This function will prompt the user if all changes to the
 ; search template should be made permanent.
 ;  INPUT : - None
 ; OUTPUT : 1 - Yes, 0 - No
 ;
 N Y
 S DIR(0)="Y",DIR("A")="Should I make all changes permanent ",DIR("B")="NO"
 D ^DIR
 K DIR
 Q Y
 ;
UPST(REC) ;-- This function will update the search template if entries are
 ; contained in the ^TMP("ATCPTF",$J,"LIST","DEL") global. Lastly,
 ; the total number of entries will be updated in the PTF A/P
 ; History file (#45.62)
 ;   INPUT : REC - Entry in file 45.62
 N DELREC,I,SRTREC
 I '$D(^TMP("ARCPTF",$J,"LIST","DEL")) G UPSTQ
 W !,">>> Updating search template." H 1
 S DELREC=0,SRTREC=$P(^DGP(45.62,REC,0),U,8)
 S I=0 F  S I=$O(^TMP("ARCPTF",$J,"LIST","DEL",I)) Q:'I  D
 . S DELREC=DELREC+1
 . K ^DIBT(SRTREC,1,I)
 I DELREC=VALMCNT D DELENTRY^DGPTAPSL($P(^DGP(45.62,REC,0),U)) G UPSTQ
 I DELREC S DA=REC,DIE="^DGP(45.62,",DR=".09///^S X=VALMCNT-DELREC" D ^DIE K DIE,DR,DA
UPSTQ Q
 ;
