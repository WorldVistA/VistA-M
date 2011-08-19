SROANEST ;BIR/TJH - ANESTHESIA ENTRY ;01 Jun 2003
 ;;3.0;Surgery;**119,150,152**;24 Jun 93
SINPUT ;
 N SRSTART
 S Z=$E($P(^SRF($S($D(SRTN):SRTN,1:DA(1)),0),"^",9),1,7),X=$S(X?1.4N.A!(X?1.2N1":"2N.A):Z_"@"_X,1:X) K %DT,Z S %DT="RTX" D ^%DT S X=Y K:Y<1 X
 I '$D(X),$G(SRFLAG)=1 D  K SRFLAG Q
 .W !!,"Check date format.",!,"     Examples of Valid Dates:",!,"       JAN 20 1957 or 20 JAN 57 or 1/20/57 or 012057",!,"       T   (for TODAY),  T+1 (for TOMORROW),  T+2,  T+7,  etc."
 .W !,"       T-1 (for YESTERDAY),  T-3W (for 3 WEEKS AGO), etc.",!,"     If the year is omitted, the computer uses CURRENT YEAR.  Two digit year"
 .W !,"       assumes no more than 20 years in the future, or 80 years in the past.",!,"     If only the time is entered, the current date is assumed."
 .W !,"     Follow the date with a time, such as JAN 20@10, T@10AM, 10:30, etc.",!,"     You may enter a time, such as NOON, MIDNIGHT or NOW."
 .W !,"     You may enter   NOW+3'  (for current date and time Plus 3 minutes",!,"       *Note--the Apostrophe following the number of minutes)"
 .W !,"     Time is REQUIRED in this response.",!,"     Enter the time a member of the Anesthesia staff begins preparing the",!,"     patient for surgery in the O.R. suite or if the care is interrupted, the"
 .W !,"     time the care resumes."
 Q:'$D(X)
 S SRSTART=$P($G(^SRF($S($D(SRTN):SRTN,1:DA(1)),.2)),"^",15)
 I SRSTART="" K SRFLAG Q
 I X<SRSTART W !!,"The time entered is before the 'TIME PAT IN HOLD AREA'.  Please check the",!,"DATE/TIME entered for this field." H 2
 K SRFLAG
 Q
STIME ;
 I '$D(X) Q
 N SRSPREC,SRPET,SRTIME,SRCRET
 S SRCRET=$$GET1^DIQ(130.213,DA(2)_","_DA(1)_",",1,"I")
 I SRCRET,(X>SRCRET) W !!,"Start time is after current end time. Please correct." K X Q
 S SRSPREC=$O(^SRF(DA(1),50,DA(2)),-1)
 I SRSPREC'=0 D
 .S SRPET=$$GET1^DIQ(130.213,SRSPREC_","_DA(1)_",",1,"I")
 .I SRPET="" W !!,"New start time entry not permitted until previous end time is entered." K X Q
 .I SRPET>X W !!,"Start time is prior to previous end time. Please correct." K X
 I $D(X),(DA(2)=1) S SRTIME(130,DA(1)_",",.21)=X D FILE^DIE("","SRTIME","^TMP(""SR"",$J)")
 Q
FINALT  ;
 N SRCST,SRLET,SRYN,SRSNREC,SRFDA,SRTIME,SRLREC,SRCON
 I $D(^SRF(DA(1),"CON")),$P(^("CON"),"^") S SRCON=$P(^SRF(DA(1),"CON"),"^")
 S SRCST=$$GET1^DIQ(130.213,DA(2)_","_DA(1)_",",.01,"I")
 I X<SRCST W !!,"End time prior to start time.  Please correct." K X Q
 S SRSNREC=$O(^SRF(DA(1),50,DA(2)))
 I SRSNREC'="B" Q
