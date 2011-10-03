GMPLEDIT ; SLC/MKB/KER -- VALM Utilities for Edit sub-list ; 04/15/2002
 ;;2.0;Problem List;**26,35**;Aug 25, 1994;Build 26
 ;
 ; External References
 ;   DBIA 10060  ^VA(200
 ;   DBIA 10076  ^XUSEC("GMPL ICD CODE"
 ;   DBIA 10009  YN^DICN
 ;   DBIA 10116  $$SETSTR^VALM1
 ;   DBIA 10117  CLEAN^VALM10
 ;   DBIA 10117  CNTRL^VALM10
 ;   DBIA 10103  $$FMTE^XLFDT
 ;   DBIA 10104  $$REPEAT^XLFSTR
 ;                    
EN ; Init Variables, list array
 ;   Expects GMPIFN   IEN of file 900011 (required)
 ;           GMPLNUM  Sequence # of Problem Edit (optional)
 W !!,"Retrieving current data for problem "
 W $S($G(GMPLNUM):"#"_GMPLNUM_" ",1:"")_"...",! K GMPFLD,GMPORIG
 ;   Set GMPFLD() and GMPORIG() Arrays
 D GETFLDS^GMPLEDT3(GMPIFN)
 I '$D(GMPFLD) W !!,"ERROR -- Cannot continue.",! S VALMBCK="Q" G KILL
INIT ;   Build list from GMPFLD()
 N LCNT,TEXT,I,SP,LINE,STR,NUM,NOTE,ICD
 S LCNT=1,ICD=$S($D(^XUSEC("GMPL ICD CODE",DUZ)):1,1:0)
 S SP="" F I=1.11,1.12,1.13,1.15,1.16,1.17,1.18 S:GMPFLD(I) SP=SP_$P(GMPFLD(I),U,2)_U
 S:$L(SP) SP=$E(SP,1,$L(SP)-1)
 K GMPSAVED,GMPREBLD D CLEAN^VALM10
 D WRAP^GMPLX($P(GMPFLD(.05),U,2),65,.TEXT)
 ;   Line 1
 S LINE="1  Problem:  "_TEXT(1)
 S ^TMP("GMPLEDIT",$J,LCNT,0)=LINE D HI(LCNT,1)
 I $D(GMPLUSER),GMPARAM("VER"),GMPFLD(1.02)="T" S LINE=$E(LINE,1,12)_"$"_$E(LINE,14,79),^TMP("GMPLEDIT",$J,LCNT,0)=LINE D HI(LCNT,13)
 I TEXT>1 F I=2:1:TEXT S LCNT=LCNT+1,^TMP("GMPLEDIT",$J,LCNT,0)="              "_TEXT(I)
 S LCNT=LCNT+1,^TMP("GMPLEDIT",$J,LCNT,0)="   "
IN1 ;   Line 2
 S LINE="2  Onset:    ",STR=$P(GMPFLD(.13),U,2)
 S LINE=LINE_$S(STR="":"unknown",1:STR),LCNT=LCNT+1
 I GMPVA S STR=$S(ICD:7,1:6)_"  SC Condition: "_$S(GMPFLD(1.1)="":"unknown",1:$P(GMPFLD(1.1),U,2)),LINE=$$SETSTR^VALM1(STR,LINE,45,34)
 S ^TMP("GMPLEDIT",$J,LCNT,0)=LINE F I=1,45 D HI(LCNT,I)
IN2 ;   Line 3
 S LINE="3  Status:   "_$P(GMPFLD(.12),U,2),LCNT=LCNT+1
 I $E(GMPFLD(.12))="A",$L(GMPFLD(1.14)) S LINE=LINE_"/"_$P(GMPFLD(1.14),U,2)
 I $E(GMPFLD(.12))="I",GMPFLD(1.07) S LINE=LINE_", Resolved "_$P(GMPFLD(1.07),U,2)
 I GMPVA S STR=$S(ICD:8,1:7)_"  Exposure:     "_$S('$L(SP):"<None>",1:$P(SP,U)),LINE=$$SETSTR^VALM1(STR,LINE,45,34)
 S ^TMP("GMPLEDIT",$J,LCNT,0)=LINE F I=1,45 D HI(LCNT,I)
IN3 ;   Line 4
 S LINE="4  Provider: "_$P(GMPFLD(1.05),U,2),LCNT=LCNT+1
 I GMPVA,$L(SP,U)>1 S STR=$P(SP,U,2),LINE=$$SETSTR^VALM1(STR,LINE,60,20)
 S ^TMP("GMPLEDIT",$J,LCNT,0)=LINE D HI(LCNT,1)
 ;   Line 5
 I $E(GMPLVIEW("VIEW"))="S" S LINE="5  Service:  "_$P(GMPFLD(1.06),U,2)
 E  S LINE="5  Clinic:   "_$P(GMPFLD(1.08),U,2)
 I GMPVA,$L(SP,U)>2 S STR=$P(SP,U,3),LINE=$$SETSTR^VALM1(STR,LINE,60,20)
 S LCNT=LCNT+1,^TMP("GMPLEDIT",$J,LCNT,0)=LINE D HI(LCNT,1) G:'ICD IN4
 ;   Line 6
 S LINE="6  ICD Code: "_$P(GMPFLD(.01),U,2),LCNT=LCNT+1
 S ^TMP("GMPLEDIT",$J,LCNT,0)=LINE D HI(LCNT,1)
IN4 ;   Line 7/8
 S LCNT=LCNT+1,^TMP("GMPLEDIT",$J,LCNT,0)="   "
 S LCNT=LCNT+1,^TMP("GMPLEDIT",$J,LCNT,0)="Comments: "
 D CNTRL^VALM10(LCNT,1,8,IOUON,IOUOFF)
 S NUM=$S(GMPVA:7,1:5) S:ICD NUM=NUM+1
 I GMPFLD(10,0) F I=1:1:GMPFLD(10,0) D
 . S NUM=NUM+1,NOTE=GMPFLD(10,I)
 . S LINE=NUM_$E("   ",1,3-$L(NUM))_$J($$EXTDT^GMPLX($P(NOTE,U,5)),8)
 . I $P(GMPFLD(10,I),U,3)="",$P(GMPORIG(10,I),U,3)'="" S $P(NOTE,U,3)="<Deleted>"
 . S LCNT=LCNT+1,^TMP("GMPLEDIT",$J,LCNT,0)=LINE_": "_$P(NOTE,U,3)
 . D HI(LCNT,1) Q:'$D(GMPLMGR)
 . S LINE="             "_$P($G(^VA(200,+$P(NOTE,U,6),0)),U)
 . S LCNT=LCNT+1,^TMP("GMPLEDIT",$J,LCNT,0)=LINE
IN5 ;   Last Line
 I $D(GMPFLD(10,"NEW"))>9 S NUM=NUM+1 D
 . S LINE=NUM_$E("   ",1,3-$L(NUM))_$J($$EXTDT^GMPLX(DT),8)_": "
 . S I=$O(GMPFLD(10,"NEW",0)),LINE=LINE_GMPFLD(10,"NEW",I)
 . S LCNT=LCNT+1,^TMP("GMPLEDIT",$J,LCNT,0)=LINE D HI(LCNT,1)
 . F  S I=$O(GMPFLD(10,"NEW",I)) Q:I'>0  D
 . . S LINE="             "_GMPFLD(10,"NEW",I)
 . . S LCNT=LCNT+1,^TMP("GMPLEDIT",$J,LCNT,0)=LINE
 S VALMCNT=LCNT,^TMP("GMPLEDIT",$J,0)=NUM_U_LCNT,VALMSG=$$MSG^GMPLEDT3
 Q
 ;          
HI(LINE,COL) ; Hi-lite #
 D CNTRL^VALM10(LINE,COL,3,IOINHI,IOINORM)
 Q
 ;          
HDR ; Header code
 N LASTMOD,PAT S PAT=$P(GMPDFN,U,2)_"  ("_$P(GMPDFN,U,3)_")"
 S LASTMOD=$P(^AUPNPROB(GMPIFN,0),U,3)
 S LASTMOD="Last Updated: "_$$FMTE^XLFDT(LASTMOD)
 S VALMHDR(1)=PAT_$$REPEAT^XLFSTR(" ",(79-$L(PAT)-$L(LASTMOD)))_LASTMOD
 Q
 ;
HELP ; Help code
 N X,CNT S CNT=+$G(^TMP("GMPLEDIT",$J,0))
 W !!?4,"You may change one or more of the above listed values describing"
 W !?4,"this problem by entering its display number (1-"_CNT_") at the prompt;"
 W !?4,"you may then enter a new value, or '@' to delete an existing value."
 W !!?4,"Enter RM to remove this problem from the patient's list completely,"
 W !?4,"SC to save your changes, or Q to simply return to the problem list."
 W:VALMCNT>11 !?4,"Enter '+' to see more information, as in the problem list."
 W !!,"Press <return> to continue ... " R X:DTIME
 S VALMSG=$$MSG^GMPLEDT3,VALMBCK=$S(VALMCC:"",1:"R")
 Q
 ;          
EXIT ; Exit code
 N DIFFRENT,% G:$D(GMPSAVED) KILL
 S DIFFRENT=$$EDITED^GMPLEDT2 I 'DIFFRENT G KILL
 W $C(7),!!,">>>  THIS PROBLEM HAS CHANGED!!"
EX1 ;   Ask to Save Changes on Exit
 W !?5,"Do you want to save these changes"
 S %=1 D YN^DICN G:(%<0)!(%=2) KILL I %=0 D  G EX1
 . W !!?5,"Enter YES or <return> to save the current values listed above"
 . W !?5,"describing this problem; enter NO to exit without saving.",!
 W !!,"Saving ..." D EN^GMPLSAVE W " done."
KILL ;   Clean-up
 S CNT=+$G(^TMP("GMPLEDIT",$J,0))
 F I=1:1:CNT K XQORM("KEY",I)
 D CLEAN^VALM10 K XQORM("KEY","$")
 K GMPFLD,GMPORIG,GMPQUIT,DUOUT,DTOUT,I,CNT
 Q
