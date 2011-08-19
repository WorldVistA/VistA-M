GMRC101H ;SLC/DCM - SET UP HL-7 MESSAGE TO UPDATE OERR ORDERABLE ITEMS FILE WITH NEW CONSULT TYPE ;5/20/98  14:20
 ;;3.0;CONSULT/REQUEST TRACKING;**1,15**;DEC 27, 1997
EN(ELC,RLECODE,ORDA,ORNAME,GMRCARRY,GMRCPRFX) ;entry point to set up HL-7 message to update orderable items file - file 101.43
 ;ELC=message type - MFN or UPD
 ;RLECODE=record level event code from table 180
 ;DA=IEN of procedure in ^ORD(101
 ;ORNAME=procedure name
 ;GMRCARRY=array of synonyms for procedure
 ;GMRCPRFX=prefix from ^ORD(101, i.e., "GMRCR " or "GMRCT "
 S MSH=$$MSH^GMRCHL7,$P(MSH,"|",3)=$S(GMRCPRFX="GMRCR ":"PROCEDURES",1:"CONSULTS"),$P(MSH,"|",9)="MFN"
 S MFI=$$MFI(RLECODE)
 S MFE=$$MFE(ELC,ORDA,ORNAME,GMRCPRFX)
 D ZSY(.GMRCARRY)
 D BUILD
 K HLQ,MFE,MSH,MFI,MSG,MSGND,ND,ND1,ND2,ZSY,SEP1,SEP2,SEP3,SEP4,SEP5
 Q
BUILD ;build the HL-7 array into its export form
 S ND=1,MSG="GMRCMSG"
 S @(MSG_"("_ND_")")=MSH,ND=ND+1
 S @(MSG_"("_ND_")")=MFI,ND=ND+1
 S @(MSG_"("_ND_")")=MFE,ND=ND+1
 I $O(ZSY(0)) D
 .S ND1=0 F  S ND1=$O(ZSY(ND1)) Q:ND1=""  S @(MSG_"("_ND_")")=ZSY(ND1),ND=ND+1
 .K ND1
 .Q
 K ND
 Q
 ;
MFI(MTP) ;set MFI HL-7 segment
 S MFI="MFI|123.3^GMRC PROCEDURE^99DD||"_MTP_"|||NE"
 Q MFI
 ;
MFE(RSPLVL,ORXDA,GMRCPRNO,PFX) ;set MFE HL-7 segment
 N X
 S X="MFE|"_RSPLVL_"|||^^^"_ORXDA_"^"_GMRCPRNO_"^99PRC"
 Q X
ZSY(ARRAY) ;set ZSY segment of the HL-7 segment; contains synonyms
 S ND1="",ND2=1
 F  S ND1=$O(ARRAY(ND1)) Q:ND1=""  S ZSY(ND2)="ZSY|"_ND2_"|"_ARRAY(ND1)_"|",ND2=ND2+1
 K ND,ND1
 Q
SVC(SVCIEN,SVCNAME,EVCODE) ;format an HL-7 message that defines a new service
 ;SVCIEN=Service IEN from file 123.5
 ;SVCNAME=Service name, i.e., Medicine
 ;EVCODE=record level event code from HL-7 table 180
 K GMRCMSG
 S MSH=$$MSH^GMRCHL7,$P(MSH,"|",9)="MFN"
 S MFI="MFI|123.5^Request Services^99DD||"_$S(EVCODE="MUP":"UPD",1:"REP")_"|||NE"
 S MFE="MFE|"_EVCODE_"|||^^^"_SVCIEN_"^"_SVCNAME_"^99CON"
 I $L($O(^GMR(123.5,SVCIEN,2,"B",""))) D
 .S ND="",ND1=0 F  S ND=$O(^GMR(123.5,SVCIEN,2,"B",ND)) Q:ND=""  S ND1=ND1+1,GMRCARRY(ND1)=ND
 .D ZSY(.GMRCARRY)
 .Q
 D BUILD
 K GMRCARRY,ND,ND1,HLQ,MSG,MSH,MFI,MFE,SEP1,SEP2,SEP3,SEP4,SEP5,ZSY
 Q
