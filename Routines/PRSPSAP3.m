PRSPSAP3 ;WOIFO/JAH - Supervisor Approve-update pt phys timecard ;01/05/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
MARK(ACT,PRSIEN,PPI) ; mark supervisors action on temp global
 ; ESR STATUS
 ; when updating a single record we overwrite.  When updating
 ; multiple records we will only update ones with no status.
 N ITEM,OLDACT,REM,OLDREM
 S ITEM=$P($G(ACT),U,2)
 S ACT=$P($G(ACT),U)
 I ITEM>0 D
 .  S PRSD=$G(^TMP($J,"PRSPSAP",PRSIEN,PPI,"B",ITEM))
 .  S ^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD,1)=ACT
 .;  add remarks to the resubmit action, otherwise remove old remarks
 .  I ACT="R" D
 ..    S OLDREM=$G(^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD,2))
 ..    S REM=$$GETREM(OLDREM)
 ..    I REM'="^" S ^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD,2)=$G(REM)
 .  E  D
 ..    K ^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD,2)
 E  D
 .  I ACT="R" S REM=$$GETREM()
 .  S PRSD=0
 .  F  S PRSD=$O(^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD)) Q:PRSD'>0  D
 ..   S OLDACT=$G(^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD,1))
 ..   I OLDACT="" D
 ...     S ^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD,1)=ACT
 ...     I $G(ACT)="R" S ^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD,2)=$G(REM)
 Q
GETREM(SNIDE) ; return supervisor remark for a resubmit request
 ; WE CAN'T EDIT THE FIELD DIRECTLY BECAUSE THIS IS A TRANSACTION
 ; AND NOTHING IS COMMITED TO THE DB UNTIL THEY SIGN
 N DIR,DIRUT,REM,DTOUT,DUOUT,X,Y
 S REM=""
 S DIR(0)="458.02,148^O"
 I $G(SNIDE)'="" S DIR("B")=SNIDE
 S DIR("A")="Enter Remarks"
 D ^DIR
 S REM=$G(Y)
 I $D(DTOUT)!$D(DUOUT) S REM="^"
 Q REM
 ;
CANTPOST(ER,TCS,PPI,PRSIEN,PRSD,ESRN) ; GIVE SUPERVISOR CAN'T POST INFORMATION
 ;
 N I,LNCNT
 D HDR(PRSIEN,PPI,PRSD)
 W !!,"Time Discrepancies must be resolved.    Timecard Status: "
 W $S(TCS="P":"RELEASED TO PAYROLL",1:"TRANSMITTED TO AUSTIN")
 W !,"Payroll must "
 W $S(TCS="P":"return ",1:"initiate corrected ")
 W "timecard or physician must resubmit ESR."
 ;
 W !!!,$$ASK^PRSLIB00(1)
 D HDR(PRSIEN,PPI,PRSD)
 ;
 ;
 W !!,?15,"TIME DISCREPANCIES BETWEEN TIMECARD AND ESR"
 ;W !,?15,"-------------------------------------------"
 W !,?6,"Error",?21,"Type of Time",?39,"Timecard Hrs",?57,"ESR Hrs"
 W !,?2,"--------------------------------------------------------------"
 S I=0 F  S I=$O(ER(I)) Q:I'>0  D
 . W !,?2,$P(ER(I),U,2),?26,$P(ER(I),U),?44,$P(ER(I),U,3),?60,$P(ER(I),U,4)
 ;
 W !!,?32,"ESR POSTING"
 ;W !,?32,"-----------"
 N ESR,DAYLNS,DTE,PDT,DAY
 S PDT=$G(^PRST(458,PPI,2))
 S DTE=$P(PDT,U,PRSD)
 D GETESR^PRSPSAP1(.ESR,PPI,PRSIEN,PRSD)
 D COLHDRS^PRSPSAP1
 W ! F I=1:1:(IOM-1) W "-"
 W ! D DAY^PRSPSAPU(.DAYLNS,PRSD_"^"_DTE,.ESR,PRSIEN,PPI)
 W !!,?30,"TIMECARD POSTING"
 ;W !,?30,"----------------"
 W !,?7,"Date",?21,"Scheduled Tour",?46,"Tour Exceptions"
 W !,?2,"------------------------------------------------------------"
 N DFN S DAY=PRSD,DFN=PRSIEN D F0^PRSADP1
 W !
 Q
 ;
