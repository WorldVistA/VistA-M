PRSXP83 ;WCIOFO/MGD-DELETE PP 03-06 ;04/16/2003
 ;;4.0;PAID;**83**;Sep 21, 1995
 ;
 Q
 ;
 ; This program will delete PP 03-06 from the PAID PAYRUN DATA (#459)
 ; file so that Central PAID can re-send the corrected download.
 ; A message will be sent to Pam McClaran and Matt Dill to help with
 ; the tracking of which sites have installed the patch and have deleted 
 ; PP 03-06.
 ;
 ; For more details see the patch description on FORUM.
 ;
START ; Main Driver
 ;
 K ^TMP($J),TMP
 N DA,DIK,MESS1,STANUM,TIME,TMP,U,XMSUB
 S U="^",DA=0
 D NOW^%DTC
 S Y=%
 D DD^%DT
 S TIME=Y
 W !!,"Post install routine PRSXP83 beginning at ",TIME_"."
 ;
 ; Get Station Number
 ;
 S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 S MESS1="Station: "_STANUM_" - "
 ;
 S DA=$O(^PRST(459,"B","03-06",DA))
 ;
 ; Check to see if the entry does not exist
 ;
 I DA'>0 D
 . S ^TMP($J,"MGD",1)=MESS1_"PP 03-06 Not Found."
 . W !!,MESS1_"PP 03-06 Not Found."
 . W !,"Please contact NVS at 888-596-4357."
 . S XMSUB="STATION "_STANUM_" PP 03-06 Not Found."
 ;
 ; Check to see if the entry does exist and delete it
 ;
 I DA>0 D
 . I '$D(^PRST(459,DA,0)) D
 . . S ^TMP($J,"MGD",1)=MESS1_"PP 03-06 Not Found."
 . . W !!,MESS1_"PP 03-06 Not Found."
 . . W !,"Please contact NVS at 888-596-4357."
 . . S XMSUB="STATION "_STANUM_" PP 03-06 Not Found."
 . I $D(^PRST(459,DA,0)) D
 . . S DIK="^PRST(459,"
 . . D ^DIK
 . . S ^TMP($J,"MGD",1)=MESS1_"PP 03-06 Deleted at "_TIME_"."
 . . W !!,MESS1_"PP 03-06 Deleted at "_TIME_"."
 . . S XMSUB="STATION "_STANUM_" PP 03-06 Deleted at "_TIME_"."
 ;
XMT ; Send status via mail message
 ;
 I $D(^TMP($J,"MGD")) D
 . N DIFROM,XMDUZ,XMTEXT,XMY
 . S XMDUZ=.5
 . S XMTEXT="^TMP($J,""MGD"","
 . S XMY("MATT.DILL@DOMAIN.EXT")="",XMY(DUZ)=""
 . S XMY("DILL.MATT@DOMAIN.EXT")=""
 . S XMY("PAM.MCCLARAN@DOMAIN.EXT")=""
 . S XMY("MCCLARAN.PAM@DOMAIN.EXT")=""
 . D ^XMD
 ;
 K ^TMP($J),Y,%
 W !!,"Post install routine PRSXP83 completed.",!
 Q
