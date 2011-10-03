KMPDENV ;OAK/RAK - CM Tools Environmnet Check ;4/21/04
 ;;2.0;CAPACITY MANAGEMENT TOOLS;**1**;Mar 22, 2002
 ;
EN ;-entry point
 ; if version 2.0
 I $P($$VERSION^KMPDUTL,U)="2.0" D  Q
 .D MES^XPDUTL("     Version 2.0 detected. Environment check successful!")
 ; if not version 2.0
 S XPDQUIT=1
 D MES^XPDUTL("     Must have Version 2.0 installed.  Install can not continue!")
 Q
