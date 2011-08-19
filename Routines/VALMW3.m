VALMW3 ; ALB/MJK - Create transport routines for LM;03:39 PM  16 Dec 1992
 ;;1;List Manager;;Aug 13, 1993
 ;
EN ; -- exporter main entry point
 N VALMSYS,VALMNS,VALMROU,VALMAX
 S U="^",DTIME=600 K ^UTILITY($J)
 D HOME^%ZIS
 W @IOF,!?20,"*** List Template Export Utility ***"
 I '$$DUZ() G ENQ
 S VALMSYS=$$OS() I VALMSYS="" G ENQ
 S VALMNS=$$NS() I VALMNS="" G ENQ
 S VALMROU=$$ROU(.VALMNS) I VALMROU="" G ENQ
 S VALMAX=$$MAX() I 'VALMAX G ENQ
 W !!!,">>> Exporting LIST TEMPLATES with namespace '"_VALMNS_"'."
 D BLD,FILE(.VALMROU)
ENQ Q
 ;
 ;
DUZ() ; -- check duz and duz(0)
 I $S('$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) D
 .W !,"PROGRAMMER ACCESS REQUIRED",!
 .S Y=0
 E  S Y=1
 Q Y
 ;
OS() ; -- get os #
 I $D(^%ZOSF("OS"))#2 D
 .S Y=+$P(^("OS"),"^",2)
 E  S Y=0
 Q Y
 ;
NS() ; -- ask for namespace
NS1 S VALMNS=""
 W !!,">>> Enter the Name of the Package (2-4 characters): "
 R X:$S($D(DTIME):DTIME,1:60) G NSQ:"^"[X
 I X'?1U1.NU!($L(X)>4) D NS^VALMW5 G NS1
 S VALMNS="",DIC="^DIC(9.4,",DIC(0)="EZ",D="C" D IX^DIC
 I Y>0 S SDPK=+Y,VALMNS=$P(Y(0),U,2)
 S:Y<1!(VALMNS="") VALMNS=$$ADHOC(X)
NSQ Q VALMNS
 ;
ROU(VALMNS) ; -- ask for export routine name
 N ROU,DIR,X,Q
ROU1 S VALMROU=""
 W ! S:$G(VALMNS)]"" DIR("B")=VALMNS_"L"
 S DIR("A")=">>> Enter Routine Name",DIR(0)="F^2:6^" D ^DIR K DIR
 G ROUQ:"^"[Y S VALMROU=Y
 W !!,"I am going to create a series of '",VALMROU,"*' routines."
 I $D(^%ZOSF("TEST"))#2 X ^("TEST") I  W *7,!,"but '"_VALMROU_"' is ALREADY ON FILE!" S Q=1
 W !,"Is that OK" D YN^DICN
 I %<0!(%=2) S:%=2 VALMROU="" G ROUQ
 I '% D ROU^VALMW5 G ROU1
ROUQ Q VALMROU
 ;
MAX() ; -- ask for max size of routines
 N Y
MAX1 S Y=""
 W !!,">>> MAXIMUM ROUTINE SIZE(BYTES): ",^DD("ROU"),"// "
 R Y:$S($D(DTIME):DTIME,1:60) I '$T G MAXQ
 S:Y="" Y=^DD("ROU")
 I Y[U S Y="" G MAXQ
 I Y\1'=Y!(Y<2000)!(Y>9999) D MAX^VALMW5 G MAX
MAXQ Q Y
 ;
ADHOC(X) ; -- pick any namespace
L W !!,"Package "_X_" not found"
 W !,"Please enter the package namespace you wish to export: "
 R X:300
 I '$T!(X="")!(X'?1A.E) S X="" G LQ
 I $L(X)>4 W !,"Namespace too long" G L
LQ Q X
 ;
BLD ; -- build utility
 N VALMLN,VALMX,VALMNAME,VALM,VALMGLB
 S VALMLN=0,VALMX=VALMNS
 F  S VALMX=$O(^SD(409.61,"B",VALMX)) Q:VALMX=""!($E(VALMX,1,$L(VALMNS))'=VALMNS)  S VALM=+$O(^(VALMX,0)) I $D(^SD(409.61,VALM,0)),$P(^(0),U,7) S VALMNAME=$P(^(0),U) D
 .W !?5,"o  ",VALMNAME
 .D SET(" W !,""'"_VALMNAME_"' List Template...""")
 .D SET(" S DA=$O(^SD(409.61,""B"","""_VALMNAME_""",0)),DIK=""^SD(409.61,"" D ^DIK:DA")
 .D SET(" K DO,DD S DIC(0)=""L"",DIC=""^SD(409.61,"",X="""_VALMNAME_""" D FILE^DICN S VALM=+Y")
 .D SET(" I VALM>0 D")
 .;
 .S VALMGLB="^SD(409.61,"_VALM_",",X=VALMGLB_"-1)"
 .F  S X=$Q(@X) Q:$E(X,1,$L(VALMGLB))'=VALMGLB  D:X'[",""B""," SET(" .S ^SD(409.61,VALM,"_$P(X,VALMGLB,2,99)_"="""_$$QUOTE(@X)_"""")
 .;
 .D SET(" .S DA=VALM,DIK=""^SD(409.61,"" D IX1^DIK K DA,DIK")
 .D SET(" .W ""Filed.""")
 .D SET(" ;")
 D SET(" K DIC,DIK,VALM,X,DA Q")
Q3 Q
 ;
SET(X) ; -- set line utility
 S VALMLN=VALMLN+1,^UTILITY($J,VALMLN,0)=X W "."
 Q
 ;
QUOTE(X) ; -- add double quotes
 N P,L
 S P=1,L=$L(X)
 F  S P=$F(X,"""",P) Q:'P!(P>(L+1))  S X=$E(X,1,P-1)_""""_$E(X,P,L),L=L+1,P=P+1
 Q X
 ;
FILE(VALMROU) ; -- file routines
 N %H,VALMDATE,VALMNUM,VALMLN
 S %H=+$H D YX^%DTC
 S VALMDATE=$E(Y,5,6)_"-"_$E(Y,1,3)_"-"_$E(Y,9,12)
 S VALMNUM="",VALMLN=0
 F  D SAVE(.VALMROU,.VALMNUM,.VALMLN,.VALMDATE) Q:VALMLN=""  S VALMNUM=VALMNUM+1
 Q
 ;
SAVE(VALMROU,VALMNUM,VALMLN,VALMDATE) ; -- save to routine
 N LINE,SIZE
 K ^UTILITY($J,0) S ^(0,1)=VALMROU_VALMNUM_" ; List Template Exporter ; "_VALMDATE,^(1.1)=" ;; ;",SIZE=0
 F LINE=2:1 S VALMLN=$O(^UTILITY($J,VALMLN)) Q:VALMLN=""  S ^UTILITY($J,0,LINE)=^(VALMLN,0),SIZE=$L(^(LINE))+SIZE I $E(^(LINE),1,2)'=" .",SIZE+700>VALMAX Q
 I VALMLN,$O(^UTILITY($J,VALMLN)) S ^UTILITY($J,0,LINE+1)=" G ^"_VALMROU_(VALMNUM+1)
 S X=VALMROU_VALMNUM X ^DD("OS",VALMSYS,"ZS") W !,X_" has been filed..."
 Q
 ;
