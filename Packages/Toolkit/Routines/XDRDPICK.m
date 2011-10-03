XDRDPICK ;SF-IRMFO.SEA/JLI - SELECT A PAIR OF POTENTIAL DUPLICATES AND VIEW ;10/10/08  13:38
 ;;7.3;TOOLKIT;**23,47,113**;Apr 25, 1995;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;;
EN ;
 N XDRFL,CMORS1,CMORS2,D0,DA,DIC,DIE,DIR,ICNT,ICNT1,JCNT,LCNT,NCNT,PNCT,TMPGLA,TMPGLB,XDRDA,XDRFILN,XDRGLB,Y,PRIFILE
 ; D EN^XDRVCHEK
 S XDRFL=$$FILE() Q:XDRFL'>0  S PRIFILE=XDRFL,XDRGLB=$P(^DIC(XDRFL,0,"GL"),U,2),XDRFILN=$P(^DIC(XDRFL,0),U)
LOOP ;
 W !!!,"At the following prompt select a POTENTIAL DUPLICATE ENTRY.  If a selection"
 W !,"is not made, you will be given a chance to select from a list if you"
 W !,"want to.  Otherwise, you will be returned to the menu system."
 W !
 S Y=$$LOOKUP^XDRDEDT(XDRFL)
 S XDRDA=+Y I Y>0 D SHOW G LOOP
 S DIR(0)="Y"
 S DIR("A")="Do you want to select from a list of potential duplicates"
 S DIR("B")="YES"
 D ^DIR K DIR Q:Y'>0
 S TMPGLB=$NA(^TMP("XDRDPICK",$J)),TMPGLA=$NA(^TMP("XDRDPICA",$J))
 K @TMPGLB,@TMPGLA
 D ASK
 I XDRDA>0 G LOOP
 K PCNT
 Q
 ;
