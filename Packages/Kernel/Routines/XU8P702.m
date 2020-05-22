XU8P702 ;ISF/CLG - Post-Install for 702 ;04/28/17  11:56
 ;;8.0;KERNEL;**702**;Jul 10, 1995;Build 19
 ;Per VA Directive 6402, this routine should not be modified.
 ;  Post Installation Routine for patch XU*8.0*702
 ;
 ;  Installs entries into the REMOTE APPLICATION file (#8994.5)
 ;
 ;  Removes entries from the REMOTE APPLICATION file (#8994.5)
 ;  that were installed with Entered in Error Patch XU*8.0*681
 ;
 ;  EXTERNAL REFERENCES
 ;    BMES^XPDUTL 10141
 ;    $$FIND1^DIC
 ;    UPDATE^DIE 2053
 ;
MAIN ; Control subroutine
 N XU8ERRX,XU8DATA
 ;
 ; "TERMINAL EMULATOR" to record terminal emulator access (LOA=2) in the SIGN-ON LOG
 K XU8DATA
 S XU8DATA(1)="TERMINAL EMULATOR" ; Name
 S XU8DATA(4)="general_terminal_emulator/loa2avcodes" ; Security phrase (case sensitive), non-application specific
 S XU8DATA(5)="S"_"^"_"-1"_"^"_""_"^"_""
 S XU8ERRX=$$CREATE(.XU8DATA) ; Create REMOTE APPLICATION entry
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 ;
 ; "MICRO FOCUS REFLECTION" to record Micro Focus Reflection access in the SIGN-ON LOG
 K XU8DATA
 S XU8DATA(1)="MICRO FOCUS REFLECTION" ; Name
 S XU8DATA(4)="delphi_rpc_broker/attachmate.emulation.frame.exe" ; Security phrase (case sensitive)
 S XU8DATA(5)="S"_"^"_"-1"_"^"_""_"^"_""
 S XU8ERRX=$$CREATE(.XU8DATA) ; Create REMOTE APPLICATION entry
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Success message" or "Error text"
 ;
 ; "ATTACHMATE REFLECTION" created with Patch XU*8.0*681, being removed with XU*8.0*702
 K XU8DATA
 S XU8DATA(1)="ATTACHMATE REFLECTION" ; Name
 S XU8ERRX=$$CLNUP(.XU8DATA) ; Create REMOTE APPLICATION entry
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Removal success message" or "Blank if no entry exists"
 ;
 ; "CPRS GUI" created with Patch XU*8.0*681, being removed with XU*8.0*702
 K XU8DATA
 S XU8DATA(1)="CPRS GUI" ; Name
 S XU8ERRX=$$CLNUP(.XU8DATA) ; Remove REMOTE APPLICATION
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Removal success message" or "Blank if no entry exists"
 ;
 ; "BCMA GUI" created with Patch XU*8.0*681, being removed with XU*8.0*702
 K XU8DATA
 S XU8DATA(1)="BCMA GUI" ; Name
 S XU8ERRX=$$CLNUP(.XU8DATA) ; Remove REMOTE APPLICATION
 D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Removal success message" or "Blank if no entry exists"
 ;
 ; "DSS ROI" created with Patch XU*8.0*681, being removed with XU*8.0*702
 K XU8DATA
 S XU8DATA(1)="DSS ROI" ; Name
 S XU8ERRX=$$CLNUP(.XU8DATA) ; Remove REMOTE APPLICATION
 I XU8ERRX'="" D BMES^XPDUTL(XU8ERRX) ; XU8ERRX is "Removal success message" or "Blank if no entry exists"
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
CLNUP(XU8DATA) ; Clean up REMOTE APPLICATION entries from Patch XU*8.0*681 (if they exist)
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
