PRSARC09 ;WOIFO/JAH - automatically load continuous recess;5/31/07
 ;;4.0;PAID;**112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
AUTOREC(AWSST,AWSEND) ; Ask user: automatically schedule all available
 ; recess, continuously from a user specified date.
 W @IOF,!!
 N DIR,X,Y,DIRUT,I
 S DIR("A")="Set available recess, continously from a particular date"
 S DIR("?",1)=" You may now select a recess start date and all available "
 S DIR("?",2)=" recess will automatically be scheduled fully for each "
 S DIR("?",3)=" week from the date you pick.  If you answer NO, you may"
 S DIR("?",4)=" schedule recess by selecting weeks in the recess editor."
 S DIR("?",5)=" "
 S DIR("?",6)=" There are "_$P(PRSRWHRS,U,3)_" weeks or "_$P(PRSRWHRS,U,2)_" hours available for recess."
 S I=0 F  S I=$O(DIR("?",I)) Q:I'>0  W !,DIR("?",I)
 S DIR("B")="YES"
 S DIR(0)="Y"
 D ^DIR
 S (PRSAUTOR)=+Y
 Q:'PRSAUTOR 0
 ; Find last date recess can start
 N X,X1,X2,RECSTART
 S X2=-(7*(($P(PRSRWHRS,U,3)+.9\1)-1)),X1=AWSEND D C^%DTC S AWSEND=X
 S RECSTART=$$AWSTART^PRSARC03(AWSST,AWSEND,"Enter Recess Start Date")
 Q:RECSTART'>0 0
 ; convert RECESS start to 1st day of week
 N D1,DAY,PPI,PPE S D1=RECSTART D PP^PRSAPPU
 N X1,X2,X,%H S X1=D1,X2=-$S(DAY<8:DAY-1,1:DAY-8) D C^%DTC S RECSTART=X
 Q PRSAUTOR_U_RECSTART
 ;
 ;
ADDAUTOR(PRSAUTOR) ; auto add recess to listman
 ;
 N LSTITEM,CTRH1,CTRH2,LOFHRS,LOFTH1,LOFTH2,WKDY1
 N ITEM,Y,RH1,RH2,OUT,HRSLEFT,RDEFAULT,CRH,TOURHRS,D1,PPI,PPE
 ;
 ; get tour hours from latest pay period on file
 N PPI S PPI=$O(^PRST(458,999999),-1)
 N TH D TOURHRS^PRSARC07(.TH,PPI,+PRSNURSE,"")
 S LOFTH1=TH("W1"),LOFTH2=TH("W2")
 ;
 ; Initialize hours left for recess to 20 since 1 pay period minimum
 ; is 25% of 80 hours
 S HRSLEFT=20
 S (OUT,ITEM,RDEFAULT)=0
 S WKDY1=$P(PRSAUTOR,U,2)-1
 F  S WKDY1=$O(FMWKS(WKDY1)) Q:WKDY1'>0!(HRSLEFT'>0)  D
 .  S HRSLEFT=$$HRSLEFT^PRSARC03()
 .  Q:HRSLEFT'>0
 .  S ITEM=$G(FMWKS(WKDY1))
 .  S LSTITEM=$G(^TMP("PRSLI",$J,ITEM))
 .  S D1=WKDY1 D PP^PRSAPPU
 .  N TH D TOURHRS^PRSARC07(.TH,PPI,+PRSNURSE,"")
 .  S CTRH1=+TH("W1"),CTRH2=+TH("W2")
 .  S TOURHRS=$S(ITEM#2:CTRH1,1:CTRH2)
 .  S LOFHRS=$S(ITEM#2:LOFTH1,1:LOFTH2)
 .  I TOURHRS'>0 S TOURHRS=LOFHRS
 .  ;get remaining hours to schedule for FY
 .  I HRSLEFT<TOURHRS D
 ..    S RDEFAULT=HRSLEFT
 .  E  D
 ..   S RDEFAULT=TOURHRS
 .  I RDEFAULT<0 S RDEFAULT=0
 . D FLDTEXT^VALM10(LSTITEM,"RECESS HOURS",$J(RDEFAULT,15,2))
 .;
 .; set hrs for selected weeks, remove from array if zero
 .; 
 . I RDEFAULT'>0 D
 ..  K ^TMP("PRSRW",$J,ITEM)
 . E  D
 ..  S ^TMP("PRSRW",$J,ITEM)=LSTITEM_U_RDEFAULT_U_WKDY1_U_"0"
 ;
 Q
 ;
