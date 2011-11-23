DVBCLURN ;ALB ISC/GTS - PRINT ROUTINE FOR MTLU LIST SEARCHES ;
 ;;2.7;AMIE;;Apr 10, 1995
 ;** ^TMP AND XTLKH ARE PASSED IN AND SHOULD NOT BE KILLED
 ;
 ;**  VARIABLE DESCRIPTIONS
 ;** XTLKH           - Entry number
 ;** ^TMP Global     - Sort array of entries found in file ^DIC(31,
 ;** DVBAREF         - Diagnostic code
 ;** DVBAREF0        - Zero node of current entry in ^DIC(31,
 ;** DVBAREF1        - One node of current entry in ^DIC(31,
 ;** DVBATEST        - Node in TMP array following one printed
 ;
WLINE ;** DISPLAY CODE AND TEXT FOR DIAGNOSIS
 S DVBAREF0="^DIC(31,"_Y_",0)"
 S DVBAREF1="^DIC(31,"_Y_",1)"
 I '$D(@(DVBAREF0))!('$D(@(DVBAREF1))) DO
 .W:XTLKH !,$J(XTLKH,4),": Bad 'ADVB' X-REF ("_Y_") on File 31...Notify IRM "
 Q:'$D(@(DVBAREF0))!('$D(@(DVBAREF1)))  ;** QUIT if a bad pointer exists
 S DVBAREF=$P(@(DVBAREF0),"^",3) ;** Indirection to 0 node, file 31
 W:((XTLKH>1)&(XTLKH#5=1)) !!
 W:XTLKH !,$J(XTLKH,4),": " ;** Write Entry number
 ;**
 ;** Write Detailed Desc. if exists, else write General Desc.
 ;** Use indirection to the 0 and 1 nodes, file 31 (DVBAREF0, DVBAREF1)
 ;**
 W $S($D(@(DVBAREF1)):@(DVBAREF1),1:$P(@(DVBAREF0),"^",1))
 W "  ("_DVBAREF_")"
 I XTLKH#5'>0 DO  ;** Output number remaining, if any
 .S DVBATEST=$O(^TMP("XTLKHITS",$J,XTLKH))
 .I +DVBATEST>0 DO
 ..W !!,"Selections "
 ..W XTLKH+1
 ..W " through "_^TMP("XTLKHITS",$J)_" follow."
 K DVBATEST,DVBAREF,DVBAREF0,DVBAREF1
 Q
 ;
ORPHAN ;the display for the orphan MTLU look up
 W:XTLKMULT !,$J(XTLKH,4),": "
 W $P(@(XTLKREF0),"^",1)
 Q
