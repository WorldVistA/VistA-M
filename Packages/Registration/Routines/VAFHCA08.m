VAFHCA08 ;ALB/CM OUTPATIENT A08 GENERATOR ;4/5/95
 ;;5.3;Registration;**91**;Jun 06, 1996
 ;
 ;This function will generator an A08 HL7 message for an outpatient
 ;event.  If the generation is successful, 0 will be returned.
 ;If for any reason is not successful, -1 and error message will be
 ;returned.
 ;
 ;Two entry points have been provided.  The first is for use by the
 ;Update event outside of an outpatient event.  The second is for use
 ;by the outpatient event.  The second will return 0^COUNT, where COUNT
 ;is the last value entered.
 ;
UP(DFN,EVENT,NODE,COUNT,GBL,PISTR,ZSTR,PSTR,XSTR,PDNUM,ZNUM,PNUM,XNUM) ;
 ;
 ;DFN - Patient file DFN
 ;EVENT - Event number from pivot file
 ;NODE - Zero Node of pivot file entry
 ;COUNT - Subscript to start global/array storage at
 ;GBL - global or array to store segments
 ;PISTR - fields to be included in PID (null - required fields,
 ;or string of fields seperated by commas)
 ;ZSTR - fields to be included in ZPD (null - required fields,
 ;or string of fields seperated by commas)
 ;PSTR - fields to be included in OPV1
 ;(if null - required fields, if "A" - supported
 ;fields, or string of fields seperated by commas")
 ;XSTR - fields to be included in ODG1
 ;(if null - required fields, if "A" - supported
 ;fields, or string of fields seperated by commas")
 ;PDNUM - ID # for PID (optional)
 ;ZNUM - ID # for ZPD (optional)
 ;PNUM - ID # for OPV1 (optional)
 ;XNUM - ID # for ODG1 (optional)
 ;
 ;Be sure to have HLENTRY defined before making this call.
 ;                HL("SAN") v1.6 from init^hlfn2
 ;It should be equal to the HL7 NON-DHCP APPLICATION PARAMETER name
 ;This is only necessary if passing "A" for the fields.
 ;
 ;As well as all variables defined in INIT^HLFNC2
 ;
 I '$D(DFN)!'$D(EVENT)!'$D(NODE)!'$D(GBL) Q "-1^MISSING PARAMETERS"
 I $D(HL)=1 Q "-1^"_HL ;             this to insure init^hlfnc2 called
 I '$D(HL) Q "-1^ No HL Array"
 D SET
 S UPFLG="",EVDT=$P(NODE,"^"),VPTR=$P(NODE,"^",5)
 I '$D(COUNT)!(+COUNT<1) S COUNT=1
 ;S @GBL@(COUNT)=$$MSH^HLFNC1("ADT"_$E(HL("ECH"))_"A08"),COUNT=COUNT+1
 S FLG="05" ;event is new flag
 G EN
 ;
OA08(DFN,EVENT,EVDT,VPTR,PISTR,ZSTR,PSTR,XSTR,PDNUM,ZNUM,PNUM,XNUM) ;
 ;
 ;DFN - Patient file DFN
 ;EVENT - Event number from pivot file
 ;EVDT - event date/time FileMan format
 ;VPTR - variable pointer
 ;PISTR - fields to be included in PID (null - required fields,
 ;or string of fields seperated by commas)
 ;ZSTR - fields to be included in ZPD (null - required fields,
 ;or string of fields seperated by commas)
 ;PSTR - fields to be included in OPV1
 ;(if null - required fields, if "A" - supported
 ;fields, or string of fields seperated by commas")
 ;XSTR - fields to be included in ODG1
 ;(if null - required fields, if "A" - supported
 ;fields, or string of fields seperated by commas")
 ;PDNUM - ID # for PID (optional)
 ;ZNUM - ID # for ZPD (optional)
 ;PNUM - ID # for OPV1 (optional)
 ;XNUM - ID # for ODG1 (optional)
 ;
 ;
 I '$D(DFN)&('$D(EVENT))&('$D(EVDT))!('$D(VPTR)) Q "-1^Missing Parameters, Unable to generate A08 Message"
 I '$D(DFN) Q "-1^No patient selected, Unable to generate A08 Message"
 I DFN="" Q "-1^No patient selected, Unable to generate A08 Message"
 I $D(EVENT) I EVENT'="" S NODE=$$PIVX^VAFHPIVT(EVENT,DFN,EVDT)
 I $D(EVENT) I EVENT="" K EVENT
 D SET
 I '$D(EVENT) S NODE=$$PIVNW^VAFHPIVT(DFN,EVDT,2,VPTR),EVENT=$P(NODE,":")
 I EVENT<1 Q "-1^Bad Event Number, Unable to generate A08 Message"
 S NODE=$P(NODE,":",2)
 ; hlsdata should not be defined in 1.6 so this should always use hla()
 S GBL=$G(HLSDATA) I GBL']"" S GBL="HLA(""HLS"")"
 S COUNT=1
 S (HLENTRY,HLNDAP)="PIMS HL7" DO  I $D(HL)=1 G EXIT
 . K HL D INIT^HLFNC2("VAFH A08",.HL) ;           ;  only for oa08 entry
 ;call to determine old or new
 S FLG="05" ;NEW
 N LAST
 S LAST=$$LTD^VAFHUTL(DFN)
 I $P(LAST,"^")>EVDT S FLG="04" ;OLD
 ;
EN ;
 S EVN=$$EVN^VAFHLEVN("A08",FLG)
 I +EVN=-1 S HLERR="-1^UNABLE TO GENERATE EVN SEGMENT" G EXIT
 S PID=$$EN^VAFHLPID(DFN,PISTR)
 S ZPD=$$EN^VAFHLZPD(DFN,ZSTR)
 I $G(^DPT(DFN,.1))]"",$D(UPFLG) DO  ;       if inpatient get inpat pv1
 . S OPV1=$$EN^VAFHAPV1(DFN,$$NOW^XLFDT(),",2,3,7,8,10,19,44,45",,EVENT)
 E  S OPV1=$$OUT^VAFHLPV1(DFN,EVENT,EVDT,VPTR,PSTR,PNUM)
 ;
 I +OPV1=-1 S HLERR="-1^UNABLE TO GENERATE PV1 SEGMENT" G EXIT
 I $D(XSTR) S ODG1=$$OUT^VAFHLDG1(DFN,EVENT,EVDT,VPTR,XSTR,XNUM)
 S @GBL@(COUNT)=EVN,COUNT=COUNT+1
 S @GBL@(COUNT)=PID M @GBL@(COUNT)=VAPID S COUNT=COUNT+1
 S @GBL@(COUNT)=ZPD,COUNT=COUNT+1
 ; CHANGE BECAUSE PHILLY WANTS "T"
 I $P(OPV1,HLFS,3)="" S $P(OPV1,HLFS,3)="T"
 S @GBL@(COUNT)=OPV1
 I $D(XSTR) I +ODG1'=-1 S COUNT=COUNT+1,@GBL@(COUNT)=ODG1
 I '$D(UPFLG) S HLMTN="ADT" DO  ;            upflag set on EN entry only
 . I GBL["^TMP(" DO  Q
 . . D GENERATE^HLMA("VAFH A08","GM",1,.HLRSLT)
 . . K ^TMP("HLS",$J)
 . I GBL["HLA(" DO  Q
 . . D GENERATE^HLMA("VAFH A08","LM",1,.HLRSLT)
 . . K HLA
EXIT ;
 N TERR ;                 upflg is set from up entry, HL check is at top
 I $D(UPFLG) K UPFLG,EVN,PID,ZPD,OPV1,ODG1 Q "0^"_COUNT
 ;I $D(HLERR)!$D(HL)=1 S TERR=$G(HLERR)
 I $D(HL)=1 S TERR="-1^"_HL
 I '$D(HLERR),$D(HL)>1 S TERR=0
 I '$D(TERR) S TERR=0 ;just in case
 K VAPID,HLRSLT,NODE,EVN,PID,ZPD,OPV1,ODG1,COUNT,FLG,CNT,ERR,EGBL
 K HLSDATA,HLEVN,HLMTN,HLENTRY,HLERR,HLNDAP,EFLAG
 D KILL^HLTRANS
 Q TERR
 ;
SET ;
 I '$D(PNUM) S PNUM=1
 I '$D(PDNUM) S PDNUM=1
 I '$D(ZNUM) S ZNUM=1
 I '$D(XNUM) S XNUM=1
 Q
