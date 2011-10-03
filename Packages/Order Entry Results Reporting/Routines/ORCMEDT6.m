ORCMEDT6 ;SLC/MKB-QO editor utilities ;12/18/02  13:33
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**164**;Dec 17, 1997
 ;
QO ; -- Enter/edit QO restriction on orderable items
 N X,Y,DA,DR,DIE,ORIT,OLDVAL,OREBLD
 F  S ORIT=$$OI("S.RX^S.LAB","Select an ORDERABLE ITEM (meds or labs only): ") Q:ORIT'>0  D  W !!
 . W !!,"Select the type of usage for which you wish to restrict ordering of this item."
 . F  S ORDG=$$SET(+ORIT) Q:"^"[ORDG  D
 .. S DA(1)=+ORIT,DA=+$O(^ORD(101.43,+ORIT,9,"B",ORDG,0))
 .. S OLDVAL=$G(^ORD(101.43,+ORIT,9,DA,0))
 .. S DR=2,DIE="^ORD(101.43,"_DA(1)_",9," D ^DIE W !
 .. I ORDG="O RX"!(ORDG="UD RX"),OLDVAL'=$G(^ORD(101.43,+ORIT,9,DA,0)) S OREBLD(ORDG)=1
 F ORDG="O RX","UD RX" I $G(OREBLD(ORDG)) D FVBLDQ^ORWUL(ORDG)
 Q
 ;
SET(OI) ; -- Returns Set Membership for OI
 N X,Y,I,DOMAIN,NAME,HELP,DONE
 S X="",I=0 F  S X=$O(^ORD(101.43,+OI,9,"B",X)) Q:X=""  S NAME=$$NAME(X),I=I+1,DOMAIN(I)=X_U_NAME,DOMAIN("B",NAME)=I
 S DOMAIN(0)=I,HELP="Select the type of usage for which you wish to restrict ordering of this item."
 S DONE=0,Y="" F  D  Q:DONE
 . W !,"Usage: "
 . R X:DTIME S:'$T X="^" I X["^" S Y="^",DONE=1 Q
 . I X="" S Y="^",DONE=1 Q
 . I X["?" W !!,HELP D LIST Q
 . D  I 'Y W $C(7),!,HELP Q
 . . N XP,XY,CNT,MATCH,DIR,I
 . . S X=$$UP^XLFSTR(X),Y=+$G(DOMAIN("B",X)) Q:Y  ; done
 . . S CNT=0,XP=X F  S XP=$O(DOMAIN("B",XP)) Q:XP=""  Q:$E(XP,1,$L(X))'=X  S CNT=CNT+1,XY=+DOMAIN("B",XP),MATCH(CNT)=XY_U_$P(DOMAIN(XY),U,2)
 . . Q:'CNT
 . . I CNT=1 S Y=+MATCH(1),XP=$P(MATCH(1),U,2) W $E(XP,$L(X)+1,$L(XP)) Q
 . . S DIR(0)="NAO^1:"_CNT,DIR("A")="Select 1-"_CNT_": "
 . . F I=1:1:CNT S DIR("A",I)=$J(I,3)_" "_$P(MATCH(I),U,2)
 . . S DIR("?")="Select the desired value, by number"
 . . D ^DIR I $D(DIRUT) S Y="" Q
 . . S Y=+MATCH(Y) W "  "_$P(DOMAIN(Y),U,2)
 . S Y=$P(DOMAIN(Y),U),DONE=1
 Q Y
 ;
LIST ; -- List order statuses in DOMAIN
 N I,Z,CNT,DONE
 S CNT=0 W !,"Choose from:"
 F I=1:1:DOMAIN(0) D  Q:$G(DONE)
 . S CNT=CNT+1 W ! I CNT>(IOSL-3) D  Q:$G(DONE)
 .. W ?3,"'^' TO STOP: " R Z:DTIME S:'$T!(Z["^") DONE=1 S CNT=1
 . W $C(13),"  "_$P(DOMAIN(I),U,2)
 Q
 ;
NAME(X) ; -- Returns full name of set X
 N Y,I S Y=$S(X="IVA RX":"IV ADDITIVES",X="IVB RX":"IV SOLUTIONS",X="IVM RX":"IV MEDICATIONS",1:"")
 I Y="" S I=+$O(^ORD(100.98,"B",X,0)),Y=$S(I:$P($G(^ORD(100.98,I,0)),U),1:X)
 Q Y
 ;
OI(IDX,CAPTION) ; -- Returns selected OI from file #101.43 using IDX xrefs
 N X,Y,D,DIC,DTOUT,DUOUT,DIRUT,DIROUT,ORDIC
 S DIC="^ORD(101.43,",DIC(0)="AEQS" S:$L($G(CAPTION)) DIC("A")=CAPTION
 S DIC("W")="W:$S('$D(%):0,'$D(DIY):0,%=DIY:0,1:1) $G(DIY)"
 S D=IDX,ORDIC="IX^DIC" S:$L(D,U)>1 ORDIC="MIX^DIC1",DIC(0)=DIC(0)_"M"
 D @ORDIC
 Q Y
 ;
OIB(CAPTION) ; -- Returns selected OI from file #101.43 using B xref
 N X,Y,DIC,DTOUT,DUOUT,DIRUT,DIROUT
 S DIC="^ORD(101.43,",DIC(0)="AEQ"
 S:$L($G(CAPTION)) DIC("A")=CAPTION
 D ^DIC
 Q Y
 ;
SEARCH ; -- Search/replace orderables in QO responses
 N I,ORP,ORIT
 S I=0 F  S I=$O(^ORD(101.41,I)) Q:I<1  I $P($G(^(I,0)),U,4)="P",$P($G(^(1)),U)="P",+$P($G(^(1)),U,2)=101.43 S ORP(I)="" ;OI prompts
 F  S ORIT=$$OIB("Search for: ") Q:ORIT<1  D SR1 W !!
 Q
 ;
SR1 ; -- list QO's & Dlgs where ORIT is used, get replacement
 N I,X,ORDAD,ORDG,ORY,ORNMBR,NUM,DA,ORNM,TYPE,SET
 D FIND(ORIT,.ORDAD) I ORDAD<1 W !,$P(ORIT,U,2)_" is not used by any quick orders or dialogs." Q
 W @IOF,"Quick Orders and Dialogs containing "_$P(ORIT,U,2),!,$$REPEAT^XLFSTR("-",79)
 S I=0 F  S I=$O(ORDAD(I)) Q:I'>0  D
 . S X=+ORDAD(I) W !,I,?4,$P(^ORD(101.41,X,0),U)
 W !,$$REPEAT^XLFSTR("-",79)
 S ORDG=+$P($G(^ORD(101.43,+ORIT,0)),U,5),ORDG=$P($G(^ORD(100.98,ORDG,0)),U,3)
 S ORY=$$OI("S."_ORDG,"Replace with: ") Q:ORY<1
 D SELECT(ORDAD,.ORNMBR) Q:ORNMBR="^"
 Q:'$$OK  W !!,"Replacing "_$P(ORIT,U,2)_" with "_$P(ORY,U,2)_" in:"
 F I=1:1:$L(ORNMBR,",") S NUM=$P(ORNMBR,",",I) I NUM D
 . S DA(1)=+ORDAD(NUM),DA=$P(ORDAD(NUM),U,2),SET=$P(ORDAD(NUM),U,3)
 . S ORNM=$P(^ORD(101.41,DA(1),0),U),TYPE=$P($G(^(0)),U,4)
 . I '$O(^ORD(101.43,+ORY,9,"B",SET,0)) W !?3,ORNM_" canceled: item invalid for this dialog." Q
 . I TYPE="Q" S ^ORD(101.41,DA(1),6,DA,1)=+ORY
 . I TYPE="D" S ^ORD(101.41,DA(1),10,DA,7)="S Y="_+ORY
 . W !?3,ORNM_" ...done."
 Q
 ;
FIND(X,QO) ; -- Find QO's, Dlg's that use ord item X
 N IFN,P,TYPE,NODE,DEF,DA,DLG,PRMT,SET S IFN=0,QO=0
 F  S IFN=+$O(^ORD(101.41,IFN)) Q:IFN<1  S TYPE=$P($G(^(IFN,0)),U,4) D
 . S NODE=$S(TYPE="Q":6,TYPE="D":10,1:0) Q:'NODE
 . S P=0 F  S P=$O(ORP(P)) Q:P<1  S DA=$O(^ORD(101.41,IFN,NODE,"D",P,0)) I DA D
 .. I TYPE="Q" Q:+$G(^ORD(101.41,IFN,6,DA,1))'=+X  S DLG=$$DEFDLG^ORCD(IFN),PRMT=+$O(^ORD(101.41,DLG,10,"D",P,0))
 .. I TYPE="D" S DEF=$G(^ORD(101.41,IFN,10,DA,7)) Q:DEF'?1"S Y=".E  S DEF=$P(DEF,"=",2) S:$E(DEF)="""" DEF=$P(DEF,"""",2) Q:+DEF'=+X  S DLG=IFN,PRMT=DA
 .. S SET=$P($G(^ORD(101.41,DLG,10,PRMT,0)),U,10),SET=$P($P(SET,";"),".",2)
 .. S QO=QO+1,QO(QO)=IFN_U_DA_U_SET
 Q
 ;
SELECT(MAX,Y) ; -- Select which QOs to replace Ord Item
 N X,DIR
 S DIR(0)="LA^1:"_MAX,DIR("A")="Replace in: ",DIR("B")=$S(MAX>1:"1-"_MAX,1:"1")
 ; S DIR("?")
 D ^DIR S:$D(DTOUT)!(X["^") Y="^"
 Q
 ;
OK() ; -- Are you ready?
 N X,Y,DIR
 S DIR(0)="YA",DIR("A")="Are you ready? ",DIR("B")="NO"
 W ! D ^DIR
 Q +Y
