VAFCCOPT ;ALB/CM/PHH/EG/GAH OUTPATIENT APPT (HL7 MESS) NIGHT JOB ; 10/18/06
 ;;5.3;Registration;**91,298,568,585,725**;Jun 06, 1996;Build 12
 ;hl7v1.6
 ;This routine will loop through the Hospital Location file "S" node
 ;and generate an HL7-v2.3 A08 message for all appointments for today
 ;that have a status of "No action taken" or "Future"
 ;the HL7 message is not batch.
 ;
 ;07/07/00 ACS - Added sequence 39 (facility+suffix) to the outpatient
 ;string of fields
 ;
 ;Check to see if sending v2.3 is on or off
EN I '$P($$SEND^VAFHUTL(),"^",2) Q
 ;
 S ERRB="^TMP($J,""ADT-ERR"","
 ;
 N STAT,X1,X2
 ;This job should be set to run after midnight daily.
 D NOW^%DTC S START=X
 S X1=START,X2=1 D C^%DTC S STOP=X K X1,X2,%H,X,%,%I
 S ENT=0,GBL="^TMP(""HLS"",$J)"
 ;
 K HL D INIT^HLFNC2("VAFC ADT-A08-SCHED SERVER",.HL)
 I $D(HL)=1 DO  QUIT
 .I $P(HL,"^",2)="Server Protocol Disabled"
 .E  S @ERRB@(1)=HL D EBULL^VAFHUTL2("","","",ERRB)
 ;
 S PSTR="2,3,7,10,18,39,44,50"
 ;
 N DGARRAY,DGCNT
 S COUNT=0
 F  S ENT=$O(^SC(ENT)) Q:(ENT="")!(ENT'?.N)  D
 .S ENT1=START
 .S DGARRAY(1)=START_";"_STOP,DGARRAY("FLDS")="1;3",DGARRAY(2)=ENT
 .S DGCNT=$$SDAPI^SDAMA301(.DGARRAY)
 .;
 .I DGCNT>0 S DFN=0 F  S DFN=$O(^TMP($J,"SDAMA301",ENT,DFN)) Q:DFN=""  D
 ..Q:'$D(^DPT(DFN,0))
 ..S ENT1=0 F  S ENT1=$O(^TMP($J,"SDAMA301",ENT,DFN,ENT1)) Q:ENT1=""!(ENT1'?.N1".".N)  D
 ...S STAT=$P($P(^TMP($J,"SDAMA301",ENT,DFN,ENT1),"^",3),";")
 ...I STAT="NT" S ERR=$$CREATE() I +ERR>0 S VPTR=$P(ERR,"^",6) D GEN
 ...I +$G(ERR)<0 S @ERRB@(1)=ERR D EBULL^VAFHUTL2("","","",ERRB)
 .I DGCNT'=0 K ^TMP($J,"SDAMA301")
 D EXIT
 Q
 ;
GEN I COUNT DO  ;first time through its been done
 . K HL D INIT^HLFNC2("VAFC ADT-A08-SCHED SERVER",.HL)
 . I $D(HL)=1 DO
 . . S @ERRB@(1)=HL D EBULL^VAFHUTL2("","","",ERRB)
 I $D(HL)=1 S ENT="ZZZZEND",ENT1=9999999,ENT2=9999999 Q
 ;
 ;
 ;Generate the following segments:
 ;EVN
 S EVN=$$EVN^VAFHLEVN("A08","05")
 I +EVN=-1 S ERR="-1^Unable to generate EVN segment" Q
 ;PID
 S VAFPID=$$EN^VAFCPID(DFN,"2,3,4,5,6,7,8,9,11,12,13,14,16,19,29,30")
 ;ZPD
 S ZPD=$$EN^VAFHLZPD(DFN,"2,3,4,5,6,7,8,9,10,11,12,13,14,15")
 ;PV1 (outpatient)
 S PV1=$$OUT^VAFHLPV1(DFN,EVENT,EVDT,VPTR,PSTR)
 I +PV1=-1 S ERR="-1^Unable to generate PV1 segment" Q
 ;
 ; no dg1 segment will be created.  No diagnosis
 ; information will be known at this stage.
 S COUNT=1
 K ^TMP("HLS",$J)
 ;
 ;
 S @GBL@(COUNT)=EVN,COUNT=COUNT+1
 MERGE @GBL@(COUNT)=VAFPID S COUNT=COUNT+1
 S @GBL@(COUNT)=ZPD,COUNT=COUNT+1
 S @GBL@(COUNT)=PV1
 ;
 D GENERATE^HLMA("VAFC ADT-A08-SCHED SERVER","GM",1,,.HLRST)
 I $L($P(HLRST,2,99)) DO
 . S @ERRB@(1)=HLRST D EBULL^VAFHUTL2("","","",ERRB)
 . S ERRCNT=$G(ERRCNT)+1
 . I $G(ERRCNT)>10 S ENT="ZZZZEND",ENT1=9999999,ENT2=9999999
 Q
 ;
EXIT K HLERR
 ;
 D KILL^HLTRANS
 K ERRCNT,VAFPID,^TMP("HLS",$J),SEQ,RESULT,MID
 K PSTR,ZPD,DG1,PID,PV1,MSH,EVN,ENT,ENT1,ENT2,DFN,START,STOP,GBL,HLSDT
 K EVDT,HLMTN,EVENT,COUNT,HLEVN,HLENTRY,ERR,VPTR,ERRB
 Q
 ;
CREATE() ;
 ;creates new entry in pivot file
 N NODE,VPTR
 S EVDT=ENT1,VPTR=DFN_";DPT("
 S NODE=$$PIVNW^VAFHPIVT(DFN,EVDT,2,VPTR)
 I +NODE=-1 Q NODE
 S EVENT=$P(NODE,":")
 Q EVENT_"^"_NODE
