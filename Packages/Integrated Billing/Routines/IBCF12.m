IBCF12 ;ALB/AAS - PRINT BILL CONT. ;24 MAY 90
 ;;2.0;INTEGRATED BILLING;**133,210**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRP2
 ;
 ;Build ^Utility array of data to print in Block 20
 ;   Print Medicare statment on bottom 4 of 23 lines
 ;   Starting from top print the following, starting and finishing on
 ;     same page.
 ;   Print Revenue codes and subtotal
 ;   Print Additional CPT/ICD codes
 ;   Print offset and totals
 ;   Print Opt visit dates
 ;
 ;^Utility(...)=free text^pointer to rev or date of additional code^additional code variable pointer^"c" if additional code^executable code
 ;             =null ;blank line
% ;
 K ^UTILITY($J) S DGLCNT=0,DGSM=1 D SM^IBCU I 'DGSM D
 .;  -dgsm=1 print medicare statement
 .;  -dgsm=2 print NSC statement
 .;  -dgsm=3 print both statements
 .S DGRNODE=$G(^DGCR(399.3,$P(^DGCR(399,IBIFN,0),"^",7),0))
 .I $P(^DGCR(399,IBIFN,0),"^",11)="i",$P(DGRNODE,"^",8) S DGSM=1
 .I $P(DGRNODE,"^",9) S DGSM=DGSM+2
 .Q
 D ^IBCF14:DGSM
 D REVCOD
 D TOTAL
 D ADDCOD:$O(^DGCR(399,IBIFN,"CP",0))
 D OPVIS:$O(^DGCR(399,IBIFN,"OP",0))
 I DGLCNT<18 D FILL
 S DGCNT=0,DGPAG=1,DGTOTPAG=DGLCNT/23 S:$P(DGTOTPAG,".",2) DGTOTPAG=DGTOTPAG\1+1
 Q
 ;
REVCOD ;I $D(IBIP) S X=IBLS_" DAY"_$S(IBLS>1:"S ",1:" ")_$S(IBBS'=IBU:IBBS,1:"INPATIENT CARE") D SET
 I $D(IBIP) S X=IBLS_" DAY"_$S(IBLS>1:"S ",1:" ")_"INPATIENT CARE" D SET
 S X="" D SET
 S DGBS=""
 F I=0:0 S DGBS=$O(^DGCR(399,IBIFN,"RC","ABS",DGBS)) Q:'DGBS  I $D(^DGCR(399.1,DGBS,0)) S X=$P(^DGCR(399.1,DGBS,0),"^") D SET,RCODE
 ;
 ; -loop thru all REV CODES and print those with no bedsection
 S DGCNT=0,DGDA=0 F I=0:0 S DGDA=$O(^DGCR(399,IBIFN,"RC",DGDA)) Q:'DGDA  I $D(^(DGDA,0)),'$P(^(0),U,5) S X="^"_DGDA D SET
 S X="^^^^W !,""SUBTOTAL"",?39,$S(IB(""U1"")']"""":"""",$P(IB(""U1""),U,1)]"""":$J($P(IB(""U1""),U,1),9,2),1:$J(0,9,2))" D SET
 Q
 ;
 ;Input: DGBS - bedsection, IBIFN - Bill/Claim
RCODE ;Find revenue codes sorted by bedsection
 N DGRV,DGDA,IBCODE
 S DGRV=0 F  S DGRV=$O(^DGCR(399,IBIFN,"RC","ABS",DGBS,DGRV)) Q:'DGRV  D
 . S DGDA=0 F  S DGDA=$O(^DGCR(399,IBIFN,"RC","ABS",DGBS,DGRV,DGDA)) Q:'DGDA  D
 .. S X=U_DGDA D SET
 .. S IBCODE=$P($G(^DGCR(399,IBIFN,"RC",DGDA,0)),U,6) D:IBCODE>0
 ... S X="          Procedure:    "_$P($$CPT^IBACSV(IBCODE),U)
 ... D SET
 Q
ADDCOD ;Find additional codes
 Q:'$D(IBPROC)#2  Q:IBPROC<4
 D RSPACE
 I DGRSPAC<(IBPROC-2) D FILL
 S X="" D SET
 S X="ADDITIONAL PROCEDURE CODES:" D SET
 S J="" F I=1:1 S J=$O(IBPROC(J)) Q:'J  I I>3 S X="^"_$P(IBPROC(J),"^",2)_"^"_$P(IBPROC(J),"^")_"^C" D SET
 Q
 ;
TOTAL ;Find offsets and Totals
 D RSPACE
 I DGRSPAC<$S($P(IB("U1"),"^",2):4,1:2) D FILL
 S X="" D SET
 I $P(IB("U1"),"^",2) S X="^^^^W !,""LESS "",$P(IB(""U1""),""^"",3),?39,$J($P(IB(""U1""),""^"",2),9,2)" D SET S X="" D SET
 S X="^^^^W !,""TOTAL"",?31,$S(+$P(IBEPAR(1),""^"",10):""001"",1:""""),?39,$J($P(IB(""U1""),""^"")-$P(IB(""U1""),""^"",2),9,2)" D SET
 Q
 ;
OPVIS ;Find outpatient Visit dates
 D RSPACE
 S DGCNT=0 F I=0:0 S I=$O(^DGCR(399,IBIFN,"OP",I)) Q:'I  S DGCNT=DGCNT+1
 S DGCNT=DGCNT/3 I $P(DGCNT,".",2)]"" S DGCNT=DGCNT\1+1
 I DGRSPAC<(DGCNT+1) D FILL
 S X="" D SET
 S X="OP VISIT DATE(S) BILLED              "
 S IB01=0 F IB02=1:1 S IB01=$O(^DGCR(399,IBIFN,"OP",IB01)) Q:'IB01  S Y=IB01 X ^DD("DD") S X=X_Y_$S($O(^DGCR(399,IBIFN,"OP",IB01)):", ",1:"") I '(IB02#3) D SET S X="                                     "
 I (IB02-1)#3 D SET
 K IB01,IB02
 Q
 ;
SET S DGLCNT=DGLCNT+1
 I DGLCNT<24,DGSM,DGLCNT+$S(DGSM=1:5,DGSM=2:2,1:8)>23 S DGLCNT=24
 G:$D(^UTILITY($J,"IB-RC",DGLCNT)) SET
 S ^UTILITY($J,"IB-RC",DGLCNT)=X Q
 Q
 ;
RSPACE ;Find remaining blank lines
 S DGRSPAC=$S(DGLCNT<24:$S(DGSM=1:18,DGSM=2:21,DGSM=3:15,1:23)-DGLCNT,DGLCNT<47:46-DGLCNT,DGLCNT<70:69-DGLCNT,DGLCNT<93:92-DGLCNT,DGLCNT<116:115,1:138)
 Q
FILL ;fill space with blank lines so all will fit on page
 F I=0:0 Q:($S(DGSM=1&(DGLCNT=18):1,DGSM=2&(DGLCNT=21):1,DGSM=3&(DGLCNT=15):1,1:0))!('(DGLCNT#23))  S X="" D SET
 Q
