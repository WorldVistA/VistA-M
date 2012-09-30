WV22PST ;HIOFO/FT-WV*1*22 POST INSTALLATION ROUTINE; 1/30/07 9:29am
 ;;1.0;WOMEN'S HEALTH;**22**;Sep 30, 1998;Build 1
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
 ;
POST ;Main entry point for Post-init items.
 ;
 ;Change the CPT codes for mammograms in file 790.2
 N X,Y,Z,OLDCPT,NEWCPT
 F X="MAMMOGRAM DX BILAT","MAMMOGRAM DX UNILAT","MAMMOGRAM SCREENING" D
 . S Y=$O(^WV(790.2,"B",X,0)) Q:Y'>0
 . S Z=$G(^WV(790.2,Y,0)) Q:Z=""
 . S OLDCPT=$P(Z,"^",8) I OLDCPT'=76090,OLDCPT'=76091,OLDCPT'=76092 Q
 . S NEWCPT=$S(X="MAMMOGRAM DX BILAT":77056,X="MAMMOGRAM DX UNILAT":77055,X="MAMMOGRAM SCREENING":77057,1:"") Q:NEWCPT=""
 . S $P(Z,"^",8)=NEWCPT,^WV(790.2,Y,0)=Z
 . ; update cross-reference
 . K ^WV(790.2,"AC",OLDCPT,Y)
 . S ^WV(790.2,"AC",NEWCPT,Y)=""
 Q
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
