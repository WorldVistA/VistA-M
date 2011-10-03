LRNITEG ;SLC/FHS - INTEGRITY CHECKER FOR LAB SERVICE PACKAGE ;8/3/89  17:52 ;
 ;;5.2;LAB SERVICE;**1**;Sep 27, 1994
EN ;set %ZOSF variables
 ; This routine stores routines (variable X) in ^TMP("LRNITEG" returns
 ; XBIT which is = $A(X) and SIZE which is the $L(X)
NEW ;
 N I,A,DIF,DIC,Y,II,XCNP,XCS,XCM,XCN,%,X
 K ^TMP("LRNITEG",$J) S XLOAD=^%ZOSF("LOAD"),XTEST=^("TEST"),DIF="^TMP(""LRNITEG"""_","_$J_","
 S XSIZE="S SIZE=0,I=1 F A=0:0 S I=$O(^TMP(""LRNITEG"",$J,I)) Q:I=""""  S SIZE=SIZE+$L(^(I,0))+2"
 Q
VER ; Select or add version #
 K DIC S U="^",DIC("A")=" Select Version # "
 S DIC(0)="AQEZ",DIC="^LAB(69.91,"
 I $D(LOAD) S DIC(0)=DIC(0)_"L",DLAYGO=69
 D ^DIC G:Y<0 STOP S VNODE=+Y,VER=$P(Y,U,2),VERDDT=$P(Y(0),U,2)
 Q
LOOP ; Loop thru intire file checking for mis-match between file directory
 K %DT S %DT="RX",X="NOW" D ^%DT W !,Y
 D EN,VER Q:Y<1  S II=0,LRST=""
ASK R !," Enter Routine to start checking from ",X:DTIME Q:'$T!(X[U)  W:X["?" !!,"Enter a program name to start with " G:X["?" ASK I $L(X),$E(X)="L" S II=X
 S:'$L(X) X="L" I $E(X)'="L" W $C(7),!!?7,"ENTER RETURN OR ROUTINE BEGINNING WITH 'L' " G ASK
 S II=X
ASK1 R !!," Enter EXACT routine to stop checking : ALL// ",X:DTIME Q:'$T!(X[U)  W:X["?" !!,"Enter the name of a program to stop this routine " G:X["?" ASK1 I $L(X),$E(X)="L" S LRST=X
 S:'$L(X) X="" I $L(X),$E(X)'="L" W $C(7),!!?7,"ROUTINE MUST START WITH 'L' " G ASK1
 K ZTSK,IO("Q"),%ZIS S LRST=X,%ZIS="0NQ" D ^%ZIS G:POP STOP I $D(IO("Q"))!(IO'=IO(0)) G QUE
 W !!?7,"Enter '^' to stop ",!!
DQ ;
 S PN=$S($G(^TMP("LRNITEGL")):^("LRNITEGL"),1:0)
 F A=0:0 R X:.1 Q:X="^"  S II=$O(^LAB(69.91,VNODE,"ROU","B",II)) Q:II=""!(II=LRST)  W "." S IX=$O(^(II,0)),X=$P(^LAB(69.91,VNODE,"ROU",IX,0),U),SIZE=$P(^(0),U,2),YBIT=$P(^(0),U,3),ER=0 I $E(X,1,5)'="LRINI" D SIZE I 'ER,XBIT'=YBIT D LOG
 Q
LOG W !,"EDIT/CHANGE IN ",X,!,$C(7) S PN=PN+1,^TMP("LRNITEGL")=PN,^("LRNITEGL",X,DT)=PN
 Q
SIZE ; Test for existence of X, load routine into ^TMP("LRNITEG" AND COUNT $L(X)
 ;Entry point for trigger of ^lab(69.911,.01  Caution if changed.
 N DIF,XCNP S DIF="^TMP(""LRNITEG"""_","_$J_"," X XTEST G:'$T ER S XCNP=0 K ^TMP("LRNITEG",$J) X XLOAD,XSIZE
BIT ;
 S XBIT=0 F I=2:1 Q:'$D(^TMP("LRNITEG",$J,I,0))  S L=^(0),LN=$L(L) F NT=1:1:LN S XBIT=$A(L,NT)+XBIT
CKSUM ; Compute Check Sum
 I '$D(^%ZOSF("RSUM")) S XSUM=1 Q
 X ^%ZOSF("RSUM") S XSUM=Y
 Q
ER ; Error msg for when attempt to use a routine that doen't exist
 S ER=1 W !,"There is not a routine called '",X,"' in this directory ",$C(7),! K X Q
ER2 ; Error msg when the version being loaded does not match the version selected for auto loading
 W !?10,ROU," is version ",$S($L($P(^TMP("LRNITEG",$J,2,0),";",3)):$P(^(0),";",3),1:"Unknown ")," NOT LOADED",$C(7),! Q
STOP ; clean-up
 K A,BIT,CNT,DIF,ER,I,II,IX,L,LN,LOAD,NT,ROU,SIZE,VER,VERDDT,VNODE,XBIT,XCM,XCN,XCMP,XCNP,XCS,XLOAD,XSIZE,XSUM,XTEST,YBIT,^TMP("LRNITEG",$J),DLAYGO Q
 Q
LOOK ; Entry point to look thru the whole selected version routine, checking for mis-matches  Prints the DA every tenth time
 G LOOP
SING ; Entry point for a single routine data look-up
 K DIC D EN,VER G STOP:Y<0 K DIC S DIC(0)="EQAL",DIC="^LAB(69.91,"_VNODE_",""ROU"",",DLAYGO=69,DA(1)=VNODE
SING1 ; Loop point
 D ^DIC G STOP:Y<0 S X=$P(Y,U,2),YBIT=$P(^LAB(69.91,VNODE,"ROU",+Y,0),U,3),ER=0 D SIZE I ER G SING1
 W !,$S(XBIT'=YBIT:" The "_X_" routine has been EDITED ",1:" The "_X_" routine is unedited"),!,"$(A) SIZE = ",XBIT,"      $(L) SIZE = ",SIZE
 W !?10,"Check Sum = ",XSUM,! G SING1
 Q
QUE ;
 S ZTDESC="PRINT CHANGES IN THE LAB INTEGRITY FILE ",ZTRTN="^DQ^LRNITEG",ZTIO=ION F I="VER","VERDDT","II","VNODE","LRST","XLOAD","XSIZE" S ZTSAVE(I)=""
 D ^%ZTLOAD W !!?10,"Queued to device "_ION,!!,$C(7) G STOP
SCREEN ;Screen routine for version number
 N XCNP,DIF,% S VER=$P(^LAB(69.91,DA(1),0),U) S XCNP=0,DIF="^TMP(""LRNITEG"","_$J_"," X ^%ZOSF("LOAD") I $P(@(DIF_"2,0)"),";",3)'=VER K X
 Q
 ;
SUM(REF) ; Sum -> Position-relative Ascii total
 N LRASC,LRDATA,LRPOS,LRTOT,LRREF,X
 ;
 ;  Various quits...
 QUIT:$G(REF)']""!(REF="^") "Invalid reference passed" ;->
 QUIT:$TR(REF,"^","")']"" 0 ;->
 ;
 ;  Does node exist?
 K X S (LRREF,X)="I $D("_REF_")#2" D ^DIM
 I '$D(X) QUIT "Node does not exist..." ;->
 I $D(X) X LRREF QUIT:'$T "Node does not exist..." ;->
 ;
 ;  Now, build sum...
 S LRTOT=0,LRDATA=@REF
 I $L(LRDATA) F LRPOS=1:1:$L(LRDATA) D
 .  S LRASC=$A($E(LRDATA,+LRPOS))
 .  S LRTOT=LRTOT+(LRASC*LRPOS)
 ;
 QUIT LRTOT
 ;
