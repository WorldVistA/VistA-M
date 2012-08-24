PRSNCGR ;WOIFO-JAH - Release POC Records for VANOD Extraction;10/16/09
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
RELEASE ; Routine provides functionality to release records for
 ; VANOD extraction.  I.e., search for POC records who's pay period
 ; status is approved and move those records to the extraction
 ; file.  Records in the POC file may cross midnight, but we will
 ; split those records at midnight and report the activity on the
 ; day on which it occured.
 ;
 ;    Prompt Coordinator for Divisions to release (one, many, all) 
 ;
 N PRSINST,PPI,PPS,MMR
 ;
 D GETDIV(.PRSINST) Q:PRSINST<0
 ;
 ; Check all pay periods with approved records which are 
 ; ready to be released.
 ;
 D PPRELCHK(.PPS,.PRSINST)
 ;
 ;    prompt for pay period
 ;
 S PPI=$$GETPP(.PPS) Q:PPI'>0
 ;
 ;
 ; do prelimary report of record status
 ;
 D CNTREP^PRSNCGR1(.PRSINST,PPI)
 ;
 I '$D(PPS("P",PPI)) D  Q
 .  W !!,"There are no records in pay period ",$P($G(^PRST(458,PPI,0)),U)," approved for release."
 .  W !! S X=$$ASK^PRSLIB00(1)
 ;
 ;    prompt for mismatch report 
 ;
 S MMR=$$ASKMM() Q:MMR<0
 ;
 I MMR D
 . N %ZIS,POP,IOP
 . S %ZIS="MQ"
 . D ^%ZIS
 . Q:POP
 . I $D(IO("Q")) D
 .. K IO("Q")
 .. N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC
 .. S ZTDESC="PRSN POC/ETA MISMATCH REPORT"
 .. S ZTRTN="MMREP^PRSNCGR"
 .. S ZTSAVE("PPI")=""
 .. S ZTSAVE("PRSINST(")=""
 .. D ^%ZTLOAD
 .. I $D(ZTSK) S ZTREQ="@" W !,"Request "_ZTSK_" Queued."
 . E  D
 .. D MMREP
 ;
 I $$SUREQ() D
 . N %ZIS,POP,IOP
 . S %ZIS="MQ"
 . D ^%ZIS
 . Q:POP
 . I $D(IO("Q")) D
 .. K IO("Q")
 .. N ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC
 .. S ZTDESC="PRSN POC/ETA RELEASE REPORT"
 .. S ZTRTN="DRIVER^PRSNCGR"
 .. S ZTSAVE("PPI")=""
 .. S ZTSAVE("PRSINST(")=""
 .. D ^%ZTLOAD
 .. I $D(ZTSK) S ZTREQ="@" W !,"Request "_ZTSK_" Queued."
 . E  D
 .. D DRIVER
 Q
MMREP ;
 N REC,CNT,FIELD,SEGCNT,PC,OUT,PG,CI,SN
 U IO
 S (PG,REC,OUT)=0
 F  S REC=$O(PRSINST(REC)) Q:REC'>0!OUT  D
 .    S CI=+PRSINST(REC)
 .    D GETS^DIQ(4,CI_",","99","E","FIELD(",,)
 .    S SN=FIELD(4,CI_",",99,"E")
 .    S PRSIEN=0
 .    F  S PRSIEN=$O(^PRSN(451,"AA",CI,PPI,PRSIEN)) Q:PRSIEN'>0!OUT  D
 ..      D PPMM^PRSNRMM(PRSIEN,PPI,.PG,.OUT)
 D ^%ZISC
 Q
 ;
