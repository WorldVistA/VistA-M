ENEQPMR5 ;(WASH ISC)/DH-Single PMI's ;2.26.98
 ;;7.0;ENGINEERING;**14,35,48**;Aug 17, 1993
SDPM4 I ENDEL'="N" D  Q:DA'>0  G SDPM41 ;pm work order not to be retained
 . K DD,DO S DIC="^ENG(6920,",DIC(0)="LX",X=ENPMWO
 . D FILE^DICN S DA=+Y
 ;  retain pm work order
 F I=1:1 S J=$S($L(I)=1:"00"_I,$L(I)=2:"0"_I,1:I),ENPMWO(0)=ENPMWO_"-"_J I '$D(^ENG(6920,"B",ENPMWO(0))),'$D(^ENG(6920,"H",ENPMWO(0))) Q
 L +^ENG(6920,"B")
 F  Q:'$D(^ENG(6920,"B",ENPMWO(0)))  S J=$P(ENPMWO(0),"-",3)+1,J=$S($L(J)=1:"00"_J,$L(J)=2:"0"_J,1:J),ENPMWO(0)=$P(ENPMWO(0),"-",1,2)_"-"_J
 K DD,DO S DIC="^ENG(6920,",DIC(0)="LX",X=ENPMWO(0) D FILE^DICN S DA=+Y
 L -^ENG(6920,"B") Q:DA'>0
 ;
SDPM41 S DIE="^ENG(6920,",DR=".05///^S X=$S($D(ENPMWO(0)):ENPMWO(0),1:ENPMWO);1///^S X=DT;9///^S X=ENSHKEY;10///^S X=DT;18///^S X=ENDA;39///^S X=""OFF-SCHEDULE PMI""" D ^DIE
 S ^ENG(6920,DA,8,0)="^6920.035^1^1",DIE="^ENG(6920,DA(1),8,",(ENOLDDA,DA(1))=DA,DA=1,DR=".01///^S X=""PREVENTIVE MAINTENANCE""" D ^DIE K DA,DR S DIE="^ENG(6920,",DA=ENOLDDA K ENOLDDA
 ;
SDPM42 S DR=$S($D(^DIE("B","ENZPMCLOSE")):"[ENZPMCLOSE]",1:"[ENPMCLOSE]") D ^DIE Q:'$D(DA)  ;pm work order deleted within ^DIE
 ;
SDPM43 I $P($G(^ENG(6920,DA,5)),U,2)="" D  G:%=1 SDPM42 G:%'=2 SDPM43
 . W !,*7,"You need to enter a DATE COMPLETE in order to post this PM work order. My",!,"guess is that you should re-edit to either enter a DATE COMPLETE or to delete"
 . W !,"the work order ('@' in response to first prompt).",!,"Am I right" S %=1 D YN^DICN
 ;
SDPM44 I $P($G(^ENG(6920,DA,5)),U,2)]"",$E(^ENG(6920,DA,0),1,3)="PM-" D
 . D PMHRS^ENEQPMR4,PMINV^ENEQPMR4 S ENCLOSE=$P(^ENG(6920,DA,5),U,2)
 . I ENDEL="Y" S DIK="^ENG(6920," D ^DIK K DIK
 Q:'$G(ENCLOSE)!(ENPM'="M")  ;return control to ENEQPMR4
 ;
SDPM5 ;  should user change the STARTING MONTH (or maybe YEAR)
 Q:'$D(ENDA)  ;nothing to look at
 S ENRS=$O(^ENG(6914,ENDA,4,"B",ENSHKEY,0))
 Q:'ENRS  ;shop doesn't normally do pm
 K ENA S I=0 F  S I=$O(^ENG(6914,ENDA,4,ENRS,2,I)) Q:'I  S ENA($P(^(I,0),U))=$P(^(0),U,6) ;build frequency array
 Q:$D(ENA("M"))  ;no need to change STARTING MONTH if MONTHLY on file
 F I="TA","BA" I $D(ENA(I)),ENA(I)="" K ENA(I)
 S ENPMYR("C")=ENPMYR,ENSTMN=$S($D(^ENG(6914,ENDA,4,ENRS,1)):^(1),1:1),I=0 S:ENSTMN="" ENSTMN=1
