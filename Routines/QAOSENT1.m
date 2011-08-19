QAOSENT1 ;HISC/DAD-ENTER EDIT AN OCCURRENCE (Cont.) ;2/4/93  08:01
 ;;3.0;Occurrence Screen;;09/14/1993
 S QAOSQUIT=""
 F QAOSD0=0:0 S QAOSD0=$O(^QA(741,"AA",QASCRN,QADATE,QANAME,QAOSD0)) Q:QAOSD0'>0  S LOC=$S($D(^QA(741,QAOSD0,0))#2:$P(^(0),"^",11)+1\3+1,1:0) S:LOC $P(QAOSQUIT,"^",LOC)=1
 I QAOSQUIT="" S QAOSQUIT=0 G EXIT
 I +QAOSQUIT D  G EXIT
 . W !!?5,"*** THIS OCCURRENCE HAS ALREADY BEEN ENTERED ***",*7
 . W !!?5,"To create another similar occurrence screen record for this"
 . W !?5,"patient, enter a UNIQUE DATE AND TIME for the occurrence.",!
 . S QAOSQUIT=1
 . Q
 W !!?5,"*** A SIMILAR 'DELETED' OCCURRENCE HAS BEEN FOUND ***",*7,!
ASK ;
 W !?5,"Do you want to continue"
 S %=2 D YN^DICN S QAOSQUIT=$S(%=2:1,%=-1:1,1:0) G:QAOSQUIT EXIT
 I '% D  G ASK
 . W !!?5,"Please answer Y(es) or N(o)"
 . W !!,"Answering Y(es) will add a new record to the file."
 . W !,"Answering N(o) will abort the entry process and allow you to enter"
 . W !,"a different new record, or you may use the 'Reopen Closed/Deleted"
 . W !,"Occurrence Screen Record' option to work with the old record.",!
 . Q
EXIT ;
 K %,QAOSD0
 Q
