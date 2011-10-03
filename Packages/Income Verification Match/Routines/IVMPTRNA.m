IVMPTRNA ;ALB/CKN/BRM,TDM - HL7 FULL DATA TRANSMISSION (Z07) BUILDER(CONTINUED);30 AUG 2001 ; 5/17/06 1:57pm
 ;;2.0;INCOME VERIFICATION MATCH;**46,58,76,105**; 21-OCT-94;Build 2
 Q
NTROBX(DGNTARR) ;
 N NTRTEMP,I,CS,RS,SS
 I $G(HLECH)'="~|\&" N HLECH S HLECH="~|\&"
 I $G(HLFS)'="^" N HLFS S HLFS="^"
 S CS=$E(HLECH,1),SS=$E(HLECH,4),RS=$E(HLECH,2)
 S NTRTEMP("NTR","Y")="1"_CS_"Received NTR Trmt"_CS_"VA0053"
 S NTRTEMP("AVI","Y")="2"_CS_"Aviator Pre 1955"_CS_"VA0053"
 S NTRTEMP("SUB","Y")="3"_CS_"Sub Trainee pre 1965"_CS_"VA0053"
 S NTRTEMP("HNC","Y")="4"_CS_"Dx With Head Neck Cancer"_CS_"VA0053"
 S NTRTEMP("NTR","N")="5"_CS_"No NTR Trmt"_CS_"VA0053"
 S NTRTEMP("AVI","N")="6"_CS_"Not Aviator Pre 1955"_CS_"VA0053"
 S NTRTEMP("SUB","N")="7"_CS_"Not Sub Trainee pre 1965"_CS_"VA0053"
 S NTRTEMP("HNC","N")="8"_CS_"Not Dx With Head Neck Cancer"_CS_"VA0053"
 S NTRTEMP("NTR","U")="9"_CS_"NTR Trmt Unknown"_CS_"VA0053"
 S NTRTEMP("VER","M")="M"_CS_"Military Med Rec"_CS_"VA0052"
 S NTRTEMP("VER","S")="S"_CS_"Qual Military Srvc"_CS_"VA0052"
 S NTRTEMP("VER","N")="N"_CS_"Not Qualified"_CS_"VA0052"
 S NTROBX(2)="CE",NTROBX(3)="VISTA"_CS_"28.11"
 S NTROBX(5)=""
 F I="NTR","AVI","SUB","HNC" D
 . I $G(DGNTARR(I))="" Q
 . I NTROBX(5)'="" S NTROBX(5)=$G(NTROBX(5))_RS
 . S NTROBX(5)=$G(NTROBX(5))_$G(NTRTEMP(I,$G(DGNTARR(I))))
 S NTROBX(11)="F"
 S NTROBX(12)=$G(DGNTARR("HDT"))
 S NTROBX(14)=$G(DGNTARR("VDT"))
 I $G(DGNTARR("VSIT"))'="" D
 . S NTROBX(15)=$P($G(^DIC(4,DGNTARR("VSIT"),99)),"^")
 S NTROBX(16)=""
 I $G(DGNTARR("HSIT"))'="" D
 . S $P(NTROBX(16),CS,14)=SS_$P($G(^DIC(4,DGNTARR("HSIT"),99)),"^")
 I $G(DGNTARR("VER"))'="" S NTROBX(17)=$G(NTRTEMP("VER",$G(DGNTARR("VER"))))
 Q
