ENY2KR ;(WASH ISC)/DH-Individual Y2K Close Out ;6.16.98
 ;;7.0;ENGINEERING;**51**;Aug 17, 1993
CO ;  close out Y2K worklist
 N DATE,COST,DIC,DIE,DA,DR,WODA,EQDA,ENX,ENY,ENY2K
 W @IOF,!,"Closing a Y2K work order normally places the affected piece of equipment in",!,"a Y2K CATEGORY of 'FULLY COMPLIANT' and updates both the Work Order and"
 W !,"Equipment files."
 W !!,"In exceptional cases, this option may also be used to remove an item from",!,"the conditionally compliant list without actually closing its Y2K work"
 W !,"order. If you enter a Y2K CATEGORY of 'NA' rather than 'FC' the system will",!,"automatically delete the Y2K work order. If you enter 'NC' the system will"
 W !,"delete the work order and prompt you for Y2K ACTION."
 W !!
 ;
CO1 ;  get first Y2K work order
 K ENX R !,"Please enter first Y2K work order to be closed: ",ENX:DTIME I ENX=""!(ENX="^")!('$T) G EXIT
 D GETWO G:Y'>0 CO1
 S (DA,WODA)=+Y,ENY2WO=$P(^ENG(6920,DA,0),U)
 S EQDA=$P($G(^ENG(6920,DA,3)),U,8) I EQDA="" W !," This work order lacks an equipment pointer and is being deleted." D DEL G CO1
 I '$D(^ENG(6914,EQDA,0)) W !," There is no equipment record for this work order. The work order",!,"is being deleted." D DEL G CO1
 L +^ENG(6920,DA):1 I '$T W !,"Work order being edited by another user. Please try again later." G CO1
 D CLSWO G:$D(DIRUT)!($D(DTOUT)) EXIT
 ;
CO2 S ENY2WO(1)=$O(^ENG(6920,"B",ENY2WO)) G:$E(ENY2WO(1),1,3)'="Y2-" EXIT I $P($G(^ENG(6920,ENY2WO(1),5)),U,2)]"" S ENY2WO=ENY2WO(1) G CO2
 ;
CO3 K ENX W !!,"Next Y2K work order (or sequential portion), '^' to quit: "_ENY2WO(1)_"// " R ENX:DTIME I $E(ENX)="^"!('$T) G EXIT
 I ENX?1.N S:$L(ENX)<3 X=$S($L(ENX)=1:"00"_ENX,1:"0"_ENX) S ENX=$P(ENY2WO,"-",1,2)_"-"_ENX W !,?10,"  ("_ENX_")"
 I ENX="" S ENX=ENY2WO(1)
 D GETWO G:Y'>0 CO3
 S (DA,WODA)=+Y,ENY2WO=$P(^ENG(6920,DA,0),U)
 S EQDA=$P($G(^ENG(6920,DA,3)),U,8) I EQDA="" W !," This work order lacks an equipment pointer and is being deleted." D DEL G CO2
 I '$D(^ENG(6914,EQDA,0)) W !," There is no equipment record for this work order. The work order",!,"is being deleted." D DEL G CO2
 L +^ENG(6920,DA):1 I '$T W !,"Another user is editing this work order. Please try again later." G CO2
 D CLSWO G:$D(DIRUT)!($D(DTOUT)) EXIT
 G CO2
 ;
EXIT K ENSHABR,ENSHOP,EN1,ENLOC,ENY2WO
 Q
 ;
HOLD I $E(IOST,1,2)="C-" R !,"<cr> to continue, '^' to quit...",X:DTIME
 S ENY=1
 Q
 ;
GETWO ;  get a Y2K work order
 ;    expects ENX and returns Y (from ^DIC)
 S DIC="^ENG(6920,",DIC("S")="I $P(^(0),U)[""Y2-"",$P($G(^(5)),U,2)="""""
 I $E(ENX,2)="." D  I D]"" S X=$E(ENX,3,99),DIC(0)="QE" D IX^DIC Q
 . S D=""
 . I $E(ENX)="E" S D="G" Q  ;  equipment
 . I $E(ENX)="L" S D="C" Q  ;  location
 I $E(ENX)="?" D
 . W !," You may use 'E.value' to list W.O.s whose EQUIPMENT ID# equals 'value', or"
 . W !," 'L.value' to list W.O.s whose LOCATION starts with 'value'."
 S X=ENX,DIC(0)="QEM" D ^DIC
 Q
 ;
CLSWO ;  disposition the Y2K work order
 W !,"EQUIPMENT ID: "_EQDA_"    "_$S($P(^ENG(6914,EQDA,0),U,2)]"":$E($P(^(0),U,2),1,20),1:$E($$GET1^DIQ(6914,EQDA,6),1,20))_"  "_$E($$GET1^DIQ(6914,EQDA,1),1,20)_"  "_$E($$GET1^DIQ(6914,EQDA,4),1,15)
 K DIR S DIR(0)="6914,71",DIR("B")="FULLY COMPLIANT"
 D ^DIR K DIR Q:$D(DIRUT)
 S ENY2K("CAT")=Y I ENY2K("CAT")="CC" W !!,"Data base unchanged." Q
 I ENY2K("CAT")'="FC" D  Q
 . D DEL
 . S DIE="^ENG(6914,",DA=EQDA,DR="71///^S X=ENY2K(""CAT"");72///^S X=""@"";72.1///^S X=""@"";73///^S X=""@"";74///^S X=""@"";75///^S X=""@"";77///^S X=""@""" D ^DIE
 . I ENY2K("CAT")="NC" S DR=76 D ^DIE
 S DR=$S($D(^DIE("B","ENZY2CLOSE")):"[ENZY2CLOSE]",1:"[ENY2CLOSE]")
 S DIE="^ENG(6920," D ^DIE I $D(Y) L -^ENG(6920,DA) Q
 I $P($G(^ENG(6920,DA,5)),U,2)]"",$E(^ENG(6920,DA,0),1,3)="Y2-" D  S DA=WODA
 . S DATE=$P(^ENG(6920,DA,5),U,2),COST=$P(^(5),U,6)+$P(^(5),U,4)+$P($G(^(4)),U,4)
 . S DA=EQDA,DIE="^ENG(6914,",DR="71///^S X=""FC"";72.1///^S X=DATE;74///^S X=COST" D ^DIE
 L -^ENG(6920,DA)
 Q
 ;
DEL ;  delete work orders without valid equipment pointers and work orders
 ;  which should not be closed ('NC' and 'NA')
 I $G(EQDA),$D(^ENG(6914,EQDA,0)) S $P(^ENG(6914,EQDA,11),U,8)=""
 S DIK="^ENG(6920," D ^DIK K DIK
 Q
 ;ENY2KR