ASK W !!,"Does this entry complete all start and end times for this case?  (Y/N)//  " R SRYN:DTIME I '$T!(SRYN["^") S SRYN="N" Q
 S SRYN=$E(SRYN) I "YyNn?"'[SRYN W !,"Invalid response, please enter Yes or No. Use ? for help." G ASK
 I "?"[SRYN D HELP G ASK
 I ("Nn"[SRYN) S SRFDA(130,DA(1)_",",.214)="@" D FILE^DIE("","SRFDA","^TMP(""SR"",$J)") K SRFDA Q
 D CHKTIME
 I SRAFLAG=1 K SRAFLAG Q
 S SRLREC=$O(^SRF(DA(1),50,"B"),-1)
 I SRLREC'=DA(2) S SRLET=$$GET1^DIQ(130.213,SRLREC_","_DA(1)_",",1,"I")
 I SRLREC=DA(2) S SRLET=X
 S SRTIME(130,DA(1)_",",.24)=SRLET,SRTIME(130,DA(1)_",",.214)="1" D FILE^DIE("","SRTIME","^TMP(""SR"",$J)")
 K SRAFLAG
 Q:'$D(SRCON)
ASK2 ;
 W !,"Does this entry complete all start and end times for the concurrent",!,"case? (Y/N)//  " R SRYN:DTIME I '$T!(SRYN["^") S SRYN="N" Q
 I "?"[SRYN D HELP^SROCON D HELP G ASK2
 S SRYN=$E(SRYN) I "YyNn"'[SRYN W !,"Invalid response, please enter Yes or No. Use ? for help." G ASK2
 I ("Nn"[SRYN),(($P(^SRF(SRCON,.2),"^",17)=1)) S SRFDA(130,SRCON_",",.214)="@" D FILE^DIE("","SRFDA","^TMP(""SR"",$J)") K SRFDA Q
 S SRTIME(130,SRCON_",",.214)="1" D FILE^DIE("","SRTIME","^TMP(""SR"",$J)")
 Q
CHKTIME ;  verify blocks of time are valid
 N SRSREC,SRCST,SRCET,SRAFLAG1,SRSNREC,SRNST,SRLREC
 S SRAFLAG=0,SRSREC=0,SRAFLAG1=0
 F  S SRSREC=$O(^SRF(DA(1),50,SRSREC)) Q:'SRSREC!(SRAFLAG1=1)  D 
 .S SRCST=$$GET1^DIQ(130.213,SRSREC_","_DA(1)_",",.01,"I"),SRCET=$$GET1^DIQ(130.213,SRSREC_","_DA(1)_",",1,"I")
 .S SRLREC=$O(^SRF(DA(1),50,"B"),-1)
 .I (SRCET=""),(SRSREC'=SRLREC) W !!,"One or more time entries missing end time.  Please correct." S SRAFLAG=1,SRAFLAG1=1 Q
 .S SRSNREC=$O(^SRF(DA(1),50,SRSREC))
 .I SRSNREC="B" S SRAFLAG1=1 Q
 .S SRNST=$$GET1^DIQ(130.213,SRSNREC_","_DA(1)_",",.01,"I")
 .I SRNST<SRCET W !!,"Some time entries overlap.  Please correct." S SRAFLAG=1,SRAFLAG1=1 Q
 Q
CSET ;  caled by set xref of mult anes start and end times used for concurrent case anes field stuffing
 N SRSREC,SRCST,SRCET,SRTIME
 I $$GET1^DIQ(130,DA(1),.214,"I")'=1 Q
 S SRSREC=0
 F  S SRSREC=$O(^SRF(DA(1),50,SRSREC)) Q:'SRSREC  D
 .S:'$D(SRCST) SRCST=$$GET1^DIQ(130.213,SRSREC_","_DA(1)_",",.01,"I")
 .S SRCET=$$GET1^DIQ(130.213,SRSREC_","_DA(1)_",",1,"I")
 S SRTIME(130,DA(1)_",",.24)=SRCET,SRTIME(130,DA(1)_",",.21)=SRCST D FILE^DIE("","SRTIME","^TMP(""SR"",$J)")
 Q
DEL ; called by kill xref of mult anes start and end times
 I '$D(DA(2)) Q
 I (DA(2)=1),(D=.01) S SRFDA(130,DA(1)_",",.21)="@" D FILE^DIE("","SRFDA","^TMP(""SR"",$J)") K SRFDA
 I ($O(^SRF(DA(1),50,DA(2)))="B"),(D=1) S SRFDA(130,DA(1)_",",.24)="@",SRFDA(130,DA(1)_",",.214)="@" D FILE^DIE("","SRFDA","^TMP(""SR"",$J)") K SRFDA
 Q
HELP ;
 W !,"Enter ""Y"" only if the block of time entered is the final block of time for"
 W !,"this case.  If the block of time is not the final block, enter ""N""."
 Q
BILLTIME() ;  calculate total minutes for mult anes start and end times
 N SRSREC,SRCST,SRCET,SRTTIME
 S SRSREC=0,SRTTIME=0
 I $$GET1^DIQ(130,D0,.214,"I")'=1 Q SRTTIME
 I '$D(^SRF(D0,50)) Q SRTTIME
 F  S SRSREC=$O(^SRF(D0,50,SRSREC)) Q:'SRSREC  D
 .S SRCST=$$GET1^DIQ(130.213,SRSREC_","_D0_",",.01,"I"),SRCET=$$GET1^DIQ(130.213,SRSREC_","_D0_",",1,"I")
 .D CALC
 Q SRTTIME
CALC ; calculate minutes between start and end times
 N SRETH,SRDHRS,SRSHR,SREHR,SRSMN,SREMN,SRSTH,X1,X2,Y,%H
 S X1=SRCST,X2=0 D C^%DTC S SRSTH=%H
 S X1=SRCET,X2=0 D C^%DTC S SRETH=%H
 S SRDHRS=(SRETH-SRSTH)*24
 S SRSHR=$E(($P(SRCST_"0",".",2)),1,2)
 S SREHR=$E(($P(SRCET_"0",".",2)),1,2)
 I SREHR<SRSHR S SREHR=SREHR+24,SRDHRS=SRDHRS-24
 S SRSMN=$E(($P(SRCST_"00",".",2)),3,4)
 S SREMN=$E(($P(SRCET_"00",".",2)),3,4)
 I SREMN<SRSMN S SREMN=SREMN+60,SREHR=SREHR-1
 S Y=(SRDHRS*60)+((SREHR-SRSHR)*60)+(SREMN-SRSMN)
 S SRTTIME=SRTTIME+Y
 Q
ANESTIME(SRDFN,SRFDATE,SRTDATE) ; API to return multiple anesthesia records and times
 N SRCASE,SRREC,SRCNT,SRNON,SRX,SRDATE,SRRES,SRSC,SRCV,SRQO,SRIR,SREC,SRMST,SRHNC,SRAO,SRSREC,SRCST,SRCET,SRTTIME,SR,SRDIAG,SRSHAD
 S (SRREC,SRCNT,SRRES)=0
 I '$D(SRDFN)!'$D(SRFDATE) Q -1
 I '$D(SRTDATE) S SRTDATE=SRFDATE
 I '$D(^SRF("B",SRDFN)) Q 0
 S SRFDATE=$P(SRFDATE,"."),SRTDATE=$P(SRTDATE,".")
 F  S SRREC=$O(^SRF("B",SRDFN,SRREC)) Q:'SRREC  S SRCNT=SRCNT+1,SRCASE(SRCNT)=SRREC
 S SRREC=0
 F  S SRREC=$O(SRCASE(SRREC)) Q:'SRREC  D
 .S SRCASE=SRCASE(SRREC)
 .S SRNON=$S($P($G(^SRF(SRCASE,"NON")),"^")="Y":1,1:0)
 .I 'SRNON S SRX=$G(^SRF(SRCASE,.2)),SRDATE=$P(SRX,"^",10)
 .I SRNON S SRX=$G(^SRF(SRCASE,"NON")),SRDATE=$P(SRX,"^",4)
 .S SRDATE=$P(SRDATE,".")
 .I (SRDATE<SRFDATE)!(SRDATE>SRTDATE) K SRCASE(SRREC) Q
 S SRREC=0
 F  S SRREC=$O(SRCASE(SRREC)) Q:'SRREC  D
 .S SRCASE=SRCASE(SRREC)
 .I $$GET1^DIQ(130,SRCASE,.214,"I")'=1 S SRRES=-2 Q
 .S SRDIAG=$P($G(^SRO(136,SRCASE,0)),"^",3)
 .I 'SRDIAG S SRDIAG=$P($G(^SRF(SRCASE,34)),"^",2)
 .S (SRAO,SREC,SRHNC,SRIR,SRMST,SRSHAD)=0
 .S SR(0)=$G(^SRF(SRCASE,0))
 .S SRSC=$P(SR(0),"^",16),SRAO=$P(SR(0),"^",17),SRIR=$P(SR(0),"^",18),SREC=$P(SR(0),"^",19),SRMST=$P(SR(0),"^",22),SRHNC=$P(SR(0),"^",23),SRCV=$P(SR(0),"^",24),SRSHAD=$P(SR(0),"^",25)
 .I '$D(^SRF(SRCASE,50)) S:SRRES'=1 SRRES=-2 Q
 .S SRRES=1,SRREC=0
 .F  S SRREC=$O(^SRF(SRCASE,50,SRREC)) Q:(SRREC="B")!(SRREC="")  D
 ..S SRCST=$$GET1^DIQ(130.213,SRREC_","_SRCASE_",",.01,"I"),SRCET=$$GET1^DIQ(130.213,SRREC_","_SRCASE_",",1,"I")
 ..I 'SRCET K ^TMP("SRANES",$J,SRCASE) S SRRES=-2,SRREC="" Q
 ..S SRTTIME=0 D CALC
 ..S ^TMP("SRANES",$J,SRCASE,SRCST,SRCET)=SRDFN_"^"_SRTTIME_"^"_SRDIAG_"^"_SRSC_"^"_SRCV_"^"_SRAO_"^"_SRIR_"^"_SREC_"^"_SRMST_"^"_SRHNC_"^"_SRSHAD
 Q SRRES
