PRCVRE1 ;WOIFO/VC-Transmit HL7 message to IFCAP for requisition received from DynaMed ; 11/3/04 3:13pm ; 5/6/05 3:43pm
 ;;5.1;IFCAP;**81,119**;Oct 20, 2000;Build 8
 ;Per VHA Directive 2004-038, this routine should not be modified
 ;
 ;An exemption from the 245 character length standard for a variable
 ;   has been requested from the SACC for reading HL7 segments into
 ;   a single variable.  The limit is request to be 1K and if longer
 ;   than that the system will exit with an Application ACK reject.
 ;   Submitted 4/14/05.
 ;
 ;This routine processes messages from DynaMed to IFCAP to build a RIL
 ;
 ;HL("MID") - Message Control ID
 ;HL7DT - Today's date in HL7 format
 ;PRCDT - Date value
 ;ORC Segment will repeat for each item
 ;  PRCORD - Order control should be NW for new order - ORC-1
 ;  PRCFCP - Fund control Point - ORC-3
 ;  PRCDATE - Date and time item entered - ORC-9
 ;  PRCEMP - Enter by - ORC-10 DUZ^Lname^Fname^Approving Authority
 ;  PRCCC - Cost Center - ORC-17
 ;  PRCSITE - Site Code should be 516 - ORC-21
 ;RQD Segment will repeat for each item
 ;  PRCCTR - Item counter - RQD-1
 ;  PRCDOC - DynaMed Document number - unique per item - RQD-2
 ;  PRCITM - Item number $p1 of RQD-3
 ;  PRCQTY - Item quantity - RQD-5
 ;  PRCNEED - Date Needed - RQD-10
 ;RQ1 Segment one segment for each RQD segment
 ;  PRCCOST - Estimated Unit Cost - RQ1-1
 ;  PRCBOC -  BOC Number - RQ1-3
 ;  PRCVND - Vendor number - pointer to file 440 - RQ1-4
 ;  PRCNIF - National Item File number - RQ1-5
 ;PRCTYP - Repetitive Item List type - default to blank
 ;Message builds an ^XTMP to pass data to IFCAP RIL build routine.
 ; The first node is "PRCVRE*"+the Message Control ID. The next nodes
 ; are 0,1, and 2. The 0 node is the standard ^XTMP structure plus
 ; $H. The $H is used to measure transmission timing. The 1 node holds
 ; header data common to all detail items being transmitted. The 2
 ; node holds detail information about each item ordered in a counter
 ; sub-node.
 ; Under the 1 and 2 nodes are "ERR" subnodes that hold error 
 ; information about each item.  There can be multiple errors
 ; associated with each item, therefore there are multiple sub-nodes
 ; possible under each "ERR" node.
 ;Counters
 ;  PRCCNT, ACKCNT,PRCCC1,PRCFCP1,X,X1,X2,X8,X9,I,II,LL,ERRCNT
 ;ERRCOD - Error code from IFCAP
 ;ERRDAT - Error data from IFCAP
 ;ERRSTR - Error text from IFCAP
 ;ERRSUB - A substring of ERRSTR
 ;ERRS - Error substring from IFCAP
 ;SEVER - Error severity value - W or E
 ;TOT,TOTERR,TOTGOOD,TOTREC - Counters of errors returned to DM
 ;FLDNO - Field identified in an error message
 ;ERRVAL - ERROR FLAG
 ;ERRARY - Message Error array sent to Prosthetics
 ;ERRLOC - Location of error sent in ACK
 ;PRCCS, PRCFS, PRCRS - Field delimiters
 ;PRCNODE - Message segment identifier
 ;Temporary Globals
 ;  ^TMP("PRCVRIL",$J,"ACK") - Acknowledgement is ok
 ;  ^TMP("PRCVRIL",$J,"NAK") - Acknowledgement is not ok
 ;  ^TMP("HLA",$J) - Message array sent to DynaMed
 ;  ^XTMP("PRCVRE*"_Message Control ID,) - Data sent to IFCAP
 ;Temporary variables
 ;   TMP,MSGFLG,X, X1
 ;PRCHD - Array to hold map between HL7 and XTMP for Header info
 ;PRCDET - Array to hold map between HL7 and XTMP for Detail info
 ;PRCVERR - Array to hold error messages for MailMan
 ;PRCSUB - XTMP first node
 ;PRCSUB2 - Second $p of PRCSUB equal to Message Control ID
 ;PRCVRES - Return variable from GENACK - Note:this doesn't work.
 ;PRCVINDX - Index number into XTMP to keep track of number of items
 ;
 Q
 ;
