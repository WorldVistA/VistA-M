PRSPSAP2 ;WOIFO/JAH - Supervisor Approve-update pt phys timecard ;7/26/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
TRANSACT ; TRANSfer ACTions to the database
 ;  loop thru temp and update the time card and the ESR day stats
 N ACT,PRSIEN,PPI,PRSD
 S PRSIEN=""
 F  S PRSIEN=$O(^TMP($J,"PRSPSAP",PRSIEN)) Q:PRSIEN'>0  D
 .  S PPI=0
 .  F  S PPI=$O(^TMP($J,"PRSPSAP",PRSIEN,PPI)) Q:PPI'>0  D
 ..     S PRSD=0
 ..     F  S PRSD=$O(^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD)) Q:PRSD'>0  D
 ...       S ACT=$G(^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD,1))
 ...;      Ignore ESR days that the superV skipped or bypassed.
 ...       Q:(ACT="")!(ACT="B")
 ...;
 ...;      set ESR day status to resubmit and add remarks
 ...       I ACT="R" D
 ....          S REM=$G(^TMP($J,"PRSPSAP",PRSIEN,PPI,PRSD,2))
 ....          D UPESR(PRSIEN,PPI,PRSD,ACT,REM)
 ...       E  D
 ....; try to update the timecard and the ESR
 ....          N CAN S (CAN("CB"),CAN("AE"))=0
 ....          D UPTCARD(.CAN,PRSIEN,PPI,PRSD)
 ....          I CAN("AE") D UPESR(PRSIEN,PPI,PRSD,ACT,"")
 ....          I CAN("CB") D PTP^PRSASR1(PRSIEN,PPI)
 Q
UPESR(PRSIEN,PPI,PRSD,ACT,REM) ; update ESR with either Resubmit OR Approve
 N PRSFDA,IENS
 ;
 ; update ESR status and display any filing errors
 ;
 S IENS=PRSD_","_PRSIEN_","_PPI_","
 S PRSFDA(458.02,IENS,146)=$S(ACT="A":"APPROVED",1:"RESUBMIT")
 I $G(REM)'="" S PRSFDA(458.02,IENS,148)=REM
 D FILE^DIE("E","PRSFDA")
 D MSG^DIALOG()
 Q
 ;
