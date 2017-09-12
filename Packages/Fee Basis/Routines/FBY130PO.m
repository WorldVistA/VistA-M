FBY130PO ;Harris/YMG - Post Install for FB patch 130 ;26-Oct-2011
 ;;3.5;FEE BASIS;**130**;JAN 30, 1995;Build 13
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; project ARCH post-install
 ;
EN ; entry point
 N XPDIDTOT
 S XPDIDTOT=1
 D JUST(1)         ; 1. Modify eligibility justification entries
 ;
EX ; exit point
 Q
 ;
JUST(FBXPD) ; modify entries in file 161.35
 ;
 N DA,DIE,DIK,DR,IEN1,IEN2,NEWPTR,PTR,STR,X,Y,Z
 D BMES^XPDUTL(" STEP "_FBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Setting eligibility justification entries ... ")
 ;
 S Z=$P(^FBAA(161.35,0),U,3) I Z=3 G JUSTX  ; there's nothing to do
 ; delete existing entries
 S DIK="^FBAA(161.35," F DA=1:1:Z D ^DIK
 ; create new entries
 S STR(1)="OEF/OIF/OND, enrolled after 8/29/2011, geographic eligibility confirmed via web based tool"
 S STR(2)="Enrolled between 10/1/2010 and 8/29/2011, geographic eligibility confirmed via web based tool"
 S STR(3)="Enrolled prior to 10/1/2010, geographic eligibility confirmed via web based tool"
 F DA=1:1:3 S DR=".01////"_STR(DA)_";1////1",DIE=161.35 D ^DIE
 ; change existing pointers
TEST ;
 S Z="" F  S Z=$O(^FBAAA("ARCH",Z)) Q:Z=""  D
 .S IEN1="" F  S IEN1=$O(^FBAAA("ARCH",Z,IEN1)) Q:IEN1=""  D
 ..S IEN2="" F  S IEN2=$O(^FBAAA("ARCH",Z,IEN1,IEN2)) Q:IEN2=""  D
 ...S PTR=+$P(^FBAAA(IEN1,"ARCHFEE",IEN2,0),U,4)
 ...I PTR'>0 Q  ; only change existing pointers
 ...S NEWPTR=$S(PTR=5:2,PTR=1:3,PTR=6:3,1:1)
 ...S DIE="^FBAAA("_IEN1_",""ARCHFEE"",",DA(1)=IEN1,DA=IEN2,DR="4////"_NEWPTR D ^DIE
 ...Q
 ..Q
 .Q
 ;
JUSTX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(FBXPD)
 Q
