IBCVA1 ;ALB/MJB - SET MCCR VARIABLES CONT. ;09 JUN 88 14:49
 ;;2.0;INTEGRATED BILLING;**52,80,109,51,137,210,349,371**;21-MAR-94;Build 57
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;MAP TO DGCRVA1
 ;
 Q
4 ;Event variables set
 D 1234^IBCVA
 Q:'$D(IBBT)
EN4 I $E(IBBT,2)>2 G OCC
INP D INP^IBCSC4
 ;NOTE (12/1/93): IBDI AND IBDIN ARRAYS WERE NOT UPDATED WITH NEW DX LOCATIONS BECAUSE THEY DO NOT SEEM TO BE USED ANYWHERE
OCC I $D(^DGCR(399,IBIFN,"C")) D
 . N IBDATE,IBC
 . S IBDATE=$$BDATE^IBACSV(IBIFN) ; The date of service
 . S IBC=^DGCR(399,IBIFN,"C")
 . F I=14:1:18 S IBDI(I)=$P(IBC,U,I) Q:IBDI(I)=""  D
 .. S IBDIN(I)=IBDI(I)
 .. S IBDI(I)=$P($$ICD9^IBACSV(IBDI(I),IBDATE),U,3)
 K IBO S:'$D(^DGCR(399,IBIFN,"OC")) IBO="" G:$D(IBO) COND S IBNO=$P(^DGCR(399,IBIFN,"OC",0),U,3),IBOC=0
 S C=0 F I=0:1 S IBOC=$O(^DGCR(399,IBIFN,"OC",I)) Q:IBOC'?1N.N!(C=5)  I $D(^DGCR(399,IBIFN,"OC",I)) S C=C+1 D SOCC
 ;
COND S IBCC=0,D=0 F I=0:0 S IBCC=$O(^DGCR(399,IBIFN,"CC",IBCC)) Q:IBCC=""!(D=5)  I $D(^DGCR(399,IBIFN,"CC",IBCC,0)) S D=D+1,IBCC(D)=$P(^DGCR(399,IBIFN,"CC",IBCC,0),"^",1) D CONDN
 ;
 D PROC
 ;
 ;Q:'$D(^DGCR(399,IBIFN,"C"))  F I=0,"C" S IB(I)=$S($D(^DGCR(399,IBIFN,I)):^(I),1:"")
 ;I $P(IB(0),"^",9)=4 F I=1:1:3 S:$P(IB("C"),"^",I)'="" IBCPT(I)=$P(IB("C"),"^",I)
 ;I $P(IB(0),"^",9)=9 F I=4:1:6 S:$P(IB("C"),"^",I)'="" IBICD(I)=$P(IB("C"),"^",I)
 ;I $P(IB(0),"^",9)=5 F I=7:1:9 S:$P(IB("C"),"^",I)]"" IBHC(I)=$P(IB("C"),"^",I),IBHCN(I)=$S($D(^ICPT(IBHC(I),0)):$P(^(0),"^",1),1:"")
 Q
 ;
5 ;Billing variables set
 D 123^IBCVA
EN5 I '$D(IBIP) G REVC
 S IBLS=$S($P(IB("U"),U,15)]"":$P(IB("U"),U,15),1:0),IBBS=$S($P(IB("U"),U,11)]"":$P(IB("U"),U,11),1:IBU) I IBBS'=IBU S IBBS=$P(^DGCR(399.1,IBBS,0),"^",1)
REVC S IBREV=0 F I=1:1 S IBREV=$O(^DGCR(399,IBIFN,"RC",IBREV)) Q:IBREV'?1.N  S IBREVC(I)=^DGCR(399,IBIFN,"RC",IBREV,0)
 S IBTF=$P(IB(0),U,26),IBTF=$S(IBTF=1:"ADMIT THRU DISCHARGE",IBTF=2:"FIRST CLAIM",IBTF=3:"CONTINUING CLAIM",IBTF=4:"LAST CLAIM",IBTF=5:"LATE CHARGE(S)",IBTF=6:"ADJUSTMENT",IBTF=7:"REPLACEMENT",IBTF=8:"CANCEL",IBTF=0:"ZERO CLAIM",1:"")
 S IBBTP1=$E($$EXPAND^IBTRE(399,.24,$P(IB(0),U,24)),1,29)
 S IBBTP2=$E($$EXPAND^IBTRE(399,.25,+$P(IB(0),U,25)),1,26)
 S IBBTP3=IBTF
 Q
SOCC S IBO(C)=$P(^DGCR(399,IBIFN,"OC",IBOC,0),"^",1),IBO(C)=$P(^DGCR(399.1,IBO(C),0),"^",2),IBOCN(C)=$P(^(0),"^",1)
 S IBOCD(C)=$P(^DGCR(399,IBIFN,"OC",IBOC,0),"^",2),IBOCD2(C)=$P(^DGCR(399,IBIFN,"OC",IBOC,0),"^",4) Q
 Q
 ;
