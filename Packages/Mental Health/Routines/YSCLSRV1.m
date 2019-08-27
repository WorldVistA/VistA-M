YSCLSRV1 ;DALOI/RLM-Clozapine data server ; 11/27/18 4:30pm
 ;;5.01;MENTAL HEALTH;**61,69,74,90,122**;Dec 30, 1994;Build 112
 ; Reference to ^%ZOSF supported by IA #10096
 ; Reference to ^XMD supported by IA #10070
 ; Reference to ^DIQ supported by DBIA #2056
CSUM ;Calculate checksum for routines and transmit errors to Forum
 S X=$T(+0) X ^%ZOSF("RSUM") S ^TMP("YSCL",$J,2,0)="YSCLSRV1 at "_YSCLST_" = "_Y
 F YSI=1:1 S YSA=$T(ROU+YSI) Q:YSA["***"  S X=$P($P(YSA,","),";",3) D
 . X ^%ZOSF("TEST") I '$T S ^TMP("YSCL",$J,YSI+3,0)=X_" is missing." Q
 . X ^%ZOSF("RSUM") S ^TMP("YSCL",$J,YSI+3,0)=X_" should be "_$P(YSA,",",2)_" is "_Y
 ;/RBN - Begin modifications for YS*5.01*122
 K XMY I $$GET1^DIQ(8989.3,1,501,"I") D
 . I 'YSDEBUG S XMY("G.CLOZAPINE ROLL-UP@AADOMAIN.EXT")=""
 . E  S XMY("G.CLOZAPINE DEBUG@FO-DALLAS.DOMAIN.EXT")=""
 E  D
 . I 'YSDEBUG S XMY("G.CLOZAPINE ROLL-UP")=""
 . E  S XMY("G.CLOZAPINE DEBUG")=""
 ;/RBN - End modifications for YS*5.01*122
 S XMSUB=$S(YSDEBUG:"DEBUG ",1:"")_"Clozapine Checksum data at "_YSCLST_" run on "_XQDATE
 S XMTEXT="^TMP(""YSCL"",$J,",XMDUZ="CLOZAPINE MONITOR" D ^XMD
 K %DT,YSA,YSCLST,YSI,X,XMDUZ,XMSUB,XMTEXT,Y
 K ^TMP("YSCL",$J)
 Q
ROU ;
 ;;YSCLDIS,62418722
 ;;YSCLSERV,90753877
 ;;YSCLSRV2,24723007
 ;;YSCLSRV3,24872037
 ;;YSCLTEST,21727247
 ;;YSCLTST1,11839450
 ;;YSCLTST2,112458688
 ;;YSCLTST3,69598047
 ;;YSCLTST5,129720110
 ;;YSCLTST6,26876020
 ;;***
ZEOR ;YSCLSRV1
