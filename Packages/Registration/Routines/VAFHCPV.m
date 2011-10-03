VAFHCPV ;ALB/CM OUTPATIENT PV1 SEGMENT ; 22 Jan 2002 10:28 AM
 ;;5.3;Registration;**91,151,298,494,573**;Aug 13, 1993
 ;
 ;This routine generates the Outpatient PV1 segment
 ;for the Philly project
 ;
 ;07/12/00 ACS - Added Facility and Suffix to sequence 39
 ;
OPV1(DFN,EVENT,EVDT,VPTR,PSTR,PNUM) ;
 ;
 ;B
 ;DFN - Patient File
 ;EVENT - event number from pivot file
 ;EVDT - event date/time in FileMan format
 ;VPTR - variable pointer
 ;PSTSR - string of fields (if null - required fields, if "A" - supported
 ;fields, or string of fields separated by commas")
 ;PNUM - ID # - always 1 (optional)
 ;
 N RESULT
 S RESULT="PV1"_HLFS_HLFS_"O"
 I '$D(DFN)!('$D(EVENT))!('$D(EVDT))!('$D(VPTR)) Q RESULT
 I $D(EVENT) I EVENT'="" S NODE=$$PIVX^VAFHPIVT(EVENT,DFN,EVDT)
 I $D(EVENT) I EVENT="" K EVENT
 I '$D(EVENT) S NODE=$$PIVNW^VAFHPIVT(DFN,EVDT,2,VPTR),EVENT=$P(NODE,":")
 I EVENT<1 Q RESULT
 S NODE=$P(NODE,":",2)
 I NODE="" S REMOVED="Y"
 ;
