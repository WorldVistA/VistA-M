XU8P540 ;SFISC/GB- POST INSTALL ;24 DEC 2009
 ;;8.0;KERNEL;**540**;Jul 10, 1995;Build 4
PRE ; Pre-Init
 D GROUP
 Q
 ;
GROUP ; Check to see if mail group has correct remote address. If not, correct it.
 N XUGIEN,XUOIEN,XUNIEN
 D BMES^XPDUTL("Checking Mail Group 'XUOAA CLIN TRAINEE'...")
 S XUGIEN=$$FIND1^DIC(3.8,"","X","XUOAA CLIN TRAINEE") ; eXact match only
 I 'XUGIEN D  Q
 . D BMES^XPDUTL("ERROR: Cannot find mail group 'XUOAA CLIN TRAINEE'")
 . S XPDABORT=1
 S XUOIEN=$$FIND1^DIC(3.812,","_XUGIEN_",","X","AIMCDATA@LRN.VA.GOV")
 I $D(DIERR) D  Q
 . D BMES^XPDUTL("ERROR: Lookup of old remote address failed.")
 . S XPDABORT=1
 I XUOIEN D  ; Delete the old remote address from the group.
 . N DIR,X,Y,DA,DIK
 . S DA(1)=XUGIEN,DA=XUOIEN,DIK="^XMB(3.8,"_XUGIEN_",6,"
 . D ^DIK
 . D MES^XPDUTL("I've deleted the old remote address from the group.")
 E  D
 . D MES^XPDUTL("The old remote address was already deleted. No action taken.")
 S XUNIEN=$$FIND1^DIC(3.812,","_XUGIEN_",","X","AIMCDATA@VA.GOV")
 I $D(DIERR) D  Q
 . D BMES^XPDUTL("ERROR: Lookup of new remote address failed.")
 . S XPDABORT=1
 I XUNIEN D
 . D MES^XPDUTL("The new remote address 'AIMCDATA@VA.GOV' was already added. No action taken.")
 E  D  ; Add the new remote address to the group.
 . N XUFDA
 . S XUFDA(3.812,"?+1,"_XUGIEN_",",.01)="AIMCDATA@VA.GOV"
 . D UPDATE^DIE("","XUFDA")
 . I $D(DIERR) D  Q
 . . D BMES^XPDUTL("ERROR: Cannot add the new remote address to the group.")
 . . S XPDABORT=1
 . D MES^XPDUTL("I've added the new remote address 'AIMCDATA@VA.GOV' to the group.")
 D MES^XPDUTL("Finished Mail Group Check.")
 Q
 ;
POST ; Post-Init
 I '$$PROD^XUPROD D BMES^XPDUTL("Not a production UCI. Quitting without reindexing/transmitting.") Q
 D REINDEX
 D XMIT
 Q
 ;
REINDEX ; Re-index the ATR xref
 ; We do this to ensure that data for ALL clinical trainees are transmitted.
 D BMES^XPDUTL("Reindexing ""ATR"" cross-reference in the NEW PERSON [#200] file...")
 N DIK
 S DIK="^VA(200,"
 S DIK(1)="12.2^ATR"
 D ENALL^DIK
 D MES^XPDUTL("Finished reindexing.")
 Q
 ;
XMIT ; Transmit Data to OAA database
 D MES^XPDUTL("Initiating transmission of OAA Clinical Trainee data...")
 D OAA^XUOAAHL7
 D MES^XPDUTL("Finished with transmission.")
 Q
