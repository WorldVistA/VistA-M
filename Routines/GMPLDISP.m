GMPLDISP ; SLC/MKB -- Problem List detailed display ; 04/15/2002
 ;;2.0;Problem List;**21,26,35**;Aug 25, 1994;Build 26
 ;
 ; External References
 ;   DBIA  3106  ^DIC(49
 ;   DBIA 10082  ^ICD9( file 80
 ;   DBIA 10040  ^SC(  file 44
 ;   DBIA 10060  ^VA(200
 ;   DBIA 10116  $$SETSTR^VALM1
 ;   DBIA 10117  CLEAN^VALM10
 ;   DBIA 10117  CNTRL^VALM10
 ;   DBIA 10103  $$FMTE^XLFDT
 ;   DBIA 10103  $$HTFM^XLFDT
 ;   DBIA 10104  $$REPEAT^XLFSTR
 ;                      
EN ; Init Variables (need GMPLSEL,GMPLNO) and List Array
 G:'$D(GMPLSEL) ERROR G:'$G(GMPLNO) ERROR
 S GMPI=+$G(GMPI)+1 I GMPI>GMPLNO D  Q
 . W !!,"There are no more problems that have been selected to view!",! S VALMBCK="" H 2
 S GMPLNUM=$P(GMPLSEL,",",GMPI) G:GMPLNUM'>0 ERROR
 S GMPIFN=$P($G(^TMP("GMPLIDX",$J,+GMPLNUM)),U,2) G:GMPIFN'>0 ERROR
 W !!,"Retrieving current data for problem #"_GMPLNUM_" ...",!
 ;                        
PROB ; Display problem GMPIFN
 N LINE,STR,I,TEXT,NOTE,GMPL0,GMPL1,X,Y,IDT,FAC,AIFN,SP,LCNT,NIFN
 G:'$G(GMPIFN) ERROR D CLEAN^VALM10
 S GMPL0=$G(^AUPNPROB(GMPIFN,0)),GMPL1=$G(^(1)),LCNT=1,SP=""
 F I=11,12,13,15,16,17,18 S:+$P(GMPL1,U,I) SP=SP_$S(I=11:"AGENT ORANGE",I=12:"RADIATION",I=13:"ENV CONTAMINANTS",I=15:"HEAD/NECK CANCER",I=16:"MIL SEXUAL TRAUMA",I=17:"COMBAT VET",1:"SHAD")_U
 F  Q:$E(SP,$L(SP))'="^"  S SP=$E(SP,1,($L(SP)-1))
 D WRAP^GMPLX($$PROBTEXT^GMPLX(GMPIFN),65,.TEXT)
 S GMPDT(LCNT,0)="  Problem: "_TEXT(1)
 I TEXT>1 F I=2:1:TEXT S LCNT=LCNT+1,GMPDT(LCNT,0)=TEXT(I)
 S LCNT=LCNT+1,GMPDT(LCNT,0)="       "
PR1 ;   Onset
 ;   SC Condition
 ;   Status
 ;   Exposure
 ;   Provider
 ;   Service/Clinic
 S LINE="    Onset: "_$S($P(GMPL0,U,13):$$EXTDT^GMPLX($P(GMPL0,U,13)),1:"date unknown"),STR=""
 S:GMPVA STR="SC Condition: "_$S(+$P(GMPL1,U,10):"YES",$P(GMPL1,U,10)=0:"NO",1:"unknown")
 S LINE=$$SETSTR^VALM1(STR,LINE,49,30),LCNT=LCNT+1,GMPDT(LCNT,0)=LINE
 S X=$P(GMPL0,U,12),LINE="   Status: "_$S(X="A":"ACTIVE",1:"INACTIVE")
 I X="A",$L($P(GMPL1,U,14)) S LINE=LINE_"/"_$S($P(GMPL1,U,14)="A":"ACUTE",1:"CHRONIC")
 I X="I",$P(GMPL1,U,7) S LINE=LINE_", Resolved "_$$EXTDT^GMPLX($P(GMPL1,U,7))
 S STR="",LCNT=LCNT+1
 S:GMPVA STR="    Exposure: "_$S('$L(SP):"none",1:$P(SP,U))
 S LINE=$$SETSTR^VALM1(STR,LINE,49,30),GMPDT(LCNT,0)=LINE
 S LINE=" Provider: "_$P($G(^VA(200,+$P(GMPL1,U,5),0)),U),LCNT=LCNT+1,STR=""
 I GMPVA,$L(SP,U)>1 S STR=$P(SP,U,2)
 S LINE=$$SETSTR^VALM1(STR,LINE,63,16),GMPDT(LCNT,0)=LINE
 I $E(GMPLVIEW("VIEW"))="S" S LINE="  Service: "_$P($G(^DIC(49,+$P(GMPL1,U,6),0)),U)
 E  S LINE="   Clinic: "_$P($G(^SC(+$P(GMPL1,U,8),0)),U)
 S LCNT=LCNT+1,STR="" I GMPVA,$L(SP,U)>2 S STR=$P(SP,U,3)
 S LINE=$$SETSTR^VALM1(STR,LINE,63,16),GMPDT(LCNT,0)=LINE
 S LCNT=LCNT+1,GMPDT(LCNT,0)="       "
PR2 ;   Recorded
 ;   Entered
 ;   Provider Narrative
 ;   ICD code
 S LINE=" Recorded: "_$S($P(GMPL1,U,9):$$EXTDT^GMPLX($P(GMPL1,U,9)),1:"date unknown")
 S:$P(GMPL1,U,4) LINE=LINE_", by "_$P($G(^VA(200,+$P(GMPL1,U,4),0)),U)
 S LCNT=LCNT+1,GMPDT(LCNT,0)=LINE
 S LINE="  Entered: "_$$EXTDT^GMPLX($P(GMPL0,U,8))
 S LINE=LINE_", by "_$P($G(^VA(200,+$P(GMPL1,U,3),0)),U),LCNT=LCNT+1
 S:GMPARAM("VER")&($P(GMPL1,U,2)="T") LINE=LINE_"  <unconfirmed>"
 S GMPDT(LCNT,0)=LINE
 S LINE=" ICD Code: "_$P($G(^ICD9(+GMPL0,0)),U),LCNT=LCNT+1,GMPDT(LCNT,0)=LINE
 S LCNT=LCNT+1,GMPDT(LCNT,0)="       "
PR3 ;   Comments
 S LCNT=LCNT+1,GMPDT(LCNT,0)="Comments:"
 D CNTRL^VALM10(LCNT,1,8,IOUON,IOUOFF)
 ;     By Facility
 F FAC=0:0 S FAC=$O(^AUPNPROB(GMPIFN,11,FAC)) Q:+FAC'>0  D
 . I 'FAC S LCNT=LCNT+1,GMPDT(LCNT,0)="   <None>" G PR4
 . F NIFN=0:0 S NIFN=$O(^AUPNPROB(GMPIFN,11,FAC,11,NIFN)) Q:+NIFN'>0  D
 . . S NOTE=$G(^AUPNPROB(GMPIFN,11,FAC,11,NIFN,0)) Q:NOTE=""
 . . S LINE=$J($$EXTDT^GMPLX($P(NOTE,U,5)),10)_": "_$P(NOTE,U,3)
 . . S LCNT=LCNT+1,GMPDT(LCNT,0)=LINE
 . . I $P(NOTE,U,6) S LINE="            "_$P($G(^VA(200,+$P(NOTE,U,6),0)),U),LCNT=LCNT+1,GMPDT(LCNT,0)=LINE
 S:'($G(NOTE)) LCNT=LCNT+1,GMPDT(LCNT,0)="   <None>"
PR4 ;   Audit Trail
 S LCNT=LCNT+1,GMPDT(LCNT,0)="       "
 S LCNT=LCNT+1,GMPDT(LCNT,0)="History:"
 D CNTRL^VALM10(LCNT,1,7,IOUON,IOUOFF)
 I '$D(^GMPL(125.8,"B",GMPIFN)) S LCNT=LCNT+1,GMPDT(LCNT,0)="   <No changes>" G PRQ
 F IDT=0:0 S IDT=$O(^GMPL(125.8,"AD",GMPIFN,IDT)) Q:IDT'>0  D
 . F AIFN=0:0 S AIFN=$O(^GMPL(125.8,"AD",GMPIFN,IDT,AIFN)) Q:AIFN'>0  D DT^GMPLHIST
PRQ ;   Header Node
 S VALMCNT=LCNT,GMPDT(0)=VALMCNT,VALMSG=$$MSG^GMPLX,VALMBG=1,VALMBCK="R"
 Q
 ;                     
HDR ; Header Code (uses GMPDFN, GMPIFN)
 N LASTMOD,PAT S PAT=$P(GMPDFN,U,2)_"  ("_$P(GMPDFN,U,3)_")"
 S LASTMOD=$S($G(GMPIFN):$P(^AUPNPROB(GMPIFN,0),U,3),1:$E($$HTFM^XLFDT($H),1,12))
 S LASTMOD="Last Updated: "_$$FMTE^XLFDT(LASTMOD)
 S VALMHDR(1)=PAT_$$REPEAT^XLFSTR(" ",(79-$L(PAT)-$L(LASTMOD)))_LASTMOD
 Q
 ;
HELP ; Help Code
 N X W !!?4,"You may view detailed information here on this problem;"
 W !?4,"more data may be available by entering 'Next Screen'."
 W !?4,"If you have selected multiple problems to view, you may"
 W !?4,"enter 'Continue to Next Selected Problem'; to return to"
 W !?4,"the patient's problem list, enter 'Quit to Problem List'."
 W !!,"Press <return> to continue ... " R X:DTIME
 S VALMSG=$$MSG^GMPLX,VALMBCK=$S(VALMCC:"",1:"R")
 Q
 ;
DEFLT() ; Default Action, using GMPI and GMPLNO
 I GMPI<GMPLNO Q "Continue to Next Selected Problem"
 Q "Quit to Problem List"
 ;
ERROR ; Error Message - drop into EXIT
 W !!,"ERROR -- Cannot continue ... Returning to Problem List.",!
 S VALMBCK="Q" H 1
EXIT ; Exit Code
 K GMPDT Q
