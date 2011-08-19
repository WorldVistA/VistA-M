GMRACMR1 ;HIRMFO/WAA-Find clinics and wards ;12/16/97  10:35
 ;;4.0;Adverse Reaction Tracking;**9**;Mar 29, 1996
MDIC() ; FUNTION RETURNS S ^TMP($J,"GMRAWC",GMRANUM,GMRAX)=""
 ; FUNCTION VALUE IS -1 IF USER ABORTS, 0 IF NO LOCS PICKED, ELSE 1
 N DIC,MDIC,NEG,X,Y K GMRANLOC,^TMP($J,"GMRAWC") S GMRANUM=0
DIC W !,$S('$D(^TMP($J,"GMRAWC")):"Select",1:"Another")_" Location: " R X:DTIME E  S X="^^"
 I $$UP^XLFSTR(X)="ALL" D  G:X="" DIC
 .F  S %=1 W !,"Do you mean ALL Locations" D YN^DICN S:%=-1 X="^",%=2 Q:%  W !,"Enter Y for yes you mean ALL or N for no.",$C(7)
 .I %=2 K % Q
 .I %=1 K % S X=0  F  S X=$O(^SC(X)) Q:X<1  D
 ..I $$SCRIACT^GMRACMR1(X) S ^TMP($J,"GMRAWC",X)=$P($G(^SC(X,0)),U,3)
 ..Q
 .K % S X=""
 .Q
RETURN I "^^"[X S MDIC=$S(X["^":-1,1:$D(^TMP($J,"GMRAWC"))) Q MDIC
 I X?1"?".E D HLP S:Y<0 X="^^" G:Y<0 RETURN S X="?"
 S NEG=X?1"-".E,X=$E(X,NEG+1,$L(X)),DIC="^SC(",DIC(0)="EQMZ",DIC("S")="I $$SCRIACT^GMRACMR1(+Y)" D ^DIC K DIC,DLAYGO I +Y'>0 G DIC
 I 'NEG S GMRANUM=GMRANUM+1,^TMP($J,"GMRAWC",+Y)=$P(^SC(+Y,0),U,3)
 E  K ^TMP($J,"GMRAWC",+Y)
 G DIC
HLP ; PRINT LOCATIONS SELECTED ALREADY
 W $C(7) I $D(^TMP($J,"GMRAWC")) W !?3,"YOU HAVE ALREADY SELECTED: "
 S Y="",X=0 F  S Y=$O(^TMP($J,"GMRAWC",+Y)) Q:Y=""  W !?5,$P(^SC(+Y,0),U) S X=X+1 I X>5 W !,"""^"" TO STOP: " R X:DTIME S:'$T X="^^" S:X="^^" Y=-1 Q:X="^"!(Y<0)  S X=0
 Q:Y<0
 W !!?3,"You may deselect from the list by typing a '-' followed by location name.",!?4,"E.g.  -3E would delete 3E from the list of locations already selected."
 W !?4,"You may enter the word ALL to select all appropriate locations."
 Q
SCRIACT(X) ; GIVEN X AS 44 ENTRY, THIS SCREEN WILL DETERMINE IF IT IS
 ; ACTIVE OR NOT FOR THIS REPORT.  RETURNS 0 IF IT IS NOT, ELSE 1
 S X("ANS")=0,X(0)=$G(^SC(X,0))
 I X(0)'="" D
 .I GMRAQST'[$P(X(0),U,3) Q
 .I $P(X(0),U,3)="W" D
 ..S GMRA42=+$G(^SC(X,42)) Q:GMRA42=""!($G(^DIC(42,GMRA42,0))="")
 ..I '$O(^DIC(42,GMRA42,"OOS",0)) S X("ANS")=1 Q
 ..I GMRASEL["1" S X("ANS")=$$ACT42(DT,DT)
 ..I 'X("ANS"),GMRASEL["3" S X("ANS")=$$ACT42(GMRAST,GMRAED)
 ..Q
 .I GMRASEL["2","^C^M^"[(U_$P(X(0),U,3)_U) D
 ..S X("I")=$G(^SC(X,"I"))
 ..I $P(X("I"),U)]"",$P(X("I"),U)<$S(GMRASEL["2"!(GMRASEL["3"):GMRAST,1:DT) D  Q
 ...Q:$P(X("I"),U,2)=""!(GMRASEL'["2"&(GMRASEL'["3"))
 ...Q:$P(X("I"),U,2)'=""&($P(X("I"),U,2)'<GMRAED)
 ...S X("ANS")=1
 ...Q
 ..S X("ANS")=1
 ..Q
 .Q
 Q X("ANS")
ACT42(START,END) ; DETERMINES IF A WARD IS ACTIVE DURING A D/T RANGE
 ; WARD IS IN GMRA42, AND PASS IN START AND END AS D/T RANGE
 N ANS,OOS
 S ANS(0)=0,ANS=1,OOS(1)=9999999-(START+.000001) ;**NEW CODE RM-5/24/93
 F  S OOS(1)=$O(^DIC(42,GMRA42,"OOS","AINV",OOS(1))) Q:OOS(1)<1  D  Q:ANS(0)
 .S OOS(2)=0 F  S OOS(2)=$O(^DIC(42,GMRA42,"OOS","AINV",OOS(1),OOS(2))) Q:OOS(2)<1  D  Q:ANS(0)
 ..S OOS=$G(^DIC(42,GMRA42,"OOS",OOS(2),0)) Q:OOS=""
 ..I '$P(OOS,U,6) Q
 ..S ANS(0)=1,ANS=0 I $S($P(OOS,U,4)="":0,1:$P(OOS,U,4)<END) S ANS=1 ;**NEW CODE RM-5/24/93
 ..Q
 .Q
 Q ANS
