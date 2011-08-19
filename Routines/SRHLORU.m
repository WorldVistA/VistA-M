SRHLORU ;B'HAM ISC/DLR - Surgery Interface Receiver of ORU messages ; [ 02/06/01  9:27 AM ]
 ;;3.0; Surgery ;**41,100**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
REC N HLCOMP,HLREP,HLSUB,HLFS,HLECH,II,SG,SRERR,SRES,SRESCNT,SRESAR,SRESNR,SRI,SSN,TYPE,SROP,SRNON,SRHL,Z
 K HLMID,PID,SRHL S SRHL("E")=+$G(SRHL("E")),(SRESCNT,SRESAR,SRESNR)=0
 S Z=$G(^SRF(CASE,"TIU")) S:$P(Z,"^",2) SRESNR=1 S:$P(Z,"^",4) SRESAR=1
 F I=1:1 X HLNEXT Q:HLQUIT'>0  S (MSG,X(I))=HLNODE,SG=$E(HLNODE,1,3),J=0 D  D PICK
 .S J=0 F  S J=$O(HLNODE(J)) Q:'J  S X(I,J)=HLNODE(J)
 D:SRHL("E")>0 DSCPANCY^SRHLU(.HL)
GEN ;generate the message
 D MSA^SRHLUO(1,$S($D(HLP("ERRTEXT")):"AE",1:"AA"))
 ;HLEID - IEN of Server event protocol
 ;HLMTIENS - IEN in 772
 ;HLEIDS - IEN of Client event protocol
 ;HLARYTYP - acknowledgement array (see V. 1.6 HL7 doc)
 ;HLFORMAT - is HLMA is pre-formatted HL7 form
 ;HLRESLTA - message ID and/or the error message (for output)
 ;HLP("ERRTEXT") - Processing error message
 ;HLP("CONTPTR") - continuation pointer field value (not used)
 ;HLP("PRIORITY") - priority field value (not used)
 ;HLP("SECURITY") - security information (not used)
 S HLEID=HL("EID"),HLEIDS=HL("EIDS"),HLARYTYP="GM",HLFORMAT=1,HLRESLTA="",HLMTIENA="",HLP=""
 D GENACK^HLMA1(HLEID,HLMTIENS,HLEIDS,HLARYTYP,HLFORMAT,.HLRESLTA,HLMTIENA,.HLP)
EXIT ;
 K ^TMP("HLA",$J),SRHL
 Q
PICK ;check routine for segment entry point
 I $T(@SG)]"" D @SG
 I $T(@SG)="" Q
 Q
MSH ;;MSH
 ;process the MSH segment
 S (HLFS,HL("FS"))=$E(MSG,4),(HLECH,HL("ECH"))=$E(MSG,5,8)
 S HLCOMP=$E(HL("ECH"),1),HLREP=$E(HL("ECH"),2),HLSUB=$E(HL("ECH"),4)
 S TYPE=$P(MSG,HL("FS"),9)
 Q
PID ;;PID
 ;process PID segment
 N I,PAT
 S PID("SSN")=$P(MSG,HL("FS"),20),PAT=$$FMNAME^HLFNC($P(MSG,HL("FS"),6))
 I $D(PAT) F I=0:0 S I=$O(^DPT("B",PAT,I)) Q:'I  I $P(^DPT(I,0),U,9)=PID("SSN") S PID("DFN")=I
 Q
OBX ;;OBX
 ;null header for OBR segments sets that are set to ignore or send
 Q:$G(OBR)=""
 D:$G(OBR)'="" OBX^SRHLUI(MSG,OBR,CASE)
 Q
NTE ;;NTE
 ;null header for OBR segments sets that are set to ignore or send
 Q:$G(OBR)=""
 D NTE^SRHLUI(MSG,OBR,CASE)
 Q
OBR ;;OBR
 ;process OBR segment as well as underlying OBX's or NTE
 N DFN,ID,IEN,SRII,SRNEXT
 ;set-up the IDentifier and check the mapping file (#133.2) for a match
 S CASE=$P(MSG,HL("FS"),4) I 'CASE S SRDISC="Unknown Surgery Case Number in "_$P(MSG,HL("FS"),1,2)_"." D SETDSC^SRHLU(.HL,SRDISC,.SRHL) Q
 I '$D(^SRF(CASE,0)) S SRDISC="Unknown Surgery Case Number ("_$G(CASE)_") in "_$P(MSG,HL("FS"),1,2)_"." D SETDSC^SRHLU(.HL,SRDISC,.SRHL) Q
 S ID=$P($P(MSG,HL("FS"),5),HLCOMP,2) I $G(ID)="" S SRDISC="Unknown OBR identifier ("_$G(ID)_") for case #"_$G(CASE)_"." D SETDSC^SRHLU(.HL,SRDISC,.SRHL) Q
 S IEN=$O(^SRO(133.2,"AC",ID,0)) I $G(IEN)="" S SRDISC="Invalid OBR identifier ("_$G(ID)_") for case #"_$G(CASE)_"." D SETDSC^SRHLU(.HL,SRDISC,.SRHL) Q
 I $D(^SRF(CASE,0)) S DFN=$P(^SRF(CASE,0),U) I $D(PID("SSN")),$P(^DPT(DFN,0),U,9)'=$G(PID("SSN")) D  Q
 .S SRDISC="SSN mismatch for Surgery Case #"_$G(CASE)_".  Surgery Patient "_$$GET1^DIQ(2,+DFN_",",.01)_" ("_$$GET1^DIQ(2,+40_",",.09)_") is being sent with invalid ID ("_$G(PID("SSN"))_")."
 .D SETDSC^SRHLU(.HL,SRDISC,.SRHL)
 ;process the OBR identifier that is set to receive
 I $$CHECK(IEN)=1 S OBR=$$OBR^SRHLUI(CASE,DFN,IEN,MSG)
 Q
CHECK(IEN) ;check for valid receivable segments in file 133.2 (Surgery Interface)
 I $G(IEN)="" Q 0
 Q $P($G(^SRO(133.2,IEN,0)),U,4)["R"
