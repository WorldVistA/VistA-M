XU8PS659 ;ISD/HGW - Post-Install for XU*8*659 ;12/17/15  10:49
 ;;8.0;KERNEL;**659**;Jul 10, 1995;Build 22
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;  Post Installation Routine for patch XU*8.0*659
 ;  EXTERNAL REFERENCES
 ;    BMES^XPDUTL 10141
 ;    $$FIND1^DIC
 ;    UPDATE^DIE 2053
 ;
MAIN ; Control subroutine
 N I,XDIR,XREF,XU8DATA,XU8ERRX,Y
 ;
 ; Delete old BSE Example entries from REMOTE APPLICATION file (#8994.5)
 S XU8DATA(1)="XUSBSE TEST1" ; Name
 S XU8ERRX=$$DELETE(.XU8DATA) ; Delete existing REMOTE APPLICATION entry
 S XU8DATA(1)="XUSBSE TEST2" ; Name
 S XU8ERRX=$$DELETE(.XU8DATA) ; Delete existing REMOTE APPLICATION entry
 S XU8DATA(1)="XUSBSE TEST3" ; Name
 S XU8ERRX=$$DELETE(.XU8DATA) ; Delete existing REMOTE APPLICATION entry
 ;
 ; Install IAM Provisioning entry into the REMOTE APPLICATION file (#8994.5)
 S XU8DATA(1)="IAM PROVISIONING" ; Name
 S XU8DATA(2)="XUS IAM USER PROVISIONING" ; ContextOption Name
 S XU8DATA(3)="IAM User Provisioning" ; ContextOption Menu Text
 S XU8DATA(4)="put butter square hat" ; Security phrase
 ; For TYPE multiple, each entry should be XU8DATA(n)=CallBackType^CallBackPort^CallBackServer^URLString
 ; where n is 5, 6, 7, 8 etc.
 S XU8DATA(5)="S^-1^N/A^N/A"
 S XU8ERRX=$$OPTION(.XU8DATA) ; Create CONTEXTOPTION if doesn't exist
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 S XU8ERRX=$$DELETE(.XU8DATA) ; Delete existing REMOTE APPLICATION entry
 S XU8ERRX=$$CREATE(.XU8DATA) ; Create REMOTE APPLICATION entry
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 ;
 ; Install IAM Binding entry into the REMOTE APPLICATION file (#8994.5)
 S XU8DATA(1)="IAM BINDING" ; Name
 S XU8DATA(2)="XUS IAM USER BINDING" ; ContextOption Name
 S XU8DATA(3)="IAM User Binding App" ; ContextOption Menu Text
 S XU8DATA(4)="de$lAyING55AMO)BAe29" ; Security phrase
 ; For TYPE multiple, each entry should be XU8DATA(n)=CallBackType^CallBackPort^CallBackServer^URLString
 ; where n is 5, 6, 7, 8 etc.
 S XU8DATA(5)="S^-1^N/A^N/A"
 S XU8ERRX=$$OPTION(.XU8DATA) ; Create CONTEXTOPTION if doesn't exist
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 S XU8ERRX=$$DELETE(.XU8DATA) ; Delete existing REMOTE APPLICATION entry
 S XU8ERRX=$$CREATE(.XU8DATA) ; Create REMOTE APPLICATION entry
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 ;
 ; Install NUMI entry into the REMOTE APPLICATION file (#8994.5)
 S XU8DATA(1)="NUMI" ; Name
 S XU8DATA(2)="WEBN NATL UTIL MGMT INTEG" ; ContextOption Name
 S XU8DATA(3)="National Utilization Mgmt Integration" ; ContextOption Menu Text
 S XU8DATA(4)="WEBN NATL UTIL MGMT INTEG" ; Security phrase
 ; For TYPE multiple, each entry should be XU8DATA(n)=CallBackType^CallBackPort^CallBackServer^URLString
 ; where n is 5, 6, 7, 8 etc.
 S XU8DATA(5)="S^-1^N/A^N/A"
 S XU8ERRX=$$OPTION(.XU8DATA) ; Create CONTEXTOPTION if doesn't exist
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 S XU8ERRX=$$DELETE(.XU8DATA) ; Delete existing REMOTE APPLICATION entry
 S XU8ERRX=$$CREATE(.XU8DATA) ; Create REMOTE APPLICATION entry
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 ;
 ; Install BMS entry into the REMOTE APPLICATION file (#8994.5)
 S XU8DATA(1)="BMS" ; Name
 S XU8DATA(2)="WEBB BED MGMT SOLUTION" ; ContextOption Name
 S XU8DATA(3)="Bed Management Solution" ; ContextOption Menu Text
 S XU8DATA(4)="WEBB BED MGMT SOLUTION" ; Security phrase
 ; For TYPE multiple, each entry should be XU8DATA(n)=CallBackType^CallBackPort^CallBackServer^URLString
 ; where n is 5, 6, 7, 8 etc.
 S XU8DATA(5)="S^-1^N/A^N/A"
 S XU8ERRX=$$OPTION(.XU8DATA) ; Create CONTEXTOPTION if doesn't exist
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 S XU8ERRX=$$DELETE(.XU8DATA) ; Delete existing REMOTE APPLICATION entry
 S XU8ERRX=$$CREATE(.XU8DATA) ; Create REMOTE APPLICATION entry
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 ;
 ;  Install entry into the DIALOG file (#.84)
 ;NUMBER: 30810.63                        DIALOG NUMBER: 30810.63
 ;  TYPE: GENERAL MESSAGE                 PACKAGE: KERNEL
 ;  SHORT DESCRIPTION: STS token not valid.
 ; TEXT:
 ;  Unable to sign on using Identity and Access Management STS token.
 K XU8DATA,XU8ERRX
 S XU8DATA(1)=30810.63
 S XU8DATA(2)="KERNEL"
 S XU8DATA(3)=2 ;"GENERAL MESSAGE"
 S XU8DATA(4)="STS token not valid."
 S XU8DATA(5)="Unable to sign on using Identity and Access Management STS token. Try using Access/Verify codes."
 S XU8ERRX=$$NEWDIA(.XU8DATA)
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 ;
 ;  Install entries into KERNEL SYSTEMS PARAMETERS file (#8989.3)
 K XU8DATA,XU8ERRX
 S XU8DATA(1)="eauth.domain.ext"
 S XU8DATA(2)="Department Of Veterans Affairs"
 S XU8DATA(3)="urn:oid:2.16.840.1.113883.4.349"
 S XU8ERRX=$$NEWKSP(.XU8DATA)
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 ;
 K ^XU8P655("VACAA") ;Cleanup after patch XU*8*655
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
DELETE(XU8DATA) ; Delete existing REMOTE APPLICATION entry
 N DA,DIK,XU8IEN
 S XU8IEN=$$FIND1^DIC(8994.5,"","X",XU8DATA(1),"B")
 I $G(XU8IEN)>0 D
 . S DIK="^XWB(8994.5,",DA=XU8IEN
 . D ^DIK
 . K XU8IEN
 Q 1
CREATE(XU8DATA) ; Create new REMOTE APPLICATION entry
 N XU8ERR,XU8FDA,XU8I,XU8IEN,XU8IENS,XU8MSG
 S XU8ERR="   REMOTE APPLICATION entry created: "_XU8DATA(1)
 S XU8FDA(8994.5,"?+1,",.01)=XU8DATA(1) ; NAME
 S XU8FDA(8994.5,"?+1,",.02)=$$FIND1^DIC(19,"","X",XU8DATA(2),"B") ; CONTEXTOPTION
 S XU8FDA(8994.5,"?+1,",.03)=$$SHAHASH^XUSHSH(256,XU8DATA(4),"B") ; APPLICATIONCODE
 D UPDATE^DIE("","XU8FDA","XU8IEN","XU8MSG")
 I $D(XU8MSG) D
 . S XU8ERR="   **ERROR** "_$G(XU8MSG("DIERR",1))_" Unable to create REMOTE APPLICATION: "_XU8DATA(1)
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
 . . . S XU8ERR="   **ERROR** "_$G(XU8MSG("DIERR",1))_" Unable to update REMOTE APPLICATION: "_XU8DATA(1)
 ;
 D CLEAN^DILF
 Q XU8ERR
 ;
NEWDIA(XU8DATA) ; Create DIALOG entry
 N DA,DIK,XU8DT,XU8ERR,XU8FDA,XU8IEN,XU8MSG
 ; Delete existing entry if it exists, before creating updated entry
 S XU8IEN=$$FIND1^DIC(.84,"","X",XU8DATA(1),"B")
 I $G(XU8IEN)>0 D
 . S DIK="^DI(.84,",DA=XU8IEN
 . D ^DIK
 . K XU8IEN
 S XU8ERR="   DIALOG entry created: "_XU8DATA(4)
 S XU8IEN(1)=XU8DATA(1)
 S XU8FDA(.84,"+1,",.01)=XU8DATA(1) ;IEN
 S XU8FDA(.84,"+1,",1)=XU8DATA(3) ;TYPE
 S XU8FDA(.84,"+1,",1.2)=XU8DATA(2) ;PACKAGE
 S XU8FDA(.84,"+1,",1.3)=XU8DATA(4) ;SHORT DESCRIPTION
 D UPDATE^DIE("","XU8FDA","XU8IEN","XU8MSG")
 I $D(XU8MSG) S XU8ERR="   **ERROR** "_$G(XU8MSG("DIERR",1))_" Unable to create DIALOG entry: "_XU8DATA(4) D CLEAN^DILF Q XU8ERR
 S XU8IEN=$$FIND1^DIC(.84,"","X",XU8DATA(1),"B")
 I $G(XU8IEN)>0 D
 . S XU8DT(1)=XU8DATA(5) ;TEXT
 . D WP^DIE(.84,XU8IEN_",",4,,"XU8DT","XU8MSG")
 I $D(XU8MSG) D
 . S XU8ERR="   **ERROR** "_$G(XU8MSG("DIERR",1))_" Unable to create DIALOG entry: "_XU8DATA(4)
 . S DIK="^DI(.84,",DA=XU8IEN
 . D ^DIK
 . K XU8IEN
 D CLEAN^DILF
 Q XU8ERR
 ;
NEWKSP(XU8DATA) ; Create KERNEL SYSTEM PARAMETERS entries
 N DA,DIK,XU8ERR,XU8FDA,XU8MSG
 S XU8ERR="   KERNEL SYSTEM PARAMETERS fields populated: SECURITY TOKEN SERVICE, ORGANIZATION, ORGANIZATION ID"
 S XU8FDA(8989.3,"1,",200.1)=XU8DATA(1)
 S XU8FDA(8989.3,"1,",200.2)=XU8DATA(2)
 S XU8FDA(8989.3,"1,",200.3)=XU8DATA(3)
 D FILE^DIE("E","XU8FDA","XU8MSG")
 I $D(XU8MSG) D
 . S XU8ERR="   **ERROR** "_$G(XU8MSG("DIERR",1))_" Unable to populate KERNEL SYSTEM PARAMETERS fields"
 D CLEAN^DILF
 Q XU8ERR
 ;
