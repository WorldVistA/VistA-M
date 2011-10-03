ACKQWB ;AUG/JLTP BIR/PTD-Compile A&SP Capitation Data - CONTINUED ; [ 12/05/95 10:33 ]
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
BUILD ;Capitation report has been generated.
 N XMDUZ,XMDUN,XMSUB,XMTEXT,XMY,TXT,X
 S (XMDUZ,XMDUN)="QUASAR",XMTEXT="TXT(",XMSUB="A&SP CAPITATION DATA GENERATED"
 F I=1:1 S X=$P($T(BUILD1+I),";;",2) Q:X=""  D PROC S TXT(I,0)=X
 D STAFF,^XMD
 Q
BUILD1 ;;
 ;;A&SP capitation data have been generated for |ACKMO|.
 ;; 
 ;;   Start Time: |ACKXST|                  Finish Time: |ACKXFT|
 ;; 
 ;;You can use the Print A&SP Capitation Report option to check the
 ;;data for accuracy.
 ;;
ABORT(ACKST) ;Abort bulletin.  ACKST = reason for abort.
 N XMDUZ,XMDUN,XMSUB,XMTEXT,XMY,TXT,X
 S ACKST=$P(ACKST,U,3)
 S (XMDUZ,XMDUN)="QUASAR",XMTEXT="TXT(",XMSUB="A&SP CAPITATION REPORT ABORTED!"
 F I=1:1 S X=$P($T(ABORT1+I),";;",2) Q:X=""  D PROC S TXT(I,0)=X
 D STAFF,^XMD
 Q
ABORT1 ;Text for abort bulletin.
 ;;                            **** WARNING ****
 ;;     The monthly A&SP Capitation generation has terminated abnormally.
 ;;Reason: |ACKST|
 ;; 
 ;;     Please inform your IRM Service.  Your Capitation Report
 ;;for the month can not be printed until this problem is resolved.
 ;;
PROC ;Process a line Of text with windows.
 F  Q:X'["|"  S X=$P(X,"|")_$$RESOLVE($P(X,"|",2))_$P(X,"|",3,245)
 Q
RESOLVE(X) ;Find the value of the variable represented by X.
 S @("X=$G("_X_")") Q X
 ;
STAFF ;Create XMY( array using active supervisors from the A&SP STAFF file (#509850.3).
 N ST S ST=0
 F  S ST=$O(^ACK(509850.3,ST)) Q:'ST  I $P(^ACK(509850.3,ST,0),U,6),'$P(^(0),U,4) S XMY(ST)=""
 I ACKMAN S XMY(ACKDUZ)=""
 I '$O(XMY(0)) S XMY(.5)=""
 Q
