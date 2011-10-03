DENTD1 ;WASH ISC/TJK,FDJW,JA-FILL V() AFTER SELECTION ;8/31/92  09:27
 ;;1.2;DENTAL;***15**;Oct 08, 1992
 S DJSW2=1
S1 S DJ14=-1,DJ9=V,DJ8=DJN
 S:'$D(DJST) DJST=1 I DJST=1 S ^TMP($J,"DJST",1,"DA")=W(DJ9),^TMP($J,"DJST",1,"SC")=DJN,^TMP($J,"DJST",1,"LOC")="",^TMP($J,"DJST",1,"DIC")=DIC,^TMP($J,"DJST",1,"DD")=DJDD,^TMP($J,"DJST",1,"GN")=""
 F V=DJF-.01:0 S V=$O(DJJ(V)) S:V="" V=-1 Q:V<0!(V>DJL)  S DJ16=$P(DJJ(V),U,4) D:DJ16["M" M D:DJ16'["M" S
 S V=DJ9,@$P(DJJ(V),U,2) K DJ3,DJ14,DJ5,DJ16,DJ7,DJ8,DJ9,Y,DJZ,DJS
 Q
S S DJ7=$P(DJJ(V),U,3) Q:DJ7=""!$P(DJJ(V),U,4)!(DJ7<0)  I DJ7=.001 S V(V)=+Y G SQ
 S:DJST=1 D0=DA D:DJST>1 COMP
 I $P(DJJ(V),U,4)["C" S DJ16=$P(DJJ(V),U,4),@$P(DJJ(V),U,2) G SQ3
 S DJ16=$P(^DD(DJDD,DJ7,0),U,4),DJ5=$P(DJ16,";",2),DJ16=$P(DJ16,";",1) G:DJ5=" " SQ
 S:DJ14'=DJ16 DJ14=DJ16,DJ3=$S($D(@(DIC_"+W(DJ9),DJ16)")):^(DJ16),1:"") S @("V(V)=$"_$S(DJ5:"P",1:"E")_"(DJ3,"_$S(DJ5:"U,DJ5)",1:+$E(DJ5,2,9)_","_$P(DJ5,",",2)_")"))
SQ Q:$G(V(V))=""!'$D(DJJ(V))  S DJ16=$P(DJJ(V),U,4),@$P(DJJ(V),U,2)
SQ1 I DJ16["D" S Y=V(V) D DT S V(V)=Y K DJ5 G E
 I DJ16["P",$D(@("^"_$P(^DD(DJDD,DJ7,0),U,3)_"V(V),0)")) S V(V)=$P(^(0),U,1) D P G E
SQ3 I DJ16["C" X $P(^DD(DJDD,DJ7,0),U,5,99) D:$E(X)=" " BLANK S V(V)=X S:+X=0 V(V)="" G:DJ16["D" SQ1
 I DJ16["S" S DJS=$P(^DD(DJDD,DJ7,0),U,3) F DJK=1:1 S DJZ=$P(DJS,";",DJK) Q:DJZ=""  I $P(DJZ,":",1)=V(V) S V(V)=$P(DJZ,":",2)
E ;    display the datum
 X XY
 IF V(V)'="" D  ;    no need to display a blank
 .  D O ;    execute the output transform
 .  S V(V)=$E(V(V),1,+DJJ(V))
 .  IF DJSW2 D  ;    display switch is on
 ..    W DJHIN
 ..    X XY
 ..    ;W V(V),DJLIN
 ..    S DJDB=""
 ..    I DJJ(V)-$L(V(V)) S $P(DJDB," ",DJJ(V)-$L(V(V)))=" "
 ..    ;I $L(DJDB) W DJDB
 ..    S DJDB=V(V)_DJDB
 ..    ;
 ..    ;    do we have more than 80 characters to write?
 ..    I $L(DJDB)'>80 W DJDB ;    no
 ..    E  W $E(DJDB,1,80-DX),!,$E(DJDB,80-DX+1,$L(DJDB)) ;    yes
 ..    W DJLIN
 ..    K DJDB
 ..    Q
 .  ;END IF
 .  ;
 .  Q
 ;END IF
 ;
 I DJ7=.01&(DJ16'["M") S ^TMP($J,"DJST",DJST,"TITLE")=$P(^DD(DJDD,.01,0),"^",1)_":"_V(V),^TMP($J,"DJST",DJST-1,"KEY")=V(V)
 Q
P ;
 S DJZ=+$P($P(^DD(DJDD,DJ7,0),"^",2),"P",2) Q:$P(^DD(DJZ,.01,0),"^",2)'["P"
P1 I $D(@("^"_$P(^DD(DJZ,.01,0),U,3)_"V(V),0)")) S V(V)=$P(^(0),U,1)
 S DJZ=+$P($P(^DD(DJZ,.01,0),"^",2),"P",2) Q:$P(^DD(DJZ,.01,0),"^",2)'["P"  G P1
 ;
M S @$P(DJJ(V),U,2),DJM1=$P($P(^DD(DJDD,$P(DJJ(V),U,3),0),U,4),";",1),DJQ1="""",DJM1=$S(DJM1'=+DJM1:DJQ1_DJM1_DJQ1,1:DJM1),DJM2=$S($D(@(DIC_+W(DJ9)_","_DJM1_")")):@(DIC_+W(DJ9)_","_DJM1_",0)"),1:"")
 S DJDD1=+$P(DJJ(V),U,4) I DJM2="" S V(V)="",DJM3="" G QQ
 ; naked reference refers to Line tag M.
 S DJM3=$P(DJM2,U,3) S:DJM3>0 V(V)=$P(^(DJM3,0),U,1) S:DJM3<1!(DJM3="") V(V)="" S DJ16=$P(^DD(DJDD1,.01,0),U,2)
 S DJDDS=DJDD,DJDD=DJDD1
 S DJ7=.01 D:DJM3>0 SQ1 S DJDD=DJDDS
QQ S V(V,"DA")=DJM3,V(V,"GN")=$P(DJM1,";",1),V(V,"DD")=$P($P(DJJ(V),U,4),"M",1),Y=-1 K DJDD1,DJ7,DJM1,DJM2,DJM3,DJQ1,DJDDS Q
COMP F DJK=0:1:DJST-2 S @("D"_DJK)=^TMP($J,"DJST",DJK+1,"DA")
 S DJK=DJST-1,@("D"_DJK)=DA Q
DT S:Y Y=$S($E(Y,4,5):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y,4,5))_" ",1:"")_$S($E(Y,6,7):+$E(Y,6,7)_",",1:"")_($E(Y,1,3)+1700)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),"^",Y[".")
 Q
O ;EX OUTPUT TRANSFORM
 I $D(^DD(DJDD,DJ7,2)) S Y=V(V) X ^(2) S V(V)=Y Q
 Q
EN ;DO NOT PRINT V(V)
 S DJSW2=0 G S1
BLANK F I=1:1:$L(X) Q:$E(X,I)'=" "
 S X=$E(X,I,$L(X))
 Q
