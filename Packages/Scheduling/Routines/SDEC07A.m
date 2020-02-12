SDEC07A ;ALB/SAT - VISTA SCHEDULING RPCS ;JUL 19, 2016
 ;;5.3;Scheduling;**627,642,651,679,686**;Aug 13, 1993;Build 53
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;References made to ICR #6185 and #4837
 Q
 ;
OVBOOK(SDECY,SDCL,NSDT,SDECRES) ;RPC - OVERBOOK - Check if Overbook is allowed for given Clinic and Date.
 ;OVBOOK(SDECY,SDCL,NSDT,SDECRES)  external parameter tag is in SDEC
 ;  .SDECY   = returned pointer to OVERBOOK data
 ;   SDCL    = clinic code - pointer to Hospital Location file ^SC
 ;   NSDT    = date/time of new appointment
 ;   SDECRES = resource to check for overbook
 N %DT,AP,SDECI,OB,SDBK,OBCNT,OBMAX,SDCLN,SDCLRES,SDCLSL,SDCNT,SDRET,SDT,SDTD,SDTE,X,Y
 N SD30,SDARR,OBCNTSUM
 S OBCNTSUM=0
 ; SDTD  = new schedule Date only in FM format
 ; SDT   = loop value for $o through schedules
 ; SDTE  = end of loop schedule
 ; NSDT  = new appointment schedule Date/Time will be converted to FM format
 S SDECI=0
 S SDECY="^TMP(""SDEC"","_$J_")"
 K @SDECY
 S @SDECY@(0)="T00020ERRORID"_$C(30)
 ;check for valid Hospital location
 I '+SDCL D ERR1("Invalid Clinic ID - Cannot determine if Overbook is allowed.") Q
 I '$D(^SC(SDCL,0)) D ERR1("Invalid Clinic ID - Cannot determine if Overbook is allowed.") Q
 ;check for valid resource ID
 I '+SDECRES D ERR1("Invalid Resource ID - Cannot determine if Overbook is allowed.") Q
 I '$D(^SDEC(409.831,SDECRES,0)) D ERR1("Invalid Resource ID - Cannot determine if Overbook is allowed.") Q
 ;check for valid DATE/TIME
 S %DT="T"
 S X=NSDT
 D ^%DT   ; GET FM FORMAT FOR APPOINTMENT DATE/TIME
 S NSDT=Y
 I NSDT=-1 D ERR1("Invalid Appointment Date.") Q
 S SDTD=$P(NSDT,".")
 ; data header
 ; OVERBOOK  0=not overbooked; 1=overbooked
 S @SDECY@(0)="T00020OVERBOOK"_$C(30)
 ;get allowed number of overbookings for clinic
 S SDCLSL=$G(^SC(SDCL,"SL"))
 S OBMAX=$P(SDCLSL,U,7)
 I '+OBMAX S (OBCNT,OBMAX)=0 G XIT
 N SDAB,SLOTSIZE
 S SDAB="^TMP("_$J_",""SDEC"",""BLKS"")"
 S SLOTSIZE="^TMP("_$J_",""SDEC"",""SLOTSIZE"")"
 K @SDAB,@SLOTSIZE
 ;get original slot sizes
 D GETSLOTS^SDEC04(SLOTSIZE,SDECRES,SDTD,SDTD_".2359")
 ;get current appt availability
 D GETSLOTS^SDEC57(SDAB,SDECRES,SDTD,SDTD_".2359")
 N IDX,SDR,SDSTART,SDSTOP,SDSLOTS,XX,IDX2,YY
 ;restore original slot sizes into appts slots
 S IDX="" F  S IDX=$O(@SLOTSIZE@(IDX)) Q:'IDX  D
 .S XX=@SLOTSIZE@(IDX)
 .S SDSTART=$P(XX,U,2),SDSTOP=$P(XX,U,3),SDSLOTS=$P(XX,U,4)
 .S IDX2="" F  S IDX2=$O(@SDAB@(IDX2)) Q:'IDX2  D
 ..S YY=@SDAB@(IDX2)
 ..S:($P(YY,U,2)'<SDSTART)&($P(YY,U,3)'>SDSTOP) $P(@SDAB@(IDX2),U,4)=SDSLOTS
 ;find overbooks
 S IDX="" F  S IDX=$O(@SDAB@(IDX)) Q:IDX=""  D
 .S XX=@SDAB@(IDX)
 .S SDSTART=$P(XX,U,2),SDSTOP=$P(XX,U,3),SDSLOTS=$P(XX,U,4)
 .;loop thru schedule
 .; SDBK(<appt time>,<appt end time>)=counter starting at 0
 .K SDBK  ;overbook counter array
 .S SDRET="" D CRSCHED^SDEC(.SDRET,SDECRES,SDSTART,SDSTOP)
 .K SDARR
 .S SD30=1,SDCNT=0,SDT=0 F  S SDT=$O(@SDRET@(SDT)) Q:SDT=""  D
 ..S SDR=$G(@SDRET@(SDT))
 ..I $P(SDR,U,1)[$c(30) S SD30=1 Q
 ..Q:SD30'=1
 ..S SDCNT=SDCNT+1
 ..S SDARR($P(SDR,U,1))=""
 ..S SD30=0
 .S SDCNT=0 F  S SDCNT=$O(SDARR(SDCNT)) Q:SDCNT=""  D
 ..S SDR=$G(^SDEC(409.84,+SDCNT,0))
 ..S SDT=$P(SDR,U,1)
 ..S SDTE=$P(SDR,U,2)
 ..Q:$P(SDR,U,12)]""  ;don't count cancelled appts
 ..;if time ranges overlap, add to SDBK array
 ..I (SDTE>SDT)&(((SDT'<SDSTART)&(SDT<SDSTOP))!((SDTE>SDSTART)&(SDTE'>SDSTOP))!((SDT'>SDSTART)&(SDTE'<SDSTOP))) D
 ...D CKOB(SDT,SDTE,.SDBK)
 ..;;D CKOB($P(SDT,".")_".0000",$P(SDTE,".")_".2359",.SDBK)
 .S OBCNT=$$CNTOB(.SDBK,SDECRES,SDTD,OBMAX,SDAB)
 .S OBCNTSUM=OBCNTSUM+OBCNT
 .K @SDRET,SDBK
