ENEQMED ;WISC/SAB-Multiple Equipment Edit ;9/24/97
 ;;7.0;ENGINEERING**35,45**;;Aug 17, 1993
 W !,"Multiple Equipment Edit",!
 I $G(IO)="" D HOME^%ZIS
 S ENEDNX=$D(^XUSEC("ENEDNX",DUZ))
 K ^TMP($J)
PO ; get purchase order #
 K ENPO,ENA,ENX
 S DIR(0)="6914,11" D ^DIR K DIR G:Y']""!$D(DIRUT) EXIT S ENX=Y
 I $D(^ENG(6914,"M",ENX)) S ENPO=ENX G POEND
 ; try an alternate format (add/remove station)
 S ENA=$S(ENX["-":$P(ENX,"-",2),1:$P($G(^DIC(6910,1,0)),U,2)_"-"_ENX)
 I ENA]"",$D(^ENG(6914,"M",ENA)) S ENPO=ENA G POEND
 ; show partial matches
 S DIC="^ENG(6914,",ENDX="M",X=ENX D IX^ENLIB1 I X]"" S ENPO=X G POEND
 I ENA]"" S X=ENA D IX^ENLIB1 I X]"" S ENPO=X G POEND
 W $C(7),!,"No equipment with purchase order # '",ENX,"' found in"
 W !,"the Equipment Inventory file."
 G PO
POEND ; have purchase order #
 ; store and sort equip in tmp
 K ^TMP($J,"ENPO")
 S ENDA=0 F  S ENDA=$O(^ENG(6914,"M",ENPO,ENDA)) Q:'ENDA  D
 . S DIC=6914,DR="6;1;4",DA=ENDA,DIQ="ENQ",DIQ(0)="I" D EN^DIQ1 K DIQ
 . F Y=6,1,4 I ENQ(6914,DA,Y,"I")']"" S ENQ(6914,DA,Y,"I")="?"
 . S ^TMP($J,"ENPO",ENQ(6914,DA,6,"I"),ENQ(6914,DA,1,"I"),ENQ(6914,DA,4,"I"),DA)=""
 . K ENQ
 ; build array ENL() of category-manufacturer-model combinations
 K ENL S (ENL,ENC("PO"))=0
 S ENCATI=""
 F  S ENCATI=$O(^TMP($J,"ENPO",ENCATI)) Q:ENCATI']""  D
 . I ENCATI S DIC=6911,DR=".01",DA=ENCATI,DIQ="ENQ" D EN^DIQ1 K DIQ
 . S ENCAT=$S(ENCATI:$E(ENQ(6911,ENCATI,.01),1,24),1:"unspecified") K ENQ
 . S ENMANI=""
 . F  S ENMANI=$O(^TMP($J,"ENPO",ENCATI,ENMANI)) Q:ENMANI']""  D
 . . I ENMANI S DIC=6912,DR=".01",DA=ENMANI,DIQ="ENQ" D EN^DIQ1  K DIQ
 . . S ENMAN=$S(ENMANI:$E(ENQ(6912,ENMANI,.01),1,24),1:"unspecified") K ENQ
 . . S ENMOD=""
 . . F  S ENMOD=$O(^TMP($J,"ENPO",ENCATI,ENMANI,ENMOD)) Q:ENMOD']""  D
 . . . S ENDA=0,ENC("LINE")=0
 . . . F  S ENDA=$O(^TMP($J,"ENPO",ENCATI,ENMANI,ENMOD,ENDA)) Q:'ENDA  D
 . . . . S ENC("LINE")=ENC("LINE")+1
 . . . S ENL=ENL+1
 . . . S ENL(ENL)=ENCATI_U_ENCAT
 . . . S ENL(ENL)=ENL(ENL)_U_ENMANI_U_ENMAN_U_ENMOD_U
 . . . S ENL(ENL)=ENL(ENL)_$S(ENMOD="?":"unspecified",1:$E(ENMOD,1,14))
 . . . S ENL(ENL)=ENL(ENL)_U_ENC("LINE")
 . . . S ENC("PO")=ENC("PO")+ENC("LINE")
 S ENL("MAX")=ENL
 ; display array
 W @IOF
 W ENC("PO")," Equipment Items found with Purchase Order # = ",ENPO
 W !,"Line",?6,"Equipment Category",?32,"Manufacturer"
 W ?58,"Model",?74,"Count",!
 F ENL=1:1:ENL("MAX") D
 . W !,ENL,?6,$P(ENL(ENL),U,2),?32,$P(ENL(ENL),U,4)
 . W ?58,$P(ENL(ENL),U,6),?74,$P(ENL(ENL),U,7)
 ; get lines to edit
 S DIR(0)="L^1:"_ENL("MAX")
 S DIR("A")="Select line(s) to edit"
 D ^DIR K DIR G:$D(DIRUT) EXIT S ENL("SEL")=Y
 S ENC("SEL")=0
 F ENI=1:1 S ENL=$P(ENL("SEL"),",",ENI) Q:'ENL  S ENC("SEL")=ENC("SEL")+$P(ENL(ENL),U,7)
 W !,ENC("SEL")," Equipment Items will be edited",!
 ; save/lock selected equipment
 K ^TMP($J,"ENSEL")
 S ENLOCK("BATCH")=$S(ENC("SEL")>50:0,1:1) ;lock batch (all) or as-edited
 S ENNX=0,ENFA=0,ENLOCK=1
 F ENI=1:1 S ENL=$P(ENL("SEL"),",",ENI) Q:'ENL  D
 . S ENCATI=$P(ENL(ENL),U,1)
 . S ENMANI=$P(ENL(ENL),U,3)
 . S ENMOD=$P(ENL(ENL),U,5)
 . S ENDA=0
 . F  S ENDA=$O(^TMP($J,"ENPO",ENCATI,ENMANI,ENMOD,ENDA)) Q:'ENDA!'ENLOCK  D
 . . I ENLOCK("BATCH") L +^ENG(6914,ENDA):10 I '$T S ENLOCK=0 Q
 . . S ^TMP($J,"ENSEL",ENDA)=""
 . . I 'ENNX,$P($G(^ENG(6914,ENDA,0)),U,4)="NX" S ENNX=1
 . . I 'ENFA,+$$CHKFA^ENFAUTL(ENDA) S ENFA=1
 I 'ENLOCK D  G EXIT
 . W $C(7),!,"Some of the selected equipment is currently being edited"
 . W !,"by another process. Please try later."
 K ^TMP($J,"ENFLD")
 ; reserve pseudo entry for edit session
 S ENDAT=0
 F ENI=90000000001:1:90000000100 L +^ENG(6914,ENI):0 I $T S ENDAT=ENI Q
 I 'ENDAT W $C(7),!,"Sorry, unable to reserve space for PM schedule." G EXIT
 K ^ENG(6914,ENDAT)
 S ^ENG(6914,ENDAT,0)=ENDAT
 G FLD^ENEQMED1
EXIT ;
 G EXIT^ENEQMED2
 ;ENEQMED
