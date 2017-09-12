DG53678P ;ALB/MRY - Pre/Post-Install ; 9/26/05 3:33pm
 ;;5.3;Registration;**678**;Aug 13, 1993
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
 ;
 Q
 ;
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") DO
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q
 ;
POST ;
 ;Add new code into PTF AUSTIN ERROR CODES (#45.64) file
 N LINE,X,DGCODE,DIC,DGDESC,DGPOS,Y,DGX,DGY,DGCNT
 S DGCNT=0
 D BMES^XPDUTL(">>> Adding new code 125 to file # 45.64")
 F LINE=1:1 S X=$T(ADD+LINE) S DGCODE=$P(X,";;",2) Q:DGCODE="EXIT"  D
 .S DIC="^DGP(45.64,",DIC(0)=""
 .S DGDESC=$P(DGCODE,U,2)
 .S DGPOS=$P(DGCODE,U,3)
 .I $L(DGDESC)>70 Q
 .S DIC("DR")=".02///"_DGDESC_";.03///"_DGPOS
 .S X=$P(DGCODE,U)
 .I +$O(^DGP(45.64,"B",X,0)) S DGCNT=1 Q
 .K DO D FILE^DICN
 .I Y=-1 Q
 .S DGX=$P(DGCODE,U),DGY=$P(DGCODE,U,2)
 .D MES^XPDUTL("  CODE "_DGX_"     "_DGY_"     added.")
 .S DGCNT=DGCNT+1
 I DGCNT<1 D
 .D MES^XPDUTL("Code(s) missing. Compare with patch description.")
 ;
 D POST^DG53678A
 Q
 ;
ADD ;new code - descriptions cannot exceed 70 char.
 ;;125^Invalid Emergency Response Indicator.^24
 ;;EXIT