BEGIN N PRCORD,DYNADATE,PRCDATE,PRCEMP,PRCSITE
 N PRCDOC,PRCITM,PRCQTY,PRCFCP,PRCCC
 N PRCCOST,PRCVND,PRCBOC,PRCNEED,PRCNIF
 N PRCSUB,PRCSUB2,PRCDT,PRCVINDX
 N ERRARY,PRCCS,PRCFS,PRCRS,PRCNODE,PRCNODE2
 N ACKCNT,NODE1,NODE2,PRCCTR,PRCCNT,PRCI,PRCJ,MID
 N X,X1,X2,X8,X9,XX,TMP,PRCCC1,PRCFCP1,LENVAL
 ; Fields used in PRCVREA are NEWed and KILLed here
 N MSG,MSGFLG,DOCID,ERRCNT,ERRCOD,ERRDAT,ERRS,ERRSTR,ERRSUB,FLDNO
 N I,IL,ERRTXT,I,II,III,J,SEVER,TOT,TOTERR,TOTGOOD,TOTREC
 N PRCDET,PRCHD,PRCVERR,MYRESULT,ERRLOC,PRCVRES
 D:'$D(U) DT^DICRW
 S PRCDT=$$NOW^XLFDT
 S HL7DT=$$FMTHL7^XLFDT(PRCDT),PRCDT=HL7DT
 S PRCSUB="PRCVRE*"_HL("MID") K ^XTMP(PRCSUB)
 D BUILD
 S PRCCNT=0
 S PRCFS=$G(HL("FS")),PRCCS=$E($G(HL("ECH"))),PRCRS=$E($G(HL("ECH")),2)
 D START
 D CLEANUP
 Q
 ;
START ;This will read the incoming message from DynaMed and build ^TMP
 ;
SETACK ; Set up information for the ACK or NAK
 ;
 K ^TMP("PRCVRIL",$J)
 S ^TMP("PRCVRIL",$J,"ACK",1)="MSA"_PRCFS_"AA"_PRCFS_HL("MID")
 S ^TMP("PRCVRIL",$J,"NAK",1)="MSA"_PRCFS_"AE"_PRCFS_HL("MID")
 S ^TMP("PRCVRIL",$J,"NAK",2)="ERR"_PRCFS
 S ACKCNT=2
 ;
 ;If this is not the right message quit
 ;
 I HL("MTN")'="OMN" D  Q
 .S $P(^TMP("PRCVRIL",$J,"NAK",ACKCNT),PRCFS,2)="Wrong Message Type: "_HL("MTN")
 .D NAKIT^PRCVREA
 I HL("ETN")'="O07" D  Q
 .S $P(^TMP("PRCVRIL",$J,"NAK",ACKCNT),PRCFS,2)="Wrong Event Type: "_HL("ETN")
 .D NAKIT^PRCVREA
 ;
 S ERRARY(1)="OK"
 ;
 ;Read the message and build the ^TMP global
 ;
 K ^TMP("PRCVRE",$J)
 S PRCI=""
 F PRCI=1:1 X HLNEXT Q:HLQUIT'>0  D
 .S ^TMP("PRCVRE",$J,PRCSUB,PRCI)=HLNODE,PRCJ=0
 .F  S PRCJ=$O(HLNODE(PRCJ)) Q:'PRCJ  S ^TMP("PRCVRE",$J,PRCSUB,PRCI,PRCJ)=HLNODE(PRCJ)
 .I $E(HLNODE,1,3)="ORC" D
 ..S PRCFCP=$P(HLNODE,PRCFS,4),PRCCC=$P(HLNODE,PRCFS,18)
 ..S TMP($J,PRCFCP,PRCCC)=""
 ;
 ;Validate that there is only one FCP and CC
 S PRCFCP="",PRCFCP1=""
 ; Prevent PRCCC1 undefined   PRC*5.1*119
 S PRCCC1=""
 F X8=1:1 S PRCFCP=$O(TMP($J,PRCFCP)) Q:PRCFCP=""  D
 .S PRCFCP1=X8
 .S PRCCC=""
 .F X9=1:1 S PRCCC=$O(TMP($J,PRCFCP,PRCCC)) Q:PRCCC=""  D
 ..S PRCCC1=X9
 I (PRCFCP1>1)!(PRCCC1>1) D  Q
 .S $P(^TMP("PRCVRIL",$J,"NAK",2),PRCFS,2)="Message contains multiple FCP's or CC's: "_HL("ETN") D NAKIT^PRCVREA
 ;
