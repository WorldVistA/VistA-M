RAHLR ;HISC/CAH/BNT - Generate Common Order (ORM) Message ;11/10/99  10:42
 ;;5.0;Radiology/Nuclear Medicine;**2,12,10,25,71,82,75,80,84,94**;Mar 16, 1998;Build 9
 ;Generates msg whenever a case is registered or cancelled or examined
 ;              registered        cancelled        examined
 ; Order control : NW                CA               XO
 ; Order status  : IP                CA               CM
 ;07/28/2008 BAY/KAM RA*5*94 Remove GMT offset from OBR-7 & add Reason for Study to OBX segment
 ;02/14/2006 BAY/KAM RA*5*71 Add ability to update exam data to V/R
 ;
 ;Integration Agreements
 ;----------------------
 ;NOW^%DTC(10000); ^%ZTLOAD(10063); $$GET1^DIQ(2056); ^DIWP(10011)
 ;$$HLDATE/$$HLNAME/$$M11^HLFNC(10106); INIT^HLFNC2(2161)
 ;GENERATE^HLMA(2164); DEM^VADPT(10061); $$EN^VAFHLPID(263)
 ;$$FMTHL7^XLFDT(10103)
 ;
 ;IA: 10039 global read .01 field WARD LOCATION (#42) file ^DIC(42,
 ;IA: 10040 global read .01 field HOSPITAL LOCATION (#44) file ^SC(
 ;
 S:$D(HLNDAP) ZTSAVE("HLNDAP")="" S:$D(HLDAP) ZTSAVE("HLDAP")="" S:$D(RAEXMDUN) ZTSAVE("RAEXMDUN")=""
 S:$D(RAEXEDT) ZTSAVE("RAEXEDT")=""
 S ZTSAVE("RADFN")="",ZTSAVE("RADTI")="",ZTSAVE("RACNI")="",ZTIO="",ZTDTH=$H,ZTDESC="Rad/Nuc Med Compiling HL7 Common Order",ZTRTN="EN^RAHLR" D ^%ZTLOAD
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE Q
EN ; Called from the RA REG & RA CANCEL & RA EXAMINED protocols
 ; Input Variables:
 ;   RADFN=file 2 IEN (DFN)
 ;   RADTI=file 70 Exam subrec IEN (reverse date/time of exam)
 ;   RACNI=file 70 Case subrecord IEN
 ;   RAEID=ien of the event driver protocol (defined in RAHLRPC)
 ; Output Variables:
 ;   HLA("HLS") array containing HL7 msg
 ;
 N EID,HL,INT,HLQ,HLFS,HLECH,HLA,HLCS,HLSCS,HLREP,HLECH
 N DFN,DIWF,DIWL,DIWR,GMRAL,PI,RACANC,RACN0,RACPT,RACPTNDE,RADTE,RAI,RAN,RAOBR4,RAPRCNDE,RAPROC,RAPROCIT,RAPRV,RAX0,VA,VADM,VAERR,X,X0,Y,X1,OBR36
 ;
 D INIT ; initialize some HL7 variables
 ;RAEXMDUN passed from EXM^RAHLRPC if conditions are met
 Q:+$G(HL)=15  ;no known client(item) linked to the event driver protocol
 Q:$O(HL(""))=""  ;disabled server appl, or no server appl 
 ;** branch to new HL7 logic when the HL7 version surpasses 2.3 **
 I HL("VER")>2.3,($T(^RAHLR1))'="" D EN^RAHLR1(RADFN,RADTI,RACNI,RAEID) Q
 ;** branch to new HL7 logic when the HL7 version surpasses 2.3 **
 S RACN0=$S($D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)):^(0),1:"") Q:RACN0']""
 ;Generate Message Text
 S RAPROC=+$P(RACN0,U,2) I 'RAPROC Q  ;If case entered via 'Enter Last Past Visit before DHCP option, and procedure 'OTHER' is inactive, RAPROC will be null and will cause bomb-out unless we quit here
 S RAPROCIT=+$P($G(^RAMIS(71,RAPROC,0)),U,12),RAPROCIT=$P(^RA(79.2,RAPROCIT,0),U,1)
 S (RADTE,OBR36)=9999999.9999-RADTI,RADTE=$E(RADTE,4,7)_$E(RADTE,2,3)_"-"_+RACN0,RACANC=$S($D(^RA(72,"AA",RAPROCIT,0,+$P(RACN0,"^",3))):1,1:0)
 S RAPRCNDE=$G(^RAMIS(71,+RAPROC,0)),RACPT=+$P(RAPRCNDE,U,9),RACPTNDE=$$NAMCODE^RACPTMSC(RACPT,DT)
 ;RA*5*82 RAEXEDT= Override the EXM conditions if Case edited
 ;I $G(RAEXMDUN)=1,'$G(RAEXEDT),$P(RACN0,U,30)'="",'$G(RATELE) Q  ;last chance to stop exm'd msg if it's already been sent RA*5*84 Is TELERAD ?? 
 ;Compile 'PID' Segment
 K VA,VADM,VAERR,RAVADM S DFN=RADFN D DEM^VADPT I VADM(1)']"" S HLP("ERRTEXT")="Invalid Patient Identifier" G EXIT
 S RAVADM(3)=$S($E(+VADM(3),6,7)="00":"",1:+VADM(3)) ; NOTE: Check
 ; for an inexact date of birth.  If inexact, pass null for DOB in
 ; the 'PID' segment.  Some COTS systems can't handle inexact DOB's.
 I HL("VER")']"2.2" D
 .S HLA("HLS",1)="PID"_HLFS_HLFS_$G(VA("PID"))_HLFS_$$M11^HLFNC(RADFN)_HLFS_HLFS_$$HLNAME^HLFNC(VADM(1))_HLFS_HLFS_$$HLDATE^HLFNC(RAVADM(3))_HLFS_$S(VADM(5)]"":$S("MF"[$P(VADM(5),"^"):$P(VADM(5),"^"),1:"O"),1:"U")
 .S:$P(VADM(2),"^")]"" $P(HLA("HLS",1),HLFS,20)=$P(VADM(2),"^")
 I HL("VER")]"2.2" S HLA("HLS",1)=$$EN^VAFHLPID(DFN,"2,3,5,7,8,19,20")
 K RAVADM
 ;Compile 'ORC' Segment
 S X0="" ;if exam-set or print-set, store parent name if order exists
 I $P(RACN0,U,25) S X0=$P(RACN0,U,11),X0=$P($G(^RAO(75.1,+X0,0)),U,2),X0=$P($G(^RAMIS(71,+X0,0)),U),X0=$S(X0="":"ORIGINAL ORDER PURGED",1:X0),X0=$S($P(RACN0,U,25)=1:"EXAM",1:"PRINT")_"SET: "_X0
 ; BNT - Added ORC4 Placer Group Number for Printset identification.
 ; ORC4 is a combination of SSN with the order inverted date/time.
 S RAORC4="" I $P($G(RACN0),U,25)=2 D
 . S:$P(VADM(2),"^")]"" RAORC4=$P(VADM(2),"^")
 . S RAORC4=$G(RAORC4)_RADTI
 S HLA("HLS",2)="ORC"_HLFS_$S(RACANC:"CA",$G(RAEXMDUN)=1:"XO",1:"NW")_HLFS_HLFS_HLFS_RAORC4_HLFS_$S(RACANC:"CA",$G(RAEXMDUN)=1:"CM",1:"IP")_HLFS_HLFS_HLFS_X0_HLFS_HLDT1
 K RAORC4
 ;Compile 'OBR' Segment
 S RAOBR4=$P(RACPTNDE,U)_$E(HLECH)_$P(RACPTNDE,U,2)_$E(HLECH)_"C4"_$E(HLECH)_+RAPROC_$E(HLECH)_$P(RAPRCNDE,U)_$E(HLECH)_"99RAP"
 ; Replace above with following when Imaging can cope with ESC chars
 ; S RAOBR4=$P(RACPTNDE,U)_$E(HLECH)_$$ESCAPE^RAHLRU($P(RACPTNDE,U,2))_$E(HLECH)_"C4"_$E(HLECH)_+RAPROC_$E(HLECH)_$$ESCAPE^RAHLRU($P(RAPRCNDE,U))_$E(HLECH)_"99RAP"
 I $P(RACPTNDE,U)']"" S $P(RAOBR4,$E(HLECH),1,3)=$P(RAOBR4,$E(HLECH),4,5)_$E(HLECH)_"LOCAL"
 ;OBR-7 change: from HLDT1 to $$HLDATE^HLFNC(9999999.9999-RADTI) d/t of registration
 ;Driver of change: CareStream Health PACS. Agfa requires a timestamp down to the second
 ;POC @ Boston is Maureen Sullivan
 ;S HLA("HLS",3)="OBR"_HLFS_HLFS_RADTE_HLFS_RADTI_"-"_RACNI_$E(HLECH)_RADTE_$E(HLECH)_"L"_HLFS_RAOBR4_HLFS_HLFS_HLFS_$$HLDATE^HLFNC(9999999.9999-RADTI)
 ;
 ;07/28/2008 BAY/KAM RA*5*94 Remove GMT offset from OBR-7 in next line
 S HLA("HLS",3)="OBR"_HLFS_HLFS_RADTE_HLFS_RADTI_"-"_RACNI_$E(HLECH)_RADTE_$E(HLECH)_"L"_HLFS_RAOBR4_HLFS_HLFS_HLFS_$P($$HLDATE^HLFNC(9999999.9999-RADTI),"-",1)
 ;
 S HLA("HLS",3)=HLA("HLS",3)_HLFS_HLQ_HLFS_HLQ_HLFS_HLFS_HLFS_HLFS_HLFS_HLQ_HLFS_HLFS
 S RAPRV=$$GET1^DIQ(200,+$P(RACN0,"^",14),.01)
 S HLA("HLS",3)=HLA("HLS",3)_$S(RAPRV]"":+$P(RACN0,"^",14)_$E(HLECH)_$$HLNAME^HLFNC(RAPRV),1:"")
 ;
 N RACN00,RA20 S RACN00=$G(^RADPT(RADFN,"DT",RADTI,0))
 ;Seg's fld 20 = pce 21 --> ien file #79.1~name of img loc~stn #~stn name
 S RA20=+$G(^RA(79.1,+$P(RACN00,U,4),0))
 S $P(HLA("HLS",3),HLFS,21)=$P(RACN00,U,4)_$E(HLECH)_$P($G(^SC(RA20,0)),U)_$E(HLECH)_$P(RACN00,U,3)_$E(HLECH)_$P($G(^DIC(4,+$P(RACN00,U,3),0)),U)
 S $P(HLA("HLS",3),HLFS,21)=$P(HLA("HLS",3),HLFS,21)
 ; Replace above with following when Imaging can cope with ESC chars
 ; S $P(HLA("HLS",3),HLFS,21)=$$ESCAPE^RAHLRU($P(HLA("HLS",3),HLFS,21))
 ;Seg's fld 21 = pce 22 --> abbrv I-type~Img type name
 S RA20=$G(^RA(79.2,+$P(RACN00,U,2),0))
 S $P(HLA("HLS",3),HLFS,22)=$P(RA20,U,3)_$E(HLECH)_$P(RA20,U)
 S $P(HLA("HLS",3),HLFS,22)=$P(HLA("HLS",3),HLFS,22)
 ; Replace above with following when Imaging can cope with ESC chars
 ; S $P(HLA("HLS",3),HLFS,22)=$$ESCAPE^RAHLRU($P(HLA("HLS",3),HLFS,22))
 ;
 S $P(HLA("HLS",3),HLFS,23)=HLDT1,$P(HLA("HLS",3),HLFS,19)=$S($D(^DIC(42,+$P(RACN0,"^",6),0)):$P(^(0),"^"),$D(^SC(+$P(RACN0,"^",8),0)):$P(^(0),"^"),1:"Unknown")
 ;
 ; OBR-31.2 = Reason for Study P75
 S $P(HLA("HLS",3),HLFS,32)=$E(HLECH)_$$ESCAPE^RAHLRU($P($G(^RAO(75.1,+$P(RACN0,"^",11),.1)),U))
 ;
 ; OBR-36 = Exam Date/Time
 S $P(HLA("HLS",3),HLFS,37)=$$FMTHL7^XLFDT(OBR36)
 ;
 I 'RACANC S X=$P($G(^RAO(75.1,+$P(RACN0,"^",11),0)),"^",6),$P(HLA("HLS",3),HLFS,28)=$E(HLECH)_$E(HLECH)_$E(HLECH)_$E(HLECH)_$E(HLECH)_$TR(X,"129","SAR")
 ; if long str, break so 2nd str begins with separator to avoid abend
 I $L(HLA("HLS",3))>245 N RAPART,RA1 S RA1=HLA("HLS",3) F RAPART=5:1:15 S RAPART(1)=$P(RA1,HLFS,1,RAPART),RAPART(2)=$P(RA1,HLFS,RAPART+1,99) Q:$L(RAPART(1))<245&($L(RAPART(2))<245)&($P(RAPART(2),HLFS)="")
 I $D(RAPART) K:RAPART=15 RAPART ;if RAPART reaches 15, then something's wrong so kill RAPART to allow abend due "string too long"
 I $D(RAPART) S HLA("HLS",3)=$P(RAPART(1),HLFS)_HLFS,HLA("HLS",3,1)=$P(RAPART(1),HLFS,2,99)_HLFS,HLA("HLS",3,2)=RAPART(2) K RAPART,RA1
