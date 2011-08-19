ORCDVBC1 ;SLC/MKB-Utility functions for VBECS dialogs cont ;2/11/08  11:03
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**212,309**;Dec 17, 1997;Build 26
 ;
PTINFO ; -- Show patient data [from EN^ORCDVBEC]
 ;   Expects ORPNM, ORVB(attribute) from OEAPI^VBECA3
 N I,X,TYPE,ORUA
 W !!,"CURRENT DATA FOR "_$G(ORPNM)_":" ;I '$L($G(ORVB("ABORH"))) W " none",! Q
 W !!,"ABO/Rh: "_$TR($G(ORVB("ABORH")),"^"," "),!
 W !,"Antibodies Identified:" D
 . I '$O(ORVB("ABHIS",0)) W "none",! Q
 . S I=0 F  S I=$O(ORVB("ABHIS",I)) Q:I<1  W ?27,$G(ORVB("ABHIS",I)),!
 W !,"Units Available",?36,"Expiration D/T  Division"
 W !,"---------------",?36,"--------------  --------"
 F TYPE="A^Autologous","D^Directed","C^Crossmatched","S^Assigned" D
 . Q:'$O(ORVB("UNIT",$P(TYPE,U),0))  S ORUA=1
 . W !,$P(TYPE,U,2)_" Units:" S TYPE=$P(TYPE,U)
 . S I=0 F  S I=$O(ORVB("UNIT",TYPE,I)) Q:I<1  S X=$G(ORVB("UNIT",TYPE,I)) W !,"  "_$$PAD^ORCHTAB($P(X,U),15)_$$PAD^ORCHTAB($P(X,U,2),19)_$$DATETIME($P(X,U,4))_"  "_$P(X,U,3)
 I '$G(ORUA) W !,"  none"
 W !!,"Transfusion Reactions",?36,"Date/Time"
 W !,"---------------------",?36,"---------"
 I '$O(ORVB("TRHX",0)) W !,"  none"
 E  S I=0 F  S I=$O(ORVB("TRHX",I)) Q:I<1  S X=$G(ORVB("TRHX",I)) W !,"  "_$P(X,U),?36,$$DATETIME($P(X,U,2))
 W !
 Q
 ;
DATETIME(X) ; -- Return external form of YYYYMMDDHHNNSS date
 N Y S Y=$$HL7TFM^XLFDT(X),Y=$$DATETIME^ORCHTAB(Y)
 Q Y
 ;
OI ; -- Edit VBECS orderable item names
 ; Option = ORCM VBECS OI EDIT
 N X,Y,D,DA,DR,DIE,DIC
 F  D  Q:Y<1  W !
 . S DIC("A")="Select VBECS ORDERABLE ITEM: "
 . S DIC("W")="W:$P(^(0),U)'=$P(^(0),U,8) ""      "",$P(^(0),U,8)"
 . S DIC="^ORD(101.43,",DIC(0)="AEQSZ",D="S.VBEC" D IX^DIC Q:Y<1
 . S X=$$NAME(Y(0,0)) Q:X="^"
 . S DIE=DIC,DA=+Y,DR=".01///"_X D ^DIE S Y=1
 Q
 ;
NAME(DFLT) ; Enter/edit orderable item text (no lookup)
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="FAO^3:63^K:X["";""!(X[""^"") X"
 S DIR("A")="NAME: " S:$L(DFLT) DIR("B")=DFLT
 S DIR("?",1)="Answer must be 3-63 characters in length and cannot contain a semicolon (;)"
 S DIR("?")="or an up-arrow (^)."
NM1 D ^DIR S:$D(DTOUT)!(X="^") Y="^" S:'$L(DFLT)&(X="") Y="^"
 I X="@" W $C(7),!!,"Orderable items may not be deleted!",! G NM1
 Q Y
 ;
STRIP(X) ; -- remove leading spaces
 N I,Y S Y=""
 F I=1:1:$L(X) I $E(X,I)'=" " S Y=$E(X,I,$L(X)) Q
 Q Y
 ;
LB(ORDER) ; -- Return Lab order number for specimen collection
 ; [Additional Text field #19 -- expects ORIFN from TEXT^ORQ12]
 N I,LR,NUM
 S NUM="",LR=+$$PKG^ORMPS1("LR")
 S I=0 F  S I=+$O(^OR(100,+$G(ORDER),2,I)) Q:I<1  I $P($G(^OR(100,I,0)),U,14)=LR,$G(^(4)) S NUM=+^(4) Q
 Q NUM
