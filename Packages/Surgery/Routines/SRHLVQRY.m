SRHLVQRY ;B'HAM ISC/PTD,DLR - Surgery Interface Receive of QRY Message ; [ 05/06/98   7:14 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;This routine processes incoming query messages for surgery cases
 N DFN,HLCOMP,HLREP,HLSUB,II,MSG,SG,SRAC,SRDT,SRERR,TYPE
 K ^TMP("HLS",$J)
QUERY F II=0:0 S II=$O(^HL(772,HLDA,"IN",II)) Q:'II!$D(HLERR)  S SG=$E(^HL(772,HLDA,"IN",II,0),1,3),MSG=^HL(772,HLDA,"IN",II,0) D PICK
 I $D(HLERR) S SRAC="AE",SRERR="" D ERR^SRHLVZSQ(SRAC,SRERR)
 I '$D(SRDT) S SRAC="AR",HLERR="Invalid or Missing QRF segment",SRERR="" D ERR^SRHLVZSQ(SRAC,SRERR)
 I '$D(DFN) S SRAC="AR",HLERR="Invalid or Missing QRD segment",SRERR="" D ERR^SRHLVZSQ(SRAC,SRERR)
 D:'$D(HLERR) ZSQ^SRHLVZSQ(DFN,SRDT)
 ;if no cases are found send AA with "no cases" message
 I $D(SRERR) S SRI=1 D MSA^SRHLVUO(.SRI,"AA")
EXIT ;Kill variables and quit.
 ;set message type for the outbound query acknowledgment
 S $P(HLSDATA(1),HLFS,9)="ZSQ",^TMP("HLS",$J,HLSDT,0)=HLSDATA(1)
 D EN1^HLTRANS
 Q
 ;
PICK ;For each segment found in the message, process the segment module.
 I $T(@SG)]"" D @SG
 I $T(@SG)="" S HLERR="Invalid segment in message "_$G(TYPE) Q
 Q
MSH ;Process the MSH segment.
 S HLFS=$E(MSG,4),HLECH=$E(MSG,5,8)
 S TYPE=$P(MSG,HLFS,9)
 S HLCOMP=$E(HLECH,1),HLREP=$E(HLECH,2),HLSUB=$E(HLECH,4)
 S HLNDAP=$O(^HL(770,"B",$P(MSG,HLFS,3),0))
 S (HLMTN,HLSDT)="ZSQ"
 Q
DSC Q
QRD ;Process QRD segment.
 N I,WDDC,WSF
 S DFN=""
 S WSF=$E($P(MSG,HLFS,9),1,3) I WSF'="ALL" S WSF=$$FMNAME^HLFNC(WSF)
 S WDDC=$E($P(MSG,HLFS,11),1,3)
 I (WSF'="ALL")!(WDDC'="ALL") D
 .I $D(WDDC) F I=0:0 S I=$O(^DPT("SSN",+WDDC,I)) Q:'I  S DFN=I
 .I $G(DFN)="" S HLERR="Invalid Patient Name or SSN"
 .I $G(DFN)'="",$D(WSF) I WSF'=$E($P(^DPT(DFN,0),"^"),1,20) S HLERR="Invalid Patient Name or SSN"
 .I $G(DFN)'="" S:'$O(^SRF("B",DFN,0)) HLERR="Invalid Patient Name - not found in Surgery application"
 Q
QRF ;Process QRF segment.
 S SRDT=$$FMDATE^HLFNC($P(MSG,HLFS,3))
 I '$D(SRDT) S HLERR="Missing request date for surgical cases"
 Q
