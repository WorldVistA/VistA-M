VBECDC01 ;hoifo/gjc-data conversion & pre-implementation;Nov 21, 2002
 ;;2.0;VBEC;;Jun 05, 2015;Build 4
 ;
 ;Medical Device #:
 ;Note: The food and Drug Administration classifies this software as a
 ;medical device.  As such, it may not be changed in any way.
 ;Modifications to this software may result in an adulterated medical
 ;device under 21CFR820, the use of which is considered to be a
 ;violation of US Federal Statutes.  Acquiring and implementing this
 ;software through the Freedom of Information Act requires the
 ;implementer to assume total responsibility for the software, and
 ;become a registered manufacturer of a medical device, subject to FDA
 ;regulations.
 ;
 ;Call to $$NEWERR^%ZTER is supported by IA: 1621
 ;Call to $$GOTLOCAL^XMXAPIG is supported by IA: 3006
 ;Call to $$GET1^DIQ is supported by IA: 2056
 ;Call to $$FMTE^XLFDT is supported by IA: 10103
 ;Call to $$NOW^XLFDT is supported by IA: 10103
 ;
EN(VBECCNV) ; entry point for both the pre-implementation and data
 ; conversion.
 ; Input: if VBECCNV evaluates to one, then the software
 ;        executes data conversion logic.  If VBECCNV evaluates
 ;        to zero, then the pre-implementation logic is executed.
 ;
 I $S($D(DUZ)[0:1,$D(DUZ(0))[0:1,'DUZ:1,DUZ=.5:1,1:0) W !!?3,$C(7),"DUZ & DUZ(0) must be defined to an active user (not POSTMASTER) in order to",!?3,"proceed." Q
 ;
 ; initialize error trap
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D ERR^VBECDCU1"
 E  S X="D ERR^VBECDCU1",@^%ZOSF("TRAP")
 ;
 ;If the data conversion process is selected to run, check the following
 ;conditions:
 ;
 ; a) If none of the VistA data been mapped prior to the data conversion
 ;    convey that information to the user and exit the data conversion
 ; b) check if mapped data remains consistent with data from the parent
 ;    (61.3 & 65.4) files.  If not, do not proceed with the
 ;    conversion
 ; c) check if the exported mail group has active local members (users
 ;    checked for activity within the last seven days)
 ; d) is there a process running that has not yet finished? If so, do
 ;    not allow another process to start (data conv. or anomaly check)
 ;
 I VBECCNV,$$NOMAP^VBECDCU2() Q  ;condition a
 I VBECCNV,$$EN^VBECDCHX() D  Q  ;condition b
 .W !!?3,"Mapping errors were identified; data conversion terminated."
 .Q
 I '$$GOTLOCAL^XMXAPIG("VBECS DATA CONVERSION",7) D  Q  ;condition c
 .W !!?3,"There must be at least one local user assigned to the VBECS"
 .W !?3,"DATA CONVERSION Mail Group.  This user must have been actively"
 .W !?3,"using VistA MailMan within the last seven (7) days.",$C(7)
 .Q
 ;
 I +$O(^VBEC(6001,0)) S VBECST=$$INPROC()
 I $L($G(VBECST)) D  K VBECST Q
 .W !!,"The "_$S($P(VBECST,U,2)=1:"data conversion",1:"pre-implementation")_" has been started on: "_$$FMTE^XLFDT($P(VBECST,U,3),"1P")
 .W !,"by: "_$$GET1^DIQ(200,+$P(VBECST,U),.01)_". This process must first complete"
 .W !,"before the "_$S(VBECCNV=1:"data conversion",1:"pre-implementation")_" can be run."
 .Q
 I VBECCNV D  I $D(VBECSTP) K VBECSTP Q  ;Only ask for database on conversion
  . W !!?3,"You must enter the name of the database "
  . W !?3,"where the converted data will be loaded."
  . W !!?3,"An invalid database name will cause a failure"
  . W !?3,"when loading the data into VBECS."
  . F  D  I $D(VBECSTP)!(VBECDBN]"") Q
  . . W !!!,?3 R "VBECS Database Name: ",VBECDBN  I VBECDBN=""!(VBECDBN["^") S VBECDBN="^",VBECSTP="" W !!?3,"Invalid database name. Conversion stopped." Q
  . . I VBECDBN?.E1C.E W !?4,"The database name cannot contain control characters.",!?4,"Please re-enter it." S VBECDBN=""
  . . I VBECDBN?1N.E W !?4,"The database name cannot begin with a number.",!?4,"Please re-enter it." S VBECDBN=""
  . . I $TR(VBECDBN,"_","")?.E1P.E W !?4,"The database name cannot contain punctuation except for an underscore.",!?4,"Please re-enter it." S VBECDBN=""
 ;
 I VBECCNV D  I $D(VBECSTP) K VBECSTP Q  ;Only ask for server on conversion
  . W !!?3,"You must enter the name of the server "
  . W !?3,"where the converted data will be loaded."
  . W !!?3,"An invalid server name will cause a failure"
  . W !?3,"when loading the data into VBECS."
  . F  D  I $D(VBECSTP)!(VBECDBN1]"") Q
  . . W !!!,?3 R "VBECS Server Name: ",VBECDBN1  I VBECDBN1=""!(VBECDBN1["^") S VBECDBN1="^",VBECSTP="" W !!?3,"Invalid server name. Conversion stopped." Q
  . . I VBECDBN1?.E1C.E W !?4,"The server name cannot contain control characters.",!?4,"Please re-enter it." S VBECDBN1=""
  . . I VBECDBN1?1N.E W !?4,"The server name cannot begin with a number.",!?4,"Please re-enter it." S VBECDBN1=""
  . . I $TR(VBECDBN1,"_-","")?.E1P.E W !?4,"The server name cannot contain punctuation except for an underscore (_) or dash (-).",!?4,"Please re-enter it." S VBECDBN1=""
 ;
 K VBECST W @IOF ;clear screen of past dialogue
 S (VBECDESC,ZTDESC)="VBECS "_$S(VBECCNV=1:"data conversion",1:"pre-implementation")
 W !?3,"The "_ZTDESC_" process will take some time to complete.",!?3,"It would be best if this process was run in the background.",!
 ;
 ; file the start time, process type, & user information into file 6001
 S VBECIEN=$$UP6001S^VBECDC02(+$E($$NOW^XLFDT(),1,12),VBECCNV,DUZ)
 I VBECIEN'>0 D  Q
 .W !!?3,"Error filing "_ZTDESC_" statistics.",$C(7) K ZTDESC,VBECIEN
 .Q
 ; kick off the task, queued or real-time
 S ZTRTN="START^VBECDC00",ZTSAVE("DUZ")="",ZTSAVE("VBECCNV")="",ZTSAVE("VBECDBN")="",ZTSAVE("VBECDBN1")=""
 S ZTSAVE("VBECIEN")="",ZTIO="" D ^%ZTLOAD
 ; display task number for user reference
 I +$G(ZTSK) W !!,VBECDESC_" task number: "_ZTSK,!
 E  D UP6001P^VBECDC02(VBECIEN) ;user exits prematurely
 K VBEC,VBECDESC,VBECIEN,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
 ;
STOPPED ; entry point executed when the user stops a task with TaskMan
 ; if the user stopped the process:
 ; 1-DATA CONVERSION ONLY delete all data in all related ^TMP globals
 ; 2-DATA CONVERSION ONLY set options back 'in-order'
 ; 3-alert the user to the stoppage
 ; 4-delete the record from the VBECS DATA
 ; INTEGRITY/CONVERSION STATISTICS (#6001) file.
 ;
 ; Variables used within this function:
 ;  VBECCNV-indicates if the data conversion (1) or data anomalies check
 ;          (0) is running
 ;      DUZ-the internal entry number of the person resposible for this
 ;          task
 ;  VBECIEN-is the IEN of the record in the VBECS DATA
 ;          INTEGRITY/CONVERSION STATISTICS (#6001) file
 ; VBECANOM-flag to indicate if anomalies exist (zero if no anomalies,
 ;          some number greater than zero if anomalies exist.)
 ;
 I VBECCNV D
 .D DELTMP($J) ;delete data in temporary globals ^TMP(,$J
 .D EN^VBECDC19(0) ;set options back in order, clear write nodes
 .Q
 ;next line performed for the anomaly check & data conversion
 D ALERT^VBECDCU(DUZ,VBECCNV,VBECANOM,"S"),UP6001P^VBECDC02(VBECIEN)
 Q
 ;
INPROC() ;is there a current data conversion or anomaly process on
 ;file that has not completed? If so, prevent this current request
 ;from starting (collision errors)
 N VBECI,VBEC0,VBECSTOP,VBECX
 S VBECI=$C(32),VBECSTOP=0,VBECX=""
 F  S VBECI=$O(^VBEC(6001,VBECI),-1) Q:'VBECI  D  Q:VBECSTOP
 .S VBEC0=$G(^VBEC(6001,VBECI,0))
 .I $P(VBEC0,U,3)="" S VBECX=$P(VBEC0,U,4)_U_$P(VBEC0,U,2)_U_$P(VBEC0,U)
 .I  S VBECSTOP=1
 .Q
 Q VBECX
 ;
DELTMP(DOLLARJ) ;Delete all Blood Bank Data in Temporary Globals
 ;
 N X S X="VBEC FINI"
 F  S VBECX=$O(^TMP(VBECX)) Q:VBECX=""!(VBECX]"VBEC63 zzz")  D
 .K ^TMP(VBECX,DOLLARJ)
 .Q
 Q
 ;
