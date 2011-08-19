MCARDNJ2 ;WISC/TJK,JA-FUNCTION FOR DISPLAY ONLY ;8/22/96  15:28
 ;;2.3;Medicine;;09/13/1996
FUNC ;FUNCTION COMMANDS
 X DJCP W DJHIN X XY W "FUNCTIONS",DJLIN
 W !!,"  ^ -- Quit"
 W:$P(^MCAR(697.3,DJN,0),"^",3)]"" ?41,"U -- Up a page"
 W !,"  N -- New record"
 W:$P(^MCAR(697.3,DJN,0),"^",5)]"" ?41,"D -- Down a page"
LST X DJCL W "FUNCTION: ",$S($P(DJJ,U,4)="":"N",1:"D"),"//" R X:DTIME S:'$T X="^" S:X=""!(X["D") X="D" G MOD:X?1"^"1N.N G Q:X["N"&(DJP=0) Q:X["N"&(DJP=1)
LS1 G:X?1"^" OUT I X["D"&($P(DJJ,U,4)]"")&($D(DJDN)) D SAVE S DJN=$P(DJJ,U,4) S DJN=$O(^MCAR(697.3,"B",DJN,0)) S:DJN="" DJN=-1 S DJFF=0 D N^MCARDPL Q:$D(DJY)  S (DA,W(V))=DJDN D ^MCARD1 G EN2^MCARDNJ
 I X["D"&($P(DJJ,U,4)="") S:$P(DJJ,U,2)'="" DJFF=0 G Q
 G:X["U" PREV
 G LST
MOD I $D(DJJ($P(X,U,2))) S V=$P(X,"^",2) S:DJ4["M"&($D(DJDIS)) DJSW1=1,DJDIS=0 S V=V-.001 G NXT
PREV G LST:$P(DJJ,U,2)="" S DJN=$P(DJJ,U,2) S:DJN'=+DJN DJN=$O(^MCAR(697.3,"B",DJN,0)) S:DJN="" DJN=-1 S DJFF=0 D REST D N^MCARDPL G NXT
Q I $P(^MCAR(697.3,DJN,0),U,3)'="" F DJK=0:0 S (DJDPL,DJNM)=$P(^MCAR(697.3,DJN,0),U,3),DJN=$O(^MCAR(697.3,"B",DJNM,0)) S:DJN="" DJN=-1 Q:$P(^MCAR(697.3,DJN,0),U,3)=""
 K V,DJ0,DJAT,DJDN,DJ3,DJ4,DJQ I '$D(DJW1) D ^MCARDPL G EN2^MCARDNJ
OUT K DJSV,DJ0,DJAT,DJK,DJDN,DJ3,V,DJJ,DJQ,DIC,DJDD,DX,DY,DJSM,DJDIC,DJKEY S DJFF=0 Q
KILL K DB,DC,DE,DG,DH,DI,DK,DL,DM,DP,DR,DW Q
SAVE S %X="V(",%Y="^TMP($J,""DJ"",DJN," D %XY^%RCR K V Q
REST K V S %X="^TMP($J,""DJ"",DJN,",%Y="V(" D %XY^%RCR Q
NXT G NXT^MCARDNJ
 ;CALLED BY MCARDNJ
COMPUTE D COMPUTE1 G NXT
COMPUTE1 D:$D(DA(1)) SET X $P(^DD(DJDD,$P(DJJ(V),U,3),0),U,5,99) D BLANK^MCARD1 S V(V)=X D:$D(DA(1)) RESET S @$P(DJJ(V),U,2) X XY S $P(DJDB," ",DJJ(V))=" " W DJDB X XY W:X DJHIN,X K DJDB X XY
 Q
SET S DJMD0=D0,DJMD1=D1,D0=DA(1),D1=DA Q
RESET S D0=DJMD0,D1=DJMD1 K DJMD0,DJMD1 Q
B S DJDB="" S:(DJJ(V)-$L(V(V))) $P(DJDB," ",DJJ(V)-$L(V(V)))=" " Q
D S $P(DJDB,".",DJJ(V))="."
 Q
 ;
Z ;    input reader - invoked by R^MCARDNJ
 D DCS^MCARDNQ
 ;
 ;    if this is a pointer multiple, do some cleanup of the system table
 S X=$P(DJJ(V),"^",4)
 IF X["P",X["M" D  ;    a pointer multiple
 .  K DIC("S") ;,DA
 .  S DG=12,DIC(0)="EQZML"
 .  S DIC("V")=DIC_D0_","_(+$P(DJ0,"^",4))_"," ;    suspect that this is the critical variable
 .  S DJXX="?",Y=-1
 .  Q
 ;END IF
 ;
 ;    get the input
 S X="",DJSM=0,DJLG=+DJJ(V)+1
 ;I DJLG<81 D
 ;.  R X#DJLG:DTIME S DJZ=$T
 ;E  ;    next line used to be concatenated with this one
 S X=$$RESPONSE^MCARDSE("",DJLG-1,DX,DY),DJZ=$P(X,"~",2),X=$P(X,"~",1)
 S:'DJZ X="^" S:X="" DJSM=1 K:X="" DIC("S")
 I $L(X)>(DJLG-1) W @IOBS," ",*7 X XY S:'$D(V(V)) V(V)="" D B:V(V)'="",D:V(V)="",M K DJDB X XY G Z
 I X?1"^".E!(X?1"?".E) S:'$D(V(V)) V(V)="" D B:V(V)'="",D:V(V)="" X XY W DJHIN X XY D M W DJLIN K DJDB X XY Q
 Q
N R !,"Press <RETURN> to Continue",DJX:DTIME S DJSV=V D N^MCARDPL S V=DJSV Q
HELP W !!,*7,"Answer 'YES' or 'NO'.  As a general rule, you should repaint the screen if the screen has been 'pushed up' by the word processing field"
 G N
M ;W V(V) W:$D(DJDB) DJDB ; ;8/31/92  14:18
 S DJDB=V(V)_$G(DJDB)
 I $L(DJDB)<80 W DJDB
 E  W $E(DJDB,1,80-DX),!,$E(DJDB,80-DX+1,$L(DJDB))
 Q
