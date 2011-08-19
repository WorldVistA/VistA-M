PSGOEH1 ;BIR/CML3-PLACE (OR MARK TO BE PLACED) ORDERS ON HOLD ;30 OCT 97 / 4:03 PM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
 S ND=$G(^PS(55,PSGP,5,+PSGORD,0)),PSGND4=$G(^(4)) I 'PSJSYSU,'$P(PSJSYSP0,"^",4) D MARK G DONE
 F  W !!,"Do you wish to place this order 'ON HOLD'" S %=1 D YN^DICN Q:%  D HM
 G DONE:%'=1
 S PSJNOO=$$ENNOO^PSJUTL5("H") S %=$S(PSJNOO<0:0,1:1)
 G HOK:%=1,DONE:'$P(PSGND4,"^",18)!'$P(PSGND4,"^",19) F  W !!,"This order has been marked for hold.  Do you want to unmark it" S %=2 D YN^DICN Q:%  D UM
 I %=1 K DA S $P(PSGND4,"^",18,20)="^^",PSGAL("C")=21081+PSJSYSU,DA(1)=PSGP,DA=+PSGORD D ^PSGAL5
 G DONE
 ;
HOK ;
 D NOW^%DTC S PSGDT=% W:'$D(PSJACHLD) "." S $P(PSGND4,"^",18,20)="1^^"_PSGDT,$P(PSGND4,"^",22,24)="^^",$P(PSGND4,"^",21)=$S($P(ND,"^",9)]"":$P(ND,"^",9),1:"A")
 I PSJSYSU,$P(PSGND4,"^",+PSJSYSU=1*2+1),$P(PSGND4,"^",15),'$P(PSGND4,"^",16) S $P(PSGND4,"^",15,17)="^^"
 S PSGAL("C")=PSJSYSU*10+8500,PSGALR=41,DIE="^PS(55,"_PSGP_",5,",DA=+PSGORD,DA(1)=PSGP,DR=$S($D(PSGACT):"15;",1:"")_"28////H"
 W:'$D(PSJACHLD) "." D ^PSGAL5 W:'$D(PSJACHLD) "." D ^DIE W:'$D(PSJACHLD) "."
 S PSOC=$S('$G(EXPF):"OH",1:"SC") D EN1^PSJHL2(PSGP,PSOC,PSGORD)
 S ^PS(55,"AUE",PSGP,+PSGORD)="" I PSJSYSL,$S(PSJSYSL<3:1,1:$P(PSGND4,"^",+PSJSYSU'=3+9)) S $P(^PS(55,PSGP,5,+PSGORD,7),"^",1,2)=PSGDT_"^H1",PSGTOL=2,PSGUOW=DUZ,PSGTOO=1 D ENL^PSGVDS
 I $D(PSJSYSO) S PSGORD=+PSGORD_"A",PSGPOSA="H",PSGPOSD=PSGDT D ENPOS^PSGVDS
 I '$D(PSJACHLD) S PSGCANFL=-1
 ;
DONE ;
 S:PSGND4]"" ^PS(55,PSGP,5,+PSGORD,4)=PSGND4
 I $G(PSJLMPRO) K DIR S DIR(0)="E" D ^DIR
 K DA,DIE,DIR,DP,DR,H,PSGAL,PSGALR,PSGND4,PSGPOSA,PSGPOSD,PSGTOL,PSGTOO,PSGUOW Q
 ;
MARK ;
 I $P(PSGND4,"^",18),$P(PSGND4,"^",19) W $C(7),!!,"THIS ORDER HAS ALREADY BEEN MARKED." Q
 K DA S $P(PSGND4,"^",18,20)="1^"_DUZ_"^"_PSGDT,PSGAL("C")=13081,DA(1)=PSGP,DA=+PSGORD D ^PSGAL5
 W !,"ORDER MARKED TO BE PLACED ON HOLD."
 Q
 ;
HM ;
 W !!,"Enter a 'Y' to place this order on hold.  Enter an 'N' (or '^') if you do not   wish to place this order on hold." Q
 ;
UM ;
 I H'?1."?" W $C(7),"  ??" Q
 W !!,"Enter a 'Y' to unmark this order.  Enter an 'N' (or '^') to leave it as is." Q
