ACKQIPS1 ;HCIOFO/BH-Version 3 Post Installation routine ;  04/01/99
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
STAFF I ^TMP("ACKQIPST","SKIP") G EXIT   ;  Virgin Site
 D BMES^XPDUTL("Updating A&SP Staff file to no longer point to New Person file.")
 ;
 N ACK1,ACK2,ACK
 S ACK1=0,ACKCNT=0
 F  S ACK1=$O(^ACK(509850.3,ACK1)) Q:'+ACK1  D
 . S ACK2=""
 . S ACK2=$O(^USR(8930.3,"B",ACK1,ACK2))
 . K ACK S ACK(509850.3,ACK1_",",.01)=ACK2 D FILE^DIE("","ACK")
 ;
 ;  Creates new 'D' Cross Reference on Staff File.
 K ^ACK(509850.3,"D")
 S DIK="^ACK(509850.3,"
 S DIK(1)=".01^D"
 D ENALL^DIK
 D BMES^XPDUTL("Completed updating A&SP Staff file.")
 ;
EXIT ;
 K ^TMP("ACKQIPST","SKIP")
 ;
 Q
