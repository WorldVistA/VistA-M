SDECCAP ;ALB/SAT - VISTA SCHEDULING RPCS ;APR 08, 2016
 ;;5.3;Scheduling;**642**;Aug 13, 1993;Build 23
 ;
 Q
 ;
GET(SDECY,DFN,SDCL,SDT,TYPE,APTYPE) ;GET entries from 2507 REQUEST file 396.3
 ;INPUT:
 ; DFN    - (required) Patient ID pointer to PATIENT file 2
 ; SDCL   - (required) Clinic ID pointer to HOSPITAL LOCATION file 44
 ; SDT    - (required) Appointment Date/Time in external format
 ; TYPE   - (required) O:MAKE
 ;                     R:REBOOK
 ;                     C:CANCEL or NO SHOW
 ; APTYPE - (required) Must be 1 for COMP and Pen
 ;RETURN:
 ; REQIEN - 2507 REQUEST id pointer to 2507 REQUEST file 396.3
 ; IEN    - Patient ID pointer to PATIENT file 2
 ; NAME   - Patient name from PATIENT file 2
 ; DATE   - Request Date in external format (field #1)
 ; EXISTS - Flag to indicate that a 2507 REQUEST already has an appointment.
 ;          This is indicated by an entry in file 396.95
 ;          0=No; 1=Yes
 ; APPT_LINKS - Appointment Links separated by pipe |
 ;               each pipe piece contains the following ~ pieces
 ;               1. Link ID         - Pointer to AMIE C&P EXAM TRACKING file 396.95
 ;               2. Initial Appt    - Date/time in external format
 ;               3. Clock Stop Appt - Date/time in external format
 ;               4. Current Appt    - Date/time in external format
 ;               5. Clinic Name     - Name from HOSPITAL LOCATION
 ;
 N %DT,X,Y
 N SDDA,SDECI,SDMKHDL
 S SDECI=0
 S SDECY="^TMP(""SDECCAP"","_$J_",""CAPGET"")"
 K @SDECY
 S @SDECY@(SDECI)="T00030REQIEN^T00030IEN^T00030NAME^T00030DATE^T00030EXISTS^T00250APPT_LINKS"_$C(30)
 ;validate DFN
 S DFN=$G(DFN)
 I ('+DFN)!('$D(^DPT(+DFN,0))) S @SDECY@(1)="-1^Invalid patient ID."_$C(30,31) Q
 ;validate SDCL
 S SDCL=$G(SDCL)
 I ('+SDCL)!('$D(^SC(+SDCL,0))) S @SDECY@(1)="-1^Invalid clinic ID."_$C(30,31) Q
 ;validate SDT
 S SDT=$G(SDT)
 S %DT="RXT",X=SDT D ^%DT S SDT=Y
 S SDDA=0 F  S SDDA=$O(^SC(SDCL,"S",SDT,1,SDDA)) Q:SDDA'>0  Q:$P($G(^SC(SDCL,"S",SDT,1,SDDA,0)),U,1)=DFN
 I SDDA="" S @SDECY@(1)="-1^Appointment not found."_$C(30,31) Q
 I SDT=-1 S @SDECY@(1)="-1^Invalid appointment date/time."_$C(30,31) Q
 ;validate TYPE
 S TYPE=$G(TYPE)
 I "ORC"'[TYPE S @SDECY@(1)="-1^Type must be O:Original Make, R for Rebook, or C for Cancel/No Show."_$C(30,31) Q
 ;validate APTYPE
 S APTYPE=$G(APTYPE)
 I APTYPE'=1 S @SDECY@(1)="-1^Only Comp & Pen is currently supported."_$C(30,31) Q
 ;from MAKE^SDAMEVT
 K ^TMP("SDAMEVT",$J)
 S SDMKHDL=$$HANDLE^SDAMEVT(1)
 S (^TMP("SDAMEVT",$J,"BEFORE","DPT"),^TMP("SDAMEVT",$J,"BEFORE","SC"),^TMP("SDAMEVT",$J,"BEFORE","STATUS"))=""
 S SDATA("BEFORE","STATUS")=""
 S (^TMP("SDEVT",$J,SDMKHDL,1,"DPT",0,"BEFORE"),^TMP("SDEVT",$J,SDMKHDL,1,"SC",0,"BEFORE"))=""
 S (^TMP("SDEVT",$J,SDMKHDL,1,"DPT",0,"AFTER"),^TMP("SDEVT",$J,SDMKHDL,1,"SC",0,"AFTER"))=""
 ;D AFTER^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDMKHDL)
 S SDATA=SDDA_U_DFN_U_SDT_U_SDCL
 D EVT(.SDATA,1,0,SDMKHDL)
 ;
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
 ;