SDPM51 K ENHZ S ENNXMN=1+(ENPMMN#12) S:ENPMMN=12 ENPMYR("C")=ENPMYR("C")+1
 F  D  Q:$G(ENHZ(0))!((ENNXMN=ENPMMN)&('$D(ENA("TA")))&('$D(ENA("BA"))))  Q:ENPMYR("C")>(ENPMYR+4)
 . I $D(ENA("TA")),'((ENPMYR("C")-ENA("TA"))#3),ENNXMN=ENSTMN S ENHZ(0)=1,ENHZ="TRI-ANNUAL" Q
 . I $D(ENA("BA")),'((ENPMYR("C")-ENA("BA"))#2),ENNXMN=ENSTMN S ENHZ(0)=1,ENHZ="BI-ANNUAL" Q
 . I $D(ENA("A")),ENNXMN=ENSTMN S ENHZ(0)=1,ENHZ="ANNUAL" Q
 . I $D(ENA("S")),'((ENNXMN-ENSTMN)#6) S ENHZ(0)=1,ENNXMN(0)=$S(ENPMMN>ENNXMN:ENNXMN+12,1:ENNXMN) I (ENNXMN(0)-ENPMMN)<6 S ENHZ="SEMI-ANNUAL" Q
 . I $D(ENA("Q")),'((ENNXMN-ENSTMN)#3) S ENHZ(0)=1,ENNXMN(0)=$S(ENPMMN>ENNXMN:ENNXMN+12,1:ENNXMN) I (ENNXMN(0)-ENPMMN)<3 S ENHZ="QUARTERLY" Q
 . I $D(ENA("BM")),'((ENNXMN-ENSTMN)#2) S ENHZ(0)=1,ENNXMN(0)=$S(ENPMMN>ENNXMN:ENNXMN+12,1:ENNXMN) I (ENNXMN(0)-ENPMMN)<2 S ENHZ="BI-MONTHLY" Q
 . S ENNXMN=1+(ENNXMN#12) S:ENNXMN=1 ENPMYR("C")=ENPMYR("C")+1
 ;
 Q:$G(ENHZ)=""  Q:(ENHZ="ANNUAL"&(ENNXMN=ENPMMN))  ;  return to ENEQPMR4, STARTING DATE is probably OK
 I $D(^ENG(6914,ENDA,6)) D  Q:ENHZ="DONE"  ;strange result (exception)
 . ;  check for posting of a future PM (will set ENHZ)
 . S:$L(ENNXMN)=1 ENNXMN="0"_ENNXMN S ENPMWO("P")="PM-"_ENSHABR_$E(ENPMYR("C")-1700,2,3)_ENNXMN_"M"
 . S I=0 F  S I=$O(^ENG(6914,ENDA,6,I)) Q:'I!(ENHZ="DONE")  I $P(^(I,0),U,2)[ENPMWO("P") S ENHZ="DONE"
 ;
 S ENPMN=$P($G(^ENG(6914,ENDA,3)),U,6)
 W !!,"Equipment entry # "_ENDA W:ENPMN]"" " (PM# ",ENPMN,") " W " is in the scheduled PMI program of the",!,ENSHOP_" shop."
 W !,"The next scheduled event is a" W:ENHZ="ANNUAL" "n" W " "_ENHZ_" PMI in ",$P("Jan^Feb^Mar^Apr^May^Jun^Jul^Aug^Sep^Oct^Nov^Dec","^",ENNXMN),", "_ENPMYR("C")_"."
SDPM71 W !!,"Would you like to change the PM schedule (at least the STARTING MONTH)",!,"for this device at this time"
 S %=2 D YN^DICN I %=1 S DIE="^ENG(6914,",DA=ENDA,ENXP=1,ENOLSHOP=ENSHOP D XNPMSE^ENEQPMP S ENSHOP=ENOLSHOP K ENOLSHOP Q  ;  return to ENEQPMR4
 I %=0 W !,"You may wish to change the STARTING MONTH so that you don't perform",!,"one PMI on the heels of another. It's your call." G SDPM71
 ;
 Q  ;  return to ENEQPMR4
 ;ENEQPMR5
