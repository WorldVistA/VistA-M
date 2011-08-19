FBNHRCS1 ;ACAMPUS/dmk-RCS 10-0168 CON'T ;10/20/98
 ;;3.5;FEE BASIS;**12,15**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
START ;called from FBNHRCS for compiling and printing report
 U IO
 D STATION^FBAAUTL I $G(FBPOP) W !,"Cannot determine proper station to build code sheets.",!,"Please check your Fee Basis Site Paramaters file (#161.4)" Q
 S (I,K)=0,J=""
 F  S I=$O(^FBAA(161.21,"ADR",I)) Q:'I  S J="" F  S J=$O(^FBAA(161.21,"ADR",I,J)) Q:'J!(J>-FBBEG)  S K=0 F  S K=$O(^FBAA(161.21,"ADR",I,J,K)) Q:'K  I $D(^FBAA(161.21,K,0)),$P(^(0),U,2)'>FBEND D  K FBCSN
 .S FBCN=$P(^FBAA(161.21,K,0),"^") D CONTR K FBCN Q:'$G(FBCSN)
 .Q:FBSN'=FBCSN
 .S ^TMP($J,"FBRCS",+$P(^FBAA(161.21,K,0),U,4),J,K)=""
 ;
VAL ;when generating code sheets - validate vendors
 I $G(FBGECS) D
 . ; loop thru vendors
 . S FBV=0 F  S FBV=$O(^TMP($J,"FBRCS",FBV)) Q:'FBV  D
 . . I $P($G(^FBAAV(+FBV,1)),U,6)'?7N D:FBGECS  W !,?5,$P($G(^FBAAV(+FBV,0)),U),"   (ien: ",+FBV,")"
 . . . ; turn off code sheets and print message when 1st problem found
 . . . S FBGECS=0
 . . . W !!,"WARNING: NO CODE SHEETS WILL BE CREATED"
 . . . W !,"The following vendor(s) are missing the required field DATE OF"
 . . . W !,"LAST ASSESSMENT. This data must be entered before any code"
 . . . W !,"sheets will be created."
 . ; if any problems were found then pause screen
 . I 'FBGECS,$E(IOST,1,2)="C-" S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 ;
EN ;start going through TMP to output report
 ; FBV=ien of vendor   FBD= latest contract to date(-)
 ; FBI=ien of latest contract within date range
 S FBV=0
 F  S FBV=$O(^TMP($J,"FBRCS",FBV)) Q:'FBV  S FBD=$O(^TMP($J,"FBRCS",FBV,"")),FBI=$O(^(+FBD,0)) D
 .  ; determine low and high rate
 .  ; FBLOW=low $ rate  FBHIGH=high $ rate
 .  ; if only one rate (fblow=fbhigh) report FBHIGH only
 . S (FBJ,CNT)=0 K FB
 . F  S FBJ=$O(^FBAA(161.22,"AC",FBI,FBJ)) Q:'FBJ  S FB(0)=$P($G(^FBAA(161.22,FBJ,0)),U,2) I FB(0),FB(0)<999.99 S CNT=CNT+1,FB(FB(0),CNT)=FB(0)
 .  N I,J,Z D
 ..  S (I,J,FBLOW,FBHIGH)=0
 ..  S FBLOW=$O(FB(0))
 ..  F  S I=$O(FB(I)) Q:'I  S FBHIGH=I F  S J=$O(FB(I,J)) Q:'J
 .. S:FBLOW=FBHIGH FBLOW=0
 .. D  S ^TMP($J,"FBTOT",FBV)=Z
 ... S VNAM=$E($$VNAME^FBNHEXP(FBV),1,23) I $L(VNAM)<23 S VNAM=$$LJ^XLFSTR(VNAM,23," ")
 ... N V S V=$G(^FBAAV(+FBV,1)) S Z=FBSN_U_VNAM_U_$$CSC(FBV)_U_$P(V,U,8)_U_$P(V,U,4)_U_$$DOLLAR(FBHIGH)_U_$$DOLLAR(FBLOW)_U_$P(V,U,5)_U_$$NVET^FBNHRCS2(FBV,FBEND)_U_$S($P(V,U,6)]"":$E($P(V,U,6),1,5)_"00",1:"0000000")
 ;
 Q
 ;
CONTR ;get numeric station number fro contract
 Q:FBCN']""!($E(FBCN,1)="-")
 I $E(FBCN,1,3)?3N S FBCSN=$E(FBCN,1,3) Q
 S FBCN=$E(FBCN,2,$L(FBCN)) G CONTR
 Q
CSC(X) ; This call will return city(15)_u_state code(2)_u_county(3)
 ;X= ien from vendor file
 N Z S Z="               "
 I $S('$G(X):1,'$D(^FBAAV(X,0)):1,1:0) Q Z_U_$E(Z,1,2)_U_$E(Z,1,3)
 N C,S,V,Y S V=$G(^FBAAV(X,0))
 S Y=$E($P(V,U,4),1,15) I $L(Y)<15 S Y=$$LJ^XLFSTR(Y,15," ")
 S S=+$P(V,U,5),S=$P($G(^DIC(5,S,0)),U,3)
 S Y=Y_U_S_$E(Z,$L(S)+1,2)_U_$$COUNTY(+$P(V,U,5),+$P(V,U,13))
 Q Y
 ;
COUNTY(X,Y) ;call returns the 3 digit county code
 ;X= ien of state file
 ;Y= ien of county in state multiple
 ;
 I $S('X:1,'Y:1,'$D(^DIC(5,X,1,Y,0)):1,1:0) Q "   "
 Q $S($L($P($G(^DIC(5,X,1,Y,0)),U,3))=3:$P(^(0),U,3),1:"   ")
 ;
DOLLAR(X) ;round off rate to closest dollar and right justify to 3
 ;X= dollar amount
 ;
 I 'X Q "000"
 S X2=0,X3=4
 D COMMA^%DTC
 Q $E($TR(X," ",0),1,3)
