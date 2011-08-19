HBHCXMT ; LR VAMC(IRMS)/MJT-HBHC create mail msgs (100 recs/125 char ea, max) from HBHC(634 file, transmit/Austin, set batch initial MM msg # & MM msg date in HBHC(631/632/633.2, set Last MM Date in HBHC(631.9, optionally prt rpt ;9803
 ;;1.0;HOSPITAL BASED HOME CARE;**2,3,6,8,10,13,24**;NOV 01, 1993;Build 201
 ; routine calls HOSP^HBHCUTL1
 I $P(^HBHC(631.9,1,0),U,8)]"" W $C(7),!,"File Update in progress.  Please try again later." H 3 Q 
 I ($D(^HBHC(634.1,"B")))!($D(^HBHC(634.2,"B")))!($D(^HBHC(634.3,"B")))!($D(^HBHC(634.5,"B")))!($D(^HBHC(634.7,"B"))) W $C(7),!!,"Records containing errors exist and must be corrected before file can",!,"be transmitted.",!! H 3 Q
 I '$D(^HBHC(634,"B")) W $C(7),!!,"No data on file to transmit." H 3 Q
 I ('$D(^HBHC(631,"AE","F")))&('$D(^HBHC(631,"AF","F")))&('$D(^HBHC(632,"AC","F")))&('$D(^HBHC(633.2,"AC","F")))!($P(^HBHC(631.9,1,0),U,6)]"") W $C(7),!!,"Data on file has been transmitted to Austin; duplicate transmission not allowed." H 3 Q
 I $P(^HBHC(631.9,1,0),U,7)]"" S HBHCPRTR=$P($G(^%ZIS(1,$P(^HBHC(631.9,1,0),U,7),0)),U) I HBHCPRTR]"" W !,"Transmit Report will be printed on device:  ",HBHCPRTR W "." D PROMPT2^HBHCR15B
 S ZTRTN="DQ^HBHCXMT",ZTIO="",ZTDTH=$H,ZTDESC="HBPC Transmission",ZTSAVE("HBHC*")="" D ^%ZTLOAD,^%ZISC
 W $C(7),!!,"Transmission request has been queued.  Task number:  ",ZTSK,!! H 3
 G EXIT
DQ ; De-queue
 ; Set Transmission in Progress Flag
 S $P(^HBHC(631.9,1,0),U,6)=1
 K XMZ,%DT,^TMP("HBHC",$J)
 D HOSP^HBHCUTL1
 S X="T" D ^%DT S HBHCDT=Y,HBHCDATE=$E(HBHCDT,4,5)_"/"_$E(HBHCDT,6,7)_"/"_$E(HBHCDT,2,3)
 S (HBHCCNT,HBHCFLG,HBHCNODE)=0,HBHCMSG=1
 F  S HBHCNODE=$O(^HBHC(634,HBHCNODE)) D:(HBHCCNT>99)!(HBHCNODE'>0) MAIL Q:HBHCNODE'>0  S HBHCCNT=HBHCCNT+1,HBHCINFO=^HBHC(634,HBHCNODE,0),^TMP("HBHC",$J,HBHCMSG,HBHCNODE,0)=HBHCINFO D HISTORY
CLEANUP ; Cleanup Transmit History (HBHC(634.6)) to maintain maximum of last 12 transmit batches
 S (HBHCTOT,HBHCDATE)=0 F  S HBHCDATE=$O(^HBHC(634.6,"C",HBHCDATE)) Q:HBHCDATE'>0  S HBHCTOT=HBHCTOT+1 S:HBHCTOT=1 HBHCDAT=HBHCDATE
 I HBHCTOT>12 S DIK="^HBHC(634.6,",DA="" F  S DA=$O(^HBHC(634.6,"C",HBHCDAT,DA)) Q:DA'>0  D ^DIK
 ; Turn Off Transmission in Progress Flag
 S $P(^HBHC(631.9,1,0),U,6)=""
PRINT ; Print Transmit Report if default printer exists in 631.9
 ; HBHCIOP set in PROMPT2^HBHCR15B
 I ($D(HBHCIOP))&($D(HBHCHEAD)) N IOP,ZTIO,ZTSAVE,ZTRTN,ZTDESC,ZTASK,%ZIS,ZTDTH,ZTQUEUED S ZTRTN="DQ^HBHCR15A",ZTIO=HBHCIOP,ZTDESC="HBPC Transmit Report",ZTSAVE("HBHC*")="",ZTDTH=$H D ^%ZTLOAD,^%ZISC
EXIT ; Exit module
 K DA,DIC,DIE,DIK,DR,HBHCCNT,HBHCDAT,HBHCDATE,HBHCDT,HBHCFLG,HBHCHOSP,HBHCINFO,HBHCMSG,HBHCNODE,HBHCPRTR,HBHCTOT,HBHCZ,XMSUB,XMTEXT,XMY,XMZ,X,Y,%,%DT,^TMP("HBHC",$J)
 Q
MAIL ; Send mail message
 S XMSUB="HBHC Site: "_$S($P(^HBHC(631.9,1,0),U,5)]"":$E(HBHCHOSP,1,3),1:"")_"  Message: "_HBHCMSG_"  "_HBHCDATE_" Transmission",XMTEXT="^TMP(""HBHC"",$J,HBHCMSG,",XMY("XXX@Q-HBH.VA.GOV")=""
 D ^XMD
 S HBHCMSG=HBHCMSG+1,HBHCCNT=0
LOOP ; Loop thru ^HBHC(631,"AE") (Form 3 Transmit Flag), ^HBHC(631,"AF") (Form 5 Transmit Flag), & ^HBHC(632,"AC") (Form 4 Transmit Flag) cross-refs to set batch initial MM message number & mailman message date fields in ^HBHC(631/632)
 ; also loop thru ^HBHC(633.2,"AC") (Form 7 Transmit Flag)
 Q:HBHCFLG
 S DIE="^HBHC(631,"
 S DR="71///T;74///^S X=XMZ;75///^S X=HBHCDT",DA="" F  S DA=$O(^HBHC(631,"AE","F",DA)) Q:DA=""  D ^DIE
 S DR="72///T;77///^S X=XMZ;78///^S X=HBHCDT",DA="" F  S DA=$O(^HBHC(631,"AF","F",DA)) Q:DA=""  D ^DIE
 S DIE="^HBHC(632,",DR="7///T;9///^S X=XMZ;10///^S X=HBHCDT",DA="" F  S DA=$O(^HBHC(632,"AC","F",DA)) Q:DA=""  D ^DIE
 ; Only update if Sanctioned MFH site
 I $P($G(^HBHC(631.9,1,0)),U,9)]"" S DIE="^HBHC(633.2,",DR="27///T;29///^S X=XMZ;30///^S X=HBHCDT",DA="" F  S DA=$O(^HBHC(633.2,"AC","F",DA)) Q:DA=""  D ^DIE
 ; Set Last Mail Message Date in System Parameters file
 S $P(^HBHC(631.9,1,0),U,2)=HBHCDT
 S HBHCFLG=1
 Q
HISTORY ; Update HBHC(634.6 Transmit History file
 K DD,DO S DIC="^HBHC(634.6,",DIC(0)="L",DIC("DR")="1///^S X=HBHCDT",X=HBHCINFO D FILE^DICN K DO
 Q
