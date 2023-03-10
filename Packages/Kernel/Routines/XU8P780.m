XU8P780 ;ISF/CLG - Post-Install for 780 ;10/25/22  12:20
 ;;8.0;KERNEL;**780**;Jul 10, 1995;Build 1
 ;Per VA Directive 6402, this routine should not be modified.
 ;  Post Installation Routine for patch XU*8.0*780
 ;
 ;  Installs entries into the REMOTE APPLICATION file (#8994.5)
 ;
 ;
 ;  EXTERNAL REFERENCES
 ;  $$FIND1^DIC       (ICR# 2051)
 ;  UPDATE^DIE        (ICR# 2053)
 ;  ^DIK              (ICR# 10013)
 ;  CLEAN^DILF        (ICR# 2054)
 ;  BMES^XPDUTL       (ICR# 10141)
 ;  $$SHAHASH^XUSHSH  (ICR# 6189)
 ;
MAIN ; Control subroutine
 N XU8ERRX,XU8DATA
 ;
 ; Install NUMI VDIF entry into the REMOTE APPLICATION file (#8994.5)
 S XU8DATA(1)="NUMI VDIF" ; Name
 S XU8DATA(2)="WEBN NATL UTIL MGMT INTEG" ; ContextOption Name
 S XU8DATA(3)="National Utilization Mgmt Integration" ; ContextOption Menu Text
 S XU8DATA(4)="webn natl util mgmt integ" ; Security phrase
 ; For TYPE multiple, each entry should be XU8DATA(n)=CallBackType^CallBackPort^CallBackServer^URLString
 ; where n is 5, 6, 7, 8 etc.
 S XU8DATA(5)="S"_"^"_"-1"_"^"_"N/A"_"^"_"N/A"
 ;S XU8DATA(5)="S^-1^N/A^N/A"
 S XU8ERRX=$$OPTION(.XU8DATA) ; Create CONTEXTOPTION if doesn't exist
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 S XU8ERRX=$$DELETE(.XU8DATA) ; Delete existing REMOTE APPLICATION entry
 S XU8ERRX=$$CREATE(.XU8DATA) ; Create REMOTE APPLICATION entry
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 ;
 ; Install BMS VDIF entry into the REMOTE APPLICATION file (#8994.5)
 S XU8DATA(1)="BMS VDIF" ; Name
 S XU8DATA(2)="WEBB BED MGMT SOLUTION" ; ContextOption Name
 S XU8DATA(3)="Bed Management Solution" ; ContextOption Menu Text
 S XU8DATA(4)="webb bed mgmt solution" ; Security phrase
 ; For TYPE multiple, each entry should be XU8DATA(n)=CallBackType^CallBackPort^CallBackServer^URLString
 ; where n is 5, 6, 7, 8 etc.
 S XU8DATA(5)="S"_"^"_"-1"_"^"_"N/A"_"^"_"N/A"
 S XU8ERRX=$$OPTION(.XU8DATA) ; Create CONTEXTOPTION if doesn't exist
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 S XU8ERRX=$$DELETE(.XU8DATA) ; Delete existing REMOTE APPLICATION entry
 S XU8ERRX=$$CREATE(.XU8DATA) ; Create REMOTE APPLICATION entry
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 ;
 Q
 ;
OPTION(XU8DATA) ; Create CONTEXTOPTION if doesn't exist
 N XU8ERR,XU8FDA,XU8IEN,XU8MSG
 S XU8IEN=$$FIND1^DIC(19,"","X",XU8DATA(2),"B")
 S XU8ERR="Error message: "_XU8IEN
 I +XU8IEN>0 S XU8ERR="OPTION exists at IEN = "_XU8IEN
 I +XU8IEN=0 S XU8ERR="OPTION "_XU8DATA(2)_" created" D
 . S XU8FDA(19,"?+1,",.01)=XU8DATA(2)
 . S XU8FDA(19,"?+1,",1)=XU8DATA(3)
 . S XU8FDA(19,"?+1,",4)="B" ; B:Broker (Client/Server)
 . D UPDATE^DIE("","XU8FDA","XU8IEN","XU8MSG")
 . I $D(XU8MSG) S XU8ERR="   **ERROR** "_$G(XU8MSG("DIERR",1))_" Unable to create OPTION entry "_XU8DATA(2)
 D CLEAN^DILF
 Q XU8ERR
 ;
CREATE(XU8DATA) ; Create new REMOTE APPLICATION entry
 N XU8ERR,XU8FDA,XU8IEN,XU8MSG,XU8I,XU8IENS,DA,DIK
 ; Delete existing entry if it exists, before creating updated entry
 S XU8IEN=$$FIND1^DIC(8994.5,"","X",XU8DATA(1),"B")
 I $G(XU8IEN)>0 D
 . S DIK="^XWB(8994.5,",DA=XU8IEN
 . D ^DIK
 . K XU8IEN
 S XU8ERR="   REMOTE APPLICATION entry created: "_XU8DATA(1)
 S XU8FDA(8994.5,"?+1,",.01)=XU8DATA(1) ; NAME
 I $D(XU8DATA(2)) S XU8FDA(8994.5,"?+1,",.02)=$$FIND1^DIC(19,"","X",XU8DATA(2),"B") ; CONTEXTOPTION
 S XU8FDA(8994.5,"?+1,",.03)=$$SHAHASH^XUSHSH(256,XU8DATA(4),"B") ; APPLICATIONCODE
 D UPDATE^DIE("","XU8FDA","XU8IEN","XU8MSG")
 I $D(XU8MSG) D
 . S XU8ERR="   **ERROR** "_$G(XU8MSG("DIERR",1))_" Unable to create REMOTE APPLICATION "_XU8DATA(1)
 ; Find the REMOTE APPLICATION
 S XU8IENS=$$FIND1^DIC(8994.5,"","X",XU8DATA(1),"B")
 I +XU8IENS<1 S XU8ERR=XU8IENS Q XU8ERR
 ; Fill in CALLBACKTYPE multiple
 S XU8I=4 F  S XU8I=$O(XU8DATA(XU8I)) Q:XU8I=""  D
 . N XU8FDA,XU8IEN,XU8MSG,XU8TEST,XU8J,XU8FLAG
 . ; Check for duplicates (loop through CALLBACKTYPE for this entry)
 . S XU8J=0 F  S XU8J=$O(^XWB(8994.5,XU8IENS,1,"B",$E(XU8DATA(XU8I),1,1),XU8J)) Q:(XU8J="")!($D(XU8FLAG))  D
 . . I $G(XU8DATA(XU8I))=$G(^XWB(8994.5,XU8IENS,1,XU8J,0)) S XU8FLAG=1
 . I '$D(XU8FLAG) D
 . . S XU8FDA(8994.51,"+2,"_XU8IENS_",",.01)=$P(XU8DATA(XU8I),"^",1) ; CALLBACKTYPE
 . . S XU8FDA(8994.51,"+2,"_XU8IENS_",",.02)=$P(XU8DATA(XU8I),"^",2) ; CALLBACKPORT
 . . S XU8FDA(8994.51,"+2,"_XU8IENS_",",.03)=$P(XU8DATA(XU8I),"^",3) ; CALLBACKSERVER
 . . S XU8FDA(8994.51,"+2,"_XU8IENS_",",.04)=$P(XU8DATA(XU8I),"^",4) ; URLSTRING
 . . D UPDATE^DIE("","XU8FDA","XU8IEN","XU8MSG")
 . . I $D(XU8MSG) D
 . . . S XU8ERR="   **ERROR** "_$G(XU8MSG("DIERR",1))_" Unable to update REMOTE APPLICATION "_XU8DATA(1)
 ;
 D CLEAN^DILF
 Q XU8ERR
DELETE(XU8DATA) ; Delete REMOTE APPLICATION entries (if they exist)
 N XU8ERR,XU8IEN,DA,DIK
 S XU8ERR=""
 S XU8IEN=$$FIND1^DIC(8994.5,"","X",XU8DATA(1),"B")
 I $G(XU8IEN)>0 D
 . S DIK="^XWB(8994.5,",DA=XU8IEN
 . D ^DIK
 . S XU8ERR="   REMOTE APPLICATION entry removed: "_XU8DATA(1)
 . K XU8IEN
 D CLEAN^DILF
 Q XU8ERR
