RAHLRPT1 ;HISC/GJC-Compiles HL7 'ORU' Message Type ; 4/26/01 10:40am
 ;;5.0;Radiology/Nuclear Medicine;**47**;Mar 16, 1998;Build 21
 ;
 ;Integration Agreements
 ;----------------------
 ;$$GET1^DIQ(2056); ^DIWP(10011); 
 ;$$FMTHL7^XLFDT(10103); $$HLNAME^XLFNAME(3065)
 ;
EN(RADFN,RADTI,RACNI,RAEID) ;Called from all RA RPT* event driver protocols whose
 ;HL7 version exceeds version 2.3.
 ;
 ;Input Variables (from RAHLRPT):
 ; RADFN=file 2 IEN (DFN)
 ; RADTI=file 70 Exam subrec IEN (inverse date/time of exam)
 ; RACNI=file 70 Case subrecord IEN
 ; RAEID=ien of the event driver protocol (defined in RAHLRPC)
 ;Output variables:
 ; HLA("HLS", array containing HL7 msg
 ;
 ;Note: RAOBR(n+1) = OBR 'n' because our software begins
 ;building the segment with the segment header ('OBR')
 ;
 ;new some variables...
 N %,DN,FT,I,J,PTR,X,Y
 ;initialize Rad/Nuc Med specific variables
 D INIT^RAHLR1
PID ;Compile the 'PID' segment
 D PID^RAHLRU1(RADFN)
OBR ;Compile 'OBR' Segment
 ;get pointer value to the rad/nuc med report; needed to build the OBR
 S RAZRPT=+$P(RAZXAM,U,17)
 ;get rad/nuc med report zero node & the transcriptionist (if exists)
 S RAZRPT=$G(^RARPT(RAZRPT,0)),RAZTRANS=+$G(^RARPT(+$P(RAZXAM,U,17),"T"))
 ;Set ID OBR-1
 S RAOBR(2)=1
 ;Placer Order Number OBR-2 mmddyy-case#
 ;Filler Order Number OBR-3 mmddyy-case#
 S (RAOBR(3),RAOBR(4))=RAZDAYCS
 S RAZCPT=$P(RAZPROC,U,9),RAZCPT(0)=$$NAMCODE^RACPTMSC(RAZCPT,DT)
 ;RAZCPT(0)=CPT code from file 81^short name of CPT code from file 81
 ;RAOBR(4)=CPT code #81_comp sep_CPT code short name #81_comp sep_"C4"
 ;         _comp sep_IEN file #71_comp sep_procedure name #71_comp sep_
 ;         "99RAP"
 ;
 S RAOBR(5)=$P(RAZCPT(0),U)_$E(HLECH)_$$ESCAPE^RAHLRU($P(RAZCPT(0),U,2))_$E(HLECH)_"C4"
 S RAOBR(5)=RAOBR(5)_$E(HLECH)_+$P(RAZXAM,U,2)_$E(HLECH)_$$ESCAPE^RAHLRU($P(RAZPROC,U))_$E(HLECH)_"99RAP"
 ;Observation date/time OBR-7 (DATE REPORT ENTERED) 74;6
 S RAOBR(8)=$$FMTHL7^XLFDT($P(RAZRPT,U,6))
 ;Specimen Source OBR-15 75.1;125 PROCEDURE MODIFIERS (mult: 75.1125)
 ;(left & right only)
 S RAZPMOD=$$SPECSRC^RAHLRU1(+$P(RAZXAM,U,11))
 S:$L(RAZPMOD) RAOBR(16)=$$REPEAT^RAHLRU1($E(HLECH),4)_$E(HLECH,4)_RAZPMOD
 ;
 ;Ordering Provider OBR-16 (REQUESTING PHYSICIAN) 75.1;14
 I $P(RAZORD,U,14),($$GET1^DIQ(200,$P(RAZORD,U,14),.01)'="") D
 .K RAZNME S RAZNME("FILE")=200,RAZNME("IENS")=$P(RAZORD,U,14)
 .S RAZNME("FIELD")=.01
 .S RAOBR(17)=$P(RAZORD,U,14)_$E(HLECH)_$$HLNAME^XLFNAME(.RAZNME,"S",$E(HLECH,1))
 .Q
 ;
 ;Call Back Phone numbers of Ordering Provider OBR-17
 D
 .N RAX,I,M S M="",I=0
 .D NPFON^MAG7UFO("RAX",$P(RAZORD,U,14))
 .F  S I=$O(RAX(I)) Q:'I  S M=M_$$ESCAPE^RAHLRU($G(RAX(I,1,1)))_$E(HLECH)_$G(RAX(I,2,1))_$E(HLECH)_$G(RAX(I,3,1))_$E(HLECH,2)
 .S:$L(M) RAOBR(18)=$E(M,1,$L(M)-1)
 ;
 ;Placer Field 1 OBR-18 site id-mmddyy-case# (mirrors OBR-2 & OBR-3)
 S RAOBR(19)=RAZDAYCS
 ;
 ;Placer Field 2 definition has been changed by a VistA Imaging request
 ;-> prior to 07/2007: inv. date/time of the exam concatenated to (by the
 ;  dash) the exam record IEN (Placer Fld 2 OBR-19 = Filler Fld 1 OBR-20)
 ;-> after 07/2007: case number
 ;RAZDAYCS=sss-mmddyy-case# OR mmddyy-case#
 S RAOBR(20)=$P(RAZDAYCS,"-",$L(RAZDAYCS,"-"))
 ;
 ;Filler Field 1 OBR-20 is defined as the site specific accession number:
 ;site id-mmddyy-case# Note: same value as OBR-18, OBR-2, & OBR-3
 ;(change effective 07/2007)
 S RAOBR(21)=RAZDAYCS
 ;
 ;Filler Field 2 OBR-21 (change effective 07/2007)
 ;RAZRXAM defined in INIT^RAHLR1
 S RAOBR(22)=$$OBR21^RAHLRU(HLECH,RAZRXAM)
 ;
 ;Results Rpt/Status Chng-date/time OBR-22
 ;verified: VERIFIED DATE 74;7
 ;unv'fied: DATE REPORT ENTERED 74;6
 S:$P(RAZRPT,U,5)="V" RAOBR(23)=$$FMTHL7^XLFDT($P(RAZRPT,U,7))
 S:$P(RAZRPT,U,5)'="V" RAOBR(23)=$$FMTHL7^XLFDT($P(RAZRPT,U,6))
 ;Status OBR-25 REPORT STATUS 74;5
 ;S:$D(^RARPT(+$P(RAZXAM,U,17),"ERR",1,0))#2 RAOBR(26)="C" ;corrected rt
 S:'$D(RAOBR(26))#2 RAOBR(26)=$S(($P(RAZRPT,U,5)="V")!($P(RAZRPT,U,5)="EF"):"F",1:"R")   ;"EF" reports send "F" (Final) in OBR-25
 ;Parent OBR-29 70.03;25 if exam/printset find ordered parent procedure
 I $P(RAZXAM,U,25) D  ;is this case part of an examset/printset
 .S RAOBR(30)=$S($P(RAZXAM,U,25)=1:"Examset: ",1:"Printset: ")_$P($G(^RAMIS(71,+$P(RAZORD,U,2),0)),U)
 .Q
 ;Principal Result Interpreter OBR-32 70.03;15
 I $P(RAZXAM,U,15),($$GET1^DIQ(200,$P(RAZXAM,U,15),.01)'="") D
 .K RAZNME S RAZNME("FILE")=200,RAZNME("IENS")=$P(RAZXAM,U,15)
 .S RAZNME("FIELD")=.01
 .;S RAOBR(33)=$$HLNAME^XLFNAME(.RAZNME,"S",$E(HLECH,1))
 .S RAOBR(33)=$P(RAZXAM,U,15)_$E(HLECH)_$$HLNAME^XLFNAME(.RAZNME,"S",$E(HLECH,1))
 .Q
 ;Assistant Result Interpreter(s)/contributors OBR-33 70.03;12
 N CNT,RAI,RAJ S CNT=0
 I $P(RAZXAM,U,12),($$GET1^DIQ(200,$P(RAZXAM,U,12),.01)'="") D
 .K RAZNME D INTNAM($P(RAZXAM,U,12))
 .Q
 K RAZNME F RAI="SRR","SSR" D  Q:CNT=10  ;ten or less interpreters
 .S RAJ=0
 .F  S RAJ=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,RAI,RAJ)) Q:'RAJ  S RAJ(0)=+$G(^(RAJ,0)) D  Q:CNT=10
 ..D INTNAM(RAJ(0))
 ..Q
 .Q
 ;Transcriptionist OBR-35 74;11
 I RAZTRANS,($$GET1^DIQ(200,RAZTRANS,.01)'="") D
 .S RAZNME("FILE")=200,RAZNME("IENS")=RAZTRANS,RAZNME("FIELD")=.01
 .S RAOBR(36)=RAZTRANS_$E(HLECH)_$$HLNAME^XLFNAME(.RAZNME,"S",$E(HLECH,1)) K RAZNME
 .Q
 ;
 ;build the OBR segment
 D BLSEG^RAHLRU1("OBR",.RAOBR)
 ;
 ;build the ZDS segment
 D ZDS^RAHLR1A(RADTI,RACNI,RAZDAYCS)
 ;
OBXPRC ;Compile 'OBX' Segment for Procedure
 ;RAXX = Counter in segment
 S (RAOBX(2),RAXX)=1
 S RAOBX(3)="CE",RAOBX(4)="P"_$E(HLECH)_"PROCEDURE"_$E(HLECH)_"L"
 S RAOBX(6)=$P(RAZXAM,U,2)_$E(HLECH)_$$ESCAPE^RAHLRU($P($G(^RAMIS(71,+$P(RAZXAM,U,2),0)),U))_$E(HLECH)_"L"
 S RAOBX(12)=$$OBX11^RAHLRPT2(+$P(RAZXAM,U,17))
 D BLSEG^RAHLRU1("OBX",.RAOBX) K RAOBX
 ;
OBXIMP ;Compile the 'OBX' segment for Impression Text
 S RAOBX(2)=$G(RAXX)
 I $O(^RARPT(+$P(RAZXAM,U,17),"I",0)) D
 .S RAOBX(3)="TX",RAOBX(4)="I"_$E(HLECH)_"IMPRESSION"_$E(HLECH)_"L"
 .S RAOBX(12)=$$OBX11^RAHLRPT2(+$P(RAZXAM,U,17))
 .K ^UTILITY($J,"W") S DIWF="",DIWR=75,(DIWL,RADIWL)=1
 .S RAI=0 F  S RAI=$O(^RARPT(+$P(RAZXAM,U,17),"I",RAI)) Q:'RAI  D
 ..S X=$G(^RARPT(+$P(RAZXAM,U,17),"I",RAI,0)) D ^DIWP
 ..Q
 .S (RAI,RAJ)=0 F  S RAI=$O(^UTILITY($J,"W",RADIWL,RAI)) Q:'RAI  D
 ..S RAJ=RAJ+1,RAOBX(2)=RAXX+RAJ
 ..S RAOBX(6)=$$ESCAPE^RAHLRU($G(^UTILITY($J,"W",RADIWL,RAI,0)))
 ..D BLSEG^RAHLRU1("OBX",.RAOBX)
 ..Q
 .S RAXX=$G(RAOBX(2))
 .Q
 K DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,RADIWL,RAOBX,^UTILITY($J,"W")
 ;
OBXDX ;Compile the 'OBX' segment for Diagnostic Code
 S RAOBX(2)=$G(RAXX)
 I +$P(RAZXAM,U,13) D  ;pri. Dx code exists; look for secondary Dx
 .S RAOBX(2)=RAXX+1,RAOBX(3)="CE"
 .S RAOBX(4)="D"_$E(HLECH)_"DIAGNOSTIC CODE"_$E(HLECH)_"L"
 .S RAOBX(6)=+$P(RAZXAM,U,13)_$E(HLECH)_$$ESCAPE^RAHLRU($P($G(^RA(78.3,+$P(RAZXAM,U,13),0)),U))_$E(HLECH)_"L"
 .S RAOBX(12)=$$OBX11^RAHLRPT2(+$P(RAZXAM,U,17))
 .D BLSEG^RAHLRU1("OBX",.RAOBX)
 .S RAXX=$G(RAOBX(2))
 .Q
 I $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",0)) D  ;secondaries...
 .S RAI=0,RAJ=0
 .F  S RAI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",RAI)) Q:'RAI  D
 ..S RAPTR=+$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",RAI,0))
 ..S RAFT=$P($G(^RA(78.3,RAPTR,0)),U)
 ..S RAJ=RAJ+1,RAOBX(2)=RAXX+RAJ,RAOBX(6)=RAPTR_$E(HLECH)_$$ESCAPE^RAHLRU(RAFT)_$E(HLECH)_"L"
 ..D BLSEG^RAHLRU1("OBX",.RAOBX)
 ..Q
 .S RAXX=$G(RAOBX(2))
 .Q
 K RAFT,RAOBX,RAPTR
 ;
OBXPMOD ;Compile 'OBX' segment for procedure modifiers
 S RAOBX(2)=$G(RAXX),RAJ=0
 S RAOBX(3)="TX",RAOBX(4)="M"_$E(HLECH)_"MODIFIERS"_$E(HLECH)_"L"
 S RAOBX(12)=$$OBX11^RAHLRPT2(+$P(RAZXAM,U,17)),(RAI,RAJ)=0
 F  S RAI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"M",RAI)) Q:'RAI  D
 .S RAJ=RAJ+1,RAPTR=+$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"M",RAI,0))
 .S RAOBX(2)=RAXX+RAJ
 .S RAOBX(6)=$$ESCAPE^RAHLRU($P($G(^RAMIS(71.2,RAPTR,0)),U))
 .D BLSEG^RAHLRU1("OBX",.RAOBX)
 .Q
 S RAXX=$G(RAOBX(2))
 K RAOBX,RAPTR
 ;
OBXTCOM ;Compile 'OBX' segment for tech comments
 D OBXTCOM^RAHLRPT2
 ;
OBXCPTM ;Compile 'OBX' segment for CPT modifiers
 D OBXCPTM^RAHLRPT2
 ;
OBXRPT ;Compile 'OBX' segment for Report Text
 D OBXRPT^RAHLRPT2
 ;
 ;Broadcast the HL7 message and cleanup the symbol table
 D GENERATE^RAHLRU
 Q
 ;
INTNAM(Y) ;return the name of the intepreter(s)
 ; input: Y=IEN of the record in the New Person (#200) file
 ; CNT=second level subscript is newed,initialized and checked above
 S RAZNME("FILE")=200,RAZNME("IENS")=Y,RAZNME("FIELD")=.01
 S CNT=CNT+1  ;update counter by 1
 S RAOBR(34,CNT)=Y_$E(HLECH)_$$HLNAME^XLFNAME(.RAZNME,"S",$E(HLECH,1)) K RAZNME
 Q
