TIUTSK ; SLC/JER - TIU's Nightly Daemon ;4/18/03 [10/18/04 10:34am]
 ;;1.0;TEXT INTEGRATION UTILITIES;**7,53,100,113,157,210,221**;Jun 20, 1997;Build 2
MAIN ; All records are read. DC date updated, Record purged, Alerts are 
 ; generated if appropriate
 N TIUDA,TIUPRM0,TIUPRM1,TIUDATE,TIUENTDT,TIUPDT,TIUODT
 N TIUSTART,TIUEND,TIUADDL
 D SETPARM^TIULE
 S TIUSTART=$$TSKPARM(1),TIUEND=$$TSKPARM(2)
 ; Traverse "FIX" X-ref to fix temporary reference dates & back-fill
 ; Discharge Dates
 S TIUDA="" F  S TIUDA=$O(^TIU(8925,"FIX",1,TIUDA)) Q:TIUDA'>0  D
 . D UPDDCDT(TIUDA) ;Ref Date fixed/DC Date updated if missing
 ; Traverse "F" X-ref to identify records for which the grace period
 ; for purge has expired
 S TIUPDT=$$FMADD^XLFDT(DT,-$P(TIUPRM0,U,4))
 S TIUODT=$$FMADD^XLFDT(DT,-$P(TIUPRM0,U,5))
 ; Traverse "F" X-ref to identify records overdue for signature or purge
 ; NOTE: Following VHA Directive 10-92-077, the purge is disabled until
 ;       further notice **53**
 ;VMP/ELR PATCH 221  SET UP TIUADDL IS OVERDUE ONLY BECAUSE OF ADDITIONAL SIGNER TO STOP AMENDMENT ALERT
 S TIUADDL=0
 S TIUENTDT=($$TSKPARM(3)-1)+.999999
 F  S TIUENTDT=$O(^TIU(8925,"F",TIUENTDT)) Q:+TIUENTDT'>0!(TIUENTDT>TIUODT)  D
 . S TIUDA=0 F  S TIUDA=$O(^TIU(8925,"F",+TIUENTDT,TIUDA)) Q:+TIUDA'>0  D
 . . ; I (TIUPDT<$$FMADD^XLFDT(DT,-90)),+$$PURGE^TIULC(TIUDA) D PURGE(TIUDA) Purges old records (see NOTE above) **53**
 . . I +$$OVERDUE(TIUDA,TIUSTART,TIUEND) D SEND^TIUALRT(TIUDA,1) S TIUADDL=0     ;Alert for overdue
 ; If upload buffer rec older than 30 days, delete it & its alerts
 S TIUDA=0 F  S TIUDA=$O(^TIU(8925.2,TIUDA)) Q:TIUDA'>0  D
 . N TIUDATE
 . S TIUDATE=$P($G(^TIU(8925.2,TIUDA,0)),U,3)
 . Q:+TIUDATE'>0
 . I $$FMDIFF^XLFDT(DT,TIUDATE)>30 D
 . . N TIUEI S TIUEI=0
 . . ; JOEL, 12/21/00:
 . . F  S TIUEI=$O(^TIU(8925.2,TIUDA,"ERR",TIUEI)) Q:+TIUEI'>0  D
 . . . N TIUEDA
 . . . S TIUEDA=+$G(^TIU(8925.2,TIUDA,"ERR",TIUEI,0)) Q:+TIUEDA'>0
 . . . D ALERTDEL^TIUPEVNT(TIUEDA)
 . . D BUFPURGE^TIUPUTC(TIUDA)
 Q
UPDDCDT(TIUDA) ; If missing DC date & Patient Movement file has DC date,
 ;         DC date updated.
 N DFN,DIE,DR,TIU,TIUDAD,TIUDDT,TIUD0,TIUD14,TIUDGPM
 S TIUD0=$G(^TIU(8925,+TIUDA,0)),TIUD14=$G(^TIU(8925,+TIUDA,14))
 S TIUDGPM=+$P(TIUD14,U)
 I +$P($G(^DGPM(+TIUDGPM,0)),U,17)'>0 D  Q
 . I +$P(TIUD0,U,12)>0 Q
 . S DIE=8925,DR=".12////1",DA=TIUDA D ^DIE
 I TIUD0'="",'+$P(TIUD0,U,6),(($P(TIUD0,U,8)="")!(+$P(TIUD0,U,12)>0)) D
 . D GETTIU^TIULD(.TIU,TIUDA)
 . I +$G(TIU("LDT"))>0 D
 . . S TIUDAD=$P(TIUD0,U,6)
 . . D FIXDC(TIUDA,TIUDAD,DFN,.TIU)
 Q