DRIVER ;
 N REC,CI,SN,CNT,PRSIEN,SEGCNT,PC
 U IO
 S REC=0
 F  S REC=$O(PRSINST(REC)) Q:REC'>0  D
 .  S CI=+PRSINST(REC)
 .  D GETS^DIQ(4,CI_",","99","E","FIELD(",,)
 .  S SN=FIELD(4,CI_",",99,"E")
 .  S CNT(CI)="0^0"
 .  S PRSIEN=0
 .  F  S PRSIEN=$O(^PRSN(451,"AA",CI,PPI,PRSIEN)) Q:PRSIEN'>0  D
 ..    S SEGCNT=0
 ..    S $P(CNT(CI),U)=$P(CNT(CI),U)+1
 ..    K PC D EXTRECS(.PC,.SEGCNT,PPI,PRSIEN)
 ..    D FILEPP^PRSNCGR1(.PC,PRSIEN,PPI,CI,SN)
 ..    S $P(CNT(CI),U,2)=$P(CNT(CI),U,2)+SEGCNT
 ..    D UPDTPOC^PRSNCGR1(PPI,PRSIEN,"R")
 .; if any records were released then update the release history for
 .; for this division
 .  I $P(CNT(CI),U,2)>0 D
 ..    D UPDTPP^PRSNCGR1(PPI,CI,$P(CNT(CI),U),$P(CNT(CI),U,2))
 D RESULTS(.CNT,PPI)
 ;
 D ^%ZISC
 Q
 ;
GETPP(PPS) ;prompt for and return pay period
 ; Use the following criteria:
 ;   1) pp must exist in 451
 ;   2) Default value is most recently ended pay period
 ;   3) selection of a pay period that has not ended is not allowed
 ;   4) Screen out pay periods with no approved data
 N DIC,DUOUT,DTOUT,X,Y,PPI,DEFPP,PPTEMP
 ;
 ; set default as most recent pay period with data but must be 
 ; earlier than current
 ;
 S PPTEMP=$G(^PRST(458,"AD",DT))
 S DEFPP=$O(PPS("P",PPTEMP),-1)
 S DIC("B")=DEFPP
 S DIC="^PRSN(451,",DIC(0)="AEQMZ"
 S DIC("A")="Select a Pay Period: "
 S DIC("S")="I +Y'>DEFPP&($D(PPS(""P"",+Y)))"
 D ^DIC
 I $D(DUOUT)!$D(DTOUT)!+$G(Y)'>0 Q 0
 Q +Y
 ;
GETDIV(PRSINST) ;
 N DIC,VAUTSTR,VAUTNI,VAUTVB,Y,CNT
 S DIC="^PRST(456,"
 S VAUTSTR="PAID Parameter Institution"
 S VAUTNI=2,VAUTVB="PRSINST"
 D FIRST^VAUTOMA
 I $G(Y)<0 S PRSINST=Y Q
 S (CNT,Y)=0
 ;
 ; all institutions selected, so loop through file to get them.
 I PRSINST D
 .  F  S Y=$O(^PRST(456,Y)) Q:Y'>0  D
 ..    S PRSINST(Y)=$G(^PRST(456,Y,0))
 ;
 ; Since the one, many or all call (VAUTOMA) doesn't explicitly return
 ; whether the user aborted the prompt, we need to check to see
 ; if there is anything in the selection array at this point
 ;  and return -1 if nothing was selected.
 ;
 S Y=0
 F  S Y=$O(PRSINST(Y)) Q:Y'>0  D
 .  S CNT=CNT+1
 I CNT'>0 S PRSINST=-1
 Q
 ;
ASKMM() ;
 W !!," Would you like to view the mismatch report"
 W !," for records to be released?"
 N DIR,DIRUT,X,Y S DIR(0)="Y",DIR("B")="N" D ^DIR
 I $D(DIRUT) S Y=-1
 Q Y
SUREQ() ;
 W !!," Are you sure you want to Release POC records?"
 N DIR,DIRUT,X,Y S DIR(0)="Y",DIR("B")="N" D ^DIR
 I $D(DIRUT) S Y=-1
 Q Y
 ;