PARSIT ;Read the ^TMP global and build the ^XTMP global to pass to IFCAP
 ;
 S PRCI=0,PRCJ=0,LENVAL="OK"
 F  S PRCI=$O(^TMP("PRCVRE",$J,PRCSUB,PRCI)) Q:PRCI=""  Q:LENVAL="NOTOK"  D
 .S NODE1=$G(^TMP("PRCVRE",$J,PRCSUB,PRCI)) Q:NODE1=""
 .F PRCJ=1:1 D  Q:$G(^TMP("PRCVRE",$J,PRCSUB,PRCI,PRCJ))=""
 ..S NODE2=$G(^TMP("PRCVRE",$J,PRCSUB,PRCI,PRCJ))
 ..I $L(NODE1)+$L(NODE2)>1024 S LENVAL="NOTOK" Q
 ..S NODE1=NODE1_NODE2
 .Q:LENVAL="NOTOK"
 .S PRCNODE=$E(NODE1,1,3)
 .;
 .; IF MSH segment ignore the record
 .;
 .I PRCNODE="MSH" Q
 .S PRCNODE2=$E(NODE1,5,$L(NODE1))
 .;
 .; If ORC segment process the record
 .;
 .I PRCNODE="ORC" D  Q
 ..I $D(^XTMP(PRCSUB,1))'=0 Q
 ..S PRCORD=$P(PRCNODE2,PRCFS,1),DYNADATE=$P(PRCNODE2,PRCFS,9),PRCEMP=$P($P(PRCNODE2,PRCFS,10),PRCCS,1,3),PRCSITE=$P(PRCNODE2,PRCFS,21)
 ..S PRCFCP=$P(PRCNODE2,PRCFS,3),PRCCC=$P(PRCNODE2,PRCFS,17)
 ..S PRCDATE=$$HL7TFM^XLFDT(DYNADATE)
 ..S $P(^XTMP(PRCSUB,1),U,1)=0
 ..S $P(^XTMP(PRCSUB,1),U,4)=PRCORD,$P(^XTMP(PRCSUB,1),U,5)=PRCSITE
 ..S $P(^XTMP(PRCSUB,1),U,6)=PRCDATE,$P(^XTMP(PRCSUB,1),U,7)=PRCEMP
 .;
 .; If RQD segment process the record
 .;
 .I PRCNODE="RQD" D  Q
 ..S PRCCTR=$P(PRCNODE2,PRCFS,1)
 ..S PRCDOC=$P(PRCNODE2,PRCFS,2),PRCITM=$P(PRCNODE2,PRCFS,3)
 ..S PRCQTY=$P(PRCNODE2,PRCFS,5),DYNADATE=$P(PRCNODE2,PRCFS,10)
 ..S PRCNEED=$$HL7TFM^XLFDT(DYNADATE)
 .;
 .;If RQ1 segment process the record and build the XTMP global record
 .;
 .I PRCNODE="RQ1" D  Q
 ..S PRCCOST=$P(PRCNODE2,PRCFS,1),PRCBOC=$P(PRCNODE2,PRCFS,3),PRCVND=$P(PRCNODE2,PRCFS,4),PRCNIF=$P(PRCNODE2,PRCFS,5)
 ..;
 ..; Now build the XTMP record
 ..;
 ..S PRCVINDX=$P($G(^XTMP(PRCSUB,1)),U,1)
 ..I PRCCTR>PRCVINDX S $P(^XTMP(PRCSUB,1),U,1)=PRCCTR
 ..S $P(^XTMP(PRCSUB,1),U,2)=PRCFCP
 ..S $P(^XTMP(PRCSUB,1),U,3)=PRCCC
 ..S ^XTMP(PRCSUB,2,PRCCTR)=PRCITM_U_PRCQTY_U_PRCVND_U_PRCCOST_U_PRCNEED_U_PRCDOC_U_PRCNIF_U_PRCBOC
 ;
 I LENVAL="NOTOK" D  Q
 .S $P(^TMP("PRCVRIL",$J,"NAK",2),PRCFS,2)="HL7 Segment length greater than 1K"
 .D NAKIT^PRCVREA
 .K ^XTMP(PRCSUB)
 D CALLIT^PRCVREA
 Q
 ;
BUILD ;Build the ^XTMP global zero node record.
 ;
 S XX=$$HTFM^XLFDT($H,1)
 S X1=$$FMADD^XLFDT(XX,5)
 S ^XTMP(PRCSUB,0)=X1_U_XX_"^Transmit message to IFCAP to build the RIL"_U_$H
 Q
 ;
CLEANUP ;This area will kill all temporary globals and variables
 ;
 K ^TMP("PRCVRE",$J),TMP($J)
 K ^TMP("HLA",$J)
 K ^TMP("PRCVRIL",$J)
 K PRCCTR,PRCCNT,PRCORD,DYNADATE,PRCDATE,PRCEMP,PRCSITE,PRCDOC
 K PRCITM,PRCQTY,PRCFCP,PRCCC,PRCNIF,PRCBOC
 K PRCCOST,PRCVND,PRCSUB,PRCSUB2,PRCDT,PRCNEED
 K PRCFS,PRCCS,PRCRS,PRCVINDX
 K ERRARY
 K PRCFS,PRCRS,PRCNODE,PRCNODE2,PRCI,PRCJ
 K ACKCNT,NODE1,NODE2,LENVAL
 K X,X1,X2,X8,X9,XX,TMP,PRCCC1,PRCFCP1
 ;Fields killed here are used in PRCVREA
 K MID,MSG,MSGFLG,MYRESULT,PRCDET,PRCHD,ERRLOC,ERRSUB
 K DOCID,ERRCNT,ERRCOD,ERRDAT,ERRS,ERRSTR,I,II,III,IL,J,ERRTXT,SEVER
 K TOT,TOTERR,TOTGOOD,TOTREC,FLDNO,PRCVERR,PRCVRES
 Q
