YSCLSRV1 ;DALOI/RLM-Clozapine data server ;24 APR 1990
 ;;5.01;MENTAL HEALTH;**61,69,74,90**;Dec 30, 1994;Build 18
 ; Reference to ^%ZOSF supported by IA #10096
 ; Reference to ^XMD supported by IA #10070
CSUM ;Calculate checksum for routines and transmit errors to Forum
 S X=$T(+0) X ^%ZOSF("RSUM") S ^TMP("YSCL",$J,2,0)="YSCLSRV1 at "_YSCLST_" = "_Y
 F YSI=1:1 S YSA=$T(ROU+YSI) Q:YSA["***"  S X=$P($P(YSA,","),";",3) D
  . X ^%ZOSF("TEST") I '$T S ^TMP("YSCL",$J,YSI+3,0)=X_" is missing." Q
  . X ^%ZOSF("RSUM") S ^TMP("YSCL",$J,YSI+3,0)=X_" should be "_$P(YSA,",",2)_" is "_Y
 K XMY S XMY("G.CLOZAPINE ROLL-UP@FORUM.VA.GOV")=""
 I YSDEBUG K XMY S XMY("G.CLOZAPINE DEBUG@FO-DALLAS.MED.VA.GOV")=""
 S XMSUB=$S(YSDEBUG:"DEBUG ",1:"")_"Clozapine Checksum data at "_YSCLST_" run on "_XQDATE
 S XMTEXT="^TMP(""YSCL"",$J,",XMDUZ="CLOZAPINE MONITOR" D ^XMD
 K %DT,YSA,YSCLST,YSI,X,XMDUZ,XMSUB,XMTEXT,Y
 K ^TMP("YSCL",$J)
 Q
ROU ;
 ;;YSCLSERV,25564583
 ;;YSCLSRV2,24723007
 ;;YSCLSRV3,24872037
 ;;YSCLTEST,12378003
 ;;YSCLTST1,11839450
 ;;YSCLTST2,32098862
 ;;YSCLTST3,25645207
 ;;***
ZEOR ;YSCLSRV1
