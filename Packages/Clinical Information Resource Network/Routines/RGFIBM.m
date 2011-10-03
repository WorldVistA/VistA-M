RGFIBM ;ALB/CJM-SEND FACILITY INTEGRATION MESSAGE ;08/27/99
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**5,9**;30 Apr 99
 ;
SEND(DFN,LEGACY,PRIMARY,RESULTS,ERROR) ;
 ;Description:  Sends the facility integration message for this patient
 ;using routing logic based on the subscription list.
 ;
 ;Input:
 ;  DFN - ien of patient
 ;  LEGACY - station number of the legacy site
 ;  PRIMARY - station number of the primary site
 ;Output:
 ;  Function Value - 1 on success, 0 on failure
 ;  RESULTS() - results array returned by calling GENERATE^HLMA (pass by reference,optional)
 ;  ERROR - error message (pass by reference,optional)
 ;
 N HL,HLA,HLERR,HLL,HLDT,HLCD,HLINK0,HLINKIEN,HLINKP,HLINKX,HLDOM,HLECH,HLFS,HLHDR,HLINST,HLN,HLPARAM,HLQ,HLSAN,HLTYPE,HLX,RGI,ERRFOUND
 K RESULTS,ERROR
 ;
 ;
 I $G(DFN),$G(PRIMARY),$G(LEGACY) D
 .;just checking!
 E  S ERROR="MISSING PARAMETER" Q 0
 ;
 I '$$BUILD("HLA(""HLS"")",DFN,LEGACY,PRIMARY,.ERROR) Q 0
 ;
 D ROUTE^RGFIRM(DFN,LEGACY,PRIMARY,.HLL)
 ;
 D GENERATE^HLMA("RG FACILITY INTEGRATION SERVER","LM",1,.RESULTS)
 ;
 S ERRFOUND=0
 I +$P($G(RESULTS),"^",2) S ERROR=$P(RESULTS,"^",3),ERROR="ERROR ENCOUNTERED BY HL7 WHILE SENDING FACILITY INTEGRATION MESSAGE: "_ERROR_" MSGID: "_+RESULTS D EXC^RGFIU(6,ERROR,DFN) S ERRFOUND=1
 S RGI=0
 I $D(RESULTS) F  S RGI=$O(RESULTS(RGI)) Q:'RGI  D
 .I +$P($G(RESULTS(RGI)),"^",2) S ERROR=$P(RESULTS(RGI),"^",3),ERROR="ERROR ENCOUNTERED BY HL7 WHILE SENDING FACILITY INTEGRATION MESSAGE: "_ERROR_" MSGID: "_+RESULTS(RGI) D EXC^RGFIU(6,ERROR,DFN) S ERRFOUND=1
 Q:ERRFOUND 0
 Q 1
 ;
BUILD(LOC,DFN,LEGACY,PRIMARY,ERROR) ;
 ;Description:  Builds the facility integration message.
 ;
 ;Input:
 ;  LOC - global location to place the message, referenced by @indirection
 ;  DFN - ien of patient
 ;  LEGACY - station number of the legacy site
 ;  PRIMARY - station number of the primary site
 ;Output:
 ;  Function Value - 1 on success, 0 on failure
 ;  ERROR - error message (pass by reference,optional)
 ;  HL7 variables defined by INIT^HLFNC2
 ;
 N ICNPLUS
 K ERROR
 ;
 ;
 I $G(DFN),$G(PRIMARY),$G(LEGACY) D
 .;just checking!
 E  S ERROR="MISSING PARAMETER NEEDED TO BUILD FACILITY INTEGRATION MESSAGE" D EXC^RGFIU(6,ERROR,DFN) Q 0
 ;
 ;don't send message if there is no ICN to identify it
 S ICNPLUS=$$GETICN^MPIF001(DFN)
 I (+ICNPLUS)'>0 S ERROR="UNABLE TO SEND FACILITY INTEGRATION MESSAGE - PATIENT LACKS ICN" D EXC^RGFIU(6,ERROR,DFN) Q 0
 ;
 ;don't send if local ICN
 I $$IFLOCAL^MPIF001(DFN) S ERROR="UNABLE TO SEND FACILITY INTEGRATION MESSAGE - PATIENT ICN IS LOCAL" D EXC^RGFIU(6,ERROR,DFN) Q 0
 ;
 D INIT^HLFNC2("RG FACILITY INTEGRATION SERVER",.HL)
 I $G(HL) S ERROR="ERROR ENCOUNTERED BY HL7 WHILE SENDING FACILITY INTEGRATION MESSAGE: "_HL D EXC^RGFIU(6,ERROR,DFN) Q 0
 ;
 S @LOC@(1)=$$EVN^VAFHLEVN("A08",51)
 S @LOC@(2)=$$EN^VAFCPID(DFN,"2,3,5,19")
 S @LOC@(3)="PV1"
 S $P(@LOC@(3),HL("FS"),3)="O"
 S @LOC@(4)="NTE"
 S $P(@LOC@(4),HL("FS"),3)="P"
 S $P(@LOC@(4),HL("FS"),4)=LEGACY_$E(HL("ECH"),1)_PRIMARY
 Q 1
 ;
SITESEND(TO,DFN,LEGACY,PRIMARY,RESULTS,ERROR) ;
 ;Description:  Sends the facility integration message for this patient
 ;to a single site.
 ;
 ;Input:
 ;  TO - station # of destination
 ;  DFN - ien of patient
 ;  LEGACY - station number (without suffix) of the legacy site
 ;  PRIMARY - station number (without suffix) of the primary site
 ;Output:
 ;  Function Value - 1 on success, 0 on failure
 ;  RESULTS() - results array returned by calling GENERATE^HLMA (pass by reference,optional)
 ;  ERROR - error message (pass by reference,optional)
 ;
 N HL,HLA,HLERR,HLL,SITEIEN,LINK,HLDT,HLCD,HLINK0,HLINKIEN,HLINKP,HLINKX,HLDOM,HLECH,HLFS,HLHDR,HLINST,HLN,HLPARAM,HLQ,HLSAN,HLTYPE,HLX
 K RESULTS,ERROR
 ;
 ;
 I $G(DFN),$G(PRIMARY),$G(LEGACY),$G(TO) D
 .;just checking!
 E  S ERROR="MISSING PARAMETER" Q 0
 ;
 S SITEIEN=$$LKUP^XUAF4(TO)
 I 'SITEIEN S ERROR="SITE NOT FOUND IN INSTITUTION FILE" Q 0
 ;
 ;set HLL array to route message to a single site
 S LINK=$$GETLINK^RGFIU(SITEIEN)
 I '$L(LINK) D
 .D EXC^RGFIU(224,"Facility Integration Message not sent to station #  "_TO,DFN)
 E  D
 .S HLL("LINKS",1)="RG FACILITY INTEGRATION CLIENT^"_LINK
 ;
 ;create the message
 I '$$BUILD("HLA(""HLS"")",DFN,LEGACY,PRIMARY,.ERROR) Q 0
 ;
 D GENERATE^HLMA("RG FACILITY INTEGRATION SERVER","LM",1,.RESULTS)
 ;
 I +$P($G(RESULTS),"^",2) S ERROR=$P(RESULTS,"^",3),ERROR="ERROR ENCOUNTERED BY HL7 WHILE SENDING FACILITY INTEGRATION MESSAGE: "_ERROR D EXC^RGFIU(6,ERROR,DFN) Q 0
 Q 1
