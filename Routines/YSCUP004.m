YSCUP004 ;DALISC/LJA - Pt Move Utils: XTMP Logic ;9/16/94 10:55
 ;;5.01;MENTAL HEALTH;**2,11**;Dec 30, 1994
 ;;
 ;
REFMH ;  ^TMP("YSMH",$J, data created after initial ^XTMP storage.  Refresh...
 ;  Store YSMH global data...
 I $O(^TMP("YSMH",$J,0)) D
 .  S %X="^TMP(""YSMH"","_$J_","
 .  S %Y="^XTMP("""_YSXTMP_""",""YSMH"","
 .  D %XY^%RCR
 QUIT
 ;
XTMP ;  Create XTMP global entry.
 ;  (Call after all vars defined, but before any actions...)
 ;
 QUIT:$G(YSDFN)'>0  ;->
 ;
 ;  Get 1st subscript for XTMP data (ie., YSXTMP) ...
 D STRIPVAR
 S YSLR="""YSDGPM"_+YSDFN_"~0"""
 S (X,YSEND)="^XTMP(""YSDGPM"_+YSDFN_"~",YSLP=X_""")"
 F  S (X,YSLP)=$Q(@YSLP) QUIT:YSLP']""  X YSTRIP QUIT:Y'[YSEND  S YSLR=$P(YSLP,"(",2,999)
 S X=+$P(YSLR,"~",2)+1,Y=$L(X),YSNO=$E("0000",1,4-Y)_+X
 S YSXTMP="YSDGPM"_+YSDFN_"~"_YSNO
 ;
 ;  Create ^XTMP(YSXTMP,0) node...
 S X1=DT,X2=1 D C^%DTC S YSPURDT=X
 D NOW^%DTC S YSNOW=%
 S ^XTMP(YSXTMP,0)=YSPURDT_U_DT_U_"MH A/D/T Movement Utility (called by ^YSCUP)"_U_$G(DUZ)_U_$P($G(XQY0),U)_U_$P($G(XQY0),U,2)_U_YSNOW
 ;
 ;  Store ^UTILITY movement data...
 I $D(^UTILITY("DGPM",$J)) D
 .  S %X="^UTILITY(""DGPM"","_$J_","
 .  S %Y="^XTMP("""_YSXTMP_""",""DGPM"","
 .  D %XY^%RCR
 ;
 ;  Store YSMH global data...
 I $O(^TMP("YSMH",$J,0)) D
 .  S %X="^TMP(""YSMH"","_$J_","
 .  S %Y="^XTMP("""_YSXTMP_""",""YSMH"","
 .  D %XY^%RCR
 ;
 ;  Store YSPM global data...
 I $O(^TMP("YSPM",$J,0)) D
 .  S %X="^TMP(""YSPM"","_$J_","
 .  S %Y="^XTMP("""_YSXTMP_""",""YSPM"","
 .  D %XY^%RCR
 ;
 ;  Store miscellaneous other local variables
 S ^XTMP(YSXTMP,"VAR")=$G(YSMH)_U_$G(YSMHMOV)_U_$G(YSMOVES)_U_$G(YSMV)_U_$G(YSNM)_U_$G(YSNMH)
 S ^XTMP(YSXTMP,"LTRSF")=$G(YSLTRSF) ;Last Transfer movement
 S ^XTMP(YSXTMP,"LADM")=$G(YSLADM) ;  Last Admit movement
 S ^XTMP(YSXTMP,"YSLMOMH")=$G(YSLMOMH) ;Last movement off MH ward
 S ^XTMP(YSXTMP,"YSFMTMH")=$G(YSFMTMH) ;First move to MH ward
 ;
 QUIT
 ;
CLEAN ;  Clean up unneeded entries in the ^XTMP entry...
 QUIT:'$D(^XTMP($G(YSXTMP)))  ;->
 ;
 K ^XTMP(YSXTMP,"STATUS")
 ;
 QUIT
 ;
UPDST ;  p(7) of YST set in UPDATE^YSCUP000.  Store newest value in ^XTMP...
 S ^XTMP(YSXTMP,"STATUS")=$G(YST)
 QUIT
 ;
SHOWPT ;  Show all ^XTMP data for one patient
 ;  Undocumented, unsupported call...
 ;
 N DA,DIC,Y,YSDFN,YSEND,YSLAST,YSLP,YSTRIP
 S YSLAST=""
 D STRIPVAR
 ;
 W !
 F  S YSOK=0 D  QUIT:'YSOK  W !! ;->
 .  K DA,DIC,Y
 .  S DIC=2,DIC(0)="AEMQ",DIC("A")="Select PATIENT: "
 .  D ^DIC
 .  QUIT:+Y'>0  ;->
 .  S YSOK=1
 .  S YSDFN=+Y
 .  S YSLP="^XTMP(""YSDGPM"_+YSDFN,YSEND=YSLP_"~",YSLP=YSLP_""")"
 .  F  S (X,YSLP)=$Q(@YSLP) X YSTRIP QUIT:Y'[YSEND  S YSY=Y D
 .  .  I $P($P(YSY,"(",2),",")'=YSLAST,YSLAST]"" D
 .  .  .  R !,X:DTIME I X[U S YSOK=0 QUIT  ;->
 .  .  W !,YSY," = ",@YSY
 .  .  S YSLAST=$P($P(YSY,"(",2),",")
 QUIT
 ;
DELDATA ;  Delete ALL ^XTMP("YSDGPM"... data!!!
 N DIR,X,Y,YSLP
 D STRIPVAR
 ;
 ;  Does any MH ^XTMP data exist?
 S X="^XTMP(""YSDGPM"")",(X,YSLP)=$Q(@X) X YSTRIP I Y'["YSDGPM" D  QUIT  ;->
 .  W !!,"No ^XTMP(""YSDGPM""... data exists!!"
 .  H 2
 ;
 ;  Explain...
 W @IOF,!,?25,"^XTMP(""YSDGPM"" Data Deletion",!,$$REPEAT^XLFSTR("=",IOM),!!
 W !,"The YS PATIENT MOVEMENTS Mental Health protocol creates ^XTMP(""YSDGPM"""
 W !,"data for every movement involving a Mental Health patient.  This data"
 W !,"is used for audit purposes.  It can be deleted at any time without "
 W !,"deleterious effects on the Mental Health package.",!!
 ;
 ;  OK to delete it?
 S DIR(0)="YO",DIR("A")="OK to delete ^XTMP(""YSDGPM"", data"
 D ^DIR
 I +Y'=1 D  QUIT  ;->
 .  W !!,"No action taken..."
 .  H 2
 ;
 ;  OK to delete.  Do it...
 K @YSLP
 F  S (X,YSLP)=$Q(@YSLP) QUIT:X']""  X YSTRIP QUIT:Y'["YSDGPM"  KILL @YSLP W "."
 W !!,"All data deleted..." H 2
 QUIT
 ;
NOMH(YSXTMP,YSVDT) ;  Kill all but 0 node & set Vapor date to T+YSVDT...
 N X1,X2,YS0,YSDT,YSX
 QUIT:'$D(^XTMP($G(YSXTMP)))  ;->
 ;
 ;  Set Vaporization Date Variable...
 S YSVDT=$S($G(YSVDT)>0:+YSVDT,1:2)
 ;
 ;  Get actual vaporization date...
 S (X1,YS0)=$G(^XTMP(YSXTMP,0)) QUIT:YS0']""  ;->
 S YSDT=+YS0 QUIT:YSDT'?7N  ;->
 S X2=+YSVDT
 D C^%DTC
 S YSDT=+X\1 QUIT:+YSDT'?7N  ;->
 ;
 ;  All OK.  Kill data and reset 0 node...
 K ^XTMP(YSXTMP)
 S $P(YS0,U,1)=YSDT
 S ^XTMP(YSXTMP,0)=YS0
 QUIT
 ;
STRIPVAR ;  Xecutable to strip extended reference from global.  
 ;  MSM returns ^[VAH,JDV]DPT(... if translated...
 ;  Places Xecutable code in STRIPVAR - Works on X...
 ;  ^[VAH,JDV]DPT(1,0) --> ^DPT(1,0)
 ;
 K YSTRIP
 S YSTRIP="S Y=""[""_$P($P(X,""["",2),""]"")_""]"",Y=$P(X,Y)_$P(X,Y,2)"
 QUIT
 ;
EOR ;YSCUP004 - Pt Move Utils: XTMP Logic ;9/16/94 10:55
