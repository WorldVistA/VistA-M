ENLBL7 ;(WASH ISC)/DH-Physical Print of Bar Code Label ;10.10.97
 ;;7.0;ENGINEERING;**12,35,45**;Aug 17, 1993
NXPRT ;Generation of NX barcode labels (equipment)
 I ENBAR("EQUIPMENT DATA")]"" X ENBAR("EQUIPMENT DATA") Q
NXPRT1 Q:'$D(^ENG(6914,DA,0))  S ENEQBC=ENEQSTA_" EE"_DA
 S ENLBLHD="*  EQUIPMENT  LABEL  *"
 I $D(^DIC(6910,1,0)),$P(^(0),U,8),$D(^ENG(6914,DA,1)),$P(^(1),U)]"" S ENA=$P(^(1),U) S:$D(^ENG(6911,ENA,0)) ENLBLHD=$E($P(^(0),U),1,20)
 S ENLBLBOT=ENEQSTAN D:$O(^DIC(6910,1,1,0))]"" ENLBLBOT
PRT ;Physical print
 W *2,*27,"E3",!,*24,ENLBLHD,!,ENEQBC,!,ENLBLBOT
 W *23,*3
 Q
FORMAT ;Equipment labels
 G:'$D(ENEQBY) FORMAT1
 K ENBAR S (ENBAR("EQUIPMENT FORMAT"),ENBAR("EQUIPMENT DATA"))=""
 S ENBCIOS(0)=$O(^DIC(6910.1,"B",ENBCIOS,0)) D:ENBCIOS(0)
 . S ENBAR("EQUIPMENT FORMAT")=$G(^DIC(6910.1,ENBCIOS(0),1))
 . S ENBAR("EQUIPMENT DATA")=$G(^DIC(6910.1,ENBCIOS(0),3))
 I ENBAR("EQUIPMENT FORMAT")]"" X ENBAR("EQUIPMENT FORMAT") Q
FORMAT1 ;Entry point for location labels
 I $D(ENEQBY),$O(^DIC(6910,1,1,0))]"" S ENEQLM=280
 W *2,*27,"P",*3
 W *2,"E3;F3;"
 W "H0;o0,280;f1;c2;d0,23;h1;w1;"
 W "B1;o23,280;f1;c0,0;h25;w1;i2;d0,20;p@;"
 W "H2;o62,",ENEQLM,";f1;c0;d0,40;h1;w1;"
 W *3
 W *2,"R",*3
 Q
BCDT ;Record print of Equip Label
 I $D(^ENG("VERSION")),^ENG("VERSION")>6.4 S DIE="^ENG(6914,",DR="28///T" D ^DIE
 Q
ENLBLBOT ;Locally specified fields (human readable)
 ; in  DA       = equipment ien
 ;     ENLBLBOT = text for bottom line (changed)
 N ENC,ENI,ENX
 S (ENC,ENI)=0
 F  S ENI=$O(^DIC(6910,1,1,ENI)) Q:'ENI  D  Q:ENC=2
 . S ENX=$G(^DIC(6910,1,1,ENI,0))
 . Q:'$P(ENX,U)
 . Q:$$GET1^DID(6914,$P(ENX,U),"","MULTIPLE-VALUED")
 . S ENC=ENC+1
 . S ENLBLBOT=$S(ENC=1:"",1:ENLBLBOT_"  ") ; init when 1st, else append
 . S ENLBLBOT=ENLBLBOT_$P(ENX,U,2)_" "_$$GET1^DIQ(6914,DA,$P(ENX,U))
 I $L(ENLBLBOT)>35 S ENLBLBOT=$E(ENLBLBOT,1,34)_"*" ; won't fit on label
 Q
 ;ENLBL7
