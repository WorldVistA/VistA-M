PSXCMOP ;BIR/WRT-review NDF (LOOP) matches for CMOP ;[ 07/20/98  1:45 PM ]
 ;;2.0;CMOP;**18,23**;11 Apr 97
 ;Reference to ^PSDRUG(  Supported by DBIA #1983, #2367
START D ^PSXCMOP0
 Q
MARK W !!,"Do you wish to mark this drug to transmit to CMOP? " K DIR S DIR(0)="Y" D ^DIR D OUT I "Nn"[X S ^TMP($J,"PSXANS",PSXDA)="NO" I '$O(^TMP($J,"PSXCMOP",PSXM,PSXDA)) D GROUP S PSXF=1 Q:PSXF=1  Q:PSXFL=1
 Q:PSXFL
 I "^"[X S PSXFL=1 Q:PSXFL=1  G DONE^PSXCMOP0
 I "Yy"[X S ^TMP($J,"PSXANS",PSXDA)="YES^"_PSXDU D DU^PSXCMOP1,QUES2
 Q
DOIT I $P(^TMP($J,"PSXANS",WAS),"^",1)="YES" S PSXLM=$P(^PSDRUG(WAS,0),"^",1),$P(^PSDRUG(WAS,660),"^",8)=$P(^TMP($J,"PSXANS",WAS),"^",2),^PSDRUG(WAS,3)=1,^PSDRUG("AQ",WAS)="" D DOIT1,PR^PSXCMOP1 S DA=WAS D ^PSXREF,IDENT^PSXCMOP1 K DA S PSXF=1
 I $P(^TMP($J,"PSXANS",WAS),"^",1)="NO" S ^PSDRUG(WAS,3)=0,DA=WAS D ^PSXREF K DA S PSXF=1
 D IT
 Q
DOIT1 I $P(^TMP($J,"PSXANS",WAS),"^",3)="YES" S $P(^PSDRUG(WAS,0),"^",1)=PSXM,^PSDRUG("B",PSXM,WAS)="" K:PSXM'=PSXLM ^PSDRUG("B",PSXLM,WAS) D TRAN^PSXCMOP1
 I $P(^TMP($J,"PSXANS",WAS),"^",3)="NO" D SYN^PSXCMOP0
 Q
IT K ^TMP($J,"PSXANS",WAS)
 Q
QUES2 S PSXDUP=0
 W !!,"Do you wish to overwrite your local name? " K DIR S DIR(0)="Y",DIR("?")="If you answer ""yes"", you will overwrite GENERIC NAME with the VA Print Name." D ^DIR D OUT I "Nn"[X S $P(^TMP($J,"PSXANS",PSXDA),"^",3)="NO" S PSXG=1 Q:PSXG=1
 Q:PSXFL
 I "Yy"[X D DUP I PSXDUP=0 S $P(^TMP($J,"PSXANS",PSXDA),"^",3)="YES",$P(^TMP($J,"PSXANS",PSXDA),"^",4)=PSXM
 I "^"[X S PSXFL=1 Q:PSXFL  G DONE^PSXCMOP0
 Q
DUP I PSXM'=PSXLOC,$D(^PSDRUG("B",PSXM)) S PSXDUP=1
 F DA=0:0 S DA=$O(^TMP($J,"PSXANS",DA)) Q:'DA  I $P(^TMP($J,"PSXANS",DA),"^",3)="YES" S PSXDUP=1
 D:PSXDUP=1 MESS S:PSXDUP=1 $P(^TMP($J,"PSXANS",PSXDA),"^",3)="NO"
 Q
MESS W !!,"You cannot write over the GENERIC NAME because you have either",!,"already marked one to overwrite or have already overwritten one",!,"with that VA Print Name. You cannot have duplicate names.",! H 4
 Q
BLD1 I $P($G(^PSDRUG(PSXB,0)),"^",3)[1!$P($G(^PSDRUG(PSXB,0)),"^",3)[2 Q
 S PSXDN=^PSDRUG(PSXB,"ND"),PSXGN=$P(PSXDN,"^",1),PSXVP=$P(PSXDN,"^",3)
 S ZX=$$PROD2^PSNAPIS(PSXGN,PSXVP) I $P($G(ZX),"^",3)=1 S PSXCMOP=$P(ZX,"^",2),PSXVAP=$P(ZX,"^"),PSXDP=$P(ZX,"^",4) K ZX D TMP
 Q
TMP S ^TMP($J,"PSXCMOP",PSXVAP,PSXB)=PSXDP
 Q
PICK1 S PSXM="" F  S PSXM=$O(^TMP($J,"PSXCMOP",PSXM)) Q:PSXM=""  Q:PSXFL  D PICK2  Q:PSXEND
 Q
PICK2 F PSXDA=0:0 S PSXDA=$O(^TMP($J,"PSXCMOP",PSXM,PSXDA)) Q:'PSXDA  D GOTIT I '$O(^TMP($J,"PSXCMOP",PSXM,PSXDA)) Q:PSXFL=1  D GROUP Q:PSXF=1
 Q
GOTIT S PSXZERO=^PSDRUG(PSXDA,0),PSXLOC=$P(PSXZERO,"^",1),PSXDU=$P(^TMP($J,"PSXCMOP",PSXM,PSXDA),"^",1) D DISPLAY^PSXCMOP0 Q:PSXF  Q:PSXFL
 Q
GROUP I $D(^TMP($J,"PSXANS")) D GROUP1
 Q
GROUP1 Q:PSXFL  W @IOF S NUM=0 W !?5,"VA Print Name: ",PSXM,!!,?3,"Local Drug Name",?46,"CMOP?",?55,"VA D.U.",?70,"O.W.?",!
 F RRF=1:1:80 W "-"
 F NDA=0:0 S NDA=$O(^TMP($J,"PSXANS",NDA)) Q:'NDA  S NUM=NUM+1 W !,NUM_".",?3,$P(^PSDRUG(NDA,0),"^",1),?46,$P(^TMP($J,"PSXANS",NDA),"^",1),?55,$P(^TMP($J,"PSXANS",NDA),"^",2),?70,$P(^TMP($J,"PSXANS",NDA),"^",3) D PRC^PSXCMOP1
 D ASK
 Q
ASK W !!!,"If you answer ""Yes"" you will go to the next VA Print Name. If you answer ""No""",!,"you will go back through this particular VA Print Name group.",!
 W !,"Are you sure everything is correct? " K DIR S DIR(0)="Y" D ^DIR D OUT I "Nn"[X G PICK1
 I "Yy"[X F WAS=0:0 S WAS=$O(^TMP($J,"PSXANS",WAS)) Q:'WAS  D DOIT K ^TMP($J,"PSXCMOP",PSXM) S:'$D(^TMP($J,"PSXCMOP")) PSXEND=1
 I "^"[X S PSXFL=1 Q:PSXFL  G DONE^PSXCMOP0
 Q
OUT I $D(DTOUT),DTOUT=1 S PSXFL=1,PSXBT=1
 Q
