IBCSC5 ;ALB/MJB - MCCR SCREEN 5 (OPT. EOC) ;27 MAY 88 10:15
 ;;2.0;INTEGRATED BILLING;**52,125,51,210,266,288,287,309,389**;21-MAR-94;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;MAP TO DGCRSC5
 ;
EN I $$INPAT^IBCEF(IBIFN) G ^IBCSC4
 I $D(IBASKCOD) K IBASKCOD D CODMUL^IBCU7 I $$BILLCPT^IBCRU4(IBIFN) D ASK^IBCU7A(IBIFN) S DGRVRCAL=1
 I $D(DGRVRCAL) D ^IBCU6 K DGRVRCAL
 L ^DGCR(399,IBIFN):1
 D ^IBCSCU S IBSR=5,IBSR1="",IBV1="10000000"_$S($$FT^IBCEF(IBIFN)'=2:0,1:1) F I="U",0 S IB(I)=$S($D(^DGCR(399,IBIFN,I)):^(I),1:"") S:IBV IBV1="111111111"
 D H^IBCSCU
 S IBPTF=$P(IB(0),U,8),IBBT=$P(IB(0),"^",4)_$P(IB(0),"^",5)_$P(IB(0),"^",6)
 D EN4^IBCVA1
 S Z=1,IBW=1 X IBWW W " Event Date : " S Y=$P(IB(0),U,3) D DT^DIQ
 N IBPOARR,IBDATE
 D SET^IBCSC4D(IBIFN,"",.IBPOARR)
 S IBDATE=$$BDATE^IBACSV(IBIFN) ; Event date
 S Z=2,IBW=1 X IBWW W " Prin. Diag.: " S Y=$$DX^IBCSC4(0,IBDATE) W $S(Y'="":$P(Y,U,4)_" - "_$P(Y,U,2),$$DXREQ^IBCSC4(IBIFN):IBU,1:IBUN)
 F I=1:1:4 S Y=$$DX^IBCSC4(+Y,IBDATE) Q:Y=""  W !?4,"Other Diag.: ",$P(Y,U,4)_" - "_$P(Y,U,2)
 I +Y S Y=$$DX^IBCSC4(+Y,IBDATE) I +Y W !?4,"***There are more diagnoses associated with this bill.***"
OP S Z=3,IBW=1 X IBWW W " OP Visits  : " F I=0:0 S I=$O(^DGCR(399,IBIFN,"OP",I)) Q:'I  S Y=I X ^DD("DD") W:$X>67 !?17 W Y_", "
 S:$D(^DGCR(399,"OP")) DGOPV=1 I '$O(^DGCR(399,IBIFN,"OP",0)) W IBU
 S Z=4,IBW=1 X IBWW W " Cod. Method: ",$S($P(IB(0),U,9)="":IBUN,$P(IB(0),U,9)=9:"ICD-9-CM",$P(IB(0),U,9)=4:"CPT-4",1:"HCPCS")
 D WRT:$D(IBPROC)
 S Z=5,IBW=1 X IBWW W " Rx. Refills: " S Y=$$RX I 'Y W IBUN
OCC G OCC^IBCSC4
 W !?4,"Opt. Code  : ",IBUN
 G OCC^IBCSC4
 Q
MORE W !?4,*7,"***There are more procedures associated with this bill.***" S I=0
 Q
WRT ;  -write out procedures codes on screen
 N IBDATE
 S J=0 F I=1:1 S J=$O(IBPROC(J)) Q:'J  D  I I>6 D MORE Q
 .S IBDATE=$P(IBPROC(J),U,2) I 'IBDATE S IBDATE=$$BDATE^IBACSV($G(IBIFN))
 .S X=$$PRCD^IBCEF1($P(IBPROC(J),U),1,IBDATE)
 .I IBPROC(J)["ICD" W !?4,"ICD Code   : ",$E($P(X,U,3),1,28)_" - "_$P(X,U,2)
 .I IBPROC(J)["CPT" W !?4,"CPT Code   : " D
 .. N Z
 .. S Z=$P(X,"^",3)_" "_$P(X,"^",2)_$S($P(IBPROC(J),U,15):"-"_$$MODLST^IBEFUNC2($P(IBPROC(J),U,15)),1:"")
 .. I $L(Z)>40 S Z=" "_$P(X,"^",2)_$S($P(IBPROC(J),U,15):"-"_$$MODLST^IBEFUNC2($P(IBPROC(J),U,15)),1:""),Z=$E($P(X,U,3),1,40-$L(Z))_Z
 .. W Z
 .I $P(IB(0),U,19)=2 S Y=+$P(IBPROC(J),U,11) S:+Y Y=+$G(^IBA(362.3,+Y,0)) W ?58,$P($$ICD9^IBACSV(Y,IBDATE),U) S Y=$P(IBPROC(J),U,2) D D^DIQ W ?67,Y Q
 .S Y=$P(IBPROC(J),"^",2) D D^DIQ W ?67,Y
 Q
 ;
MOD(IBM,PUNC) ; Returns modifier list from comma delimited ien's in string IBM
 ; PUNC = Punctuation to use as first character of output
 N IBMOD,Q
 S IBMOD=""
 F Q=1:1:$L(IBM,",") I $P(IBM,",",Q)'="" S IBMOD=IBMOD_$S(IBMOD'="":",",1:"")_$P($$MOD^ICPTMOD($P(IBM,",",Q),"I"),U,2)
 I IBMOD'="" S IBMOD=$G(PUNC)_IBMOD
 Q IBMOD
 ;
PD() ;prints prosthetic device in external form, returns 0 if there are none
 N IBX,IBY,IBZ,IBN,X S X=0 S IBX=0 F  S IBX=$O(^IBA(362.5,"AIFN"_IBIFN,IBX)) Q:'IBX  D  Q:X>5
 . S IBY=0 F  S IBY=$O(^IBA(362.5,"AIFN"_IBIFN,IBX,IBY)) Q:'IBY  S IBZ=$G(^IBA(362.5,IBY,0)) I IBZ'="" D  Q:X>5
 .. S X=X+1 I X>5 W !,?17,"*** There are more Pros. Items associated with this bill.***" Q
 .. W:X'=1 ! W ?17,$E($P(IBZ,U,5),1,40),?67,$$FMTE^XLFDT(+IBZ)
 Q X
 ;
RX() ;prints RX REFILLS in external form, returns 0 if there are none
 N IBX,IBY,IBZ,IBN,X S X=0 S IBX="" F  S IBX=$O(^IBA(362.4,"AIFN"_IBIFN,IBX)) Q:IBX=""  D  Q:X>5
 . S IBY=0 F  S IBY=$O(^IBA(362.4,"AIFN"_IBIFN,IBX,IBY)) Q:'IBY  S IBZ=$G(^IBA(362.4,IBY,0)) I IBZ'="" D  Q:X>5
 .. S X=X+1 I X>5 W !,?17,"*** There are more Rx. Refills associated with this bill.***" Q
 ..D ZERO^IBRXUTL(+$P(IBZ,U,4))
 .. S IBN=$G(^TMP($J,"IBDRUG",+$P(IBZ,U,4),.01)) W:X'=1 ! W ?17,IBN,?65,$$FMTE^XLFDT(+$P(IBZ,U,3))
 K ^TMP($J,"IBDRUG")
 Q X
 ;
 ;IBCSC5
