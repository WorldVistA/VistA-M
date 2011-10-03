SPNCMR1 ;HIRMFO/WAA-Find clinics and wards ; 1/23/93
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
MDIC() ; FUNTION RETURNS S ^TMP($J,"SPNWC",SPNNUM,SPNX)=""
 ; FUNCTION VALUE IS -1 IF USER ABORTS, 0 IF NO LOCS PICKED, ELSE 1
 N DIC,MDIC,NEG,X,Y K SPNNLOC,^TMP($J,"SPNWC") S SPNNUM=0
DIC W !,$S('$D(^TMP($J,"SPNWC")):"Select",1:"Another")_" Location: " R X:DTIME E  S X="^^"
 I $$UP^XLFSTR(X)="ALL" D  G:X="" DIC
 .F  S %=1 W !,"Do you mean ALL Locations" D YN^DICN S:%=-1 X="^",%=2 Q:%  W !,"Enter Y for yes you mean ALL or N for no.",$C(7)
 .I %=2 K % Q
 .I %=1 K % S X=0  F  S X=$O(^SC(X)) Q:X<1  D
 ..I $$SCRIACT^SPNCMR1(X) S ^TMP($J,"SPNWC",X)=$P($G(^SC(X,0)),U,3)
 ..Q
 .K % S X=""
 .Q
RETURN I "^^"[X S MDIC=$S(X["^":-1,1:''$D(^TMP($J,"SPNWC"))) Q MDIC
 I X?1"?".E D HLP S:Y<0 X="^^" G:Y<0 RETURN S X="?"
 S NEG=X?1"-".E,X=$E(X,NEG+1,$L(X)),DIC="^SC(",DIC(0)="EQMZ",DIC("S")="I $$SCRIACT^SPNCMR1(+Y)" D ^DIC K DIC,DLAYGO I +Y'>0 G DIC
 I 'NEG S SPNNUM=SPNNUM+1,^TMP($J,"SPNWC",+Y)=$P(^SC(+Y,0),U,3)
 E  K ^TMP($J,"SPNWC",+Y)
 G DIC
HLP ; PRINT LOCATIONS SELECTED ALREADY
 W $C(7) I $D(^TMP($J,"SPNWC")) W !?3,"YOU HAVE ALREADY SELECTED: "
 S Y="",X=0 F  S Y=$O(^TMP($J,"SPNWC",+Y)) Q:Y=""  W !?5,$P(^SC(+Y,0),U) S X=X+1 I X>5 W !,"""^"" TO STOP: " R X:DTIME S:'$T X="^^" S:X="^^" Y=-1 Q:X="^"!(Y<0)  S X=0
 Q:Y<0
 W !!?3,"You may deselect from the list by typing a '-' followed by location name.",!?4,"E.g.  -3E would delete 3E from the list of locations already selected."
 W !?4,"You may enter the word ALL to select all appropriate locations."
 Q
SCRIACT(X) ; GIVEN X AS 44 ENTRY, THIS SCREEN WILL DETERMINE IF IT IS
 ; ACTIVE OR NOT FOR THIS REPORT.  RETURNS 0 IF IT IS NOT, ELSE 1
 S X("ANS")=0,X(0)=$G(^SC(X,0))
 I X(0)'="" D
 .I SPNQST'[$P(X(0),U,3) Q
 .I $P(X(0),U,3)="W" D
 ..S SPN42=+$G(^SC(X,42)) Q:SPN42=""!($G(^DIC(42,SPN42,0))="")
 ..I '$O(^DIC(42,SPN42,"OOS",0)) S X("ANS")=1 Q
 ..I SPNSEL["1" S X("ANS")=$$ACT42(DT,DT)
 ..I 'X("ANS"),SPNSEL["3" S X("ANS")=$$ACT42(SPNST,SPNED)
 ..Q
 .I SPNSEL["2","^C^M^"[(U_$P(X(0),U,3)_U) D
 ..S X("I")=$G(^SC(X,"I"))
 ..I $P(X("I"),U)]"",$P(X("I"),U)<$S(SPNSEL["2"!(SPNSEL["3"):SPNST,1:DT) D  Q
 ...Q:$P(X("I"),U,2)=""!(SPNSEL'["2"&(SPNSEL'["3"))
 ...Q:$P(X("I"),U,2)'=""&($P(X("I"),U,2)'<SPNED)
 ...S X("ANS")=1
 ...Q
 ..S X("ANS")=1
 ..Q
 .Q
 Q X("ANS")
ACT42(START,END) ; DETERMINES IF A WARD IS ACTIVE DURING A D/T RANGE
 ; WARD IS IN SPN42, AND PASS IN START AND END AS D/T RANGE
 N ANS,OOS
 S ANS(0)=0,ANS=1,OOS(1)=9999999-(START+.000001) ;**NEW CODE RM-5/24/93
 F  S OOS(1)=$O(^DIC(42,SPN42,"OOS","AINV",OOS(1))) Q:OOS(1)<1  D  Q:ANS(0)
 .S OOS(2)=0 F  S OOS(2)=$O(^DIC(42,SPN42,"OOS","AINV",OOS(1),OOS(2))) Q:OOS(2)<1  D  Q:ANS(0)
 ..S OOS=$G(^DIC(42,SPN42,"OOS",OOS(2),0)) Q:OOS=""
 ..I '$P(OOS,U,6) Q
 ..S ANS(0)=1,ANS=0 I $S($P(OOS,U,4)="":0,1:$P(OOS,U,4)<END) S ANS=1 ;**NEW CODE RM-5/24/93
 ..Q
 .Q
 Q ANS
