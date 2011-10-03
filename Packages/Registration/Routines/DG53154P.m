DG53154P ;ALB/MM - POST INSTALLATION ROUTINE FOR DG*5.3*154;11/25/97
 ;;5.3;Registration;**154**;Aug 13 1993
 ;
EN ;
 ;Check for ^DD(45.52) Edit Clerk multiple
 I $D(^DD(45.52)) D  Q
 .K ^DD(45.52)
 .D BMES^XPDUTL(">>Edit Clerk multiple (#45.52) found.  Data dictionary nodes deleted.")
 .Q
 D BMES^XPDUTL(">>Edit Clerk multiple (#45.52) not found.  Nothing deleted.")
 Q
