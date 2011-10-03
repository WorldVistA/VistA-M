XUMFPOST ;ISS/RAM - post-install routine ;04/15/02
 ;;8.0;KERNEL;**299**;Jul 10, 1995
 ;
 ; make sure subscriber protocols are associated with event protocols
 ;
 Q
 ;
MAIN ; -- main
 ;
 N FDA,IEN,IENS
 ;
 ; mfn
 K FDA
 ;S IEN=$$FIND1^DIC(101,,"B","DS Pub Man~~L")
 S IEN=$$FIND1^DIC(101,,"B","XUMFX SERVER")
 S IENS=IEN_","
 S FDA(101.0775,"?+1,"_IENS,.01)="XUMF MFS"
 D UPDATE^DIE("E","FDA","IENS")
 ;
 ; mfp
 K FDA
 S IEN=$$FIND1^DIC(101,,"B","XUMF MFP MFQ")
 S IENS=IEN_","
 S FDA(101.0775,"?+1,"_IENS,.01)="XUMF MFP MFR"
 D UPDATE^DIE("E","FDA","IENS")
 ;
 ; mfq
 K FDA
 S IEN=$$FIND1^DIC(101,,"B","XUMFX MFQ")
 S IENS=IEN_","
 S FDA(101.0775,"?+1,"_IENS,.01)="XUMFX MFR"
 D UPDATE^DIE("E","FDA","IENS")
 ;
 Q
 ;
