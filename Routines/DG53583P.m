DG53583P ;ALB/TMK - DG*5.3*583 DELETE XREF FIELD .312 ; 09/29/2006
 ;;5.3;Registration;**583**;Aug 13, 1993;Build 20
 Q
EN ; Delete xref 1 on field .312 of patient file and re-compile input templates
 ;
 D BMES^XPDUTL("Deleting 'ACFL2' xref on *CLAIM FOLDER LOCATION (#.312) of PATIENT file (#2)")
 D DELIX^DDMOD(2,.312,1)
 D BMES^XPDUTL("Re-compiling input template DG LOAD EDIT SCREEN 7 of PATIENT FILE (#2)")
 N X,Y,DMAX
 S Y=$O(^DIE("B","DG LOAD EDIT SCREEN 7",""))
 I Y'="" D
 . S X=$G(^DIE(Y,"ROU")) I $E(X)="^" S X=$E(X,2,99)
 . S DMAX=$$ROUSIZE^DILF
 . D EN^DIEZ
 . Q
 D BMES^XPDUTL("Re-compiling input template DVBHINQ UPDATE of PATIENT FILE (#2)")
 N X,Y,DMAX
 S Y=$O(^DIE("B","DVBHINQ UPDATE",""))
 I Y'="" D
 . S X=$G(^DIE(Y,"ROU")) I $E(X)="^" S X=$E(X,2,99)
 . S DMAX=$$ROUSIZE^DILF
 . D EN^DIEZ
 . Q
 D BMES^XPDUTL("Step complete ... post install complete")
 Q
 ;
