PRCVEE1 ;WOIFO/VAC-EDIT/CANCELLATION FOR RIL/2237 FROM IFCAP TO DYNAMED ; 5/4/05 10:41am
 ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;PER VHA Directive 10-93-142, this routine should not be modified
 ;
 ;This routine will pass changes, cancellations and approvals from
 ;IFCAP to DynaMed because of changes in RIL's or 2237's
BEGIN(REF,PRCVDT) ;
 ; REF is passed in as node for ^XTMP(REF)
 ; PRCVDT is passed in as node for ^XTMP(REF,PRCVDT)
 ;  Note: PRCVDT is really two data elements $H and comma delimited
 ; There are two XTMP structures for this process.  The first is
 ;  for the original message sent from IFCAP. The first node is 
 ;  "PRCVUP*"+the RIL or 2237 number. The second node is $H. The third
 ;  node is either 0,1 or 2.  Zero is the standard ^XTMP structure
 ;  plus $H. The 1 node contains header information common to all
 ;  items.  The 2 node contains detail information to be sent.
 ;  Subordinate to the 2 node is a counter node unique for each item.
 ;  Under the 1 and 2 nodes, will reside an "ERR" node with
 ;  subordinate counters for multiple errors per item.  The second
 ;  ^XTMP is a pointer to the PRCVUP*xxx node.  The first node is 
 ;  "PRCVMID*"+the Message Control ID for the original message.
 ;  The 1 node contains the PRCVUP*+xxx and $H to point back to the
 ;  original XTMP("PRCVUP*"+RIL/2237)
 ; PRCPRO - Procedure call ID
 ; PRCERR - Error array for processing message errors
 ; PRCFS - Field separator
 ; PRCCS - Component separator
 ; PRCRS - Repetition separator
 ; PRCEE - Escape separator
 ; PRCSC - Sub-component separator
 ; PRCMID - Message Control ID for sent message
 ; ORCDAT - a single field that holds an ORC Segment
 ; RQD - an array of fields for the RQD segment
 ; RQ1 - an array of fields for the RQ1 segment
 ; ORC - an array of fields for the ORC segment
 ; PRCCNT - a record counter
 ; PRCVY - Loop counter
 N PRCPRO,PRCERR,PRCFS,PRCCS,PRCRS,PRCEE,PRCSC,PRCDP
 N ORCDAT,I,J,K,Y,X,X1,X2,XX,RQD,ORC,PRCCNT,RQ1
 N ODATE,PRCDTS,PRCDT,PRCMID,PRCVMID,DETAIL,HLA,HL,ERRCNT
 N PRCVERR,PRCVY,PRCDATA,PRCSITE,PRCFCP
 S PRCDATA=$P(REF,"*",2)
 S PRCSITE=$P(PRCDATA,"-",1),PRCFCP=$P(PRCDATA,"-",4)
 S PRCERR="OK"
 I REF="" Q
 S PRCDTS=$$NOW^XLFDT
 S PRCDT=$$FMTHL7^XLFDT(PRCDTS),ERRCNT=1
 D BUILD
 D SEND
 D CLEAN
 Q
BUILD ;Create the ORC record for the message
 S PRCCNT=1
 S PRCPRO="PRCV_IFCAP_01_EV_DYNAMED_UPDATE"
 K HL D INIT^HLFNC2(PRCPRO,.HL)
 I $G(HL) S PRCVERR(ERRCNT)="Error Generating Message to DynaMed" D MSGRTN Q
 S PRCFS=HL("FS"),PRCCS=$E(HL("ECH"),1),PRCRS=$E(HL("ECH"),2),PRCEE=$E(HL("ECH"),3),PRCSC=$E(HL("ECH"),4)
 ;
ORC ;Build ORC Segment
 S ORCDAT=$G(^XTMP(REF,PRCVDT,1))
 Q:ORCDAT=""
 F I=1:1:21 S ORC(I)=""
 ;Convert a $H node value to a HL7 date format
 S ODATE=$$HTFM^XLFDT(PRCVDT) S ORC(9)=$$FMTHL7^XLFDT(ODATE)
 S ORC(21)=$P(ORCDAT,U,2)
 S ORC(10)=$P(ORCDAT,U,3)_PRCCS_$P(ORCDAT,U,4)_PRCCS_$P(ORCDAT,U,5)
 S $P(ORC(10),PRCCS,9)=ORC(21)
 ;S HLA("HLS",PRCCNT)="ORC"_PRCFS
 ;
