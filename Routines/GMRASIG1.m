GMRASIG1 ;HIRMFO/WAA-A/AR PATIENT SIGN OFF PART2 ;9/22/06  10:49
 ;;4.0;Adverse Reaction Tracking;**2,17,21,36**;Mar 29, 1996;Build 9
PRINT ;Print out data to be signed off on
 N DIR,X,Y
 S GMRAPA=""
 I GMRASIGN W @IOF
 W !,"ADVERSE REACTION",!,"----------------" ;21
 S (GMRAI,GMRACNT)=0
 F  S GMRACNT=$O(^TMP($J,"GMRASF",GMRACNT)) Q:GMRACNT<1  S GMRAPA=$O(^TMP($J,"GMRASF",GMRACNT,0)) Q:GMRAPA<0  D  Q:GMRAOUT  I $Y>(IOSL-4) D PAGE Q:GMRAOUT
 .W ! W:GMRACNTT>1 GMRACNT,")" ;21
 .S GMRAG=^GMR(120.8,GMRAPA,0),GMRADRG=$S($P(GMRAG,U,20)="D":1,1:0)
 .W "  ",$P(GMRAG,U,2),! ;21
 .W !,?11,"Obs/Hist:",?21,$S($P(GMRAG,U,6)="o":"OBSERVED",$P(GMRAG,U,6)="h":"HISTORICAL",1:"") I $P(GMRAG,U,6)="o" W !,?12,"Obs d/t: ",$$FMTE^XLFDT($P(^GMR(120.85,$O(^GMR(120.85,"C",GMRAPA,0)),0),U)) ;21
 .K GMRAHEAD
 .K GMRAREC I $D(^GMR(120.8,GMRAPA,10,0)) D
 ..S GMRAOTH=$O(^GMRD(120.83,"B","OTHER REACTION",0))
 ..S GMRAREC=0 F  S GMRAREC=$O(^GMR(120.8,GMRAPA,10,GMRAREC)) Q:GMRAREC'>0  D  ;21
 ...S X=$G(^GMR(120.8,GMRAPA,10,GMRAREC,0)),GMRAREC(GMRAREC)=$S($P(X,U)'=GMRAOTH:$P($G(^GMRD(120.83,+$P(X,U),0)),U),1:$P(X,U,2)) ;21
 ...I $P(X,U,4)>0 S $P(GMRAREC(GMRAREC),U,2)=$$FMTE^XLFDT($P(X,U,4),2) ;21
 ...Q  ;21
 ..Q
 .I $D(GMRAREC)=11 S GMRAREC=$O(GMRAREC("")) W !,?5,"Signs/Symptoms: ",?21,$P(GMRAREC(GMRAREC),U) W:$P(GMRAREC(GMRAREC),U,2)'="" " ("_$P(GMRAREC(GMRAREC),U,2)_")" ;21
 .;W ?65,$S($P(GMRAG,U,6)="o":"OBSERVED",$P(GMRAG,U,6)="h":"HISTORICAL",1:"")
 .I $G(GMRAREC)>0 F  S GMRAREC=$O(GMRAREC(GMRAREC)) Q:GMRAREC<1  W !,?21,$P(GMRAREC(GMRAREC),U) W:$P(GMRAREC(GMRAREC),U,2)'="" " ("_$P(GMRAREC(GMRAREC),U,2)_")" I $Y>(IOSL-4) D PAGE Q:GMRAOUT  ;21
 .Q:GMRAOUT  D:$Y>(IOSL-4) PAGE Q:GMRAOUT  W !
 .D OUTPUT^GMRAPEM1 Q:GMRAOUT
 .Q
 Q:GMRACNTT'>1
 Q:'GMRASIGN
 W (GMRACNTT+1),")  All of the above",! ;17
 W (GMRACNTT+2),")  None of the above",! ;17
 Q
PAGE ;PAGE
 N DIR
 D ENDPG^GMRADSP3 Q:GMRAOUT
 W @IOF,!
 Q
PNOTE ; Generate a Progress Note for a patient
 Q:$G(GMRAUSER,0)
 N GMRAOUT S GMRAOUT=0
 I $D(GMRASLL) D
 .N GMRAFLL,X
 .S X=0 F  S X=$O(GMRASLL(X)) Q:X<1  D
 ..I GMRASLL(X) Q
 ..I $P($G(^GMR(120.8,X,0)),U,6)'="o" Q
 ..S GMRAFLL(X)=""
 ..Q
 .Q:'$D(GMRAFLL)
 .D EN1^GMRAPET0(DFN,.GMRAFLL,"S",.GMRAOUT)
 .Q
 Q
ENCNT ; Count how many entries where selected and set up Sort order
 N SUB ;36
 S (GMRACNTT,X)=0 K ^TMP($J,"GMRARE") ; Resort the entries
 F  S X=$O(^TMP($J,"GMRASF","B",X)) Q:X<1  D
 .S GMRACNTT=GMRACNTT+1
 .S SUB=$O(^TMP($J,"GMRASF","B",X,0)) ;36
 .S ^TMP($J,"GMRARE",GMRACNTT,X)=+$G(^TMP($J,"GMRASF","B",X,SUB)) ;36
 .S ^TMP($J,"GMRARE","B",X,GMRACNTT)=+$G(^TMP($J,"GMRASF","B",X,SUB)) ;36
 .Q
 K ^TMP($J,"GMRASF")
 M ^TMP($J,"GMRASF")=^TMP($J,"GMRARE")
 K ^TMP($J,"GMRARE")
 Q
YNSO ;Select sign off for a patient
 W @IOF,!,"Causative Agent Data edited this Session:"
 K X D PRINT ; Redisplay the reactions
 K DIR S DIR(0)="L^1:"_(GMRACNTT+2),GMRALL=GMRACNTT+1,GMRANON=GMRACNTT+2 ;17
 S DIR(0)=DIR(0)_"^I X[""."" W !,""DO NOT USE DECIMAL VALUES."",$C(7) K X Q"
 S DIR("A")="Select the Correct data "
 S DIR("?")="^D PRINT^GMRASIG1"
 D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) S Y=GMRANON_","
 I Y=(GMRALL_",") D ALLSNG^GMRASIGN ; User select all the reaction
 I Y=(GMRANON_",") S Y="" ; user select not of the reactions
 I $F(Y,","_GMRALL_",") W !,"INVALID SELECTION: You can only select ",GMRACNT+1,")  All by itself." G YNSO
 I $F(Y,","_GMRANON_",") W !,"INVALID SELECTION: You can only select ",GMRACNT+2,")  None by itself." G YNSO
 Q
