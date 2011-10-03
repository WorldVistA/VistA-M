PRCFDBL ;WISC/CLH/LEM-BULLETIN GENERATOR FOR CI'S DUE ;7/19/95  14:30
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 N PRC,X,Y,%,DIR,PRCFDT,DATE
 S X="T+7" D ^%DT S PRCFDT=Y D DD^%DT S DATE=Y
 I '$D(ZTQUEUED) D  Q
 . S PRCF("X")="AS" D ^PRCFSITE Q:'%
 . W ! S DIR(0)="Y",DIR("T")=120,DIR("A")="Okay to continue",DIR("A",1)="This option generates bulletins to those services having",DIR("A",2)="a Certified Invoice due in Fiscal on "_DATE_".",DIR("?")="^D CI^PRCFHLP"
 . S DIR("A",3)=" ",DIR("A",4)="This job is scheduled to run on a daily basis",DIR("A",5)="Are you sure you want to run this option manually?" D ^DIR K DIR
 . I 'Y Q
 . S ZTDTH=$H,ZTIO="",ZTDESC="Certified Invoice Bulletin Generator",ZTRTN="DQ^PRCFDBL",ZTSAVE("PRC*")="",ZTSAVE("DATE")="" D ^%ZTLOAD
 . W !! S X="Request Queued.*" D MSG^PRCFQ K ZTSK
DQ N DA,CP,XMY,XMDUZ,XMTEXT,MSG,SITE,FCP,FCPTR,PRCFPO,X,ZX,ZXX,CNT,XMZ
 K ^TMP($J) Q:'$D(^PRCF(421.5,"AC",PRCFDT))
 S DA=0 F  S DA=$O(^PRCF(421.5,"AC",PRCFDT,DA)) Q:'DA  I $D(^PRCF(421.5,DA,2)),'$P(^(2),U,14) D
 . S PRC("SITE")=+$P(^PRCF(421.5,DA,2),U,3)
 . S FCPTR=$P($G(^PRCF(421.5,DA,0)),U,7) Q:'FCPTR
 . S FCP=+$P($G(^PRC(442,FCPTR,0)),U,3) Q:'FCP
 . S ^TMP($J,PRC("SITE"),FCP,DA)=""
 S PRC("SITE")=0
 F  S PRC("SITE")=$O(^TMP($J,PRC("SITE"))) Q:'PRC("SITE")  D
 . S FCP=0 F  S FCP=$O(^TMP($J,PRC("SITE"),FCP)) Q:'FCP  D
 . . S MSG(1)=" "
 . . S MSG(2)="The following invoice(s) are DUE in Fiscal on "_DATE
 . . S MSG(3)=" for Control Point "_$S($D(^PRC(420,PRC("SITE"),1,+FCP,0)):$P(^(0),U),1:"UNKNOWN FCP")_":"
 . . S MSG(4)=" "
 . . S CNT=4,DA=0 F  S DA=$O(^TMP($J,PRC("SITE"),FCP,DA)) Q:'DA  D
 . . . S CNT=CNT+1,X=^PRCF(421.5,DA,0),MSG(CNT)="Tracking #: "
 . . . S MSG(CNT)=MSG(CNT)_$P(X,U)_", Vendor: "
 . . . S MSG(CNT)=MSG(CNT)_$S($P(X,U,8)]"":$P($G(^PRC(440,$P(X,U,8),0)),U),1:"UNKNOWN")
 . . . S MSG(CNT)=MSG(CNT)_", Invoice #: "_$P(X,U,3)
 . . . S PRCFPO=$P($G(^PRCF(421.5,DA,1)),U,3)
 . . . S:PRCFPO]"" MSG(CNT)=MSG(CNT)_", PO#: "_PRCFPO
 . . . Q
 . . K XMY S ZX=0 F  S ZX=$O(^PRC(420,PRC("SITE"),1,+FCP,1,ZX)) Q:'ZX  I $P($G(^(ZX,0)),U,2)<3,$P(^(0),"^")]"" S XMY(ZX)=""
 . . S XMDUZ=$S(+$G(PRC("PER")):+PRC("PER"),1:DUZ),XMY(XMDUZ)=""
 . . S XMSUB="CERTIFIED INVOICES DUE IN FISCAL",XMTEXT="MSG("
 . . S MSG(CNT+1)=" "
 . . S MSG(CNT+2)="Please note and return to Fiscal prior to due date."
 . . D ^XMD
 . . S ZXX=0 F  S ZXX=$O(^TMP($J,PRC("SITE"),FCP,ZXX)) Q:'ZXX  S $P(^PRCF(421.5,ZXX,2),U,14)=1,$P(^(2),U,15)=DT,$P(^(2),U,16)=$G(XMZ)
 . . K MSG,XMY
 . . Q
 . Q
 S ZTREQ="@" K PRC,^TMP($J),DTOUT,DUOUT,DIRUT,DIROUT,PRCFDT,DATE
 Q
