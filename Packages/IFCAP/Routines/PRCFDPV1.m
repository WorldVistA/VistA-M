PRCFDPV1 ;WISC/LEM-PAYMENT ERROR PROCESSING CON'T ;6/13/94  11:00 AM
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT
 ; No top level entry
STATT ; Transmitted
 W !!,"This FMS document has been transmitted to FMS."
 W !,"No error processing can be performed at this time.",!!
 D PAUSE^PRCFDPVU
 S PRCFA("ERROR")=0
 Q
STATQ ; Queued for transmission
 W !!,"This FMS document has been queued for transmission to FMS."
 W !,"No error processing can be performed at this time.",!!
 D PAUSE^PRCFDPVU
 S PRCFA("ERROR")=0
 Q
STATM ; Marked for immediate transmission
 W !!,"This FMS document has been marked for immediate transmission to FMS."
 W !,"No error processing can be performed at this time.",!!
 D PAUSE^PRCFDPVU
 S PRCFA("ERROR")=0
 Q
STATE ; Error in transmission
 W !!,"This FMS document had an error during transmission."
 W !,"Use the option to 'Retransmit Stack File Document' on the FMS"
 W !,"Code Sheet Menu.",!
 D PAUSE^PRCFDPVU
 S PRCFA("ERROR")=0
 Q
STATA ; Accepted by FMS
 W !!,"This FMS document has been accepted by FMS."
 W !,"No error processing is necessary.",!!
 D PAUSE^PRCFDPVU
 S PRCFA("ERROR")=0
 Q
STATR ; Rejected by FMS
 W !!,"This FMS document has rejected due to one or more errors."
 S PRCFA("ERROR")=1
 Q
STATR1 S:$G(MOP)="" MOP=2
 S LABEL=$S(MOP=1:"Purchase Order",MOP=21:"1358 Miscellaneous Obligation",MOP=8:"Requistion",MOP=2:"Certified Invoice",0:"Obligation")
 W !,"The "_LABEL_" will now be displayed for your review.",!!
 W "Please review the source document very carefully and take",!,"the appropriate corrective action.",!
 D PAUSE^PRCFDPVU
 Q
