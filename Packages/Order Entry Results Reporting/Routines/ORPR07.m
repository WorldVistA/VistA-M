ORPR07 ; slc/dcm - Printless in Tuscaloosa ;6/10/97  15:36
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**15,11,94,141**;Dec 17, 1997
ORDT(IFN,ACT) ;Get order date
 ;IFN=ORIFN
 ;ACT=DA of action
 Q:'$G(IFN) ""
 Q:'$D(^OR(100,IFN,0)) ""
 N X,Y
 S X="" I $G(ACT) S Y=$$ACT(IFN,ACT) Q +Y
 S X=$P(^OR(100,IFN,0),"^",7)
 Q X
ACT(IFN,ACT) ;This is an action
 N X
 Q:'$D(^OR(100,+$G(IFN),8,+$G(ACT),0)) "" S X=^(0)
 Q X
VNURSE(IFN,ACT) ;Get verifying nurse data
 ;Returns 1^name^initials^title^date/time verified if data, "" if not
 Q:'$G(IFN) ""
 Q:'$D(^OR(100,IFN,0)) ""
 N X,Y,Z S X=""
 I $G(ACT) S Y=$$ACT(IFN,ACT),Z=$G(^VA(200,+$P(Y,"^",8),0)) I $L(Z) S X=1_"^"_$P(Z,"^")_"^"_$P(Z,"^",2)_"^"_$P($G(^DIC(3.1,+$P(Z,"^",9),0)),"^")_"^"_$P(Y,"^",9)
 Q X
VCLERK(IFN,ACT) ;Get verifying clerk data
 ;Returns 1^name^initials^title^date/time verified if data, "" if not
 Q:'$G(IFN) ""
 Q:'$D(^OR(100,IFN,0)) ""
 N X,Y,Z S X=""
 I $G(ACT) S Y=$$ACT(IFN,ACT),Z=$G(^VA(200,+$P(Y,"^",10),0)) I $L(Z) S X=1_"^"_$P(Z,"^")_"^"_$P(Z,"^",2)_"^"_$P($G(^DIC(3.1,+$P(Z,"^",9),0)),"^")_"^"_$P(Y,"^",11)
 Q X
RVIEW(IFN,ACT) ;Get Chart reviewed by data
 ;Returns 1^name^initials^titel^date/time reviewed, "" if not
 Q:'$G(IFN) ""
 Q:'$D(^OR(100,IFN,0)) ""
 N X,Y,Z S X=""
 I $G(ACT) S Y=$$ACT(IFN,ACT),Z=$G(^VA(200,+$P(Y,"^",18),0)) I $L(Z) S X=1_"^"_$P(Z,"^")_"^"_$P(Z,"^",2)_"^"_$P($G(^DIC(3.1,+$P(Z,"^",9),0)),"^")_"^"_$P(Y,"^",19)
 Q X
ORDOC(IFN,ACT) ;Get Ordering provider
 Q:'$G(IFN) ""
 Q:'$D(^OR(100,IFN,0)) ""
 N X,Y,Z
 S X=""
 I $G(ACT) S Y=$$ACT(IFN,ACT),Z=$G(^VA(200,+$P(Y,"^",3),0)) I $L(Z) S X=$P(Z,"^")
 I '$L(X) S Y=$P(^OR(100,IFN,0),"^",4),Z=$G(^VA(200,+Y,0)) I $L(Z) S X=$P(Z,"^")
 Q X
PHONE(IFN,ACT,PIECE) ;Get Ordering provider's phone number (multiple choice)
 ;PIECE=the piece of data to get from node ^VA(200,DUZ,.13)
 Q:'$G(IFN) ""
 Q:'$D(^OR(100,IFN,0)) ""
 Q:'$G(PIECE)
 N X,Y,Z
 S X=""
 I $G(ACT) S Y=$$ACT(IFN,ACT),Z=$G(^VA(200,+$P(Y,"^",3),.13)) I $L(Z) S X=$P(Z,"^",PIECE) Q X
 S Y=$P(^OR(100,IFN,0),"^",4) S:Y X=$P($G(^VA(200,Y,.13)),"^",PIECE)
 Q X
NAT(IFN,ACT) ;Get Nature of order
 Q:'$G(IFN) ""
 Q:'$D(^OR(100,IFN,0)) ""
 N X,Y
 S X=""
 I $G(ACT) S Y=$P($$ACT(IFN,ACT),"^",12),X=$S($D(^ORD(100.02,+Y,0)):$P(^(0),"^"),1:"")
 Q X
