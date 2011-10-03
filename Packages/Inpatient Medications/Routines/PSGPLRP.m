PSGPLRP ;BIR/CML3-PICK LIST REPRINT DRIVER ;18 APR 95 / 4:20 PM
 ;;5.0; INPATIENT MEDICATIONS ;**50**;16 DEC 97
 ;
 D ENCV^PSGSETU I $D(XQUIT) Q
 ;
START ;
 R !!,"Select WARD GROUP or PICK LIST: ",X:DTIME W:'$T $C(7) S:'$T X="^" G:"^"[X DONE
 I X=+X,$D(^PS(53.5,X,0)) S PSGPLG=X I '$D(^PS(53.5,"AF",PSGPLG)) S Y=^PS(53.5,X,0),PSGPLWG=+$P(Y,U,2),PSGPLWGP=$G(^PS(57.5,PSGPLWG,5)),PSGID=$P(Y,"^",3)
 I  S PSGOD=$P(Y,"^",4),Y=$S('$D(^PS(57.5,PSGPLWG,0)):PSGPLWG_";PS(57.5",$P(^(0),"^")]"":$P(^(0),"^"),1:PSGPLWG_";PS(57.5") W "  ",Y,!?$L(PSGPLG)+21,$$ENDTC^PSGMI(PSGID),"  thru  ",$$ENDTC^PSGMI(PSGOD) D RP1 G START
 D:X?1."?" HLP K DIC S DIC="^PS(57.5,",DIC(0)="EIMQ",DIC("S")="I $D(^PS(57.5,+Y,0)),$P(^(0),""^"",2)=""P"",$D(^PS(53.5,""AB"",+Y))!$D(^PS(53.5,""AO"",+Y))" D ^DIC K DIC G:+Y'>0 START
 S PSGPLWG=+Y,PSGPLWGP=$G(^PS(57.5,PSGPLWG,5)) D NOW^%DTC S PSGDT=%,PSGPLGF="P",PSGPLG="" F  D ^PSGPLG Q:"^"[PSGPLG  D RP1
 G START
 ;
DONE ;
 D ENKV^PSGSETU K PSGPLGF,PSGPLG,PSGPLWG,PSGPLWGP,PSGPLUPF,PN,RB,WDN,TM,Y,PSGPLSTR Q
 ;
RP1 ;
 K PSGPLUPF S %=2 I $D(^PS(53.5,"AU",PSGPLG)) D PW Q:%<1
 D PAT Q:$D(DUOUT)
 I %=2,$D(^PS(53.5,PSGPLG,0)) I '$P(^(0),"^",9) W $C(7),$C(7),!!?33,"*** WARNING ***",!,"THIS PICK LIST STARTED TO RUN ",$$ENDTC^PSGMI($P(^(0),"^",11)),", BUT HAS NOT RUN TO COMPLETION."
 K ZTSAVE S ZTDESC="UNIT DOSE PICK LIST REPRINT",PSGTIR="^PSGPLR",(ZTSAVE("PSGPLG"),ZTSAVE("PSGPLWG"),ZTSAVE("PSGPLWGP"),ZTSAVE("PSGPLSTR"))="" S:$D(PSGPLUPF) ZTSAVE("PSGPLUPF")="" S:$D(PSJPRN) ZTSAVE("PSJPRN")=""
 D ENDEV^PSGTI I POP W !,"No device selected.  Option terminated." Q
 I $D(IO("Q")) W:$D(ZTSK) !,"Pick list print queued!" Q
 W !!," ...one moment, please..." D ^PSGPLR D ^%ZISC Q
 ;
HLP ;
 W !?2,"Select a Ward Group for which a pick list has run for which you wish to",!,"reprint.",!?2,"You may also select a Pick List by number, which prints in the upper left",!,"corner of each pick list." Q
 ;
PW ; print which? pick list or update
 F  W !!,"This pick list has an update.",!,"Do you want to print the update" S %=2 D YN^DICN Q:%  W !!?2,"An update has been run for this pick list.  Enter 'YES' to print the update",!,"only.  Enter 'NO' to print the complete pick list."
 S:%=1 PSGPLUPF=1 Q
 ;
PAT ; select patient to start from
 I $G(PSGPLUPF)=1 S DIC("S")="I $P(^(0),U,5)=1"
 S PSGPLSTR="",DIC="^PS(53.5,"_PSGPLG_",1,",DIC("A")="Select PATIENT to start from (optional): ",DIC(0)="AEQZ" D ^DIC K DIC Q:Y<0
 S WDN=$S($P(^PS(53.5,PSGPLG,0),"^",7)=1:"zns",1:$P(Y(0),"^",3)),TM=$P(Y(0),"^",2)
 S RB=$P($G(^PS(53.5,PSGPLG,1,+Y(0),0)),U,4) I RB]"",$P(^PS(53.5,PSGPLG,0),U,6),RB'="zz" S RB=$S($P(RB,"-",2)?1N:0,1:"")_$P(RB,"-",2)_"-"_$P(RB,"-")
 S RB=$S($P(^PS(53.5,PSGPLG,0),"^",8)=1:"zz",RB="":"zz",1:RB)
 S PN=$E($P($G(^DPT(+Y(0),0)),U),1,12)_U_+Y(0)
 Q:'$D(^PS(53.5,"AC",PSGPLG,TM,WDN,RB,PN))
 S PSGPLSTR=TM_"^"_WDN_"^"_RB_"^"_PN
 Q
