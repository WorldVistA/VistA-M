FBXIP49 ;WOIFO/SS-PATCH INSTALL ROUTINE ;11/20/02
 ;;3.5;FEE BASIS;**49**;JAN 30, 1995
 Q
PS ;post-install entry point
 D BMES^XPDUTL("Fee Basis LTC FB Workload Capture, Post-Install Starting")
 D SETLTC
 D BMES^XPDUTL("    Creating new AF cross-references in file #162")
 D INDX
 D BMES^XPDUTL("Fee Basis LTC FB Workload Capture, Post-Install Complete")
 Q
 ;
INDX ;post-install entry point
 ;reindex "AF" cross-ref for #162.02  field #3 AUTHORIZATION POINTER
 N DA,DIK
 S DIK(1)="3^AF"
 S DA(2)=0
 F  S DA(2)=$O(^FBAAC(DA(2))) Q:+DA(2)=0  D
 . S DA(1)=0
 . F  S DA(1)=$O(^FBAAC(DA(2),1,DA(1))) Q:+DA(1)=0  D
 . . S DA=0
 . . F  S DA=$O(^FBAAC(DA(2),1,DA(1),1,DA)) Q:+DA=0  D
 . . . S DIK="^FBAAC("_DA(2)_",1,"_DA(1)_",1,"
 . . . D EN1^DIK
 Q
 ;
LTCTYP(FBIENCL,FBLTCTYP) ;
 N FBIENS,FBFDA,FBERR
 S FBIENS=FBIENCL_"," ; "D0,"
 S FBFDA(161.82,FBIENS,5)=FBLTCTYP
 D FILE^DIE("","FBFDA","FBERR")
 I $D(FBERR) D
 . D BMES^XPDUTL(+$G(FBIENCL)_","_$G(FBLTCTYP)_" "_$G(FBERR("DIERR",1,"TEXT",1)))
 Q
 ;
SETLTC ;
 D BMES^XPDUTL("    Populating field #5 LTC COPAY TYPE of file #161.82")
 N FBX,FBT,FBIEN
 F FBX=1:1 S FBT=$P($T(POV+FBX),";",3) Q:'$L(FBT)  D
 . S FBIEN=+$O(^FBAA(161.82,"C",+FBT,0))
 . I FBIEN=0 D BMES^XPDUTL("  Error: there is no entry for "_+FBT_" code in 161.82") Q
 . D LTCTYP(FBIEN,$P(FBT,"^",2))
 Q
 ;
 ;Listed below are the POV codes related to LTC but not necessarily
 ;will be a subject for LTC copays
 ;
POV ;
 ;;42^3^COMMUNITY NURSING HOME FOR ACTIVE DUTY PERSONNEL
 ;;70^3^HOME HEALTH NURSING SERVICES
 ;;71^3^HOMEMAKER/HOME HEALTH AID SERVICES
 ;;74^3^HOME HEALTH SERVICES (NON-NURSING PROFESSIONAL)
 ;;77^3^HOSPICE & PALLIATIVE CARE (OPT) - CONTRACT/SHARING AGREEMENT
 ;;78^3^HOSPICE & PALLIATIVE CARE (OPT) - FEE BASIS AUTHORITY (CFR 17.50b)
 ;;
