PSXPURG1 ;BIRM/WPB-CHECK PSX(552.1,"AP" FOR NOT PROCESSED BATCHES [ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
CKAP K ^TMP($J,"PSXPROC")
 D NOW^%DTC S STRT=$$FMADD^XLFDT(%,-3,0,0,0),CNT=1 K %
 F  S STRT=$O(^PSX(552.1,"AP",STRT)) Q:'STRT  S BAT="" F  S BAT=$O(^PSX(552.1,"AP",STRT,BAT)) Q:'BAT  D CKAQ
 D MSG
 K STRT,BAT,CNT
 Q
CKAQ S:$D(^PSX(552.2,"AQ",BAT)) ^TMP($J,"PSXPROC",CNT)=BAT,CNT=CNT+1
 Q
MSG Q  Q:'$D(^TMP($J,"PSXPROC"))
 S XMSUB="CMOP PROCESSED MSG",XMDUN="CMOP Manager"
 D XMZ^XMA2 G:XMZ'>0 MSG
 S FAC=$P(^PSX(553,1,0),"^")_" CMOP"
 S COM=$S($D(^TMP($J,"PSXPROC")):" has transmissions that are marked as processed that have data to go to the vendor.",1:" all transmissions processed correctly."),LCNT=1
 S ^XMB(3.9,XMZ,2,LCNT,0)=FAC_COM,LCNT=LCNT+1,^XMB(3.9,XMZ,2,LCNT,0)=" ",LCNT=LCNT+1
 I $D(^TMP($J,"PSXPROC")) D
 .S XX=0 F  S XX=$O(^TMP($J,"PSXPROC",XX)) Q:XX'>0  S ^XMB(3.9,XMZ,2,LCNT,0)=$G(^TMP($J,"PSXPROC",XX))_" marked as processed but has data to send to the vendor.",LCNT=LCNT+1
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_LCNT_"^"_LCNT_"^"_DT,XMDUZ=.5
 K XMY D GRP^PSXNOTE D ENT1^XMD
 K XMSUB,XMDUN,XMZ,LCNT,^TMP($J,"PSXPROC"),FAC,COM,XMY,XMDUZ,XX
 Q
