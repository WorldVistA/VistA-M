ACKQUTL9 ;AUG/JLTP BIR/PTD HCIOFO/BH-New Clinic Visits - CONTINUED ; [ 04/12/96   10:38 AM ]
 ;;3.0;QUASAR;**1,4**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
BUILD() ;  Generate a message informing Supervisors that time period for
 ;  for changing Procedure code type has begun
 ;
 N XMDUZ,XMDUN,XMSUB,XMTEXT,XMY,TXT,X
 S (XMDUZ,XMDUN)="QUASAR",XMTEXT="TXT(",XMSUB="A&SP Procedure Code Amendment Notice"
 S TXT(1,0)="   "
 S TXT(2,0)="          This notice is to inform all Quasar Supervisors that the "
 S TXT(3,0)="          oppotunity of change the type of Procedures your Site uses"
 S TXT(4,0)="          is now available.  This option will only be available until"
 S TXT(5,0)="          the 30th of September.   If you wish to change the type of"
 S TXT(6,0)="          Procedure codes your Site uses select Quasars Site Parameters "
 S TXT(7,0)="          option and amend the USE EVENT CAPTURE CODES field."
 S TXT(8,0)="  "
 D STAFF,^XMD
 ;
 N ACKY
 S ZTDESC="QUASAR - Mail Procedure code Warning"
 D NOW^%DTC
 S ACKY=$E(X,1,3)
 S ACKY=ACKY+1
 S ZTDTH=ACKY_"0917.0100"
 S ZTIO=""
 S ZTRTN="BUILD^ACKQUTL9()"
 D ^%ZTLOAD
 Q
 ;
CHANGE(ACKQQCH,ACKDA1) ;  Passes in new changed value of USE EVENT CAPTURE CODE
 ;                  field ACKQQCH will either equal '1' or zero
 ;
 N %X,DC,D2,DE,DH,DG,DI,DICREC,DIDATA,DIEDA,DIEFDAS,DIEFCNOD,DIEFAR
 ; N DIENCNT,DIEFF,DIEFFLAG,DIEFFLD,DIEFFLST,DIEFFREF,DIEFFVAL,DIEFI
 N DIEFIEN,DIFM,DIIENS,DI0V,DIP,DIEL,DITMP,DIFLD,DIEFNVAL,DIEFNODE
 ; N DIEFLEV,DIETMP,DIEXREF,DIEFSPOT,DIEFTREF,DIEFSORK,DIEFRLST,DIEFRFLD
 ; N DIEFOVAL
 N DA,D,D0,D1,DIE,DIC,DR,DU,XMDUZ,XMDUN,XMSUB,XMTEXT,XMY,TXT,X,Z,Y
 ; N DK,DQ,DP,DQI,XQZ,X1,J,M,S,POP,DV,DW,XQXFLG,XQW,XQV,XQUSER,XQSV,XQT
 ; N XQJMP,XQCH,DOREPL,DN,DM,DLAYGO,DL,DIQUIET,DIWT,DIW,DIENS
 N ACKDIVN S ACKDIVN=$$GET1^DIQ(40.8,ACKDA1,.01)
 S (XMDUZ,XMDUN)="QUASAR",XMTEXT="TXT(",XMSUB="A&SP Procedure Code Change Notice."
 S TXT(1,0)="   "
 S TXT(2,0)="          The USE EVENT CAPTURE CODE field has been amened within "
 S TXT(3,0)="          Quasars Site Parameters function."
 S TXT(4,0)="          Division "_ACKDIVN_" is now set up to use "_$S(ACKQQCH=1:"Event Capture",1:"CPT")_" codes."
 S TXT(5,0)="          This change will take effect on the 1st of October."
 S TXT(6,0)="          "
 D STAFF,^XMD
 K ACKDA1
 Q
 ;
STAFF ;  Create XMY(...  array using active supervisors from A&SP STAFF file
 N ACKQQCNV,X,Y,ACKST,ACKIND,ACKDTE S ACKST=0
 D NOW^%DTC   ;   X=TODAYS DATE
 S ACKDTE=X
 F  S ACKST=$O(^ACK(509850.3,ACKST)) Q:'ACKST  D
 . I $P(^ACK(509850.3,ACKST,0),U,6)'=1 Q    ;  Not a Supervisor
 . S ACKIND=$P(^ACK(509850.3,ACKST,0),U,4)
 . I ACKIND'="",ACKIND<ACKDTE Q             ;  Inactivated
 . S ACKQQCNV=$$CONVERT2^ACKQUTL4(ACKST) I ACKQQCNV="" Q
 . S XMY(ACKQQCNV)=""
 S XMY(DUZ)=""
 I '$O(XMY(0)) S XMY(.5)=""
 Q
 ;
CHECK() ;  Check to see if 2 week time time window to edit USE EC CODE
 ;  is now
 ;
 D NOW^%DTC
 N ACKM,ACKD
 S ACKM=$E(X,4,5)
 S ACKD=$E(X,6,7)
 I ACKM'="09" Q 0
 I ACKD>16 Q 1
 Q 0
