IBDFOSG1 ;ALB/MAF/AAS - SCANNED ENCOUNTERS WITH BILLING DATA CONT. ; JUL 6 1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**29**;APR 24, 1997
 ;
START ;  -- Loop thru clinics
 N IBDFCLIN,IBQUIT
 S IBQUIT=0
 S ^TMP("GTOT",$J)="0^0^0^0^0^0^0^0^0"
 F IBDFCLIN=0:0 S IBDFCLIN=$O(^SC(IBDFCLIN)) Q:'IBDFCLIN  D CK(IBDFCLIN),BLD:'IBQUIT
 Q
 ;
CHECK(CLIN) ;
 ;  -- Check to see if clinic has a form and its one that
 ;     is not for future use only.
 N IBDFNODE,IBDFCL,HASFORM
 S HASFORM=1
 I $O(^SD(409.95,"B",+CLIN,0)) D
 .S IBDFCL=$O(^SD(409.95,"B",+CLIN,0))
 .S IBDFNODE=^SD(409.95,IBDFCL,0)
 Q HASFORM
 ;
CK(XCL) ;  -- Check clinic, division, form
 Q:'$D(^SC(XCL,0))
 S IBQUIT=0
 S IBDFNODE=$G(^SC(XCL,0))
 Q:$P(IBDFNODE,"^",3)'="C"
 S IBDIVNM=$P($G(^DG(40.8,+$P(IBDFNODE,"^",15),0)),"^",1) I IBDIVNM="" S IBDIVNM=$S(IBDFMUL=0:$$PRIM^VASITE,1:"NOT SPECIFIED")
 I VAUTD=0 Q:'$D(VAUTD(+$P(IBDFNODE,"^",15)))
 I '$$CHECK(XCL) S IBQUIT=1 Q
 S ^TMP("CTOT",$J,IBDIVNM,$P(IBDFNODE,"^",1))="0^0^0^0^0^0^0^0^0"
 I '$D(^TMP("DTOT",$J,IBDIVNM)) S ^TMP("DTOT",$J,IBDIVNM)="0^0^0^0^0^0^0^0^0"
 Q
 ;
BLD ; -- scan appts
 F IBDFT=IBDFBEG:0 S IBDFT=$O(^SC(IBDFCLIN,"S",IBDFT)) Q:'IBDFT!($P(IBDFT,".",1)>IBDFEND)  D
 .F IBDFDA=0:0 S IBDFDA=$O(^SC(IBDFCLIN,"S",IBDFT,1,IBDFDA)) Q:'IBDFDA  I $D(^SC(IBDFCLIN,"S",IBDFT,1,IBDFDA,0)) S IBDFSA=^(0) S DFN=+IBDFSA D CK1
 Q
 ;