ESNAME(IFN,ACT) ;Get Electronic Sig Name
 Q:'$G(IFN) ""
 Q:'$D(^OR(100,IFN,0)) ""
 N X,Y
 S X=""
 I $G(ACT) S Y=$$ACT(IFN,ACT) D  Q X
 . I $P(Y,"^",5) S X=$P($G(^VA(200,$P(Y,"^",5),20)),"^",2) S:$L(X) X=$S($P(Y,"^",4)=7:"/ds/",1:"/es/")_X Q
 . I $P(Y,"^",4),"42"[$P(Y,"^",4) S X="_______________" Q
 Q X
ESTIT(IFN,ACT) ;Get Electronic Sig Title
 Q:'$G(IFN) ""
 Q:'$D(^OR(100,IFN,0)) ""
 N X,Y
 S X="" I $G(ACT) S Y=$$ACT(IFN,ACT) S:$P(Y,"^",5) X=$E($P($G(^VA(200,$P(Y,"^",5),20)),"^",3),1,20)
 Q X
ESDATE(IFN,ACT) ;Get Electronic Sig Date
 Q:'$G(IFN) ""
 Q:'$D(^OR(100,IFN,0)) ""
 N X
 S X=""
 I $G(ACT) S X=$P($$ACT(IFN,ACT),"^",6)
 Q X
ESODATE(IFN,ACT) ;Get Date/time Signed online
 Q:'$G(IFN) ""
 Q:'$D(^OR(100,IFN,0)) ""
 N X
 S X=""
 I $G(ACT),$P($$ACT(IFN,ACT),"^",4)=1 S X=$P($$ACT(IFN,ACT),"^",6)
 Q X
ENTBY(IFN,ACT) ;Get Entered by
 Q:'$G(IFN) ""
 Q:'$D(^OR(100,IFN,0)) ""
 N X,Y
 S X="" I $G(ACT) S Y=$$ACT(IFN,ACT) S:$P(Y,"^",13) X=$P($G(^VA(200,$P(Y,"^",13),0)),"^") Q X
 S X=$P(^OR(100,IFN,0),"^",6) S:X X=$P(^VA(200,X,0),"^")
 Q X
ENTINT(IFN,ACT) ;Get Entered by Initials
 Q:'$G(IFN) ""
 Q:'$D(^OR(100,IFN,0)) ""
 N X,Y
 S X="" I $G(ACT) S Y=$$ACT(IFN,ACT) S:$P(Y,"^",13) X=$P($G(^VA(200,$P(Y,"^",13),0)),"^",2) Q X
 S X=$P(^OR(100,IFN,0),"^",6) S:X X=$P(^VA(200,X,0),"^",2)
 Q X
ENTIT(IFN,ACT) ;Get Electronic Sig Title of Entering Person
 Q:'$G(IFN) ""
 Q:'$D(^OR(100,IFN,0)) ""
 N X,Y
 S X="" I $G(ACT) S Y=$$ACT(IFN,ACT) S:$P(Y,"^",13) X=$E($P($G(^VA(200,$P(Y,"^",13),20)),"^",3),1,20) Q X
 S X=$P(^OR(100,IFN,0),"^",6) S:X X=$E($P(^VA(200,X,20),"^",3),1,20)
 Q X
BY(ORIFN) ;Get DC info for DC by & when PRINT FIELD
 Q:'$G(ORIFN) ""
 N Y,Z,X6,X1,ORDCBY
 I $P($G(^OR(100,ORIFN,6)),"^",2) S X6=^(6) D  Q ORDCBY
 . S Y=+$J($P(X6,"^",3),0,4),Z=$G(^VA(200,+$P(X6,"^",2),0)) I $L(Z) S X1=$P(Z,"^")_$S($P(Z,"^",9):" ("_$E($P(^DIC(3.1,$P(Z,"^",9),0),"^"),1,10)_")",1:""),Y=$$DATE^ORU(Y)_" "_$$TIME^ORU(Y)
 . S ORDCBY="DC'ed "_$S(+$P(X6,"^",4):"("_$P(^ORD(100.03,+$P(X6,"^",4),0),"^")_")",1:"")_" by:"_X1_" "_Y
 Q ""
WARDREM(ORIFN) ;Get Ward Remarks
 N ORI,X
 S X=""
 I $G(ORIFN) S ORI=$O(^OR(100,ORIFN,4.5,"ID","COMMENT",0)) I ORI S X="^OR(100,"_+ORIFN_",4.5,"_ORI_",2)"
 Q X
RX(IFN,FLD,Y) ;Get Pharmacy Fields
 ;IFN=internal # of 100
 ;FLD=code for RX field to lookup
 ;Y=output returned in Y
 Q:'$G(IFN)  Q:'$L($G(FLD))
 Q:'$D(^OR(100,IFN,0))
 N X,X4,PKG,DFN,I S X=^OR(100,IFN,0),X4=$G(^(4)) Q:'$L(X4)
 S PKG=$P(X,"^",14) Q:'PKG
 S PKG=$S($P(^DIC(9.4,PKG,0),"^")="INPATIENT MEDICATIONS":"I",$P(^(0),"^")="OUTPATIENT MEDICATIONS":"O",$P(^(0),"^")="IV MEDICATIONS":"I",$P(^(0),"^")="UNIT DOSE MEDICATIONS":"I",1:"") Q:'$L(PKG)
 S DFN=+$P(X,"^",2)
 D OEL^PSOORRL(DFN,X4_";"_PKG)
 I FLD="SI" S Y=$P($G(^TMP("PS",$J,"SI")),"^",1,99) Q  ;Special Instructions
 I FLD="SCH" S I=0 D  Q  ;Schedule & Admin Times
 . F  S I=$O(^TMP("PS",$J,"SCH",I)) Q:I<1  S Y(I)=$P(^(I,0),"^") ;_"  "_$P(^(0),"^",2)
 I FLD="OTH" S Y=$P($G(^TMP("PS",$J,"OPI")),1,99) Q  ;Other print info
 I FLD="DRUG" S Y=$P($G(^TMP("PS",$J,0)),"^") Q  ;Drug
 I FLD="INF" S Y=$P($G(^TMP("PS",$J,0)),"^",2) Q  ;Infusion rate
 I FLD="STOP" S Y=$P($G(^TMP("PS",$J,0)),"^",3) Q  ;Stop date
 I FLD="REFIL" S Y=$P($G(^TMP("PS",$J,0)),"^",4) Q  ;Refills
 I FLD="MDRT" S I=0 D  Q  ;Med Route
 . F  S I=$O(^TMP("PS",$J,"MDR",I)) Q:I<1  S Y(I)=^(I,0)
 I FLD="SIG" S I=0 D  Q  ;SIG (outpat) Instructions (inpat)
 . F  S I=$O(^TMP("PS",$J,"SIG",I)) Q:I<1  S Y(I)=^(I,0)
 I FLD="PC" S I=0 D  Q  ;Provider comments
 . F  S I=$O(^TMP("PS",$J,"PC",I)) Q:I<1  S Y(I)=^(I,0)
 I FLD="ADD" S I=0 D  Q  ;Additive, amount, bottle
 . F  S I=$O(^TMP("PS",$J,"A",I)) Q:I<1  S Y(I)=$P(^(I,0),"^")_"  "_$P(^(0),"^",2)_"  #"_$P(^(0),"^",3)
 I FLD="SOL" S I=0 D  Q  ;Solution & amount
 . F  S I=$O(^TMP("PS",$J,"B",I)) Q:I<1  S Y(I)=$P(^(I,0),"^")_"  "_$P(^(0),"^",2)
 Q
TEST ;Test RX call
 W !,"Enter Pharmacy Order # (ORIFN): " R X:DTIME Q:X=""!(X["^")  I '$D(^OR(100,+$G(X),0)) W !,$C(7),X_" does not exist" G TEST
 S ORIFN=X F ORI="SCH","SI","ADM","OTH","DRUG","INF","STOP","REFIL","MDRT","SIG","PC","ADD","SOL" K TEST D RX(ORIFN,ORI,.TEST) I $D(TEST) W !,ORI_"- " ;ZW TEST
 Q
LABEL(Y,ORIFN,QUIET,OACTION) ;Print pharmacy label
 I $G(ORTEST) D TEST1 Q
 N X,X4,ORC
 Q:'$D(^OR(100,+$G(ORIFN),0))  Q:'$L($G(^(4)))  S X=^(0),X4=^(4)
 I $S($P($G(^DIC(9.4,+$P(X,"^",14),0)),"^")="INPATIENT MEDICATIONS":0,$P($G(^DIC(9.4,+$P(X,"^",14),0)),"^")="IV MEDICATIONS":0,$P($G(^DIC(9.4,+$P(X,"^",14),0)),"^")="UNIT DOSE MEDICATIONS":0,1:1) Q
 N LINES,ORXPTMP,I,ACT
 I $G(OACTION),$D(^OR(100,+$G(ORIFN),8,OACTION,0)) S ACT=$P(^(0),"^",2)
 I $L($T(MAR^PSJORMAR),",")>4 D MAR^PSJORMAR(+$P(X,"^",2),$P(X4,"^"),1,.LINES,$G(ACT))
 I $L($T(MAR^PSJORMAR),",")'>4 D MAR^PSJORMAR(+$P(X,"^",2),$P(X4,"^"),1,.LINES)
 I $G(QUIET) K Y S (I,Y)=0 D  Q
 . F  S I=$O(LINES(I)) Q:'I  S Y(I,0)=LINES(I),ORPICKUP=I
 S (ORC,I)=0
 I '$D(ORIOSL) N ORIOSL S ORIOSL=$S($D(IOSL):IOSL,1:50)
 I '$D(ORIOF) N ORIOF S ORIOF=$S($D(IOF):IOF,1:"!")
 F  S I=$O(LINES(I)) Q:I<1  S ORC=ORC+1 D
 . I $Y>(ORIOSL-2) W @ORIOF S ORC=1
 . W:ORC>1 ! W LINES(I)
 Q
TEST1 ;Print test label
 W !,"03/03 |            |               (F1990)|"
 W !,"Test Pharmacy Label"
 W !,"Give: 1GM TOP QD"
 W !!,"                       RPH: _____RN: _____|"
 Q