HDR(PRSIEN,PPI,PRSD) ;
 W @IOF,!!,"ESR approval REJECTED for "
 W $P($G(^PRSPC(PRSIEN,0)),"^")," on day ",PRSD," in PP "
 W $P($G(^PRST(458,PPI,0)),U),"."
 Q
 ;
 ;===================================================================
 ;
CMPESRTC(ERCNT,ERMSG,ESRN,TCN,PPI,PRSIEN,PRSD) ;compare the ESR to the timecard
 ;
 ; OUTPUT VARIABLE
 ;
 ;  ERMSG: Array of mismatches in a 4 piece ^ message format
 ;          type of time ^ message ^ timecard total ^ ESR total
 ;
 ; LOCAL VARS
 ;   TT : Type of time code from type of time file (2 exceptions for
 ;        WP on timecard with remark 3, awol is "WPAWOL" OR
 ;        remarks 4, on suspension is "WPSUSP")
 ;   ERFND : flag that some mismatch was found
 ;   ESRT
 ;   TCT   : total time 
 ;
 N TT,ERFND,ESRT,TCT,PRSTA
 ;
 S (ERFND,ERMSG,ERCNT)=0
 I ($G(PPI)'>0)!($G(PRSIEN)'>0)!($G(PRSD)'>0) D  Q
 .  S ERMSG=U_"FATAL ERROR: Missing internal lookup parameters."_U_U
 I $G(ESRN)="" S ESRN=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,5))
 I $G(TCN)="" S TCN=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,2))
 D ESRTCAR(.PRSTA,ESRN,TCN,PPI,PRSIEN,PRSD)
 ;
 ;
 ; Check for any leave posting mismatch (IGNORE WPAWOL, WPSUSP, RG)
 S TT=""
 F  S TT=$O(PRSTA(TT)) Q:TT=""  D
 . Q:"^HX^AL^AA^DL^ML^RL^SL^CB^AD^WP^TR^TV^"'[(U_TT_U)
 . S TCT=+$P(PRSTA(TT),U),ESRT=+$P(PRSTA(TT),U,2)
 . I TCT'=ESRT D
 ..   S ERCNT=ERCNT+1
 ..   S ERMSG(ERCNT)=TT_U_"LEAVE mismatch"_U_TCT_U_ESRT,ERFND=1
 ;
 ; Check for problems with NON PAY.  If non pay is on the timecard
 ; then only NO WORK is accepatable on the ESR.
 ; 
 I $P($G(PRSTA("NP")),U)>0 D
 .  S TT=""
 .  F  S TT=$O(PRSTA(TT)) Q:TT=""!(ERFND)  D
 ..   S ESRT=+$P(PRSTA(TT),U,2)
 ..   I +ESRT>0 D
 ...  S ERCNT=ERCNT+1
 ...  S ERMSG(ERCNT)=TT_U_"NON PAY mismatch"_U_U_ESRT
 Q
 ; 
 ;===================================================================
 ;