OBXPRC ;Compile 'OBX' Segment for Procedure
 S RAN=4 D OBXPRC^RAHLRU
OBXMOD ;Compile 'OBX' Segment for two types of Modifiers
 S RAN=5 D OBXMOD^RAHLRU
OBXHIST ;Compile 'OBX' Segment for Clinical History and Reason for Study (added as prefix).
 I $D(^RAO(75.1,+$P(RACN0,"^",11),.1)) D
 .S RAN=RAN+1,HLA("HLS",RAN)="OBX"_HLFS_HLFS_"TX"_HLFS_"H"_$E(HLECH)_"HISTORY"_$E(HLECH)_"L"_HLFS_HLFS_"Reason for Study: "_$$ESCAPE^RAHLRU($P($G(^RAO(75.1,+$P(RACN0,"^",11),.1)),U)) D OBX11^RAHLRU
 I $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",0)) S RAN=RAN+1,HLA("HLS",RAN)="OBX"_HLFS_HLFS_"TX"_HLFS_"H"_$E(HLECH)_"HISTORY"_$E(HLECH)_"L"_HLFS_HLFS_" " D OBX11^RAHLRU  ;blank line
 K ^UTILITY($J,"W") S DIWF="",DIWR=80,DIWL=1 F RAI=0:0 S RAI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H",RAI)) Q:'RAI  I $D(^(RAI,0)) S X=^(0) D ^DIWP
 F RAI=0:0 S RAI=$O(^UTILITY($J,"W",DIWL,RAI)) Q:'RAI  I $D(^(RAI,0)) S RAN=RAN+1,HLA("HLS",RAN)="OBX"_HLFS_HLFS_"TX"_HLFS_"H"_$E(HLECH)_"HISTORY"_$E(HLECH)_"L"_HLFS_HLFS_^(0) D OBX11^RAHLRU
