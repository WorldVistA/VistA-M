GMVLGQU ;HIOFO/YH,FT-UTILITY FOR LEGEND, PO2 AND QUALIFIER ;11/8/01  14:31
 ;;5.0;GEN. MED. REC. - VITALS;;Oct 31, 2002
 ;
 ; This routine uses the following IAs:
 ; #10104 - ^XLFSTR calls          (supported)
 ;
LEGEND ;CREATE VITAL/QUALIFIER/SYNONYM LEGEND STORED IN GLINE LOCAL GLOBAL
 N I,X,J,K,G,B S (I,J,B)=0,(X,GLINE(1),GLINE(2),GLINE(3),GLINE(4),GLINE(5),GLINE)=""
 F G(1)="T","P","R","B","H","W","PO2","CG","CVP","PN" I $D(GMRQUAL(G(1))) D LEGEND1
 S J=J+1,GLINE(J)=X
 K ^UTILITY($J),DIWF,DIWL,WIWR Q
LEGEND1 ;
 S G=$S(G(1)="CG":"CIRC/GIRTH",G(1)="PO2":"PULSE OX",G(1)="B":"BP",G(1)="W":"WT",G(1)="H":"HT",G(1)="T":"TEMP",G(1)="P":"PULSE",G(1)="R":"RESP",G(1)="PN":"PAIN",1:G(1))_" - "
 S X=X_$S(B=0:"",1:"    ")_G S B=1 D:$L(X)>150 CUT D
 . S G="" F  S G=$O(GMRQUAL(G(1),G)) Q:G=""  S X=X_G_"  " I $L(X)>150 D CUT
 Q
CUT ;
 S DIWF="",DIWL=0,DIWR=$S(+$G(GLPRNTR):120,1:150) K ^UTILITY($J) D ^DIWP
 S I=+$P(^UTILITY($J,"W",0),"^")
 S J=J+1,GLINE(J)=$G(^UTILITY($J,"W",0,1,0)),X=$G(^UTILITY($J,"W",0,2,0))
 K ^UTILITY($J)
 Q
SYNOARY ;
 K GG S GG=$L(GMRSITE(1),";") F GG(1)=1:1:GG S GG(2)=$P(GMRSITE(1),";",GG(1)) S GG(3)=$O(^GMRD(120.52,"B",GG(2),0)) D:GG(3)>0
 . S GMRSITE=GMRSITE_$S(GMRSITE="":"",1:" "),GSYNO=""
 . I $P($G(^GMRD(120.52,GG(3),0)),"^",2)'="" S GSYNO=$P(^(0),"^",2)
 . E  S GCHA=GG(2) D
 . . I GCHA["-" S GCHA=$P(GCHA,"-")_" "_$P(GCHA,"-",2)
 . . I $L(GCHA," ")<2 S GSYNO=$E(GCHA)_$$LOW^XLFSTR($E(GCHA,2,3))
 . . E  S GLEN=$L(GCHA," ") F I=1:1:GLEN S GSYNO=GSYNO_$S($E($P(GCHA," ",I))'="(":$E($P(GCHA," ",I)),1:"")
 . I GG(2)'="" S GG(2)=$E(GG(2))_$$LOW^XLFSTR($E(GG(2),2,30))
 . S GMRSITE=GMRSITE_GSYNO S:GI'="C" GMRQUAL(GI,GSYNO_": "_GG(2))="" K GLEN
 Q
PO2(X) ;
 I X="" Q
 I X["%" D
 . S X(2)=$P(X,"%")
 . I X(2)["l/min" S X(2)=$P(X(2),"l/min",2)
 I X["l/min" D
 . S X(1)=$P(X,"l/min")
 . I X(1)["%" S X(1)=$P(X(1),"%",2)
 S X(1)=$$STRIP^XLFSTR(X(1)," "),X(2)=$$STRIP^XLFSTR(X(2)," ")
 Q