EN ;
 N PV1,EVTY,LOC,LOOP,HLD,PIVOT,QUOT
 S QUOT=""""""
 I '$D(PNUM) S PNUM=1
 I $G(PSTR)="A" S PSTR=",2,3,7,10,44,45,50,"
 I $G(PSTR)'="" S PSTR=","_PSTR_","
 I $G(PSTR)="" S PSTR=""
 I +PSTR=-1 Q RESULT
 I $D(REMOVED) S $P(PV1,HLFS,50)=+EVENT,$P(PV1,HLFS,2)="O",$P(PV1,HLFS,1)=PNUM,PV1="PV1"_HLFS_PV1 K REMOVED Q PV1
 S (PIVOT,PV1)="",EVTY="O",LOOP=0
 ; Empty PV1 segment:
 S $P(PV1,HLFS,2)="O"
 ;
 ;F  S LOOP=LOOP+1,HLD=$P(PSTR,",",LOOP) Q:HLD=""  D
 ;.I HLD=2 S $P(PV1,HLFS,2)=EVTY Q
 ;.I HLD=3 S $P(PV1,HLFS,3)=$$CLINIC(NODE) Q
 ;.I HLD=7 S $P(PV1,HLFS,7)=$$OUTPRO(NODE) Q
 ;.;patient type for v2.3
 ;.I HLD=18 DO  Q
 ;. .I +$G(^DPT(DFN,"TYPE")) DO
 ;. . .S $P(RESULT,HLFS,18)=$P($G(^DG(391,+^("TYPE"),0)),"^",1)
 ;. .E  S $P(RESULT,HLFS,18)=HLQ
 ;.I HLD=44 S $P(PV1,HLFS,44)=$$HLDATE^HLFNC(EVDT) Q
 ;.I HLD=50 S $P(PV1,HLFS,50)=EVENT Q
 ;
 I PSTR[",3," S $P(PV1,HLFS,3)=$$CLINIC(NODE)
 I PSTR[",7," S $P(PV1,HLFS,7)=$$OUTPRO(NODE)
 ;.;patient type for v2.3
 I PSTR[18 DO
 .I +$G(^DPT(DFN,"TYPE")) DO
 . .S $P(PV1,HLFS,18)=$P($G(^DG(391,+^("TYPE"),0)),"^",1)
 . .E  S $P(PV1,HLFS,18)=HLQ
 ;
 ; facility and suffix
 ;
 I PSTR[39  D
 . N VAFACSUF,VAMEDCTR,GLOB
 . S GLOB="^"_$P(VPTR,";",2)_+VPTR
 . ;
 . ; If variable pointer is for patient file:
 . I GLOB["DPT(" D
 . . N PATNODE S PATNODE=""
 . . I '$D(^DPT(DFN)) Q
 . . F  S PATNODE=$O(^DPT(DFN,"DIS",PATNODE)) D  Q:PATNODE=""
 . . . N PATDATA,VAFILE
 . . . Q:PATNODE=""
 . . . S PATDATA=$G(^DPT(DFN,"DIS",PATNODE,0))
 . . . ; Spin through multiple events and get division pointer
 . . . I EVDT=$P(PATDATA,"^",1) D  Q:VAFILE="MATCH"
 . . . . S VAMEDCTR=$P(PATDATA,"^",4) I VAMEDCTR="" S VAFILE="" Q
 . . . . ; get facility/suffix from medical center div file
 . . . . S VAFACSUF=$P($G(^DG(40.8,VAMEDCTR,0)),"^",2)
 . . . . ; move data into the PV1 segment
 . . . . S $P(PV1,HLFS,39)=$S(VAFACSUF]"":VAFACSUF,1:HLQ)
 . . . . S VAFILE="MATCH",PATNODE=""
 . . . . Q
 . . . Q
 . . Q
 . ; If variable pointer is for outpatient encounter file:
 . I GLOB["^SCE(" D
 . . N VAFIEN,ENCDATA,ENCDATE
 . . ; get encounter date and medical center division
 . . S VAFIEN=+VPTR Q:VAFIEN=""
 . . I '$D(^SCE(VAFIEN)) Q
 . . S ENCDATA=$G(^SCE(VAFIEN,0))
 . . S ENCDATE=$P(ENCDATA,"^",1) Q:ENCDATE=""
 . . S VAMEDCTR=$P(ENCDATA,"^",11) Q:VAMEDCTR=""
 . . ; call below returns: inst pointer^inst name^facility w/suffix
 . . S VAFACSUF=$$SITE^VASITE(ENCDATE,VAMEDCTR)
 . . S VAFACSUF=$P(VAFACSUF,"^",3)
 . . ; move data into the PV1 segment
 . . S $P(PV1,HLFS,39)=$S(VAFACSUF]"":VAFACSUF,1:HLQ)
 . . Q
 . ;
 . ; If variable pointer is for patient movement file:
 . I GLOB["^DGPM(" D
 . . N VAFIEN,VAFDATE,VAWARD
 . . ; get movement date and medical center division
 . . S VAFIEN=+VPTR Q:VAFIEN=""
 . . I '$D(^DGPM(VAFIEN)) Q
 . . S VAFDATE=$P($G(^DGPM(VAFIEN,0)),"^",1) Q:VAFDATE=""
 . . S VAWARD=$P($G(^DGPM(VAFIEN,0)),"^",6) Q:VAWARD=""
 . . S VAMEDCTR=$P($G(^DIC(42,VAWARD,0)),"^",11) Q:VAMEDCTR=""
 . . ; call below returns: inst pointer^inst name^facility w/suffix
 . . S VAFACSUF=$$SITE^VASITE(VAFDATE,VAMEDCTR)
 . . S VAFACSUF=$P(VAFACSUF,"^",3)
 . . ; move data into the PV1 segment
 . . S $P(PV1,HLFS,39)=$S(VAFACSUF]"":VAFACSUF,1:HLQ)
 . . Q
 . Q
 ;
 I PSTR[44 S $P(PV1,HLFS,44)=$$HLDATE^HLFNC(EVDT)
 I PSTR[50 S $P(PV1,HLFS,50)=EVENT
 ;
 I PV1?1"^"."^" Q RESULT
 S $P(PV1,HLFS,1)=PNUM,PV1="PV1"_HLFS_PV1
 K NODE,QUOT
 Q PV1
 ;
CLINIC(ZNODE) ;
 ;Get clinic for appointments and add/edit stop codes
 ;
 N HPTR,HLOC,GLOB,LOC
 ;
 ;HPTR=fifth piece in pivot file - Variable pointer
 ;
 S (HLOC,LOC)="",HPTR=$P(ZNODE,"^",5),GLOB="^"_$P(HPTR,";",2)_+HPTR_")"
 I $E(GLOB,1,5)="^DPT(" D
 .;Patient file, appointment hasn't gotten to outpatient encounter file
 .S HLOC=$P($G(@GLOB@("S",$P(NODE,"^"),0)),"^")
 ;
 I $E(GLOB,1,5)="^SCE(" D
 .N VAENC0
 .;Outpatient Encounter file
 .S HLOC=$$SCE^DGSDU(+$P(GLOB,"^SCE(",2),4,0)
 ;
 I HLOC="" Q QUOT
 ;HLOC is IEN of Hospital Location file
 S LOC=$P($G(^SC(HLOC,0)),"^")
 I LOC="" S LOC=QUOT
 Q LOC
 ;
OUTPRO(ZNODE) ;
 ;
 N OUTPTR,OPRV,OPTR,FILE,PTR
 ;
 ;OUTPTR=fifth piece in pivot file - variable pointer
 ;
 S OUTPTR=$P(ZNODE,"^",5),OPTR=+OUTPTR,FILE=$P(OUTPTR,";",2)
 I OPTR=""!(FILE'="SCE(") Q ""
 ;
 ;get primary provider
 S OPRV=$$GETPRO(OPTR) I OPRV DO  Q OPRV
 . I $P($G(^VA(200,OPRV,0)),"^")]"" DO
 . . N DGNAME S DGNAME("FILE")=200,DGNAME("IENS")=OPRV,DGNAME("FIELD")=.01
 . . S OPRV=OPRV_$E(HLECH)_$$HLNAME^XLFNAME(.DGNAME,"S",$E($G(HLECH)))
 . E  S OPRV=QUOT
 ;
 Q QUOT
 ;
GETPRO(OPTR) ;get first primary provider Returns OPRV or 0
 N VAENC0,VAEPRV,VAP
 S VAENC0=$$SCE^DGSDU(OPTR)
 I OPTR,+VAENC0,$$DATE^SCDXUTL(+VAENC0)
 E  Q 0
 ;
 S OPRV=0
 D GETPRV^SDOE(OPTR,"VAEPRV")
 S VAP=0 F  S VAP=$O(VAEPRV(VAP)) Q:'VAP  I $P(VAEPRV(VAP),"^",4)="P" S OPRV=+VAEPRV(VAP)_"^P" Q
 Q +OPRV
