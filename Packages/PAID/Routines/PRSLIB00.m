PRSLIB00 ;WOIFO/JAH - PAID LIBRARY - ROUTINES & FUNCTIONS ;01/22/2005
 ;;4.0;PAID;**25,35,49,57,93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ;=====================================================================
AVAILREC(WHO,GLOBREF,OUT) ;IS RECORD AVAILABLE
 ;parameters
 ;  WHO     indicates type of option attempting the lock (TK or SUP)
 ;  GLOBREF passed by reference - used to return a global name
 ;  OUT     passed by reference - used to return results of call to
 ;          $$ASK. Equals 1 if user entered '^' at the prompt.
 ;          Is only defined when employee record could not be locked.
 ;make sure there is a pay period record for employee & that
 ;record is not being edited by timekeeper or supervisor.
 ;
 ;If record is available, then lock it and store pointer to
 ;locked record in ^TMP($J,"LOCK" so we can unlock all 
 ;records in ^TMP "queue" upon exit of certification option.
 ;
 N MESSAGE,M1,M2,M3,EMPNAME
 ;
 ;create message depending on which option is being used to attempt
 ;to edit record: Supervisory Certification or TimeKeeper posting.
 ;
 S M1="-Employee's pay period record locked. "
 S M2=$S(WHO="SUP":"Timekeeper",WHO="TK":"Supervisor",1:"Another user")
 S M3=" may be editing or reviewing."
 S MESSAGE=M1_M2_M3
 ;
 ;
 S GLOBREF="^PRST(458,"_PPI_","_"""E"""_","_DFN_",0)"
 K OUT
 S AVAIL=0
 I $D(^PRST(458,PPI,"E",DFN,0)) D
 .  S EMPNAME=$P($G(^PRSPC(DFN,0)),"^")_" "
 .  I '$$LOCK(GLOBREF) W !!,EMPNAME,!,MESSAGE S OUT=$$ASK^PRSLIB00()
 .  E  D
 ..    S ^TMP($J,"LOCK",DFN)=""
 ..    S AVAIL=1
 Q AVAIL
 ;====================================================================
 ;
 ;===================================================================
LOCK(GLOBREF) ;INCREMENTALLY LOCK A RECORD
 ;
 ;RETURN FALSE IF RECORD ALREADY HAS A LOCK
 L +@GLOBREF:2 S SUCCESS=$T
 Q SUCCESS
 ;
 ;===================================================================
 ;
 ;====================================================================
 ;
UNLOCK(GLOBREF) ;INCREMENTALLY UNLOCK A RECORD
 L -@GLOBREF
 Q
 ;
 ;===================================================================
 ;
 ;===================================================================
ASK(HOLD) ;ask user 2 continue function
 ;return true (1) if user want's 2 stop, false (0) 2 continue.
 ;If HOLD defined, use prompt 2 hold display until user hits return.
 ;If not terminal then, do nothing, return FALSE.
 ;
 S STOP=0
 I $E(IOST,1,2)="C-" D
 .;
 .N RESP,DIR S RESP=0
 .I $G(HOLD) S DIR(0)="EA",DIR("A")="Enter return to continue. "
 .E  S DIR(0)="E"
 .D ^DIR I Y="" S STOP=0
 .I $D(DIRUT) S STOP=1
 Q STOP
 ;=====================================================================
BLDYR(NEXT) ;Build year with last digit of year.
 ;pivot back 2 years and forward 7.
 ;NEXT is a single digit (0-9).  Single digit is assummed 2 b last 
 ;digit in a year.  This function takes that digit & finds 
 ;1st yr. including current year that has passed digit in it's 
 ;last position.  4 digit year returned.
 ;
 N CNT,CURR,I,ADDYRS,YR,X1,X2,Y,X,RTN
 S CNT=0
 S YR=$E(DT,1,3)-2
 S CURR=$E(YR,3)
 F I=1:1:10  Q:CURR=NEXT  D
 . S CURR=CURR+1
 . S CURR=$E(CURR,$L(CURR))
 . S CNT=CNT+1
 S ADDYRS=CNT*365
 S YR=YR_"0601" S X1=YR,X2=ADDYRS D C^%DTC
 S Y=X D DD^%DT S RTN=$P(Y," ",3)
 Q RTN
 ;==================================================================
LEAPYR(Y) ;boolean function determines if year is leap year.
 ;INPUT:           Y =  year in standard 4 digit format.
 ;OUTPUT:  LEAPFLAG =  return 1 for leap year, otherwise 0.
 ;
 N LEAPFLAG
 S LEAPFLAG='(Y#4)
 I '(Y#100) S LEAPFLAG='(Y#400)
 Q LEAPFLAG
 ;==================================================================
MONOGRPH(MSG) ;DISPLAY A MESSAGE (MSG)
 ;
 N HAIR,FORHEAD,NOSE,LINE,TOE,TAB1,TAB2,LEN
 S LEN=$L(MSG)
 S TAB1=(47-LEN\2)
 S TAB2=48
 S HAIR="                       /////"
 S TOE="|_______________________________________________|"
 S NOSE="|                       (_)                     |"
 S LINE="|                                               |"
 S FORHEAD=" __________________oOO_(O-O)__OOo_______________"
 W !!,HAIR,!,FORHEAD,!,NOSE,!,LINE
 W !,"| ",?TAB1,MSG,?TAB2,"|",!,LINE,!,TOE,!
 Q
 ;===================================================================
 ;=====================================================================
HUMDRUM(ZZ,INC) ;A SORT OF CLOCK THAT SPINS WHILE LONG PROCESSING IS OCCURRING
 S ZZ=ZZ+INC I ZZ#1=0 S ZZT=ZZ#9 W $C(13),$S(ZZT=1:"|",ZZT=2:"/",ZZT=3:"-",ZZT=4:"\",ZZT=5:"|",ZZT=6:"/",ZZT=7:"-",ZZT=8:"\",1:"") I ZZ=8 S ZZ=0
 Q ZZ
 ;=====================================================================
 ;
 Q
MSSG(MSG) ;Randomly pick a heart warming message
 ; MSGS = The # of messages in this routine.  If u add a message, update
 N MSGS,CNT
 S MSGS=8
 S CNT=$R(MSGS)+1,MSG=$P($TEXT(MSG+CNT),";",2)
MSG ;
 ;All Work & No Training, Makes Me a Dull Dude!
 ;Well Trained Employees, Put Veterans First!
 ;You Bet, Train a Vet!
 ;By failing to prepare we prepare to fail.
 ;Ideas won't work unless you do.
 ;The future is purchased by the present.
 ;A smooth sea never made a skillful sailor.
 ;Don't learn safety rules simply by accident.
 ;
 Q
 ;
CVTDATE(X,PRSDATE) ;
 ;  Called by the input transform of File 458.1 (LEAVE REQUEST) field 
 ;  # 2 From Date and field # 4 To Date.
 ;      
 ;  INPUT:  X - is set to the external representation of the date 
 ;           selected by the user.
 ;
 ;          PRSDATE - The variable Z1 is created by Form PRSA LV REQ and
 ;           is passed by the input transform to CVTDATE. This variable
 ;           may not be defined if this field is edited by another
 ;           method.  If defined PRSDATE will be the internal FileMan
 ;           representation of the date entered by the user for the
 ;           From Date field.  During the To Date field validation,
 ;           PRSDATE will represent the earliest date allowed.
 ;
 ; OUTPUT:  X - is returned by the function.  X will contain either the
 ;           internal FileMan format for the valid date selected by
 ;           the user or the value -1 if an invalid date was selected.
 ;
 N FUTYR,PASYR,%DT,BEGINDT,X1,X2,Y
 ;
 ; Set %DT to not allow TODATE earlier than FROMDATE.  Z1 contains
 ; the date stored in FROMDATE in the FileMan internal date format.
 ;
 I +$P($G(PRSDATE),"^")?7N S %DT(0)=$P(PRSDATE,"^")
 ;
 ; Convert user input based on assumed past date lookup.
 ; Y will contain the user selected date in internal FileMan format.
 ;
 S %DT="XP" D ^%DT
 S PASYR=Y
 ;
 ; Convert user input based on assumed future date lookup
 ; Y will contain the user selected date in internal FileMan format.
 ;
 S %DT="XF" D ^%DT
 S FUTYR=Y
 ;
 ; If these two lookups match the user specified a four digit
 ; year and no extra processing is necessary.
 ;
 I PASYR=FUTYR S X=PASYR
 ;
 ; If these two lookups don't match then the user did not
 ; enter a four digit year. That's o.k. but we need to assume that 
 ; they meant either 60 days ago or in the future.
 ;
 ; Subtract 60 days from today and test to see if the date the user
 ; entered falls within this range.
 ;
 I PASYR'=FUTYR D
 .S X1=DT,X2=-60
 .D C^%DTC
 .S BEGINDT=X
 .; Default the date to the past year lookup and begin testing
 .S X=PASYR
 .; Perform two checks:
 .; #1 Does the user entered date fall within that last 60 days?
 .;    If it doesn't execute check #2.
 .; #2 Does the date falls within the standard +20 year
 .; time window?  If so then default to a future year.
 .I BEGINDT>PASYR,($E(DT,1,3)+20'<$E(FUTYR,1,3)) S X=FUTYR
 ;
 Q X ; Return the user selected date in the FileMan internal date format.