RF1(DFN,RF1TYP) ; create RF1 segment
 ;  Input:
 ;        DFN - Patient IEN
 ;     RF1TYP - RF1 Type
 ;              SAD = Street Address Change (Default)
 ;              CAD = Confidential Address Change
 ;              CPH = Cell Phone Number Change
 ;              PNO = Pager Number Change
 ;              EAD = E-Mail Address Change
 ;
 ;  Output: RF1 segment
 ;
 N X,Y,ADDRSRC,ADRSRC,ADRSIT,ADTDT,I,CS,RS,SS,HLQ,RETURN,RFDAT,ERR
 I $G(HLECH)'="~|\&" N HLECH S HLECH="~|\&"
 I $G(HLFS)'="^" N HLFS S HLFS="^"
 S CS=$E(HLECH,1),SS=$E(HLECH,4),RS=$E(HLECH,2),HLQ=""""
 S:$G(RF1TYP)="" RF1TYP="SAD"   ;Set type to 'SAD' if no value passed
 ; initialize the RETURN variable
 S RETURN="RF1",$P(RETURN,HLFS,4)=RF1TYP,$P(RETURN,HLFS,11)=""
 Q:'$G(DFN) RETURN
 ;I RF1TYP="SAD",$$BADADR^DGUTL3(DFN) Q RETURN
 D RF1LOAD(RF1TYP) Q:$D(ERR) RETURN
 I RF1TYP'="SAD",$G(ADRDT)="" Q ""
 ; RF1 SEQ 1-2 are not currently used
 ; RF1 SEQ 3
 S $P(RETURN,HLFS,4)=RF1TYP
 ; RF1 SEQ 4-5 are not currently used
 ; RF1 SEQ 6
 S $P(RETURN,HLFS,7)=$G(ADRSIT)
 S:$G(ADRSRC)'="" $P(RETURN,HLFS,7)=$P(RETURN,HLFS,7)_CS_ADRSRC
 ; RF1 SEQ 7
 S $P(RETURN,HLFS,8)=$G(ADRDT)
 ; RF1 SEQ 8-11 are not currently used
 ; quit with completed RF1 segment
 Q RETURN
 ;
ADDRCNV(ADDRSRC) ;convert Address Source to HL7 format
 Q:$G(ADDRSRC)']"" ""
 Q:ADDRSRC="HEC" "USVAHEC"
 Q:ADDRSRC="VAMC" "USVAMC"
 Q:ADDRSRC="HBSC" "USVAHBSC"
 Q:ADDRSRC="NCOA" "USNCOA"
 Q:ADDRSRC="BVA" "USVABVA"
 Q:ADDRSRC="VAINS" "USVAINS"
 Q:ADDRSRC="USPS" "USPS"
 Q:ADDRSRC="LACS" "LACS"
 Q ""
 ;
RF1LOAD(RF1TYP) ;
 N RFDT,RFSRC,RFSIT,GETFLDS,RFDAT,ERR
 K ADRDT,ADRSRC,ADRSIT
 I RF1TYP="SAD" S RFDT=.118,RFSRC=.119,RFSIT=.12
 I RF1TYP="CAD" S RFDT=.14112,RFSRC="",RFSIT=.14113
 I RF1TYP="CPH" S RFDT=.139,RFSRC=.1311,RFSIT=.13111
 I RF1TYP="PNO" S RFDT=.1312,RFSRC=.1313,RFSIT=.1314
 I RF1TYP="EAD" S RFDT=.136,RFSRC=.137,RFSIT=.138
 S GETFLDS=RFDT S:RFSRC'="" GETFLDS=GETFLDS_";"_RFSRC S GETFLDS=GETFLDS_";"_RFSIT
 D GETS^DIQ(2,DFN_",",GETFLDS,"IE","RFDAT","ERR") Q:$D(ERR)
 S ADRDT=$$FMTHL7^XLFDT($G(RFDAT(2,DFN_",",RFDT,"I")))
 S:RFSRC'="" ADRSRC=$$EXTERNAL^DILFD(2,RFSRC,"",$G(RFDAT(2,DFN_",",RFSRC,"I")))
 ; only populate Change Site if Source=VAMC or NO Source Field
 I ($G(ADRSRC)="VAMC")!(RFSRC="") D
 . S ADRSIT=$G(RFDAT(2,DFN_",",RFSIT,"I"))
 . S:ADRSIT]"" ADRSIT=$$GET1^DIQ(4,ADRSIT_",",99)
 S ADRSRC=$$ADDRCNV($G(ADRSRC))  ;convert source to HL7 format
 Q