ESRTCAR(PRSTA,ESRN,TCN,PPI,PRSIEN,PRSD) ;
 ; return an array subscripted by types of time (TT) for each TT
 ; found in either the ESR or timecard.  Piece 1 of each TT subscript
 ; represents the timcard and piece 2 represents the ESR.
 ; Both pieces contain the total hours in decimal format of that TT.
 ;
 ;
 ; loop through the timecard and the ESR totaling the various types of
 ; time for each.  Exceptions are as follows:
 ;   1. when timecard has WP with remarks AWOL or On Suspension then
 ;      don't add to WP total, since this can never be recorded on 
 ;      the ESR, instead store on special node ("WPAWOL") or ("WPSUSP")
 ;
 ; INPUT VARIABLES
 ;
 ; ESRN : electronic subsidiary record posting node
 ; TCN  : timecard posting node
 ; PPI, PRSIEN, PRSD : package standard
 ;
 ; 
 ;LOCAL variables
 ;  TCPT  : timecard posting type (worked or absent all day or except) 
 ;  TOD   : Tour of duty pointer
 ;  PRSML : Length of meal in minutes
 ;  PRSTA : Time Array subscripted by type of time code (piece one is
 ;            the timecard total time and piece 2 is esr total time
 ;  MTT   : Type of time associated with the meal
 ;  ZNODE : zero node from timecard for tour pointers and lengths
 ;  
 ;
 N TCPT,TOD,PRSML,ZNODE,T1LEN,T2LEN,NETRG,TCEXAMT
 N TSEG,TT,BEG,END,MEAL,HRS,SEGHRS,TRC
 K PRSTA
 ;
 S ZNODE=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0))
 ;
 ; get tour length in case we need to determine amount of time
 ; for the tour when we don't have exceptions on the timecard or
 ; we need the implied RG
 ;
 S T1LEN=$P(ZNODE,U,8)
 S T2LEN=$P(ZNODE,U,14)
 ;
 ;
 ;ESR
 ;
 ;
 F I=1:5:31 D
 .  S TSEG=$P(ESRN,U,I,I+4)
 .  S TT=$P(TSEG,U,3)
 .;
 .;this line may need to be removed since we are simply looking
 .; at all types of time at this stage (also would make this call
 .; more useful as an API to get all types of time)
 .; 
 .  Q:"^RG^HX^AL^AA^DL^ML^RL^SL^CB^AD^WP^TR^TV^"'[(U_TT_U)
 .  S HRS=$P($G(PRSTA(TT)),U,2)
 .  S BEG=$P(TSEG,U)
 .  S END=$P(TSEG,U,2)
 .  S MEAL=$P(TSEG,U,5)
 .  S SEGHRS=$$AMT^PRSPSAPU(BEG,END,MEAL)
 .  S $P(PRSTA(TT),U,2)=SEGHRS+HRS
 ;
 ; if timecard isn't posted there's no point in going on
 Q:(+$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,10)),U,2)'>0)
 ;
 ;Timecard with exceptions (no full day work or leave)
 ;
 S TCPT=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,10)),U,4)
 I '((TCPT=1)!(TCPT=2)) D
 .  F I=1:4:24 D
 ..   S TSEG=$P(TCN,U,I,I+3)
 ..   S TT=$P(TSEG,U,3)
 ..   S TRC=$P(TSEG,U,4)
 ..;  check for awol and store separate from other WP
 ..   I TT="WP" S TT=$S(TRC=3:"WPAWOL",TRC=4:"WPSUSP",1:TT)
 ..   Q:"^HX^AL^AA^DL^ML^RL^SL^CB^AD^WP^TR^TV^"'[(U_TT_U)
 ..   S HRS=$P($G(PRSTA(TT)),U)
 ..   S BEG=$P(TSEG,U)
 ..   S END=$P(TSEG,U,2)
 ..   S SEGHRS=$$AMT^PRSPSAPU(BEG,END,0)
 ..   S $P(PRSTA(TT),U)=SEGHRS+HRS
 E  D
 .;
 .;  if timecard is posted w/exception or work for the full day
 .;  then use the tour 1 and 2 lengths to record hours
 .;
 .  I TCPT=2 D
 ..;  full day exception posted: get type of time and remarks
 ..    S TT="" F I=1:4:24 Q:TT'=""  S TT=$P(TCN,U,I+2),TRC=$P(TCN,U,I+3)
 ..    I TT="WP" S TT=$S(TRC=3:"WPAWOL",TRC=4:"WPSUSP",1:TT)
 .  ;
 .  ; full day work
 .  I TCPT=1 S TT="RG"
 .;
 .  S $P(PRSTA(TT),U)=T1LEN+T2LEN
 ;
 ; RG should not be coded on the PTP's timecard but we will tabulate
 ; the implied RG by reducing the tour length by any exceptions totals
 ;
 I $P($G(PRSTA("RG")),U)="" D
 .  S NETRG=T1LEN+T2LEN
 .  S TT=""
 .  F  S TT=$O(PRSTA(TT)) Q:TT=""  D
 ..;  only times that reduce RG are included
 ..;    (WP, WPAWOL, WPSUSP & NP) reduce RG
 ..   Q:"^HX^AL^AA^DL^ML^RL^SL^CB^AD^TR^TV^"[(U_TT_U)
 ..   Q:TT="RG"
 ..   S TCEXAMT=$P(PRSTA(TT),U)
 ..   S NETRG=NETRG-TCEXAMT
 .  S $P(PRSTA("RG"),U)=NETRG
 ;
 Q
