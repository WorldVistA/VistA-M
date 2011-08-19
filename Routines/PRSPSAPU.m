PRSPSAPU ;WOIFO/JAH - PT Physician, supervisor approval utils ;01/22/05
 ;;4.0;PAID;**93,125**;Sep 21, 1995;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
ONEPTP(TLE) ; get one or all ptp's from a TLE
 ; if the selection hasn't a memo or hasn't an ESR to be approved
 ; then inform and re-ask
 ; 
 ; return PRSIEN for successful PTP selection
 ; return 0 for all PTP's in T&L
 ; return -1 for abort/timeout
 ;
 N ALL,PTP,OUT
 S (PTP,ALL,OUT)=0
 F  D  Q:(OUT!(PTP>0)!(ALL))
 .  S PTP=$$ALL1PTP(TLE)
 .  I PTP=0 S ALL=1 Q  ; all ptp's were selected
 .  I PTP<0 S OUT=1 Q  ; user uparrow or timeout
 .  I PTP>0,'$D(^PRST(458.7,"B",PTP)) W !!,"There are no Service Level Memoranda on file for ",$P(^PRSPC(PTP,0),U) S PTP=0
 .  I PTP>0,'$D(^PRST(458,"ASA",PTP)) W !!,"There are no daily ESR's pending approval for ",$P(^PRSPC(PTP,0),U) S PTP=0
 I ALL S PTP=0
 I OUT S PTP=-1
 Q PTP
 ;
ALL1PTP(TLE) ; ask for one part time physician from a TLE or ALL
 I TLE'?1A.E,TLE'>0 Q PRSIEN
 N DIC,PRSIEN,D,Y,DUOUT,DTOUT
 S PRSIEN=""
 S DIC("A")="Select an EMPLOYEE or press RETURN for ALL: "
 S DIC(0)="AEQM"
 S DIC="^PRSPC("
 S DIC("S")="I $P(^(0),""^"",8)=TLE"
 ; start look up with ATL xref
 S D="ATL"_TLE
 W !
 D IX^DIC
 ;
 ; user hit return for all (return 0)
 I Y=-1,'($D(DUOUT)!$D(DTOUT)) D
 .  S PRSIEN=0
 E  D
 .  S PRSIEN=+Y
 Q PRSIEN
 ;
UPESRST(PPI,PRSIEN,PRSD) ;update ESR DAILY STATUS
 N DIE,DR,DA
 S DA(2)=$G(PPI),DA(1)=$G(PRSIEN),DA=$G(PRSD)
 S DR="146///SIGNED;149///MANUAL POST"
 S DIE="^PRST(458,"_DA(2)_",""E"","_DA(1)_",""D"","
 D ^DIE
 Q
ESRDTS(ESRDTS,PRSIEN,PPI) ; Return signed dates from PTP's ESR
 ; return array ESRDTS subscripted sequentially from 1
 ;    ESRDTS(1) = Tue 2-NOV-04
 ;    ESRDTS(2) = Fri 5-NOV-04
 N PRSD,ITEMS,PRSDTS
 S PRSDTS=$G(^PRST(458,PPI,2))
 S (PRSD,ITEMS)=0
 F  S PRSD=$O(^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD)) Q:PRSD'>0  D
 .  S ITEMS=ITEMS+1
 .  S ESRDTS(ITEMS)=PRSD_U_$P(PRSDTS,U,PRSD)
 Q
