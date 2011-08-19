ABSVMVV2 ;OAKLANDFO/DPC-VSS MIGRATION;7/18/2002
 ;;4.0;VOLUNTARY TIMEKEEPING;**31,33,35**;Jul 1994
 ;
PROF(VOLIEN,VOLIDEN,FLAG,VALRESP) ;
 ;
 N PROFIEN,PROF0,ERRS,OUT
 N AWARD,AWCDPTR,ENTRY,STATION,STATPTR,TERM
 S PROFIEN=0
 F  S PROFIEN=$O(^ABS(503330,VOLIEN,4,PROFIEN)) Q:PROFIEN=""  D
 . N ERRS S ERRS=0
 . S OUT=0
 . S PROF0=$G(^ABS(503330,VOLIEN,4,PROFIEN,0))
 . ; if no zero node, clean up children nodes and 'B' cross-ref
 . I PROF0="" K ^ABS(503330,VOLIEN,4,"B",PROFIEN,PROFIEN),^ABS(503330,VOLIEN,4,PROFIEN) Q
 . ;STATION NUMBER
 . D
 . . S STATPTR=$P(PROF0,U)
 . . I STATPTR="" D ADDERR^ABSVMVV1(VOLIDEN_"is missing Station information.",.ERRS,VOLIEN) S OUT=1 Q
 . . S STATION=$P($G(^ABS(503338,STATPTR,0)),U,9)
 . . Q:$D(EXSITES(STATION))  ;check for excluded sites
 . . I $L(STATION)>7!(STATION="") D ADDERR^ABSVMVV1(VOLIDEN_"has incorrect Station Number information.",.ERRS,VOLIEN) S OUT=1 Q
 . . ; if no station number, then set it. This field should alway be there, it is set in a trigger on .01 field
 . . I $P(PROF0,U,12)="" S $P(PROF0,U,12)=STATION,^ABS(503330,VOLIEN,4,PROFIEN,0)=PROF0 Q
 . ;ENTRY DATE, if no error then do
 . D:'OUT
 . . N DA,DIK
 . . S ENTRY=$P(PROF0,U,2),DIK="^ABS(503330,"_VOLIEN_",4,"
 . . ;if no entry date, then delete this station multiple
 . . I ENTRY="" S DA=PROFIEN,DA(1)=VOLIEN D ^DIK S OUT=1 Q
 . . ;D ADDERR^ABSVMVV1(VOLIDEN_"is missing Entry Date information.",.ERRS,VOLIEN) Q
 . . ;Check if hours recorded for that station. Ok if entry date new.
 . . I '$D(^TMP("ABSVM","VOLWHRS",$J,VOLIEN,STATION))&(+ENTRY<$$HTFM^XLFDT($$HADD^XLFDT($H,-90))) S OUT=1 Q
 . . N RES D DT^DILF("",ENTRY,.RES)
 . . I $L($P(ENTRY,"."))'=7!(RES=-1) D ADDERR^ABSVMVV1(VOLIDEN_"has an incorrect Entry Date.",.ERRS,VOLIDEN)
 . ;If OUT, Station Profile should not be sent, record error and QUIT
 . I OUT D:ERRS>0 RECERR^ABSVMUT1(.VALRESP,.ERRS) Q
 . ;YEARS
 . I $P(PROF0,U,3)'?.N D ADDERR^ABSVMVV1(VOLIDEN_"has an incorrect value for Years At Station.",ERRS,VOLIEN)
 . ;PRIOR HOURS
 . I $P(PROF0,U,20)'?.N D ADDERR^ABSVMVV1(VOLIDEN_"has an incorrect value for Prior Years Hours Served.",.ERRS,VOLIEN)
 . ;CURRENT HOURS
 . I $P(PROF0,U,21)'?.N D ADDERR^ABSVMVV1(VOLIDEN_"has an incorrect value for Current Year Hours Served.",.ERRS,VOLIEN)
 . ;LAST AWARD HOURS
 . I $P(PROF0,U,5)'?.N D ADDERR^ABSVMVV1(VOLIDEN_"has an incorrect value for Hours Last Award.",.ERRS,VOLIEN)
 . ;LAST AWARD DATE
 . S AWARD=$P(PROF0,U,6)
 . D:AWARD'=""
 . . N RES D DT^DILF("",AWARD,.RES)
 . . I $L($P(AWARD,"."))'=7!(RES=-1) D ADDERR^ABSVMVV1(VOLIDEN_"has an incorrect Last Award Date.",.ERRS,VOLIDEN)
 . ;AWARD CODE
 . S AWCDPTR=$P(PROF0,U,7)
 . I AWCDPTR'="",'$D(ACDS(AWCDPTR)) D ADDERR^ABSVMVV1(VOLIDEN_"has an incorrect Award Code.",.ERRS,.VOLIEN)
 . ;TERM DATE
 . S TERM=$P(PROF0,U,8)
 . D:TERM'=""
 . . N RES D DT^DILF("",TERM,.RES)
 . . I $L($P(TERM,"."))'=7!(RES=-1) D ADDERR^ABSVMVV1(VOLIDEN_"has an incorrect Termination Date.",.ERRS,VOLIDEN)
 . ;REMARKS
 . ;Only 160 characters can be sent. See ABSVM VOLREMARKS function.
 . D
 .. N D0,D1,REM,ERRORS
 .. S D0=VOLIEN,D1=PROFIEN,REM=$$GETREM()
 .. I $L(REM)>160 D
 ... S ERRORS(1)="Warning: "_VOLIDEN_"has Remarks greater than 160 characters."
 ... I $G(VALRES("ERRIEN"))="" D
 .... N ABSIEN
 .... D ABSIEN^ABSVMUT1 Q:'ABSIEN
 .... S VALRES("ERRIEN")=ABSIEN
 ... D WP^DIE(503339.52,VALRES("DA")_","_VALRES("ERRIEN")_",",4,"A","ERRORS")
 . ;MEALS?
 . I ",,0,1,"'[(","_$P(PROF0,U,24)_",") D ADDERR^ABSVMVV1(VOLIDEN_"has an incorrect Eligible For Meals code.",.ERRS,VOLIEN)
 . ;TRANSPORT
 . I ",,1,2,3,4,"'[(","_$P(PROF0,U,23)_",") D ADDERR^ABSVMVV1(VOLIDEN_"has an incorrect Method of Transportation code.",.ERRS,VOLIEN)
 . ; Check for errors
 . I ERRS>0 D RECERR^ABSVMUT1(.VALRESP,.ERRS) Q
 . ; No errors and got this far; add to send list if FLAG=S
 . I $G(FLAG)["S" S ^XTMP("ABSVMVOLP","IEN",VOLIEN)=""
 . ;PARKING STICKERS
 . D PARKVAL^ABSVMVV3(VOLIEN,PROFIEN,VOLIDEN,$G(FLAG),.VALRESP)
 Q
 ;
GETREM() ;Function to return Remarks field from Voluntary Master
 N MYIENS,MYROOT,WPREM,REMARKS,I
 S MYIENS=D1_","_D0_","
 S MYROOT=$$GET1^DIQ(503330.01,MYIENS,18,,"WPREM")
 I MYROOT="" Q ""
 S I=0,REMARKS=""
 F  S I=$O(WPREM(I)) Q:I=""  D
 . ;Avoid string too long error.
 . I $L(REMARKS)+$L(WPREM(I))>511 S I=99999 Q
 . S REMARKS=REMARKS_$S($L(REMARKS)>0:" ",1:"")_WPREM(I)
 Q REMARKS
 ;
