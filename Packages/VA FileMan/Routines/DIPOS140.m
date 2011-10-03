DIPOS140 ;SFISC/SO- POST INSTAL DI*22*140 RE-COMPILE XREF;8:50 AM  18 Aug 2004
 ;;22.0;VA FileMan;*140*;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D MES^XPDUTL("Begin re-compile of cross references...")
 N FILE S FILE=1.99999
 F  S FILE=$O(^DIC(FILE)) Q:'FILE  D
 . I '$D(^DD(FILE,0,"DIK")) Q  ;File does not have compiled xref
 . N GL,X,Y,DMAX,DIQUITE
 . I '$D(^DIC(FILE,0,"GL")) Q  ;Missing global location
 . S GL=^("GL")_"0)" ;Naked set in previous line
 . I '$D(@GL) Q  ;No file header node
 . I +$P(@GL,U,2)'=FILE Q  ;File node number not correct
 . D MES^XPDUTL("Re-compiling cross reference for: "_$$GET1^DIQ(1,FILE_",",.01)_"(#"_FILE_")")
 . S DMAX=^DD("ROU")
 . S X=^DD(FILE,0,"DIK")
 . S Y=FILE
 . D EN^DIKZ
 . Q
 D MES^XPDUTL("Finished re-compile of cross refereneces.")
 Q
