VDI1P2 ;ALB/MRY - Patch 2 Post-Init ; 3/23/2023
 ;;1.0;VETERANS DATA INTEGRATION AND FEDERATION;**2**;Dec 30, 1994;Build 5
 ;
 Q
 ;
MAIN ; Control subroutine
 N XU8ERRX,XU8DATA
 S XU8ERRX=""
 ;
 ; Install VDIF DENTAL entry into the REMOTE APPLICATION file (#8994.5)
 S XU8DATA(1)="VDI DENTAL ELIGIBILITY" ; Name
 S XU8DATA(2)="VDI DENTAL ELIGIBILITY" ; ContextOption Name
 S XU8DATA(3)="VDI DENTAL ELIGIBILITY Remote Application" ; ContextOption Menu Text
 S:$$PROD^XUPROD(1) XU8DATA(4)="XEYwWOta2I4q/GP5TLg+pKwc8xJ0stbaKu9Gw+p+Jrw=" ; Security phrase - Production
 S:'$$PROD^XUPROD(1) XU8DATA(4)="5cn0yaOflmMXqfW3fjqASg2u6kuEWhTUawZrSgxqlMY=" ; Security phrase - Non Production
 ; For TYPE multiple, each entry should be XU8DATA(n)=CallBackType^CallBackPort^CallBackServer^URLString
 ; where n is 5, 6, 7, 8 etc.
 ;
 ; CallBack Type:   S - Station #
 ;   H - HTTP
 ;   R - RPC Broker
 ;
 ;S XU8DATA(5)="H"_"^"_"-1"_"^"_"N/A"_"^"_"https://sqa.ehrm.das.domain.ext/vista/v1/api/selectPatient"
 S XU8DATA(5)="S"_"^"_"-1"_"^"_"N/A"_"^"_"N/A"
 ;S XU8DATA(5)="S^-1^N/A^N/A"
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 S XU8ERRX=$$CREATE(.XU8DATA) ; Create REMOTE APPLICATION entry
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 ;
 Q
 ;
CREATE(XU8DATA) ; Create new REMOTE APPLICATION entry
 N XU8ERR,XU8FDA,XU8IEN,XU8MSG,XU8I,XU8IENS,DA,DIK
 ; Delete existing entry if it exists, before creating updated entry
 S XU8IEN=$$FIND1^DIC(8994.5,"","X",XU8DATA(1),"B")
 I $G(XU8IEN)>0 D
 . S DIK="^XWB(8994.5,",DA=XU8IEN
 . D ^DIK
 . K XU8IEN
 . D BMES^XPDUTL("   OLD REMOTE APPLICATION DELETED, CREATING NEW RECORD")
 S XU8ERR="   REMOTE APPLICATION entry created: "_XU8DATA(1)
 S XU8FDA(8994.5,"?+1,",.01)=XU8DATA(1) ; NAME
 I $D(XU8DATA(2)) S XU8FDA(8994.5,"?+1,",.02)=$$FIND1^DIC(19,"","X",XU8DATA(2),"B") ; CONTEXTOPTION
 ; To prevent from double HASHING 
 ;S XU8FDA(8994.5,"?+1,",.03)=$$SHAHASH^XUSHSH(256,XU8DATA(4),"B") ; APPLICATIONCODE
 S XU8FDA(8994.5,"?+1,",.03)=XU8DATA(4)
 D UPDATE^DIE("","XU8FDA","XU8IEN","XU8MSG")
 I $D(XU8MSG) D
 . S XU8ERR="   **ERROR** "_$G(XU8MSG("DIERR",1))_" Unable to create REMOTE APPLICATION "_XU8DATA(1)
 ; Find the REMOTE APPLICATION
 S XU8IENS=$$FIND1^DIC(8994.5,"","X",XU8DATA(1),"B")
 I +XU8IENS<1 S XU8ERR=XU8IENS Q XU8ERR
 ;
 D CLEAN^DILF
 Q XU8ERR
