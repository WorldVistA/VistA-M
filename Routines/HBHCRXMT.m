HBHCRXMT ; LR VAMC(IRMS)/MJT-HBHC Re-transmit previous MM (100 rec @ 125 chars ea, max) using ^HBHC(634) data, transmit/Austin, & set re-transmit batch initial MM msg no & re-transmit MM date in ^HBHC(631/632) ;9204
 ;;1.0;HOSPITAL BASED HOME CARE;**2,6**;NOV 01, 1993
 I ($D(^HBHC(634.1,"B")))!($D(^HBHC(634.2,"B")))!($D(^HBHC(634.3,"B")))!($D(^HBHC(634.5,"B"))) W *7,!!,"Records containing errors exist and must be corrected before file can",!,"be transmitted.",!! H 3 Q
 I '$D(^HBHC(634,"B")) W *7,!!,"No data on file to transmit." H 3 Q
EN ; Entry point
 W !!,"This option re-transmits the same data included in the last file created for",!,"transmission to Austin.  It should only be run under special circumstances and",!,"should be coordinated with Austin.  Do you wish to continue"
 S %=2 D YN^DICN
 I %=0 W !!,"A 'Yes' response will re-transmit the file to Austin.  A 'No' response will",!,"return to the menu without any data being transmitted." G EN
 G:%'=1 EXIT
 W *7,!!,"Re-transmission request has been queued.",!! H 3
 S ZTRTN="DQ^HBHCRXMT",ZTIO="",ZTDTH=$H,ZTDESC="HBPC Re-Transmit" D ^%ZTLOAD,^%ZISC Q
DQ ; De-queue
 K XMZ,%DT,^TMP("HBHC",$J)
 S X="T" D ^%DT S HBHCDT=Y,HBHCDATE=$E(HBHCDT,4,5)_"/"_$E(HBHCDT,6,7)_"/"_$E(HBHCDT,2,3)
 S (HBHCCNT,HBHCFLG,HBHCNODE)=0,HBHCMSG=1
 F  S HBHCNODE=$O(^HBHC(634,HBHCNODE)) D:(HBHCCNT>99)!(HBHCNODE'>0) MAIL Q:HBHCNODE'>0  S HBHCCNT=HBHCCNT+1,^TMP("HBHC",$J,HBHCMSG,HBHCNODE,0)=^HBHC(634,HBHCNODE,0)
EXIT ; Exit module
 K DA,DIE,DR,HBHCCNT,HBHCDAT,HBHCDATE,HBHCDT,HBHCFLG,HBHCMSG,HBHCNODE,HBHCZ,XMSUB,XMTEXT,XMY,XMZ,X,Y,%,%DT,^TMP("HBHC",$J)
 Q
MAIL ; Send mail message
 S XMSUB="HBHC Site: "_$S($P(^HBHC(631.9,1,0),U,5)]"":$E($P($G(^DIC(4,$P(^HBHC(631.9,1,0),U,5),99)),U),1,3),1:"")_"  Message: "_HBHCMSG_"  "_HBHCDATE_" Transmission",XMTEXT="^TMP(""HBHC"",$J,HBHCMSG,",XMY("XXX@Q-HBH.VA.GOV")=""
 D ^XMD
 S HBHCMSG=HBHCMSG+1,HBHCCNT=0
LOOP ; Loop thru ^HBHC(631,"AG") (Form 3 Mail Message Date), ^HBHC(631,"AH") (Form 5 Mail Message Date), & ^HBHC(632,"AD") (Form 4 Mail Message Date) cross-refs
 ; set re-transmit batch initial MM msg no & re-transmit mailman date fields in ^HBHC(631/632)
 Q:HBHCFLG
 S HBHCDAT=$P($G(^HBHC(631.9,1,0)),U,2)
 Q:HBHCDAT=""
 S DIE="^HBHC(631,"
 S DR="83///^S X=XMZ;84///^S X=HBHCDT",DA="" F  S DA=$O(^HBHC(631,"AG",HBHCDAT,DA)) Q:DA=""  D ^DIE
 S DR="85///^S X=XMZ;86///^S X=HBHCDT",DA="" F  S DA=$O(^HBHC(631,"AH",HBHCDAT,DA)) Q:DA=""  D ^DIE
 S DIE="^HBHC(632,",DR="13///^S X=XMZ;14///^S X=HBHCDT",DA="" F  S DA=$O(^HBHC(632,"AD",HBHCDAT,DA)) Q:DA=""  D ^DIE
 S HBHCFLG=1
 Q
