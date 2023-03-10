PSO613P ;MCF - PSO*7*613 POST-INSTALL ROUTINE TO CLEAN UP CLOZAPINE REGISTRATION DATE. ;12/04/20
 ;;7.0;OUTPATIENT PHARMACY;**613**;DEC 1997;Build 10
 ;
 ; ICRs:
 ;
 Q
 ;
FGRND ; Run in foreground
 N FGRND S FGRND=1
QUE ; Task to background
 N NAMSP,PATCH,JOBN,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,Y,ZTQUEUED,ZTREQ,ZTSAVE,SBJM,RESTART
 S NAMSP="PSO613P"
 S JOBN="PSO*7*613 Post Install"
 S PATCH="PSO*7*613"
 S Y=$$NOW^XLFDT S ZTDTH=$$FMTH^XLFDT(Y)
 ;
 D BMES^XPDUTL("=============================================================")
 D MES^XPDUTL("Queuing background job for "_JOBN_"...")
 D MES^XPDUTL("Start time: "_$$HTE^XLFDT(ZTDTH))
 D MES^XPDUTL("A MailMan message will be sent to the installer upon Post")
 D MES^XPDUTL("Install Completion.  This may take 4-5 minutes.")
 D MES^XPDUTL("==============================================================")
 ;
 S SBJM="Foreground job for "_JOBN
 I $G(FGRND) D EN Q
 S (SBJM,ZTDESC)="Background job for "_JOBN
 S ZTRTN="EN^"_NAMSP,ZTIO=""
 S ZTSAVE("JOBN")="",ZTSAVE("ZTDTH")="",ZTSAVE("DUZ")="",ZTSAVE("SBJM")=""
 D ^%ZTLOAD
 D:$D(ZTSK)
 . D MES^XPDUTL("*** Task #"_ZTSK_" Queued! ***")
 . D BMES^XPDUTL("")
 . S ZTSAVE("ZTSK")=""
 D BMES^XPDUTL("")
 K XPDQUES
 Q
EN ; Main entry point to clean up clozapine registration date.
 N PSDFN,PSVAL,PSCNT,PSNEW,PSREG,STARTH
 S STARTH=$$HTE^XLFDT($S($G(ZTDTH):ZTDTH,1:$H))
 D INIT
 D REGDATE
 D MAIL
 Q
REGDATE ; LOOP THROUGH #55 and find bad date time stamps
 S PSDFN=0
 F  S PSDFN=$O(^PS(55,PSDFN)) Q:PSDFN=""  D
 .  S PSVAL=$$GET1^DIQ(55,PSDFN,58,"I")
 .  I ($G(PSVAL))&(PSVAL[".") D
 .  .  S PSCNT=PSCNT+1
 .  .  W:PSCNT#10 "."
 .  .  S PSNEW=$P(PSVAL,".",1)
 .  .  S PSREG(55,PSDFN_",",58)=PSNEW
 .  .  S ^XTMP("PSO613P",PSNOW,"^PS(55,DFN,SAND)",PSDFN)=PSVAL
 D FILE^DIE("","PSREG","PSERR")    ; update existing entries
 Q
MAIL ;Send message
 N DIFROM,XMDUZ,XMSUB,XMTEXT,XMY,I
 S Y=$$NOW^XLFDT S STOPH=$$FMTH^XLFDT(Y),STOPH=$$HTE^XLFDT(STOPH)
 S XMDUZ="PSO*7.0*613 POST INSTALL Complete"
 S XMY(DUZ)=""
 S ^TMP("PSOTEXT",$J,1)="The background job "_+$G(ZTSK)_" began "_STARTH_" and "
 S ^TMP("PSOTEXT",$J,2)="ended "_STOPH_"."
 S ^TMP("PSOTEXT",$J,3)="Cleanedup "_PSCNT_" entries."
 S XMDUZ="OUTPATIENT PHARMACY",XMSUB=SBJM,XMTEXT="^TMP(""PSOTEXT"","_$J_","
 S XMY(DUZ)=""
 D ^XMD
 K ^TMP("PSOTEXT",$J)
 Q
RESTORE ; LOOP THROUGH ^XTMP and RESTORE bad date time stamps
 N PSCNT,PSDFN,PSLAST,PSVAL,REG,PSVAL
 ;K
 I '$G(ZTSK) D BMES^XPDUTL("Restoring")
 S (PSCNT,PSDFN)=0
 S PSLAST=$O(^XTMP("PSO613P",""),-1)
 D BMES^XPDUTL("Last restore point was "_PSLAST)
 F  S PSDFN=$O(^XTMP("PSO613P",PSLAST,"^PS(55,DFN,SAND)",PSDFN)) Q:PSDFN=""  S PSVAL=$G(^(PSDFN)) D
 . S PSCNT=PSCNT+1
 . W:PSCNT#10 "."
 . S PSREG(55,PSDFN_",",58)=PSVAL
 D FILE^DIE("","PSREG","PSERR")    ; update existing entries
 I '$G(ZTSK) D BMES^XPDUTL("Restored "_PSCNT_" entries.")
 Q
INIT ; Initialize variables DGPREFIX, DGSRVR, DGREGION, and DGKEY
 ; 
 S PS90=$$FMADD^XLFDT($$DT^XLFDT,90),PSNOW=$$NOW^XLFDT
 S PSDESC="CLOZAPINE - BAD REGISTRATION DATE CLEAN-UP"
 S ^XTMP("PSO613P",0)=PS90_"^"_PSNOW_"^"_PSDESC
 S PSCNT=0
 I '$G(ZTSK) D BMES^XPDUTL(">VARIABLES INITIALIZED")
 I '$G(ZTSK) D BMES^XPDUTL("Restore point at "_PSNOW)
 Q
REIX5252 ; Reindex new AC Mumps type cross reference in file 52.52
 N DIK
 S DIK="^PS(52.52,"
 S DIK(1)=".01^AC"
 D ENALL^DIK
 Q
