PSGPLDP0 ;BIR/CML3-ENTER UNITS DISPENSED (PART 2) ;23 OCT 97 / 9:34 AM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
 S PSGPLTND=^PS(53.5,PSGPLG,0),WSF=$P(PSGPLTND,"^",7)
 I $P(PSGPLTND,"^",2),'$P(PSGPLTND,"^",9) S PSGOD=$$ENDTC^PSGMI($P(PSGPLTND,"^",11)) W $C(7),$C(7),!!?33,"*** WARNING ***",!,"THIS PICK LIST STARTED TO RUN ",PSGOD,", BUT HAS NOT RUN TO COMPLETION."
 ;
PRN ;
 F  W !!,"Do you want to see PRN meds only" S %=2 D YN^DICN Q:%  D PRNM^PSGPLDPH
 I %<0 S PRN="^" Q
 S PSGLCNT=0,PRN=%-1,(PC,TM)="" W @IOF
 ;
TM ;
 S OK="" F  S TM=$O(^PS(53.5,"AC",PSGPLG,TM)) Q:TM=""  S WDN="" F  S WDN=$O(^PS(53.5,"AC",PSGPLG,TM,WDN)) Q:WDN=""  D:PRN&'WSF W1 S RB="" F  S (PR,RB)=$O(^PS(53.5,"AC",PSGPLG,TM,WDN,RB)) Q:RB=""  S PN="" D PN G OUT:OK["^^^",TM:OK["^^"
 ;
OUT ;
 W:'PRN&'PC !!?2,"(No PRN meds founds.)" F  W !!,"ARE YOU FINISHED WITH THIS PICK LIST" S %=1 D YN^DICN Q:%  D FMSG^PSGPLDPH
 Q:%<0  G:%'=1 PRN I $P(PSGPLTND,"^",3) D NOW^%DTC I $P(PSGPLTND,"^",3)>% Q
 ;
FILE ;
 F  W !!,"MAY I FILE THE DATA IN THIS PICK LIST AWAY" S %=2 D YN^DICN Q:%  D FIMSG^PSGPLDPH
 I %=1 S DIE="^PS(53.5,",DA=PSGPLG,DR=".05////1" D ^DIE K DIE
 Q
 ;
PN ;
 S OK="" F  D  Q:PN=""  S PSGP=$P(PN,"^",2),WF=0 D:WSF&PRN W1 D:PRN W2 D ST Q:OK["^^"  G:OK="^" PN
 .I ($E(OK,1,1)'="^")&($P(OK,"^",2)'?1.AP) S PN=$O(^PS(53.5,"AC",PSGPLG,TM,WDN,RB,PN)),OK="" Q
 .S DIC="^PS(53.5,"_PSGPLG_",1,",DIC(0)="EQZ",X=$P(OK,"^",2),OK="" D ^DIC K DIC I Y<0 S PN="" Q
 .S Y=$S(WSF:"zns",1:$P(Y(0),"^",3))
 .S RB=$P($G(^PS(53.5,PSGPLG,1,+Y(0),0)),U,4) I RB]"",$P(^PS(53.5,PSGPLG,0),U,6),RB'="zz" S RB=$S($P(RB,"-",2)?1N:0,1:"")_$P(RB,"-",2)_"-"_$P(RB,"-")
 .S RB=$S($P(^PS(53.5,PSGPLG,0),"^",8)=1:"zz",RB="":"zz",1:RB)
 .I '$D(^PS(53.5,"AC",PSGPLG,$P(Y(0),"^",2),Y,RB,$E($P($G(^DPT(+Y(0),0)),U),1,12)_U_+Y(0))) S PN="" K Y Q
 .S PN=$E($P($G(^DPT(+Y(0),0)),U),1,12)_U_+Y(0),TM=$P(Y(0),"^",2),WDN=Y K Y
 ;
NP Q
 ;
