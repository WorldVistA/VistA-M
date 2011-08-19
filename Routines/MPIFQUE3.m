MPIFQUE3 ;SF/TNV-Generate Batch message for comparison of CMOR score ;FEB 27, 1998
 ;;1.0; MASTER PATIENT INDEX VISTA ;**1,3**;30 Apr 99
 ;
COMP ; Create a batch CMOR request for comparing the CMOR score with the owner
 ; of this patient. This will be for ALL CMOR SITES. (NOT ONE SITE)
 ;
 N DIRUT
 S DIR("A")="This process will take a while to complete. Are you sure? "
 S DIR("B")="NO",DIR(0)="YAO" D ^DIR K DIR Q:$D(DIRUT)
 I Y=0 K DIR Q                           ; no go
 I $P($G(^RGSITE(991.8,1,"COMP")),"^")'="" S $P(^("COMP"),"^")=""
TASK ; Task this job to run
 S ZTIO="",ZTRTN="EN^MPIFQUE3",ZTSAVE("DUZ")=""
 S ZTDESC="GENERATE CMOR COMPARISON PROCESS"
 D ^%ZTLOAD
 I $D(ZTSK) W "   Task#, ",ZTSK," queued" S $P(^RGSITE(991.8,1,"COMP"),U,5)=ZTSK
 ;
KILL ; Clean up the partition
 K DIR,ZTSK,Y,ZTIO,ZTRTN,ZTDESC,ZTSAVE
 Q
 ;
EN ; Entry point for CMOR Batch comparison.  This should only be run after
 ; the initialization to the MPI has been completed.
 N U,SITE,NODE,MPI,MTIEN,MPILOOP,DTNOW,MSGCOUNT,LINCOUNT,RGLOG
 S U="^",(MPILOOP,SITE)="",MPISTOP=0
 D START^RGHLLOG()
 N X,Y,DIC
 S DIC="^VA(200,",DIC(0)="MZO",X="`"_+DUZ
 D ^DIC
 I $G(Y)<1 S MPINAME=""
 I $G(Y)>0 S MPINAME=$G(Y(0,0))
 ; If the job has manually stopped status it should restart at where
 ; it left off
 I $P($G(^RGSITE(991.8,1,"COMP")),U,4)="MS" D
 . I $P($G(^RGSITE(991.8,1,"COMP")),U)="" S $P(^("COMP"),U,4)="C" Q  ; Not logical restart from the top
 . S NODE=$$MPINODE^MPIFAPI(+$P(^RGSITE(991.8,1,"COMP"),U))
 . S CMOR=$P(NODE,U,3)   ; CMOR of the last patient
 . I +CMOR>0 S SITE=$O(^DPT("ACMOR",CMOR),-1)                        ; Back up one level
 . I +CMOR>0 S MPILOOP=+$P(^RGSITE(991.8,1,"COMP"),U)                ; Marked the last patient
 . I +CMOR<1 S (SITE,MPILOOP)=0
 . K CMOR
 ; If the job has completed status it should restart at the top
 I $P($G(^RGSITE(991.8,1,"COMP")),U,4)="C" S $P(^("COMP"),U)=""
 ; Start the job
 S ^XTMP("RGVCCMR","@@@@","DFNCOUNT")=0          ; set for counter in CALC^RGVCCMR2
 D NOW^%DTC S Y=X X ^DD("DD") S DTNOW=Y          ; get current date and time
 S $P(^RGSITE(991.8,1,"COMP"),U,2)=%             ; timestamp the job
 S $P(^RGSITE(991.8,1,"COMP"),U,4)="R"           ; mark the status as running
 S $P(^RGSITE(991.8,1,"COMP"),U,6)="N"           ; reset the flag
 N RGDFN,CALDT,NODE
 F  S SITE=$O(^DPT("ACMOR",SITE)) Q:SITE=""  D   ; Get the site CMOR on file
 . Q:MPISTOP=1                                   ; Trouble occured, user wanted to stop
 . I +SITE=+$$SITE^VASITE() Q                    ; Don't process your own
 . D HDR                                         ; Create batch for each site
 . F  S MPILOOP=$O(^DPT("ACMOR",+SITE,MPILOOP)) Q:MPILOOP=""  D  Q:MPISTOP=1  ; Start with DFN and go
 . . S DFN=+MPILOOP Q:DFN<0
 . . S NODE=$$MPINODE^MPIFAPI(DFN) Q:+NODE<1    ; Was not CIRN'ed
 . . I $G(^DPT(DFN,.35)),$P($G(^DPT(DFN,.35)),"^")'="" Q  ; Death patient
 . . I $P(NODE,"^")="" D LOG Q     ; Log exception if no ICN
 . . S CALDT=$P(NODE,"^",7)   ; current calc date
 . . I CALDT="" S CALDT=0
 . . S X="T-90" D ^%DT
 . . I CALDT<Y S RGDFN=DFN D CALC^RGVCCMR2   ; score is older than 90 days
 . . S $P(^RGSITE(991.8,1,"COMP"),U)=+DFN        ; mark that patient as done
 . . D INDV
 . . I MSGCOUNT>99 D SEND D HDR                   ; send out if over 100 messages
 . . I $P($G(^RGSITE(991.8,1,"COMP")),U,6)="Y" S MPISTOP=1 D SEND Q
 . I $O(^TMP("HLS",$J,0)) D SEND ;**3
 ;
 ; if user asked to stop set flag = yes and status to MS
 ; if naturally stop set status to SN
 I MPISTOP=1 S $P(^RGSITE(991.8,1,"COMP"),U,6)="Y",$P(^("COMP"),U,4)="MS"
 E  S $P(^RGSITE(991.8,1,"COMP"),U,4)="C"
 D NOW^%DTC S $P(^RGSITE(991.8,1,"COMP"),U,3)=%  ; timestamp when it stop
 D CLEAN
 D STOP^RGHLLOG()
 Q
 ;
