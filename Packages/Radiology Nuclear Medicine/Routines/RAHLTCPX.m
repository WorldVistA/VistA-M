RAHLTCPX ;HIRMFO/RTK,RVD,GJC - Rad/Nuc Med HL7 TCP/IP Bridge;02/11/08 ; 22 Feb 2013  12:30 PM
 ;;5.0;Radiology/Nuclear Medicine;**47,114,129**;Mar 16, 1998;Build 1
 ;
 ; this is a modified copy of RAHLTCPB for HL7 v2.4
 ;
 ;Integration Agreements
 ;----------------------
 ;GENACK^HLMA1(2165); DT^XLFDT(10103) ^DPT("SSN" (10035)
 ;
EN1 ; Main entry point; Build the ^TMP("RARPT-REC" global
 ;
 N ARR,HLCS,HLDTM,HLFS,HLSCS,MSA1,PAR,RAI,RAX,RAY,RAXX,RAEXIT,RARCNT
 N RASEG,RASUB,RAHLTCPB,RANODE,RAVERF,RAESIG,RAERR,RANOSEND
 N RARRR,RACNPPP,RACKYES,RAPRSET,RAT35,RASTRE,RARE33
 D INIT,PROCESS,XIT
 Q
 ;
INIT ; -- initialize
 ;
 S RASUB=HL("MID"),RAHLTCPB=1,RACNPPP=0,RARRR="",RACKYES=0 K RAERR
 K ^TMP("RARPT-REC",$J,RASUB) ; kill storage area for new HL7 message id
 S ^TMP("RARPT-REC",$J,RASUB,"RADATE")=$$DT^XLFDT()
 S ^TMP("RARPT-REC",$J,RASUB,"VENDOR")=$G(HL("SAN"))
 S:$D(HL("ESIG")) ^TMP("RARPT-REC",$J,RASUB,"RAESIG")=HL("ESIG") ;Save off E-Sig information (if it exists)
 S:'$$GETSFLAG^RAHLRU($G(HL("SAN")),$G(HL("MTN")),$G(HL("ETN")),$G(HL("VER"))) RANOSEND=$G(HL("SAN"))
 ;
 S HLDTM=HL("DTM")
 S HLFS=HL("FS")
 S HLCS=$E(HL("ECH"))
 S HLSCS=$E(HL("ECH"),4)
 S HLREP=$E(HL("ECH"),2)
 S HLECH=HL("ECH")
 Q
 ;
PROCESS ; -- pull message text
 ;
 F  X HLNEXT Q:HLQUIT'>0!$G(RAEXIT)  D
 .I '$L(HLNODE),$L($G(HLNODE(1))) S HLNODE=HLNODE(1) K HLNODE(1) F J=2:1 Q:'$D(HLNODE(J))  S HLNODE(J-1)=HLNODE(J) K HLNODE(J)
 .Q:$P(HLNODE,HLFS)=""
 .Q:"^MSH^PID^PV1^OBR^OBX^ORC^"'[(U_$P(HLNODE,HLFS)_U)
 .K ARR,PAR M ARR(1)=HLNODE D PARSEG^RAHLRU1(.ARR,.PAR)
 .D @($P(HLNODE,HLFS))
 Q:$G(RAEXIT)
 I '$D(RASEG("PID")) S RAERR="Missing PID Segment" Q
 I '$D(RASEG("OBR")) S RAERR="Missing OBR Segment" Q
 I '$D(RASEG("OBX")) S RAERR="Missing OBX Segment" Q
 Q
 ;
MSH ;
 Q
PID ; Pick data off the 'PID' segment.
 ;Req: PID-2(Station number concatenated with dash and DFN ex: 587-1234),
 ;     PID-3(SSN), PID-4(National ICN), PID-5(Patient Name), PID-19(SSN)
 ;Opt: PID-7(Date of Birth), PID-8(Sex), PID-10(Race), PID-11(Address),
 ;     PID-13(Phone-Home), PID-14(Phone-Bus), PID-22(Ethnic Group)
 ;
 ;As a result of PID-2, PID-3, PID-4 discussions/emails with Imaging and
 ; Identity Management (IDM), the above description is what will be sent
 ; in fields PID-2 thru PID-4.  For parsing incoming ORU messages from
 ; voice recognition systems, this code will first look for the SSN in
 ; PID-3.  If that is null or not a valid SSN, the code will next look
 ; for the Station Number-DFN in PID-2.  If that is null or does not
 ; contain a valid DFN, the message will be rejected with an "Invalid
 ; Patient Identifier" reject message.
 ;
 ; get SSN from PID-3/PAR(4) if unsuccessful get DFN from PID-2/PAR(3)
 S RADFN="" S RASSNVAL=$P($G(PAR(4)),U,1) I RASSNVAL'="" S RADFN=$O(^DPT("SSN",RASSNVAL,""))
 I RADFN="" S RADFN=$P($P($G(PAR(3)),U,1),"-",2)  ;strip station number and get DFN
 I $G(RADFN)="" S RAERR="Invalid patient identifier",RAEXIT=1 Q
 I $G(RADFN)'="" S ^TMP("RARPT-REC",$J,RASUB,"RADFN")=RADFN
 ;
 ; get SSN from PID-19/PAR(20)
 I $G(PAR(20)) S RASSN=PAR(20),^TMP("RARPT-REC",$J,RASUB,"RASSN")=RASSN
 S RASEG("PID")=""
 ;.I $P(PAR(5),U,5)="NI" D  Q   ;check for valid ICN
 ;..S RAICNVAL=$P($P(PAR(5),U,1),"V",1),RADFN=$$GETDFN^MPIF001(RAICNVAL)
 ;..I $G(RADFN)<0 S RAERR="Invalid patient ICN",RAEXIT=1,RADFN="" Q
 Q
PV1 ;Ignored at this time.
 Q
ORC ; Pick data off the 'ORC' segment
 ;Opt: ORC -1   
 ;     = CN The combined result code provides a mechanism to transmit
 ;       results that are associated with two or more orders. 
 ;       This situation occurs commonly in reports when the radiologist
 ;       dictates a single report for two or more exams.
 ;   = RE Observations to follow is used to transmit patient-specific information with an order.
 ;        An order detail segment (e.g., OBR) can be followed by one or more observation RASEGments (OBX).
 ;        Any observation that can be transmitted in an ORU message can be transmitted with this mechanism.
 ;        When results are transmitted with an order, the results should immediately follow the order or orders that they support.
 S RARRR="",RASEG("ORC")=PAR(2)
 S:PAR(2)="CN" RACNPPP=RACNPPP+1,RARRR="RARPT-REC-"_RACNPPP
 Q
OBR ; Pick data off the 'OBR' segment.
 ;Req: OBR-1(set ID), OBR-2(Placer Order #), OBR-3(Filler Order #), OBR-4(Uni. Service ID)
 ;     OBR-7(Observ. Date/time), OBR-16(Ord. Provider), OBR-18(Placer Fld 1)
 ;     OBR-19(Placer Fld 2), OBR-20(Filler Fld 1), OBR-21(Filler Fld 2)
 ;     OBR-22(Rslts Rpt/Stat Chng D/T), OBR-25(Rslts Status)
 ;Opt: OBR-15(Specimen Source), OBR-17(Ord. Callback Phone #), OBR-29(Parent)
 ;     OBR-32(Prin. Rslt Interpreter), OBR-33(Asst. Rslt Interpreter), OBR-35(Transcriptionist) 
 S RASEG("OBR")=""
 I $L(RARRR) K ^TMP(RARRR,$J)  M ^TMP(RARRR,$J)=^TMP("RARPT-REC",$J) ;Merge if OBR without Report
 S:'$L(RARRR) RARRR="RARPT-REC"
 N RAX,RAX1,RAX2,RAI,RARR,RAVERF,RARSDNT,RATRANSC,ARR
 ;OBR-3/PAR(4) for v2.4: site specific accession # (SSS-DDDDDD-CCCCC)
 ;Note: if SSAN parameter switch is off format is old # (DDDDDD-CCCCC)
 D:$L(PAR(4))
 .S RALONGCN=$P(PAR(4),HLCS),^TMP(RARRR,$J,RASUB,"RALONGCN")=RALONGCN
 .I RALONGCN="" Q
 .I $L(RALONGCN,"-")=2 D  ;if old format get data from "ADC" x-ref
 ..S RADTI=$O(^RADPT("ADC",RALONGCN,RADFN,"")) Q:RADTI=""
 ..S RACNI=$O(^RADPT("ADC",RALONGCN,RADFN,RADTI,"")) Q:RACNI=""
 .;
 .;if new format & the "ADC1" x-ref exists (reg'd/b'cast under v2.4)
 .I $L(RALONGCN,"-")=3,($D(^RADPT("ADC1",RALONGCN))\10=1) D
 ..S RADTI=$O(^RADPT("ADC1",RALONGCN,RADFN,"")) Q:RADTI=""
 ..S RACNI=$O(^RADPT("ADC1",RALONGCN,RADFN,RADTI,"")) Q:RACNI=""
 .;
 .;if new format & the "ADC1" x-ref does not exist
 .;(reg'd under v2.3 & b'cast/resent under v2.4) p129
 .I $L(RALONGCN,"-")=3,($D(^RADPT("ADC1",RALONGCN))\10=0) D
 ..S RADTI=$O(^RADPT("ADC",$P(RALONGCN,"-",2,3),RADFN,"")) Q:RADTI=""
 ..S RACNI=$O(^RADPT("ADC",$P(RALONGCN,"-",2,3),RADFN,RADTI,"")) Q:RACNI=""
 .;
 .Q:RADTI=""
 .Q:RACNI=""
 .S ^TMP(RARRR,$J,RASUB,"RADTI")=RADTI
 .S ^TMP(RARRR,$J,RASUB,"RACNI")=RACNI
 I $G(RADTI)'>0 S RAERR="Invalid exam registration timestamp" D XIT Q
 I $G(RACNI)'>0 S RAERR="Invalid exam record IEN" D XIT Q
 ;OBR-25/PAR(26) STATUS: 'C'orrected, 'F'inal, or 'R'esults filed, not verified & 'VAQ' NTP releases the study back to the VA
 I '$L($G(PAR(26))) S RAERR="Missing Report Status",RAEXIT=1 Q 
 I "^C^F^R^VAQ^"'[("^"_PAR(26)_"^") S RAERR="Invalid Report Status: "_PAR(26),RAEXIT=1 Q
 S ^TMP(RARRR,$J,RASUB,"RASTAT")=PAR(26)
 G:$P(RARRR,"-",3) 112
 ;OBR-32 PAR(33) Principal Result Interpreter
 S RAVERF=+$G(PAR(33)),RAST32=$$VFIER^RAHLRU1(.RAVERF,PAR(26),"OBR-32") I 'RAST32 S RAERR=$P(RAST32,"^",2),RAEXIT=1 Q
 I '$D(^XUSEC("RA VERIFY",RAVERF)) S RAERR="PHYSICIAN has no RA VERIFY key",RAEXIT=1 Q
 D SR^RAHLRU1(RAVERF)
 I +RASTRE=-1 S RAERR=$P(RASTRE,U,2),RAEXIT=1 Q
 I RASTRE'["^S^" S RAERR="PHYSICIAN must have a STAFF classification" S RAEXIT=1 Q
 S ^TMP(RARRR,$J,RASUB,"RAVERF")=RAVERF
 S ^TMP(RARRR,$J,RASUB,"RASTAFF",1)=RAVERF,^("RAWHOCHANGE")=RAVERF ;ID #^family^given
 ;OBR-33 First Interpreter of Resident type will be the Primary Interpreting staff
 D:$L($G(PAR(34)))
 .;build an array of good assistants (active & the proper classification)
 .S RARR=0 F I=1:1:10 S RARE33=$P(PAR(34),HLREP,I) D:$L(RARE33)
 ..D SR^RAHLRU1(+RARE33) Q:+RASTRE=-1
 ..I RASTRE'["^S^",RASTRE'["^R^" Q  ;must be a staff or res.
 ..;find the first resident...
 ..I RASTRE["^R^",('($D(RARSDNT)#2)) S (RARSDNT,^TMP(RARRR,$J,RASUB,"RARESIDENT"))=+RARE33 Q
 ..I RASTRE["^R^" S ^TMP(RARRR,$J,RASUB,"RARESIDENT",I)=+RARE33 Q  ; To be stored in 70.03 field 70
 ..I RASTRE["^S^" S ^TMP(RARRR,$J,RASUB,"RASTAFF",I)=+RARE33  ;To be stored in 70.03 field 60
 ..Q
 .Q
 ;"OBR-35"  Transcriptionist
 S RATRANSC=$G(PAR(36)),RATRANSC=$P(RATRANSC,HLCS,4)
 I RATRANSC'="" S RAT35=$$VFIER^RAHLRU1(.RATRANSC,PAR(26),"OBR-35") I 'RAT35 S RAERR=$P(RAT35,"^",2),RAEXIT=1 Q
 S ^TMP(RARRR,$J,RASUB,"RATRANSCRIPT")=$S(RATRANSC]"":RATRANSC,$D(RARSDNT):RARSDNT,1:RAVERF)
 D ESIG^RAHLO3
 ;If last OBR set provider info to all OBRs
 K RAXX F I=1:1:RACNPPP S RAXX=RARRR_"-"_I D:$D(^TMP(RAXX,$J,RASUB))
 .N RAXXX M RAXXX=^TMP(RAXX,$J,RASUB),^TMP(RAXX,$J,RASUB)=^TMP(RARRR,$J,RASUB),^TMP(RAXX,$J,RASUB)=RAXXX
 ;
112 ;
 I $D(RADTI),$D(RACNI),$D(RAPRSET(RADTI,RACNI)) K RAPRSET(RADTI,RACNI),^TMP(RARRR,$J) S RACNPPP=RACNPPP-1 Q:$P(RARRR,"-",3)  M ^TMP(RARRR,$J)=^TMP("RARPT-REC-"_(RACNPPP+1),$J) K ^TMP("RARPT-REC-"_(RACNPPP+1),$J) Q
 I $D(RADTI),'$D(RAPRSET(RADTI)) D  ;Get array of printset for date...
 .N RAPRTSET,RACN,RASUB,CNT
 .K RAXX D EN2^RAUTL20(.RAXX) M:$D(RAXX) RAPRSET(RADTI)=RAXX K RAPRSET(RADTI,RACNI)
 Q
 ;
OBX ; Pick data off the 'OBX' segments
 ;Req: OBX-2(Value Type), OBX-3(Observ. ID), OBX-5(Observ. Value) 
 ;     OBX-11(Observ. Rslt. Status)
 ;
 ; OBX-2=CE:Coded Element, T:Text
 ; OBX-3=Identifier ^ Text ^ Name of Coding System ('^' is the
 ;   component separator)
 ;     P^PROCEDURE^L, I^IMPRESSION^L, D^DIAGNOSTIC CODE^L, M:MODIFIERS^L,
 ;     TCM^TECH COMMENT^L, C4^CPT MODIFIERS^L, R^REPORT^L
 ; OBX-5=data within classification (OBX-3) by Value Type (OBX-2)
 ; OBX-11=F:Final Results; C:Correction, replace final results; 
 ;        R:Rslts entered-not v'fied
 ;
 N RAX S RAOBX3=3 ;RAOBX3 is the # of required components for OBX-3
 S RASEG("OBX")="" I $G(PAR(4))']"" S RAERR="Missing Observation Identifier",RAEXIT=1 Q
 I $L(PAR(4),HLCS)'=RAOBX3 S RAERR="Observation Identifier format error",RAEXIT=1 Q
 ;verify OBX-3 by component (three components)
 ;Ex. RAOBR3(1)="P", RAOBR3(2)="PROCEDURE", RAOBR3(3)="L" always "L"
 F RAI=1:1:RAOBX3 S RAOBX3(RAI)=$P(PAR(4),HLCS,RAI)
 ;
 I RAOBX3(3)'="L" S RAERR="Observation Identifier Coding System name in error",RAEXIT=1 Q
 S RASTR=""_HLCS_"",RASTR(0)=$P(PAR(4),HLCS,1,2)
 ;RASTR(0)=identifer and text for this specific HL7 message
 ;build the identifier and text string for all possible values...
 F RAI=1:1 S RAX=$T(OBX3+RAI) Q:RAX=""  S RASTR=RASTR_$P(RAX,";",3)_HLCS_$P(RAX,";",4)_HLCS
 I RASTR'[(HLCS_RASTR(0)_HLCS) S RAERR="Observation Identifier/Text mismatch" Q
 ;verify the Observation Value OBX-5
 S RAX=$G(PAR(6)),RANODE=$S(RAOBX3(1)="D":"RADX",RAOBX3(1)="I":"RAIMP",1:"RATXT")
 S RARCNT(RAOBX3(1))=$G(RARCNT(RAOBX3(1)))+1
 I RAX["\S\"!(RAX["\R\")!(RAX["\E\")!(RAX["\T\") S RAX=$$DEESC(RAX)
 ; For DX Codes we are expecting only the # (ie, 1,2,5 etc not the text)
 ; If VR (PSCRIBE) sends text with DX Code, strip off text in next line
 ; Text only will be rejected
 I RAOBX3(1)="D" S RAX=+RAX
 S ^TMP("RARPT-REC",$J,RASUB,RANODE,RARCNT(RAOBX3(1)))=RAX
 F RAI=1:1:RACNPPP S RARRR="RARPT-REC-"_RAI S ^TMP(RARRR,$J,RASUB,RANODE,RARCNT(RAOBX3(1)))=RAX
 K RAOBX3,RASTR
 Q
XIT ;
 D ERR I RAERRCHK=1 G XIT1
 I $D(^TMP("RARPT-REC",$J)) S:'RACNPPP RACKYES=1 D EN1^RAHLO D ERR I RAERRCHK=1 G XIT1
 F RAI=1:1:RACNPPP S RARRR="RARPT-REC-"_RAI D:$D(^TMP(RARRR,$J)) 
 .K ^TMP("RARPT-REC",$J) M ^TMP("RARPT-REC",$J)=^TMP(RARRR,$J) K ^TMP(RARRR,$J)
 .S RACKYES=(RAI=RACNPPP) N I D EN1^RAHLO D ERR I RAERRCHK=1 G XIT1
XIT1 K ^TMP("RARPT-REC",$J) ; kill storage area for current HL7 message id
 F RAI=1:1:RACNPPP S RARRR="RARPT-REC-"_RAI K ^TMP(RARRR,$J)
 Q
ERR ;
 S RAERRCHK=0
 I $D(RAERR) D
 .S RAEXIT=1,RACKYES=1,RAERRCHK=1
 .D ENX^RAHLEXF(HLDTM,RASUB)
 .D GENACK
 .Q
 Q
 ;
DEESC(RASTR) ;Replace escape sequences with their field separator and escape character
 ;equivalents. (RAHLTCPX)
 ;
 ;input : RASTR=the string of characters being checked for esc sequences
 ;output: returns a string with field separator and escape characters in
 ;         place of escape sequences
 ;
 ;RAFSESC/HLFS = field separator
 ;RACSESC/$E(HLECH,1) = component separator
 ;RARSESC/$E(HLECH,2) = repetition separator
 ;RAESESC/$E(HLECH,3) = escape character
 ;RASCESC/$E(HLECH,4) = subcomponent separator
 ;
 N RAFSESC,RACSESC,RARSESC,RAESESC,RASCESC
 S RAFSESC="\F\",RACSESC="\S\",RARSESC="\R\",RAESESC="\E\",RASCESC="\T\"
 N RAYES ;escape characters present? if yes, set YES to one
 F  D  Q:'RAYES
 .S RAYES=0
 .I RASTR[RAFSESC S RASTR=$P(RASTR,RAFSESC)_HLFS_$P(RASTR,RAFSESC,2,99999),RAYES=1
 .I RASTR[RACSESC S RASTR=$P(RASTR,RACSESC)_$E(HLECH,1)_$P(RASTR,RACSESC,2,99999),RAYES=1
 .I RASTR[RARSESC S RASTR=$P(RASTR,RARSESC)_$E(HLECH,2)_$P(RASTR,RARSESC,2,99999),RAYES=1
 .I RASTR[RAESESC S RASTR=$P(RASTR,RAESESC)_$E(HLECH,3)_$P(RASTR,RAESESC,2,99999),RAYES=1
 .I RASTR[RASCESC S RASTR=$P(RASTR,RASCESC)_$E(HLECH,4)_$P(RASTR,RASCESC,2,99999),RAYES=1
 .Q
 Q RASTR
 ;
GENACK ; Compile the 'ACK' segment, generate the 'ACK' message.
 Q:'$G(RACKYES)
 N HLFORMAT,HLARYTYP,RESULT
 S MSA1="AA"
 Q:$E($G(HL("SAN")),1,3)'="RA-"  ; Don't allow non RA namespaced interfaces
 I $D(RAERR) S MSA1=$S(HL("SAN")="RA-PSCRIBE-TCP"!$G(RATELE):"AE",1:"AR")
 ; Added next line to support MedSpeak interface.  Must re-initialize
 ; FS and EC's before sending ACK.
 ;D:HL("SAN")="RA-CLIENT-TCP" INIT^HLFNC2("RA VOICE TCP SERVER RPT",.HL)
 S HLA("HLA",1)="MSA"_HL("FS")_MSA1_HL("FS")_HL("MID")_$S($D(RAERR):HL("FS")_RAERR,1:"")
 S HLEID=HL("EID"),HLEIDS=HL("EIDS"),HLARYTYP="LM",HLFORMAT=1
 K HLRESLT D GENACK^HLMA1(HLEID,HLMTIENS,HLEIDS,HLARYTYP,HLFORMAT,.RESULT)
 I $G(RESULT)="" Q  ; RTK 3/26/2008 - UNDEFINED 'RESULT' ERROR
 I +$P(RESULT,U,2) D ASTATUS^RAHLACK(RESULT,RASUB,HL("SAN")) ;ERROR in gen ACK...
 Q
 ;
OBX3 ;set the values for OBX-3.1 & OBX-3.2
 ;;P;PROCEDURE
 ;;I;IMPRESSION
 ;;D;DIAGNOSTIC CODE
 ;;M;MODIFIERS
 ;;TCM;TECH COMMENT
 ;;C4;CPT MODIFIERS
 ;;R;REPORT
