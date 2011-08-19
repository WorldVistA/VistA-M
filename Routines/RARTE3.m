RARTE3 ;HISC/GJC-Create a skeletal report, store in Error Reports multiple ;2/4/97  09:39
 ;;5.0;Radiology/Nuclear Medicine;**31,56**;Mar 16, 1998;Build 3
 ;Supported IA #10103 NOW^XLFDT
 ;Supported IA #2053 UPDATE^DIE
 ; This routine will be accessed when the user unverifies a report.
 ; At this time, a skeletal copy of the report will be stored off
 ; in the 'Error Reports' multiple.  This will keep track of report
 ; addendums.
EN1(RADA) ; Create the 'Error Reports' sub-record.
 ; Input: 'RADA': IEN of the report in file 74.
 ; Create the record, enter when the report was unverified.
 Q:'($D(^TMP($J,"RA AUTOE"))\10)
 N RACNT,RAIEN,RANEW,RANOW,X S RANOW=$$NOW^XLFDT()
 S RANEW(74.06,"+1,"_RADA_",",.01)=RANOW
 D UPDATE^DIE("","RANEW","RAIEN","")
 ; Error Report date/time field created, now the skeletal report text
 S RADA(1)=RADA,RADA=+$G(RAIEN(1)) Q:'RADA  ; sub-file ien not created
 S RACNT=+$O(^TMP($J,"RA AUTOE",999999999999),-1)
 D ZERO K ^TMP($J,"RA AUTOE")
 Q
ZERO ; setup the ^TMP($J,"RA AUTOE" global with a zero node
 S ^RARPT(RADA(1),"ERR",RADA,"RPT",0)="^^"_RACNT_"^"_RACNT_"^"_(RANOW\1)_"^"
 N I S I=0
 F  S I=$O(^TMP($J,"RA AUTOE",I)) Q:I'>0  D
 . S ^RARPT(RADA(1),"ERR",RADA,"RPT",I,0)=$G(^TMP($J,"RA AUTOE",I))
 . Q
 Q
CHK17 ; called from routine RARTE1
 ; check 17th piece of exam with same pat/dttm/longcn
 ; values of RAOK:
 ; 1 = unknown case no. or unknown case ien, CAN'T DELETE REPORT
 ; 2 = exm doesn't point to this rpt, CAN DELETE BUT NOT UPGRADE EXM STAT
 ; 3 = all okay
 S RAOK=3
 S RADFN=+$P(RA0,"^",2),RADTI=9999999.9999-$P(RA0,"^",3)
 S RACN=$P($P(RA0,"^"),"-",2) ;get from longcase no.'s 2nd part
 I RACN="" D WARN1,PRESS Q
 S RACNI=+$O(^RADPT(RADFN,"DT",RADTI,"P","B",RACN,0))
 I 'RACNI D WARN1,PRESS Q
 I $P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),"^",17)'=RAIEN D WARN2,PRESS
 Q
WARN1 W !!?3,"** Cannot determine internal or external case number. **"
 W !!?3,"** You may NOT delete this report. **"
 S RAOK=1
 Q
WARN2 W !!?3,"** This report refers to an exam that isn't pointing back to this report. **"
 S RAOK=2
WARNQ W !!?3,"** You may delete this report if it is indeed the report you don't want. **"
 W !?3,"** Or call IRM for help. **"
 Q
PRESS R !!?5,"Press RETURN to continue. ",X:DTIME
 Q
