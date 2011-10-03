PSGOEH0 ;BIR/CML3-TAKE (OR MARK TO BE TAKEN) ORDERS OFF OF HOLD ;30 OCT 97 / 4:06 PM 
 ;;5.0; INPATIENT MEDICATIONS ;**51**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ;
 S PSGND4=$G(^PS(55,PSGP,5,+PSGORD,4)) I 'PSJSYSU,'$P(PSJSYSP0,"^",4) D MARK G DONE
 F  W !!,"Do you wish to take this order 'OFF OF HOLD'" S %=1 D YN^DICN Q:%  D HM
 G DONE:%'=1
 S PSJNOO=$$ENNOO^PSJUTL5("H") S %=$S(PSJNOO<0:0,1:1)
 G HOK:%=1,DONE:'$P(PSGND4,"^",18)!'$P(PSGND4,"^",19)
 F  W !!,"This order has been marked to be taken off of hold.",!,"Do you want to unmark it" S %=2 D YN^DICN Q:%  D UM
 I %=1 K DA S $P(^PS(55,PSGP,5,+PSGORD,4),"^",22,24)="^^",PSGAL("C")=21085+PSJSYSU,DA(1)=PSGP,DA=+PSGORD D ^PSGAL5
 G DONE
 ;
HOK ;
 I $P(PSGND4,"^",26),'$G(PSGORFG) W $C(7),!!,"This order was placed ON HOLD thru OE/RR, and can only be taken OFF HOLD",!,"thru OE/RR.",!! Q
 D NOW^%DTC S PSGDT=% W:'$D(PSJACHLD) "." S $P(PSGND4,"^",22,24)="1^^"_PSGDT,$P(PSGND4,"^",18,20)="^^"
 I $P(PSGND4,"^",26),$G(PSGORFG)>0 S $P(PSGND4,"^",26)=""
 I PSJSYSU,$P(PSGND4,"^",+PSJSYSU=1*2+1),$P(PSGND4,"^",15),'$P(PSGND4,"^",16) S $P(PSGND4,"^",15,17)="^^"
 I $S('$D(PSGOEAV):1,1:'PSGOEAV),PSJSYSU S $P(PSGND4,"^",+PSJSYSU,+PSJSYSU+1)=DUZ_"^"_PSGDT,$P(PSGND4,"^",+PSJSYSU=1+9)=1
 S EXPF=$S($D(^PS(55,PSGP,5,+PSGORD,2)):$P(^(2),"^",4)'>PSGDT,1:1),PSGAL("C")=PSJSYSU*10+8000,PSGALR=40,DIE="^PS(55,"_PSGP_",5,",DA=+PSGORD,DA(1)=PSGP,DR=$S($D(PSGACT):"15;",1:"")_"28////"_$S('EXPF:$P(PSGND4,"^",21),1:"E")
 W:'$D(PSJACHLD) "." D ^PSGAL5 W:'$D(PSJACHLD) "." D ^DIE W:'$D(PSJACHLD) "."
 S PSOC=$S('EXPF:"OE",1:"SC") D EN1^PSJHL2(PSGP,PSOC,PSGORD)
 S ^PS(55,"AUE",PSGP,+PSGORD)="" I PSJSYSL,$S(PSJSYSL<3:1,1:$P(PSGND4,"^",+PSJSYSU'=3+9)) S $P(^PS(55,PSGP,5,+PSGORD,7),"^",1,2)=PSGDT_"^H0",PSGTOL=2,PSGUOW=DUZ,PSGTOO=1 D ENL^PSGVDS
 I '$D(PSJACHLD) S PSGCANFL=-1
 ;
DONE ;
 S:PSGND4]"" ^PS(55,PSGP,5,+PSGORD,4)=PSGND4
 I $D(PSJLMPRO) K DIR S DIR(0)="E" D ^DIR
 K DA,DIE,DP,DR,EXPF,H,ND,PSGAL,PSGALR,PSGND4,PSGTOL,PSGTOO,PSGUOW Q
 ;
MARK ;
 I $P(PSGND4,"^",22),$P(PSGND4,"^",23) W $C(7),!!,"THIS ORDER HAS ALREADY BEEN UNMARKED." Q
 K DA S $P(PSGND4,"^",22,24)="1^"_DUZ_"^"_PSGDT,PSGAL("C")=13085,DA(1)=PSGP,DA=+PSGORD D ^PSGAL5 Q
 ;
HM ;
 W !!?2,"Answer 'YES' to take this order off of hold.  Answer 'NO' (or '^') if you do",!,"not wish to take this order off of hold." Q
 ;
UM ;
 I H'?1."?" W $C(7),"  ??" Q
 W !!,"Enter a 'Y' to unmark this order.  Enter an 'N' (or '^') to leave it as is." Q
 ;
ENOR ;
 S ND=$G(^PS(55,PSGP,5,+PSGORD,0)),PSGND4=$G(^(4)) I 'PSJSYSU D MARK G DONE
 G HOK
