GMRCPOST ;SLC/DCM - Post init driver routine ;10/28/98  14:31
 ;;3.0;CONSULT/REQUEST TRACKING;**1**;DEC 27, 1997
 D EN^GMRCPOS1
 Q
EN S ND=0 I '$O(^GMR(123.5,ND)) S DIE=123.5,DA=1,DR=".01////^S X=""ALL SERVICES""" D ^DIE K DIE,DA,DR
 K ND
 Q
SVC(SVCIEN,SVCNAME,EVCODE) ;build HL7 message for conversion
 K GMRCMSG
 S MSH="MSH|^~\&|CONSULTS|"_$S($G(DUZ(2))]"":DUZ(2),1:+$$SITE^VASITE())_"|||||MFN"
 S MFI="MFI|123.5^Request Services^99DD||"_$S(EVCODE="MUD":"REP",1:"UPD")_"|||NE"
 S MFE="MFE|"_EVCODE_"|||^^^"_SVCIEN_"^"_SVCNAME_"^99CON"
 I $L($O(^GMR(123.5,SVCIEN,2,"B",""))) D
 .S ND1="",ND2=0 F  S ND1=$O(^GMR(123.5,SVCIEN,2,"B",ND1)) Q:ND1=""  S ND2=ND2+1,GMRCARRY(ND2)=ND1
 .D ZSY(.GMRCARRY)
 .Q
 I +$P(^GMR(123.5,SVCIEN,0),"^",2),$P(^(0),"^",2)'=9 S ZCS="ZCS|"_$P(^(0),"^",2)
 D BUILD
 K MSH,MFI,MFE,GMRCARRY,ZSY,ZCS
 Q
 ;
BUILD ;build the HL-7 array into its export form
 S ND=1,MSG="GMRCMSG"
 S @(MSG_"("_ND_")")=MSH,ND=ND+1
 S @(MSG_"("_ND_")")=MFI,ND=ND+1
 S @(MSG_"("_ND_")")=MFE,ND=ND+1
 S:$D(ZCS) @(MSG_"("_ND_")")=ZCS,ND=ND+1
 S ND1=0 F  S ND1=$O(ZSY(ND1)) Q:ND1=""  S @(MSG_"("_ND_")")=ZSY(ND1),ND=ND+1
 Q
 ;
MFI(MTP) ;s MFI HL-7 segment
 N X
 S MFI="MFI|101^Protocol^99DD||"_$S(MTP="MFN":"REP",1:"UPD")_"|||NE"
 Q MFI
 ;
MFE(RSPLVL,ORXDA,GMRCPRNO,PFX) ;set MFE HL=7 segment
 N X
 S X="MFE|"_RSPLVL_"|||^^^"_ORXDA_"^"_GMRCPRNO_"^99"_$S(PFX="GMRCR ":"PRO",1:"CON")
 Q X
 ;
ZSY(ARRAY)  ;set ZSY segment of the HL-7 segment; contains synonyms
 S ND1="",ND2=1
 F  S ND1=$O(ARRAY(ND1)) Q:ND1=""  S ZSY(ND2)="ZSY|"_ND2_"|"_ARRAY(ND1)_"|",ND2=ND2+1
 K ND1,ND2
 Q
 ;
ITEMS(ELC,RLECODE,ORDA,ORNAME,GMRCARRY,GMRCPRFX) ;entry point to set up HL-7 message to update orderable items file - file 101.43 in Post INIT
 S MSH="MSH|^~\&|"_$S(GMRCPRFX="GMRCR ":"PROCEDURES",1:"CONSULTS")_"|"_+$$SITE^VASITE_"|||||"_ELC
 S MFI=$$MFI(ELC)
 S MFE=$$MFE(RLECODE,ORDA,ORNAME,GMRCPRFX)
 D ZSY(.GMRCARRY)
 D BUILD
 K HLQ,MFE,MSH,MFI,MSG,MSGND,ND,ND1,ND2,ZSY
 Q
 ;
