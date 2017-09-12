PRSXP84 ;WCIOFO/MGD-CORRECT ERRONEOUS DATA IN 459 ;07/25/2003
 ;;4.0;PAID;**84**;Sep 21, 1995
 ;
 Q
 ;
 ; This routine will correct erroneous data in the PAID PAYRUN DATA
 ; (#459) file for Pay Periods 03-06, 03-07 and 03-08.
 ; The following fields in the EMPLOYEE (#459.01) multiple will be
 ; updated:
 ;          GRADE  (#3)
 ;          STEP   (#4)
 ;          SALARY (#13)
 ;
 ; For more details see the patch description on FORUM.
 ;
START ; Main Driver
 ;
 K ^TMP($J),TMP
 N D0305,D0306,D0307,D0308,D450,DA,DB,DIK,DR,EMP,EMPX,FLSA
 N GRD05,GRD06,GRD07,GRD08,GRADE,IEN05,IEN06,IEN07,IEN08
 N LCNT,MCNT,MESS,MESS1,NAME,PDATE,PP,STP05,STP06,STP07,STP08
 N SAL05,SAL06,SAL07,SAL08,SALARY,SD,SSN,STANUM,STEP
 N TCNT,TIME,TMP,U,UCIX,XMSUB
 S U="^",(DA,LCNT,TCNT)=0,MCNT=1
 D NOW^%DTC
 S Y=%
 D DD^%DT
 S TIME=Y
 W !!,"Post install routine PRSXP84 beginning at ",TIME_"."
 ;
 ; Get Station Number
 ;
 S STANUM=$$KSP^XUPARAM("INST")_","
 S STANUM=$$GET1^DIQ(4,STANUM,99)
 S MESS1="Station: "_STANUM_" - "
 ;
 ; Check for UCI,VOL
 ;
 X ^%ZOSF("UCI")
 S UCIX=$G(Y)
 I UCIX=""!(UCIX'?3U1","3U) S UCIX="???,???"
 S MESS1=MESS1_UCIX_" - "
 ;
 ; Find IENs for Pay Periods in the PAID PAYRUN DATA (#459) file
 ;
 S (IEN05,IEN06,IEN07,IEN08)=""
 S IEN05=$O(^PRST(459,"B","03-05",IEN05))
 S IEN06=$O(^PRST(459,"B","03-06",IEN06))
 S IEN07=$O(^PRST(459,"B","03-07",IEN07))
 S IEN08=$O(^PRST(459,"B","03-08",IEN08))
 I IEN05'>0!(IEN06'>0)!(IEN07'>0)!(IEN08'>0) D  Q
 . I IEN05'>0 D
 . .S ^TMP($J,"MGD",MCNT)=MESS1_"PP 03-05 Not Found"
 . .S MCNT=MCNT+1
 . I IEN06'>0 D
 . .S ^TMP($J,"MGD",MCNT)=MESS1_"PP 03-06 Not Found"
 . .S MCNT=MCNT+1
 . I IEN07'>0 D
 . .S ^TMP($J,"MGD",MCNT)=MESS1_"PP 03-07 Not Found"
 . .S MCNT=MCNT+1
 . I IEN08'>0 D
 . .S ^TMP($J,"MGD",MCNT)=MESS1_"PP 03-08 Not Found"
 . D XMT
 ;
 ; Loop through employees
 ;
 S EMP=0
 F  S EMP=$O(^PRSPC(EMP)) Q:'EMP  D
 . ;
 . ; Quit if the employee is separated
 . ;
 . Q:$P($G(^PRSPC(EMP,1)),U,1)="Y"
 . ;
 . S D450=$G(^PRSPC(EMP,0))
 . Q:D450=""
 . S PDATE=$P(D450,U,28)
 . ;
06 . ; Check for employees who received a promotion in PP 03-06
 . ;
 . I PDATE>3030322&(PDATE<3030406) D  Q
 . . S TCNT=TCNT+1
 . . D RPT
 . . S MESS="PP 03-05"_$J(SAL05,10)_$J(GRD05,6)_$J(STP05,7)
 . . S ^TMP($J,"MGD",MCNT)=MESS
 . . S MCNT=MCNT+1
 . . ;
 . . S MESS="PP 03-06"_$J(SAL06,10)_$J(GRD06,6)_$J(STP06,7)
 . . I SAL06'=SALARY!(GRD06'=GRADE)!(STP06'=STEP) D
 . . . S MESS=MESS_$J(SALARY,19)_$J(GRADE,6)_$J(STEP,7)
 . . S ^TMP($J,"MGD",MCNT)=MESS
 . . S MCNT=MCNT+1
 . . S DR="3////^S X=GRADE",DIE="^PRST(459,IEN06,""P"",",DA=EMP
 . . L +^PRST(459,IEN06,"P",EMP):0 I $T D ^DIE
 . . S DR="4////^S X=STEP",DIE="^PRST(459,IEN06,""P"",",DA=EMP D ^DIE
 . . S DR="13////^S X=SALARY",DIE="^PRST(459,IEN06,""P"",",DA=EMP D ^DIE
 . . L -^PRST(459,IEN06,"P",EMP)
 . . ;
 . . S MESS="PP 03-07"_$J(SAL07,10)_$J(GRD07,6)_$J(STP07,7)
 . . I SAL07'=SALARY!(GRD07'=GRADE)!(STP07'=STEP) D
 . . . S MESS=MESS_$J(SALARY,19)_$J(GRADE,6)_$J(STEP,7)
 . . S ^TMP($J,"MGD",MCNT)=MESS
 . . S MCNT=MCNT+1
 . . S DR="3////^S X=GRADE",DIE="^PRST(459,IEN07,""P"",",DA=EMP
 . . L +^PRST(459,IEN07,"P",EMP):0 I $T D ^DIE
 . . S DR="4////^S X=STEP",DIE="^PRST(459,IEN07,""P"",",DA=EMP D ^DIE
 . . S DR="13////^S X=SALARY",DIE="^PRST(459,IEN07,""P"",",DA=EMP D ^DIE
 . . L -^PRST(459,IEN07,"P",EMP)
 . . ;
 . . S MESS="PP 03-08"_$J(SAL08,10)_$J(GRD08,6)_$J(STP08,7)
 . . I SAL08'=SALARY!(GRD08'=GRADE)!(STP08'=STEP) D
 . . . S MESS=MESS_$J(SALARY,19)_$J(GRADE,6)_$J(STEP,7)
 . . S ^TMP($J,"MGD",MCNT)=MESS
 . . S MCNT=MCNT+1
 . . S DR="3////^S X=GRADE",DIE="^PRST(459,IEN08,""P"",",DA=EMP
 . . L +^PRST(459,IEN08,"P",EMP):0 I $T D ^DIE
 . . S DR="4////^S X=STEP",DIE="^PRST(459,IEN08,""P"",",DA=EMP D ^DIE
 . . S DR="13////^S X=SALARY",DIE="^PRST(459,IEN08,""P"",",DA=EMP D ^DIE
 . . L -^PRST(459,IEN08,"P",EMP)
 . . ;
 . . S ^TMP($J,"MGD",MCNT)="  IN 450"_$J(SALARY,10)_$J(GRADE,6)_$J(STEP,7)
 . . S MCNT=MCNT+1
 . . S ^TMP($J,"MGD",MCNT)=""
 . . S MCNT=MCNT+1
 . . ;
07 . . ; Check for employees who received a promotion in PP 03-07
 . . ;
 . I PDATE>3030405&(PDATE<3030420) D  Q
 . . ;
 . . ; Load data from PP 03-05
 . . ;
 . . S TCNT=TCNT+1
 . . D RPT
 . . S MESS="PP 03-05"_$J(SAL05,10)_$J(GRD05,6)_$J(STP05,7)
 . . S ^TMP($J,"MGD",MCNT)=MESS
 . . S MCNT=MCNT+1
 . . ;
 . . S MESS="PP 03-06"_$J(SAL06,10)_$J(GRD06,6)_$J(STP06,7)
 . . I SAL06'=SAL05!(GRD06'=GRD05)!(STP06'=STP05) D
 . . . S MESS=MESS_$J(SAL05,19)_$J(GRD05,6)_$J(STP05,7)
 . . S ^TMP($J,"MGD",MCNT)=MESS
 . . S MCNT=MCNT+1
 . . S DR="3////^S X=GRD05",DIE="^PRST(459,IEN06,""P"",",DA=EMP
 . . L +^PRST(459,IEN06,"P",EMP):0 I $T D ^DIE
 . . S DR="4////^S X=STP05",DIE="^PRST(459,IEN06,""P"",",DA=EMP D ^DIE
 . . S DR="13////^S X=SAL05",DIE="^PRST(459,IEN06,""P"",",DA=EMP D ^DIE
 . . L -^PRST(459,IEN06,"P",EMP)
 . . ;
 . . S MESS="PP 03-07"_$J(SAL07,10)_$J(GRD07,6)_$J(STP07,7)
 . . I SAL07'=SALARY!(GRD07'=GRADE)!(STP07'=STEP) D
 . . . S MESS=MESS_$J(SALARY,19)_$J(GRADE,6)_$J(STEP,7)
 . . S ^TMP($J,"MGD",MCNT)=MESS
 . . S MCNT=MCNT+1
 . . S DR="3////^S X=GRADE",DIE="^PRST(459,IEN07,""P"",",DA=EMP
 . . L +^PRST(459,IEN07,"P",EMP):0 I $T D ^DIE
 . . S DR="4////^S X=STEP",DIE="^PRST(459,IEN07,""P"",",DA=EMP D ^DIE
 . . S DR="13////^S X=SALARY",DIE="^PRST(459,IEN07,""P"",",DA=EMP D ^DIE
 . . L -^PRST(459,IEN07,"P",EMP)
 . . ;
 . . S MESS="PP 03-08"_$J(SAL08,10)_$J(GRD08,6)_$J(STP08,7)
 . . I SAL08'=SALARY!(GRD08'=GRADE)!(STP08'=STEP) D
 . . . S MESS=MESS_$J(SALARY,19)_$J(GRADE,6)_$J(STEP,7)
 . . S ^TMP($J,"MGD",MCNT)=MESS
 . . S MCNT=MCNT+1
 . . S DR="3////^S X=GRADE",DIE="^PRST(459,IEN08,""P"",",DA=EMP
 . . L +^PRST(459,IEN08,"P",EMP):0 I $T D ^DIE
 . . S DR="4////^S X=STEP",DIE="^PRST(459,IEN08,""P"",",DA=EMP D ^DIE
 . . S DR="13////^S X=SALARY",DIE="^PRST(459,IEN08,""P"",",DA=EMP D ^DIE
 . . L -^PRST(459,IEN08,"P",EMP)
 . . S ^TMP($J,"MGD",MCNT)="  IN 450"_$J(SALARY,10)_$J(GRADE,6)_$J(STEP,7)
 . . S MCNT=MCNT+1
 . . S ^TMP($J,"MGD",MCNT)=""
 . . S MCNT=MCNT+1
 ;
 D XMT
 K DIE
 Q
 ;
XMT ; Send status via mail message
 ;
 I $D(^TMP($J,"MGD")) D
 . N DIFROM,XMDUZ,XMTEXT,XMY
 . S XMDUZ=.5
 . S XMTEXT="^TMP($J,""MGD"","
 . S XMSUB=MESS1_"SALARY, GRADE & STEP CLEANUP"
 . S XMY("DILL.MATT@DOMAIN.EXT")="",XMY(DUZ)=""
 . S XMY("MCCLARAN.PAM@DOMAIN.EXT")=""
 . D ^XMD
 ;
 K ^TMP($J),Y,%
 D NOW^%DTC
 S Y=%
 D DD^%DT
 S TIME=Y
 W !!,"Post install routine PRSXP84 completed at ",TIME_"."
 W !,TCNT," Employees were updated."
 Q
 ;
RPT ; 
 ;
 S GRADE=$P(D450,U,14),STEP=$P(D450,U,39),SALARY=$P(D450,U,29)
 S DB=$P(D450,U,10),FLSA=$P(D450,U,12),PP=$P(D450,U,21)
 S SSN=$E($P(D450,U,9),6,9),EMPX="         "
 S NAME=$P($P(D450,U,1),",",1)_","_$E($P($P(D450,U,1),",",2))
 ;
 S D0305=$G(^PRST(459,IEN05,"P",EMP,0))
 S D0306=$G(^PRST(459,IEN06,"P",EMP,0))
 S D0307=$G(^PRST(459,IEN07,"P",EMP,0))
 S D0308=$G(^PRST(459,IEN08,"P",EMP,0))
 ;
 S SAL05=$P(D0305,U,14),GRD05=$P(D0305,U,4),STP05=$P(D0305,U,5)
 S SAL06=$P(D0306,U,14),GRD06=$P(D0306,U,4),STP06=$P(D0306,U,5)
 S SAL07=$P(D0307,U,14),GRD07=$P(D0307,U,4),STP07=$P(D0307,U,5)
 S SAL08=$P(D0308,U,14),GRD08=$P(D0308,U,4),STP08=$P(D0308,U,5)
 S SD=""
 I PDATE>3030322&(PDATE<3030406) S SD="PP 03-06"
 I PDATE>3030405&(PDATE<3030420) S SD="PP 03-07"
 S Y=PDATE
 D DD^%DT
 S PDATE=Y
 S $E(EMPX,1,$L(EMP))=EMP
 S MESS=NAME_" ID: "_SSN_"  IEN: "_EMPX_"  Salary date: "_PDATE_" - "_SD
 S ^TMP($J,"MGD",MCNT)=MESS
 S MCNT=MCNT+1
 S MESS="Pay Plan: "_PP_"    Duty Basis: "_DB_"  FLSA: "_FLSA
 S ^TMP($J,"MGD",MCNT)=MESS
 S MCNT=MCNT+1
 S MESS="Pay Period  Salary   Grade  Step  Corrected Salary   Grade  Step"
 S ^TMP($J,"MGD",MCNT)=MESS
 S MCNT=MCNT+1
 Q