PURGE(DA) ; When purge criteria met, document and addenda purged
 N DR,DIE,TIUTYP,TIUDA,X,Y S TIUDA=0
 F  S TIUDA=+$O(^TIU(8925,"DAD",+DA,TIUDA)) Q:+TIUDA'>0  D
 . I +$$ISADDNDM^TIULC1(TIUDA) D PURGE(TIUDA) I 1
 . E  D DIK^TIURB2(TIUDA) ; Remove components entirely. 1/3/01 updated DIK^TIURB to DIK^TIURB2 - Margy
 S DIE=8925,DR=".05///PURGED;1609////"_$$NOW^TIULC_";2///@" D ^DIE
 S ^TIU(8925,+DA,"TEXT",0)="^^"_2_U_2_U_DT_"^^"
 S ^TIU(8925,+DA,"TEXT",1,0)=" "
 S ^TIU(8925,+DA,"TEXT",2,0)="  Document Purged on "_$$DATE^TIULS(DT,"MM/DD/YY")_"."
 Q
FIXDC(DA,PARENT,DFN,TIU) ; Stuff fixed field data
 N FDA,FDARR,IENS,FLAGS,TIUMSG
 S IENS=""""_DA_",""",FDARR="FDA(8925,"_IENS_")",FLAGS="K"
 I +$G(PARENT)'>0 D
 . S @FDARR@(.08)=$P(TIU("LDT"),U)
 . S @FDARR@(1402)=$P($G(TIU("TS")),U)
 I +$G(PARENT)>0 D
 . S @FDARR@(.08)=$P(TIU("LDT"),U)
 . S @FDARR@(1401)=$P(^TIU(8925,+PARENT,14),U)
 . S @FDARR@(1402)=$P(^TIU(8925,+PARENT,14),U,2)
 S @FDARR@(1205)=$P($G(TIU("LOC")),U)
 S @FDARR@(1212)=$P($G(TIU("INST")),U)
 S @FDARR@(.12)="@"
 S @FDARR@(1301)=+$G(TIU("LDT"))
 D FILE^DIE(FLAGS,"FDA","TIUMSG") ; File record
 Q
OVERDUE(TIUDA,TIUSTART,TIUEND) ;Checks whether or not a given document is overdue
 ;This is the same as OVERDUE^TIULC exept for the following items:
 ;    TIUPRM0 must be defined before calling
 ;    also checks for additional signatures overdue
 N TIUD0,TIUDATE,TIUY,TIUDPRM,TIUXTRA S TIUY=0,TIUD0=$G(^TIU(8925,TIUDA,0)),TIUXTRA=0
 D DOCPRM^TIULC1(+TIUD0,.TIUDPRM,TIUDA)
 I '$D(TIUDPRM) G OVERX
 S TIUDATE=$S($$REQVER^TIULC(TIUDA,+$P(TIUDPRM(0),U,3)):$P($G(^TIU(8925,+TIUDA,13)),U,5),$P(TIUDPRM(0),U,2):$P($G(^TIU(8925,+TIUDA,13)),U,4),1:$P($G(^TIU(8925,+TIUDA,12)),U))
 G:+TIUDATE'>0 OVERX
 I $$FMDIFF^XLFDT(DT,TIUDATE)>$P(TIUPRM0,U,5),(+$P($G(^TIU(8925,+TIUDA,0)),U,5)>4),(+$P($G(^TIU(8925,+TIUDA,0)),U,5)<7) S TIUY=1 G OVERX
 F  S TIUXTRA=$O(^TIU(8925.7,"B",TIUDA,TIUXTRA)) Q:'TIUXTRA  D
 . I TIUDATE<$G(TIUSTART)!(TIUDATE>$G(TIUEND)) Q
 . I '$$TSKPARM^TIUTSK(1) Q
 . I $$FMDIFF^XLFDT(DT,TIUDATE)>$P(TIUPRM0,U,5),('$P($G(^TIU(8925.7,TIUXTRA,0)),U,4)) S TIUY=1,TIUADDL=1
OVERX Q TIUY
TSKPARM(TIUDA) ;Calculate a tiu parameter for the nightly task
 ; TIUDA = 1 then return NIGHTLY TASK START computation
 ; TIUDA = 2 then return NIGHTLY TASK END computation
 N TIUDIV,TIUPARM,TIUY,TIUVAL
 S TIUY=0
 I TIUDA=2 S TIUY=DT
 I TIUDA=3 D DT^DILF("P","T-12M",.TIUY)
 I '$D(TIUPRM0) D SETPARM^TIULE
 I '$G(TIUPRM0) Q TIUY
 S TIUDIV=$P(TIUPRM0,U,1)
 I '$G(TIUDIV) Q TIUY
 S TIUPARM=$O(^TIU(8925.99,"B",TIUDIV,""))
 I '$G(TIUPARM) Q TIUY
 S TIUVAL=$P($G(^TIU(8925.99,TIUPARM,3)),U,TIUDA)
 I '$G(TIUVAL) Q TIUY
 D DT^DILF("P","T-"_TIUVAL,.TIUY)
 Q TIUY
