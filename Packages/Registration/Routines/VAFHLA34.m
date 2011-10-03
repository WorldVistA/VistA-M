VAFHLA34 ;ALB/JLU;creates the A34 message.
 ;;5.3;Registration;**91**;Jun 06, 1996
 ;
EN(DFN,GBL,CTR,APL,BEF,STAT,PID,ZPD,ID) ;builds the actual A34 message content. INIT OF
 ;HLTRANS and all of the HL7 varaiables most have been set up.
 ;
 ;DFN - The DFN of the Patient
 ;GBL - The GLOBAL to store message
 ;CTR - the counter to start at
 ;APL - The HL7 application or HLMTN
 ;BEF - This is the before value of the PID
 ;STAT - The status of this event (old or new)
 ;PID - The fields to be returned from the PID call
 ;ZPD - The fields to be returned from the ZPD call
 ;ID  - Contains the set ID field for HL7 (OPTIONAL)
 ;
 N VAR
 DO
 .I $S('$D(DFN):1,DFN="":1,1:0) S VAR="Patient not identified" Q
 .I $S('$D(GBL):1,GBL="":1,1:0) S VAR="Storage global not identified" Q
 .I $S('$D(CTR):1,CTR="":1,1:0) S VAR="Counter to start at not identified" Q
 .I $S('$D(APL):1,APL="":1,1:0) S VAR="Calling application not identified" Q
 .I $S('$D(BEF):1,BEF="":1,1:0) S VAR="Before value of PID not identified" Q
 .I $S('$D(STAT):1,STAT="":1,1:0) S VAR="Status of event not identified" Q
 .I $S('$D(PID):1,PID="":1,1:0) S VAR="Fields for PID not identified" Q
 .I $S('$D(ZPD):1,ZPD="":1,1:0) S VAR="Fields for ZPD not identified" Q
 .Q
 I $D(VAR) G ERR
 S @GBL@(CTR)=$$EVN^VAFHLEVN("A34",STAT) ;creates the EVN segment
 S CTR=CTR+1
 S @GBL@(CTR)=$$EN^VAFHLPID(DFN,PID) ;creates the PID segment
 S CTR=CTR+1
 S @GBL@(CTR)=$$EN^VAFHLZPD(DFN,ZPD) ;creates the ZPD segment
 S CTR=CTR+1
 S @GBL@(CTR)=$$EN^VAFHLMRG(DFN,BEF) ;creates the MRG segment
 Q 1_U_CTR
ERR Q -1_U_VAR
