ORWDVAL ; SLC/KCM - Validate procedures
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243**;Dec 17, 1997;Build 242
 ;
VALSCHED(ERR,SCHED) ; Validate a schedule
 ; Set up 'interval^repeat count', if no interval assume QD
 S ERR=0
 S INTERVAL=$P(SCHED," ",1),REPEAT=$P(SCHED," ",2)
 ;I '$O(^PS(51.1,"APLR",INTERVAL,0)) S ERR=1 Q
 K ^TMP($J,"ORLIST")
 D ZERO^PSS51P1(,INTERVAL,"LR",,"ORLIST")
 I '$D(^TMP($J,"ORLIST","B",INTERVAL)) K ^TMP($J,"ORLIST") S ERR=1 Q
 K ^TMP($J,"ORLIST")
 I '(X?1"X"1.N) S ERR=1 Q
 Q
STOPDT(ADATE,SCHED) ; Return stop date given a schedule
 ; Look at max days continuous orders
 ; set numdays to lesser of Xnn and LR MAX...
 ; calculate stop date from collection time
 Q
EXPSCHED(LST,SCHED,START,STOP,MAX) ; procedure
 ; Expand schedule into start/stop times
 N IEN,TYP,INTERVAL,REPEAT
 D VALSCHED I ERR S LST=""
 S INTERVAL=$P(SCHED," ",1),REPEAT=$E($P(SCHED," ",2),2,999)
 K ^TMP($J,"ORWDVAL") D AP^PSS51P1("LR",INTERVAL,,,"ORWDVAL")
 S IEN=$O(^TMP($J,"ORWDVAL","APLR",INTERVAL,0))
 S TYP=$P($G(^TMP($J,"ORWDVAL",IEN,5)),U)
 S FREQ=$G(^TMP($J,"ORWDVAL",IEN,2))
 I TYP="C" D  ; add interval until repeat count or stop time reached
 . ;
 I TYP="D" D  ; from start time look for matching day of week & add
 . ;
 I TYP="O" D  ; quit with just the start time
 . ;
 ; range, shift, dow-range ???
 K ^TMP($J,"ORWDVAL")
 Q
DATE ; Validate a date/time (allow visits)
 Q
