HBHCPS24 ; LR VAMC(IRMS)/MJT-HBHC HBH*1*24 Post Install Routine to force 1 last transmission of 150 character transmission records before length of transmit record changes to 200 characters ; Mar 2008 
 ;;1.0;HOSPITAL BASED HOME CARE;**24**;NOV 01, 1993;Build 201
 ; routine calls HOSP^HBHCUTL1
 S HBHC=$S($$PROD^XUPROD(1):"PRODUCTION",1:"TEST")
 G:HBHC="TEST" EXIT
 ; Do 'build'
 S HBHCLSDT=DT
 D ^HBHCAPPT,^HBHCXMC,^HBHCXMA,^HBHCXMV,^HBHCXMD
 ; Do Cleanup modules
 D ADM,VISIT,DC,MFH
 ; Transmit
 S $P(^HBHC(631.9,1,0),U,6)=1
 K XMDUZ,XMY,XMZ,%DT,^TMP("HBHC",$J)
 N DIFROM
 D HOSP^HBHCUTL1
 S X="T" D ^%DT S HBHCDT=Y,HBHCDATE=$E(HBHCDT,4,5)_"/"_$E(HBHCDT,6,7)_"/"_$E(HBHCDT,2,3)
 S (HBHCCNT,HBHCFLG,HBHCNODE)=0,HBHCMSG=1
 F  S HBHCNODE=$O(^HBHC(634,HBHCNODE)) D:(HBHCCNT>99)!(HBHCNODE'>0) MAIL Q:HBHCNODE'>0  S HBHCCNT=HBHCCNT+1,HBHCINFO=^HBHC(634,HBHCNODE,0),^TMP("HBHC",$J,HBHCMSG,HBHCNODE,0)=HBHCINFO D HISTORY
CLEANUP ; Cleanup Transmit History (HBHC(634.6)) to maintain maximum of last 12 transmit batches
 S (HBHCTOT,HBHCDATE)=0 F  S HBHCDATE=$O(^HBHC(634.6,"C",HBHCDATE)) Q:HBHCDATE'>0  S HBHCTOT=HBHCTOT+1 S:HBHCTOT=1 HBHCDAT=HBHCDATE
 I HBHCTOT>12 S DIK="^HBHC(634.6,",DA="" F  S DA=$O(^HBHC(634.6,"C",HBHCDAT,DA)) Q:DA'>0  D ^DIK
 ; Turn Off Transmission in Progress Flag
 S $P(^HBHC(631.9,1,0),U,6)=""
EXIT ; Exit module
 D ^%ZISC
 K HBHC,HBHCDIR,HBHCLSDT
 K DA,DIC,DIE,DIK,DR,HBHCCNT,HBHCDAT,HBHCDATE,HBHCDT,HBHCFLG,HBHCHOSP,HBHCINFO,HBHCMSG,HBHCNODE,HBHCPRTR,HBHCTOT,HBHCZ,XMSUB,XMTEXT,XMY,XMZ,X,Y,%,%DT,^TMP("HBHC",$J)
 Q
ADM ; Clean up Admission Error file (#634.1)
 I $D(^HBHC(634.1,"B")) K ^HBHC(634.1) S ^HBHC(634.1,0)="HBHC EVALUATION/ADMISSION ERROR(S)^634.1"
 Q
VISIT ; Clean up Visit Error file (#634.2)
 I $D(^HBHC(634.2,"B")) K ^HBHC(634.2) S ^HBHC(634.2,0)="HBHC VISIT ERROR(S)^634.2P"
 Q
DC ; Clean up Discharge Error file (#634.3)
 I $D(^HBHC(634.3,"B")) K ^HBHC(634.3) S ^HBHC(634.3,0)="HBHC DISCHARGE ERROR(S)^634.3"
 Q
MFH ; Clean up MFH Error file (#634.7)
 I $D(^HBHC(634.7,"B")) K ^HBHC(634.7) S ^HBHC(634.7,0)="HBHC MEDICAL FOSTER HOME ERROR(S)^634.7P"
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
