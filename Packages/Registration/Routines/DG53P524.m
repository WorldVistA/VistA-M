DG53P524 ;ALB/TMD - Patch DG*5.3*524 Install Utility Routine ; 7/17/03 8:48am
 ;;5.3;Registration;**524**;AUG 13, 1993
 ;
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
 ;
 ;
PRE ;Main entry point for Pre-init items.
 Q
 ;
 ;
POST ;Main entry point for Post-init items.
 ;
 D POST1
 D POST2
 D POST3
 Q
 ;
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q
 ;
 ;
POST1 ;Change Brief Description (#20) for SPANISH AMERICAN (number 3) in PERIOD OF SERVICE file (#21).
 ;
 N DGBDESC   ;Brief Description
 N DGPOS     ;Period of Service
 N DGPOSIEN  ;Period of Service IEN in file #21
 N DGFDA     ;FDA for DBS call
 N DGERR     ;Error array for DBS call
 ;
 S DGPOS="SPANISH AMERICAN"
 S DGBDESC="(4/21/1898-7/4/1902)"
 D BMES^XPDUTL("** Updating PERIOD OF SERVICE file (#21) with new BRIEF DESCRIPTION field (#20) value for "_DGPOS_".")
 S DGPOSIEN=$$FIND1^DIC(21,"","MX",DGPOS,"","","DGERR") D
 .I 'DGPOSIEN!$D(DGERR) Q
 .S DGFDA(21,DGPOSIEN_",",20)=DGBDESC
 .D FILE^DIE("ET","DGFDA","DGERR")
 I $G(DGERR)'="" D BMES^XPDUTL("** Update of "_DGPOS_" Period of Service was NOT successful.") Q
 D BMES^XPDUTL("** BRIEF DESCRIPTION for "_DGPOS_" Period of Service changed to "_DGBDESC_".")
 ;
 Q
 ;
POST2 ; Change Input Transform for Claim Number field (#.313) in Patient file (#2) to disallow length>10 (pseudo SSNs)
 ;
 N DGCODE  ; Changed input transform
 N DGINTP  ; Input template name
 N DGERR   ; Error flag
 N DMAX    ; Maximum Routine Size
 N DGFIRST ; First four pieces of DD node containing input transform
 N X,Y
 ;
 I '$D(^DD(2,.313,0)) D BMES^XPDUTL("** Unable to locate DD node to update input transform for CLAIM NUMBER field (#.313) of the PATIENT file (#2)") Q
 S DGFIRST=$P(^DD(2,.313,0),U,1,4)
 S DGCODE="S DFN=DA D EV^DGLOCK I $D(X) S L=$S($D(^DPT(DA,0)):$P(^(0),U,9),1:X) W:X?1""SS"".E ""  "",L S:X?1""SS"".E X=L"
 S DGCODE=DGCODE_" K:$L(X)>9 X Q:'$D(X)  I X'=L K:$L(X)>8!($L(X)<7)!'(X?.N) X"
 S ^DD(2,.313,0)=DGFIRST_"^"_DGCODE
 D BMES^XPDUTL("** Input transform of the CLAIM NUMBER field (#.313) of the PATIENT file (#2) changed to:")
 D BMES^XPDUTL(DGCODE)
 ; Recompile Input Templates
 F DGINTP="DG LOAD EDIT SCREEN 7","DVBHINQ UPDATE" S Y=$O(^DIE("B",DGINTP,0)) S DGERR=0 D  I DGERR D BMES^XPDUTL("** "_DGINTP_" input template could not be updated")
 .I 'Y S DGERR=1 Q
 .S X=$P($G(^DIE(Y,"ROU")),U,2) I X="" S DGERR=1 Q
 .S DMAX=$$ROUSIZE^DILF D EN^DIEZ
 Q
POST3 ;
 ;N DGHELP  ;New help prompt text
 ;
 I '$D(^DD(2,.313,3)) D BMES^XPDUTL("** Unable to locate DD node to update Help Prompt for CLAIM NUMBER field (#.313) of the PATIENT file (#2)") Q
 S DGHELP="Enter this patient's claim number as 7-8 numerics or enter SS if the claim number is the same as his/her SSN.  Pseudo SSNs are not allowed."
 S ^DD(2,.313,3)=DGHELP
 D BMES^XPDUTL("** Help Prompt text for the CLAIM NUMBER field (#.313) of the PATIENT file (#2) changed to: ")
 D BMES^XPDUTL(DGHELP)
 Q
 ;