ALLER ;Compile 'OBX' Segment for Allergies
 S DFN=RADFN D ALLERGY^RADEM S X="" I $D(GMRAL) S RAI=0 F  S RAI=$O(PI(RAI)) Q:RAI'>0  S X0=PI(RAI) I X0]"" Q:($L(X)+$L(X0))>200  S X=X_X0_", "
 I $L(X) S RAN=RAN+1,HLA("HLS",RAN)="OBX"_HLFS_HLFS_"TX"_HLFS_"A"_$E(HLECH)_"ALLERGIES"_$E(HLECH)_"L"_HLFS_HLFS_X D OBX11^RAHLRU
OBXTCM ;Compile 'OBX' Segment for Tech Comment
 D OBXTCM^RAHLRU
EXIT ; set HL7 message type & return to protocol
 K ^UTILITY($J,"W")
 S HL("MTN")="ORM"
 N HLEID,HLARYTYP,HLFORMAT,HLMTIEN,HLP
 S HLEID=EID,HLARYTYP="LM",HLFORMAT=1,HLMTIEN="",HLP("PRIORITY")="I"
 D:$D(RASSSX(HLEID)) GETHLP^RAHLRS1(HLEID,.HLP,"RASSSX")
 D:$D(RASSSX1(HLEID)) GETHLP^RAHLRS1(HLEID,.HLP,"RASSSX1")
 D GENERATE^HLMA(HLEID,HLARYTYP,HLFORMAT,.HLRESLT,HLMTIEN,.HLP)
 Q
Q ;Entry Point to Process an ORR Message (Just a Quit Since No Processing is Required)
 Q
INIT ; initialize HL7 variables
 D NOW^%DTC S HLDT=%,HLDT1=$$HLDATE^HLFNC(%)
 ;Note: HLDT1 is used for HL7 fields: ORC-9 & OBR-22
 Q:'$G(RAEID)  S EID=RAEID
 S HL="HLS(""HLS"")",INT=1
 D INIT^HLFNC2(EID,.HL,INT)
 Q:'$D(HL("Q"))  ;no server application defined
 S HLQ=HL("Q")
 S HLECH=HL("ECH")
 S HLFS=HL("FS")
 S HLCS=$E(HL("ECH"))
 S HLSCS=$E(HL("ECH"),4)
 S HLREP=$E(HL("ECH"),2)
 Q
