PSGPLDP ;BIR/CML3-ENTER AND FILE UNITS DISPENSED ;15 JAN 97 / 11:13 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
 D ENCV^PSGSETU Q:$D(XQUIT)  S PSGPLGF="D",PRN=""
CHK ;
 D NOW^%DTC S PSGDT=% F Q=0:0 S Q=$O(^PS(53.5,"AB",Q)) Q:'Q  Q:$O(^(Q,0))
 I 'Q W !,"NO PICK LIST AVAILABLE",$S($D(^PS(53.5,"AB")):", YET.",1:".") G DONE
ASK R !!,"Select WARD GROUP or PICK LIST: ",X:DTIME W:'$T $C(7) S:'$T X="^" G:"^"[X DONE I X=+X D NL I Y D RUN1 G CHK
 ;D:X?1."?" HLP S DIC(0)="EIMQZ",DIC="^PS(57.5,",DIC("S")="I $P($G(^PS(57.5,+Y,0)),""^"",2)=""P"",$D(^PS(53.5,""AB"",+Y)),$O(^(+Y,0))<"_PSGDT D ^DIC K DIC G:Y'>0 ASK S (WG,PSGPLWG)=+Y,PSGPLWGN=Y(0,0) D RUN G CHK
 D:X?1."?" HLP S DIC(0)="EIMQZ",DIC="^PS(57.5,",DIC("S")="I $P($G(^PS(57.5,+Y,0)),""^"",2)=""P"",$D(^PS(53.5,""AB"",+Y))" D ^DIC K DIC G:Y'>0 ASK S (WG,PSGPLWG)=+Y,PSGPLWGN=Y(0,0) D RUN G CHK
 ;
DONE ;
 D:$D(^PS(53.5,"AF")) ENQ D ENKV^PSGSETU K AM,DR,DRG,FA,LMT,OK,PSGLCNT,PSJJORD,PC,PDD,PDN,PN,PND,PPN,PR,PRN,PSGP,PSGPLG,PSGPLGF,PSGPLTND,PSGPLWG,PSGPLWGN,PW,Q,RB,SCH,PSSN,ST,TM,WDN,WF,WSF,WG,X,Y Q
 ;
RUN ; choose pick list and go through it
 D ^PSGPLG Q:"^"[PSGPLG  D RUN1
 Q
 ;
RUN1 ;
 I '$$LOCK^PSGPLUTL(PSGPLG,"PSGPL")  W $C(7),!!,"Another terminal is acccessing this pick list." Q
 I $O(^PS(53.5,PSGPLG,0))="" D AF
 I $O(^PS(53.5,PSGPLG,0))]"" D ^PSGPLDP0
 D UNLOCK^PSGPLUTL(PSGPLG,"PSGPL") Q
 ;
AF ;
 ;*** what are the AO and AB xrefs that follow?
 W !!?3,"*** NO DATA" D NOW^%DTC S Y=+$P(^PS(53.5,PSGPLG,0),"^",3) I $S('Y:1,1:%>Y) S $P(^(0),"^",5)=2,^PS(53.5,"AO",PSGPLWG,Y,PSGPLG)="" K ^PS(53.5,"AB",PSGPLWG,Y,PSGPLG) W " (PICK LIST AUTOMATICALLY FILED AWAY)"
 W " ***" Q
 ;
ENQ ; queue PSGPLF
 D NOW^%DTC S AM=15 F  L +^PS(59.7,1,63.5):0 I  S X=$P($G(^PS(59.7,1,63.5)),"^",4),ST=$S(X>%:X,1:%),X=$$EN^PSGCT(ST,AM) S $P(^PS(59.7,1,63.5),"^",4)=X L -^PS(59.7,1,63.5) Q
 S PSGTID=X,PSGTIR="EN^PSGPLF",ZTDESC="FILE AWAY PICK LIST",ZTIO="" K ZTSAVE D ENNOIO^PSGTI Q
 ;
NL ; numeric look-up
 S Y=$G(^PS(53.5,X,0)) I $S('Y:1,'$P(Y,"^",2):1,1:'$D(^PS(53.5,"AB",$P(Y,"^",2),+$P(Y,"^",3),X))) S Y=0 Q
 S PSGPLG=X,X=^PS(53.5,PSGPLG,0),Y=$$ENDTC^PSGMI($P(X,"^",3)),PSGPLWG=$P(X,"^",2),PSGPLWGN=$S('$D(^PS(57.5,PSGPLWG,0)):PSGPLWG_";PS(57.5,",$P(^(0),"^")]"":$P(^(0),"^"),1:PSGPLWG_";PS(57.5,"),PSGOD=$$ENDTC^PSGMI($P(X,"^",4))
 W "  ",PSGPLWGN,!?$L(PSGPLWG)+21,Y,"  thru  ",PSGOD S Y=1 Q
 ;
HLP ;
 W !?2,"Select a Ward Group for which a pick list has run for which you wish to enter",!,"the units actually dispensed.",!?2,"You may also select a pick list by its number, which prints in the upper left",!,"corner of each pick list." Q
