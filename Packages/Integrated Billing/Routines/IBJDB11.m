IBJDB11 ;ALB/CPM - BILLING LAG TIME REPORT (COMPILE) ; 27-DEC-96
 ;;2.0;INTEGRATED BILLING;**69,100,118,165**;21-MAR-94
 ;
EN ; - Entry point from IBJDB1.
 ;
 ; - 
 I IBRPT="D" F X=2,3,4,6,7,8 S:IBSEL[X IBSEL=IBSEL_X_"I,"
 I 'IBSORT D INIT(0) G REV
 S X=0 F  S X=$S('VAUTD:$O(VAUTD(X)),1:$O(^DG(40.8,X))) Q:'X  D INIT(X)
 ;
REV ; - Review all claims in file #399.
 S IBN=0 F  S IBN=$O(^DGCR(399,IBN)) Q:'IBN  S IBN0=$G(^(IBN,0)) D  Q:IBQ
 .I IBN#100=0 S IBQ=$$STOP^IBOUTL("Billing Lag Time Report") Q:IBQ
 .;
 .I $P($G(^PRCA(430,IBN,0)),U,2)'=9 Q  ;              Not an RI claim.
 .I $P(IBN0,U,13)<3 Q  ;                              Not authorized.
 .I $P(IBN0,U,13)=7 Q  ;                              Cancelled in IB.
 .S X=$P($G(^PRCA(430,IBN,0)),U,8) I X=26!(X=39) Q  ; Cancelled in AR.
 .;
 .; - Does claim meet report criteria?
 .S IBAUTH=$$AUTH(IBN) I 'IBAUTH Q
 .;
 .; - Get division, if necessary.
 .I 'IBSORT S IBDIV=0
 .E  S IBDIV=$$DIV^IBJDF2(IBN) I 'IBDIV S IBDIV=+$$PRIM^VASITE()
 .I IBSORT,'VAUTD,'$D(VAUTD(IBDIV)) Q  ;  Not a selected division.
 .;
 .S IBTY=$S($P(IBN0,U,5)<3:"IN",1:"OP") ; Inpatient or outpatient claim?
 .;
 .;- Get date PTF transmitted.
 .S IBPTF="" I IBTY="IN" S IBPTF=$$PTF($P(IBN0,U,8)) Q:'IBPTF
 .;
 .; - Get other claim info and build date line.
 .S IBDAT=$P(IBAUTH,U,2,5),DFN=+$P(IBN0,U,2),IBDFN=$G(^DPT(DFN,0))
 .S IBPOL=+$G(^DPT(DFN,.312,+$P($G(^DGCR(399,IBN,"MP")),U,2),1))
 .;
 .; - Get care dates; quit if there are none.
 .K IBDR S IBNU=$G(^DGCR(399,IBN,"U")) D
 ..I IBTY="IN" S X=+$P(IBNU,U,2) S:'X X=+IBNU S:X IBDR(X)="" Q
 ..I '$D(^DGCR(399,IBN,"OP")) D  Q
 ...S X=+$P(IBNU,U,2) S:X IBDR(X)="" S:+IBNU&(+IBNU'=X) IBDR(+IBNU)=""
 ..S X=0 F  S X=$O(^DGCR(399,IBN,"OP",X)) Q:'X  S IBDR(X)=""
 .I '$D(IBDR) Q
 .;
 .; - Calculate statistics for each care date.
 .S IBX=0 F  S IBX=$O(IBDR(IBX)) Q:'IBX  D
 ..;
 ..; - Get discharge date.
 ..I IBTY="IN" D
 ...S IBX1=+$G(^DGPT(+$P(IBN0,U,8),70))\1 I IBX1 Q
 ...S IBX1=+$O(^DGPM("APTT3",DFN,(IBX-.0001)))\1 I 'IBX1 S IBX1=IBX
 ..;
 ..; - Get most recent check out date that has not been marked as non
 ..;   billable by Claims Tracking; quit if there isn't one.
 ..I IBTY="OP" D  K IBCL,IBCL1 Q:'IBCHK
 ...D CL(IBN) ;GET LIST OF CLINICS FOR THIS BILL
 ...S IBCHK=0,IBX1=IBX-.0001
 ...F  S IBX1=$O(^SCE("ADFN",DFN,IBX1)) Q:'IBX1!((IBX1\1)>IBX)  D
 ....S IBX2=0 F  S IBX2=$O(^SCE("ADFN",DFN,IBX1,IBX2)) Q:'IBX2  D
 .....;
 .....;CHECK TO SEE IF CLINICS MATCH
 .....S IBCL1=+$P($G(^SCE(IBX2,0)),U,4) Q:'$D(IBCL(IBCL1))
 .....I $P($G(^IBT(356,+$O(^IBT(356,"ASCE",IBX2,0)),0)),U,19) Q
 .....S IBX3=$P($G(^SCE(IBX2,0)),U,7)\1 I IBX3,IBX3'>$P(IBAUTH,U,2)  D
 ...... S:IBX3>IBCHK IBCHK=IBX3 Q
 ..;
 ..S X=$S(IBTY="IN":IBX1_U_+IBPTF,1:IBX_U_IBCHK)_U_IBDAT
 ..S IBPOL1=$S(IBPOL>+X:1,1:0) ; Policy found after treatment.
 ..;
 ..; - Check date line for at least one date within the user specified
 ..;   range; quit if there isn't any.
 ..S IBDCHK=0 F Y=2:1:6 I $$DL(0,$P(X,U,Y)) S IBDCHK=1 Q
 ..I 'IBDCHK Q
 ..;
 ..K D,Y,Z S IBSEL1=""
 ..F Y=1:1:5 S Z(1)=$P(X,U,Y),Z(2)=$P(X,U,Y+1) D
 ...;
 ...; - Check out date/PTF transmission date.
 ...I Y=1 D:Z(2)  Q
 ....S D(0)=$$FMDIFF^XLFDT(Z(2),Z(1)),Z=$S(IBTY="IN":5,1:1)
 ....I $$DL(Z,Z(2)) S IBSEL1=IBSEL1_Z_",",Y(Z)=$S(IBRPT="D":Z(1)_U_Z(2)_U_D(0),1:D(0))
 ...;
 ...; - Date authorized.
 ...I Y=2 D:Z(1)  Q
 ....S D(1)=$$FMDIFF^XLFDT(Z(2),Z(1)),Z=$S(IBTY="IN":6,1:2)
 ....I $$DL(Z,Z(2)) D
 .....S Z1=$S(IBPOL1:Z_"I",1:Z),IBSEL1=IBSEL1_Z1_",",Y(Z1)=$S(IBRPT="D":Z(1)_U_Z(2)_U_D(1),1:D(1))
 .....I Z1=Z D
 ......S Z2=Z_"I",IBSEL1=IBSEL1_Z2_",",Y(Z2)=$S(IBRPT="D":Z(1)_U_Z(2)_U_D(1),1:D(1))
 ...;
 ...; - Date activated.
 ...I Y=3 D:Z(2)  Q
 ....S D(2)=$$FMDIFF^XLFDT(Z(2),Z(1)) I $$DL(9,Z(2)) S IBSEL1=IBSEL1_"9,",Y(9)=$S(IBRPT="D":Z(1)_U_Z(2)_U_D(2),1:D(2))
 ...;
 ...; - Payment date.
 ...I Y=4 D:Z(2)  Q
 ....S D(3)=$$FMDIFF^XLFDT(Z(2),Z(1)),D(6)=$$FMDIFF^XLFDT(Z(2),+X)
 ....F Z=$S(IBTY="IN":7,1:3),10 I $$DL(Z,Z(2)) D
 .....S Z1=$S(IBPOL1&(Z<10):Z_"I",1:Z),Z2=$S(Z<10:6,1:3)
 .....S IBSEL1=IBSEL1_Z1_",",Y(Z1)=$S(IBRPT="D":$S(Z2=3:Z(1),1:+X)_U_Z(2)_U_D(Z2),1:D(Z2))
 .....I Z1=Z,Z<10 S Z3=Z_"I",IBSEL1=IBSEL1_Z3_",",Y(Z3)=$S(IBRPT="D":$S(Z2=3:Z(1),1:+X)_U_Z(2)_U_D(Z2),1:D(Z2))
 ...;
 ...; - Date closed.
 ...I Z(2) D
 ....S D(4)=$$FMDIFF^XLFDT(Z(2),Z(1)),D(5)=$$FMDIFF^XLFDT(Z(2),+X)
 ....F Z=$S(IBTY="IN":8,1:4),11 I $$DL(Z,Z(2)) D
 .....S Z1=$S(IBPOL1&(Z<11):Z_"I",1:Z),Z2=$S(Z<11:5,1:4)
 .....S IBSEL1=IBSEL1_Z1_",",Y(Z1)=$S(IBRPT="D":$S(Z2=4:Z(1),1:+X)_U_Z(2)_U_D(Z2),1:D(Z2))
 .....I Z1=Z,Z<11 S Z3=Z_"I",IBSEL1=IBSEL1_Z3_",",Y(Z3)=$S(IBRPT="D":$S(Z2=4:Z(1),1:+X)_U_Z(2)_U_D(Z2),1:D(Z2))
 ..;
 ..; - Save data for detail or summary report(s).
 ..F Y=1:1 S Z=$P(IBSEL1,",",Y) Q:'Z  D
 ...I IBRPT="D" D
 ....S IBBN=$P(IBN0,U) S:IBPOL1 IBBN=IBBN_"*"
 ....S Y(Z)=IBBN_U_Y(Z),Y1(Z)=$G(Y1(Z))+1
 ....S ^TMP("IBJDB1",$J,IBDIV,IBTY,Z,$P(IBDFN,U)_"@@"_$P(IBDFN,U,9),Y1(Z))=Y(Z)
 ...E  S IBCT(IBDIV,IBTY,Z)=IBCT(IBDIV,IBTY,Z)+1,IBTL(IBDIV,IBTY,Z)=IBTL(IBDIV,IBTY,Z)+Y(Z)
 ;
 Q
 ;
INIT(X) ; - Initialize summary accumulators/detail division nodes.
 I IBRPT="D" S ^TMP("IBJDB1",$J,X)="" Q
 F Y=1:1:4,9,10,11,"2I","3I","4I" S (IBCT(X,"OP",Y),IBTL(X,"OP",Y))=0
 F Y=5:1:11,"6I","7I","8I" S (IBCT(X,"IN",Y),IBTL(X,"IN",Y))=0
 Q
 ;
AUTH(IBN) ; - Is this an authorized claim?
 ;  Input: IBN=Pointer to the AR in file #430
 ; Output: VAL=1^2^3^4^5, where:
 ;             1=1-Authorized claim
 ;               0-Not an authorized claim
 ;             2=Date AR was authorized
 ;             3=Date AR was activated
 ;             4=AR first payment date
 ;             5=Date AR was closed
 ;
 N IBPAY,IBT,IBT0,IBT1,VAL,X
 S VAL=0 I '$G(IBN) G AUTHQ
 ;
 ; - Get date authorized (required).
 S X=$P($G(^DGCR(399,IBN,"S")),U,10) G:'X AUTHQ S VAL="1^"_X
 ;
 ; - Get date activated, if available.
 S X=$P($G(^PRCA(430,IBN,6)),U,21) I X S $P(VAL,U,3)=X\1 G FP
 S X=$P($G(^PRCA(430,IBN,9)),U,3) I X S $P(VAL,U,3)=X\1 G FP
 S X=$P($G(^PRCA(430,IBN,0)),U,10) I X S $P(VAL,U,3)=X\1
 ;
FP ; - Get first payment date, if available.
 I '$P($G(^PRCA(430,IBN,7)),U,7) G DC ; No payments made.
 S (IBPAY,IBT)=0 F  S IBT=$O(^PRCA(433,"C",IBN,IBT)) Q:'IBT  D  Q:IBPAY
 .S IBT0=$G(^PRCA(433,IBT,0)),IBT1=$G(^(1))
 .I $P(IBT0,U,4)'=2 Q  ;                  Not complete.
 .I $P(IBT1,U,2)'=2,$P(IBT1,U,2)'=34 Q  ; Not a payment.
 .S X=$S(+IBT1:+IBT1,1:$P(IBT1,U,9)\1),$P(VAL,U,4)=X,IBPAY=1
 ;
DC ; - Get date AR closed.
 S X=$$CLO^PRCAFN(IBN) I X>0 S $P(VAL,U,5)=X
 ;
 ; - Is there a payment date AND a closed date for this claim?
 I '$P(VAL,U,4),$P(VAL,U,5) S $P(VAL,U)=0
 ;
AUTHQ Q VAL
 ;
DL(X,X1) ; - Is line item date valid for report?
 ;  Input: X=Line item number (or 0), X1=Line item date
 ; Output: 1=valid, 0=invalid 
 ; *Requires pre-defined variables IBBDT, IBEDT, and IBSEL
 S X2=0 I 'X1 G DLQ
 I 'X S:X1'<IBBDT&(X1'>IBEDT) X2=1 G DLQ
 I IBSEL[(","_X_","),X1'<IBBDT,X1'>IBEDT S X2=1
DLQ Q X2
 ;
 ;
PTF(X) ; - Get most recent PTF transmission date.
 ;    Input: X=IEN of PTF file entry.
 ;   Output: Y=PTF date.
 N I,K,Y
 S Y=0 G:'$O(^DGP(45.83,"C",+X,0)) PTFQ
 S I=0 F  S I=$O(^DGP(45.83,"C",X,I)) Q:'I  D
 .S J=$P($G(^DGP(45.83,I,0)),U,2)\1  Q:J>$P(IBAUTH,U,2)  S:J K(J)=""
 S I=0 F  S I=$O(K(I)) Q:'I  S Y=I
 ;
PTFQ Q Y
 ;
CL(IBN) ; - Get the clinics for bill.
 N I,J K IBCL ; IBCL=Bill clinic array.
 S I=0 F  S I=$O(^DGCR(399,IBN,"CP",I)) Q:I=""  D
 .S J=$P($G(^DGCR(399,IBN,"CP",I,0)),U,7) S:J IBCL(J)=""
 Q
