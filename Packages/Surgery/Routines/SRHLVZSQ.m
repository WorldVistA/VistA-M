SRHLVZSQ ;B'HAM ISC/PTD,DLR - Surgery Interface Sender of ZSQ Message ; [ 06/09/98   6:17 AM ]
 ;;3.0; Surgery ;**41**;24 Jun 93
 ; Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;VISTA Surgery system responds to QRY message with ZSQ message.
 ;ZSQ can contain surgical data for a specified patient/date,
 ;or all surgical cases (scheduled, requested,...) for a
 ;specified date.
 ;Variables defined when this module is called:
 ;DFN  - IEN in file #2 for a request of patient data.
 ;     - "" for a request of all cases
 ;SRDT - Requested date in FileMan form
 ;
ZSQ(DFN,SRDT) ;query response message for patient or all cases on a given date
 N BDT,CASE,EDT,FIND,HLCOMP,HLREP,HLSUB,SRI
 S SRI=1,HLCOMP=$E(HLECH,1),HLREP=$E(HLECH,2),HLSUB=$E(HLECH,4),(HLMTN,HLSDT)="ZSQ"
 ;Determine if data is available for requested date.  If not, set HLERR and SRERR build error message and quit."
 ;specified patient cases ONLY
 S FIND=0 I $G(DFN)'="" D  I FIND=0 S SRERR="No cases for the requested patient." Q
 .S CASE=0 F  S CASE=$O(^SRF("B",DFN,CASE)) Q:'CASE  I $P($P(^SRF(CASE,0),"^",9),".")=SRDT S FIND=1 Q
 ;all cases
 I $G(DFN)="" D  I FIND=0 S SRERR="No cases scheduled for date requested." Q
 .S BDT=SRDT-.0001,EDT=SRDT+.9999 F  S BDT=$O(^SRF("AC",BDT)) Q:'BDT!(BDT>EDT)!($G(FIND)=1)  S CASE=0 F  S CASE=$O(^SRF("AC",BDT,CASE)) Q:'CASE!($G(FIND)=1)  S:$P($G(^SRF(CASE,31)),U,4) FIND=1
PROCESS ;Data exists for the requested date.
 S SRAC="AA" D MSA^SRHLVUO(.SRI,SRAC)
 S BDT=SRDT-.0001,EDT=SRDT+.9999 F  S BDT=$O(^SRF("AC",BDT)) Q:'BDT!(BDT>EDT)  S CASE=0 F  S CASE=$O(^SRF("AC",BDT,CASE)) Q:'CASE  D
 .;all patient cases for a requested date
 .I $G(DFN)'="" Q:DFN'=+$P(^SRF("AC",BDT,CASE),"^")  D MSG
 .;all cases for a requested date
 .I $G(DFN)="" S DFN=$P(^SRF(CASE,0),"^") D MSG S DFN=""
 Q
 ;
MSG ;Send ZSQ message.
 N SREVENT,SRSTATUS,SROERR
 S (SREVENT,SRSTATUS)=""
 S SROERR=CASE D STATUS^SROERR0
 D ZCH^SRHLVUO1(.SRI,.SREVENT,.SRSTATUS)
 D PID^SRHLVUO(.SRI)
 D OBX^SRHLVUO(.SRI)
 D DG1^SRHLVUO(.SRI)
 D AL1^SRHLVUO(.SRI)
 D ZIS^SRHLVUO2(.SRI)
 D ZIG^SRHLVUO1(.SRI)
 D ZIP^SRHLVUO1(.SRI)
 D ZIL^SRHLVUO1(.SRI)
 Q
 ;
ERR(SRAC,SRERR) ;Error found, transmit error message.
 N SRI
 K ^TMP("HLS",$J)
 S SRI=1
 D MSA^SRHLVUO(.SRI,SRAC)
 D ERR^SRHLVUO(.SRI,SRERR)
 Q