DISPLAY(PRSIEN,PPI,CNT) ;display PPI signed esr days for super review/action
 ; RETURN array CNT
 ; CNT = count of days
 ; CNT(1)= days w/status from supervisor during this option
 ; PGLNS = lines on current page
 ; DYLNS = lines in a day
 ; 
 N I,PRSD,ESRDTS,ESEG,ESR,PGLNS,DAYLNS,OUT
 D HDRESR^PRSPSAP1(PRSIEN,PPI,.PGLNS)
 ;
 D ESRDTS^PRSPSAPU(.ESRDTS,PRSIEN,PPI)
 S (PRSD,CNT,CNT(1),OUT)=0
 F  S PRSD=$O(^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD)) Q:PRSD'>0!(OUT)  D
 .  I $Y>(IOSL-6) S OUT=$$ASK^PRSLIB00() D HDRESR^PRSPSAP1(PRSIEN,PPI,.PGLNS)
 .  Q:OUT
 .  D GETESR^PRSPSAP1(.ESR,PPI,PRSIEN,PRSD)
 .  S CNT=CNT+1
 .  W !,CNT
 .  D DAY(.DAYLNS,ESRDTS(CNT),.ESR,PRSIEN,PPI)
 .  S PGLNS=PGLNS+DAYLNS
 Q
 ;
DAY(LN,EXTDAY,ESR,PRSIEN,PPI) ; write a day, return # of lines.
 N STE,ESEG,REMARKS,START,STOP,MEAL,HOURS,STATUSI,LCNT
 S LN=0
 S HOURS=""
 W ?3,$P(EXTDAY,U,2)
 W ?17,ESR("TODEXT")
 ; if tour is too wide for column move down a line
 I $L(ESR("TODEXT"))>16 W ! S LN=LN+1
 ;
 F ESEG=1:5:31 Q:($P(ESR("WORK"),U,ESEG)="")  D
 .   I ESEG>1 W !
 .;   start
 .   S START=$P(ESR("WORK"),U,ESEG)
 .   S STOP=$P(ESR("WORK"),U,ESEG+1)
 .   S MEAL=$P(ESR("WORK"),U,ESEG+4)
 .   W ?33,START
 .   I START'["No work:" D
 ..    W "-"
 ..    S HOURS=$$ELAPSE^PRSPESR2(MEAL,START,STOP)
 .;   stop
 .   W STOP
 .;  type of time
 .   W ?49,$$TTE($P(ESR("WORK"),U,ESEG+2))
 .;   remarks - use 458.02 to convert to external
 .   S REMARKS=$P(ESR("WORK"),U,ESEG+3)
 .   I REMARKS>0 D
 ..     S LN=LN+1
 ..     W !,?34,"Remarks: ",$$EXTERNAL^DILFD(458.02,44,"",REMARKS)
 .;   hours and meal
 .   W ?61,HOURS,?68,MEAL
 ;   display PTP remarks (if any)
    I ESR("RMK")]"" D
 .     W !,?2,"Physician Remarks: "
 .     D WRAP(.LCNT,ESR("RMK"),21,66)
 .     S LN=LN+LCNT
 S STATUSI=$G(^TMP($J,"PRSPSAP",PRSIEN,PPI,+EXTDAY,1))
 W ?72,$$STATUSE(STATUSI)
 Q
GETDAY(ESRDY,ESRDTS,ESR,CNT,PRSIEN,PPI) ; RETURN write a day IN ESRDY ARRAY
 N BLANKS,LN,ESEG,START
 S LN=1
 S BLANKS="                                       "
 S ESRDY(LN)="   "_$P(ESRDTS(CNT),U,2)
 S ESRDY(LN)=$E(ESRDY(LN)_BLANKS,1,18)_ESR("TODEXT")
 ; if tour is too wide for the column move down a line for the work
 I $L(ESR("TODEXT"))>16 S LN=LN+1,ESRDY(LN)=""
 ;
 F ESEG=1:5:31 Q:($P(ESR("WORK"),U,ESEG)="")  D
 .   I ESEG>1 W !
 .;   start
 .   S START=$P(ESR("WORK"),U,ESEG)
 .   S ESRDY(LN)=$E(ESRDY(LN)_BLANKS,1,35)_START
 .   I START'["No work-signed by" S ESRDY(LN)=ESRDY(LN)_"-"
 .;   stop
 .   S ESRDY(LN)=ESRDY(LN)_$P(ESR("WORK"),U,ESEG+1)
 .;  type of time
 .   S ESRDY(LN)=$E(ESRDY(LN)_BLANKS,1,51)_$$TTE($P(ESR("WORK"),U,ESEG+2))
 .;   remarks
 .   S ESRDY(LN)=$E(ESRDY(LN)_BLANKS,1,54)_$P(ESR("WORK"),U,ESEG+3)
 .;   meal
 .   S ESRDY(LN)=$E(ESRDY(LN)_BLANKS,1,68)_$P(ESR("WORK"),U,ESEG+4)
 .   S ST=$$STATUSE($G(^TMP($J,"PRSPSAP",PRSIEN,PPI,+ESRDTS(CNT),1)))
 .   S ESRDY(LN)=$E(ESRDY(LN),1,71)_ST
 .   S LN=LN+1,ESRDY(LN)=""
 Q
 ;
