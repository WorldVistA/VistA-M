RAHL24U ;HINES OIFO/GJC process & respond to query message utilities
 ;;5.0;Radiology/Nuclear Medicine;**107**;Mar 16, 1998;Build 2
 ;
 ;ROUTINE            IA #      USAGE          CUSTODIAN     
 ;     TAG
 ;----------------------------------------------------------
 ;DIC                2051      Supported      VA FileMan
 ;     $$FIND1
 ;DIQ                2056      Supported      VA FileMan
 ;     $$GET1()
 ;DIWP               10011     Supported      VA FileMan
 ;     DIWP
 ;HLOAPI             4716      Supported      VistA HL7
 ;     $$MOVESEG()
 ;     $$NEWMSG()
 ;HLOAPI1            4717      Supported      VistA HL7
 ;     $$SENDONE()
 ;MAGDRAHL           5022      Private        VistA Imaging
 ;     $$ZDS^MAGDRAHL()
 ;MAG7UFO            4845      Private        VistA Imaging
 ;     NPFON
 ;XLFDT              10103     Supported      VistA Kernel
 ;     $$FMADD()
 ;     $$FMTHL7()
 ;XLFNAME            3065      Supported      VistA Kernel
 ;     $$HLNAME()
 ;
 ;Note about variablies in symbol table:
 ; -RAMSG is an array that is dedicated to the response message   
 ;
START ; get Radiology data (RAD/NUC MED REPORTS #74 file)
 S RACONSTANT=9999999.9999,(RACNT,RADATA)=0
 ;RADTE & RAEND passed in (ztsave)...
 S (HLECH,HL("ECH"))=RAECH,(HLFS,HL("FS"))=RAFS
 S (HLQ,HL("Q"))="""""",HLCS=$E(HL("ECH"))
 S HLSCS=$E(HL("ECH"),4),(HLREP,HLRS)=$E(HL("ECH"),2)
 ;
 ;format: ^RADPT(RADFN,"DT","B",RADTE,RADTI)
 ;
 F  S RADTE=$O(^RADPT(RADFN,"DT","B",RADTE)) Q:'RADTE!(RADTE>RAEND)  D  Q:RACNT=RAQUANTITY
 .S RADTI=(RACONSTANT-RADTE) ;inverse date/time format
 .S (RACNI,RAPSET)=0 ;RAPSET = printset flag
 .F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:'RACNI  D  Q:(RACNT=RAQUANTITY)!RAPSET
 ..;
 ..;1) quit if the study has been cancelled (ORDER field set to zero)
 ..S RAY3=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) ;EXAMINATIONS SUB-FIELD
 ..Q:$P($G(^RA(72,$P(RAY3,U,3),0)),U,3)=0
 ..;
 ..;2) quit if the study does not have a report
 ..Q:$P(RAY3,U,17)=""
 ..;
 ..;3) quit if that report is not signed (req'd: REPORT STATUS = Verified)
 ..S RARPT=$P(RAY3,U,17),RARPT(0)=$G(^RARPT(RARPT,0))
 ..Q:$P(RARPT(0),U,5)'="V"
 ..;
 ..S RAY2=$G(^RADPT(RADFN,"DT",RADTI,0)) ;REGISTERED EXAMS SUB-FIELD
 ..S RACN=$P(RAY3,U),RAOIFN=+$P(RAY3,U,11),RAOIFN(0)=$G(^RAO(75.1,RAOIFN,0))
 ..; is the study part of a printset? (pset = multiple studies share the same report)
 ..S:$P(RAY3,U,25)=2 RAPSET=1
 ..;
 ..;OBX segment order: PROCEDURE, IMPRESSION TEXT, DIAGNOSTIC CODE (primary & secondary)
 ..;PROCEDURE MODIFIER, TECH COMMENTS, CPT MODIFIER & REPORT TEXT.
 ..K RAERR,RAERROR
 ..D INIT
 ..;RADATA=1 (RADATA initialized to zero) indicates we've
 ..;found at least one patient result to satisfy the query
 ..S RADATA=1
 ..D CLIENT Q:$G(RAERR)=0
 ..D BLDMSA Q:$G(RAERR)=0
 ..D BLDQAK Q:$G(RAERR)=0
 ..D BLDQPD Q:$G(RAERR)=0
 ..D BLDRCP Q:$G(RAERR)=0
 ..D BLDPID Q:$G(RAERR)=0
 ..D BLDOBR Q:$G(RAERR)=0
 ..D BLDZDS Q:$G(RAERR)=0
 ..D BLDPROC Q:$G(RAERR)=0
 ..D BLDTEXT("I") Q:$G(RAERR)=0
 ..D BLDMISC("DX") Q:$G(RAERR)=0
 ..D BLDMISC("M") Q:$G(RAERR)=0
 ..D BLDTCOM Q:$G(RAERR)=0
 ..D BLDMISC("CMOD") Q:$G(RAERR)=0
 ..D BLDTEXT("R") Q:$G(RAERR)=0
 ..D BROADCST
 ..Q
 .Q
 I $G(RADATA)'=1 D
 .D CLIENT Q:$G(RAERR)=0
 .D BLDMSA Q:$G(RAERR)=0
 .D BLDERR Q:$G(RAERR)=0
 .D BLDQAK Q:$G(RAERR)=0
 .D BLDQPD Q:$G(RAERR)=0
 .D BLDRCP Q:$G(RAERR)=0
 .D BROADCST
 .K RATXT
 .S RATXT(1)="no data found for this patient over this timeframe."
 .D ERR^RAHL24Q
 .QUIT
 S:$D(ZTQUEUED) ZTREQ="@"
 D EXIT^RAHL24Q
 Q
 ;
INIT ;initialize radiology variables
 ;--- if the site specific accession number exists use it, else build the legacy ---
 S RAQDAYCS=$S($P(RAY3,U,31)]"":$P(RAY3,U,31),1:$E(RADTE,4,7)_$E(RADTE,2,3)_"-"_+RAY3)
 ;---
 ;RAQPRC: pointer to RAD/NUC MED PROCEDURES file
 ;RAQPRC(0): zero node rad/nuc med procedure record
 ;RAQIMG: pointer to  file IMAGING TYPE file
 ;RAQIMG(0): zero node imaging type record
 ;
 S RAQPRC=+$P(RAY3,U,2),RAQPRC(0)=$G(^RAMIS(71,RAQPRC,0))
 S RAQPIMG=+$P($G(^RAMIS(71,RAQPRC,0)),U,12)
 S RAQPIMG(0)=$G(^RA(79.2,RAQPIMG,0))
 S RAQCPT=+$P(RAQPRC(0),U,9),RAQCPT(0)=$$NAMCODE^RACPTMSC(RAQCPT,DT)
 Q
 ;
