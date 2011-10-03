ENEQTD ;WIRMFO/SAB-TURN-IN/DISPOSITION EQUIPMENT RECORDS ;2.12.97
 ;;7.0;ENGINEERING;**35**;Aug 17, 1993
TD ; turn-in/disposition non-capitalized equipment record
 K ENDL S $P(ENDL,"-",80)=""
 ;
TDEQ ; select equipment
 W ! D GETEQ^ENUTL G:Y'>0 TDEXIT S ENDA=+Y
 ;
 I +$$CHKFA^ENFAUTL(ENDA) D  G TDEQ
 . W $C(7),!,"Can't proceed. Item is currently reported to FAP."
 . W !,"Use the Disposition an Asset (FD Document) option."
 ;
 I $P($G(^ENG(6914,ENDA,0)),U,4)="NX",'$D(^XUSEC("ENEDNX",DUZ)) D  G TDEQ
 . W $C(7),!,"Security Key ENEDNX is required to edit NX equipment."
 ;
 F ENI=0,1 S ENY(ENI)=$G(^ENG(6914,ENDA,ENI))
 W !,ENDL
 W !,"Entry #: ",ENDA,?21,"Mfg. Name: ",$E($P(ENY(0),U,2),1,40)
 W !,"Mfg: ",$$GET1^DIQ(6914,ENDA,1)
 W !,"Mod: ",$P(ENY(1),U,2),?40,"Ser #: ",$P(ENY(1),U,3)
 W !,"Cat: ",$$GET1^DIQ(6914,ENDA,6)
 W ?57,"Acq Date: ",$$GET1^DIQ(6914,ENDA,13)
 W !,ENDL
 ;
 S DIR(0)="SA^T:TURN-IN;D:FINAL DISPOSITION"
 S DIR("A")="Select TURN-IN or FINAL DISPOSITION (enter '^' to quit): "
 D ^DIR K DIR G:$D(DIRUT) TDEXIT
 S ENTASK=Y
 ; check for unprocessed components, if any found give option to stop
 I $O(^ENG(6914,"AE",ENDA,0)) D  G:ENTASK="" TDEQ
 . N ENCY,ENX
 . W !!,"  This is the parent system for some equipment items."
 . W !,"  Components without "_$S(ENTASK="T":"either a turn-in or ",1:"")_"disposition date are shown below:"
 . S ENI=0,ENX="" F  S ENI=$O(^ENG(6914,"AE",ENDA,ENI)) Q:'ENI  D
 . . S ENCY(3)=$G(^ENG(6914,ENI,3))
 . . I ENTASK="D",$P(ENCY(3),U,11)]"" Q
 . . I ENTASK="T",$P(ENCY(3),U,11)]""!($P(ENCY(3),U,3)]"") Q
 . . I $L(ENX)+$L(ENI)>70 W !,?4,ENX_"," S ENX=ENI
 . . E  S ENX=ENX_$S(ENX]"":", ",1:"")_ENI
 . I ENX']"" W !,?4,"None found" Q
 . W !,?4,ENX,! D
 . . S DIR("0")="Y",DIR("B")="NO"
 . . S DIR("A")="Continue with "_$S(ENTASK="T":"Turn-In",1:"Final Disposition")_" of Parent System"
 . . D ^DIR K DIR S:'Y ENTASK=""
 ;
TDEDIT ; edit equipment
 W !!,"Note: Some data fields are automatically modified."
 S ENCONTR=$P($G(^ENG(6914,ENDA,7)),U)
 S DIE="^ENG(6914,",DA=ENDA
 S:ENTASK="T" DR=$S($D(^DIE("B","ENZEQTURN")):"[ENZ",1:"[EN")_"EQTURN]"
 S:ENTASK="D" DR=$S($D(^DIE("B","ENZEQDISP")):"[ENZ",1:"[EN")_"EQDISP]"
 D ^DIE
 ;
 W !!,"Checking for inconsistencies..."
 S ENOK=1 F ENI=2,3 S ENY(ENI)=$G(^ENG(6914,ENDA,ENI))
 I ENTASK="D","^10^23^70^"[(U_$E($$GET1^DIQ(6914,ENDA,18),1,2)_U),$P(ENY(3),U,11)="",$P(ENY(2),U,9)="" D
 . W !,"  Accountable NX has both DISPOSITION DATE and CMR blank."
 . S ENOK=0
 I $P(ENY(3),U)>3,$P(ENY(3),U)<6,$P(ENY(3),U,3)="",$P(ENY(3),U,11)="" D
 . W !,"  Either TURN-IN DATE or DISPOSITION DATE should be entered"
 . W !,"    when USE STATUS = ",$$EXTERNAL^DILFD(6914,20,"",$P(ENY(3),U))
 I 'ENOK D  G:$D(DIRUT) TDEXIT G:Y TDEDIT
 . S DIR(0)="Y",DIR("A")="Do you want to re-edit the equipment item"
 . S DIR("B")="YES"
 . W ! D ^DIR K DIR
 I ENOK W "OK"
 G TDEQ
TDEXIT ;
 K DA,DIC,DIE,DIROUT,DIRUT,DR,DTOUT,DUOUT,X,Y
 K ENCONTR,ENDA,ENDL,ENI,ENOK,ENTASK,ENY
 Q
 ;ENEQTD