ST ;
 S ST="A" F  S ST=$O(^PS(53.5,"AC",PSGPLG,TM,WDN,RB,PN,ST)) Q:"Z"[ST  D DRG Q:OK["^"
 Q
 ;
DRG ;
 S DRG=""
 F  S DRG=$O(^PS(53.5,"AC",PSGPLG,TM,WDN,RB,PN,ST,DRG)) Q:DRG=""  S PSGORD=$P(DRG,"^",2),PSJJORD=+$G(^PS(53.5,PSGPLG,1,PSGP,1,PSGORD,0)),SCH=$P($G(^PS(55,PSGP,5,PSJJORD,2)),"^") I SCH["PRN"!(ST="P")!PRN D GD Q:OK["^"
 Q
 ;
GD ;
 S DDRG="" F  Q:OK["^"  S DDRG=$O(^PS(53.5,"AC",PSGPLG,TM,WDN,RB,PN,ST,DRG,DDRG)) Q:DDRG=""  S DN=+$P(DDRG,"^",2),DN=$G(^PS(53.5,PSGPLG,1,PSGP,1,PSGORD,1,DN,0)),PDD=$P(DN,"^",3),PDN=$P(DN,"^",2) I DN'["DI" D
 .I DN="" W !,$$ENPDN^PSGMI(+$G(^PS(55,PSGP,5,PSJJORD,.2))),?42,"NEEDED: OI",?55,"DISPENSED:" D SCREEN Q
 .S DR=$P($G(^PS(55,PSGP,5,PSJJORD,1,+DN,0)),"^"),DR=$$ENDDN^PSGMI(DR)
 .S LMT=PDN*2+1000 I 'PRN S:'PC PC=1 I 'WF S WF=1,OK="??" D W1
 .I PDN="WS" W !,DR,?42,"NEEDED: ",PDN,?55,"DISPENSED: ",PDN D SCREEN Q
 .S PSGLCNT=0
 .F  W !,DR,?42,"NEEDED: ",PDN,?55,"DISPENSED: ",$S(PDD="":"",1:PDD_"// ") R OK:DTIME W:'$T $C(7) S:'$T OK="^^^" Q:$S(OK=+OK:OK'>LMT,OK?1.3"^":1,($E(OK,1,1)="^")&($P(OK,"^",2)?1.AP):1,1:OK="")  D:OK?1."?" GDMSG I OK'?1."?" W $C(7),"  ??"
 .Q:($E(OK,1,1)="^")&($P(OK,"^",2)?1.AP)
 .I OK="" S OK=$S(PDD]"":PDD,PDN="NV":"",1:PDN) W "  ",OK
 .I OK=+OK,OK'=PDD S $P(^PS(53.5,PSGPLG,1,PSGP,1,PSGORD,1,$P(DDRG,"^",2),0),"^",3)=OK
 Q
 ;
GDMSG ;
 W !!,"  Enter the number of units actually dispensed for this medication.  If the",!,"units dispensed is the same as the units needed (or units dispensed, if shown),",!,"just press the RETURN key."
 W "  Enter an '^' to jump ahead to the next patient,",!,"'^^' to jump ahead to the next team, or '^^^' to exit this pick list.",! Q:OK'?2."?"
 ;
W1 ;
 S PW=$S('WSF:WDN,1:$P(^PS(53.5,PSGPLG,1,PSGP,0),"^",3)),PSGLCNT=PSGLCNT+.5
 W !!,"TEAM: ",$S(TM'["zz":TM,1:"* N/F *"),?40,"WARD: ",$S(WDN'["zz":PW,1:"* N/F *") Q:OK'?2."?"
 ;
W2 ;
 S PSSN=$S($D(^DPT(PSGP,0)):$E($P(^(0),"^",9),6,9),1:"* N/F *"),PPN=$S('$D(^(0)):PN,$P(^(0),"^")]"":$P(^(0),"^"),1:PN),PR=$P(^PS(53.5,PSGPLG,1,PSGP,0),"^",4)
 W !!,?5,$S($P(PSGPLTND,"^",8):"ROOM-BED: ",$P(PSGPLTND,"^",6):"BED-ROOM: ",1:"ROOM-BED: "),$S(PR'["zz":PR,1:"* N/F *"),?30,PPN,"  (",PSSN,")",!
 I '$D(^PS(53.5,PSGPLG,1,PSGP,1)) W !,?20,"(NO ORDERS)",! D SCREEN
 Q
 ;
SCREEN ; display break
 S PSGLCNT=PSGLCNT+1 Q:PSGLCNT<4  S PSGLCNT=0 W !
 K DIR S DIR("A")="Press RETURN to continue",DIR("?")="Enter ^ to go to next patient, ^XXX to go to patient XXX, ^^ to go to next ward, ^^^ to go to next team.",DIR(0)="FOU^^K:(X'="""")!(X'[""^"") X" D ^DIR K DIR S OK=X
 Q