EVT(SDATA,SDAMEVT,SDMODE,SDHDL)  ;EVT^SDAMEVT
 K DTOUT,DIROUT
 S:$P(SDATA,U,3) $P(SDATA,U,5)=$$REQ^SDM1A(+$P(SDATA,U,3))
 D EN
 Q
 ;
 ;from EN^DVBCSDEV
EN   ;**AMIE Scheduling event driver main entry point
 K KDFN I '$D(DFN) N DFN S DFN=$P(SDATA,U,2),KDFN=""
 S DVBAORG=$$SDORGST^DVBCUTL5
 I +DVBAORG=1 D
 .S DVBAXST=$$SDEVTXST^DVBCUTL5
 .I +DVBAXST=1 D
 ..S DVBATYPE=1   ;$$SDEVTSPC^DVBCUTL5(16)
 ..I +DVBATYPE=1 D
 ...I +SDAMEVT=1 D EN1     ;EN^DVBCMKLK ;** Original Make event
 ...;I +SDAMEVT=1,($D(DVBAAUTO)) K DVBAAUTO ;** Auto-rebook Make event
 ...I +SDAMEVT=2 D ENCAN    ;EN^DVBCCNNS ;** Cancel/No show event
 ..K DVBATYPE
 .K DVBAXST
 K DVBAORG
 I $D(KDFN) K KDFN,DFN
 D KVARS^DVBCMKLK
 Q
 ;
 ;from DVBCMKLK