CLIENT ; VistA client: build/broadcast the response to the query
 K RAERR,RAERROR,RAPARAM S RAPARAM("COUNTRY")="USA",RAPARAM("FIELD SEPARATOR")=HLFS
 S RAPARAM("ENCODING CHARACTERS")=HLECH,RAPARAM("VERSION")=2.4
 S RAPARAM("MESSAGE TYPE")="RSP",RAPARAM("EVENT")="K11"
 S RAPARAM("MESSAGE STRUCTURE")="RSP_K11",RAPARAM("PROCESSING MODE")="P"
 ;Create the new message (builds the MSH segment)
 S RAERR=$$NEWMSG^HLOAPI(.RAPARAM,.RAMSG,.RAERROR) ;Note RAERR=0 if call failed
 I RAERR=0 D
 .S RATXT(1)="$$NEWMSG^HLOAPI1 failed: Contact the national Rad/Nuc Med"
 .S RATXT(2)="development team."
 .D ERR^RAHL24Q
 .QUIT
 K RAERROR,RAPARAM
 QUIT
 ;
BLDMSA ; build the MSA segment
 K RAERR N SEG S SEG=""
 S SEG(1)="MSA"_HLFS_$S(RADATA=0:"AE",1:"AA")_HLFS_RAMSGCNTID
 S RAERR=$$MOVESEG^HLOAPI(.RAMSG,.SEG,.RAERROR) ;Note RAERR=0 if call failed
 QUIT
 ;