UPTCARD(CAN,PRSIEN,PPI,PRSD) ; UPDATE A TIME CARD 
 ;               WITH ESR LEAVE EXCEPTIONS AND HOLIDAY X
 ; Return CAN by reference.
 ;   CAN("AE") "CAN APPROVE ESR" is set to true if the ESR can be 
 ;             approved.  i.e. timecard status is T-timekeep or there's
 ;             no affect on the timecard
 ;   CAN("CB") "CAN CALL BANK" is set to true when a call should be 
 ;             made to the hours bank API (PTP^PRSASR1).
 ;             Calling routines must consider the order in which
 ;             to APPROVE ESR and CALL HOURS BANK since the API 
 ;             PTP^PRSASR, will only count hrs with an approved status.
 ;
 ;458.02 (DAY MULTIPLE)
 ; FIELD:   10  TOUR LAST POSTED BY^P200
 ;                identifies last person to post a tour for employee
 ;          101  POSTING STATUS^S^T:TIMEKEEPER POSTED;
 ;               P:PAYROLL REVIEWED;X:TRANSMITTED;
 ;          102  TIMEKEEPER POSTING^P200'^VA(200,
 ;          103  TK DATE/TIME ENTERED^DATE
 ;          104  POSTING TYPE^S^1:WORKED ENTIRE TOUR;
 ;               2:ABSENT ENTIRE TOUR;3:IRREGULAR TOUR;
 N TCN,ESRN,POST,PSTDT,POSTER,PTYPE
 N TCSTAT,DYSTAT,DUMB,POSTYPE,TOD,EARY,ERRORS
 S (CAN("CB"),CAN("AE"))=0
 ;get the raw posting from the ESR
 S ESRN=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,5))
 ; day signed on ESR with no work OR get the work segments
 I $P(ESRN,U)'="" S ESRN=$$GETAPTM(ESRN)
 ;get the timecard node
 S TCN=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,2))
 S POST=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,10))
 S PSTDT=$P(POST,U)
 S DYSTAT=$P(POST,U,2)
 S POSTER=$P(POST,U,3)
 S POSTYPE=$P(POST,U,4)
 ; if the timecard is still with timekeep it can be updated.
 S TCSTAT=$$TCSTAT(PPI,PRSIEN)
 I TCSTAT="T" D
 .   S CAN("AE")=1,CAN("CB")=0
 .   D EDTCARD(PPI,PRSIEN,PRSD,ESRN)
 E  D
 . ;if timecard is in a payroll or transmit we can check
 . ; for any affect to TimeCard from the ESR.  If none
 .;  we can update the ESR to approved and we should make a
 .; a call to the hours bank after ESR is set to apporved
 .; the hours bank and quit
 .; otherwise we have to either return timecard or do corrcted timecard
 .;  
 .;  If timecard has no postings and ESR has no exceptions
 .;  the ESR can be approved since no change to timecard is necessary
 .  I ESRN=""&(TCN="") S (CAN("AE"),CAN("CB"))=1 Q
 .;
 .; if ESR matches Timecard, update ESR no Timecard update necessary
 .  D CMPESRTC^PRSPSAP3(.ERRORS,.EARY,"","",PPI,PRSIEN,PRSD)
 .  I ERRORS=0 S (CAN("AE"),CAN("CB"))=1 Q
 .  I "^P^X^"["^"_TCSTAT_"^" S (CAN("AE"),CAN("CB"))=0 D  Q
 ..    D CANTPOST^PRSPSAP3(.EARY,TCSTAT,PPI,PRSIEN,PRSD,ESRN)
 ..    S DUMB=$$ASK^PRSLIB00(1)
 Q
EDTCARD(PPI,PRSIEN,PRSD,ESRN) ; edit the timecard
 ;
 N EDTSTR,CLEAR,POSTTIME,PRSFDA,IENS
 ;
 ; if there's no work, no leave or only RG then ptp gets credit for
 ; entire day, otherwise we have some exceptions.  If the physician
 ; used leave the entire day then don't post meal and set ptype=2
 ;
 S CLEAR=$$CLRTCDY^PRSPSAPU(PPI,PRSIEN,PRSD,5)
 S PTYPE=$S($P(ESRN,U)="":1,1:3)
 I PTYPE=3 D
 .  I $$ABSENT(ESRN,PPI,PRSIEN,PRSD) S PTYPE=2
 .  S TCN=$$ESR2TC(ESRN,PTYPE)
 .; update the timecard with a global set
 .  S ^PRST(458,PPI,"E",PRSIEN,"D",PRSD,2)=TCN
 ;
 ; update timecard status
 N %,X,%I,%H D NOW^%DTC S POSTTIME=%
 ;
 ; update timecard status and display any filing errors
 ;
 S IENS=PRSD_","_PRSIEN_","_PPI_","
 S PRSFDA(458.02,IENS,101)="T"
 S PRSFDA(458.02,IENS,102)=DUZ
 S PRSFDA(458.02,IENS,103)=POSTTIME
 S PRSFDA(458.02,IENS,104)=PTYPE
 D FILE^DIE("","PRSFDA")
 D MSG^DIALOG()
 Q
 ;
ESR2TC(ESRN,PT) ;CONVERT ESR DATA TO TIMECARD FORMAT
 ;
 N ESR2TC,TCS,I,TSEG,ST,EN,TT,RE,ML,TCN
 ;
 S TCN=""
 F I=1:5:31 D
 .  S TSEG=$P(ESRN,U,I,I+4)
 .    S ST=$P(TSEG,U)
 .    Q:ST=""
 .    S EN=$P(TSEG,U,2)
 .    S TT=$P(TSEG,U,3)
 .    S RE=$P(TSEG,U,4)
 .    S ML=$P(TSEG,U,5)
 .;   if meal posted remove it from leave end time
 .    I (PT=3)&(ML>0) S EN=$$ENDML(EN,ML)
 .    S:$G(TCN)'="" TCN=TCN_"^"
 .    S TCS=ST_U_EN_U_TT_U_RE
 .    S TCN=TCN_TCS
 ; REMOVE A TRAILING UPARROW GENERATED BY NULL REMARKS CODE
 I $E(TCN,$L(TCN))=U S TCN=$E(TCN,1,$L(TCN)-1)
 Q TCN
 ;
 ;
ABSENT(ESRN,PPI,PRSIEN,PRSD) ;return true if the ESR posting matches all
 ; the tour start and stop times and uses only one type of leave and
 ; the meal matches the tours meal.
 ; i.e. ESR posting equivalent to absent entire tour question.
 ;
 N TR1,TR2,TR1ML,TR2ML,TRMEAL,LASTTT,MULTITT,NODE0,RETURN,TCT
 N TCS,I,TSEG,ST,EN,TT,ML,TCTOUR,ESRTOUR
 ;
 S (ESRTOUR,LASTTT)="",(MULTITT,ML,RETURN)=0
 F I=1:5:31 D
 .  S TSEG=$P(ESRN,U,I,I+4)
 .    S ST=$P(TSEG,U)
 .    Q:ST=""
 .    S EN=$P(TSEG,U,2)
 .    S TT=$P(TSEG,U,3)
 .    I LASTTT="" D
 ..      S LASTTT=TT
 .    E  D
 ..      I LASTTT'=TT S MULTITT=1
 .    S ML=ML+$P(TSEG,U,5)
 .    S:$G(ESRTOUR)'="" ESRTOUR=ESRTOUR_"^"
 .    S TCS=ST_U_EN
 .    S ESRTOUR=ESRTOUR_TCS
 ; REMOVE A TRAILING UPARROW GENERATED BY NULL REMARKS CODE
 I $E(ESRTOUR,$L(ESRTOUR))=U S ESRTOUR=$E(ESRTOUR,1,$L(ESRTOUR)-1)
 ;
 ;
 S TCT=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,1))
 S NODE0=$G(^PRST(458,PPI,"E",PRSIEN,"D",PRSD,0))
 S (TR1ML,TR2ML)=0
 S TR1=$P(NODE0,U,2) I TR1>0 S TR1ML=$P($G(^PRST(457.1,TR1,0)),U,3)
 S TR2=$P(NODE0,U,15) I TR2>0 S TR2ML=$P($G(^PRST(457.1,TR2,0)),U,3)
 S TRMEAL=TR1ML+TR2ML
 S TCTOUR=""
 F I=1:3:31 D
 .  S TSEG=$P(TCT,U,I,I+4)
 .    S ST=$P(TSEG,U)
 .    Q:ST=""
 .    S EN=$P(TSEG,U,2)
 .    S:$G(TCTOUR)'="" TCTOUR=TCTOUR_"^"
 .    S TCS=ST_U_EN
 .    S TCTOUR=TCTOUR_TCS
 I (TCTOUR=ESRTOUR)&('MULTITT)&(TRMEAL=ML) S RETURN=1
 Q RETURN
 ;
ENDML(END,MEAL) ;GET AN END TIME AND DEDUCT THE MEAL FROM IT
 ;
 N X
 ; quit if we aint gots a good enought end time.
 Q:($G(END)'?2N.P.2N.A)&(END'="MID")&(END'="NOON") $G(END)
 S END=$$TWENTY4^PRSPESR2(END)
 S END=$E(END,1,2)_":"_$E(END,3,4)
 S END=$$MEALCUT(END,MEAL)
 ; Convert back to form stored in 458 start stop times
 S X=END D ^PRSATIM S END=X
 Q END
 ;
MEALCUT(HHMM,MEAL) ;Subtract meal time from the end time
 ; (subtract a 15 minute increment from length of time
 ; in hh:mm format, i.e. hh:mm - mm
 ;
 N X,Y,DECR,OBJ,I,HH,MM
 S MM=$P(HHMM,":",2) ; get minutes
 ; quit minutes or meal not quarter hours
 Q:(MM#15'=0&(+MM)!((MEAL#15)'=0&(+MEAL))) HHMM
 ; get hours
 S HH=$P(HHMM,":")
 ;
 ; convert segment minutes and meal to a digit.
 ;
 S X=MM D MEALIN^PRSPESR2 S OBJ=X
 S X=$G(MEAL) D MEALIN^PRSPESR2 S DECR=X
 I OBJ=0 S OBJ=4
 F I=1:1:DECR D
 .  I OBJ=4 D
 ..    I +HH=0 D
 ...     S HH=23
 ..    E  D
 ...     S HH="0"_(+HH-1) S HH=$E(HH,$L(HH)-1,$L(HH))
 . S OBJ=$S(OBJ=4:3,OBJ=3:2,OBJ=2:1,OBJ=1:4)
 S MM=$S(OBJ=1:15,OBJ=2:30,OBJ=3:45,1:"00")
 ;
 Q HH_MM
 ;
TCSTAT(PPI,PRSIEN) ; get timecard status
 Q:(PPI'>0)!(PRSIEN'>0) 0
 Q $P($G(^PRST(458,PPI,"E",PRSIEN,0)),U,2)
 ;
GETAPTM(WORK) ; return the work node with only the time that should
 ; be posted to a PTP's timecard
 ; INPUT: WORK : ESR work node
 ; RETURN ESRN : ESR node with only time applicable to PTP's 
 ; 
 N I,TSEG
 S TCN=""
 F I=1:5:31 D
 .  S TSEG=$P(WORK,U,I,I+4)
 .  S TT=$P(TSEG,U,3)
 .  Q:TSEG="^^^^"!("^HX^AL^AA^DL^ML^RL^SL^CB^AD^WP^TR^TV^"'[(U_TT_U))
 .  S TCN=TCN_TSEG_"^"
 Q TCN
 ;
 ;
