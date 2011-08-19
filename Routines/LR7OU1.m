LR7OU1 ;slc/dcm - General Utilities ;8/11/97
 ;;5.2;LAB SERVICE;**121,187,235**;Sep 27, 1994
 ;
EN(TST,SUB) ;Expand a lab panel
 ;TST=Test ptr to file 60
 ;SUB=Test subscript $p(^LAB(60,X,0),"^",5)
 ;TSTY(subscript)=TST Expanded panel put in this array
 N S2,J,X
 I $L($G(SUB)) S S2=$P(SUB,";",2) S:'$D(TSTY(S2)) TSTY(S2)=+TST Q
 S J=0 F  S J=$O(^LAB(60,+TST,2,J)) Q:J<1  S X=^(J,0) D EN(+X,$P(^LAB(60,+X,0),"^",5))
 Q
TEST ;Test expanding panel
 S DIC=60,DIC(0)="ZAEQM" D ^DIC Q:Y<1
 N TSTY D EN(+Y,$P(Y(0),"^",5))
 ;ZW TSTY
 Q
UPPER(X) ; Convert lower case X to UPPER CASE
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
WC(PK,IFN) ;Get collection type for print fields
 N X
 S X=$$TYPE($P(PK,";",2),$P(PK,";",3)),Y=$S(X="WC":"Ward Collect",X="LC":"Lab Collect",X="SP":"Send Patient",X="I":"Immediate Collect",1:"")
 Q Y
ACC(PK,IFN) ;Get accession numbers for print fields
 N X,Y
 S X=$$GETST($P(PK,";",2),$P(PK,";",3),IFN),Y="",Y=$P(X,"^",3,5),X=$S($D(^LRO(68,+$P(Y,"^",2),0)):$P(^(0),"^",11),1:""),X=X_" "_$E($P(Y,"^"),4,7)_" "_$P(Y,"^",3)
 Q X
LU(PK,IFN) ;Get urgency for print fields
 N X
 S X=$$GETST($P(PK,";",2),$P(PK,";",3),IFN),X=$P(X,"^",2),X=$S(X:$P(^LAB(62.05,X,0),"^"),1:"")
 Q X
COL(PK,IFN) ;Get collection sample with Tube type for print fields
 N X,Y
 S X=$$SAMP($P(PK,";",2),$P(PK,";",3))
 S Y=$S(X:$S($D(^LAB(62,X,0)):$P(^(0),"^")_" "_$P(^(0),"^",3),1:""),1:"")
 Q Y
VER() ;Check OE/RR version #
 ;Returns current OE/RR version #
 N VER S VER=$S(+$G(^DD(100,0,"VR")):+^("VR"),1:0)
 Q VER
GETTEST(IFN) ;Get Lab test from Order entry
 ;IFN=Order # from file 100
 Q:'$G(IFN) ""
 N X
 S X=$$VALUE^ORCSAVE2(IFN,"ORDERABLE") Q:'X ""
 S X=+$P($G(^ORD(101.43,+X,0)),"^",2)
 Q X
GETST(ODT,SN,IFN) ;Find test node from LRODT,LRSN for a given ORIFN
 ;ODT=LRODT, SN=LRSN, IFN=ORIFN
 Q:'$G(ODT) "" Q:'$G(SN) "" Q:'$G(IFN) ""
 Q:'$D(^LRO(69,ODT,1,SN,0)) ""
 N TST,X,T,END
 S X="",(T,END)=0,TST=$$GETTEST(IFN) Q:'TST ""
 F  S T=$O(^LRO(69,ODT,1,SN,2,T)) Q:T<1!(END)  D
 . I $D(^LRO(69,ODT,1,SN,2,T,0)),+^(0)=TST S X=^(0),END=1 Q
 Q X
GET0(ODT,SN) ;Get zero node: ^LRO(69,ODT,1,SN,0) for an ORIFN
 ;ODT=LRODT, SN=LRSN
 Q:'$G(ODT) "" Q:'$G(SN) ""
 Q $G(^LRO(69,ODT,1,SN,0))
SAMP(ODT,SN) ;Get collection sample pointer from lab order
 ;ODT=LRODT, SN=LRSN
 Q $P($$GET0(ODT,SN),"^",3)
TYPE(ODT,SN) ;Get collection type internal value from lab order
 ;ODT=LRODT, SN=LRSN
 Q $P($$GET0(ODT,SN),"^",4)
SAMPCOM(PK,IFN) ;Get Ward Remarks (specimen) for lab order
 N TEST,SPEC
 S TEST=+$$GETST($P(PK,";",2),$P(PK,";",3),IFN) I 'TEST Q ""
 S SPEC=$$SAMP($P(PK,";",2),$P(PK,";",3)) I 'SPEC Q ""
 S SPEC=$O(^LAB(60,TEST,3,"B",SPEC,0)) I 'SPEC Q ""
 Q "^LAB(60,"_TEST_",3,"_SPEC_",1)"
WARDCOM(PK,IFN) ;Get General Ward comments on a test order
 N TEST
 S TEST=+$$GETST($P(PK,";",2),$P(PK,";",3),IFN) I 'TEST Q ""
 Q "^LAB(60,"_TEST_",6)"
EXPAND(TEST,ARAY) ;Expand a lab test panel
 ;TEST=Test ptr to file 60
 ;Expanded panel returned in ARAY(TEST)
 N INARAY
 D EX(TEST)
 M ARAY=INARAY
 Q
EX(TST) ;
 N J,X,SUB
 Q:'$D(^LAB(60,TST,0))  S SUB=$P(^(0),"^",5)
 I $L(SUB) S:'$D(INARAY(+TST)) INARAY(+TST)="" Q
 S J=0 F  S J=$O(^LAB(60,+TST,2,J)) Q:J<1  S X=^(J,0) D EX(+X)
 Q
SPLIT(TXT,ARAY,CTR,LENGTH,PRE,POST) ;Splits text into an array
 ;Splits text at nearest space from LENGTH value 
 ;Word limit: 150 characters...<150 stored on own node, >150 split
 ;TXT- text to be split
 ;ARAY- array to put the text (e.g. "LOCAL", "^TMP(""LRT"",$J)")
 ;CTR- starting point in array, default=0. Passed by reference so that external counter is incremented.
 ;LENGTH- length for each array node, default=80
 ;PRE- optional text to append at the beginning of each array node
 ;POST- optional text to append at the end of each array node
 N END
 Q:'$L($G(TXT))  Q:'$L($G(ARAY))
 S:'$G(CTR) CTR=0
 S:'$G(LENGTH) LENGTH=80
 S:'$L($G(PRE)) PRE=""
 S:'$L($G(POST)) POST=""
 I $L(TXT)'>LENGTH!('$F(TXT," ",LENGTH)),$L(TXT)<150 S CTR=CTR+1,@ARAY@(CTR)=PRE_$$STRIP(TXT)_POST Q
 S END=$S($F(TXT," ",LENGTH):$F(TXT," ",LENGTH),1:LENGTH)
 S:END>150 END=150
 S CTR=CTR+1,@ARAY@(CTR)=PRE_$$STRIP($E(TXT,1,$S(END=LENGTH:END,1:END-1)))_POST
 D SPLIT($E(TXT,END,999),ARAY,.CTR,LENGTH,PRE,POST)
 Q
STRIP(X) ; -- Strip leading spaces from text X
 N I,Y S Y=""
 F I=1:1:$L(X) I $E(X,I)'=" " S Y=$E(X,I,999) Q
 Q Y
