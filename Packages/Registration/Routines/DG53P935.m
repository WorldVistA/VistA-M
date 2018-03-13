DG53P935 ;ALB/KUM - DG*5.3*935 POST INSTALL ;8/30/17 9:18am
 ;;5.3;Registration;**935**;Aug 13, 1993;Build 53
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; DG*5.3*935 Post Install routine to correct Veteran Plan - Veterans Choice Wait Time
 ;  Integration Agreements:
 ;        10141 : BMES^XPDUTL
 ;              : MES^XPDUTL
 ;        2053  : FILE^DIE
 ;        2051  : FIND1^DIC
 ;
 Q
 ;
POST ;Update Health Benefit Plan
 ;
 D BMES^XPDUTL("    Checking Entry in HEALTH BENEFIT PLAN File - Veteran Plan - Veterans Choice Wait Time   ")
 D UPDREQ
 Q
 ;
UPDREQ ; Update entry in the HEALTH BENEFIT PLAN File (25.11)
 ;
 N IEN,ERR,NAME,FDA,IEN1,NAME1
 S ERR=""
 S NAME="Veteran Plan - Veterans Choice Wait Time"
 ; Check if entry exists, use it if it does
 S IEN=$$FIND1^DIC(25.11,,"B",NAME)
 I 'IEN D BMES^XPDUTL("    "_NAME_" does not exist, no action is taken.  ") Q
 L +^DGHBP(25.11,IEN):10 I '$T D BMES^XPDUTL("    "_NAME_" is locked by another user. Try later.   ") Q
 S IEN1=IEN
 S IEN=IEN_","
 ;
 S FDA(25.11,IEN,.01)="Veteran Plan - Veterans Choice Wait-Time"
  ; file new Address Change Date/Time
 ;
 D FILE^DIE("E","FDA","ERR")
 L -^DGHBP(25.11,IEN1)
 I ERR'="" D
 . D BMES^XPDUTL("     *** An Error occurred during updating Plan: Veteran Plan - Veterans Choice Wait Time")
 . D MES^XPDUTL("     Please log CA SDM ticket.")
 . Q
 ;
 I ERR="" D
 . S NAME1=$P(^DGHBP(25.11,IEN1,0),"^",1)
 . D BMES^XPDUTL("    "_NAME_" is corrected in HEALTH BENEFIT PLAN File to "_NAME1_".")
 Q
 ;
