HLFNC1 ;AISC/SAW,JRP-Continuation of HLFNC, Additional Functions/Calls Used for HL7 Messages ;11/30/94  15:01
 ;;1.6;HEALTH LEVEL SEVEN;;Oct 13, 1995
 ;This routine is used for the Version 1.5 Interface Only
HLFLDS(APP,SEG) ;Returns HL7 fields used by a DHCP application for a
 ;specified segment
 ;
 ;This is an extrinsic function call that returns a string containing
 ;a list of HL7 fields separated by uparrows (e.g., 1^2^3)
 ;
 ;Required variables:
 ;APP - the internal entry number of the DHCP application
 ;      from file 771
 ;SEG - the name of the HL7 segment for which fields are
 ;      to be returned
 ;
 ;Check for required input parameters
 I 'APP!(SEG']"") Q ""
 I '$D(^HL(771,APP,0)) Q ""
 N X S X=$O(^HL(771.3,"B",SEG,0)) I 'X Q ""
 S X=$O(^HL(771,APP,"SEG","B",X,0)) I 'X Q ""
 ;Return string
 Q $TR($G(^HL(771,APP,"SEG",X,"F")),",","^")
MSH(HLMTN,HLSEC) ;Create an MSH Segment for an Outgoing HL7 Message
 ;
 ;Input  : HLMTN - Three to seven character HL7 message type name
 ;         HLSEC - Security to be included in field #8 of the segment
 ;                 (optional - field left blank when not passed)
 ;         All variables created by a call to INIT^HLTRANS
 ;
 ;Output : An HL7 MSH segment
 ;
 ;Note   : NULL is returned on error/bad input
 ;       : Existance of variables from INIT^HLTRANS is assumed
 ;
 ;Check for required parameters
 Q:($G(HLMTN)="") ""
 Q:('$D(HLNDAP0)) ""
 S HLSEC=$G(HLSEC)
 ;Make sure pointer to Message Text file is valid
 Q:('$D(HLDA)) ""
 Q:('$D(^HL(772,HLDA,0))) ""
 ;Declare variables
 N MID,NODE,MSH
 ;Get message ID
 S NODE=$G(^HL(772,HLDA,0))
 S MID=$P(NODE,"^",6)
 Q:(MID="") ""
 ;Build MSH segment
 S MSH="MSH"_HLFS_HLECH_HLFS_HLDAN_HLFS_$P(HLNDAP0,"^",2)
 S MSH=MSH_HLFS_$P(HLNDAP0,"^",1)_HLFS_$P(HLNDAP0,"^",3)_HLFS_HLDT1
 S MSH=MSH_HLFS_HLSEC_HLFS_HLMTN_HLFS_MID_HLFS_HLPID_HLFS_HLVER
 ;Return MSH segment
 Q MSH
BHS(HLMTN,HLSEC,HLMSA) ;Create a BHS Segment for an Outgoing HL7 Batch Message
 ;
 ;This is an extrinsic function call that returns an HL7 BHS segment
 ;
 ;Input  : HLMTN - The three to seven character HL7 message type name
 ;         HLSEC - Security to be included in field #8 of the segment
 ;                 (optional - field left blank when not passed)
 ;         HLMSA - Three components (separated by the HL7 component
 ;                 separator character) consisting of the first
 ;                 three fields in the MSA segment.  This variable is
 ;                 required if the message you are building is a
 ;                 batch response.
 ;         All variables created by a call to INIT^HLTRANS
 ;
 ;Output : An HL7 BHS segment
 ;
 ;Note   : NULL is returned on error/bad input
 ;       : Existance of variables from INIT^HLTRANS is assumed
 ;
 ;Check for required parameters
 Q:($G(HLMTN)="") ""
 S HLSEC=$G(HLSEC)
 S HLMSA=$G(HLMSA)
 Q:('$D(HLNDAP0)) ""
 ;Declare variables
 N BHS,FIELD9,FIELD10,TMP,BID,BRID
 ;Get batch ID
 S TMP=$G(^HL(772,HLDA,0))
 S BID=$P(TMP,"^",6)
 Q:(BID="") ""
 ;Build field # 9 (batch name/processing ID/type/version)
 S FIELD9=$E(HLECH)_HLPID_$E(HLECH)_$E(HLMTN,1,3)_$E(HLECH)_HLVER
 ;Build field # 10 (batch comment)
 S FIELD10=""
 I (HLMSA'="") D
 .S FIELD10=$P(HLMSA,$E(HLECH))
 .S TMP=$P(HLMSA,$E(HLECH),3)
 .S:(TMP'="") FIELD10=FIELD10_$E(HLECH)_TMP
 ;Get batch reference ID
 S BRID=""
 S TMP=$P(HLMSA,$E(HLECH),2)
 S:(TMP'="") BRID=TMP
 ;Build BHS segment
 S BHS="BHS"_HLFS_HLECH_HLFS_HLDAN_HLFS_$P(HLNDAP0,"^",2)
 S BHS=BHS_HLFS_$P(HLNDAP0,"^")_HLFS_$P(HLNDAP0,"^",3)_HLFS_HLDT1
 S BHS=BHS_HLFS_HLSEC_HLFS_FIELD9_HLFS_FIELD10_HLFS_BID_HLFS_BRID
 ;Return BHS segment
 Q BHS
