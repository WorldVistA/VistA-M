PSGPO ;BIR/CML3-PURGE PATIENT'S ORDERS ; 15 May 98 / 10:42 AM
 ;;5.0; INPATIENT MEDICATIONS ;**3**;16 DEC 97
 D ENCV^PSGSETU Q:$D(XQUIT)  S POD=$O(^PS(55,"AUDDD",0)) I 'POD K POD W !!,"THERE ARE NO ORDERS TO PURGE AT THIS TIME." Q
 S EDATE=4000000 D:$S($D(^PS(53.5,"AB")):1,1:$D(^("AF"))) EDATE I EDATE<4000000 S X1=EDATE\1,X2=-31 D C^%DTC S EDATE=X I POD>EDATE W !!,"THERE ARE PICK LISTS THAT NEED TO BE FILED AWAY THAT MAY CONTAIN THESE ORDERS.",! G DONE
 S PSGOD=$$ENDTC^PSGMI(POD),Y=-1
 F  K %DT S %DT="EPTX" S:EDATE<4000000 %DT(0)=-EDATE R !!,"PURGE ORDERS FOR PATIENTS DISCHARGED BEFORE WHAT DATE: ",X:DTIME W:'$T $C(7) S:'$T X="^" D DTM:X?1."?",^%DT:"^"'[X I Y>0!("^"[X) W:Y'>0 !,"No date chosen for order purge.",! Q
 G:Y'>0 DONE W !!,"This purge will automatically be queued." K %ZIS,IO("Q"),IOP S PSGION=ION,%ZIS="NQ",%ZIS("B")="",%ZIS("A")="Please select a DEVICE for the PURGE REPORT: " D ^%ZIS
 I POP S IOP=PSGION D ^%ZIS W !?3,"No device selected for purge run." G DONE
 S PSGPOD=Y,PSGPOIO=ION K ZTSAVE S ZTDESC="PATIENT ORDER PURGE",PSGTIR="ENQ^PSGPO",(ZTIO,ZTSAVE("PSGPOIO"),ZTSAVE("PSGPOD"))="" D ENTSK^PSGTI W:$D(ZTSK) !,"Purge queued.  (It may take a while to run.)",! G DONE
 ;
