NVSVCSS ;emc/maw,kjw-clusterwide system status (VMS/Cache); 1/26/04
 ;;2.0;EMC SYSTEM UTILITIES; January 26, 2004
 ;
 ; The procedure AXP$CLU_SS.COM called by this routine was authored by
 ; Kurt Wittman, OIFO Birmingham, AL.
 ;
 ; --- added check for file existence in [AXP] directory   jls     1/21/06  NOON
 ; --- modified to work in a co-location environment wjw 10.17.05
 ; 
 I $G(DUZ)="" D
 .S DUZ=.5
 .D DT^DICRW
 .D HOME^%ZIS
 ;
 K NVSCHK,NVSFILE,NVSPEC S NVSPEC("AXP$CLU_SS.COM")="" S NVSCHK=$$LIST^%ZISH("USER$:[AXP]","NVSPEC","NVSFILE")
 I NVSCHK=0 D  K NVSCHK,NVSFILE,NVSPEC Q
 .W !,"<<< The DCL file AXP$CLU_SS.COM is not found in the USER$:[AXP] directory. >>>",!
 .W !,"This file can be retrieved from an FTP server at DOWNLOAD.VISTA.MED.VA.GOV"
 .W !,"in the [ANONYMOUS.AXP.CACHECONV] directory, or you can log a Remedy ticket for"
 .W !,"assistance."
 .H 2
 .Q
 ;
 W !!,"This uses the Fileman Browser for screen display, for online help for navigating"
 W !,"through screen pages, enter <PF1>H for details.  Do *not* use the RETURN key for"
 W !,"paging, use the Up/Down Arrow keys instead."
 K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" W ! D ^DIR K DIR
 W !!,"Collecting system status from all nodes in the cluster...a moment please..."
 S NVSCFG=$P($ZU(86),"*",2),NVSCFG=$P(NVSCFG,"A")
 S X=$ZF(-1,"@USER$:[AXP]AXP$CLU_SS USER$:[TEMP]CLUSTER_SS.TXT "_NVSCFG)
 K ^TMP("NVS")
 S X=$$FTG^%ZISH("USER$:[TEMP]","CLUSTER_SS.TXT","^TMP(""NVS"",1)",2,"OVF")
 I X'=1 D  Q
 .W !!,"Data collection failed."
 .S X=$ZF(-1,"DEL USER$:[TEMP]CLUSTER_SS.TXT;*")
 .S X=$ZF(-1,"DEL USER$:[AXP]sysman_cluss.tmp;*")
 S X=$ZF(-1,"DEL USER$:[TEMP]CLUSTER_SS.TXT;*")
 S X=$ZF(-1,"DEL USER$:[AXP]sysman_cluss.tmp;*")
 S NVSHDR="CLUSTER SYSTEM STATUS : "_$G(^DD("SITE"))_" : "_$$FMTE^XLFDT($$NOW^XLFDT())
 D BROWSE^DDBR("^TMP(""NVS"")","N",NVSHDR)
 K DIRUT,DTOUT,NVSCHK,NVSFILE,NVSPEC,NVSHDR,X,Y,^TMP("NVS"),NVSCFG
 Q