CONDN S IBCC(D)=$P($G(^DGCR(399.1,+IBCC(D),0)),U,2),IBCCN(D)=$P($G(^(0)),U,1)
 Q
 ;
PROCX ; Entrypoint from output formatter
 N IBIFN,IBZ
 S IBIFN=$G(IBXIEN)
 D PROC
 D F^IBCEF("N-PROCEDURE CODING METHD","IBZ",,IBIFN)
 I IBZ="" K IBPROC S IBPROC=0 Q
 S Z=0 F  S Z=$O(IBPROC(Z)) Q:'Z  I $P(IBPROC(Z),U)'[$S(IBZ=9:";ICD",1:";ICP") K IBPROC(Z) S IBPROC=IBPROC-1
 Q
 ;
PROC ;  -build array of procedures in IBPROC
 N IBHCFA,IBMOD,I,J,X,X1
 S IBHCFA=($$FT^IBCEF(IBIFN)=2)
 K IBPROC S IBPROC=0
 I '$D(IB("C")) S IB("C")=$G(^DGCR(399,IBIFN,"C"))
 S:'$D(IB(0)) IB(0)=$G(^DGCR(399,IBIFN,0)) S J=$P($G(IB(0)),"^",9)
 I IB("C")'="" F I=1:1:9 I $P(IB("C"),"^",I)'="" S IBPROC(I)=$P(IB("C"),"^",I)_";"_$S(I<4:"ICPT(",I<7:"ICD0(",1:"ICPT(")_"^"_$P(IB("C"),"^",$S(I#3:10+(I#3),1:13)),IBPROC=IBPROC+1
 I $D(^DGCR(399,IBIFN,"CP")) S X=0 F I=100:1 S X=$O(^DGCR(399,IBIFN,"CP",X)) Q:'X  S X1=$G(^(X,0)) Q:'X1  D
 . S IBMOD=$$GETMOD^IBEFUNC(IBIFN,X)
 . I $TR(IBMOD,",")'="" S $P(X1,U,15)=IBMOD
 . S IBPROC($S($P(X1,"^",4):$P(X1,"^",4),1:I))=X1
 . I IBHCFA S IBPROC($S($P(X1,"^",4):$P(X1,"^",4),1:I),"AUX")=$G(^DGCR(399,IBIFN,"CP",X,"AUX"))
 . S IBPROC=IBPROC+1
PROCQ Q
 ;
ALLPROC(IBIFN,IBPROC) ; Returns all procedures for bill IBIFN in array IBPROC
 ;  IBPROC = # of procedures found
 ;  IBPROC(prnt order)=0-node of 'CP' entry with piece 15 = the
 ;                      modifiers separated by commas
 ;  IBPROC(prnt order,"AUX")="AUX" node of 'CP' entry for CMS-1500 forms
 ; Pass IBPROC by reference
 ;
 N IB
 K IBPROC
 D PROC
 Q
 ;
VC ;returns a bills value codes, IBIFN must be defined: IBVC=count,IBVC(VIFN)=CODE ^ NAME ^ VALUE ^ $$?
 N IBY,IBX,IBZ S IBVC=0 Q:'$D(^DGCR(399,IBIFN,"CV"))
 S IBX=0 F  S IBX=$O(^DGCR(399,IBIFN,"CV",IBX)) Q:'IBX  S IBY=$G(^DGCR(399,IBIFN,"CV",IBX,0)) I +IBY D
 . S IBVC=IBVC+1,IBZ=$G(^DGCR(399.1,+IBY,0)) Q:IBZ=""
 . S IBVC(+IBY)=$P(IBZ,U,2)_U_$P(IBZ,U,1)_U_$S($P(IBY,U,2)="":"",+$P(IBZ,U,12):$J($P(IBY,U,2),0,2),1:$P(IBY,U,2))_U_$P(IBZ,U,12)
 Q
 ;
SETMODS(IBMOD,IBZ,IBXSAVE) ; Set modifiers into IBXSAVE
 ; IBMOD = the list of modifier iens for the proc, separated by commas
 ; IBZ = the line counter to return the data in
 ;
 ; Output Formatter utility
 ;
 ; Variables passed by reference, returned
 ; IBXSAVE("PROCMODS",IBZ) = Formatter 'save' array for modifiers
 ;
 N Q,IBQ
 I $L(IBMOD) F Q=1:1:$L(IBMOD,",") I $P(IBMOD,",",Q)'="" D
 . S IBQ=$$MOD^ICPTMOD(+$P(IBMOD,",",Q),"I")
 . S IBXSAVE("PROCMODS",IBZ)=$G(IBXSAVE("PROCMODS",IBZ))_$P(IBQ,U,2)_","
 S Q=$L($G(IBXSAVE("PROCMODS",IBZ)))
 I 'Q S IBXSAVE("PROCMODS",IBZ)=""
 I Q S IBXSAVE("PROCMODS",IBZ)=$E(IBXSAVE("PROCMODS",IBZ),1,Q-1)
 Q
 ;
