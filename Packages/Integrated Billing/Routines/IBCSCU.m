IBCSCU ;ALB/MJB - MCCR SCREEN UTILITY ROUTINE ;27 MAY 88 11:09
 ;;2.0;INTEGRATED BILLING;**52,51,348**;21-MAR-94;Build 5
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;MAP TO DGCRSCU
 ;
 S IBW=1,IBU="UNSPECIFIED",IBUN=IBU_" [NOT REQUIRED]",IBV=$S($D(IBV):IBV,1:1) D HOME^%ZIS
 ;S IBWW1="X ""F Z2=1:1:(Z1-$L(Z)) S Z=Z_"""" """""" W Z Q"
 S (IBVO,IBVI)="" I $S('$D(IOST(0)):1,'$D(^DG(43,1,0)):1,'$P(^DG(43,1,0),"^",36):1,$D(^DG(43,1,"TERM",IOST(0))):1,1:0) G M
 ;
 I $D(IOST(0)) S X="IOINHI;IOINLOW;IOINORM" D ENDR^%ZISS
 I $L(IOINHI),$L(IOINLOW) S IBVI=IOINHI,IBVO=$S(IOINORM]"":IOINORM,1:IBINLOW)
 D KILL^%ZISS
 ;I $D(^%ZIS(2,IOST(0),7)) S I=^(7) I $L($P(I,"^",1)),$L($P(I,"^",2)) S IBVI=$P(I,"^",1),IBVO=$S($P(I,"^",3)]"":$P(I,"^",3),1:$P(I,"^",2))
 ;
M ;I $L(IBVI_IBVO)>4 S X=80 X ^%ZOSF("RM")
 S IBWW="W:IBW ! S Z=$S(IBV:""<""_Z_"">"",$E(IBV1,Z):""<""_Z_"">"",1:""[""_Z_""]"") W:$E(Z)=""["" IBVI,Z,IBVO W:$E(Z)'=""["" Z Q"
 ;S IBWW="W:IBW ! S Z=$S(IOST=""C-QUME""&($L(IBVI)'=2):Z,IBV:""<""_Z_"">"",$E(IBV1,Z):""<""_Z_"">"",1:""[""_Z_""]"") W:$E(Z)=""["" @IBVI,Z,@IBVO W:$E(Z)'=""["" Z Q"
 I $D(IBPAR) S IBV=0,IBVV="00000" Q
 S IBBNO=$P(^DGCR(399,IBIFN,0),"^",1)
 S IBVV=$S('$$INPAT^IBCEF(IBIFN):"000101001",1:"000010101"),X="63266556"
 I $P($G(^IBE(353,+$P($G(^DGCR(399,IBIFN,0)),U,19),2)),U,9)'="",$S($D(^DGCR(399,IBIFN,"I1")):1,1:$P($G(^DGCR(399,IBIFN,"M")),U,11)) S $E(IBVV,9)="0"
 Q
 ;
H ;Screen Header
 S L="",$P(L,"=",81)=""
 I $D(IBH("HELP")) S X="HELP SCREEN" W @IOF,!?(40-($L(X)\2)),IBVI,X,IBVO,!,L G HQ
 S X=$P("DEMOGRAPHIC^EMPLOYMENT^PAYER^EVENT - INPATIENT^EVENT - OUTPATIENT^BILLING - GENERAL^BILLING - GENERAL^BILLING - SPECIFIC^LOCALLY DEFINED","^",IBSR)_" INFORMATION",X1="SCREEN <"_+IBSR_">"
 N IB0,IBT S IB0=$G(^DGCR(399,IBIFN,0)),IBT=$P(IB0,U,19),DGINPT=$S($$INPAT^IBCEF(IBIFN):"Inpat",1:"Outpat")
 ;
 W @IOF                                          ; clear screen
 W !,VADM(1)                                     ; name
 W "   ",$P(VADM(2),"^",2)                       ; ssn
 W "   BILL#: ",IBBNO_" - "_DGINPT,"/"           ; claim# - type
 I IBT=2 W "1500"                                ; form type 2
 I IBT=3 W $TR($P($G(^IBE(353,3,0)),U,1),"-")    ; form type 3
 W ?(80-$L(X1)),X1                               ; screen#
 W !,L                                           ; separator line
 W !?(40-($L(X)\2)),IBVI,X,IBVO                  ; screen description
HQ ;
 K L,DGINPT
 Q
 ;
A ;Format Address(es)
 N Y F I=IBA1:1:IBA1+2 I $P(IB(IBAD),U,I)]"" S IBA(IBA2)=$P(IB(IBAD),U,I),IBA2=IBA2+2
 I IBA2=1 S IBA(1)="STREET ADDRESS UNKNOWN",IBA2=IBA2+2
 S J=$S($D(^DIC(5,+$P(IB(IBAD),U,IBA1+4),0)):$P(^(0),U,2),1:""),J(1)=$P(IB(IBAD),U,IBA1+3),J(2)=$P(IB(IBAD),U,IBA1+11),IBA(IBA2)=$S(J(1)]""&(J]""):J(1)_", "_J,J(1)]"":J(1),J]"":J,1:"CITY/STATE UNKNOWN")
 S Y=$S(IBAD=.11!(IBAD=.121):$P(IB(IBAD),U,IBA1+11),IBAD=.25:$P($G(^DPT(+$G(DFN),.22)),U,6),IBAD=.311:$P($G(^DPT(+$G(DFN),.22)),U,5),1:"") D ZIPOUT^VAFADDR
 S IBA(IBA2)=IBA(IBA2)_" "_Y F I=0:0 S I=$O(IBA(I)) Q:I=""  S IBA(I)=$E(IBA(I),1,25)
 K IBA1,I,J Q