EN1 ;** Link C&P appointment to 2507
 N DVBADFN,DVBASDPR,DVBASTAT
 N SDI,SDJ,DVBADA,SDL,SDLINKS,SDM,SDTMP,TMP,TMP1
 S DVBADFN=DFN,DVBASTAT="P" ;**DVBASTAT used in REQARY^DVBCUTL5
 ;
 ;**If user entered from AMIE Scheduling, only prompted if enhanced
 ;** dialogue turned on and is needed
 ;** QUIT on next line if from DVBCSCHD
 ;I $D(DVBASDRT) S DVBADA=REQDA D LINKAPPT^DVBCMKL2,KVARS QUIT  ;*DVBCSCHD
 S (DVBADA,DVBASDPR)=""
 D REQARY^DVBCUTL5 ;**Set up ^TMP of AMIE 2507's
 ;^TMP("DVBC",8945,6889775.889799,3110224.1102,34231)=""
 ;                 Inverse REQUEST DATE, REQUEST DATE, IEN)
 S SDI="" F  S SDI=$O(^TMP("DVBC",$J,SDI)) Q:SDI=""  D
 .S SDJ="" F  S SDJ=$O(^TMP("DVBC",$J,SDI,SDJ)) Q:SDJ=""  D
 ..S DVBADA="" F  S DVBADA=$O(^TMP("DVBC",$J,SDI,SDJ,DVBADA)) Q:DVBADA=""  D
 ...S $P(SDTMP,U,1)=DVBADA   ;2507 REQUEST id
 ...S $P(SDTMP,U,2)=DFN
 ...S $P(SDTMP,U,3)=$$GET1^DIQ(2,DFN_",",.01)
 ...S $P(SDTMP,U,4)=$$FMTE^XLFDT(SDJ)
 ...S $P(SDTMP,U,5)=+$E($D(^DVB(396.95,"AR",+DVBADA)),1)
 ...D
 ....K TMP("DVBC LINK")
 ....S SDLINKS=""    ;SDLINKS |  ~
 ....D LNKARY^DVBCUTA3(DVBADA,DFN)
 ....S SDL="" F  S SDL=$O(TMP("DVBC LINK",SDL)) Q:SDL=""  D
 .....S SDM="" F  S SDM=$O(TMP("DVBC LINK",SDL,SDM)) Q:SDM=""  D
 ......S TMP1=SDM_"~"_$TR(TMP("DVBC LINK",SDL,SDM),"^","~")
 ......S SDLINKS=SDLINKS_$S(SDLINKS'="":"|",1:"")_TMP1
 ...S $P(SDTMP,U,6)=SDLINKS
 ...S SDECI=SDECI+1 S @SDECY@(SDECI)=SDTMP_$C(30)
 K ^TMP("DVBC LINK")
 Q
 ;
 ;
SET(SDECY,REQIEN,APPTLNK,VETREQ,SDCL,SDT)  ;SET entries to AMIE C&P EXAM TRACKING file 396.95 and update file 396.3
 ;INPUT:
 ;  1. REQIEN   - (required) 2507 REQUEST id pointer to 2507 REQUEST file 396.3
 ;  2. APPTLNK  - (optional) Appointment Link with the following ~ pieces: (a new link will be made if this is null)
 ;               1. Link ID         - Pointer to AMIE C&P EXAM TRACKING file 396.95
 ;               2. Initial Appt    - Date/time in external format
 ;               3. Clock Stop Appt - Date/time in external format
 ;               4. Current Appt    - Date/time in external format
 ;               5. Clinic Name     - Name from HOSPITAL LOCATION
 ;  3. VETREQ   - (optional) Veteran Request flag - (field .04 in file 396.95)
 ;                "Is this appointment due to a veteran requested cancellation or 'No Show'"
 ;                0=NO; 1=YES
 ;  4. SDCL     - (required) pointer to HOSPITAL LOCATION file 44
 ;  5. SDT      - (required) Appointment date/time in external format
 ;RETURN:
 ;  CODE ^ MESSAGE
 N DFN,DVBADA,DVBALKRC,DVBAVTRQ
 N SDDA,SDECI
 S SDECI=0
 S SDECY="^TMP(""SDECCAP"","_$J_",""CAPSET"")"
 K @SDECY
 S @SDECY@(SDECI)="T00030CODE^T00250MESSAGE"_$C(30)
 ;validate REQIEN
 S (REQIEN,DVBADA)=$G(REQIEN)
 I '+REQIEN S @SDECY@(1)="-1^Invalid 2507 REQUEST id."_$C(30,31) Q
 I '$D(^DVB(396.3,+REQIEN,0)) S @SDECY@(1)="-1^Invalid 2507 REQUEST id."_$C(30,31) Q
 S DFN=$$GET1^DIQ(396.3,REQIEN_",",.01,"I")
 ;validate APPTLNK
 S APPTLNK=$G(APPTLNK)
 ;validate VETREQ
 S VETREQ=$G(VETREQ)
 I VETREQ'=1,VETREQ'=2 S VETREQ=""
 ;validate SDCL
 S SDCL=$G(SDCL)
 I ('+SDCL)!('$D(^SC(+SDCL,0))) S @SDECY@(1)="-1^Invalid clinic ID."_$C(30,31) Q
 ;validate SDT
 S SDT=$G(SDT)
 S %DT="RXT",X=SDT D ^%DT S SDT=Y
 I SDT=-1 S @SDECY@(1)="-1^Invalid appointment date/time."_$C(30,31) Q
 S SDDA=0 F  S SDDA=$O(^SC(SDCL,"S",SDT,1,SDDA)) Q:SDDA'>0  Q:$P($G(^SC(SDCL,"S",SDT,1,SDDA,0)),U,1)=DFN
 I SDDA="" S @SDECY@(1)="-1^Appointment not found."_$C(30,31) Q
 ;
 ;from MAKE^SDAMEVT
 ;K ^TMP("SDAMEVT",$J)
 ;S SDMKHDL=$$HANDLE^SDAMEVT(1)
 ;S (^TMP("SDAMEVT",$J,"BEFORE","DPT"),^TMP("SDAMEVT",$J,"BEFORE","SC"),^TMP("SDAMEVT",$J,"BEFORE","STATUS"))=""
 ;S SDATA("BEFORE","STATUS")=""
 ;S (^TMP("SDEVT",$J,SDMKHDL,1,"DPT",0,"BEFORE"),^TMP("SDEVT",$J,SDMKHDL,1,"SC",0,"BEFORE"))=""
 ;S (^TMP("SDEVT",$J,SDHDL,1,"DPT",0,"AFTER"),^TMP("SDEVT",$J,SDHDL,1,"SC",0,"AFTER"))=""
 ;  ;D AFTER^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDMKHDL)
 S SDATA=SDDA_U_DFN_U_SDT_U_SDCL
 I APPTLNK="" D CRTREC S @SDECY@(1)=+Y_U_"AMIE C&P EXAM TRACKING record added"_$C(30,31) G SETX
 I APPTLNK'="" S DVBALKRC=$P(APPTLNK,"~",1),DVBAVTRQ=VETREQ D UPDTLK S @SDECY@(1)=DVBALKRC_U_"AMIE C&P EXAM TRACKING record updated"_$C(30,31) G SETX
 S @SDECY@(1)="-1^No updates made"_$C(30,31)