HDR ; Create HL7 batch HEADER message to each of the CMOR site
 K ^TMP("HLS",$J)
 D INIT^HLFNC2("MPIF CMOR COMPARISON SERVER",.HL)
 I $D(HL)=1 D EXC^RGHLLOG(220,"Error Returned in INIT^HLFNC2") K HL S MPISTOP=1 Q
 D CREATE^HLTF(.HLMID,.MTIEN,.HLDT,.HLDT1)
 I $D(MTIEN)="" D EXC^RGHLLOG(220,"Error Returned in CREATE^HLTF") K HLMID,HLDT,HLDT1 S MPISTOP=1 Q
 S LINCOUNT=0                            ; Set line counter
 S MSGCOUNT=1                            ; Set counter for 100 message per batch
 Q
 ;
INDV ; Create individual message of the HL7 ADT-A31 batch message
 ; EVN segment = event, date, CMOR score, requestor name
 ; PID segment = standard call
 ; NTE segment = Reason CMOR COMPARISON, site requested
 D INIT^HLFNC2("MPIF CMOR COMPARISON SERVER",.HL)  ; Because HL7 did not know
 S HL("SAF")=$P($$SITE^VASITE,"^",3)       ; the facility # when dynamic
 ;                                              address of batch. This needs
 ;                                              to be set. Until HL7 fixs it
 S MPIID=HLMID_"-"_MSGCOUNT
 D MSH^HLFNC2(.HL,MPIID,.MPI)
 N NODE
 S LINCOUNT=LINCOUNT+1
 S ^TMP("HLS",$J,LINCOUNT)=MPI
 S LINCOUNT=LINCOUNT+1
 S NODE=$$MPINODE^MPIFAPI(DFN)
 Q:+NODE<1
 S ^TMP("HLS",$J,LINCOUNT)="EVN"_HL("FS")_"A31"_HL("FS")_$P(NODE,"^",7)_HL("FS")_$P(NODE,U,6)_HL("FS")_MPINAME
 S LINCOUNT=LINCOUNT+1
 S ^TMP("HLS",$J,LINCOUNT)=$$EN^VAFCPID(DFN,"2,3,5")
 S LINCOUNT=LINCOUNT+1
 ;this is the request to the site for a comparison
 S ^TMP("HLS",$J,LINCOUNT)="NTE"_HL("FS")_"COMPARISON"_HL("FS")_$P($$SITE^VASITE(),U,3)
 S MSGCOUNT=MSGCOUNT+1
 Q
 ;
