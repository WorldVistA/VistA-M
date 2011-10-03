ENY2VACO ;;(WIRMFO)/DH-Y2K Activity Report ;10.9.98
 ;;7.0;ENGINEERING;**55,58**;August 17, 1993
EN ;  national roll-up of Y2K information
 ;  may be selected manually or scheduled to run automatically
 ;    at a user specified frequency
 N %DT
 W @IOF,!,?20,"NATIONAL ROLL-UP OF Y2K INFORMATION"
 I $P($G(^DIC(6910,1,0)),U,2)']"" W !!,"There is no STATION NUMBER in your Engineering Init Parameters file.",!,"Can't proceed.",*7 D HOLD Q
 I '$D(^XUSEC("ENY2K_ROLL_UP",DUZ)) W !!,"You must hold security key ENY2K_ROLL_UP in order to execute this option.",*7 D HOLD Q
 ;
ACT1 W !!,"Please enter starting and stopping dates for activity reporting",!," (or '^' to escape...)",!
 S %DT="AEP",%DT("A")="Starting date: ",%DT(0)=-DT
 S Y=$E(DT,1,5)-1 S:$E(Y,4,5)="00" Y=($E(Y,1,3)-1)_12 S Y=Y_"01"
 X ^DD("DD") S %DT("B")=Y
 D ^%DT Q:Y'>0
 S Y=$P(Y,"."),ENDATE("STARTI")=Y X ^DD("DD") S ENDATE("STARTE")=Y
ACT2 S Y=$$EOM^ENUTL(ENDATE("STARTI")) X ^DD("DD") S %DT("B")=Y
 S %DT("A")="Stopping date: " K %DT(0)
 D ^%DT Q:Y'>0  S Y=$P(Y,"."),ENDATE("STOPI")=Y_".9" X ^DD("DD") S ENDATE("STOPE")=Y
 I ENDATE("STOPI")'>ENDATE("STARTI") W !!,"STOPPING DATE must follow the STARTING DATE",*7 G ACT2
 S X=$P($O(^ENG(6918,"C",ENDATE("STARTI"))),".") I X=""!(X>ENDATE("STOPI")) W !!,"There was no Y2K activity between "_ENDATE("STARTE")_" and "_ENDATE("STOPE")_".",!,"Cumulative information will be transmitted anyway.",*7
 I $P(ENDATE("STOPI"),".",2)="" S ENDATE("STOPI")=ENDATE("STOPI")_".99"
 W !!,"The system is now prepared to send a Y2K report to VACO."
 S DIR("A")="Is that what you want to do",DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR I $D(DIRUT)!('Y) K ENDATE Q  ; confirm the transaction
 S ZTRTN="DEQVACO^ENY2VACO",ZTIO=""
 F J="ENDATE(""STARTI"")","ENDATE(""STOPI"")" S ZTSAVE(J)=""
 S ZTDESC="Y2K National Roll-up (equipment)"
 S ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS K ZTSK
 W !!,"A national roll-up of Y2K information has been tasked to run via NetWork",!,"Mail. You will receive a copy of the message."
 K ENDATE
 Q
 ;
DEQVACO ;  use ENX( as root of NetWork mail message
 K ^TMP($J)
 I $G(ENDATE("STARTI"))="" D
 . S Y=$E(DT,1,5)-1 S:$E(Y,4,5)="00" Y=($E(Y,1,3)-1)_12 S Y=Y_"01"
 . S Y=$P(Y,"."),ENDATE("STARTI")=Y
 . S ENDATE("STOPI")=$$EOM^ENUTL(ENDATE("STARTI"))_".99"
 N DA,CAT,EN,ENX,ENY,TOTAL,STATION,COST,COUNT,ALLSTN,ENSTN,KOUNT,ENCLASS
 D NOW^%DTC S ENY=$P(%,".",2)
 S ENC(1,0)="ENG^"_$E(1000+$E($P(^DIC(6910,1,0),U,2),1,3),2,4)_"^Y2K^"_(%+17000000\1)_U_ENY_$E("000000",1,6-$L(ENY))_U_$$LTZ^ENPLUTL_"^001^|",KOUNT=1
 S (ALLSTN,ENSTN)=0,ENY2K("VACO")=1,ENCLASS=1 D CNTACT^ENY2REP,ROLLACT
 K COUNT,TOTAL
 K ^TMP($J)
 D DEQ1^ENY2REP4,ROLLCUM^ENY2VAC1
 K COUNT,TOTAL
 D DEQ1^ENY2REPA,ROLLFC^ENY2VAC2
 K COUNT,TOTAL
 D SUM1^ENY2USRS,ROLLUTL^ENY2VAC2
 S KOUNT=KOUNT+1,ENC(KOUNT,0)="$"
 D SEND
 G EXIT
 ;
ROLLACT ;  add Y2K activity to national roll-up
 S STATION=0 F  S STATION=$O(^TMP($J,"ENY2B",STATION)) Q:STATION=""  D
 . S ENC(2,0)="A1^"_($P(ENDATE("STARTI"),".")+17000000\1)_U_($P(ENDATE("STOPI"),".")+17000000\1)_U_"|",COUNT=1,KOUNT=2
 . F J=0,"FC","NC","CC","NA" F K=0,"FC","NC","CC","NA" I '(J=0&(K=0)) D
 .. S COUNT=COUNT+1 Q:'^TMP($J,"ENY2B",STATION,J,K,"COUNT")
 .. S KOUNT=KOUNT+1,ENC(KOUNT,0)="A"_COUNT_U_J_U_K_U_^TMP($J,"ENY2B",STATION,J,K,"COUNT")_U_^("EST")_U_^("ACT")_U_^("REST")_U_$S($D(COUNT(STATION,J,K,"EST")):COUNT(STATION,J,K,"EST"),1:"")
 .. S ENC(KOUNT,0)=ENC(KOUNT,0)_U_^TMP($J,"ENY2B",STATION,J,K,"RACT")_U_$S($D(COUNT(STATION,J,K,"ACT")):COUNT(STATION,J,K,"ACT"),1:"")_U_"|"
 Q
 ;
SEND ; send NetWork mail
 S XMY(DUZ)="",XMY("S.EN_UPDATE_Y2K@FORUM.VA.GOV")="",XMDUZ=.5
 ;S XMY(DUZ)="",XMDUZ=.5
 S XMSUB="Roll-up of Y2K Information",XMTEXT="ENC("
 D ^XMD
 K XMY,XMDUZ,XMSUB,XMTEXT
 Q
 ;
HOLD Q:$E(IOST,1,2)'="C-"
 R !!,"Press <RETURN> to continue...",X:DTIME
 Q
EXIT ;
 K ^TMP($J)
 D ^%ZISC,HOME^%ZIS
 I $D(ZTQUEUED) S ZTREQN="@"
 K J,K,X,ENDATE,ENSTN
 Q
 ;ENY2VACO