EXTRECS(PC,SEGCNT,PPI,PRSIEN) ; get all POC activity for nurses pay period
 ;
 ;  INPUT:
 ;          PRSIEN - (required) nurse 450 IEN
 ;          PPI (required) pay period IEN
 ;  OUTPUT:
 ;          PC - Array of POC activity records formatted for
 ;             the extraction file.
 ;
 ; Note: any work from the 2nd Saturday night of the prior pay period is 
 ; returned in the zero node of PC, if that pp is either approved or
 ; released.
 ;
 ; In general.  Work from a two day tour is included on the node
 ; for that day.  I.e., two day tours are split at midnight.
 ; 
 N PRSD,POCD,T1,T2,SEG,SI,MT,T1N,T2N
 ;
 S SI=0
 K POCD
 ; If prior pp approved or released get any spillover from 2nd Sat.
 I "^A^R^"[(U_$P($G(^PRSN(451,PPI-1,"E",PRSIEN,0)),U,2)_U) D
 .  D L1^PRSNRUT1(.POCD,PPI-1,PRSIEN,14)
 .  S PRSD=0
 .  D SEGS
 ;
 F PRSD=1:1:14 D
 .  K POCD
 .  D L1^PRSNRUT1(.POCD,PPI,PRSIEN,PRSD)
 .  D SEGS
 ;
 ;   Don't extract day 14 from prior pay period
 K PC(0)
 ; we may end up with data in PC(15)--2 day tour on day 14 of current
 ; pp.  That should only be extracted for corrections and is handled
 ; by the release corrections logic
 Q
SEGS ;
 S SEG=0
 F  S SEG=$O(POCD(SEG)) Q:SEG'>0  D
 .;  T1 and T2 are start and stop times for each segment.
 .; 1st IF handles segments occuring entirely on 2nd day of a tour.
 .; 2nd if splits segments that cross midnight into segments on the day
 .; they occur and the ELSE DO handles segments entirely on 1st day.
 .;
 .    S (T1,T1N)=$P(POCD(SEG),U,9)
 .    S (T2,T2N)=$P(POCD(SEG),U,10)
 .    S MT=$P(POCD(SEG),U,3)
 .    I T1'<2400 D
 ..      S SI=SI+1
 ..      S PC(PRSD+1,SI)=POCD(SEG)
 ..      S T1N=T1-2400
 ..      S $P(PC(PRSD+1,SI),U,9)=T1N
 ..      S T2N=T2-2400
 ..      I MT S T2N=$$SUBMEAL(T1N,T2N,.MT)
 ..      S $P(PC(PRSD+1,SI),U,2)=$$EXTIME(T2N)
 ..      S $P(PC(PRSD+1,SI),U,3)=0
 ..      S $P(PC(PRSD+1,SI),U,10)=T2N
 .    E  D
 ..      I T2>2400 D
 ...        S SI=SI+1
 ...        S PC(PRSD,SI)=POCD(SEG)
 ...        S T2N=2400
 ...        I MT S T2N=$$SUBMEAL(T1N,T2N,.MT)
 ...        S $P(PC(PRSD,SI),U,2)=$$EXTIME(T2N)
 ...        S $P(PC(PRSD,SI),U,3)=0
 ...        S $P(PC(PRSD,SI),U,10)=T2N
 ...        S SI=SI+1
 ...        S PC(PRSD+1,SI)=POCD(SEG)
 ...        S T1N=0,T2N=T2-2400
 ...        S $P(PC(PRSD+1,SI),U)="MID"
 ...        S $P(PC(PRSD+1,SI),U,9)=T1N
 ...        I MT S T2N=$$SUBMEAL(T1N,T2N,.MT)
 ...        S $P(PC(PRSD+1,SI),U,2)=$$EXTIME(T2N)
 ...        S $P(PC(PRSD+1,SI),U,3)=0
 ...        S $P(PC(PRSD+1,SI),U,10)=T2N
 ..      E  D
 ...        S SI=SI+1
 ...        S PC(PRSD,SI)=POCD(SEG)
 ...        I MT S T2N=$$SUBMEAL(T1N,T2N,.MT)
 ...        S $P(PC(PRSD,SI),U,2)=$$EXTIME(T2N)
 ...        S $P(PC(PRSD,SI),U,3)=0
 ...        S $P(PC(PRSD,SI),U,10)=T2N
 S SEGCNT=SI
 Q
 ;
SUBMEAL(TIME1,TIME2,MEAL) ;
 ;
 ;MEAL should be passed with a . so that any partial meal application can be returned
 ;for processing on next segment on 2 day tours
 N TIME2N,MIN,MINDIF,MEALN
 S MINDIF=$$MINDIF(TIME1,TIME2)
 S MEALN=$S(MINDIF<MEAL:MINDIF,1:MEAL)
 S MEAL=MEAL-MEALN
 S MIN=TIME2#100
 I MIN'<MEALN S TIME2N=TIME2-MEALN Q TIME2N
 S TIME2N=TIME2-100+(60-MEALN)
 Q TIME2N
 ;
MINDIF(TIME1,TIME2) ;
 ;FIND THE NUMBER OF MINUTES BETWEEN TWO TIMES
 N MIN1,MIN2,MINDIF
 S MIN1=(TIME1\100*60)+(TIME1#100)
 S MIN2=(TIME2\100*60)+(TIME2#100)
 S MINDIF=MIN2-MIN1
 Q MINDIF
 ;
EXTIME(TIME) ;
 ;TIME IS IN MILTARY TIME
 ;outputs HH:MMA/P
 N EXTIME
 I 'TIME!(TIME=1200)!(TIME=2400) S EXTIME=$S(TIME=1200:"NOON",1:"MID") G EXTQ
 S EXTIME=$S(TIME>1259:TIME-1200,1:TIME),EXTIME=$E("000",1,4-$L(EXTIME))_EXTIME
 S EXTIME=$E(EXTIME,1,2)_":"_$E(EXTIME,3,4)_$S(TIME=2400:"A",TIME>1159:"P",1:"A")
 ;
EXTQ ;
 ;
 Q EXTIME
 ;
RESULTS(CNT,PPI) ; Print results of the Release
 N DIVI,DIVE,I,F,X,STNUM,STNAME
 W @IOF,!!,?14,"POC RECORDS RELEASED RESULTS FOR PAY PERIOD ",$P($G(^PRST(458,PPI,0)),U)
 W !,?14,"==========================================="
 W !!,?30,"TOTAL",?42,"TOTAL"
 W !,?4,"DIVISION",?30,"NURSES",?42,"RECORDS"
 W !,?4,"========",?30,"======",?42,"======="
 N I S I=0
 F  S I=$O(CNT(I)) Q:I'>0  D
 .  D GETS^DIQ(4,I_",",".01;99","EI","F(",,)
 .  S STNUM=F(4,I_",",99,"E"),STNAME=F(4,I_",",.01,"E")
 .  W !,?4,STNAME," (",STNUM,")",?30,$P(CNT(I),U),?44,$P(CNT(I),U,2)
 W !!! S X=$$ASK^PRSLIB00(1)
 Q
 ;
PPRELCHK(PPS,PRSINST,PPI) ; BUILD ARRAY OF PAY PERIODS WITH APPROVED DATA
 ; BY DIVISION
 ;
 ;  INPUT:
 ;    PRSINST (required) array of institutions to check
 ;    PPI (optional) if passed only that pay period will be checked
 ;         otherwise all pps will be checked
 ;  OUTPUT:
 ;    PPS (returned by reference) two part array. Portion w/subscript
 ;         "P" contains pay periods w/approved recs. for any of the 
 ;         divisions in PRSINST.  Subscipt "D" is division specific 
 ;         w/total approved records for each pay period.
 ;
 N REC,CNT,FIELD,STOP
 I $G(PPI)>0 D
 .   S STOP=PPI
 E  D
 .   S STOP=99999999
 S REC=0
 F  S REC=$O(PRSINST(REC)) Q:REC'>0  D
 .  S CI=+PRSINST(REC)
 .  S PPI=+$G(PPI)
 .  F  S PPI=$O(^PRSN(451,"AA",CI,PPI)) Q:PPI'>0!(PPI>STOP)  D
 ..    S PPS("D",CI,PPI)=0
 ..    S PPS("P",PPI)=""
 ..    S PRSIEN=0
 ..    F  S PRSIEN=$O(^PRSN(451,"AA",CI,PPI,PRSIEN)) Q:PRSIEN'>0  D
 ...      S PPS("D",CI,PPI)=PPS("D",CI,PPI)+1
 Q
