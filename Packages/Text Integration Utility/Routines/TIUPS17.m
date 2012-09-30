TIUPS17 ; SLC/JER - Post-install for TIU*1*7 and TIU*1*51 ;1/12/99@11:33:48
 ;;1.0;Text Integration Utilities;**7,51**;Jun 20, 1997
MAIN ; Control Subroutine
 N TIUDA,TIUCNT,XPDIDTOT S (TIUCNT,TIUDA)=0
 ; If "ACL" cross-reference has already been built, then exit
 ; I +$$XRDONE Q ** RESTORE THIS AFTER TEST v3 **
 K ^TIU(8925.1,"ACL") ; Remove the existing ACL x-ref
 D BMES^XPDUTL("BUILDING NEW ""ACL"" CROSS-REFERENCE ON FILE 8925.1")
 S XPDIDTOT=$P(^TIU(8925.1,0),U,4)
 D UPDATE^XPDID(0)
 F  S TIUDA=$O(^TIU(8925.1,TIUDA)) Q:+TIUDA'>0  D
 . D XREF(TIUDA) S TIUCNT=+$G(TIUCNT)+1
 . I '(TIUCNT#10) D UPDATE^XPDID(TIUCNT)
 Q
XREF(DA) ; Call EN1^DIK to build "ACL" cross-reference on ^TIU(8925.1,
 N DIK
 S DIK="^TIU(8925.1,",DIK(1)=".01^ACL"
 D EN1^DIK
 Q
XRDONE() ; Determine whether last entry in 8925.1 has been x-refed
 N TIULNM,TIUY S TIULNM="",TIUY=0
 S TIULNM=$O(^TIU(8925.1,"ACL",38,TIULNM),-1)
 I TIULNM]"WARN" S TIUY=1
 Q TIUY
