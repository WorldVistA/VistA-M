IBDFU7 ;ALB/CJM - ENCOUNTER FORM - (utilities to handle form locks);3/29/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
LOCKFORM(FORM) ;locks the form - returns 0 if unsuccessful, 1 otherwise
 ;this lock is used to prevent multiple processes from simultaneously compiling a form
 L +^IBE(357,FORM,"LOCK1"):10
 Q $T
 ;
LOCKFRM2(FORM) ;locks the form - returns 0 if unsuccessful, 1 otherwise
 ;this lock is used to prevent multiple users from editing a form simultaneously
 L +^IBE(357,FORM,"LOCK2"):5
 Q $T
 ;
FREEFORM(FORM) ;unlocks the form
 L -^IBE(357,FORM,"LOCK1")
 Q
 ;
FREEFRM2(FORM) ;unlocks the form locked by LOCKFRM2()
 L -^IBE(357,FORM,"LOCK2")
 Q
 ;
 ;
LOCKMSG2(FORM) ;displays a message to the user for forms unavailable by LOCKFRM2()
 N FORMNAME
 S FORMNAME=$P($G(^IBE(357,FORM,0)),"^",1)
 W !!,"The form = '"_FORMNAME_"' is currently not available.",!,"It is being edited by another person.",!
 D PAUSE^IBDFU5
 Q