BLDERR ; build ERR segment
 K RAERR N SEG,X S SEG=""
 S X="no data for this patient within this timeframe"
 S SEG(1)="ERR"_HLFS_"QPD"_HLCS_HLCS_HLCS_HLSCS_X
 S RAERR=$$MOVESEG^HLOAPI(.RAMSG,.SEG,.RAERROR) ;Note RAERR=0 if call failed
 QUIT
 ;
BLDQAK ; build the QAK segment
 K RAERR N SEG S SEG=""
 S SEG(1)="QAK"_HLFS_RAQRYTAG_HLFS_$S(RADATA=0:"NF",1:"OK")_HLFS_RAMSGQRYNAME
 S RAERR=$$MOVESEG^HLOAPI(.RAMSG,.SEG,.RAERROR) ;Note RAERR=0 if call failed
 QUIT
 ;
BLDQPD ; build the QPD segment
 K RAERR N SEG,X S SEG=""
 S X="@PID.3.1.1"_HLCS_"EQ"_HLCS_RAMRN_HLCS_"AND"_HLRS_"@PID.3.5.1"_HLCS_"EQ"_HLCS_"SS"_HLCS
 S X=X_"AND"_HLRS_"@OBR.22"_HLCS_"GE"_HLCS_RABEGHL7_HLCS_"AND"_HLRS_"@OBR.22"
 S X=X_HLCS_"LE"_HLCS_RAENDHL7
 S SEG(1)="QPD"_HLFS_RAMSGQRYNAME_HLFS_RAQRYTAG_HLFS_X
 S RAERR=$$MOVESEG^HLOAPI(.RAMSG,.SEG,.RAERROR) ;Note RAERR=0 if call failed
 QUIT
 ;
BLDRCP ; build the RPC segment
 K RAERR N SEG S SEG=""
 S SEG(1)="RCP"_HLFS_RAMSGQRYNAME_HLFS_RAQUANTITY
 S RAERR=$$MOVESEG^HLOAPI(.RAMSG,.SEG,.RAERROR) ;Note RAERR=0 if call failed
 QUIT
 ;
