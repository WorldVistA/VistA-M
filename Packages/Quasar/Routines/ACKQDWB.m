ACKQDWB ;AUG/JLTP BIR/PTD HCIOFO/BH-Compile A&SP Capitation Data - CONTINUED ; [ 12/05/95 10:33 ]
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
BUILD ;  Capitation report has been generated.
 N XMDUZ,XMDUN,XMSUB,XMTEXT,XMY,TXT,X
 S (XMDUZ,XMDUN)="QUASAR",XMTEXT="TXT(",XMSUB="A&SP CAPITATION DATA GENERATED"
 S TXT(1,0)="A&SP capitation data have been generated for "_ACKMO_"."
 S TXT(2,0)="   "
 D DIV1     ;  Display Divisions
 S TXT(I,0)=""
 S I=I+1,TXT(I,0)="     Start Date/Time : "_ACKXSDTE_" at "_ACKXST
 S I=I+1,TXT(I,0)="     Finish Date/Time: "_ACKXEDTE_" at "_ACKXFT
 S I=I+1,TXT(I,0)=""
 S I=I+1,TXT(I,0)="You can use the Print A&SP Capitation Report option to check the"
 S I=I+1,TXT(I,0)="data for accuracy.",I=I+1,TXT(I,0)=""
 D STAFF,^XMD
 Q
 ;
ABORT(ACKST) ;  Abort bulletin.  ACKST = reason for abort.
 N XMDUZ,XMDUN,XMSUB,XMTEXT,XMY,TXT,X,ACKK1
 S ACKK1=""
 S (XMDUZ,XMDUN)="QUASAR",XMTEXT="TXT(",XMSUB="A&SP CAPITATION REPORT ABORTED!"
 ;
 S TXT(1,0)="                            **** WARNING ****"
 S TXT(2,0)="     The monthly A&SP Capitation generation has terminated abnormally."
 ;
 D DIV     ;  Display Divisions with errors
 ;
 S TXT(I,0)="Reason: "_$P(ACKST,U,3),TXT(I+1,0)="        "
 S TXT(I+1,0)="     Please inform your IRM Service.  Your Capitation Report"
 S TXT(I+1,0)="for the month can not be printed until this problem is resolved."
 S TXT(I+1,0)="   "
 D STAFF,^XMD
 Q
 ;
STAFF ;Create XMY( array using active supervisors from the A&SP STAFF file (#509850.3).
 N ST S ST=0
 F  S ST=$O(^ACK(509850.3,ST)) Q:'ST  I $P(^ACK(509850.3,ST,0),U,6),'$P(^(0),U,4) S XMY($$CONVERT1^ACKQUTL4(ST))=""
 I $G(ACKMAN) S XMY(ACKDUZ)=""
 I '$O(XMY(0)) S XMY(.5)=""
 Q
 ;
DIV ;  Loops through the Entered Divisions and displays the ones appropriate
 S I=3
 S ACKK1=""
 F  S ACKK1=$O(ACKDIV(ACKK1)) Q:ACKK1=""  D 
 . S DIVIEN=$P(ACKDIV(ACKK1),U,1)
 . I '$D(^ACK(509850.7,ACKDA,5,DIVIEN)) Q
 . I '$P(^ACK(509850.7,ACKDA,5,DIVIEN,0),U,2),'$P(^ACK(509850.7,ACKDA,5,DIVIEN,0),U,3),'$P(^ACK(509850.7,ACKDA,5,DIVIEN,0),U,4) Q
 . I $E(ACKST)=2,$P(^ACK(509850.7,ACKDA,5,DIVIEN,0),U,4) D  Q
 . . D DIVLN S I=I+1
 . I $E(ACKST)=1,'$P(^ACK(509850.7,ACKDA,5,DIVIEN,0),U,4) D  Q
 . . D DIVLN S I=I+1
 Q
 ;
DIV1 ;  Loops through all divisions and displays them 
 S ACKK1="",I=3
 F  S ACKK1=$O(ACKDIV(ACKK1)) Q:ACKK1=""  D DIVLN S I=I+1
 Q
 ;
DIVLN I I=3 S TXT(3,0)="     For the following "_$S($O(ACKDIV(ACKK1))'="":"Divisions",1:"Division")_" : "_$P(ACKDIV(ACKK1),U,3) Q
 S TXT(I,0)="                                  "_$P(ACKDIV(ACKK1),U,3)
 Q
 ;
