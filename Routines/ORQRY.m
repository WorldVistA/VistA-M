ORQRY ; SLC/MKB/JDL - Order Query utilities ;3/17/03  14:45
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**153,174**;Dec 17, 1997
 ;
 ;
PP(DFN,PROV) ; -- Returns 1 or 0, if PROV is prim prov for DFN
 N X,Y I '$G(DFN)!'$G(PROV) Q ""
 S X=$$OUTPTPR^SDUTL3(+DFN),Y=$S(+X=+PROV:1,1:0)
 Q Y
 ;
ACT(DFN,BEG,END,LOC) ; -- Returns 1 or 0, if recent activity for DFN
 ;  BEG = beginning date [default = DT-1yr]
 ;  END = ending date [default = DT]
 ;  LOC(IEN) = list of clinic IENs from #44 [default = all]
 N X,YY,VASD,VAERR,IDT,DA
 N VSTH,IX,JX
 S DFN=+$G(DFN),YY=0 I '$G(DFN) Q ""
 S BEG=$G(BEG,DT-10000),END=$G(END,DT) ;default=last year
 I END<BEG S X=END,END=BEG,BEG=X
 I '$D(LOC) D  G:YY ACTQ ;check inpatient, Rx data
 . ;curr inpt
 . I $G(^DPT(DFN,.105)) S YY=1 Q
 . S X=+$O(^DGPM("APRD",DFN,BEG))
 . ; admission
 . I X,X'>END S YY=1 Q
 . ;Rx
 . D OCL^PSOORRL(DFN,BEG,END) I $O(^TMP("PS",$J,0)) S YY=1 Q
 S VSTH="",(IX,JX)=0
 D VST^ORWCV(.VSTH,DFN,BEG,END)
 F  S IX=$O(VSTH(IX)) Q:'IX  D
 . F  S JX=$O(LOC(JX)) Q:'JX  D
 . . I +$P($G(VSTH(IX)),";",3)=JX S YY=1 Q
 I YY=1 G ACTQ
 S IDT=BEG-.0001 F  S IDT=$O(^SCE("ADFN",DFN,IDT)) Q:IDT<1!(IDT>END)  D  Q:YY  ;IA #2065
 . I '$D(LOC) S YY=1 Q
 . S DA=0 F  S DA=+$O(^SCE("ADFN",DFN,IDT,DA)) Q:DA<1  I $D(LOC(+$P($G(^SCE(DA,0)),U,4))) S YY=1 Q
ACTQ K ^UTILITY("VASD",$J),^TMP("PS",$J)
 Q YY
 ;
BYPT(ORY,DFN,QRY) ; -- Returns report data in @ORY based on QRY parameters
 Q:'$G(DFN)  N PAT,ORYPAT,VA,VADM,VAIN,VAERR ;M ^XTMP("ORQRY",$G(DUZ)_";"_$H)=QRY
 S ORY=$G(ORY,"^TMP($J)"),DFN=+DFN D OERR^VADPT
 S ORYPAT("Patient.DFN")=DFN,PAT=DFN_";DPT("
 S ORYPAT("Patient.Age")=VADM(4),ORYPAT("Patient.Name")=VADM(1)
 S ORYPAT("Patient.Last4")=$E(VADM(1))_VA("BID")
 S ORYPAT("Patient.Ward")=$S(VAIN(4):$P(VAIN(4),U,2)_" "_VAIN(5),1:"")
 I $D(QRY("Document")) D DOCMTS
 I $D(QRY("Order")) D ORDERS
 I $D(QRY("Consult")) D CSLTS
 I $D(QRY("Visit")) D VISITS
 Q
 ;
DOCMTS ; -- Find documents
 N DOCMT
 M DOCMT=QRY("Document")
 D DOCDT^ORQRY01(.DOCMT)
 D QUERY^TIUQRY(ORY,.DOCMT,.ORYPAT)
 I $D(DOCMT("NegativeSearch")) D NEGATE("Documents")
 Q
 ;
CSLTS ; -- Find consults (treats consults as special case of orders)
 N ORDER,ORGRP,SDATE,EDATE,ORCNT,X,CSLTMODE
 M ORDER=QRY("Consult") S ORCNT=0,CSLTMODE=1
 I '$D(ORDER("DisplayGroup")) D
 . S ORDER("DisplayGroup",$O(^ORD(100.98,"B","CSLT",0)))=""
 G ORDERS1
 ;