CK1 ;  -- Check scheduling nodes, forms tracking, if scanned, 
 ;           patient insured, bill entered, bill printed, 
 ;           avg time from encounter to printed bill.
 ;
 I $P($G(^DPT(DFN,"S",IBDFT,0)),"^",2)]"" Q
 N IBDFXPC,IBDFYPC
 S IBDFXPC=$P(IBDFNODE,"^",1) ;Clinic name
 S IBDFYPC=$P($G(^DPT(+$G(DFN),0)),"^",1) ;patient name
 ;
 I $D(^IBD(357.96,"APTAP",DFN,IBDFT)) S IBDFIFN=$O(^IBD(357.96,"APTAP",DFN,IBDFT,0)) I $P($G(^IBD(357.96,+IBDFIFN,0)),"^",11)>1,$P(^(0),"^",11)<5 D
 .S (IBFLG1,IBFLG2,IBFLG3,IBFLG5,IBFLG6,IBFLG7,IBFLG8,IBFLG9)=0
 .I $$INSURED^IBCNS1(DFN,IBDFT) S IBFLG3=1
 .I '$D(^DGCR(399,"AOPV",DFN,$P(IBDFT,".",1))) D SET Q
 .F IBDFNUM=0:0 S IBDFNUM=$O(^DGCR(399,"AOPV",DFN,$P(IBDFT,".",1),IBDFNUM)) Q:IBDFNUM']""!(IBFLG2)  D
 ..S IBMCNODE=$G(^DGCR(399,IBDFNUM,0))
 ..S IBMCSND=$G(^DGCR(399,IBDFNUM,"S"))
 ..Q:$P(IBMCSND,"^",17)  ;canceled date
 ..I 'IBFLG1,$P(IBMCSND,"^",1) D  ;bill entered
 ...S IBFLG1=1,^TMP("IBD-ENTERED",$J,IBDFNUM)="",^TMP("IBD-ENTERED",$J,IBDIVNM,IBDFNUM,DFN)=""
 ..I $P(IBMCSND,"^",12),'$D(^TMP("IBD-PRINTED",$J,IBDFNUM)) S IBFLG2=1,^TMP("IBD-PRINTED",$J,IBDFNUM)="" ;bill printed
 ..;
 ..; -- find amount billed/received if unique bill
 ..I IBFLG2,'$D(^TMP("IBD-BILL",$J,IBDFNUM)) D
 ...S ^TMP("IBD-BILL",$J,IBDFNUM)=1
 ...S IBFLG6=+$P(^DGCR(399,IBDFNUM,"U1"),"^")
 ...S X=$$TPR^PRCAFN(IBDFNUM) S:X>0 IBFLG7=X
 ...S IBFLG8=1 ;is new unique bill
 ...S IBFLG9=+$P($G(^DGCR(399,IBDFNUM,"OP",0)),"^",4)
 ...Q
 ..Q
 .;
 .S X1=$S($P(IBMCSND,"^",12):$P(IBMCSND,"^",12),1:$G(VADAT("W"))),X2=IBDFT D ^%DTC S IBFLG5=X
 .D SET
 Q
SET ;  -- Set counters in temp arrays
 ;     Piece 1 := Number bills entered
 ;     Piece 2 := Number bills generated
 ;     Piece 3 := Number of forms scanned for patients with INS
 ;     Piece 4 := Number of forms scanned
 ;     Piece 5 := Number of days from encounter date to bill printed
 ;     Piece 6 := amount billed (for unique bill)
 ;     Piece 7 := amount received (for unique bills)
 ;     Piece 8 := number of unique bills
 ;     Piece 9 := Number of visit dates on bills in 8
 ;
 S ^TMP("MCCR",$J,IBDIVNM,IBDFXPC,IBDFYPC,DFN,IBDFT)=IBDFCLIN_"^"_^IBD(357.96,IBDFIFN,0)
 ;
 S IBDFTMP=^TMP("CTOT",$J,IBDIVNM,$P(IBDFNODE,"^",1))
 S IBDFTMP1=^TMP("DTOT",$J,IBDIVNM)
 S IBDFTMP2=^TMP("GTOT",$J)
 ;
 I IBFLG1 D INC(1,1) ;     Bills Entered
 I IBFLG2 D INC(2,1) ;     Bills Generated
 I IBFLG3 D INC(3,1) ;     With insurance
 D INC(4,1) ;              number scanned
 I IBFLG5 D INC(5,IBFLG5) ;Days from encounter to Printed Bill
 I IBFLG6 D INC(6,IBFLG6) ;Amount billed
 I IBFLG7 D INC(7,IBFLG7) ;Amount Received
 I IBFLG8 D INC(8,1) ;     Number of Bills
 I IBFLG9 D INC(9,IBFLG9) ;number of visits on bills
 ;
 S ^TMP("CTOT",$J,IBDIVNM,$P(IBDFNODE,"^",1))=IBDFTMP
 S ^TMP("DTOT",$J,IBDIVNM)=IBDFTMP1
 S ^TMP("GTOT",$J)=IBDFTMP2
 Q
 ;
INC(PIECE,VALUE) ;
 ; -- increment counters, 
 S $P(IBDFTMP,"^",PIECE)=$P(IBDFTMP,"^",PIECE)+VALUE
 S $P(IBDFTMP1,"^",PIECE)=$P(IBDFTMP1,"^",PIECE)+VALUE
 S $P(IBDFTMP2,"^",PIECE)=$P(IBDFTMP2,"^",PIECE)+VALUE
 Q
