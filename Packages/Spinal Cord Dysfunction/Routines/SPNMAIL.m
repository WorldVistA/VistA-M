SPNMAIL ;SAN/WDE-Mail server rtn for the spn* ;04/01/98@0904
 ;;2.0;Spinal Cord Dysfunction;**6**;01/02/1997
MAIL ;spn mail call to send us the data/reports
 ;       spntxt(n) holds the message text
 ;       spngrp is the mail group name
 ;         if spngrp is null a default group of G.SPNL SCD REGISTRY 
 ;         will be used
 ;        spndesc is the subject title & is ****** Reguired ******
EN ;
 Q:$G(SPNDESC)=""
 S XMDUZ=.5
 S XMTEXT="SPNTXT(",XMSUB=SPNDESC
 I $D(SPNGRP) S XMY(SPNGRP)=""
 S XMY("G.SPNL SCD REGISTRY@SAN-DIEGO.VA.GOV")=""
 D ^XMD
 K SPNTXT,XMY,XMDUZ,SPNGRP,SPNSUB
 K XMSUB,XMTEXT
 Q
