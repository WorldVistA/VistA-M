PRCFFER1 ;WISC/SJG-OBLIGATION ERROR PROCESSING CON'T ;7/24/00  23:17
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT
MSG(STATUS,PRCFA) ;
 S PRCFA("ERROR")=$S(STATUS="R":1,1:0)
 I STATUS="" D STAT0,PAUSE Q
 I STATUS="A" D STATA,PAUSE Q
 I STATUS="E" D STATE,PAUSE Q
 I STATUS="F" D STATF,PAUSE Q
 I STATUS="M" D STATM,PAUSE Q
 I STATUS="Q" D STATQ,PAUSE Q
 I STATUS="R" D STATR Q
 I STATUS="T" D STATT,PAUSE Q
 D EN^DDIOL("The status "_STATUS_"is not valid")
 D EN^DDIOL("No error processing can be performed")
 ;
PAUSE ; return to continue
 W ! D EN^DDIOL("Press 'RETURN' to continue")
 R X:DTIME
 I $D(IOF) W @IOF
 Q
 ;
STAT0 ; No Status on Stack File Entry
 W !!,"This FMS document does not have a status!!."
 W !,"No error processing can be performed at this time.",!!
 Q
STATT ; Transmitted
 W !!,"This FMS document has been transmitted to FMS."
 W !,"No error processing can be performed at this time.",!!
 Q
STATQ ; Queued for transmission
 W !!,"This FMS document has been queued for transmission to FMS."
 W !,"No error processing can be performed at this time.",!
 Q
STATM ; Marked for immediate transmission
 W !!,"This FMS document has been marked for immediate transmission to FMS."
 W !,"No error processing can be performed at this time.",!!
 Q
STATE ; Error in transmission
 W !!,"This FMS document has an error in transmission."
 W !,"Use the option to 'Retransmit Stack File Document' on the FMS"
 W !,"Code Sheet Menu.",!
 Q
STATA ; Accepted by FMS
 W !!,"This FMS document has been accepted by FMS."
 W !,"No error processing is necessary.",!!
 Q 
STATF ; Final
 W !!
 D EN^DDIOL("This document duplicates information already accepted by FMS.")
 D EN^DDIOL("No error processing is necessary.")
 W !!
 Q
STATR ; Rejected by FMS
 W !!,"This FMS document has rejected due to one or more errors."
 Q