TTE(CODE) ; return external type of time
 N K
 Q:$G(CODE)="" CODE
 S K=$O(^PRST(457.3,"B",CODE,0))
 Q $P($G(^PRST(457.3,+K,0)),"^",2)
 ;
STATUSE(ST) ; return external form of supervisor action status
 S ST=$G(ST)
 Q $S(ST="B":"Bypass",ST="R":"Resubmit",ST="A":"Approved",1:"")
 ;
CLRTCDY(PPI,PRSIEN,PRSD,EST) ;function true (1) for success otherwise 0
 ;  clear a timecard day (2,3,10 nodes) if status is (T) timekeeper
 ;  clear work, posting status and remove approved status from ESR day.
 ; INPUT: PPI,PRSIEN,PRSD: package standard
 ;        EST : optional, valid ESR DAILY STATUS internal value
 ;
 Q:($G(PPI)'>0)!($G(PRSIEN)'>0)!($G(PRSD)'>0) 0
 Q:'$D(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0)) 0
 N TCSTAT
 S TCSTAT=$$TCSTAT^PRSPSAP2(PPI,PRSIEN)
 Q:$G(TCSTAT)'="T" 0
 ;
 ; kill the timecard work nodes
 K ^PRST(458,PPI,"E",PRSIEN,"D",PRSD,2),^(3),^(10)
 ;
 ; ONLY if a valid ESR daily status is passed then set it
 N VALID
 D CHK^DIE(458.02,146,"",$G(EST),.VALID)
 Q:VALID["^" 1
 ;
 N IENS,PRSFDA
 S IENS=PRSD_","_PRSIEN_","_PPI_","
 S PRSFDA(458.02,IENS,146)=EST
 D FILE^DIE("","PRSFDA")
 D MSG^DIALOG()
 Q 1
 ;
WRAP(LNS,STR,TAB,WID) ; format a long message string to break lines at words
 ; TAB is left margin
 ; WID is right margin
 ; return LNS number of lines it took to write
 N WORD,I,WC,COLW,W1,W2
 S WC=0,WORD=""
 S COLW=WID-TAB+1
 W ?$G(TAB)
 S LNS=1
 F I=1:1:$L(STR," ") D
 .  S WORD=$P(STR," ",I)
 .  Q:WORD=""
 .;   break words longer than the width of the column
 .  F  Q:($L(WORD)<(COLW+1))  D
 ..    S W1=$E(WORD,1,COLW-1)_"-"
 ..    S W2=$E(WORD,COLW,$L(WORD))
 ..    S WORD=W1 D WW
 ..    S WORD=W2
 .  D WW
 Q
WW ; Write Word
 I ($X+$L(WORD))>WID D
 .   I WC>0 W !,?$G(TAB) S LNS=LNS+1,WC=0
 W WORD," " S WC=WC+1
 Q
 ;
 ;
 ;===============================================================
 ;
AMT(START,STOP,MEAL) ; return decimal hours between times
 ; times are in PAID timecard work node format. (e.g. 04:30P )
 N AMT,X
 S AMT=$$ELAPSE^PRSPESR2(MEAL,START,STOP)
 S X=$P(AMT,":",2) S X=$S(X=30:5,X=15:25,X=45:75,1:0)
 S AMT=+$P(AMT,":",1)_"."_X
 Q AMT