RQD ;Build RQD segment
 S PRCVY=0 F K=1:1 S PRCVY=$O(^XTMP(REF,PRCVDT,2,PRCVY)) Q:PRCVY=""  D
 .S DETAIL=$G(^XTMP(REF,PRCVDT,2,PRCVY))
 .Q:DETAIL=""
 .S ORC(1)=$P(DETAIL,PRCCS,1)
 .S HLA("HLS",PRCCNT)="ORC"_PRCFS
 .F I=1:1:10 S RQD(I)=""
 .F I=1:1:20 S HLA("HLS",PRCCNT)=HLA("HLS",PRCCNT)_ORC(I)_PRCFS
 .S HLA("HLS",PRCCNT)=HLA("HLS",PRCCNT)_ORC(21)
 .S PRCCNT=PRCCNT+1
 .S HLA("HLS",PRCCNT)="RQD"_PRCFS
 .S RQD(1)=PRCVY
 .S RQD(2)=$P(DETAIL,U,7)
 .S RQD(3)=$P(DETAIL,U,2)
 .S RQD(4)=$P(DETAIL,U,11)
 .S RQD(5)=$P(DETAIL,U,3)
 .S RQD(6)=$P(DETAIL,U,9)
 .S RQD(9)=$P(REF,"*",2)
 .S RQD(10)=$P(DETAIL,U,8)
 .S RQD(10)=$$FMTHL7^XLFDT(RQD(10))
 .F J=1:1:9 S HLA("HLS",PRCCNT)=HLA("HLS",PRCCNT)_RQD(J)_PRCFS
 .S HLA("HLS",PRCCNT)=HLA("HLS",PRCCNT)_RQD(10)
 .S PRCCNT=PRCCNT+1
 .;Build RQ1 segment
 .F I=1:1:5 S RQ1(I)=""
 .S HLA("HLS",PRCCNT)="RQ1"_PRCFS
 .S RQ1(1)=$P(DETAIL,U,6)
 .S RQ1(2)=$P(DETAIL,U,10)
 .S RQ1(3)=$P(DETAIL,U,12)
 .S RQ1(4)=$P(DETAIL,U,4)_PRCCS_PRCCS_PRCCS_$P(DETAIL,U,5)
 .S RQ1(5)=$P(DETAIL,U,15)
 .F J=1:1:4 S HLA("HLS",PRCCNT)=HLA("HLS",PRCCNT)_RQ1(J)_PRCFS
 .S HLA("HLS",PRCCNT)=HLA("HLS",PRCCNT)_RQ1(5)
 .S PRCCNT=PRCCNT+1
 Q
SEND ;Send record to HL7 interface to DynaMed
 S PRCDP="" D GENERATE^HLMA(PRCPRO,"LM",1,.PRCDP)
 I $P(PRCDP,PRCCS,2)'="" S PRCVERR(ERRCNT)="Generated "_$P(PRCDP,U,3)  D MSGRTN
 ;
 ;Get the Message Control ID
 S PRCMID=$P(PRCDP,U,1)
 S XX=$$HTFM^XLFDT($H,1)
 S X1=$$FMADD^XLFDT(XX,5)
 S PRCVMID="PRCVMID*"_PRCMID
 S ^XTMP(PRCVMID,0)=X1_U_XX_"^ACK 2237/RIL message from DynaMed"
 S ^XTMP(PRCVMID,1)=REF_U_PRCVDT
 Q
MSGRTN ;Send message to Fund Control Point users for update
 N XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ
 S XMSUB="TRANSMISSION ERRORS FOR  "_$P(REF,"*",2)
 S XMDUZ="IFCAP OUTBOUND ERROR MESSAGE FOR RIL/2237"
 S XMTEXT="PRCVERR("
 D GETFCPU^PRCVLIC(.XMY,PRCSITE,PRCFCP)
 D ^XMD
 K XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ
 Q
CLEAN ;Clean up variables
 K ODATE,PRCPRO,PRCERR,PRCFS,PRCCS,PRCRS,PRCEE,PRCSC
 K DETAIL,HLA("HLS"),PRCDP,PRCERR,PRCMID,PRCVMID,PRCDT,PRCDTS
 K ORCDAT,I,J,K,Y,X,X1,X2,XX,HLA,RQD,RQ1,ORC,PRCCNT,PRCVY
 K XMDUZ,XMMG,XMSUB,XMTEXT,XMY,XMZ,ERRCNT,PRCVERR
 K PRCDATA,PRCSITE,PRCFCP
 Q
 ;
