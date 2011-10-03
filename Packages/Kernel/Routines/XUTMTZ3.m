XUTMTZ3 ;SEA/RDS - TaskMan: Toolkit, troubleshooting, part 4 ;6/25/91  15:20 ;
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
HERE ;REPORT--log errors by count for this cpu
 S ZTV=^%ZOSF("VOL"),ZT1=0 W !,ZTV
 F ZT=0:0 S ZT1=$O(^%ZTER(1,ZT1)),ZT2=0 Q:'ZT1  F ZT=0:0 S ZT2=$O(^%ZTER(1,ZT1,1,ZT2)) Q:'ZT2  I $D(^(ZT2,"ZE"))#2 S ZTE=$E($TR(^("ZE"),ZTRANSLT,""),1,40) I ZTE]"" D LOG
 Q
 ;
OTHERS ;REPORT--find other cpus, lookup mgr accounts, compute for each
 S ZTV="" F ZT=0:0 S ZTV=$O(^%ZIS(14.5,"B",ZTV)) Q:ZTV=""  I ZTV'=^%ZOSF("VOL") S ZTN=$O(^%ZIS(14.5,"B",ZTV,"")) I ZTN]"",$D(^%ZIS(14.5,ZTN,0))#2 S ZTS=^(0) S ZTM=$P(ZTS,"^",6) I ZTM]"" D THERE
 Q
 ;
THERE ;OTHERS--log errors by count for other cpus
 I $P(ZTS,"^",3)="N" Q
 I $P(ZTS,"^",4)="Y" Q
 W !,ZTV S ZT1=0
 F ZT=0:0 S ZT1=$O(^[ZTM,ZTV]%ZTER(1,ZT1)),ZT2=0 Q:'ZT1  F ZT=0:0 S ZT2=$O(^[ZTM,ZTV]%ZTER(1,ZT1,1,ZT2)) Q:'ZT2  I $D(^(ZT2,"ZE"))#2 S ZTE=$E($TR(^("ZE"),ZTRANSLT,""),1,40) I ZTE]"" D LOG
 Q
 ;
LOG ;HERE & THERE--log totals entry and dailies entry
 I ZTDAY,$H-ZT1<ZTNUMBER S X=$S($D(^TMP($J,"D",1,ZT1,ZTE))#2:^(ZTE),1:"0^,"),Y=$P(X,"^",2),X=X+1,^(ZTE)=X_"^"_Y_$S(Y[(","_ZTV_","):"",1:ZTV_",")
 I ZTCOUNT S X=$S($D(^TMP($J,"T",1,ZTE))#2:^(ZTE),1:"0^,"),Y=$P(X,"^",2),X=X+1,^(ZTE)=X_"^"_Y_$S(Y[(","_ZTV_","):"",1:ZTV_",")
 W "." Q
 ;
DAILIES ;REPORT--compute dailies
 W !,"DAILIES"
 S ZT1=0 F ZT=0:0 S ZT1=$O(^TMP($J,"D",1,ZT1)),ZT2="" Q:'ZT1  F ZT=0:0 S ZT2=$O(^TMP($J,"D",1,ZT1,ZT2)) Q:ZT2=""  S ZTX=^(ZT2),^TMP($J,"D",2,99999-ZT1,99999-ZTX,ZT2)=$P(ZTX,"^",2) W "."
 Q
 ;
TOTALS ;REPORT--compute totals
 W !,"TOTALS"
 S ZT1="" F ZT=0:0 S ZT1=$O(^TMP($J,"T",1,ZT1)) Q:ZT1=""  S ZTX=^(ZT1),^TMP($J,"T",2,99999-ZTX,ZT1)=$P(ZTX,"^",2) W "."
 Q
 ;
OUT ;REPORT--report the data computed
 I ZTCOUNT W !!,"Errors by total count since install:"
 I ZTCOUNT S ZT1=0 F ZT=0:0 S ZT1=$O(^TMP($J,"T",2,ZT1)),ZT2="" Q:'ZT1  F ZT=0:0 S ZT2=$O(^TMP($J,"T",2,ZT1,ZT2)) Q:ZT2=""  S X=^(ZT2) W !,99999-ZT1,?4,ZT2,?46,$E(X,2,$L(X)-1)
 I ZTDAY W !!,"Errors by day:"
 I ZTDAY S ZT1=0 F ZT=0:0 S ZT1=$O(^TMP($J,"D",2,ZT1)),ZT2=0 Q:'ZT1  W !,$$HTE^XLFDT(99999-ZT1) D OUT2
 Q
 ;
OUT2 ;OUT--report the data by day
 F ZT=0:0 S ZT2=$O(^TMP($J,"D",2,ZT1,ZT2)),ZT3="" Q:'ZT2  F ZT=0:0 S ZT3=$O(^TMP($J,"D",2,ZT1,ZT2,ZT3)) Q:ZT3=""  S X=^(ZT3) W !,99999-ZT2,?4,ZT3,?46,$E(X,2,$L(X)-1)
 Q
 ;
SEND ;REPORT--mail the report to the San Francisco ISC
 W !,"Assembling mail report" S ZTLINE=1
 I ZTCOUNT S ^TMP($J,"M",ZTLINE,0)="Report by raw count since install:",ZTLINE=ZTLINE+1
 I ZTCOUNT S ZT1=0 F ZT=0:0 S ZT1=$O(^TMP($J,"T",2,ZT1)),ZT2="" Q:'ZT1  F ZT=0:0 S ZT2=$O(^TMP($J,"T",2,ZT1,ZT2)) Q:ZT2=""  S X=^(ZT2),^TMP($J,"M",ZTLINE,0)=$J(99999-ZT1,5)_$J(ZT2,45)_"  "_$E(X,2,$L(X)-1),ZTLINE=ZTLINE+1 W "."
 I ZTCOUNT,ZTDAY S ^TMP($J,"M",ZTLINE,0)=" ",ZTLINE=ZTLINE+1
 I ZTDAY S ^TMP($J,"M",ZTLINE,0)="Report by day:",ZTLINE=ZTLINE+1
 I ZTDAY S ZT1=0 F ZT=0:0 S ZT1=$O(^TMP($J,"D",2,ZT1)),ZT2=0 Q:'ZT1  S ^TMP($J,"M",ZTLINE,0)=$$HTE^XLFDT(99999-ZT1)_":",ZTLINE=ZTLINE+1 D SEND2
 S ZTN="" I $D(^XMB(1,1,0))#2 S ZTN=$P(^(0),"^")
 I ZTN]"",$D(^DIC(4.2,ZTN,0))#2 S ZTN=$P(^(0),"^")
 D EN^XM S XMSUB="Error report from "_ZTN_" on "_$$HTE^XLFDT($H)
 S XMTEXT="^TMP($J,""M"","
 W !,"Sending the report..." D ^XMD,KILL^XM W !!,"Report sent."
 Q
 ;
SEND2 ;MAIL--prepare to mail report by day
 F ZT=0:0 S ZT2=$O(^TMP($J,"D",2,ZT1,ZT2)),ZT3="" Q:'ZT2  F ZT=0:0 S ZT3=$O(^TMP($J,"D",2,ZT1,ZT2,ZT3)) Q:ZT3=""  S X=^(ZT3),^TMP($J,"M",ZTLINE,0)=$J(99999-ZT2,5)_$J(ZT3,45)_"  "_$E(X,2,$L(X)-1),ZTLINE=ZTLINE+1 W "."
 Q
 ;
