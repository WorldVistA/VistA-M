ECXFTRAN ;BIR/DMA-Extract from Local Editing Files and Write to Host File ; 17 Mar 95 / 1:02 PM
 ;;3.0;DSS EXTRACTS;;Dec 22, 1997
 ;
 S ECRE="",DIC=727,DIC(0)="AEQM",DIC("A")="File transfer which extract ",DIC("S")="I '$D(^(""L"")),'$D(^(""PURG""))" D ^DIC K DIC G END:Y<0
 I $G(^ECX(727,+Y,"PURG")) W !,"Data for this extract was purged on ",$E(^("PURG"),4,5),"/",$E(^("PURG"),6,7),"/",$E(^("PURG"),2,3) G ECXFTRAN
 S ECDA=+Y I $G(^ECX(727,ECDA,"TR")) W !,"This extract was transfered on ",$E(^("TR"),4,5),"/",$E(^("TR"),6,7),"/",$E(^("TR"),2,3) S DIR(0)="Y",DIR("A")="Do you want to transfer again "
 D ^DIR K DIR G ECXFTRAN:'Y K ^ECX(727,ECDA,"TR") S ECRE="re"
 S ZTSK=$G(^ECX(727,ECDA,"Q")) I ZTSK D STAT^%ZTLOAD I ZTSK(0) I ZTSK(1)<3 W !!,"Task ",ZTSK," is already queued to transmit this extract",!! K ZTSK G ECXFTRAN
 S ZTIO=""
QUE S ZTSAVE("ECDA")="",ZTSAVE("ECRE")="",ZTRTN="START^ECXFTRAN",ZTDESC="Transmission of extract # "_ECDA D ^%ZTLOAD
SET I $D(ZTSK) W !,"Request queued as Task #",ZTSK,".",! S ^ECX(727,ECDA,"Q")=ZTSK K ZTSK
END K ECDA,ECRE,X,Y Q
 ;
START ; entry point
 S ECINST=+$P(^ECX(728,1,0),"^") K ECXDIC S DA=ECINST,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 D EN^DIQ1 S ECINST=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 S ECF=^ECX(727,ECDA,"FILE"),ECHEAD=^("HEAD"),ECGRP=^("GRP"),ECED=$P(^(0),"^",5),ECPACK=$P(^(0),"^",3)
 K ^TMP($J) S ECHD(1)=ECINST_ECHEAD_$$ECXYM^ECXUTL(ECED),ECRN=0
 S ECFILE=ECHEAD_ECDA_".DAT"
 S %ZIS=0,IOP="DSS FILE DEVICE",%ZIS("HFSNAME")=ECFILE D ^%ZIS
 U IO
 W ECHD(1),!
 F J=0:0 S J=$O(^ECX(ECF,"AC",ECDA,J)) Q:'J  I $D(^ECX(ECF,J,0)) W $P(^(0),"^",4,100)_"^~",! S ECRN=ECRN+1 I ECRN>499,'(ECRN#500) I $$S^%ZTLOAD Q
 I $$S^%ZTLOAD G CLEAN
 ;
 S TIME=$P($$HTE^XLFDT($H),":",1,2)
MSG ; send message to mail group 'DSS-ECGRP'
 S XMSUB=ECINST_" - "_ECPACK_" EXTRACT FOR DSS",XMDUZ="DSS SYSTEM"
 K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 S ^TMP($J,"LOC",1,0)="The DSS "_ECPACK_" extract (#"_ECDA_") was "_ECRE_"transfered on "_$P(TIME,"@")_" at "_$P(TIME,"@",2)_". ",^TMP($J,"LOC",3,0)=" ",^TMP($J,"LOC",4,0)="A total of "_ECRN_" records were written."
 S ^TMP($J,"LOC",5,0)="File name "_ECFILE,^TMP($J,"LOC",6,0)=" "
 S XMTEXT="^TMP($J,""LOC""," D ^XMD S ^ECX(727,ECDA,"TR")=DT
CLEAN ;
 S ZTREQ="@" K ^TMP($J),^ECX(727,ECDA,"Q") D ^%ZISC,^ECXKILL
 I $$S^%ZTLOAD K ZTREQ S ZTSTOP=1
 Q
 ;