BLDPID ; build the PID segment
 N HLA,RAPID,SEG
 D PID^RAHLRU1(RADFN) ;sets the HLA("HLS" & RAPID arrays
 D HLA2SEG
 S RAERR=$$MOVESEG^HLOAPI(.RAMSG,.SEG,.RAERROR) ;Note RAERR=0 if call failed
 QUIT
 ;
BLDOBR ; build the OBR segment
 N HLA,RAOBR,RAQPMOD,RAQTRANS,SEG
 ;get  transcriptionist data (if it exists)
 S RAQTRANS=+$G(^RARPT(RARPT,"T"))
 ;Set ID OBR-1
 S RAOBR(2)=1
 ;Placer Order Number OBR-2 mmddyy-case# -or- SSAN
 ;Filler Order Number OBR-3 mmddyy-case# -or- SSAN
 S (RAOBR(3),RAOBR(4))=RAQDAYCS
 S RAOBR(5)=$P(RAQCPT(0),U)_$E(HLECH)_$$ESCAPE^RAHLRU($P(RAQCPT(0),U,2))_$E(HLECH)_"C4"
 S RAOBR(5)=RAOBR(5)_$E(HLECH)_RAQPRC_$E(HLECH)_$$ESCAPE^RAHLRU($P(RAQPRC,U))_$E(HLECH)_"99RAP"
 ;Observation date/time OBR-7 (DATE REPORT ENTERED) 74;6
 S RAOBR(8)=$$FMTHL7^XLFDT($P(RARPT(0),U,6))
 ;Specimen Source OBR-15 75.1;125 PROCEDURE MODIFIERS (mult: 75.1125)
 ;(left & right only)
 S RAQPMOD=$$SPECSRC^RAHLRU1(+$P(RAY3,U,11))
 S:$L(RAQPMOD) RAOBR(16)=$$REPEAT^RAHLRU1($E(HLECH),4)_$E(HLECH,4)_RAQPMOD
 ;
 ;Ordering Provider OBR-16 (REQUESTING PHYSICIAN) 75.1;14
 I $P(RAOIFN(0),U,14),($$GET1^DIQ(200,$P(RAOIFN(0),U,14),.01)'="") D
 .N RAQNME S RAQNME("FILE")=200,RAQNME("IENS")=$P(RAOIFN(0),U,14)
 .S RAQNME("FIELD")=.01
 .S RAOBR(17)=$P(RAOIFN(0),U,14)_$E(HLECH)_$$HLNAME^XLFNAME(.RAQNME,"S",$E(HLECH))
 .Q
 ;
 ;Call Back Phone numbers of Ordering Provider OBR-17
 D
 .N RAI,RAM,RAX S RAM="",RAI=0
 .D NPFON^MAG7UFO("RAX",$P(RAOIFN(0),U,14))
 .F  S RAI=$O(RAX(RAI)) Q:'RAI  S RAM=RAM_$$ESCAPE^RAHLRU($G(RAX(RAI,1,1)))_$E(HLECH)_$G(RAX(RAI,2,1))_$E(HLECH)_$G(RAX(RAI,3,1))_$E(HLECH,2)
 .S:$L(RAM) RAOBR(18)=$E(RAM,1,$L(RAM)-1)
 .QUIT
 ;
 ;Placer Field 1 OBR-18 accession number: may be legacy or SSAN
 ;(mirrors OBR-2, OBR-3 & OBR-20)
 S RAOBR(19)=RAQDAYCS
 ;
 ;Placer Field two OBR-19 case number 70.03;.01
 S RAOBR(20)=RACN
 ;
 ;Filler Field 1 OBR-20 accession number: may be legacy or SSAN
 ;(mirrors OBR-2, OBR-3 & OBR-18)
 S RAOBR(21)=RAQDAYCS
 ;
 ;Filler Field 2 OBR-21
 ;Components as separated by the accent grave "`"
 ;Subcomponents by the underscore "_"
 ;Example: RAD_GENERAL RADIOLOGY`1_TD-RAD`660_SALT LAKE CITY
 S RAOBR(22)=$$OBR21^RAHLRU(HLECH,RAY2)
 ;
 ;Results Rpt/Status Chng-date/time OBR-22
 ;verified: pass VERIFIED DATE 74;7
 S RAOBR(23)=$$FMTHL7^XLFDT($P(RARPT(0),U,7))
 ;
 ;Status OBR-25 REPORT STATUS 74;5
 ;Note: treat electronically filed "EF" reports the same as verified "V" reports
 S RAOBR(26)=$S(($P(RARPT(0),U,5)="V")!($P(RARPT(0),U,5)="EF"):"F",1:"R")
 ;
 ;Parent OBR-29 70.03;25 if exam/printset find ordered parent procedure
 S:$P(RAY3,U,25) RAOBR(30)=$S($P(RAY3,U,25)=1:"Examset: ",1:"Printset: ")_$P(RAQPRC(0),U)
 ;
 ;Principal Result Interpreter OBR-32 70.03;15
 I $P(RAY3,U,15),($$GET1^DIQ(200,$P(RAY3,U,15),.01)'="") D
 .N RAQNME S RAQNME("FILE")=200,RAQNME("IENS")=$P(RAY3,U,15)
 .S RAQNME("FIELD")=.01
 .S RAOBR(33)=$P(RAY3,U,15)_$E(HLECH)_$$HLNAME^XLFNAME(.RAQNME,"S",$E(HLECH))
 .Q
 ;
 ;Assistant Result Interpreter(s)/contributors OBR-33 70.03;12
 N RACNT,RAI,RAJ S RACNT=0 ; in this instance RACNT is local to BLDOBR
 I $P(RAY3,U,12),($$GET1^DIQ(200,$P(RAY3,U,12),.01)'="") D
 .K RAQNME S RAQNME("FILE")=200,RAQNME("IENS")=$P(RAY3,U,12)
 .S RAQNME("FIELD")=.01,RACNT=RACNT+1
 .S RAOBR(34,RACNT)=$P(RAY3,U,12)_$E(HLECH)_$$HLNAME^XLFNAME(.RAQNME,"S",$E(HLECH))
 .Q
 K RAQNME F RAI="SRR","SSR" D  Q:RACNT=10  ;cardinality: 10
 .S RAJ=0
 .F  S RAJ=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,RAI,RAJ)) Q:'RAJ  D  Q:RACNT=10
 ..S RAJ(0)=+$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,RAI,RAJ,0)) Q:'RAJ(0)
 ..S RAQNME("FILE")=200,RAQNME("IENS")=RAJ(0),RAQNME("FIELD")=.01
 ..S RACNT=RACNT+1
 ..S RAOBR(34,RACNT)=RAJ(0)_$E(HLECH)_$$HLNAME^XLFNAME(.RAQNME,"S",$E(HLECH))
 ..K RAQNME
 ..Q
 .Q
 ;
 ;Transcriptionist OBR-35 74;11
 I RAQTRANS,($$GET1^DIQ(200,RAQTRANS,.01)'="") D
 .S RAQNME("FILE")=200,RAQNME("IENS")=RAQTRANS,RAQNME("FIELD")=.01
 .S RAOBR(36)=RAQTRANS_$E(HLECH)_$$HLNAME^XLFNAME(.RAQNME,"S",$E(HLECH)) K RAQNME
 .Q
 ;
 ;build the OBR segment
 D BLSEG^RAHLRU1("OBR",.RAOBR),HLA2SEG
 ;
 S RAERR=$$MOVESEG^HLOAPI(.RAMSG,.SEG,.RAERROR) ;Note RAERR=0 if call failed
 ;set RAINC to the last established Set ID value 
 S RAINC=$G(RAOBX(2))
 QUIT
 ;
BLDZDS ; build the ZDS segment ^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SIUID")
 K RAERR N RASIUID,SEG
 S RASIUID=$$GETSIUID^RAAPI(RADFN,RADTI,RACNI)
 ;if RASIUID does not exist create it...
 S:RASIUID="" RASIUID=$$STUDYUID^MAGDRAHL(RADTI,RACNI,RAQDAYCS)
 S SEG="",SEG(1)=$$ZDS^MAGDRAHL(RASIUID)
 S RAERR=$$MOVESEG^HLOAPI(.RAMSG,.SEG,.RAERROR) ;Note RAERR=0 if call failed
 QUIT
 ;
BLDMISC(RASUB) ;get data from secondary DX, CPT Modifiers & Modifiers sub-files.
 ; This function builds OBX segments. The OBX segment(s) is(are) defined by the
 ; RAOBX array.
 ;
 ; input: RASUB - "CMOD" = CPT MODIFERS; "DX" = DIAGNOSTIC CODE; "M" = MODIFIERS 
 ;        
 ;        Note: DT, HLECH, RADFN, RADTI, RACNI, RAINC, RARPT & RAY3 are assumed to exist
 ;
 ;return: Diagnostic Code/CPT Modifiers/Modifiers OBX segments
 ;
 ;if we're after Dx Code data check for Primary Dx Code data
 ;no primary Dx Code data, no Dx code data period
 K RAERR N HLA,SEG
 I RASUB="DX",($P(RAY3,U,13)="") Q  ; no Dx data...
 ;setup the necessary generic variables
 N RAIEN,RAOBX,RAQ,RAX S RAQ=0
 S RAOBX(3)=$S(RASUB="M":"TX",1:"CE")
 S:RASUB="CMOD" RAOBX(4)="C4"_$E(HLECH)_"CPT MODIFIERS"_$E(HLECH)_"L"
 S:RASUB="DX" RAOBX(4)="D"_$E(HLECH)_"DIAGNOSTIC CODE"_$E(HLECH)_"L"
 S:RASUB="M" RAOBX(4)="M"_$E(HLECH)_"MODIFIERS"_$E(HLECH)_"L"
 S RAOBX(12)=$$OBX11^RAHLRPT2(RARPT)
 ;are we after Dx Codes? if so get those codes
 I RASUB="DX",($P(RAY3,U,13)) D
 .;--- begin primary Dx code ---
 .S RAQ=RAQ+1,RAOBX(2)=RAINC+RAQ
 .S RAX=$$ESCAPE^RAHLRU($P($G(^RA(78.3,$P(RAY3,U,13),0)),U))
 .S RAOBX(6)=$P(RAY3,U,13)_$E(HLECH)_RAX_$E(HLECH)_"L"
 .D BLSEG^RAHLRU1("OBX",.RAOBX) S RAINC=RAOBX(2)
 .D HLA2SEG K HLA
 .S RAERR=$$MOVESEG^HLOAPI(.RAMSG,.SEG,.RAERROR)
 .Q
 ;--- end primary Dx code ---
 N RAIEN,RAQ,RAY,X,Y S (RAQ,RAY)=0
 S RAX=$NA(^RADPT(RADFN,"DT",RADTI,"P",RACNI,RASUB))
 F  S RAY=$O(@RAX@(RAY)) Q:'RAY  D
 .S RAIEN=+$G(@RAX@(RAY,0)) Q:'RAIEN
 .;RAIEN is an Internal Entry Number which needs to get resolved.
 .S RAQ=RAQ+1,RAOBX(2)=RAINC+RAQ ;increment Set ID
 .;note: The value returned by $$CPTMOD^RAHLRU is escaped.
 .S:RASUB="CMOD" RAOBX(6)=$$CPTMOD^RAHLRU(RAIEN,HLECH,DT)
 .;escape it...
 .S:RASUB="DX" RAOBX(6)=RAIEN_$E(HLECH)_$$ESCAPE^RAHLRU($P($G(^RA(78.3,RAIEN,0)),U))_$E(HLECH)_"L"
 .S:RASUB="M" RAOBX(6)=$$ESCAPE^RAHLRU($P($G(^RAMIS(71.2,RAIEN,0)),U))
 .D BLSEG^RAHLRU1("OBX",.RAOBX)
 .D HLA2SEG K HLA
 .S RAERR=$$MOVESEG^HLOAPI(.RAMSG,.SEG,.RAERROR)
 .Q
 S RAINC=$G(RAOBX(2))
 QUIT
 ;
BLDTEXT(RASUB) ;get IMPRESSION TEXT & REPORT TEXT.
 ; This function builds OBX segments. The OBX segment(s) is(are) defined by
 ; the RAOBX array.
 ;
 ; input: RASUB - "I" = IMPRESSION TEXT; "R" = REPORT TEXT 
 ;        
 ;        Note: DT, HLECH, RAINC & RARPT are assumed to exist
 ;
 ;return: Impression Text or Report Text OBX segment
 ;
 K RAERR N HLA,RAOBX,RAQ,RAX,RAXRX,RAY,SEG
 S RAX=$NA(^RARPT(RARPT,RASUB))
 Q:'$O(@RAX@(0))  ;no impression/report text to return
 S (RAQ,RAY)=0
 ;format text using existing FM utilities
 F  S RAY=$O(@RAX@(RAY)) Q:'RAY  D
 .S RAXRX=$G(@RAX@(RAY,0))
 .S RAOBX(3)="TX"
 .S RAOBX(4)=RASUB_$E(HLECH)_$S(RASUB="I":"IMPRESSION",1:"REPORT")_$E(HLECH)_"L"
 .S RAOBX(12)=$$OBX11^RAHLRPT2(RARPT)
 .S RAQ=RAQ+1,RAOBX(2)=RAINC+RAQ ;increment Set ID
 .S RAOBX(6)=$$ESCAPE^RAHLRU(RAXRX)
 .D BLSEG^RAHLRU1("OBX",.RAOBX)
 .D HLA2SEG K HLA
 .S RAERR=$$MOVESEG^HLOAPI(.RAMSG,.SEG,.RAERROR)
 .Q
 ;
 S RAINC=$G(RAOBX(2))
 QUIT
 ;
BLDPROC ;get exam procedure; build the OBX segment dedicated to that procedure
 ;
 ; input: none
 ;        
 ;        Note: HLECH, RAQPRC, RAQPRC(0), RARPT & RAY3 are assumed to exist
 ;
 ;return: Rad/Nuc Med Procedure OBX segment
 ;
 N HLA,RAOBX,RAX,SEG
 S (RAOBX(2),RAINC)=1 ;RAINC = Set ID value (dynamic)
 S RAOBX(3)="CE",RAOBX(4)="P"_$E(HLECH)_"PROCEDURE"_$E(HLECH)_"L"
 ;escape the procedure name (.01 field)
 S RAX=$$ESCAPE^RAHLRU($P(RAQPRC(0),U))
 S RAOBX(6)=RAQPRC_$E(HLECH)_RAX_$E(HLECH)_"L"
 S RAOBX(12)=$$OBX11^RAHLRPT2(RARPT)
 D BLSEG^RAHLRU1("OBX",.RAOBX)
 D HLA2SEG
 S RAERR=$$MOVESEG^HLOAPI(.RAMSG,.SEG,.RAERROR) ;Note RAERR=0 if call failed
 S RAINC=$G(RAOBX(2))
 QUIT
 ;
BLDTCOM ;get tech comments; build the OBX segment dedicated to those tech comments
 ;
 ; input: none
 ;        
 ;        Note: HLECH, RADFN, RADTI, RACNI & RARPT are assumed to exist
 ;
 ;return: Tech Comments OBX segment
 ;
 K RAERR N HLA,RAOBX,RAQ,RAX,RAY,SEG
 S RAOBX(3)="TX",RAOBX(4)="TCM"_$E(HLECH)_"TECH COMMENT"_$E(HLECH)_"L"
 S RAOBX(12)=$$OBX11^RAHLRPT2(RARPT)
 ;escape the procedure name
 S (RAQ,RAY)=0
 F  S RAY=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L",RAY)) Q:'RAY  D
 .S RAX=$$ESCAPE^RAHLRU($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L",RAY,"TCOM")))
 .S RAQ=RAQ+1,RAOBX(2)=RAINC+RAQ,RAOBX(6)=RAX
 .D BLSEG^RAHLRU1("OBX",.RAOBX)
 .D HLA2SEG K HLA
 .S RAERR=$$MOVESEG^HLOAPI(.RAMSG,.SEG,.RAERROR) ;Note RAERR=0 if call failed
 .Q
 S RAINC=$G(RAOBX(2))
 QUIT
 ;
BROADCST ; broadcast the response(s) to the query
 ;if calling SENDONE^HLOAPI1...
 ;RAPARAM was set when the $$NEWMSG function was called in client but this will
 ;not be an issue here.
 N RAPARAM,RAWHO
 S RAPARAM("ACCEPT ACK TYPE")="AL",RAPARAM("APP ACK TYPE")="NE"
 S RAPARAM("FAILURE RESPONSE")="FAILURE^RAHL24Q"
 S RAPARAM("QUEUE")="RA-NTP-QRY-CLIENT"
 S RAPARAM("SENDING APPLICATION")="RA-NTP-QRY-SERVER"
 S RAWHO("RECEIVING APPLICATION")="RA-NTP-QRY-CLIENT"
 ;DNS is passed as the third component in the SENDING FACILTY field
 ;of the original (query) message. The second component is the DNS
 ;Address. Now find the logical link name for this DNS Address.
 S RAWHO("FACILITY LINK IEN")=$$FIND1^DIC(870,"","M",RAMSH("SENDING FACILITY",2))
 I RAWHO("FACILITY LINK IEN")'>0 S RATXT(1)="DNS Address lookup failed." D ERR^RAHL24Q QUIT
 I '$$SENDONE^HLOAPI1(.RAMSG,.RAPARAM,.RAWHO,.RAERROR) D
 .S RATXT(1)="$$SENDONE^HLOAPI1 failed: Contact the national Rad/Nuc Med"
 .S RATXT(2)="development team."
 .D ERR^RAHL24Q
 .QUIT
 ;increment the counter tracking the number of results returned
 S RACNT=RACNT+1
 Q
 ;
HLA2SEG ;copy HLA("HLS",P) & HLA("HLS",P,Q) to SEG(R)
 K P,Q,R S (P,R)=0,SEG="",SEG(1)="xxx|"
 S P=$O(HLA("HLS",P)) Q:'P
 S R=R+1,SEG(R)=$G(HLA("HLS",P))
 S Q=0 F  S Q=$O(HLA("HLS",P,Q)) Q:'Q  D
 .S R=R+1,SEG(R)=$G(HLA("HLS",P,Q))
 .Q
 K P,Q,R
 QUIT
 ;
