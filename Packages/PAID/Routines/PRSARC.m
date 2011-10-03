PRSARC ;WOIFO/JAH - Recess Tracking ListManger Inteface ;10/16/06
 ;;4.0;PAID;**112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
ENEDIT ; -- main entry point for PRSA RECESS TRACKING
 S PRSOUT=0
 ;
 D SETUP(.PRSOUT)
 I $G(PRSOUT)=1 D EXIT Q
 ;
 ; set global var to allow editing
 S PRSVIEW=0
 D EN^VALM("PRSA RECESS TRACKING MANAGER")
 Q
SUP ;
TK ;
 N PRSTLV,TLE,TLI
 S PRSTLV=2 D ^PRSAUTL
 Q:$G(TLE)=""
 N DIC,Y,FYREC,PRSIEN,DUOUT,DTOUT
 S DIC("S")="I $P(^PRSPC(+^PRST(458.8,+Y,0),0),U,8)=TLE"
 S DIC(0)="AEMZQ"
 S DIC("A")="Select 9-month AWS Nurse: "
 S DIC="^PRST(458.8,"
 D ^DIC
 Q:$D(DUOUT)!$D(DTOUT)!($G(Y)'>0)
 S PRSIEN=Y(0)
 S FYREC=+Y
 D ENVIEW
 Q
HR ;
 N DIC,Y,FYREC,PRSIEN,DUOUT,DTOUT
 S DIC(0)="AEMZQ"
 S DIC("A")="Select 9-month AWS Nurse: "
 S DIC="^PRST(458.8,"
 D ^DIC
 Q:$D(DUOUT)!$D(DTOUT)!($G(Y)'>0)
 S PRSIEN=Y(0)
 S FYREC=+Y
 D ENVIEW
 Q
NURSE ;
 N DIC,Y,FDEFAULT,SSN,FYREC,PRSIEN,DUOUT,DTOUT,ABORT
 S PRSNURSE="",SSN=$P($G(^VA(200,DUZ,1)),"^",9)
 I SSN'="" S PRSNURSE=$O(^PRSPC("SSN",SSN,0))
 I 'PRSNURSE W !!!,*7,"Your SSN was not found in either the New Person file or the Employee file.",!! H 1 S ABORT=$$ASK^PRSLIB00(1) Q
 S FDEFAULT=$O(^PRST(458.8,"AC",PRSNURSE,9999999),-1)
 I 'FDEFAULT W !!,*7,"You have no recess schedules on file.  Please contact your timekeeper.",!! H 1 S ABORT=$$ASK^PRSLIB00(1) Q
 S FDEFAULT=$O(^PRST(458.8,"AC",PRSNURSE,FDEFAULT,0))
 S FDEFAULT=+$G(^PRST(458.8,FDEFAULT,3))
 S DIC("B")=FDEFAULT
 S DIC(0)="AEMZQ"
 S DIC("A")="Select a Recess Schedule: "
 S DIC="^PRST(458.8,"
 S DIC("S")="I +^PRST(458.8,+Y,0)=PRSNURSE"
 D ^DIC
 Q:$D(DUOUT)!$D(DTOUT)!($G(Y)'>0)
 S PRSIEN=Y(0)
 S FYREC=+Y
 D ENVIEW
 Q
ENVIEW ; -- main entry point for PRSA RECESS VIEWER
 ; ask user nurse then provide selection of available recess records
 ; by fiscal year that may be viewed.
 ;
 N ZNODE,NAME,SSN,TLE
 S ZNODE=$G(^PRSPC(+PRSIEN,0))
 S NAME=$P(ZNODE,U)
 ; set global var so action protocols will be unavailable (view only)
 S PRSVIEW=1
 S SSN=$P(ZNODE,U,9),SSN="XXX-XX-"_$E(SSN,6,9)
 S TLE=$P(ZNODE,U,8)
 S PRSNURSE=PRSIEN_U_NAME_U_U_TLE_U_SSN
 S PRSFY=$$FYRDATA^PRSARC03(FYREC)
 S PRSFYRNG=$P(PRSFY,U,5,6)
 D FYWEEKS^PRSARC04(.FMWKS,PRSFY,0)
 D FYWEEKS^PRSARC04(.WKSFM,PRSFY,1)
 S PRSDT=$P(PRSFY,U,11)
 S PRSFSCYR=$$GETFSCYR^PRSARC04(PRSDT)
 S PRSRWHRS=$$GETAVHRS^PRSARC04(.FMWKS,PRSDT)
 D EN^VALM("PRSA RECESS TRACKING VIEWER")
 Q
 ;
SETUP(OUT) ; Setup for a new AWS schedule-prompt for year & start or bring
 ; up an existing schedule
 ;
 ;
 ; get NURSE IEN^NAME^(0 edit only, 1 add and edit)
 ; if nurse is currently entitled to recess a new rec can be added,
 ; otherwise only edit existing records curr, next, or last are allowed.
 ; 2nd input param=2 for timekeepers T&L lookup
 ; 
 D GETNURSE^PRSARC02(.PRSNURSE,2)
 I +$G(PRSNURSE)'>0 S OUT=1 Q
 L +^PRST(458.8,+PRSNURSE):$S($G(DILOCKTM)>0:DILOCKTM,1:5) I '$T W !,"Another user is editing this nurses recess records." S OUT=1 Q
 ;
 ; Set global variable to hold total of weeks that are selectable
 ;
 N ALLFY,FD,LD,RWREC
 ;
 ; Build schedule choice and ask which one to edit, current next last.
 ; If schedule exists we get 458.8 Recess Tracking IEN.
 ;
 D CHOOSEFY^PRSARC02(.PRSFY,PRSNURSE)
 ;
 I $G(PRSFY)'>0 S OUT=1 Q
 S RWREC=$P(PRSFY,U,9)
 ;
 ; get range of dates for PRSFY
 ;
 S PRSFYRNG=$P(PRSFY,U,5,6)
 ;
 S FD=$P(PRSFYRNG,U,1)
 S LD=$P(PRSFYRNG,U,2)
 ;
 ; Build 2 indexes: (1) FMWKS with FMdate subscript = week number and
 ; (2) WKSFM with week number subscript = FMdate (1st day of week)
 ;
 D FYWEEKS^PRSARC04(.FMWKS,PRSFY,0)
 D FYWEEKS^PRSARC04(.WKSFM,PRSFY,1)
 ;
 ; use existing AWS Start Date if it exist otherwise
 ; ask if AWS will cover entire fiscal year?
 ;
 ;code for setting continuous recess for new records
 N NEWREC S NEWREC=0
 ;
 S PRSDT=$P(PRSFY,U,11)
 I PRSDT'>0 D
 . ;code for setting continuous recess for new records
 .  S NEWREC=1
 .;
 .  S ALLFY=$$ALLFYAWS^PRSARC04()
 .  I ALLFY<0 D
 ..    S OUT=1 K PRSFY
 .  E  D
 ..    I ALLFY=1 D
 ...      S PRSDT=FD
 ..    E  D
 ...      S PRSDT=$$AWSTART^PRSARC03(FD,LD,"Enter Date 9 mo. AWS begins")
 ...      I PRSDT=0 S OUT=1 K PRSFY
 .  I 'OUT D
 ..; convert start to 1st day of pp and 
 ..; update the PRSFY var with new start date info
 ..   N D1,DAY,PPI,PPE S D1=PRSDT D PP^PRSAPPU
 ..   I DAY'=1 N X1,X2,X,%H S X1=D1,X2=-(DAY-1) D C^%DTC S PRSDT=X
 ..   S $P(PRSFY,U,12)=PPE
 ..   S $P(PRSFY,U,10)=$E(PRSDT,4,5)_"/"_$E(PRSDT,6,7)_"/"_$E(PRSDT,2,3)
 ..   S $P(PRSFY,U,11)=PRSDT
 Q:OUT
 ;
 S PRSFSCYR=$$GETFSCYR^PRSARC04(PRSDT)
 ;
 ;GET total available hours based on fiscal year and start date.
 ;
 S PRSRWHRS=$$GETAVHRS^PRSARC04(.FMWKS,PRSDT)
 ;code for setting continuous recess for new records
 I NEWREC S PRSAUTOR=$$AUTOREC^PRSARC09(PRSDT,LD)
 ;
 Q
 ;
HDR ; -- header code
 N NAME,SSN,TLE,PAD
 S NAME=$E($P(PRSNURSE,U,2),1,30)
 S SSN=$P(PRSNURSE,U,5)
 S TLE=$P(PRSNURSE,U,4)
 S VALMHDR(1)=$P(PRSFSCYR,U,2)_" Recess Week "_$S($G(PRSVIEW):"Viewer",1:"Editor")_" for 9 month AWS with start date "_$P(PRSFY,U,10)_" (pp "_$P(PRSFY,U,12)_")"
 S PAD=$E("                               ",1,31-$L(NAME))
 S VALMHDR(2)=NAME_PAD_SSN_"              T&L Unit: "_TLE
 Q
 ;
INIT ; -- init variables and list array
 ;
 ; PRSLSTRT = what week the list starts with.  So if the schedule
 ;            begins in the 13th week of the fiscal year, this var
 ;            would be 13 and the first selectable item in the list.
 ; PRSWKLST = increment counter for items in the list that are #ed
 ;            and thus selectable.  when init is done calling main this
 ;            should be set to week # of the last week in the FY.
 ;  LINE  =   counter of all items in list, incl. non selectable items
 ;            such as month headings.
 ;
 Q:$G(PRSOUT)=1
 N LISTI,LINE,FIRSTRW
 S (LISTI,LINE)=0
 K ^TMP("PRSARC",$J) ;  array-all items in list, incl. non selectable 
 ;                      items such as month headings.
 K ^TMP("PRSLI",$J) ; index of all selectable items in the list.
 K ^TMP("PRSSW",$J) ; index of items selected as recess weeks.
 K ^TMP("PRSRW",$J) ; index of recess weeks with hours.
 D MAIN^PRSARC06(.PRSLSTRT,.LISTI,.LINE,PRSDT,PRSFYRNG)
 S PRSWKLST=LISTI-1
 S VALMCNT=LINE
 ;
 ; add recess hours to screen and PRSRW array if they exist
 ;
 S RWREC=$P(PRSFY,U,9)
 I RWREC>0 D GETFLWKS^PRSARC03(RWREC,PRSDT)
 ;
 ; add recess hours if user elected to auto populated recess and start
 ; list display at that week
 ;
 I +$G(PRSAUTOR)>0 D ADDAUTOR^PRSARC09(PRSAUTOR)
 S FIRSTRW=$O(^TMP("PRSRW",$J,0))
 I $G(FIRSTRW)>0 S FIRSTRW=+^TMP("PRSRW",$J,FIRSTRW) I $G(FIRSTRW)>3 S VALMBG=FIRSTRW-1
 ;
 ; get timecard posted recess that's certified
 D RPOSTED^PRSARC03
 Q
 ;
HELP ; -- help code
 N DIR
 I X="?" S DIR("A")="Enter RETURN to continue or '^' to exit",DIR(0)="E"
 D FULL^VALM1
 W !!,"The following actions are available:"
 W !,"  GH  Recess Hours Summary - recess weeks and hours summary with totals."
 I $G(PRSVIEW)'=1 D
 .W !,"  SE  Select Recess Weeks - select weeks and add/edit recess hours."
 .W !,"  EH  Edit Recess Hours - edit recess hours for each selected week."
 .W !,"  CR  Cancel Recess Weeks - remove recess hours from selected weeks."
 .W !,"  NS  Change AWS Start - change pay period when the AWS becomes effective."
 .W !,"  HE  Help - Get more detailed help about the available actions."
 .W !,"  SV  Save Recess Schedule - save any edits and continue editing."
 .W !,"  QU  Quit without Saving - exit without saving changes."
 .W !,"  EX  Exit and Save Recess - file changes to recess schedule and exit."
 I $D(DIR("A")) D ^DIR
 S VALMBCK="R"
 Q
 ;
EXIT ; -- exit code
 D FULL^VALM1
 I +$G(PRSFY) D VALIDRS^PRSARCS
 I '$G(PRSVIEW) D
 .  L -^PRST(458.8,+$G(PRSNURSE))
 .  I +$G(PRSFY) D ALLOKEY^PRSARC04(+$G(PRSNURSE))
 ;
 K ^TMP("PRSARC",$J),^TMP("PRSLI",$J),^TMP("PRSRW",$J),^TMP("PRSSW",$J)
 K PRSFYRNG,PRSFSCYR,PRSWKLST,PRSLSTRT,PRSFY,PRSNURSE
 K PRSVIEW,PRSOUT,PRSRWHRS,PRSDT,PRSVONLY,PRSAUTOR
 K FMWKS,WKSFM,RWREC
 ; clean up vars from PRS calls outside of Recess Tracking
 K C0,FLX,A1,DAY,AC,DAY,PP,PMP,STOP,T1,T2,Z1,TESTINPP
 Q
 ;
EXPND ; -- expand code
 Q
 ;
