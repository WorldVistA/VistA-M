PRSXP105 ;WCIOFO/RRG-CORRECT VCS ALLOTMENT ;11/18/2005
 ;;4.0;PAID;**105**;Sep 21, 1995
 ;
 ;
 Q
 ;
 ;
READ ; This module will run as a post install for *105
 ; It will update the read access value and the 
 ; 'Date Last Updated' for 4 fields in #450
 ; 
 F I=758,759,760,761 S ^DD(450,I,8)="FP",^DD(450,I,"DT")=DT
 Q
 ;
 ;
 ; The remainder of this program will correct the formatting
 ;  for the following fields:
 ;
 ; PAID EMPLOYEE (#450)
 ;   #586.1 - VCS ALLOTMENT AMT
 ;
 ; PAID PAYRUN DATA (#459)
 ;   #171 - VCS ALLOTMENT AMT
 ;
DEVICE ;Ask device or queue
 ;
 ;
 W ! K IOP,%ZIS
 S %ZIS("A")="Select Device: ",%ZIS="MQ"
 D ^%ZIS K %ZIS,IOP
 Q:POP
 ;
 I $D(IO("Q")) D  Q
 . S PRSAPGM="START^PRSXP105",XQY0="CORRECT VCS ALLOTTMENT FIELDS",PRSALST=""
 . D QUE^PRSAUTL
 . K PRSAPGM,XQY0,PRSALST,POP
 ;
 ;
START ; Main Driver
 ;
 D 450
 D 459
 I $D(^TMP($J,"LOCKED","P105")) D WARN
 Q
 ;
450 ; Correct data in the PAID EMPLOYEE (#450) file
 ;
 N CNT,DA,DATA,DIE,DR,EMP,LCNT,LINE,LINE2,MESS,MSG,MSG1,LKCNT
 N NAME,PVAL,STANUM,STATUS,TIME,TNAME,U,UCIX,FILE
 S U="^",LCNT=1,$P(LINE,"-",80)="",$P(LINE2,"=",80)="",STATUS="OK"
 K ^TMP($J)
 S MESS="PAID EMPLOYEE (#450)",MSG1=" beginning at "
 D TIME
 D STAUCI
 S ^TMP($J,"P105",LCNT)="",LCNT=LCNT+1
 S MESS="Correcting the VCS ALLOTMENT AMT (#586.1) field."
 S ^TMP($J,"P105",LCNT)=MESS,LCNT=LCNT+1
 S ^TMP($J,"P105",LCNT)="",LCNT=LCNT+1
 S ^TMP($J,"P105",LCNT)=LINE2,LCNT=LCNT+1
 S MESS="                            CURRENT    CORRECTED"
 S ^TMP($J,"P105",LCNT)=MESS,LCNT=LCNT+1
 S MESS="PAID EMPLOYEE (#450)          VALUE    VALUE"
 S ^TMP($J,"P105",LCNT)=MESS,LCNT=LCNT+1
 S ^TMP($J,"P105",LCNT)=LINE,LCNT=LCNT+1
 ;
 ;
 S (EMP,CNT)=0,LKCNT=1,FILE=450
 F  S EMP=$O(^PRSPC(EMP)) Q:'EMP  D
 . S DATA=$$GET1^DIQ(450,EMP,586.1)
 . Q:DATA=""  ; Quit if they don't have any VCS Allotment
 . ; Quit if the value has already been formatted by another download
 . Q:DATA["."
 . D NAME
 . L +^PRSPC(EMP):0
 . I '$T D LOCKED  Q
 . S PVAL=DATA ; Previous value
 . D DD^PRSDUTIL
 . S DR="586.1///^S X=DATA",DA=EMP,DIE=450
 . D ^DIE
 . L -^PRSPC(EMP)
 . S CNT=CNT+1
 . S MESS=NAME,$E(MESS,31,35)=PVAL,$E(MESS,40,46)=DATA
 . S ^TMP($J,"P105",LCNT)=MESS,LCNT=LCNT+1
 S ^TMP($J,"P105",LCNT)="",LCNT=LCNT+1
 S ^TMP($J,"P105",LCNT)=LINE,LCNT=LCNT+1
 S ^TMP($J,"P105",LCNT)="",LCNT=LCNT+1
 S MESS=$S(CNT>0:CNT_" employee(s) corrected.",1:"No records to correct")
 S ^TMP($J,"P105",LCNT)=MESS,LCNT=LCNT+1
 I STATUS="Check" D
 . S ^TMP($J,"P105",LCNT)="",LCNT=LCNT+1
 . S ^TMP($J,"P105",LCNT)=LKCNT_" Employee record(s) were locked."
 . S ^TMP($J,"P105",LCNT)="",LCNT=LCNT+1
 S ^TMP($J,"P105",LCNT)="",LCNT=LCNT+1
 S MESS="PAID EMPLOYEE (#450)",MSG1=" ending at "
 D TIME
 S ^TMP($J,"P105",LCNT)="",LCNT=LCNT+1
 S STATUS="OK",MSG=MSG_"450 "_STATUS
 D XMT
 Q
 ;
 ;
459 ; Correct data in the PAID PAYRUN DATA (#459) file
 ;
 N CNT,DATA,EMP,I,IENS,LCNT,LINE,MESS,MSG
 N NAME,PPE,PPI,PPIEN,PRSFDA,PVAL,STANUM,STATUS,TIME,TNAME,U,UCIX,FILE
 S U="^",LCNT=1,$P(LINE,"-",80)="",$P(LINE2,"=",80)="",STATUS="OK",FILE=459
 K ^TMP($J,"P105")
 S MESS="PAID PAYRUN DATA (#459)",MSG1=" beginning at "
 D TIME
 D STAUCI
 S ^TMP($J,"P105",LCNT)="",LCNT=LCNT+1
 S MESS="Correcting the VCS ALLOTMENT AMT (#171) field of the"
 S ^TMP($J,"P105",LCNT)=MESS,LCNT=LCNT+1
 S MESS="EMPLOYEE (#459.01) multiple."
 S ^TMP($J,"P105",LCNT)=MESS,LCNT=LCNT+1
 S ^TMP($J,"P105",LCNT)="",LCNT=LCNT+1
 S PPI="03-10"
 F  S PPIEN="",PPI=$O(^PRST(459,"B",PPI)) Q:'PPI!(PPI>"07-20")  D
 . S PPIEN=$O(^PRST(459,"B",PPI,0)) Q:'PPIEN
 . S PPE=$P(^PRST(459,PPIEN,0),"^")
 . S ^TMP($J,"P105",LCNT)="",LCNT=LCNT+1
 . S ^TMP($J,"P105",LCNT)="",LCNT=LCNT+1
 . S ^TMP($J,"P105",LCNT)="Pay Period "_PPE,LCNT=LCNT+1
 . S ^TMP($J,"P105",LCNT)=LINE2,LCNT=LCNT+1
 . S MESS="                             CURRENT   CORRECTED"
 . S ^TMP($J,"P105",LCNT)=MESS,LCNT=LCNT+1
 . S MESS="PAID PAYRUN DATA (#459)        VALUE   VALUE"
 . S ^TMP($J,"P105",LCNT)=MESS,LCNT=LCNT+1
 . S ^TMP($J,"P105",LCNT)=LINE,LCNT=LCNT+1
 . S (CNT,EMP)=0
 . F  S EMP=$O(^PRST(459,PPIEN,"P",EMP)) Q:'EMP  D
 . . S IENS=EMP_","_PPIEN_","
 . . S DATA=$$GET1^DIQ(459.01,IENS,171)
 . . Q:DATA=""  ; Quit if they don't have any VCS Allotment
 . . ; Quit if the value has already been formatted by another download
 . . Q:DATA["."
 . . D NAME
 . . L +^PRST(459,PPIEN,"P",EMP):0
 . . I '$T D LOCKED Q
 . . S PVAL=DATA
 . . D DD^PRSDUTIL
 . . S IENS=EMP_","_PPIEN_",",PRSFDA(459.01,IENS,171)=DATA
 . . D FILE^DIE("","PRSFDA") ; Correct data
 . . S CNT=CNT+1
 . . L -^PRST(459,PPIEN,"P",EMP)
 . . S $E(NAME,1,$L(TNAME))=TNAME,$E(NAME,31,35)=PVAL,$E(NAME,40,46)=DATA
 . . S ^TMP($J,"P105",LCNT)=NAME,LCNT=LCNT+1
 . S MESS=$S(CNT>0:CNT_" employee(s) corrected.",1:"No records to correct")
 . S ^TMP($J,"P105",LCNT)="",LCNT=LCNT+1
 . S ^TMP($J,"P105",LCNT)=MESS,LCNT=LCNT+1
 . S ^TMP($J,"P105",LCNT)="",LCNT=LCNT+1
 . I STATUS="Check" D
 . . S ^TMP($J,"P105",LCNT)="",LCNT=LCNT+1
 . . S ^TMP($J,"P105",LCNT)=LKCNT_" Employee record(s) were locked."
 . . S ^TMP($J,"P105",LCNT)="",LCNT=LCNT+1
 S MESS="PAID PAYRUN DATA (#459)",MSG1=" ending at "
 D TIME
 S STATUS="OK",MSG=MSG_"459 "_STATUS
 D XMT
 Q
 ;
XMT ; Send status via mail message
 ;
 I $D(^TMP($J,"P105")) D
 . N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY
 . S XMDUZ=.5
 . S XMSUB=MSG
 . S XMTEXT="^TMP($J,""P105"","
 . S XMY(DUZ)=""
 . S XMY("G.PAD@"_^XMB("NETNAME"))=""
 . D ^XMD
 ;
 K ^TMP($J,"P105"),Y,%
 Q
 ;
TIME ; Get current Time
 ;
 D NOW^%DTC
 S Y=%
 D DD^%DT
 S TIME=Y
 S MESS=MESS_" clean up routine"_MSG1_TIME_"."
 S ^TMP($J,"P105",LCNT)=MESS,LCNT=LCNT+1
 Q
 ;
 ; Get Station Number
 ;
STAUCI S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 S MSG=STANUM_" - "
 ;
 ; Check for UCI,VOL
 ;
 X ^%ZOSF("UCI")
 S UCIX=$G(Y)
 I UCIX="" S UCIX="??????"
 S MSG=MSG_UCIX_" - "
 Q
 ;
NAME ; Format name
 ;
 S NAME="",$P(NAME," ",30)=""
 S TNAME=$$GET1^DIQ(450,EMP,.01)
 I TNAME="" S TNAME=EMP
 S $E(NAME,1,$L(TNAME))=TNAME
 Q
 ;
LOCKED ; Message for locked records
 ;
 S MESS=NAME_" record was locked in file # "_FILE
 S ^TMP($J,"LOCKED","P105",LKCNT)=MESS,LKCNT=LKCNT+1
 S STATUS="Check"
 Q
 ;
WARN ; Warning message if records were locked
 ;
 S ^TMP($J,"LOCKED","P105",LKCNT)="",LKCNT=LKCNT+1
 S ^TMP($J,"LOCKED","P105",LKCNT)="These records were locked.",LKCNT=LKCNT+1
 S ^TMP($J,"LOCKED","P105",LKCNT)="Contact NVS @ 888-596-4357",LKCNT=LKCNT+1
 ;
 I $D(^TMP($J,"LOCKED","P105")) D
 . N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY
 . S XMDUZ=.5
 . S XMSUB="Locked records - PRS*4*105"
 . S XMTEXT="^TMP($J,""LOCKED"",""P105"","
 . S XMY(DUZ)=""
 . S XMY("G.PAD@"_^XMB("NETNAME"))=""
 . D ^XMD
 ;
 K ^TMP($J,"LOCKED","P105"),Y,%
 Q
 ;
