PRSXP82 ;WCIOFO/MGD-ADD CENTRAL,PAID TO #200 ;09/16/2003
 ;;4.0;PAID;**82**;Sep 21, 1995
 ;
 Q
 ;
 ; This program will add the new entry CENTRAL,PAID to the NEW PERSON
 ; (#200) file.  This entry will be used by the VistA PAID/ETA
 ; software to track changes in the employee's Labor Distribution(s)
 ; through the processing of the various downloads received from
 ; Central Paid in Austin, Texas.  It will also add 
 ;
 ; For more details see the patch description on FORUM.
 ;
START ; Main Driver
 ;
 N DIC,DIERR,DLAYGO,I,IENS,LCNT,MSG,PRSFDA,STA1,STA2,STA3,STANUM
 N STATUS,TIME,TOI,U,UCIX,X,Y
 S U="^",LCNT=1,(STA1,STA2,STA3)=""
 K ^TMP($J)
 D NOW^%DTC
 S Y=%
 D DD^%DT
 S TIME=Y
 W !!,"Post install routine PRSXP82 beginning at ",TIME_".",!
 ;
 ; Get Station Number
 ;
 S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 S MSG="Station: "_STANUM_" - "
 ;
 ; Check for UCI,VOL
 ;
 X ^%ZOSF("UCI")
 S UCIX=$G(Y)
 I UCIX=""!(UCIX'?3U1","3U) S UCIX="???,???"
 S MSG=MSG_UCIX_" - "
 ;
 S X=$O(^VA(200,"B","CENTRAL,PAID",0))
 I X D ERR1
 ;
 I 'X D
 . S X="CENTRAL,PAID",DIC(0)="L",DLAYGO=200,DIC="^VA(200,"
 . D FILE^DICN
 . I Y=-1 D ERR2
 . I $P(Y,U,3) D
 . . S ^TMP($J,"MGD",LCNT)=MSG_" CENTRAL,PAID added."
 . . S LCNT=LCNT+1
 . . W !,MSG_" CENTRAL,PAID added."
 ;
TOI ; Create entries for the Types Of Interfaces
 K PRSFDA
 W !
 S LCNT=LCNT+1
 S ^TMP($J,"MGD",LCNT)=""
 S LCNT=LCNT+1
 F I=1:1:4 D
 . S TOI=$S(I=1:"INITIAL",I=2:"EDIT & UPDATE",I=3:"TRANSFER",4:"PAYRUN",1:"INITIAL")
 . S IENS="?+"_I_",1,"
 . S PRSFDA(454.02,IENS,.01)=I
 . S PRSFDA(454.02,IENS,1)=TOI
 . D UPDATE^DIE("","PRSFDA")
 . I $D(DIERR)>0 D
 . . S LCNT=LCNT+1
 . . S ^TMP($J,"MGD",LCNT)=MSG_" unable to add "_TOI_" entry."
 . . W !,MSG_" unable to add "_TOI_" entry.",!
 . . S STA3=" ERROR #3"
 . I $D(DIERR)<1 D
 . . S LCNT=LCNT+1
 . . S ^TMP($J,"MGD",LCNT)=MSG_" entry "_TOI_" added."
 . . W !,MSG_" entry "_TOI_" added."
 ;
XMT ; Send status via mail message
 ;
 I $D(^TMP($J,"MGD")) D
 . S STATUS=STA1_STA2_STA3
 . I STATUS'["ERROR" S STATUS="NO ERRORS"
 . N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY
 . S XMDUZ=.5
 . S XMSUB=MSG_" - "_STATUS_"."
 . S XMTEXT="^TMP($J,""MGD"","
 . S XMY("DILL.MATT@FORUM.VA.GOV")="",XMY(DUZ)=""
 . S XMY("MCCLARAN.PAM@FORUM.VA.GOV")=""
 . D ^XMD
 ;
 K ^TMP($J),Y,%
 W !!,"Post install routine PRSXP82 completed."
 W !,"Status: ",STATUS_"."
 Q
 ;
ERR1 ; Error message if CENTRAL,PAID already exists
 S ^TMP($J,"MGD",LCNT)=MSG_" CENTRAL,PAID entry already exists."
 S LCNT=LCNT+1
 W !,MSG_" CENTRAL,PAID entry already exists."
 S STA1="ERROR #1 "
 Q
 ;
ERR2 ; Error message if unable to add CENTRAL,PAID entry
 S ^TMP($J,"MGD",LCNT)=MSG_" unable to add CENTRAL,PAID entry."
 S LCNT=LCNT+1
 W !,MSG_" unable to add CENTRAL,PAID entry."
 S STA2=" ERROR #2 "
 Q
 ;