GETLIST ;
 I XDRGLB="DPT(",$O(^DPT("ACMORS",0))>0 D CMORS Q
 N FLG
 F ICNT=ICNT:0 S ICNT=$O(^VA(15,ICNT)) Q:ICNT'>0  S X=^(ICNT,0) D  Q:'(NCNT#4)&(NCNT>0)&FLG
 . S FLG=1 ;This flag is when NCNT is set from previous call and STATUS is not "P" the first time- - so loop will not quit with (NCNT#4)
 . I $P(X,U,3)'="P" S:PCNT=NCNT FLG=0 Q
 . I $P($P(X,U),";",2)'=XDRGLB Q
 . S NCNT=NCNT+1,X1=+$P(X,U),X2=+$P(X,U,2)
 . I '($D(@(U_XDRGLB_X1_",0)"))#2)!'($D(@(U_XDRGLB_X2_",0)"))#2) S NCNT=NCNT-1 Q
 . S @TMPGLB@(NCNT)=ICNT_U_X1_U_X2
 . S @TMPGLB@(NCNT,1)=@(U_XDRGLB_X1_",0)")
 . S @TMPGLB@(NCNT,2)=@(U_XDRGLB_X2_",0)")
 Q
 ;
ASK ;
 S NCNT=0,ICNT=0,ICNT1=0,JCNT=0,XDRDA=0,PCNT=0
 F  D  D CHEK Q:XDRDA'=0  Q:JCNT'>0
 . D GETLIST
 . S PCNT=NCNT
 . F JCNT=JCNT:0 S JCNT=$O(@TMPGLB@(JCNT)) Q:JCNT'>0  D  Q:'(JCNT#4)
 . . W !!!,$J(JCNT,5),".  ",@TMPGLB@(JCNT,1)
 . . W !,?8,@TMPGLB@(JCNT,2)
 I XDRDA>0 S XDRDA=+@TMPGLB@(XDRDA) D SHOW
 Q
 ;
CHEK ;
 W !
 I JCNT'>0 S DIR(0)="N"
 E  S DIR(0)="NO",DIR("A",1)="Enter Return to continue listing or"
 S DIR("A")="Select the desired entry by number"
 S DIR(0)=DIR(0)_"^1:"_NCNT
 D ^DIR K DIR
 I Y>0 S XDRDA=+Y
 I $D(DUOUT)!$D(DTOUT) S XDRDA=-1 K DTOUT,DUOUT
 K DIRUT
 Q
 ;
SHOW ;
 ;L +^VA(15,+XDRDA,0):30 I '$T G BUSY
 ;I $P(^VA(15,+XDRDA,0),U,3)'="P" L -^VA(15,+XDRDA,0) G BUSY ; NOT AVAILABLE
 ;N XDRXX S XDRXX(15,(+XDRDA)_",",.03)="X"
 ;D FILE^DIE("","XDRXX")
 ;L -^VA(15,+XDRDA,0)
 I '$D(XDRGLB) N XDRGLB S XDRGLB=$P($P(^VA(15,XDRDA,0),U),";",2)
 I $D(@(XDRGLB_(+^VA(15,XDRDA,0))_",-9)"))!$D(@(XDRGLB_(+$P(^VA(15,XDRDA,0),U,2))_",-9)")) W !,$C(7),"One of these entries has already been merged.  Pick another pair.",!! D RESET(XDRDA) Q
 S XQAID=""
 S X=^VA(15,+XDRDA,0)
 S X1=+X,X2=+$P(X,U,2)
 I $$COUNT^XDRRMRG2(XDRFL,X1,X2)>1 S X1=X2,X2=+X
 S XQADATA=XDRDA_U_X1_";"_X2_U_"PRIMARY"_U_XDRFL
 D ^XDRRMRG1
 ; If Primary verifier has set status to DUPLICATE, set STATUS at top level
 ; to "X" (VERIFICATION IN PROCESS)
 S DA=$$FIND1^DIC(15.02,","_XDRDA_",","X","PRIMARY")
 I DA>0 D
 . S X=$P(^VA(15,XDRDA,0),U,3)
 . I X="N"!(X="V") Q
 . S X=^VA(15,XDRDA,2,DA,0)
 . I $P(X,U,2)="V" D
 . . S DR=".03///X;.1///"_DT_";"
 . . S DIE="^VA(15,",DA=XDRDA D ^DIE K DIE,DR
 . . D SETUP^XDRRMRG1(XDRDA)
 . . D CHEKVER^XDRRMRG1
 ; If PATIENT, status=VERIFIED, NOT A DUPLICATE, add patients to MPI DO NOT LINK file(new with XT*7.3*113)
 I XDRFL=2,$P(^VA(15,XDRDA,0),U,3)="N" D
 . ;Quit if routine ^MPIFDNL is not loaded
 . S X="MPIFDNL" X ^%ZOSF("TEST") Q:'$T
 . S X=^VA(15,XDRDA,0)
 . D CALLRPC^MPIFDNL(DUZ,DUZ(2),+X,+$P(X,U,2))
 Q
 ;
BUSY ;
 W !!,$C(7),"Record is being processed by someone else.",!!
 Q
 ;
FILE(XDRFLAG) ;
 ; If XDRFLAG=1, option not available to the PATIENT file (#2) (new with XT*7.3*113)
 N X,XDRPT,XDRFLNM
 S (X,XDRPT)=0
 S XDRFLAG=+$G(XDRFLAG)
 I XDRFLAG=1 W !,"* This option is not available for PATIENTS"
 S XDRFLNM=""
 F I=0:0 S I=$O(^VA(15.1,I)) Q:I'>0  D
 . I XDRFLAG=1,I=2 S XDRPT=1 Q
 . S X=X+1,X(I)=""
 . S XDRFLNM=$P($G(^DIC(I,0)),U)
 . Q
 I X=0 Q -1
 I X=1 Q $O(X(""))
 S:'XDRFLAG XDRFLNM="PATIENT"
 K DIC S DIC=15.1,DIC(0)="AEQM"
 S DIC("A")="Which FILE are the potential duplicates in (e.g., "_XDRFLNM_")? "
 S DIC("B")=XDRFLNM
 I XDRFLAG=1 S DIC("S")="I Y'=2"
 D ^DIC K DIC
 Q +Y
 ;
CMORS ; RETURN DATA RANKED BY CMORS (HIGH VALUES FIRST)
 I '$D(^VA(15,"ACMORS")) D SETCMOR
 I $G(^VA(15,"ACMORS",0))'>0 D SETCMOR
 I $G(^VA(15,"ACMORS",0))>0,$$FMDIFF^XLFDT(DT,^(0))>7 D ASKCMOR
 I ICNT1>0 S ICNT=ICNT-1
 S LCNT=0
 F ICNT=ICNT:0 S ICNT=$O(^VA(15,"ACMORS",ICNT)) Q:ICNT'>0  D  Q:('(NCNT#4))&(LCNT>0)
 . F ICNT1=+ICNT1:0 S ICNT1=$O(^VA(15,"ACMORS",ICNT,ICNT1)) Q:ICNT1'>0  D  Q:('(NCNT#4))&(LCNT>0)
 . . S X=$G(^VA(15,ICNT1,0)) Q:X=""  Q:$P(X,U,3)'="P"  S X1=+X,X2=+$P(X,U,2)
 . . I $D(@TMPGLA@(X1,X2)) Q
 . . S @TMPGLA@(X1,X2)=""
 . . S NCNT=NCNT+1,LCNT=LCNT+1
 . . S @TMPGLB@(NCNT)=ICNT1_U_X1_U_X2
 . . S CMORS1=$P($G(^DPT(X1,"MPI")),U,6),CMORS2=$P($G(^DPT(X2,"MPI")),U,6)
 . . S @TMPGLB@(NCNT,1)=@(U_XDRGLB_X1_",0)")_" (CMOR SCORE = "_$S(CMORS1="":"NULL",1:CMORS1)_")"
 . . S @TMPGLB@(NCNT,2)=@(U_XDRGLB_X2_",0)")_" (CMOR SCORE = "_$S(CMORS2="":"NULL",1:CMORS2)_")"
 Q
 ;
SETCMOR ;
 N I,X,X1,X2,SCOR
 K ^VA(15,"ACMORS")
 F I=0:0 S I=$O(^VA(15,I)) Q:I'>0  S X=^(I,0) D
 . I $P(X,U,3)'="P" Q
 . I $P($P(X,U),";",2)'="DPT(" Q
 . S X1=+X,X2=+$P(X,U,2)
 . S SCOR=$P($G(^DPT(X1,"MPI")),U,6) I SCOR'>0 S SCOR=0
 . S ^VA(15,"ACMORS",(9999999-SCOR),I)=""
 . S SCOR=$P($G(^DPT(X2,"MPI")),U,6) I SCOR'>0 S SCOR=0
 . S ^VA(15,"ACMORS",(9999999-SCOR),I)=""
 S ^VA(15,"ACMORS",0)=DT
 Q
 ;
ASKCMOR ;
 N DIR
 S DIR(0)="Y",DIR("A")="The CMOR scores for activity haven't been checked recently.  Do you want to update these (It might take a couple of minutes)"
 S DIR("B")="YES"
 D ^DIR I Y>0 D SETCMOR
 Q
 ;
SET1 ; HANDLES SETTING OF X-REF ON CMOR SCORES FOR POTENTIAL DUPLICATES
 I X'="P" Q
 N XDRXVAL,XDRXVAL1
 S XDRXVAL=^VA(15,D0,0)
 I $P($P(XDRXVAL,U),";",2)'="DPT(" Q
 S XDRXVAL1=$P($G(^DPT(+XDRXVAL,"MPI")),U,6) I XDRXVAL1="" S XDRXVAL1=-1
 S ^VA(15,"ACMORS",(9999999-XDRXVAL1),D0)=""
 S XDRXVAL1=$P($G(^DPT(+$P(XDRXVAL,U,2),"MPI")),U,6) I XDRXVAL1="" S XDRXVAL1=-1
 S ^VA(15,"ACMORS",(9999999-XDRXVAL1),D0)=""
 Q
 ;
KILL1 ; HANDLES KILLING OF X-REF ON CMOR SCORES FOR POTENTIAL DUPLICATES
 I X'="P" Q
 N XDRXVAL,XDRXVAL1
 S XDRXVAL=^VA(15,D0,0)
 I $P($P(XDRXVAL,U),";",2)'="DPT(" Q
 S XDRXVAL1=+$P($G(^DPT(+XDRXVAL,"MPI")),U,6) I XDRXVAL1="" S XDRXVAL1=-1
 K ^VA(15,"ACMORS",(9999999-XDRXVAL1),D0)
 S XDRXVAL1=+$P($G(^DPT(+$P(XDRXVAL,U,2),"MPI")),U,6) I XDRXVAL1="" S XDRXVAL1=-1
 K ^VA(15,"ACMORS",(9999999-XDRXVAL1),D0)
 Q
 ;
OTHERS ; CHECKS AND MARKS OTHER PAIRS SO ONLY ONE CAN BE PROCESSED AT A TIME
 Q  ; NOT USED CURRENTLY
 ;
 ;   P   CLEAR ALL RELATED
 ;
 ;   X   MARK ALL RELATED
 ;
 ;   V   CLEAR TO
 ;
 ;   O   NOTHING
 ;
 ;   R   MARK ALL RELATED
 ;
 ;  MERGED  CLEAR TO   REALIGN FROM
 I X="O" Q
 N OLDDA,OLDX S OLDDA=DA,OLDX=X N DA,X
 N XDRENTR,IENVAL,XDRPAIR,DONE,XDR0,STATUS,DIREC
 I $D(XDROTHER) Q
 N XDROTHER S XDROTHER=1
 I OLDX="P"!(OLDX="N") D  Q
 . F XDRENTR=$P(^VA(15,OLDDA,0),U),$P(^VA(15,OLDDA,0),U,2) F IENVAL=0:0 S IENVAL=$O(^VA(15,"B",XDRENTR,IENVAL)) Q:IENVAL'>0  I IENVAL'=OLDDA,$P(^VA(15,IENVAL,0),U,3)="O" D
 . . ; Have to check on whether the other member of the pair in process as well.
 . . S XDRPAIR=$P(^VA(15,IENVAL,0),U) IF XDRPAIR=XDRENTR S XDRPAIR=$P(^(0),U,2)
 . . S DONE=0 F IENPAIR=0:0 S IENPAIR=$O(^VA(15,"B",XDRPAIR,IENPAIR)) Q:IENPAIR'>0  I IENPAIR'=IENVAL D  Q:DONE
 . . . S XDR0=^VA(15,IENPAIR,0)
 . . . S STATUS=$P(XDR0,U,3)
 . . . I STATUS="X"!(STATUS="R") S DONE=1 Q
 . . . I STATUS="V" D  Q:DONE
 . . . . S DIREC=$P(XDR0,U,4)
 . . . . I $P(XDR0,U,DIREC)=XDRPAIR S DONE=1 Q  ; IT IS THE 'FROM' ENTRY
 . . . . Q
 . . . Q
 . . D RESET(IENVAL)
 . . Q
 . Q
 I OLDX="X"!(OLDX="R") D  Q
 . F XDRENTR=$P(^VA(15,OLDDA,0),U),$P(^VA(15,OLDDA,0),U,2) F IENVAL=0:0 S IENVAL=$O(^VA(15,"B",XDRENTR,IENVAL)) Q:IENVAL'>0  I IENVAL'=OLDDA,$P(^VA(15,IENVAL,0),U,3)="P" D
 . . N XDRXX S XDRXX(15,IENVAL_",",.03)="O"
 . . D FILE^DIE("","XDRXX")
 . Q
 I OLDX="V"&$D(XDRDADJX) D  Q  ; IF MERGED (XDRDADJX IS SET IN XDRDAJD AND IS RUN BY A CROSS-REFERENCE FOR MERGE STATUS SET TO 'MERGED')
 . F XDRENTR=$P(^VA(15,OLDDA,0),U),$P(^VA(15,OLDDA,0),U,2) D
 . . S DIREC=$P(^VA(15,OLDDA,0),U,4)
 . . F IENVAL=0:0 S IENVAL=$O(^VA(15,"B",XDRENTR,IENVAL)) Q:IENVAL'>0  I IENVAL'=OLDDA,$P(^VA(15,IENVAL,0),U,3)="O" D
 . . . ; Have to check on whether the other member of the pair in process as well.
 . . . S XDRPAIR=$P(^VA(15,IENVAL,0),U) IF XDRPAIR=XDRENTR S XDRPAIR=$P(^(0),U,2)
 . . . S DONE=0 F IENPAIR=0:0 S IENPAIR=$O(^VA(15,"B",XDRPAIR,IENPAIR)) Q:IENPAIR'>0  I IENPAIR'=IENVAL D  Q:DONE
 . . . . S XDR0=^VA(15,IENPAIR,0)
 . . . . S STATUS=$P(XDR0,U,3)
 . . . . I STATUS="X"!(STATUS="R") S DONE=1 Q
 . . . . I STATUS="V" D  Q:DONE
 . . . . . S DIREC=$P(XDR0,U,4)
 . . . . . I $P(XDR0,U,DIREC)=XDRPAIR S DONE=1 Q  ; IT IS THE 'FROM' ENTRY
 . . . . . Q
 . . . . Q
 . . . D RESET(IENVAL) ; RESET TO "P"
 . . . Q
 . . Q
 . Q
 Q
 ;
RESET(DA) ;
 N XDRXX,IENS,X
 I $P(^VA(15,DA,0),U,5)>1 Q
 D NAME^XDRDEDT(DA)
 S X=^VA(15,DA,0)
 S IENS=DA_","
 S XDRXX(15,IENS,.03)="P"
 I $P(X,U,4)'="" S XDRXX(15,IENS,.04)="@"
 I $P(X,U,5)'="" S XDRXX(15,IENS,.05)="@"
 I $P(X,U,7)'="" S XDRXX(15,IENS,.07)="@"
 I $P(X,U,8)'="" S XDRXX(15,IENS,.08)="@"
 I $P(X,U,10)'="" S XDRXX(15,IENS,.1)="@"
 I $P(X,U,13)'="" S XDRXX(15,IENS,.13)="@"
 I $P(X,U,14)'="" S XDRXX(15,IENS,.14)="@"
 D FILE^DIE("","XDRXX")
 S:$D(DUZ) $P(^VA(15,DA,0),U,12)=DUZ
 K ^VA(15,DA,2)
 K ^VA(15,DA,3)
 Q