SEND ; Send out the batch message
 N RESLT
 D GENERATE^HLMA("MPIF CMOR COMPARISON SERVER","GB",1,.RESLT,MTIEN)
 I $P(RESLT,U,2)'="" D EXC^RGHLLOG(220,"Error Returned in GENERATE^HLMA "_$P(RESLT,U,2)) S MPISTOP=1
 Q
 ;
LOGIC ; This is where the dynamic address located. 
 ; ** Routing logic field in Protocol file is being used
 ; instead of GET^HLSUB.
 ; For now, I have to hard set the receiving logical link, intercept
 ; the message before it send out, figure out the receiving Logical
 ; link from the MSH segment and let the Routing logic create the
 ; HLL("LINKS") array.
 N RESLT
 K RGL,RESLT
 D LINK^HLUTIL3(SITE,.RGL)               ; get the logical link to that institution
 S INSTITU=$O(RGL(0))
 I INSTITU<1 Q                           ; if there is no logical link
 I $E($G(RGL(INSTITU)),1,2)'="VA" D
 .D START^RGHLLOG()
 .D EXC^RGHLLOG(224,"Can't send CMOR Comparison message to site, due to non-CIRN logical link for site "_INSTITU)
 .D STOP^RGHLLOG()
 .S RESLT=1
 Q:$D(RESLT)
 S HLL("LINKS",1)="MPIF CMOR COMPARISON CLIENT"_HL("FS")_RGL(INSTITU)
 K INSTITU,RGL
 Q
 ;
CLEAN ; Clean up the partition
 K %,X,Y,MPISTOP,MPINAME,DFN,MPIID
 K ^XTMP("HLS",$J)
 Q
 ;
LOG ; Log exception for non ICN but CMOR belong to someone else
 N NAME,SSN,RGLOG,TEXT
 S XMCHAN=1,NAME=$P(^DPT(DFN,0),"^",1),SSN=$P(^(0),"^",9)
 S TEXT="This patient "_NAME_" ssn# "_SSN_" is missing the ICN. Log a NOIS regarding this missing ICN."
 D EXC^RGHLLOG(219,TEXT,DFN)
 K XMCHAN
 Q
 ;
STOP ; Stop/Restart the CMOR Comparison process
 I $P($G(^RGSITE(991.8,1,"COMP")),"^",4)'="R" D  Q
 . S DIR("A")="Do you want to RESTART this CMOR Comparison process"
 . S DIR("B")="N",DIR(0)="Y" D ^DIR
 . I $G(Y)=1 D TASK
 I $P($G(^RGSITE(991.8,1,"COMP")),"^",4)="R" D  Q
 . W !
 . S DIR("A")="Do you want to stop CMOR Comparison process after the current patient"
 . S DIR("B")="N",DIR(0)="Y" D ^DIR
 . I $G(Y)=1 S $P(^RGSITE(991.8,1,"COMP"),"^",6)="Y"
 Q
 ;
STATUS ; Where is the process right now?
 N IEN,NAME,SSN,STATUS,Y
 I $P($G(^RGSITE(991.8,1,"COMP")),"^",5)="" W !,"The CMOR Comparison process HAS NEVER been tasked" Q
 W !,"The CMOR Comparison process has been tasked with task # ",$P($G(^RGSITE(991.8,1,"COMP")),"^",5),". The"
 S STATUS=$P($G(^RGSITE(991.8,1,"COMP")),"^",4)
 W !,"process ",$S(STATUS="R":"is currently running",STATUS="MS":"was manually stopped",STATUS="C":"has completed",1:"")
 I (STATUS="C")!(STATUS="MS") S Y=$P($G(^RGSITE(991.8,1,"COMP")),"^",3) X ^DD("DD") W " on ",Y
 S IEN=$P($G(^RGSITE(991.8,1,"COMP")),"^")
 I IEN'="" D
 .S NAME=$P($G(^DPT(+IEN,0)),"^"),SSN=$P($G(^(0)),"^",9)
 .S CMOR=$P($G(^DPT(+IEN,"MPI")),"^",3)
 .S CMOR=$P($$NNT^XUAF4(CMOR),"^")
 .W " and the last patient",!,"was ",NAME," ssn # ",SSN," CMOR= ",CMOR
 Q
 ;
