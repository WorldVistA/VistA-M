IVMPREC ;ALB/MLI/ESD,BAJ - PROCESS INCOMING HL7 (QRY) MESSAGES ; 8/17/06 2:37pm
 ;;2.0;INCOME VERIFICATION MATCH;**1,9,11,15,18,24,34,105**;JUL 8,1996;Build 2
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine will process (QRY) HL7 messages received from HEC
 ; At present, the (QRY) message queries for updated information
 ; for a single patient.
 ;
 ;
QRY ; - Receive Query Message requesting further information
 ;
 S (HLEVN,IVMCT,IVMERROR,IVMFLAG)=0
 ;
 K IVMQUERY("LTD"),IVMQUERY("OVIS") ;Variables needed to open/close last visit date and outpt visit QUERIES
 S IVMRTN="IVMPREC"
 K ^TMP($J,IVMRTN),^TMP("HLS",$J),^TMP("HLA",$J)
 F SEGCNT=1:1 X HLNEXT Q:HLQUIT'>0  D
 .S CNT=0
 .S ^TMP($J,IVMRTN,SEGCNT,CNT)=HLNODE
 .F  S CNT=$O(HLNODE(CNT)) Q:'CNT  D
 ..S ^TMP($J,IVMRTN,SEGCNT,CNT)=HLNODE(CNT)
 ;
 ; INITIALIZE HL7 VARIABLES
 S HLEID="VAMC "_$P($$SITE^VASITE,"^",3)_" ORF-Z07 SERVER"
 S HLEID=$O(^ORD(101,"B",HLEID,0))
 D INIT^HLFNC2(HLEID,.HL)
 S HLEIDS=$O(^ORD(101,HLEID,775,"B",0))
 ;
 ; IVM*2.0*105 BAJ 11/02/2005 Temp global for Consistency Checks
 K ^TMP($J,"CC")
 ;
 F IVMDA=0:0 S IVMDA=$O(^TMP($J,IVMRTN,IVMDA)) Q:'IVMDA  S IVMSEG=$G(^(IVMDA,0)) I $E(IVMSEG,1,3)="QRD"!($E(IVMSEG,1,3)="MSH") D
 .I $E(IVMSEG,1,3)="MSH" S IVMMSHID=$P(IVMSEG,HLFS,10),MSGID=$P(IVMSEG,HLFS,10),HLMID=MSGID Q
 .K HLERR S IVMFLAG=1
 .S IVMSEG=$P(IVMSEG,HLFS,2,999) ; strip off segment name
 .S IVMQLR=$P(IVMSEG,HLFS,7),DFN=$P(IVMSEG,HLFS,8),IVMIY=$P(IVMSEG,HLFS,10)
 .D ERRCK
 .I $D(HLERR) D ACK
 .I '$D(HLERR) D
 ..N EVENTS
 ..; - if master query - create entry in (#301.9) file
 ..I IVMQLR>1,'DFN D  Q
 ...S IVMSEG1="QRD"_HLFS_IVMSEG
 ...S:'$D(^IVM(301.9,1,10,0)) ^(0)="^301.9001DA^"
 ...S DA(1)=1,DIC="^IVM(301.9,1,10,",DIC(0)=""
 ...S X=IVMIY
 ...K DO,DD D FILE^DICN
 ...S DA=+Y,DA(1)=1,DIE="^IVM(301.9,1,10,"
 ...S DR=".02///NOW;.04////^S X=IVMMSHID;10////^S X=IVMSEG1" D ^DIE
 ..;
 ..; Send AE if veteran has a Pseudo SSN and eligibility is not verified
 ..; Removed with IVM*2*105
 ..; I '$$SNDPSSN^IVMPTRN7(DFN) S HLERR="Pseudo SSN must be verified" D ACK Q
 ..;
 ..; - prepare (ACK) message
 ..D:'$D(HLERR) MSGHDR   ;header (MSH)
 ..D ACK     ;message (MSA)
 ..;
 ..; - set up local HL7 event type code in MSH
 ..S IVMCT=IVMCT+1,^TMP("HLS",$J,IVMCT)="QRD"_HLFS_IVMSEG ; copy of incoming QRD
 ..;
 ..; - build 'FULL' transmission (note: without MSH segment)
 ..S IVMMTDT=$E(IVMIY,1,3)+1_"1231.9999"
 ..D FULL^IVMPTRN7(DFN,IVMMTDT,.EVENTS,.IVMCT,.IVMGTOT,,1,,.IVMQUERY)
 ;
 ; IVM*2.0*105 BAJ 11/02/2005
 ; send AE if inconsistencies found.
 I ^TMP($J,"CC",0) S HLERR="Message not sent.  Inconsistencies in Record" D ACK
 K ^TMP($J,"CC")
 ;
 F Z="LTD","OVIS" I $G(IVMQUERY(Z)) D CLOSE^SDQ(IVMQUERY(Z)) K IVMQUERY(Z)
 I 'IVMFLAG S HLERR="Invalid Message Format" D ACK
 S HLMTN="ORF"
 S HLMTIENA=HLMTIEN
 K ^TMP("HLA",$J) M ^TMP("HLA",$J)=^TMP("HLS",$J) K ^TMP("HLS",$J)
 D GENACK^HLMA1(HLEID,HLMTIENS,HLEIDS,"GB",1,.HLRESLTA,HLMTIENA,.HLP)
 ;
QRYQ K DFN,DR,HLEVN,IVMCT,IVMDA,IVMERROR,IVMFLAG,IVMIY,IVMMTDT,IVMSEG,IVMSEG1,IVMQLR,IVMMSHID,MSGID,MSHID
 K ^TMP("HLA",$J),^TMP("HLS",$J),^TMP($J,IVMRTN)
 Q
 ;
 ;
ERRCK ; Perform error checks on HL7 (QRD) segment
 I ('DFN!(DFN'=+DFN)) S:IVMQLR'>1 HLERR="Invalid DFN"
 I '$D(HLERR) S IVMIY=$$FMDATE^HLFNC(IVMIY) I $E(IVMIY,4,7)'="0000"!($E(IVMIY,1,3)<292) S HLERR="Invalid Income Year"
 I '$D(HLERR),$P(IVMSEG,HLFS,2)'="R" S HLERR="Invalid Query Format Code"
 I '$D(HLERR),$P(IVMSEG,HLFS,3)'="I",($P(IVMSEG,HLFS,3)'="D") S HLERR="Invalid Query Priority"
 I '$D(HLERR),$P(IVMSEG,HLFS,9)'="DEM" S HLERR="Invalid Query Subject Filter"
 I '$D(HLERR),$P(IVMSEG,HLFS,12)'="T" S HLERR="Invalid Query Results Level"
 ;
 Q
 ;
MSGHDR ; prepare header MSH segment in batch of 100 message events
 ; input variables:
 ;          IVMCT record counter
 ;          HLEVN event number
 ;          MSHID outgoing message id
 ;             HL array for protocol
 ;                 
 N MID,HLRES
 S HLEVN=$G(HLEVN)+1
 D:(HLEVN#100)=1
 .K MSHID,HLDT,HLDT1,HLMTIEN
 .D INIT^HLFNC2(HLEID,.HL)
 .D CREATE^HLTF(.MSHID,.HLMTIEN,.HLDT,.HLDT1)
 S MID=MSHID_"-"_HLEVN
 D MSH^HLFNC2(.HL,MID,.HLRES)
 S IVMCT=$G(IVMCT)+1
 S ^TMP("HLS",$J,IVMCT)=HLRES
 Q
 ;
ACK ; prepare positive and negative acknowledgement (ACK) message
 ; (positive acknowledgement: MSA segment with no MSH segment)
 ; (negative acknowledgement: MSA segment with MSH segment)
 N MID,HLRES
 S IVMCT=$G(IVMCT)+1
 D:$D(HLERR)
 .S IVMERROR=1
 .S HLEVN=HLEVN+1
 .D:(HLEVN#100)=1
 ..K HLMID,HLMTIEN,HLDT,HLDT1 ; set up batch
 ..D INIT^HLFNC2(HLEID,.HL)
 ..D CREATE^HLTF(.HLMID,.HLMTIEN,.HLDT,.HLDT1)
 .S MID=HLMID_"-"_HLEVN
 .D MSH^HLFNC2(.HL,MID,.HLRES)
 .S ^TMP("HLS",$J,IVMCT)=HLRES
 .S IVMCT=IVMCT+1
 .S ^TMP("HLS",$J,IVMCT)="MSA"_HLFS_"AE"_HLFS_MSGID_HLFS_HLERR_"- SSN "_$S($G(DFN):$P($$PT^IVMUFNC4(DFN),"^",2),1:"NOT FOUND")
 I '$D(HLERR) S ^TMP("HLS",$J,IVMCT)="MSA"_HLFS_"AA"_HLFS_HLMID
 ;
 Q
 ;