ORDERS ; -- Find orders
 N ORDER,ORGRP,SDATE,EDATE,ORCNT,I
 M ORDER=QRY("Order") S ORCNT=0
ORDERS1 N ORCBO I $D(ORDER("ItemCombo1"))>1 S (ORCBO(1),ORCBO(2))=-1
 I $D(ORDER("DisplayGroup"))>1 S I=0 F  S I=$O(ORDER("DisplayGroup",I)) Q:'I  D GRP(I)
 D DATES,@$S($D(ORDER("Abnormal")):"ARSX",1:"ACTX") ;$G(ORDER("View")):"AVWX"
 ; if looking for a combination and both not there, remove the orders
 I $D(ORCBO),((ORCBO(1)=-1)!(ORCBO(2)=-1)) D
 . D RMOV($S($G(CSLTMODE):"CST",1:"ORD"))
 . S ORCNT=0
 S:'$D(CSLTMODE) @ORY@(0,"Orders")=ORCNT
 S:$D(CSLTMODE) @ORY@(0,"Consults")=ORCNT
 I $D(ORDER("NegativeSearch")) D NEGATE($S($G(CSLTMODE):"Consults",1:"Orders"))
 Q
 ;
GRP(DG) ; -- Setup display group DG in ORGRP()
 N STK,MEM
 S ORGRP(DG)="",STK=1,STK(STK)=DG_"^0",STK(0)=0,MEM=0
 F  S MEM=$O(^ORD(100.98,+STK(STK),1,MEM)) D @$S(+MEM'>0:"POP",1:"PROC") Q:STK<1
 Q
POP S STK=STK-1,MEM=$P(STK(STK),"^",2)
 Q
PROC S $P(STK(STK),"^",2)=MEM,DG=$P(^ORD(100.98,+STK(STK),1,MEM,0),"^",1)
 S ORGRP(DG)="",STK=STK+1,STK(STK)=DG_"^0",MEM=0
 Q
 ;
DATES ; -- Return SDATE and EDATE from TimeFrame
 ;    [Inverted for rev-chron search]
 N X S X=$O(ORDER("TimeFrame","")),SDATE=$P(X,":"),EDATE=$P(X,":",2)
 I EDATE S EDATE=$S($L(EDATE,".")=2:EDATE+.0001,1:EDATE+1)
 I SDATE S SDATE=$S($L(SDATE,".")=2:SDATE-.0001,1:SDATE)
 S SDATE=9999999-$S(SDATE:SDATE,1:0),EDATE=9999999-$S(EDATE:EDATE,1:9999998)
 S X=EDATE,EDATE=SDATE,SDATE=X
 Q
 ;
AVWX ; -- use ORQ1 for order view
 N X,DG,MULT,ORLIST,ORI,IFN,ACT
 S X=$O(ORDER("TimeFrame","")),SDATE=$P(X,":"),EDATE=$P(X,":",2)
 S DG=+$O(^ORD(100.98,"B","ALL",0)),X=$G(ORDER("View"))
 S MULT=$S("^1^6^8^9^10^11^13^14^20^22^"[(U_X_U):1,1:0)
 D EN^ORQ1(PAT,,X,,SDATE,EDATE,,MULT)
 S ORI=0 F  S ORI=$O(^TMP("ORR",$J,ORLIST,ORI)) Q:ORI'>0  S IFN=$G(^(ORI)),ACT=$P(IFN,";",2) D CONT
 K ^TMP("ORR",$J,ORLIST)
 Q
 ;
ARSX ; -- loop on ARS xref
 N IDX,IFN
 S IDX="^OR(100,""ARS"",PAT,SDATE)"
 F  S IDX=$Q(@IDX) Q:$P(IDX,"""",4)'=PAT  Q:$P(IDX,",",4)>EDATE  D
 . S IFN=+$P(IDX,",",5) D CONT
 Q
ACTX ; -- loop on "ACT" xref
 N IDX,IFN,ACT
 S IDX="^OR(100,""ACT"",PAT,SDATE)"
 F  S IDX=$Q(@IDX)  Q:$P(IDX,"""",4)'=PAT  Q:$P(IDX,",",4)>EDATE  D
 . S IFN=+$P(IDX,",",6),ACT=+$P(IDX,",",7)
 . I $P($G(^OR(100,IFN,8,ACT,0)),U,2)="NW"!$D(ORDER("SignStatus")) D CONT
 Q
CONT ; -- Proceed with checking order ORDER() & IFN [from ARS,ACT]
 N X,X0,X3,X7,X8,ACTN
 S X0=$G(^OR(100,IFN,0)),X3=$G(^(3)),X7=$G(^(7))
 Q:$P(X3,U,8)  I $P(X3,U,9),'$P($G(^OR(100,+$P(X3,U,9),3)),U,8) Q
 ;I $L($P(X0,U,17)),"^10^11^"[(U_STS_U) S X=$$LAPSED^OREVNTX($P(X0,U,17))
 I $D(ORGRP) Q:'$D(ORGRP(+$P(X0,U,11)))
 I $D(ORDER("Requestor")) Q:'$D(ORDER("Requestor",+$P(X0,U,4)))  ;X8?
 I $D(ORDER("Status")) Q:'$D(ORDER("Status",+$P(X3,U,3)))
 I $D(ORDER("Abnormal")) Q:'$P(X7,U,2)
 I $D(ORDER("Orderable")) Q:'$$OI(IFN)
 S ACTN=$S($G(ACT):ACT,1:$$LAST(IFN)),X8=$G(^OR(100,IFN,8,ACTN,0))
 S TXT=+$P(X8,U,14) I $D(ORDER("Text")) Q:'$$TEXT(IFN,TXT)
 I $D(ORDER("SignStatus")) Q:'$L($P(X8,U,4))  Q:'$D(ORDER("SignStatus",+$P(X8,U,4)))
 ;I $D(ORDER("Requestor")) Q:'$D(ORDER("Requestor",+$P(X8,U,3)))
 D SAVEORD
 Q
 ;
LAST(IFN) ; -- Returns DA of current/latest action for order IFN
 ;      (Only NW or XX actions?)
 N Y S Y=+$P($G(^OR(100,IFN,3)),U,7)
 I Y<1 S Y=+$O(^OR(100,IFN,8,"?"),-1)
 Q Y
 ;
OI(IFN) ; -- Return 1 or 0, if IFN contains any requested OI's
 N ITM,Y S Y=0
 S ITM=0 F  S ITM=$O(ORDER("Orderable",ITM)) Q:ITM<1  I $D(^OR(100,IFN,.1,"B",ITM)) S Y=1 Q
 Q Y
 ;
TEXT(IFN,TXT) ; -- Return 1 or 0, if IFN;TXT text contains requested string
 N X,Y,I S Y=0
 S X="" F  S X=$O(ORDER("Text",X)) Q:X=""  S I=0 D
 . F  S I=+$O(^OR(100,IFN,8,TXT,.1,I)) Q:I<1  I $$UP^XLFSTR($G(^(I,0)))[$$UP^XLFSTR(X) S Y=1 Q
 Q Y
 ;
SAVEORD ; -- Save order number in @ORY@("ORD:IFN;ACTN")
 ;    Called from CONT: also uses X0,X3,X8,TXT,ORYPAT
 N ID,X
 S ID=$S($D(CSLTMODE):"CST:",1:"ORD:")_IFN_";"_ACTN,ORCNT=ORCNT+1
 S @ORY@(ID,"Order.Datetime")=$S($P(X0,U,8):$P(X0,U,8),1:$P(X8,U,16))
 S @ORY@(ID,"Order.DisplayGroup")=$P($G(^ORD(100.98,+$P(X0,U,11),0)),U)
 S @ORY@(ID,"Order.Provider")=$P($G(^VA(200,+$P(X0,U,4),0)),U)
 S X=$P(X8,U,4),@ORY@(ID,"Order.Signature")=$S(X=0!(X=4):"on chart",X=1:"electronically signed",X=2:"unsigned",X=3:"not required",X=5:"cancelled",X=6:"service correction",X=7:"digitally signed",1:"")
 S @ORY@(ID,"Order.Status")=$$LOW^XLFSTR($P($G(^ORD(100.01,+$P(X3,U,3),0)),U))
 S @ORY@(ID,"Order.Abnormal")=$S($P(X7,U,2):"YES",X7:"NO",1:"")
 S @ORY@(ID,"Order.Finding")=$P(X7,U,3)
 S @ORY@(ID,"Order.Text")=$$BLDTXT(IFN,TXT)
 M @ORY@(ID)=ORYPAT
 I $D(ORCBO) D SETCBO(IFN)
 Q
BLDTXT(IFN,TXT) ; -- Return concatenated order text up to 245 chars
 N I,ALL,PART,MAX S ALL="",MAX=0
 S I=0 F  S I=$O(^OR(100,IFN,8,TXT,.1,I)) Q:'I  D  Q:MAX
 . S PART=$G(^OR(100,IFN,8,TXT,.1,I,0))
 . I ($L(ALL)+$L(PART))<245 S ALL=ALL_$S($L(ALL):" ",1:"")_PART
 . E  S MAX=1
 I MAX S ALL=ALL_"..."
 Q ALL
 ;
SETCBO(IFN) ; -- Set flags when looking for combinations of orderable items
 N I,OI
 S I=0 F  S I=$O(^OR(100,IFN,.1,I)) Q:'I  D
 . S OI=+^OR(100,IFN,.1,I,0)
 . I $D(ORDER("ItemCombo1",OI)) S ORCBO(1)=1
 . I $D(ORDER("ItemCombo2",OI)) S ORCBO(2)=1
 Q
 ;
VISITS ; -- Find clinic visits
 ;    Save in @ORY@("VST:TYPE;DT;LOC")
 N VISIT,X,SDATE,EDATE,ORV,ORCNT,I,ID,VTYPE
 M VISIT=QRY("Visit")
 S X=$O(VISIT("TimeFrame","")),SDATE=$P(X,":"),EDATE=$P(X,":",2)
 S SDATE=SDATE-.0001 S:$L(EDATE,".")<2 EDATE=EDATE+.9999
 D VST^ORWCV(.ORV,DFN,SDATE,EDATE,1) S ORCNT=0
 S I=0 F  S I=+$O(ORV(I)) Q:I<1  D
 . S X=ORV(I) Q:'$$ISVALID(X)
 . Q:$P(X,";",2)>(EDATE+1)
 . S VTYPE=$P(ORV(I),";")
 . S ID="VST:"_$P(X,U),ORCNT=ORCNT+1
 . S @ORY@(ID,"Visit.Datetime")=$P(ID,";",2)
 . S @ORY@(ID,"Visit.Location")=$P(X,U,3)
 . S @ORY@(ID,"Visit.NoShow")=$S($E(X)'="A":"",$$UP^XLFSTR($P(X,U,4))["NO-SHOW":"YES",1:"NO")
 . S:VTYPE'="I" @ORY@(ID,"Visit.Status")=$P(X,U,4)
 . M @ORY@(ID)=ORYPAT
 S @ORY@(0,"Visits")=ORCNT
 I $D(VISIT("NegativeSearch")) D NEGATE("Visits")
 Q
 ;
ISVALID(VST) ; -- True: valid visit data
 N IX,VSTID,ISVAL
 S VSTID=+$P(VST,";",3)
 S (IX,ISVAL)=0
 F  S IX=$O(VISIT("Location",IX)) Q:'IX  D
 . I IX=VSTID S ISVAL=1 Q
 S:'$D(VISIT("Location")) ISVAL=1
 Q ISVAL
 ;
NEGATE(SRCHITM) ; -- set report to return nodes only when nothing found
 N ID,RTNCNT,PRE
 I SRCHITM="Consults"  S ID="PTC:"_DFN,PRE="CST"
 I SRCHITM="Orders"    S ID="PTO:"_DFN,PRE="ORD"
 I SRCHITM="Documents" S ID="PTD:"_DFN,PRE="DOC"
 I SRCHITM="Visits"    S ID="PTV:"_DFN,PRE="VST"
 S RTNCNT=@ORY@(0,SRCHITM)
 I RTNCNT=0 D
 . M @ORY@(ID)=ORYPAT
 . S @ORY@(ID,"Patient.NoneFound")=SRCHITM
 . S @ORY@(0,SRCHITM)=1
 E  D
 . D RMOV(PRE)
 . S @ORY@(0,SRCHITM)=0
 Q
 ;
RMOV(PRE) ; -- Remove nodes based on ID prefix
 N ID
 S ID="" F  S ID=$O(@ORY@(ID)) Q:ID=""  I $P(ID,":")=PRE K @ORY@(ID)
 Q
