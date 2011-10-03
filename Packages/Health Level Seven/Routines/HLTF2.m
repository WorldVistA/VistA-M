HLTF2 ;AISC/SAW/MTC-Process Message Text File Entries (Cont'd) ;10/17/2007  09:44
 ;;1.6;HEALTH LEVEL SEVEN;**25,122**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
MERGEIN(LLD0,LLD1,MTIEN,HDR,MSA) ;Merge Data From Communication Server
 ;Module Logical Link File into Message Text File
 ;
 ;This is a subroutine call with parameter passing.  The output
 ;parameters HDR (and optionally) MSA are returned by this call.
 ;
 ;Required input parameters
 ;  LLD0 = Internal entry number where message is stored in Logical Link
 ;            file or XM if message is stored in MailMan
 ;  LLD1 = Internal entry number of IN QUEUE multiple entry in Logical
 ;           Link file (Only required for messages stored in Logical
 ;           Link file)
 ;  MTIEN = Internal entry number where message is to be copied to in
 ;            Message Text file
 ;    HDR = The variable in which the message header segment will
 ;            be returned
 ;    MSA = The variable in which the message acknowledgement segment
 ;            will be returned, if one exists for this message
 ;
 ;Check for required parameters
 I $G(LLD0)']""!('$G(MTIEN)) Q
 I LLD0'="XM",'$G(LLD1) Q
 N FLG,HLCHAR,HLEVN,HLFS,I,X,X1,HLDONE
 S (FLG,HLCHAR,HLEVN,X)=0
 ;
 ; patch HL*1.6*122: MPI-client/server
 F  L +^HL(772,+$G(MTIEN)):10 Q:$T  H 1
 ;
 ;Move data from Logical Link file to Message Text file
 I LLD0'="XM" D
 .S I=0 F  S X=$O(^HLCS(870,LLD0,1,LLD1,1,X)) Q:X'>0  S X1=$G(^(X,0)) S:"FHS,BHS,MSH"[$E(X1,1,3) FLG=1 I FLG S HLCHAR=HLCHAR+$L(X1) D
 ..;If header segment, process it and set HDR equal to it
 ..I X1'="","FHS,BHS,MSH"[$E(X1,1,3) D
 ...I '$D(HDR) S HDR=X1,HLFS=$E(X1,4) I $E(HDR,1,3)="BHS" S MSA="MSA"_HLFS_$P($P(HDR,HLFS,10),$E(HDR,5),1)_HLFS_$P(HDR,HLFS,12)_HLFS_$P($P(HDR,HLFS,10),$E(HDR,5),2)
 ...S $P(X1,HLFS,8)=""
 ...S:$E(X1,1,3)="MSH" HLEVN=HLEVN+1
 ..;If acknowledgement segment, set MSA equal to it
 ..I $E(X1,1,3)="MSA",'$D(MSA),$E($G(HDR),1,3)="MSH" S MSA=X1
 ..S I=I+1,^HL(772,MTIEN,"IN",I,0)=X1
 ;
 ;Move data from MailMan Message file to Message Text file
 I LLD0="XM" D
 .S I=0 F  X XMREC Q:XMER<0  S:"FHS,BHS,MSH"[$E(XMRG,1,3) FLG=1 I FLG S HLCHAR=HLCHAR+$L(XMRG) D  Q:XMER<0
 ..;If header segment, process it and set HDR equal to it
 ..I XMRG'="","FHS,BHS,MSH"[$E(XMRG,1,3) D
 ...I '$D(HDR) S HDR=XMRG,HLFS=$E(XMRG,4) I $E(HDR,1,3)="BHS" S MSA="MSA"_HLFS_$P($P(HDR,HLFS,10),$E(HDR,5),1)_HLFS_$P(HDR,HLFS,12)_HLFS_$P($P(HDR,HLFS,10),$E(HDR,5),2)
 ...S $P(XMRG,HLFS,8)=""
 ...S:$E(XMRG,1,3)="MSH" HLEVN=HLEVN+1
 ..;If acknowledgement segment, set MSA equal to it
 ..I $E(XMRG,1,3)="MSA",'$D(MSA),$E($G(HDR),1,3)="MSH" S MSA=XMRG
 ..S I=I+1,^HL(772,MTIEN,"IN",I,0)=XMRG
 S ^HL(772,MTIEN,"IN",0)="^^"_I_"^"_I_"^"_$$DT^XLFDT_"^"
 ;Update statistics in Message Text file for this entry
 ;
 ; patch HL*1.6*122: MPI-client/server
 L -^HL(772,+$G(MTIEN))
 ;
 D STATS^HLTF0(MTIEN,HLCHAR,HLEVN)
 Q
MERGEOUT(MTIEN,LLD0,LLD1,HDR) ;Merge Text in Message Text File into
 ;Communication Server Module Logical Link File
 ;
 ;This is a routine call with parameter passing.  There are no output
 ;parameters returned by this call.
 ;
 ;Required input parameters
 ;  MTIEN = Internal entry number where message is stored in Message
 ;            Text file
 ;  LLD0 = Internal entry number where message is to be copied to in
 ;            Logical Link file
 ;  LLD1 = Internal entry number of IN QUEUE multiple entry in Logical
 ;          Link file
 ;  HDR  = Name of the array that contains HL7 Header segment
 ;         format: HLHDR - Used with indirection to build message in out
 ;                         queue
 ;  This routine will first take the header information in the array
 ;  specified by HDR and merge into the Message Text field of file 870.
 ;  Then it will move the message contained in 772 (MTIEN) into 870.
 ;
 ;Check for required parameters
 I '$G(MTIEN)!('$G(LLD0))!('$G(LLD1))!(HDR="") Q
 ;
 ;-- initilize 
 N I,X
 S I=0
 ;
 ; patch HL*1.6*122: MPI-client/server
 F  L +^HLCS(870,+$G(LLD0),2,+$G(LLD1)):10 Q:$T  H 1
 ;
 ;-- move header into 870 from HDR array
 S X="" F  S X=$O(@HDR@(X)) Q:'X  D
 . S I=I+1,^HLCS(870,LLD0,2,LLD1,1,I,0)=@HDR@(X)
 S I=I+1,^HLCS(870,LLD0,2,LLD1,1,I,0)=""
 ;
 ;Move data from Message Text file to Logical Link file
 S X=0 F  S X=$O(^HL(772,MTIEN,"IN",X)) Q:X=""  D
 . S I=I+1,^HLCS(870,LLD0,2,LLD1,1,I,0)=$G(^HL(772,MTIEN,"IN",X,0))
 ;
 ;-- update 0 node of message and format arrays
 S ^HLCS(870,LLD0,2,LLD1,1,0)="^^"_I_"^"_I_"^"_$$DT^XLFDT_"^"
 ;
 ; patch HL*1.6*122: MPI-client/server
 L -^HLCS(870,+$G(LLD0),2,+$G(LLD1))
 ;
 Q
OUT(HLDA,HLMID,HLMTN) ;File Data in Message Text File for Outgoing Message
 ;Version 1.5 Interface Only
 ;
 ; patch HL*1.6*122: HLTF routine splitted, moves sub-routines,
 ; OUT, IN, and ACK to HLTF2 routine.
 ; 
 Q:'$D(HLFS)
 ;
 I HLMTN="ACK"!(HLMTN="MCF")!(HLMTN="ORR") Q:'$D(HLMSA)  D ACK(HLMSA,"I") Q
 ;
 ;-- if message contained MSA find inbound message
 I $D(HLMSA),$D(HLNDAP),$P(HLMSA,HLFS,3)]"" D
 . N HLDAI
 . S HLDAI=0
 . F  S HLDAI=$O(^HL(772,"AH",+$P($G(HLNDAP0),U,12),$P(HLMSA,HLFS,3),HLDAI)) Q:'HLDAI!($P($G(^HL(772,+HLDAI,0)),U,4)="I")
 . I 'HLDAI K HLDAI
 ;
 D STUFF^HLTF0("O")
 ;
 N HLAC S HLAC=$S($D(HLERR):4,'$P(HLNDAP0,"^",10):1,1:2) D STATUS^HLTF0(HLDA,HLAC,$G(HLMSG))
 D:$D(HLCHAR) STATS^HLTF0(HLDA,HLCHAR,$G(HLEVN))
 ;
 ;-- update status if MSA and found inbound message
 I $D(HLMSA),$D(HLDAI) D
 .N HLERR,HLMSG I $P(HLMSA,HLFS,4)]"" S HLERR=$P(HLMSA,HLFS,4)
 .S HLAC=$P(HLMSA,HLFS,2)
 .I HLAC'="AA" S HLMSG=$S(HLAC="AR":"Application Reject",HLAC="AE":"Application Error",1:"")_" - "_HLERR
 .S HLAC=$S(HLAC'="AA":4,1:3) D STATUS^HLTF0(HLDAI,HLAC,$G(HLMSG))
 Q
 ;
IN(HLMTN,HLMID,HLTIME) ;File Data in Message Text File for Incoming Message
 ;Version 1.5 Interface Only
 ;
 ; patch HL*1.6*122: HLTF routine splitted, moves sub-routines,
 ; OUT, IN, and ACK to HLTF2 routine.
 ; 
 Q:'$D(HLFS)
 I HLMTN="ACK"!(HLMTN="MCF")!(HLMTN="ORR") Q:'$D(HLMSA)  D ACK(HLMSA,"O",$G(HLDA)) Q
 ;
 N HLDAI S HLDA=0
 I $D(HLNDAP),HLMID]"" D
 .F  S HLDA=+$O(^HL(772,"AH",+$P($G(HLNDAP0),U,12),HLMID,HLDA)) Q:'HLDA!($P($G(^HL(772,+HLDA,0)),U,4)="I")
 .I HLDA D
 ..S HLDT=+$P($G(^HL(772,HLDA,0)),"^"),HLDT1=$$HLDATE^HLFNC(HLDT)
 ..K ^HL(772,HLDA,"IN")
 .I $D(HLMSA),$P(HLMSA,HLFS,3)]"" D
 ..S HLDAI=0
 ..F  S HLDAI=$O(^HL(772,"AH",+$P($G(HLNDAP0),U,12),$P(HLMSA,HLFS,3),HLDAI)) Q:'HLDAI!($P($G(^HL(772,+HLDAI,0)),U,4)="O")
 ..I 'HLDAI K HLDAI
 ;
 ; patch HL*1.6*122: MPI-client/server
 ; I 'HLDA D CREATE(.HLMID,.HLDA,.HLDT,.HLDT1) K HLZ
 I 'HLDA D CREATE^HLTF(.HLMID,.HLDA,.HLDT,.HLDT1) K HLZ
 ;
 D STUFF^HLTF0("I")
 N HLAC S HLAC=$S($D(HLERR):4,1:1) D STATUS^HLTF0(HLDA,HLAC,$G(HLMSG))
 ;
 D MERGE15^HLTF1("G",HLDA,"HLR",HLTIME)
 ;
 I '$D(HLERR),$D(HLMSA),$D(HLDAI) D
 .N HLAC,HLERR,HLMSG I $P(HLMSA,HLFS,4)]"" S HLERR=$P(HLMSA,HLFS,4)
 .S HLAC=$P(HLMSA,HLFS,2) I HLAC'="AA" S HLMSG=$S(HLAC="AR":"Application Reject",1:"Application Error")_" - "_HLERR
 .S HLAC=$S(HLAC'="AA":4,1:3) D STATUS^HLTF0(HLDAI,HLAC,$G(HLMSG))
 Q
 ;
ACK(HLMSA,HLIO,HLDA) ;Process 'ACK' Message Type - Version 1.5 Interface Only
 ;
 ; patch HL*1.6*122: HLTF routine splitted, moves sub-routines,
 ; OUT, IN, and ACK to HLTF2 routine.
 ; 
 ; To determine the correct message to link the ACK, HLIO is used.
 ; For an ack from DHCP (original message from remote system) then
 ; HLIO should be "I" so that the correct inbound message is ack-ed. For
 ; an inbound ack (original message outbound from DHCP) HLIO should be
 ; "O". This distinction must be made due to the possible duplicate
 ; message ids from a bi-direction interface.
 ;
 ; Input : MSA - MSA from ACK message.
 ;         HLIO - Either "I" or "O" : See note above.
 ;Output : None
 ;
 N HLAC,HLMIDI
 ;-- set up required vars
 S HLAC=$P(HLMSA,HLFS,2),HLMIDI=$P(HLMSA,HLFS,3)
 ;-- quit
 Q:HLMIDI']""!(HLAC']"")!('$D(HLNDAP))
 ;-- find message to ack
 I '$G(HLDA) S HLDA=0 D
 . F  S HLDA=+$O(^HL(772,"AH",+$P($G(HLNDAP0),U,12),HLMIDI,HLDA)) Q:'HLDA!($P($G(^HL(772,+HLDA,0)),U,4)=HLIO)
 ;-- quit if no message
 Q:'$D(^HL(772,+HLDA,0))
 ;-- check for error
 I $P(HLMSA,HLFS,4)]"" N HLERR S HLERR=$P(HLMSA,HLFS,4)
 I $D(HLERR),'$D(HLMSG) N HLMSG S HLMSG="Error During Receipt of Acknowledgement Message"_$S(HLAC="AR":" - Application Reject",HLAC="AE":" - Application Error",1:"")_" - "_HLERR
 ;-- update status
 S HLAC=$S(HLMTN="MCF":2,HLAC'="AA":4,1:3)
 D STATUS^HLTF0(HLDA,HLAC,$G(HLMSG))
 Q
 ;
