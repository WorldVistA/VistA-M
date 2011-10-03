XIPPOST ;ALB/BRM/OIFO/SO - STANDARD POST INSTALL FOR XIP;12:26 PM  20 Oct 2005
 ;;8.0;KERNEL;**292,378**;Jul 10, 1995;Build 59
 ;
POST ; post install - correct state file pointers for 5.12 and 5.13
 K ^DD(5.12,0,"ID",8) ; IA #4140
 D
 . N DIK
 . S DIK="^DIC(5,"
 . S DIK(0)="1^ADUALC"
 . D ENALL^DIK
 . Q
 D RP512
 D RP513
 D ADDID
 Q
 ;
RP512 ;Repoint Field #3 to proper STATE(#5) file entry
 N IEN512,XIPSEED
 S XIPSEED=1 ; Prevent "AD" xref from firing
 D BMES^XPDUTL("   Updating State File pointers in file #5.12")
 S IEN512=0
 F  S IEN512=$O(^XIP(5.12,IEN512)) Q:'IEN512  D
 . N IEN5,IEN513,VACODE
 . S IEN513=$P($G(^XIP(5.12,IEN512,0)),"^",3) ;Get pointer to 5.13
 . D
 .. N DIERR,XIPERR
 .. S VACODE=$$GET1^DIQ(5.13,IEN513_",",.01,"","","XIPERR")
 .. S VACODE=$E(VACODE,1,2)
 . S IEN5=0,IEN5=+$O(^DIC(5,"C",VACODE,IEN5))
 . I IEN5 D  Q
 .. N DIERR,XIPERR,FDA
 .. S FDA("XIP",5.12,IEN512_",",3)=IEN5
 .. D FILE^DIE("","FDA(""XIP"")","XIPERR")
 .. I $D(XIPERR) D
 ... N X
 ... S X="File: 5.12 IEN: "_IEN512_" "_XIPERR("DIERR",1,"TEXT",1)
 ... D BMES^XPDUTL(X)
 . I 'IEN5 D  Q
 .. N X
 .. S X="File: 5.12 IEN: "_IEN512_" VA STATE CODE: "_VACODE_" is invalid."
 .. D BMES^XPDUTL(X)
 D BMES^XPDUTL("  Finished repointing file #5.12")
 Q
 ;
RP513 ;Repoint Field #2 to proper STATE(#5) file entry
 N IEN513,XIPSEED,VACODE
 S XIPSEED=1 ; Prevent "AC" xref from firing
 S IEN513=0
 D BMES^XPDUTL("   Updating State File pointers in file #5.13")
 F  S IEN513=$O(^XIP(5.13,IEN513)) Q:'IEN513  D
 . N IEN5
 . S VACODE=$P(^XIP(5.13,IEN513,0),"^")
 . S VACODE=$E(VACODE,1,2)
 . S IEN5=0,IEN5=+$O(^DIC(5,"C",VACODE,0))
 . I 'IEN5 D  Q
 .. S X="File: 5.13 IEN: "_IEN513_" VA STATE CODE: "_VACODE_" is invalid."
 .. D BMES^XPDUTL(X)
 . D
 .. N DIERR,XIPERR,FDA
 .. S FDA("XIP",5.13,IEN513_",",2)=IEN5
 .. D FILE^DIE("","FDA(""XIP"")","XIPERR")
 .. I $D(XIPERR) D
 ... S X="File: 5.13 IEN: "_IEN513_" "_XIPERR("DIERR",1,"TEXT",1)
 ... D BMES^XPDUTL(X)
 D BMES^XPDUTL(" Finished repointing file #5.13")
 Q
 ;
ADDID ; Add Write ID node & Up date $P#2 of File Header
 S ^DD(5.12,0,"ID","W1")="D EN^DDIOL($P(^(0),U,2)_""  ""_$P(^(0),U,6)_""  ""_$P(^(0),U,7),"""",""?0"")"
 S $P(^XIP(5.12,0),"^",2)="5.12I"
 Q