SETX  ;
 Q
CRTREC ;** Add a record to file 396.95 (Appt Tracking)
 N DIC,DD,DLAYGO,DO,DVBAADT,X
 S DVBAADT=$P(SDATA,U,3)
 S DIC="^DVB(396.95,",X=DVBAADT,DIC(0)="LX",DLAYGO="396.95"
 S DIC("DR")=".02////^S X=DVBAADT;.03////^S X=DVBAADT;"
 S DIC("DR")=DIC("DR")_".04////^S X=0;.06////^S X=DVBADA;"
 S DIC("DR")=DIC("DR")_".07////^S X=1"
 D FILE^DICN K DIC,X,DLAYGO,DVBAADT
 Q
UPDTLK ;** Update selected 396.95 link
 N DVBARSAP
 S DVBARSAP=$P(^DVB(396.95,DVBALKRC,0),U,3)
 K Y,DIR D RSCHAPT(DVBALKRC,$P(SDATA,U,3))
 K DVBAVTRQ
 N DVBAAPST
 S DVBAAPST=$P(^DPT(DFN,"S",SDT,0),U,2)
 Q
RSCHAPT(LKDA,RSCHDT) ;** Update Appt record with reschedule data  ;from DVBCMKLK
 N DA,DIE,DR
 S DA=+LKDA,DIE="^DVB(396.95,",DR=".03////^S X=RSCHDT;.07////1"
 S:(+$P(^DVB(396.95,DA,0),U,4)=0&('$D(DVBAVTRQ))) DR=".02////^S X=RSCHDT;"_DR
 S:($D(DVBAVTRQ)) DR=".04////^S X=1;.05////^S X=RSCHDT;"_DR
 D ^DIE K DA,DIE,DR
 Q
 ;
CAN(SDECY,DFN,SDCL,SDT)   ;SET AMIE C&P EXAM TRACKING as cancel
 ;INPUT:
 ; DFN    - (required) Patient ID pointer to PATIENT file 2
 ; SDCL   - (required) Clinic ID pointer to HOSPITAL LOCATION file 44
 ; SDT    - (required) Appointment Date/Time in external format
 ;RETURN:
 ; an array of codes and messages:
 ;   code ^ message
 ;   code -   -1=error   -2=message to be displayed to the user
 N SDAMEVT,SDATA,SDCPHDL,SDECI,SDHDL
 N ZTQUEUED
 S ZTQUEUED=1
 S SDAMEVT=2
 S SDECI=0
 S SDECY="^TMP(""SDECCAP"","_$J_",""CAPSET"")"
 K @SDECY
 S @SDECY@(SDECI)="T00030REQIEN^T00030IEN^T00030NAME^T00030DATE^T00030EXISTS_T00250APPT_LINKS"_$C(30)
 ;validate DFN
 S DFN=$G(DFN)
 I ('+DFN)!('$D(^DPT(+DFN,0))) S @SDECY@(1)="-1^Invalid patient ID."_$C(30,31) Q
 ;validate SDCL
 S SDCL=$G(SDCL)
 I ('+SDCL)!('$D(^SC(+SDCL,0))) S @SDECY@(1)="-1^Invalid clinic ID."_$C(30,31) Q
 ;validate SDT
 S SDT=$G(SDT)
 S %DT="RXT",X=SDT D ^%DT S SDT=Y
 I SDT=-1 S @SDECY@(1)="-1^Invalid appointment date/time."_$C(30,31) Q
 S SDDA=0 F  S SDDA=$O(^SC(SDCL,"S",SDT,1,SDDA)) Q:SDDA'>0  Q:$P($G(^SC(SDCL,"S",SDT,1,SDDA,0)),U,1)=DFN
 I SDDA="" S @SDECY@(1)="-1^Appointment not found."_$C(30,31) Q
 S (SDHDL,SDCPHDL)=$$HANDLE^SDAMEVT(1) D BEFORE^SDAMEVT(.SDATA,DFN,SDT,SDCL,"",SDCPHDL)   ;CAN^SDCNP0
 ;D CANCEL^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,0,SDCPHDL)   ;EVT^SDCNP0
 D AFTER^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDCPHDL)    ;CANCEL^SDAMEVT
 S SDATA=SDDA_U_DFN_U_SDT_U_SDCL
 D EVT(.SDATA,SDAMEVT,0,SDCPHDL)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
 ;
