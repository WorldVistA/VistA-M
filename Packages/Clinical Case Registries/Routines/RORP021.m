RORP021 ;ALB/TK  ENV CK, PRE and POST INSTALL - PATCH 21 ;09/12/2013
 ;;1.5;CLINICAL CASE REGISTRIES;**21**;Feb 17, 2006;Build 45
 ;
 ;*****************************************************************************
 ;*****************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE       DEVELOPER    MODIFICATION
 ;-----------  ---------  -----------  ----------------------------------------
 ;ROR*1.5*21   NOV 2013   T KOPP       Added routine for env check, pre/post
 ;                                     install
 ;                                               
 ;******************************************************************************
 ;******************************************************************************
 ; 
 ; SUPPORTED CALLS:
 ;  RTN^%ZTLOAD   #10063
 ;  STAT^%ZTLOAD  #10063
 ;  BMES^XPDUTL   #10141
 ;  BLD^DIALOG    #2050
 ;
ENV ;  Environment check
 S XPDNOQUE=1 ; disable queuing
 Q
 ;
PRE ; Patch pre-install
 N RC,ZTSK,RORBUF
 ; Check for ROR INITIALIZE task running
 D BMES^XPDUTL("   *** Checking to be sure ROR INITIALIZE task is not already running")
 S RC=0
 D RTN^%ZTLOAD("RORSET02","RORBUF")
 S ZTSK="" F  S ZTSK=$O(RORBUF(ZTSK)) Q:ZTSK=""  D  I $G(ZTSK(1))=2 S RC=-1 Q
 . D STAT^%ZTLOAD
 ;--- Display error message if option is running
 I RC<0  D  S XPDABORT=2 Q
 . D BMES^XPDUTL($$MSG^RORERR20(RC,,XPDNM))
 . D BMES^XPDUTL("    ROR INITIALIZE task is already running.  Task # is "_ZTSK)
 . D BMES^XPDUTL("    This task must complete or be terminated before the install can continue")
 . D BMES^XPDUTL("    Restart this patch install when this task is not running")
 . D BMES^XPDUTL(""),BMES^XPDUTL("")
 Q
 ;
POST ; Patch post-install
 N RORKIDS,REGIEN,RORREG,RORERR,DIERR,CT,Z
 S RORKIDS=1
 ; Set up registries params for initialization
 F RORREG="VA APNEA" D
 . S REGIEN=$$REGIEN^RORUTL02(RORREG)
 . I REGIEN>0 D
 .. K RORFDA,RORMSG
 .. S RORFDA(798.1,REGIEN_",",1)=2850101
 .. S RORFDA(798.1,REGIEN_",",21.05)=""
 .. S RORFDA(798.1,REGIEN_",",19.1)=""
 .. D UPDATE^DIE(,"RORFDA",,"RORMSG")
 .. I $G(DIERR) D
 ... D DBS^RORERR("RORMSG",-112,,,798.1,REGIEN)
 ... K RORERR
 ... S RORERR(1)="     New registry "_RORREG_"(ien #"_REGIEN_") encountered the following error"
 ... S RORERR(2)="     and may not initialize correctly.  Please report this error to your CCR contact:"
 ... S RORERR(3)=""
 ... S Z=0,CT=3 F  S Z=$O(RORMSG("DIERR",1,"TEXT",Z)) Q:'Z  S CT=CT+1,RORERR(CT)=$J("",10)_$G(RORMSG("DIERR",1,"TEXT",1))
 ... D MES^XPDUTL(.RORERR)
 D ^RORSET02
 Q
 ;
 ; Sets the DIR array from the post-install question #3 (suspension start time)
POSQ3(DIR) ;
 K:$G(XPDQUES("POSQ2"))'=1 DIR
 Q:'$D(DIR)
 D BLD^DIALOG(7980000.011,,,"DIR(""?"")","S")
 Q
 ;
 ; Sets the DIR array from the post-install question #4  (suspension end time)
POSQ4(DIR) ;
 K:$G(XPDQUES("POSQ2"))'=1 DIR
 Q:'$D(DIR)
 S DIR("A")="Suspension end time"
 ;  Make sure end time entered is later than end time start
 S DIR(0)="D^::R^K:(Y#1)'>(XPDQUES(""POSQ3"")#1) X"
 D BLD^DIALOG(7980000.012,,,"DIR(""?"")","S")
 Q
 ;
 ; Updates the DIR array from the post-install question #5  (schedule time for ROR INITIALIZE task)
POSQ5(DIR) ;
 Q:'$D(DIR)
 N ROREDT
 ; Set earliest date to schedule to 15 minutes from 'NOW'
 S ROREDT=$$FMADD^XLFDT($$NOW^XLFDT(),,,15)
 ; Strip seconds
 S ROREDT=$P(ROREDT,".",1)_"."_$E($P(ROREDT,".",2),1,4)
 ;  Make sure future date/time is entered
 S $P(DIR(0),U,3)=("K:Y<"_ROREDT_" X")
 S DIR("B")=$$FMTE^XLFDT(ROREDT,2)
 Q
 ;
