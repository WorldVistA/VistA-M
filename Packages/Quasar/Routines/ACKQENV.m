ACKQENV ;HCIOFO/BH-QUASAR Version 3.0. Environment Check Routine  ;  11/01/99
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 N ACKTEST S ACKTEST=$$GET1^DIQ(509850.8,1,.1,"I")
 I ACKTEST="S"!(ACKTEST="D") D  Q
 . S ACKTXT(1)="Installation has been run previously."
 . S ACKTXT(2)="Therefore will not re-run Environment Check."
 . S ACKTXT(4)=" " D MES^XPDUTL(.ACKTXT) K ACKTXT
 ;
 ;
T N ACK1,ACKCNT,ACKMSG,ACKNME
 S ACK1=0,ACKCNT=0
 F  S ACK1=$O(^ACK(509850.3,ACK1)) Q:'+ACK1  D
 . I '$D(^USR(8930.3,"B",ACK1)) D
 . . S XPDABORT=2
 . . S ACKCNT=ACKCNT+1
 . . S ACKNME=$$GET1^DIQ(200,ACK1,.01)
 . . I ACKNME="" S ACKNME="A&SP Staff memeber with IEN "_ACK1_" no longer has entry on file #200."
 . . D MES^XPDUTL("  "_ACKCNT_".) "_ACKNME)
 I $G(XPDABORT)=2 D
 . D BMES^XPDUTL("ERROR - It is a requirment of Quasar Version 3.0 that all existing A&SP")
 . D MES^XPDUTL("staff members be entered on the USR CLASS MEMBERSHIP (#8930.3) file.")
 . I ACKCNT=1 S ACKMSG="The 1 A&SP staff member listed above has not been entered on this file."
 . I ACKCNT'=1 S ACKMSG="The "_ACKCNT_" A&SP staff members listed above have not been entered on this file."
 . D MES^XPDUTL(ACKMSG)
 . D BMES^XPDUTL("This install will now abort.  Only attempt to re-install when corrective action")
 . D MES^XPDUTL("has been taken.")
 Q
