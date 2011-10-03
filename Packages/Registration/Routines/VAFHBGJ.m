VAFHBGJ ;ALB/CM BACKGROUND JOB FOR UPDATE MESSAGES ;05/23/95
 ;;5.3;Registration;**91,415**;Jun 06, 1996
 ;
 ;This routine will loop through the pivot file, getting the entries
 ;that have the TRANSMITTED-NEED TO TRANSMIT field populated and
 ; generating an A08 message for the update.
 ;
 ;
EN ;check to see if sending is on or off
 I '$$SEND^VAFHUTL() Q
 ;make sure only one job will run
ENT L +^XTMP("ADT/HL7 VAFH BATCH UPDATE"):3 E  Q
 ;
 D MAIN
 K HLA D KILL^HLTRANS
 L -^XTMP("ADT/HL7 VAFH BATCH UPDATE")
 Q
 ;
MAIN N LSTR,LOOP,NODE,DFN,RECENT,EVTY,EVDT,PIVOT,VPTR,GBL,COUNT,UP,ERR,CLEAN
 I '$O(^VAT(391.71,"AC",1,"")) Q
 S LOOP="",GBL="HLA(""HLS"")"
 K HLA
 ;
 F  S COUNT=1,LOOP=$O(^VAT(391.71,"AC",1,LOOP)) Q:LOOP=""  D  Q:$D(HL)=1
 .; bad x-ref, delete it and quit
 .I '$D(^VAT(391.71,LOOP)) K ^VAT(391.71,"AC",1,LOOP) Q
 .S NODE=$G(^VAT(391.71,LOOP,0)) Q:'NODE
 .K HL D INIT^HLFNC2("VAFH A08",.HL)
 .I $D(HL)=1 Q
 .I LOOP#10=0,+$$S^%ZTLOAD K HL S HL="TaskMan User Stop " Q
 .S DFN=$P(NODE,"^",3),PIVOT=$P(NODE,"^",2) Q:'DFN
 .; need to check if anything but registration
 .S LSTR=$P($$LTD^VAFHUTL(DFN),"^",2)
 .I LSTR'="R",LSTR'["No l" S LSTR=",2,50"
 .E  S LSTR=50
 .;
 .; generate the a08 message
 .S ERR=$$UP^VAFHCA08(DFN,PIVOT,NODE,COUNT,GBL,"2,3,4,5,6,7,8,9,10B,11,12,13,14,16,19,22B","2,3,4,5,6,7,8,9,10,11,12,13,14,15",LSTR)
 .I +ERR=0 DO
 . .S CLEAN=$$CLNTRAN^VAFHPIV2(PIVOT),COUNT=$P(ERR,"^",2)+1
 .E  Q
 .;;;I COUNT<2&($D(CLEAN)) D
 .I +CLEAN=-1 D ERROR^VAFHCCAP(CLEAN,DFN) Q
 .D GENERATE^HLMA("VAFH A08","LM",1,.HLRESLT)
 .K HLA
 Q