ENQ ;
 F  L +^PS(53.43,1,1,0):0 I  S ND=$G(^PS(53.43,1,1,0)) S:ND="" ND="^53.4301A" Q
 F RDA=$P(ND,"^",3)+1:1 W "." I '$D(^PS(53.43,1,1,RDA)) S ^PS(53.43,1,1,RDA,0)=RDA,$P(ND,"^",3)=RDA,$P(ND,"^",4)=$P(ND,"^",4)+1,^PS(53.43,1,1,0)=ND Q
 L -^PS(53.43,1,1,0)
 F PSGPO=0:0 S PSGPO=$O(^PS(55,"AUDDD",PSGPO)) Q:'PSGPO!(PSGPO'<PSGPOD)  F DA(1)=0:0 S DA(1)=$O(^PS(55,"AUDDD",PSGPO,DA(1))) Q:'DA(1)  F DA=0:0 S DA=$O(^PS(55,"AUDDD",PSGPO,DA(1),DA)) Q:'DA  D:"DE"[$P(^PS(55,DA(1),5,DA,0),"^",9) DIK
 K %ZIS,ZTSAVE S H=ZTSK,IOP=PSGPOIO,%ZIS="NQ",PSGJ=RDA,PSGTIR="^PSGPOR",ZTDESC="PATIENT ORDER PURGE REPORT",PSGTID=$H,(ZTSAVE("PSGPOD"),ZTSAVE("PSGJ"))="" D ^%ZIS,ENTSK^PSGTI S ZTSK=H
 ;
DONE ;
 D ENKV^PSGSETU K AM,EDATE,H,POD,PSGJ,PSGPO,PSGPOD,PSGPOIO,ST,TRTN,ZTOUT Q
 ;
DIK ;
 S DIK="^PS(55,"_DA(1)_",5," D ^DIK K ^PS(55,DA(1),5,"B",DA,DA),^PS(55,"AUDDD",PSGPO,DA(1),DA),^PS(55,"AUE",DA(1),DA) S ^(0)=DA(1)_"^"_$S($D(^PS(53.43,1,1,RDA,1,DA(1),0)):$P(^(0),"^",2)+1,1:1) Q
 ;
DTM ;
 W !!,"  If a date is entered here, all orders for patients discharged before the date entered will be purged (deleted) from the computer.  Please note that any orders for any patients admitted after the date entered will NOT be affected."
 W !,"  The earliest discharge date found is ",PSGOD,! Q
 ;
EDATE ;
 F X=0:0 S X=$O(^PS(53.5,"AB",X)) Q:'X  S Y=$O(^(X,0)) I Y,Y<EDATE S EDATE=Y
 F X=0:0 S X=$O(^PS(53.5,"AF",X)) Q:'X  I $D(^PS(53.5,X,0)) S Y=$P(^(0),"^",3) I Y,Y<EDATE S EDATE=Y
 Q
 ;
ENRX ; re-index 55 to be able to purge UD orders (AUDDD x-ref)
 K ^PS(55,"AUDDD") D NOW^%DTC F P=0:0 S P=$O(^PS(55,P)) Q:'P  I $D(^(P,5)) D RX1
 K A Q
 ;
RX1 ;
 F ON=0:0 S ON=$O(^PS(55,P,5,ON)) Q:'ON  S:$P($G(^(+ON,0)),U,20) ^PS(55,"AUDDD",$P(^(0),U,20),P,+ON)=""
 Q
 ;S (D1,DL)=0,X=$O(^DGPM("ATID3",P,"")) I X S X=$O(^(+X,0)) I X S X=$G(^DGPM(X,0)),D2=+X,AD=+$G(^DGPM(+$P(X,U,14),0)) S:'D2 DL=AD I D2>+D1 S D1=D2
 ;S (D1,DL)=0 F Q=0:0 S Q=$O(^DPT(P,"DA",Q)) Q:'Q  S AD=$S($D(^(Q,0)):+^(0),1:0),D2=$S($D(^(1)):+^(1),1:0) S:'D2 DL=AD I D2>+D1 S D1=D2_"^"_Q_"^"_AD
 Q:'D1  D NOW^%DTC S:'DL DL=% F Q=0:0 S Q=$O(^PS(55,P,5,"AUS",Q)) Q:'Q  Q:Q>DL  F QQ=0:0 S QQ=$O(^PS(55,P,5,"AUS",Q,QQ)) Q:'QQ  S $P(^PS(55,P,5,QQ,0),"^",20)=+D1,^PS(55,"AUDDD",+D1,P,QQ)=""
 S:$D(^PS(55,"AUDDD",+D1,P)) ^(P)=$P(D1,"^",2,3) Q
 ;
ENDS ; delete single order
 F  R !!,"DO YOU WANT TO DISCONTINUE THIS ORDER" S %=1 D YN^DICN Q:%  W !!?2,"Answer 'Y' to d/c this order now.  (It will be deleted immediately.)",!,"Answer 'N' (or '^') to not d/c the order."
 I %=1 D
 .;N DA,DIK,PSGPO I $P($G(^PS(55,PSGP,5,+PSGORD,0)),U,21) S X=$O(^ORD(101,"B","PS EVSEND OR",0))_";ORD(101,",PSJORDER=$$ORDER^PSJHLU(PSGORD),PSOC="OD",PSREASON="ORDER DISCONTINUED" D EN1^XQOR:X K X W !?3,"...one moment, please..."
 .N DA,DIK,PSGPO I $P($G(^PS(55,PSGP,5,+PSGORD,0)),U,21) D EN1^PSJHL2(PSGP,"OD",PSGORD,"ORDER DISCONTINUED") W !?3,"...one moment, please..."
 .S PSGCANFL=1,DA(1)=PSGP,DA=+PSGORD,DIK="^PS(55,"_PSGP_",5,",PSGPO=1 D ^DIK W ".DONE!"
 K %,%Y Q
