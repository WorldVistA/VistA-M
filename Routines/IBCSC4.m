IBCSC4 ;ALB/MJB - MCCR SCREEN 4 (INPT. EOC) ;27 MAY 88 10:17
 ;;2.0;INTEGRATED BILLING;**52,51,210,245,155,287,349,403,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;MAP TO DGCRSC4
 ;
EN I $P(^DGCR(399,IBIFN,0),"^",5)>2 G EN^IBCSC5
 I $D(IBASKCOD) K IBASKCOD D CODMUL^IBCU7 I $$BILLCPT^IBCRU4(IBIFN) D ASK^IBCU7A(IBIFN) S DGRVRCAL=1
 I $D(DGRVRCAL) D ^IBCU6 K DGRVRCAL
 D ^IBCSCU S IBSR=4,IBSR1="",IBV1="0000000"_$S($$FT^IBCEF(IBIFN)'=2:0,1:1),IBUC="UNSPECIFIED CODE"
 S:IBV IBV1="11111111"
 D H^IBCSCU F I=1:1:4 S Y="Q"_I_"^IBCVA" D @Y
 D INP
 S IBBT=$P(IB(0),"^",4)_$P(IB(0),"^",5)_$P(IB(0),"^",6)
 D:DGPT(0)]"" DX^IBCSC4A D OCC^IBCVA1
 I '$P(DGPT(0),U,6) W !?26,$S('DGPT(0):"No PTF record for this ADMISSION",1:"PTF record status: OPEN")
 S J=$P(IB("U"),U,20),J=$S(J=99:"",J="":"",J=0:"",$L(J)=1:".0"_J,1:"."_J)
 S Z=1 X IBWW W " Admission  : " S I=$S($P(DGPT(0),U,2)]"":$P(DGPT(0),U,2),1:$P(IBIP,U,2)_J) S:$P(I,".",2)=""&I $P(I,".",2)="2400"
 S Y=$$FMTE^XLFDT(I,"1P")
 W Y,?49,"Accident Hour: ",$S($P(IB("U"),U,10)=99:IBU,$P(IB("U"),U,10)'="":$P(IB("U"),U,10),1:IBU)
 W !?4,"Source     : " S I=$P(^DD(399,159,0),U,3),I=$P($P(I,";",($P(IB("U"),U,9))),":",2) W I
 ;
 ; IB*2*400 - new values added to field# 158
 N ATIN,ATEX
 S ATIN=+$P($G(IB("U")),U,8),ATEX=""
 I ATIN S ATEX=$$EXTERNAL^DILFD(399,158,,ATIN)
 I ATIN=9 S ATEX="INFO NOT AVAIL"    ; so it fits on the screen
 I ATEX="" S ATEX=IBU
 W ?58,"Type: ",ATEX
 ;
 D OT
 S Z=2 X IBWW
 W " Discharge  : " S Y=$S($P(IBIP,U,6)>0:$P(IBIP,U,6),1:"") X ^DD("DD") W $S(Y]"":Y,1:IBU)
 W !?4,"Status     : ",$S($P(IB("U"),U,12)]""&($D(^DGCR(399.1,(+$P(IB("U"),"^",12)),0))):$P(^(0),"^",1),1:IBU)
 N IBPOARR,IBDATE,NEEDPOA,POA
 D SET^IBCSC4D(IBIFN,"",.IBPOARR)
 S IBDATE=$$BDATE^IBACSV(+$G(IBIFN)) ; The EVENT DATE of the bill
 S NEEDPOA=$$INPAT^IBCEF(IBIFN)&($$FT^IBCEF(IBIFN)=3)
 S Z=3,IBW=1 X IBWW W " Prin. Diag.: " S Y=$$DX(0,IBDATE),POA="" S:NEEDPOA&(Y'="") POA=$P(IBPOARR(+Y),U,3)
 W $S(Y'="":$P(Y,U,4)_" - "_$P(Y,U,2)_$S(POA=""!(POA=1):"",1:" ("_POA_")"),$$DXREQ(IBIFN):IBU,1:IBUN)
 F I=1:1:4 S Y=$$DX(+Y,IBDATE) Q:Y=""  D
 .S POA="" S:NEEDPOA POA=$P(IBPOARR(+Y),U,3)
 .W !?4,"Other Diag.: ",$P(Y,U,4)_" - "_$P(Y,U,2)_$S(POA=""!(POA=1):"",1:" ("_POA_")")
 .Q
 I +Y S Y=$$DX(+Y,IBDATE) I +Y W !?4,"***There are more diagnoses associated with this bill.***"
 S Z=4,IBW=1,DGPCM=$P(IB(0),U,9) X IBWW W " Cod. Method: ",$S(DGPCM="":IBUN,DGPCM=9:"ICD-9-CM",DGPCM=4:"CPT-4",1:"HCPCS")
 D:$D(IBPROC) WRT^IBCSC5
OCC ;
 S Z=$S($P(IB(0),U,5)<3:5,1:6)
 S IBW=1 X IBWW W " Pros. Items: " S Y=$$PD^IBCSC5 I 'Y W IBUN
 S Z=$S($P(IB(0),U,5)<3:6,1:7) X IBWW
 W " Occ. Code  : " F I=1:1:5 I $D(IBO(I)) W:I>1 !?4,"Occ. Code  : ",$E(IBOCN(I),1,27) W:I=1 $E(IBOCN(I),1,27) S Y=IBOCD(I) X ^DD("DD") W ?55,Y S Y=IBOCD2(I) I +Y X ^DD("DD") W " - ",Y
 I '$D(IBO) W IBUN
 I $D(IBO)=1,IBO="" W IBUN
 S Z=$S($P(IB(0),U,5)<3:7,1:8) X IBWW
 W " Cond. Code : " F I=1:1:5 I $D(IBCC(I)) W:I>1 !?4,"Cond. Code : ",IBCCN(I) W:I=1 IBCCN(I)
 I '$D(IBCC) W IBUN
 I $D(IBCC)=1,IBCC="" W IBUN
 S Z=$S($P(IB(0),U,5)<3:8,1:9)
 X IBWW W " Value Code : " S IBVC=0
 I $$FT^IBCEF(IBIFN)'=2 D
 . D VC^IBCVA1 I +IBVC S J=1,I=0 F  S I=$O(IBVC(I)) Q:'I  W:J>1 !,?3," Value Code : " W ?17,$E($P(IBVC(I),U,2),1,40),?58,$P(IBVC(I),U,3) S J=J+1
 W:'IBVC IBUN K IBVC
 D Q^IBCSC4B G ^IBCSCP
 Q
OCC1 W $P(^DGCR(399,IBIFN,"CP",I,0),"^",3)_" - "_$P($$PRCD^IBCEF1($P(^DGCR(399,IBIFN,"CP",I,0),U)),U),?55,"Date: ",Y
 Q
 ;IBIP= PTF ptr (399,.08) ^ PTF admiss dt (45,2) or Event dt (399,.03)^ accident hour (399,160) 
 ; ^ source of addmis (399,159) ^ typ of addmiss (399,158)
 ; ^ PTF disch dt (45,70) or Non-VA disch dt (399,.16) ^ disch status (399,162)
 ; ^ dxls (45,79) ^ disch bedsection (399,161)
INP F I="C","U",0 S IB(I)=$S($D(^DGCR(399,IBIFN,I)):^(I),1:"")
 S IBPTF=$P(IB(0),U,8) F I=0,70 S DGPT(I)=$S(IBPTF="":"",$D(^DGPT(IBPTF,I)):^(I),1:"")
 F I="C","U",0 S IB(I)=$S($D(^DGCR(399,IBIFN,I)):^(I),1:"")
 S IBIP=IBPTF_"^"_$S($P(DGPT(0),"^",2)]"":$P(DGPT(0),"^",2),1:$P(IB(0),"^",3))_"^"_$P(IB("U"),"^",10)_"^"_$P(IB("U"),"^",9)_"^"_$P(IB("U"),"^",8)_"^"_$S(+DGPT(70)>0:+DGPT(70),1:$P(IB(0),"^",16))_"^"
 S IBIP=IBIP_$P(IB("U"),"^",12)_"^"_$S($D(DGPT(70)):$P(DGPT(70),"^",10),1:"")_"^"_$P(IB("U"),"^",11)
 Q
SET ;S ^DD(399.0304,0,"ID","WRITE")="N X S X=^(0) W ""   "",$E($P($G(@(U_$P($P(X,U),"";"",2)_+X_"",0)"")),U,$S($P(X,U,1)[""CPT"":2,1:4)),1,30)"
 Q
 ;
DX(ORDER,IBDATE) ; Get next diagnosis data
 N IBX
 S IBX=""
 S ORDER=$O(IBPOARR(ORDER))
 I ORDER S IBX=ORDER_U_$$ICD9^IBACSV(+IBPOARR(ORDER),$G(IBDATE))
 Q IBX
 ;
OT ; print Other Care (SNF) multiple
 N IBX,IBY,IBN I '$O(^DGCR(399,IBIFN,"OT",0)) W !,?4,"SNF Care   : UNSPECIFIED [NOT REQUIRED]"
 S IBX=0 F  S IBX=$O(^DGCR(399,IBIFN,"OT",IBX)) Q:'IBX  D
 . S IBY=$G(^DGCR(399,IBIFN,"OT",IBX,0)) Q:'IBY
 . S IBN=$P($G(^DGCR(399.1,+IBY,0)),U,1),IBN=$S(IBN["SKILLED":"SNF Care ",IBN["SUB-ACUTE":"Sub-Acute",1:"Unknown  ")
 . W !,?4,IBN,"  : ",$$FMTE^XLFDT(+$P(IBY,U,2))," - ",$$FMTE^XLFDT(+$P(IBY,U,3))
 Q
 ;
DXREQ(IBIFN) ; Is the principle diagnosis code required or not?
 ; Function returns true (1) if DX is required for this bill, otherwise 0
 NEW REQ,IBFT
 S REQ=0,IBFT=$$FT^IBCEF(IBIFN)
 I IBFT=2 S REQ=1 G DXREQX                            ; required for CMS-1500
 I IBFT=3,$$WNRBILL^IBEFUNC(IBIFN) S REQ=1 G DXREQX   ; UB with Medicare (WNR) current payer
DXREQX ;
 Q REQ
 ;
 ;IBCSC4