XIT ;
 S SDECI=SDECI+1
 S @SDECY@(SDECI)=$S(OBCNTSUM<OBMAX:"YES",1:"NO")
 S SDECI=SDECI+1
 S @SDECY@(SDECI)=$C(30)
 S SDECI=SDECI+1
 S @SDECY@(SDECI)=$C(31)
 Q
 ;
 ;find appointment in SDEC APPOINTMENT file
SDECAP(SDECSDT,DFN) ;
 N SDECAPN,SDECRES,ID
 S SDECRES=0
 S ID=0
 F  S ID=$O(^SDEC(409.84,"B",SDECSDT,ID)) Q:ID'>0  Q:SDECRES'=0  D
 . S SDECAPN=$G(^SDEC(409.84,ID,0))
 . I $P(SDECAPN,U,5)=DFN S SDECRES=$P(SDECAPN,U,7)
 Q SDECRES
 ;
 ;check if appointment start/stop is in range of an existing appointment
CKOB(START,STOP,SDBK) ;called internally
 ;  START   = appointment start date/time in FM format
 ;  STOP    = appointment stop date/time in FM format
 ; .SDBK    = bookings Array -  SDBK(<appt time>,<appt end time>)=counter starting at 0
 N B,E,OB,OBF
 S OBF=0
 S B=""
 F  S B=$O(SDBK(B)) Q:B'>0  D  Q:+OBF
 . S E="" F  S E=$O(SDBK(B,E)) Q:E'>0  D  Q:+OBF
 . . S OB=SDBK(B,E)
 . . S OBF=1
 . . ;S OBF=(($$FMADD^XLFDT(START,B,2)'<0)&($$FMADD^XLFDT(START,E,2)<0))!(($$FMADD^XLFDT(STOP,B,2)>0)&($$FMADD^XLFDT(STOP,E,2)'<0))
 . . ;S OBF=(($P(START,".",2)'<$P(B,".",2))&($P(START,".",2)'>$P(E,".",2)))!(($P(STOP,".",2)>$P(B,".",2))&($P(STOP,".",2)'>$P(E,".",2)))
 . . I OBF S SDBK(B,E)=(OB+1)
 I 'OBF S SDBK(START,STOP)=1
 ;
 Q
 ;
 ;count overbookings
CNTOB(SDBK,SDECRES,SDTD,OBMAX,SDAB) ;called internally
 N AB,ABF,ABN,CNT,BK,SLOTS,B,E
 S BK=""
 S CNT=0
 S B="" F  S B=$O(SDBK(B)) Q:B=""  D  Q:CNT'<OBMAX
 . S E="" F  S E=$O(SDBK(B,E)) Q:E=""  D  Q:CNT'<OBMAX
 . . S BK=SDBK(B,E)
 . . Q:'+BK
 . . S SLOTS=$$SLOTS(B,E,SDAB)   ;find access block
 . . I '+SLOTS S CNT=CNT+BK
 . . E  S BK=BK-SLOTS S:BK<0 BK=0 S CNT=CNT+BK
 Q CNT
SLOTS(B,E,SDAB) ;find access block
 N ABF,ABN,SDI,SLOTS
 S SLOTS=""
 S SDI=0 F  S SDI=$O(@SDAB@(SDI)) Q:SDI'>0  D  Q:+ABF
 .S ABN=@SDAB@(SDI)
 .S ABF=((B'<$P(ABN,U,2))&(B<$P(ABN,U,3)))!((E>$P(ABN,U,2))&(E'>$P(ABN,U,3)))
 .S:ABF SLOTS=+$P(ABN,U,4)
 Q SLOTS
 ;
REQSET(SDRIEN,SDPROV,SDUSR,SDACT,SDECTYP,SDECNOTE,SAVESTRT,SDECRES) ;add SCHEDULED activity to REQUEST/CONSULTATION file
 ;INPUT:
 ; SDRIEN  - (required) pointer to RFEQUEST/CONSULTATION file 123
 ; SDPROV  - (required) Provider pointer to NEW PERSON
 ; SDUSR   - (optional) User that entered appointment pointer to NEW PERSON
 ; SDACT   - (required) ACTIVITY type to add  1=SCHEDULED  2=STATUS CHANGE
 ; SDECTYP - (required if SDACT=2) appointment Status valid values:
 ;                          C=CANCELLED BY CLINIC
 ;                         PC=CANCELLED BY PATIENT
 ; SDECNOTE - Comments from Appointment
 ; SAVESTRT - Appointment time in external format    ;alb/sat 651 corrected comment
 ; SDECRES  - Appointment Resource
 N SDDT,SDFDA,SDI,SDIEN,SDOA,SDOS,SDPDC,SDSCHED,SDSCHEDF,SDSTAT,SDTXT,SDERR,Y,SDPCM
 S SDACT=$G(SDACT)
 S SAVESTRT=$G(SAVESTRT)
 S SDECRES=$G(SDECRES)
 Q:"12"'[SDACT
 S SDSCHEDF=0
 S SDUSR=$G(SDUSR)
 S:SDUSR="" SDUSR=DUZ
 S:'$D(^VA(200,+SDUSR,0)) SDUSR=DUZ  ;take this out
 S SDSCHED=$$GETIEN^SDEC51("SCHEDULED")
 S SDSTAT=$$GETIEN^SDEC51("STATUS CHANGE")
 S SDPDC=$O(^ORD(100.01,"B","DISCONTINUED",0))
 ;ajf ; Check for completed Consult
 S SDPCM=$O(^ORD(100.01,"B","COMPLETE",0))
 I SDACT=1,SDSCHED="" Q
 I SDACT=2,SDSTAT="" Q
 ;ajf ; Check for completed Consult
 S SDCPS=$$GET1^DIQ(123,SDRIEN_",",8,"I")
 Q:SDCPS=SDPDC!(SDCPS=SDPCM) 
 ;Q:$$GET1^DIQ(123,SDRIEN_",",8,"I")=SDPDC   ;never update file 123 if CPRS STATUS is DISCONTINUED
 ;Q:$$GET1^DIQ(123,SDRIEN_",",8,"I")=SDPCM   ;never update file 123 if CPRS STATUS is COMPLETE
 S SDECNOTE=$G(SDECNOTE)
 ;it is possible to have multiple scheduled activities; make sure there is not already a SCHEDULED activity
 ;S SDI=0 F  S SDI=$O(^GMR(123,SDRIEN,40,SDI)) Q:SDI'>0  D  Q:+SDSCHEDF
 ;.I $P($G(^GMR(123,SDRIEN,40,SDI,0)),U,2)=SDSCHED S SDSCHEDF=1 Q
 ;Q:+SDSCHEDF
 S SDDT=$$NOW^XLFDT()  ;*zeb 12/13/17 679 don't use $E to remove seconds
 ;
 ; Replaced with call to SDCNSLT below.  wtc/zeb 3.21.18 patch 686 ;
 ;
 ;S SDFDA(123.02,"+1,"_SDRIEN_",",.01)=SDDT                                   ;ICR 6185
 ;S SDFDA(123.02,"+1,"_SDRIEN_",",1)=$S(SDACT=1:SDSCHED,SDACT=2:SDSTAT,1:"")  ;ICR 6185
 ;S SDFDA(123.02,"+1,"_SDRIEN_",",2)=SDDT                                     ;ICR 6185
 ;S SDFDA(123.02,"+1,"_SDRIEN_",",3)=SDPROV                                   ;ICR 6185
 ;S SDFDA(123.02,"+1,"_SDRIEN_",",4)=SDUSR                                    ;ICR 6185
 ;D UPDATE^DIE("","SDFDA","SDIEN")
 S SDTXT=""
 ;MGH modified to add in note text and appointment data
 I SDACT=1 D
 .;
 .; Disabled lines below because they exist in SDCNSLT.
 .; wtc/zeb 3.22.18 patch 686
 .;
 .;S SDTXT(1)=$P($G(^SDEC(409.831,+SDECRES,0)),U,1)_" Consult Appt. on "_SAVESTRT
 .;I SDECNOTE'="" S SDTXT(2)=SDECNOTE
 . N %DT,X,SD,TMPYCLNC ;
 . S X=SAVESTRT,%DT="T" D ^%DT S SD=Y ;
 . S TMPYCLNC=$P($G(^SDEC(409.831,+SDECRES,0)),U,4) I TMPYCLNC'="" S TMPYCLNC=TMPYCLNC_U_$P(^SC(TMPYCLNC,0),U,1) ;
 . D EDITCS^SDCNSLT(SD,SDECNOTE,TMPYCLNC,SDRIEN) ; Changed "" to SDECNOTE - wtc 686 11/7/2018
 I SDACT=2 D
 .;
 .; Disabled lines below because they exist in SDCNSLT.
 .; wtc/zeb 3.22.18 patch 686
 .;
 .;S SDECTYP=$G(SDECTYP)
 .;S SDTXT(1)=$P($G(^SDEC(409.831,+SDECRES,0)),U,1)_" Appt. on "_SAVESTRT_" was cancelled"_$S(SDECTYP["P":" by the Patient.",SDECTYP["C":" by the Clinic.",1:".")   ;alb/sat 651 include appt info
 .;I SDECNOTE'="" S SDTXT(2)="Remarks: "_SDECNOTE
 . N DFN,%DT,X,SDTTM,SDSC,SDPL ;
 . S DFN=$P($G(^GMR(123,SDRIEN,0)),U,2) ;
 . S X=SAVESTRT,%DT="T" D ^%DT S SDTTM=Y ;
 . S SDSC=$P($G(^SDEC(409.831,+SDECRES,0)),U,4) ;
 . S SDPL=0 F  S SDPL=$O(^SC(SDSC,"S",SDTTM,1,SDPL)) Q:'SDPL  Q:$P(^(SDPL,0),U,1)=DFN  ;
 . D SDECCAN^SDCNSLT(SDRIEN,DFN,SDTTM,SDSC,SDECTYP,SDPL,SDECNOTE) ;*zeb 686 10/30/18 send comments to consult
 Q  ;
 ;
 ;  Lines below disabled by calls to SDCNSLT.
 ;  wtc/zeb 3.22.18 patch 686
 ;
 ;I $D(SDTXT) D
 ;.D WP^DIE(123.02,SDIEN(1)_","_SDRIEN_",",5,"","SDTXT","SDERR")   ;ICR 6185
 ;K SDFDA   ;alb/sat 651
 ;set CPRS status field  ICR 6185
 ;S SDOS=$O(^ORD(100.01,"B","SCHEDULED",0))
 ;S SDOA=$O(^ORD(100.01,"B","ACTIVE",0))
 ;I SDOS'="" D
 ;.;K SDFDA  ;alb/sat 651 moved up
 ;.S SDFDA(123,SDRIEN_",",8)=$S(SDACT=1:SDOS,1:SDOA)
 ;.;D UPDATE^DIE("","SDFDA")                          ;ICR 6185  ;alb/sat 651 moved down out of IF scope
 ;S:+$G(SDSCHED) SDFDA(123,SDRIEN_",",9)=$S(SDACT=1:SDSCHED,1:SDSTAT)      ;alb/sat 651 - set LAST ACTION TAKEN   ICR 4837
 ;D:$D(SDFDA) UPDATE^DIE("","SDFDA")   ;alb/sat 651
 ;Q
 ;
EWL(WLIEN,APPDT,SDCL,SVCP,SVCPR,NOTE,SDAPPTYP) ;update SD WAIT LIST at appointment add
 ;INPUT:
 ;  WLIEN = Wait List ID pointer to SD WAIT LIST file 409.3
 ;  APPDT = Appointment date/time (Scheduled Date of appt) in fm format
 ;  SDCL  = Clinic ID pointer to HOSPITAL LOCATION file 44
 ;  SVCP  = Service Connected Percentage numeric 0-100
 ;  SVCPR = Service Connected Priority  0:NO  1:YES
 ;  NOTE  = Comment only 1st 60 characters are used
 ;  SDAPPTYP - (optional) Appointment type ID pointer to APPOINTMENT TYPE file 409.1
 ;
 ;all input must be verified by calling routine
 N SDDIV,SDFDA,SDSN
 S:+$G(SDAPPTYP) SDFDA(409.3,WLIEN_",",8.7)=SDAPPTYP
 S SDFDA(409.3,WLIEN_",",13)=APPDT                     ;SCHEDULED DATE OF APPT       = APPDT  (SDECSTART)
 S SDFDA(409.3,WLIEN_",",13.1)=$P($$NOW^XLFDT,".",1)   ;DATE APPT. MADE              = TODAY
 S SDFDA(409.3,WLIEN_",",13.2)=SDCL                    ;APPT CLINIC                  = SDCL   (SDECSCD)
 S SDFDA(409.3,WLIEN_",",13.3)=$P($G(^SC(SDCL,0)),U,4) ;APPT INSTITUTION             = Get from 44 using SDCL
 S SDFDA(409.3,WLIEN_",",13.4)=$P($G(^SC(SDCL,0)),U,7) ;APPT STOP CODE               = Get from 44 using SDCL
 S SDDIV=$P($G(^SC(SDCL,0)),U,15)
 S SDSN=$S(SDDIV'="":$P($G(^DG(40.8,SDDIV,0)),U,2),1:"")
 S SDFDA(409.3,WLIEN_",",13.6)=SDSN                    ;APPT STATION NUMBER
 S SDFDA(409.3,WLIEN_",",13.7)=DUZ                     ;APPT CLERK                   = Current User
 S SDFDA(409.3,WLIEN_",",13.8)="R"                     ;APPT STATUS                  = R:Scheduled/Kept
 S:SVCP'="" SDFDA(409.3,WLIEN_",",14)=SVCP                      ;SERVICE CONNECTED PERCENTAGE = SVCP   (SDSVCP)
 S:SVCPR'="" SDFDA(409.3,WLIEN_",",15)=SVCPR                     ;SERVICE CONNECTED PRIORITY   = SVCPR  (SDSVCPR)
 S:$G(NOTE)'="" SDFDA(409.3,WLIEN_",",25)=NOTE
 S SDFDA(409.3,WLIEN_",",27)="U"                       ;EWL ENROLLEE STATUS          = U:UNDETERMINED
 S SDFDA(409.3,WLIEN_",",27.2)=0                       ;EWL ENROLLEE DATABASE FILE   = 0:NONE
 S SDFDA(409.3,WLIEN_",",28)=DUZ                       ;EDITING USER                 = Current User
 D UPDATE^DIE("","SDFDA")
 Q
 ;
ERROR ;
 D ERR1("Error")
 Q
 ;
ERR1(SDECERR) ;Error processing
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=SDECERR_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
