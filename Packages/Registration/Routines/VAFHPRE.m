VAFHPRE ;ALB/JRP,PKE - PRE INIT DRIVER;28-MAY-1996
 ;;5.3;Registration;**91**;AUG 13, 1993
 ;
CHKPTS ;Create check points for pre-init
 ;Input  : All variables set by KIDS
 ;Output : None
 ;
 ;Declare variables
 N TMP
 ;Create check points
 ;just set the ADT send HL7 messages switch off
 S TMP=$$NEWCP^XPDUTL("VAFH01","NOSEND^VAFHPRE")
 ;
 ; clean up old 391 cross-reference from previous versions
 S TMP=$$NEWCP^XPDUTL("VAFH02","XREF391^VAFHPRE")
 ;
 ; remove old DD(43,391.7011) so it can be replaced by 391.7012
 S TMP=$$NEWCP^XPDUTL("VAFH03","DD7011^VAFHPRE")
 QUIT
 ;
 ;
 ;
NOSEND ; Set the MAS Parameter Switch, SEND PIMS HL7 MESSAGE to STOP
 ;
 ;Input  : None
 ;Output : None
 ;Note   : This is a KIDS complient check point
 ;
 I '$$NOSEND^VAFHUTL Q
 D BMES^XPDUTL("Failed to set the MAS Parameter Switch 'SEND PIMS HL7 MESSAGES' to STOP")
 Q
 ;
XREF391 ; remove old 391 cross-reference from previous versions
 ; 991 will be used instead except for dd(2,.363,1,391)
 ;
 ;Input  : None
 ;Outout : None
 ;
 N VAFCX,NOOP
 F VAFCX=.01,.02,.03,.06,.09,.351 DO
 .I '$D(^DD(2,VAFCX,1,391,0)) Q
 .I VAFCX=.01 DO
 . . D BMES^XPDUTL("Removing old DD(2,,1,391) cross reference from Test Sites")
 .S NOOP=1
 .S DIK="^DD(2,VAFCX,1,"
 .S DA=391
 .S DA(1)=1
 .S DA(2)=VAFCX
 .S DA(3)=2
 .D ^DIK
 .K DIK,DA
 .;W "."
 I $G(NOOP) D BMES^XPDUTL("......")
 Q
 ;
DD7011 ; delete 43,391.7011 for replacement by 43,391.7012
 N VAFCX,NOOP
 I $D(^DD(43,391.7011)) DO
 .D BMES^XPDUTL("Removing field 391.7011 from file 43 at test sites")
 .S NOOP=1
 .S DIK="^DD(43,"
 .S DA=391.7011
 .S DA(1)=43
 .D ^DIK K DIK,DA
 .;W "."
 I $G(NOOP) D BMES^XPDUTL(".Field 391.7011 removed")
 Q