ENCAN   ;from DVBCCNNS
 N DVBAAPDA,DVBAAUTO,DVBACURA,DVBAFND,DVBALKDA,DVBARQDA,DVBASTAT,DVBAUPDT
 N LNKCNT
 S DVBASTAT=$$SDEVTSPC^DVBCUTL5(2)
 S DVBACURA=$P(SDATA,U,3) ;**Get the date being canceled
 S (DVBAAPDA,DVBALKDA)=""
 S DVBAUPDT=0
 K DVBAFND
 S LNKCNT=0
 F  S DVBAAPDA=$O(^DVB(396.95,"CD",DVBACURA,DVBAAPDA)) Q:(DVBAAPDA="")  D
 .S DVBARQDA=$P(^DVB(396.95,DVBAAPDA,0),U,6)
 .I ($P(^DVB(396.3,DVBARQDA,0),U,1)=DFN) D
 ..S LNKCNT=LNKCNT+1
 ..S:(+$P(^DVB(396.95,DVBAAPDA,0),U,7)=1) DVBAFND="",DVBALKDA=DVBAAPDA
 ..I '$D(DVBAFND),($P(^DVB(396.95,DVBAAPDA,0),U,8)>DVBAUPDT) D
 ...S DVBAUPDT=$P(^DVB(396.95,DVBAAPDA,0),U,8) ;**Keep latest cancel dte
 ...S DVBALKDA=DVBAAPDA ;**Keep DA of rec last cancelled
 I (DVBASTAT="PCA")!((DVBASTAT="NA")!(DVBASTAT="CA")) S DVBAAUTO=""
 ;
 ;** Appt not linked, enhnc dilog on, not processing in background
 I LNKCNT=0 D
 .N DVBACROT,Y S Y=DVBACURA X ^DD("DD") S DVBACROT=Y K Y
 .S SDECI=SDECI+1 S @SDECY@(SDECI)="-2^Appointment "_DVBACROT_" was not linked to a 2507 request or was"
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=" manually rebooked and linked to another appointment."
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=" (If the appointment was manually rebooked, you do not want to auto-rebook.)"
 .S SDECI=SDECI+1 S @SDECY@(SDECI)="If the appointment was not properly linked, it will need to be linked with the"
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=" AMIE/C&P appointment link management option."_$C(30)
 ;I $D(DVBAAUTO),($D(DVBAFND)!('$D(DVBAFND)&(+LNKCNT>0))) DO  ;**Auto-rbk
 ;.S:(+$$SDEVTXST^DVBCUTL5=1) DVBAAPDT=$$SDEVTSPC^DVBCUTL5(10)
 ;.K DVBAVTRQ ;**Set if appointment canceled by vet
 ;.S:(DVBASTAT["P"!(DVBASTAT["N"&(DVBASTAT'="NT"))) DVBAVTRQ=""
 ;.D RSCHAPT^DVBCMKLK(DVBALKDA,DVBAAPDT)
 ;.D:((+$$ENHNC^DVBCUTA4=1)&('$D(ZTQUEUED))) CNCMSG
 I '$D(DVBAAUTO),($D(DVBAFND)) D  ;**Appt linked, not Auto
 .D CANCEL^DVBCCNNS
 .S SDECI=SDECI+1 S @SDECY@(SDECI)="-2^The link has been updated."_$C(30)
 .;D:((+$$ENHNC^DVBCUTA4=1)&('$D(ZTQUEUED))) CNCMSG
 I +LNKCNT>1 D
 .S SDECI=SDECI+1 S @SDECY@(SDECI)="-2^This C&P appointment has multiple links with the same Current Appt Date."
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=" Use the AMIE/C&P Appointment Link Management option to review and delete"
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=" any duplicate links."_$C(30)
 D KVARS^DVBCCNNS
 Q
