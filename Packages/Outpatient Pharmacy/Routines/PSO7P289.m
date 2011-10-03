PSO7P289 ;CMF - PSO*7*289 Convert file 52.25/field 24 to pointer ;06/09/2008
 ;;7.0;OUTPATIENT PHARMACY;**289**;May 2008;Build 107
 ;;Reference to 9002313.25 supported by DBIA 5064
 ;
 N NAMSP,PATCH,JOBN,JOBDUZ,DTOUT,DUOUT,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,QUIT,Y,ZTQUEUED,ZTREQ,ZTSAVE
 S NAMSP=$$NAMSP
 S JOBN="Clarification Code Conversion"
 S JOBDUZ=$S($G(DUZ)'="":DUZ,1:.5)
 S PATCH="PSO*7*289"
 ;
 L +^XTMP(NAMSP):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I '$T D  Q
 . D BMES^XPDUTL(JOBN_" job is already running.  Halting...")
 . D MES^XPDUTL("")
 . D QUIT
 ;
 I '$D(^XTMP(NAMSP)) D INITXTMP(NAMSP,JOBN_", "_PATCH,90)        ;90 day life
 S QUIT=0
 ;
 I $G(^XTMP(NAMSP,0,"STATUS"))["Completed" D  Q
 . D BMES^XPDUTL("This conversion has been run before to completion on ")
 . D MES^XPDUTL($$FMTE^XLFDT($P($G(^XTMP(NAMSP,0,"STATUS")),"^",2))_".")
 . D MES^XPDUTL("If you want to run it again, do 'RESTORE^PSO7P289', then")
 . D MES^XPDUTL("the global subscript ^XTMP('"_NAMSP_"') must be")
 . D MES^XPDUTL("killed prior to doing so.")
 . D MES^XPDUTL("")
 . D MES^XPDUTL("It is strongly recommended you not do this.")
 . D QUIT
 ;
 ;I '$D(XPDQUES("POS1")) D  I 'ZTDTH D QUIT Q
 ;. K DIR
 ;. S DIR("A")="Enter when to Queue the "_JOBN_" to run."
 ;. S DIR("B")="NOW"
 ;. S DIR(0)="D^::%DT"
 ;. S DIR("?")="Enter when to start the job. This should be a time after the install has completed."
 ;. D ^DIR
 ;. I $D(DTOUT)!($D(DUOUT)) W !,"Halting..." S ZTDTH="" Q
 ;. S ZTDTH=$$FMTH^XLFDT(Y)
 ;
 ;I $D(XPDQUES("POS1")) S ZTDTH=$$FMTH^XLFDT(XPDQUES("POS1"))
 S ZTDTH=$$FMTH^XLFDT($$NOW^XLFDT)
 D BMES^XPDUTL("=============================================================")
 D MES^XPDUTL("Queuing background job for "_JOBN_"...")
 D MES^XPDUTL("Start time: "_$$HTE^XLFDT(ZTDTH))
 D MES^XPDUTL("==============================================================")
 I ZTDTH="" D BMES^XPDUTL(JOBN_" NOT QUEUED") D QUIT Q
 ;
 S:$D(^XTMP(NAMSP,0,"LAST")) ^XTMP(NAMSP,0,"ZAUDIT",$H)="RE-STARTED ON"_"^"_$$NOW^XLFDT_"^"_$P(^XTMP(NAMSP,0,"LAST"),"^",2,5)
 ;
 I $P($G(^XTMP(NAMSP,0,"LAST")),"^")="STOP" D
 . S $P(^XTMP(NAMSP,0,"LAST"),"^",1,2)="RUN^"_$$NOW^XLFDT
 E  D
 . S ^XTMP(NAMSP,0,"LAST")="RUN^"_$$NOW^XLFDT_"^^^"
 ;
 S ZTRTN="EN^PSO7P289"
 S ZTIO=""
 S ZTDESC="Background job for "_JOBN_" on prescriptions updated via "_PATCH
 S ZTSAVE("JOBN")=""
 S ZTSAVE("JOBDUZ")=""
 L -^XTMP(NAMSP)
 D ^%ZTLOAD
 D:$D(ZTSK)
 . D MES^XPDUTL("*** Task #"_ZTSK_" Queued! ***")
 . D BMES^XPDUTL("")
 D BMES^XPDUTL("")
 Q
QUIT ;
 L -^XTMP(NAMSP)
 ;
 Q
 ;
STATUS ;show status of job running
 I $$ST D
 . W !,"Currently processing:"
 . I $G(^XTMP($$NAMSP,0,"STATUS"))["Completed" D  Q
 . . W !,"Completed on ",$$FMTE^XLFDT($P($G(^XTMP($$NAMSP,0,"STATUS")),"^",2)),!
 . W !?5,"Rx being processed > ",$$GETD0
 . W !?5,"  Reject being processed > ",$$GETD1
 E  D
 .I $G(^XTMP($$NAMSP,0,"STATUS"))["Completed" D
 .. W !,"Completed on ",$$FMTE^XLFDT($P($G(^XTMP($$NAMSP,0,"STATUS")),"^",2)),!
 Q
 ;
STOP ;stop job command
 I $$ST D SETSTOP(1) D
 . W !,"CLARIFICATION CODE CONVERSION Job - set to STOP Soon"
 . W !!,"Check TASKMAN or Status to ensure it has stopped..."
 . W !,"     (D STATUS^PSO7P289)"
 Q
ST() ;status
 L +^XTMP($$NAMSP):3 I $T D  Q 0
 . L -^XTMP($$NAMSP)
 . W !,"*** NOT CURRENTLY RUNNING! ***",!
 Q 1
 ;
INITXTMP(NAMSP,TITLE,LIFE) ;create ^Xtmp according to SAC std
 N BEGDT,PURGDT
 S BEGDT=$$NOW^XLFDT()
 S PURGDT=$$FMADD^XLFDT(BEGDT,LIFE)
 S ^XTMP(NAMSP,0)=PURGDT_"^"_BEGDT_"^"_TITLE
 Q
 ;
NAMSP() ;
 Q $T(+0)
 ;
EN ;
 D CONVERT
 D REJECT
 Q
 ;
CONVERT ;
 Q:$P($G(^XTMP($$NAMSP,0,"STATUS")),U)="In Process"
 Q:$P($G(^XTMP($$NAMSP,0,"STATUS")),U)="Completed"
 D SETD0(0)
 D SETD1(0)
 D SETSTOP(0)
 D SETCWS
 S ^XTMP($$NAMSP,0,"STATUS")="In Process"_U_$$NOW^XLFDT
 S ^XTMP($$NAMSP,0,"JOBDUZ")=$G(JOBDUZ)
 S ^XTMP($$NAMSP,0,"JOBN")=$G(JOBN)
RESUME ;
 N RXIEN,REJIEN,OLDCODE,NEWCODE,NEWCODEE,DIE,DA,DR
 S RXIEN=$$GETD0
 F  S RXIEN=$O(^PSRX(RXIEN)) Q:'RXIEN!($$GETSTOP())  D
 .D SETD0(RXIEN)
 .D SETD1(0)
 .S REJIEN=$$GETD1
 .F  S REJIEN=$O(^PSRX(RXIEN,"REJ",REJIEN)) Q:'REJIEN  D
 ..D SETD1(REJIEN)
 ..S OLDCODE=$P(^PSRX(RXIEN,"REJ",REJIEN,0),U,15)
 ..Q:OLDCODE=""
 ..S NEWCODE=$$GETCW(OLDCODE)
 ..S NEWCODEE=$$GET1^DIQ(9002313.25,NEWCODE,.01)
 ..S DIE="^PSRX("_RXIEN_","_"""REJ"""_",",DA(1)=RXIEN,DA=REJIEN,DR="24///"_NEWCODEE D ^DIE
 ..S ^XTMP($$NAMSP,0,"LOG",RXIEN,REJIEN)=OLDCODE_U_NEWCODE
 I '$$GETSTOP() D
 .S ^XTMP($$NAMSP,0,"STATUS")="Completed"_U_$$NOW^XLFDT
 .D NOTIFY
 Q
 ;
REJECT ;
 N ERR
 D RESCH^XUTMOPT("PSO REJECTS BACKGROUND MESSAGE",$$FMADD^XLFDT($$NOW^XLFDT,1),"","24H","L",.ERR)
 Q
 ;
NOTIFY ; build mail message
 N XMSUB,XMDUZ,XMTEXT,XMY,I,RXIEN,REJIEN,RX,OLDVALUE,NEWVALUE,NEWDESC
 S XMSUB="PSO*7*289 Clarification Code Conversion Results"
 S XMDUZ="OUTPATIENT PHARMACY PACKAGE"
 S XMTEXT="^TMP($J,""PSO7P289"",""NOTIFY"","
 S XMY(^XTMP($$NAMSP,0,"JOBDUZ"))=""
 K ^TMP($J,"PSO7P289","NOTIFY")
 S ^TMP($J,"PSO7P289","NOTIFY",1)="The Clarification Code Conversion queued install routine for patch"
 S ^TMP($J,"PSO7P289","NOTIFY",2)="PSO*7*289 has completed.  This message lists edited prescriptions."
 S ^TMP($J,"PSO7P289","NOTIFY",3)=""
 S ^TMP($J,"PSO7P289","NOTIFY",4)="The 'Old Value' column contains the internal set of codes value for"
 S ^TMP($J,"PSO7P289","NOTIFY",5)="CLARIFICATION CODE field (#24) of REJECT INFO Multiple (#52.25) of"
 S ^TMP($J,"PSO7P289","NOTIFY",6)="PRESCRIPTION file (#52). Possible old values consist of:"
 S ^TMP($J,"PSO7P289","NOTIFY",7)=""
 S ^TMP($J,"PSO7P289","NOTIFY",8)=$$RJ^XLFSTR("CODE",10)_"   DESCRIPTION"
 S ^TMP($J,"PSO7P289","NOTIFY",9)=$$RJ^XLFSTR("====",10)_"   ======================="
 S ^TMP($J,"PSO7P289","NOTIFY",10)=$$RJ^XLFSTR("0",10)_"   FOR NOT SPECIFIED"
 S ^TMP($J,"PSO7P289","NOTIFY",11)=$$RJ^XLFSTR("1",10)_"   NO OVERRIDE"
 S ^TMP($J,"PSO7P289","NOTIFY",12)=$$RJ^XLFSTR("2",10)_"   OTHER OVERRIDE"
 S ^TMP($J,"PSO7P289","NOTIFY",13)=$$RJ^XLFSTR("3",10)_"   VACATION SUPPLY"
 S ^TMP($J,"PSO7P289","NOTIFY",14)=$$RJ^XLFSTR("4",10)_"   LOST PRESCRIPTION"
 S ^TMP($J,"PSO7P289","NOTIFY",15)=$$RJ^XLFSTR("5",10)_"   THERAPY CHANGE"
 S ^TMP($J,"PSO7P289","NOTIFY",16)=$$RJ^XLFSTR("6",10)_"   STARTER DOSE"
 S ^TMP($J,"PSO7P289","NOTIFY",17)=$$RJ^XLFSTR("7",10)_"   MEDICALY NECESSARY"
 S ^TMP($J,"PSO7P289","NOTIFY",18)=$$RJ^XLFSTR("8",10)_"   PROCESS COMPOUND"
 S ^TMP($J,"PSO7P289","NOTIFY",19)=$$RJ^XLFSTR("9",10)_"   ENCOUNTERS"
 S ^TMP($J,"PSO7P289","NOTIFY",20)=""
 S ^TMP($J,"PSO7P289","NOTIFY",21)="The 'New Value' column is the equivalent pointer to file 9002313.25."
 S ^TMP($J,"PSO7P289","NOTIFY",22)="The 'New Value Description' describes the value."
 S ^TMP($J,"PSO7P289","NOTIFY",23)=""
 S ^TMP($J,"PSO7P289","NOTIFY",24)=$$RJ^XLFSTR("Reject",28)_$$RJ^XLFSTR("Old",7)_$$RJ^XLFSTR("New",7)
 S ^TMP($J,"PSO7P289","NOTIFY",25)=$$RJ^XLFSTR("RXien",10)_$$RJ^XLFSTR("RX#",10)_$$RJ^XLFSTR("Ien",8)_$$RJ^XLFSTR("Value",7)_$$RJ^XLFSTR("Value",7)_"   New Value Description"
 S ^TMP($J,"PSO7P289","NOTIFY",26)="============================================================================="
 S I=26
 S RXIEN=0
 F  S RXIEN=$O(^XTMP($$NAMSP,0,"LOG",RXIEN)) Q:'RXIEN  D
 .S RX=$$GET1^DIQ(52,RXIEN,.01)
 .S REJIEN=0
 .F  S REJIEN=$O(^XTMP($$NAMSP,0,"LOG",RXIEN,REJIEN)) Q:'REJIEN  D
 ..S I=I+1
 ..S OLDVALUE=$P(^XTMP($$NAMSP,0,"LOG",RXIEN,REJIEN),"^",1)
 ..S NEWVALUE=$P(^XTMP($$NAMSP,0,"LOG",RXIEN,REJIEN),"^",2)
 ..S NEWDESC=$$GET1^DIQ(9002313.25,NEWVALUE,.02)
 ..S ^TMP($J,"PSO7P289","NOTIFY",I)=$$RJ^XLFSTR(RXIEN,10)_$$RJ^XLFSTR(RX,10)_$$RJ^XLFSTR(REJIEN,8)_$$RJ^XLFSTR(OLDVALUE,7)_$$RJ^XLFSTR(NEWVALUE,7)_"   "_NEWDESC
 D ^XMD
 K ^TMP($J,"PSO7P289","NOTIFY")
 Q
 ;;
RESTORE ; restore old set of code values (backstop)
 N RXIEN,REJIEN,OLDVALUE,DIE,DA,DR
 S RXIEN=0
 F  S RXIEN=$O(^XTMP($$NAMSP,0,"LOG",RXIEN)) Q:'RXIEN  D
 .S REJIEN=0
 .F  S REJIEN=$O(^XTMP($$NAMSP,0,"LOG",RXIEN,REJIEN)) Q:'REJIEN  D
 ..S OLDVALUE=$P(^XTMP($$NAMSP,0,"LOG",RXIEN,REJIEN),"^",1)
 ..S DIE="^PSRX("_RXIEN_","_"""REJ"""_",",DA(1)=RXIEN,DA=REJIEN,DR="24///"_OLDVALUE D ^DIE
 K ^XTMP($$NAMSP,0,"LOG")
 Q
 ;;
SETD0(VALUE) ;;
 S ^XTMP($$NAMSP,0,"LASTD0")=VALUE
 Q
 ;
GETD0() ;;
 Q ^XTMP($$NAMSP,0,"LASTD0")
 ;
SETD1(VALUE) ;;
 S ^XTMP($$NAMSP,0,"LASTD1")=VALUE
 Q
 ;
GETD1() ;
 Q ^XTMP($$NAMSP,0,"LASTD1")
 ;
SETCWS ;set cross-walk values
 ;;'0' FOR NOT SPECIFIED; 
    ;;'1' FOR NO OVERRIDE; 
    ;;'2' FOR OTHER OVERRIDE; 
    ;;'3' FOR VACATION SUPPLY; 
    ;;'4' FOR LOST PRESCRIPTION; 
    ;;'5' FOR THERAPY CHANGE; 
    ;;'6' FOR STARTER DOSE; 
    ;;'7' FOR MEDICALLY NECESSARY; 
    ;;'8' FOR PROCESS COMPOUND; 
    ;;'9' FOR ENCOUNTERS; 
    ;;'99' FOR OTHER;
    N I
    F I=0:1:9,99 D SETCW(I)
    Q 
 ;;
SETCW(VALUE) ;;
 N POINTER
 S POINTER=$O(^BPS(9002313.25,"B",VALUE,0))
 S ^XTMP($$NAMSP,0,"CW",VALUE)=POINTER
 ;;
GETCW(VALUE) ;get cross-walk value
 I $G(VALUE)="" Q ""
 Q $G(^XTMP($$NAMSP,0,"CW",VALUE))
 ;;
SETSTOP(VALUE) ;;
 S ^XTMP($$NAMSP,0,"STOP")=VALUE
 S:+VALUE ^XTMP($$NAMSP,0,"STATUS")="Stopped"_U_$$NOW^XLFDT
 Q
 ;;
GETSTOP() ;
 Q ^XTMP($$NAMSP,0,"STOP")
 ;;
DESP ;delete ePharmacy site parameter file if it exists
 ;; This utility is used a pre-install routine for PSO*7*289 patch to delete file 52.86 if it
 ;; exists so that the security parameters on the file may be updated to allow user read access.
 Q:'$D(^PS(52.86))
 D MES^XPDUTL(" ")
 D MES^XPDUTL("Updating security parameters for ePharmacy Site Parameter file (#52.86).")
 D MES^XPDUTL(" ")
 S DIU="52.86",DIU(0)="E" D EN^DIU2 K DIU
 D MES^XPDUTL("Recreating the DATA DICTIONARY...   File 52.86 update is complete.")
 Q
