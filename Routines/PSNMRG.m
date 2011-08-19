PSNMRG ;BIR/CCH&WRT-merges NDF fields into PSDRUG ; 04/18/01 14:56
 ;;4.0; NATIONAL DRUG FILE;**2,22,27,51,55,59,60,65,84**; 30 Oct 98
 ;
 ;Reference to ^PS(50.3 supported by DBIA #2612
 ;Reference to ^PSDRUG supported by DBIA #2352,#221
 ;Reference to EN2^PSSUTIL supported by DBIA #3107
 ;Reference to ^PS(59.7 supported by DBIA #2613
 ;Reference to ^PS(59 supported by DBIA #1976
 ;IA 3621 - DRG^PSSHUIDG(DA)
 ;IA 4394 - DRG^PSSDGUPD(DA)  HL7 V.2.4 dispensing machines
 ;
 W !,"This option will merge NDF fields into your local drug file. This will also",!,"produce an Error Report for entries in the translation file which are not",!,"in the local file if they should exist."
 W " These exceptions will not be merged.",!
 W !,"You may queue this report if you wish.",!
DVC K %ZIS,POP,IOP S %ZIS="QM",%ZIS("B")="",%ZIS("A")="Select Printer: " D ^%ZIS G:POP DONE W:$E(IOST)'="P" !!,"This report must be run on a printer.",!! G:$E(IOST)'="P" DVC I POP K IOP,POP,IO("Q") Q
QUE I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^PSNMRG",ZTDESC="Merge Error Report" D ^%ZTLOAD K ZTSK D ^%ZISC Q
ENQ U IO S PSNPGCT=0,PSNPGLNG=IOSL-6 D TITLE,LOOP
DONE W @IOF S:$D(ZTQUEUED) ZTREQ="@" K PSNPGLNG,PSNPGCT,Y,MJT,POP,VADC,PRIM,FLAG,IOP,IO("Q") D ^%ZISC
 Q
TITLE I $D(IOF),IOF]"" W @IOF S PSNPGCT=PSNPGCT+1
 W !,?32,"MERGE ERROR REPORT",!
 S Y=DT X ^DD("DD") W !,"Date Printed: ",Y,?73,"Page: ",PSNPGCT,!
 W !!,"INTERNAL FILE NUMBER",?30,"VA PRODUCT NAME",!
 F MJT=1:1:80 W "-"
 Q
LOOP D:$D(XRTL) T0^%ZOSV K ^TMP($J,"PSN") F PSNB=0:0 S PSNB=$O(^PSNTRAN(PSNB)) Q:'PSNB  D SET
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV ; STOP
 I '$D(^TMP($J,"PSN")) W !!,?30,"No Errors Found During Merge",!!!
 I $D(^TMP($J,"PSN")) F PSNB=0:0 S PSNB=$O(^TMP($J,"PSN",PSNB)) Q:'PSNB  D:$Y+5>IOSL TITLE W !,?8,PSNB,?30,FRMNAM,!,"***** This entry no longer exists in your local drug file. ***** ",!," This entry will not be merged. ",! K ^PSNTRAN(PSNB,0)
 I $D(^TMP("PSNDP",$J)) S DISPNM="" F  S DISPNM=$O(^TMP("PSNDP",$J,DISPNM)) Q:DISPNM=""  D:$Y+5>IOSL TITLE W !,?5,DISPNM,?51,"needs to be rematched to Orderable Item."
 I $D(^TMP("PSNAD",$J)) S ADNM="" F  S ADNM=$O(^TMP("PSNAD",$J,ADNM)) Q:ADNM=""  D:$Y+5>IOSL TITLE W !,"Additive ",?12,ADNM,?51,"needs to be rematched to Orderable Item."
 I $D(^TMP("PSNSL",$J)) S SLNM="" F  S SLNM=$O(^TMP("PSNSL",$J,SLNM)) Q:SLNM=""  D:$Y+5>IOSL TITLE W !,"Solution ",?12,SLNM,?51,"needs to be rematched to Orderable Item."
KILLIT K ANS,CLDA,PSNNODE,PSNB,PSNIO,ZTRTN,FRMNAM,^TMP("PSNAD",$J),^TMP("PSNDP",$J),^TMP("PSNSL",$J),SLNM,ADNM,DISPNM Q
 Q
SET I $D(PSNFL) Q:PSNFL
 Q:'$D(^PSNTRAN(PSNB,0))  Q:$P(^PSNTRAN(PSNB,0),"^",9)'="Y"  I '$D(^PSDRUG(PSNB)) S FRMNAM=$P(^PSNDF(50.68,$P(^PSNTRAN(PSNB,0),"^",2),0),"^"),^TMP($J,"PSN",PSNB,FRMNAM)="" Q
 I $D(^PSDRUG("VAC")) F VADC=0:0 S VADC=$O(^PSDRUG("VAC",VADC)) Q:'VADC  I $D(^PSDRUG("VAC",VADC,PSNB)) K ^PSDRUG("VAC",VADC,PSNB)
 S PSNNODE=^PSNTRAN(PSNB,0)
 S ^PSDRUG(PSNB,"ND")=$P(PSNNODE,"^")_"^"_$P(^PSNDF(50.68,$P(PSNNODE,"^",2),0),"^")_"^"_$P(PSNNODE,"^",2)_"^"_$P(PSNNODE,"^",5)_"^"_$P(PSNNODE,"^",7)_"^"_$P(PSNNODE,"^",3),^PSDRUG("VAC",$P(PSNNODE,"^",3),PSNB)="",^PSDRUG("AND",+PSNNODE,PSNB)=""
 S PSNEX=$E($P(^PSDRUG(PSNB,"ND"),"^",2),1,30),^PSDRUG("VAPN",PSNEX,PSNB)="" K PSNEX
 S MMM=$P(^PSDRUG(PSNB,"ND"),"^",1),NNN=$P(^PSDRUG(PSNB,"ND"),"^",3),DA=MMM,K=NNN,X=$$PROD2^PSNAPIS(DA,K) I X]"",$P(X,"^")]"" S $P(^PSDRUG(PSNB,"ND"),"^",10)=$P(X,"^",2),^PSDRUG("AQ1",$P(X,"^",2),PSNB)=""
 S FORMI=$P($G(^PSNDF(50.68,NNN,5)),"^") I FORMI]"" S $P(^PSDRUG(PSNB,"ND"),"^",11)=FORMI
 I $P(^PSDRUG(PSNB,0),"^",3)="",$P($G(^PSNDF(50.68,NNN,7)),"^") N CS S CS=$P($G(^PSNDF(50.68,NNN,7)),"^"),$P(^PSDRUG(PSNB,0),"^",3)=$S(CS?1(1"2n",1"3n"):+CS_"C",+CS=2!(+CS=3)&(CS'["C"):+CS_"A",1:CS) K CS
 S X="PSNPSS" X ^%ZOSF("TEST") I  D ^PSNPSS
 K MMM,NNN,FORMI
 S X="PSSUTIL" X ^%ZOSF("TEST") I  D EN2^PSSUTIL(PSNB,0)
 S FLAG=0
 I $D(^PS(59.7,1,49.99)),+^(49.99) S CLDA=$P(PSNNODE,"^",3) I $D(^PS(50.605,CLDA)) S $P(^PSDRUG(PSNB,0),"^",2)=$P(^PS(50.605,CLDA,0),"^",1)
 I $D(^PSDRUG("APC")) F PP=0:0 S PP=$O(^PSDRUG("APC",PP)) Q:'PP  S COD="" F  S COD=$O(^PSDRUG("APC",PP,COD)) Q:COD=""  I $D(^PSDRUG("APC",PP,COD,PSNB)) D SETAPC
 I FLAG=0 S PRIM=$P($G(^PSDRUG(PSNB,2)),"^",6) I PRIM,$D(^PS(50.3,PRIM)) S ^PSDRUG("APC",PRIM,$P(^PSDRUG(PSNB,0),"^",2),PSNB)=""
 K ^PSNTRAN(PSNB,0) S $P(^PSNTRAN(0),"^",4)=($P(^PSNTRAN(0),"^",4))-1,$P(^PSNTRAN(0),"^",3)=0
 ;
 I $D(^PSDRUG("AOC")) S PP=0 F  S PP=$O(^PSDRUG("AOC",PP)) Q:'PP  S COD="" F  S COD=$O(^PSDRUG("AOC",PP,COD)) Q:COD=""  I $D(^PSDRUG("AOC",PP,COD,PSNB)) K ^PSDRUG("AOC",PP,COD,PSNB)
 S PRIM=$P($G(^PSDRUG(PSNB,2)),"^") S:PRIM ^PSDRUG("AOC",PRIM,$P(^PS(50.605,CLDA,0),"^",1),PSNB)=""
 I $$PATCH^XPDUTL("PSS*1.0*57") D DRG^PSSHUIDG(PSNB)
 N XX,DNSNAM,DNSPORT,DVER,DMFU S XX=""
 F XX=0:0 S XX=$O(^PS(59,XX)) Q:'XX  D
 .S DVER=$$GET1^DIQ(59,XX_",",105,"I"),DMFU=$$GET1^DIQ(59,XX_",",105.2)
 .I DVER="2.4" S DNSNAM=$$GET1^DIQ(59,XX_",",2006),DNSPORT=$$GET1^DIQ(59,XX_",",2007) I DNSNAM'=""&(DMFU="YES") D DRG^PSSDGUPD(PSNB,"",DNSNAM,DNSPORT)
 Q
SETAPC K ^PSDRUG("APC",PP,COD,PSNB) S ^PSDRUG("APC",PP,$P(^PS(50.605,CLDA,0),"^",1),PSNB)="" S FLAG=1
 Q
