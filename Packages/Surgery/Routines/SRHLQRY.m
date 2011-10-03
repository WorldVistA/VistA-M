SRHLQRY ;B'HAM ISC/DLR - Surgery Interface Receiver of SQM Message ; [ 05/06/98   7:14 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;This routine processes incoming Schedule Query messages for surgery cases
 N DFN,HLCOMP,HLREP,HLSUB,II,MSG,SG,SRAC,SRDT,SRERR,TYPE
 K ^TMP("HLA",$J),HLMID
QUERY N I,J,X F I=1:1 X HLNEXT Q:HLQUIT'>0  S X(I)=HLNODE,J=0,SG=$E(X(I),1,3) D  S MSG=X(I) D PICK
 .F  S J=$O(HLNODE(J)) Q:'J  S X(I,J)=HLNODE(J)
 S HLCOMP=$E(HL("ECH"),1),HLREP=$E(HL("ECH"),2),HLSUB=$E(HL("ECH"),4)
 I $D(SRERR) I $G(SRERR)'["No cases scheduled for date requested" S SRAC="AE",SRERR="" D ERR^SRHLZQR(SRAC,SRERR)
 I '$D(SRDT) S SRAC="AR",SRERR="Invalid or Missing QRF segment",SRERR="" D ERR^SRHLZQR(SRAC,SRERR)
 I '$D(DFN) S SRAC="AR",SRERR="Invalid or Missing QRD segment",SRERR="" D ERR^SRHLZQR(SRAC,SRERR)
 D ZQR^SRHLZQR(DFN,SRDT)
EXIT ;Kill variables and quit.
 I $D(SRERR) S HLP("ERRTEXT")=SRERR
 ;setup message for the outbound query acknowledgment
 ;S HLEID=HL("EID"),HLEIDS=HL("EIDS"),HLARYTYP="GM",HLFORMAT=1,HLRESLTA="",HLMTIENA="",HLP=""
 ;D GENACK^HLMA1(HL("EID"),HLMID,HL("EIDS"),"GM",1,.HLRESLTA,.MTIEN)
 D GENACK^HLMA1(HL("EID"),HLMTIENS,HL("EIDS"),"GM",1,.HLRESLTA)
 Q
 ;
PICK ;For each segment found in the message, process the segment module.
 I $T(@SG)]"" D @SG
 I $T(@SG)="" Q
 Q
MSH ;;MSH
 ;Process the MSH segment.
 S (HLFS,HL("FS"))=$E(MSG,4),(HLECH,HL("ECH"))=$E(MSG,5,8)
 S TYPE=$P(MSG,HL("FS"),9)
 S HLCOMP=$E(HL("ECH"),1),HLREP=$E(HL("ECH"),2),HLSUB=$E(HL("ECH"),4)
 S HLQ=HL("Q")
 Q
QRD ;;QRD
 ;Process QRD segment.
 N I,WDDC,WSF
 S DFN=""
 S WSF=$P(MSG,HL("FS"),9) I WSF'="ALL" S WSF=$$FMNAME^HLFNC(WSF)
 S WDDC=$P(MSG,HL("FS"),11)
 I (WSF'="ALL")!(WDDC'="ALL") D
 .I $D(WDDC) F I=0:0 S I=$O(^DPT("SSN",+WDDC,I)) Q:'I  S DFN=I
 .I $G(DFN)="" S SRERR="Invalid Patient Name or SSN"
 .I $G(DFN)'="",$D(WSF) I WSF'=$E($P(^DPT(DFN,0),"^"),1,20) S SRERR="Invalid Patient Name or SSN"
 .I $G(DFN)'="" S:'$O(^SRF("B",DFN,0)) SRERR="Invalid Patient Name - not found in Surgery application"
 Q
QRF ;;QRF
 ;Process QRF segment.
 S SRDT=$$FMDATE^HLFNC($P(MSG,HL("FS"),3))
 I '$D(SRDT) S SRERR="Missing request date for surgical cases"
 Q
