PXUALOCK ;ISA/KWP - PCE LOCK/UNLOCK UTILITY;3/29/1999
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**67**;AUG 12, 1996
 ;+ LOCK(PXGLOBAL,PXWAIT,PXATT,PXMSG,PXBKG)
 ;+ Returns 1 success 0 failure
 ;+ PXGLOBAL -Global to be locked
 ;+ PXWAIT -seconds for wait, default of 0
 ;+ PXATT -Number of attempts to lock before failing
 ;+  0 would mean until canceled,default
 ;+ PXMSG -a message to be printed above the wait message
 ;+ PXBKG -0 foreground, default
 ;+  1 background, if background max 20 attempts
LOCK(PXGLOBAL,PXWAIT,PXATT,PXMSG,PXBKG) ;
 I '$G(PXWAIT) S PXWAIT=0
 I '$G(PXATT) S PXATT=0
 I '$G(PXBKG) S PXBKG=0
 N PXTMP,PXSPACE,PXEXIT,PXRESVAL S (PXEXIT,PXRESVAL)=0
 F PXTMP=1:1:$S(PXATT:PXATT,PXBKG&('PXATT):20,1:9999999) D  Q:PXEXIT
 .L +@PXGLOBAL:PXWAIT
 .I  S (PXRESVAL,PXEXIT)=1 Q
 .I 'PXBKG D 
 ..I 'PXBKG,PXTMP=1 W:$G(PXMSG)'="" !,PXMSG W !,"Waiting for file access, press ENTER to cancel..."
 ..R PXSPACE:0
 ..I  S PXEXIT=1 Q
 ..W "."
 Q PXRESVAL
 ;+ UNLOCK (PXGLOBAL,PXMSG)
 ;+ PXGLOBAL -Global to unlock
 ;+ PXMSG -message to be printed when unlocked, if any
UNLOCK(PXGLOBAL,PXMSG) ;
 L -@PXGLOBAL
 I $G(PXMSG)'="" W !,PXMSG
 Q
