MPIFQUE4 ;SF/TNV-Process the CMOR COMPARISON request ;FEB 25, 1998
 ;;1.0; MASTER PATIENT INDEX VISTA ;**1,3,11,24,27**;30 Apr 99
 ;
 ; Integration Agreements Utilized:
 ;
 ;   EXC^RGHLLOG     IA #2796
 ;   START^RGHLLOG   IA #2796
 ;   STOP^RGHLLOG    IA #2796
 ;   CALC^RGVCCMR2   IA #2710
 ;   $$EN^VAFCPID    IA #3015
 ;   ^DGCN(391.91    IA #2751
 ;   FILE^VAFCTFU    IA #2988
 ; 
 ; This routine will process the batch message from the sending CMOR
 ; who wished to change the patient CMOR from you to their own.
 ; PLEASE NOTE THAT THIS PROCESS WILL NOT BE TRACKED AS CMOR REQUEST
 ; EVENT. SO NOTHING WILL BE RECORDED IN THAT FILE. (PER SRS 9-18-97)
 ; Approving process:
 ; The sender will give the CMOR score and the date for a patient
 ; The receiver will look into the CMOR score on the system and compare
 ; the date if the date is less than 90 days. Go and use the Current
 ; CMOR score and compare. If the incoming CMOR score is 80% or more than
 ; the system CMOR score. CMOR site will be changed to the requesting CMOR
 ; site. An approved HL7 message will be send to ALL SITES in the
 ; subscriber list and notify them the new CMOR site. MPI is included.
 ; If the score is equal or greater than 90 days. CMOR score will be
 ; recalulated for this patient and compare. Same process as above.
 ; If the incoming CMOR score is not higher than 80% nothing will happen.
BEGIN ; Entry point for CMOR COMPARISON request to process.
 ; NO input or output variables
 N IEN,RGLOG
 K RGL
 D NOW^%DTC
 S ZTIO="",ZTDTH=%,ZTRTN="EN^MPIFQUE4"
 S ZTDESC="BACKGROUND CMOR COMPARISON"
 S ZTSAVE("HL*")=""
 D ^%ZTLOAD,CLEAN
 K COUNT,RGL,%,ZTIO,ZTDTH,ZTRTN,ZTDESC,ZTSAVE
 Q
 ;
EN ; Background job to run for cmor comparison
 K ERROR,MPICNT
 N MPII,U,LINE,PARENT,COUNT,NDATE,IKI,MPIFFS,MPIFSFS,MPIFREAP,RGLOG
 S MPIFFS=HL("FS"),MPIFSFS=$E(HL("ECH"),1),MPIFREAP=$E(HL("ECH"),2)
 D START^RGHLLOG()
 S U="^",(COUNT,MPICNT)=0
 F MPII=1:1 X HLNEXT Q:HLQUIT'>0!($D(ERROR))  G:$$S^%ZTLOAD CLEAN D
 . S LINE=HLNODE
 . I $P(LINE,MPIFFS)["MSH" D MSH
 . I $P(LINE,MPIFFS)["NTE" D NTE
 . I $P(LINE,MPIFFS)["PID" D PID
 . I $P(LINE,MPIFFS)["EVN" D EVN
 . I COUNT=4,'$D(ERROR) D PROCES
 K SERVER,CLIENT,ERROR
 D STOP^RGHLLOG()
 S ZTREQ="@"
 Q
 ;
MSH ; Process MSH segment
 S COUNT=COUNT+1
 Q
 ;
NTE ; Process NTE segment
 S COUNT=COUNT+1
 S SITE=$P(LINE,MPIFFS,3)
 I SITE="" S ERROR="HL7 Msg# "_$G(HL("MID"))_" is missing CMOR for ICN# "_$G(ICN) D EXC^RGHLLOG(221,ERROR) Q
 S REASON=$P(LINE,MPIFFS,2)
 I REASON'="COMPARISON" S ERROR="HL7 Msg# "_$G(HL("MID"))_" contained a unknown request reason for ICN# "_$G(ICN) D EXC^RGHLLOG(222,ERROR)
 Q
 ;
PID ; Process PID segment
 N NODE
 S COUNT=COUNT+1
 S ICN=+$P(LINE,MPIFFS,3)   ; get ICN out.
 I ICN="" S ERROR="HL7 Msg# "_$G(HL("MID"))_" contains a null ICN in a PID segment." D EXC^RGHLLOG(219,ERROR) Q
 S DFN=$$IEN^MPIFNQ(ICN)                  ; get DFN of this patient
 I DFN="" S ERROR="Can't Process CMOR Compare for Patient with ICN "_ICN_". ICN not at this site. HL7 Message#: "_HLMTIEN D EXC^RGHLLOG(219,ERROR) Q
 S NODE=$$MPINODE^MPIFAPI(+DFN)
 S CMOR=$P(NODE,"^",3)               ; get the CMOR of this patient
 S SCORE=$P(NODE,"^",6),NDATE=$P(NODE,"^",7)
 ; if no score or score date recalc score and reset variables
 I SCORE=""!(NDATE="") N RGDFN S RGDFN=DFN D CALC^RGVCCMR2
 S NODE=$$MPINODE^MPIFAPI(+DFN),SCORE=$P(NODE,"^",6),NDATE=$P(NODE,"^",7)
 Q
 ;
EVN ; Process EVN segment
 S COUNT=COUNT+1
 S X=$P(LINE,MPIFFS,3) D ^%DT S INDATE=Y
 I INDATE=-1 S ERROR="CMOR score Date was missing for DFN "_DFN_" in CMOR Compare Inbound Message" Q
 S INSCORE=$P($G(LINE),MPIFFS,4)
 I INSCORE="" S INSCORE=0
 Q
 ;
PROCES ; Process one complete message (MSH,PID,EVN,NTE)
 N LIMIT
 I $G(ERROR)]"" D CLEAN Q                ; Don't do anything if there is an error
 S X="T-90" D ^%DT                       ; get the target date
 I NDATE>Y D  Q                           ; RECORDED DATE is less than 90 days
 . S LIMIT=$$PERCENT(INSCORE,SCORE)      ; Incoming CMOR score is above 80%
 . I (LIMIT>80.5)&(INSCORE>SCORE) D CHANGE                 ; Incoming CMOR score is greater
 . D CLEAN                               ; Incoming CMOR score is LESS
 N RGDFN S RGDFN=DFN D CALC^RGVCCMR2                         ; Last calculation was greater than 90 days
 S SCORE=$P($$MPINODE^MPIFAPI(DFN),"^",6)    ; Get the latest score
 S LIMIT=$$PERCENT(INSCORE,SCORE)        ; Incoming CMOR score is above 80%
 I (LIMIT>80.5)&(INSCORE>SCORE) D CHANGE                   ; Incoming CMOR score is greater
 D CLEAN                                 ; Incoming CMOR score is LESS than the latest score
 Q
 ;
PERCENT(NUM1,NUM2) ; Calculate the percent difference 80% or more need for change
 ; of CMOR number
 N DIF
 I NUM1="" S NUM1=0
 I NUM2="" S NUM2=0
 Q:$$MAX^XLFMTH(NUM1,NUM2)=0 0
 S DIF=(100-(($$MIN^XLFMTH(NUM1,NUM2))/($$MAX^XLFMTH(NUM1,NUM2))*100))
 Q DIF
 ;
CHANGE ; Process the change CMOR request to the new CMOR site and Send out 
 ; notification to the Subscriber list and MPI.
 N CHANGE,MPIFSITE S MPIFSITE=$$LKUP^XUAF4(SITE)  ;get INSTITUTION (#4) IEN
 I MPIFSITE=-1 S ERROR="HL7 Msg#"_$G(HL("MID"))_" contained an invalid STATION#"_$G(SITE)_" for ICN#"_$G(ICN) D EXC^RGHLLOG(211,ERROR,+DFN) Q
 S CHANGE=$$CHANGE^MPIF001(+DFN,MPIFSITE)
 I +CHANGE<1 S ERROR="Unable to change CMOR in HL7 Msg#"_$G(HL("MID"))_" from "_$P($$SITE^VASITE,"^",3)_" To "_$G(SITE)_" due to "_$P(CHANGE,"^",2) D EXC^RGHLLOG(211,ERROR,DFN) Q
 S SERVER="MPIF CMOR RESULT SERVER",CLIENT="MPIF CMOR RESULT CLIENT"
 D INIT^HLFNC2(SERVER,.HL)
 I $G(HL) S ERROR=HL D EXC^RGHLLOG(220,ERROR,DFN) Q
 D LINK
 I $G(RESULT)=0 K RESULT Q
 S HLA("HLS",1)=$$EN^VAFCPID(+DFN,"2,3,4,5,6,7,8,9,10")
 S HLA("HLS",2)="EVN"_HL("FS")_"A31"_HL("FS")_INDATE_HL("FS")_INSCORE_HL("FS")_"POSTMASTER"
 ;actually change the cmor
 S HLA("HLS",3)="PV1"_HL("FS")_HL("FS")_HL("FS")_SITE_HL("FS")_HL("FS")_HL("FS")_$P($$NNT^XUAF4(CMOR),"^",2)
 N RESLT
 D GENERATE^HLMA(SERVER,"LM",1,.RESLT)
 I $P(RESLT,U,2)'="" D EXC^RGHLLOG(220,"Error returned in GENERATE^HLMA  "_$P(RESLT,U,2),DFN)
 K RESULT
 S MPICNT=MPICNT+1 ;counting changes in CMOR
 Q
 ;
LINK ; Give back the TF list in HLL(LINKS") array for this patient
 N CMOR,SUB,IEN,MPILINK,MPITF,PID,CST
 K RGL
 S RGL(0)=""
 S PID=$$GETDFN^MPIF001(ICN)
 S CMOR=$$GETVCCI^MPIF001(PID),CST=$$IEN^XUAF4(CMOR)
 I '$D(^DGCN(391.91,"APAT",PID,CST)) D FILE^VAFCTFU(PID,CST,1)
 S X=$$QUERYTF^VAFCTFU1($G(ICN),"MPITF")
 ;LOOP THOUGH TF LIST AND GET LINK FOR EACH
 N LP,CNT,STN,MPIFHL S CNT=1,LP=0 K ERROR
 F  S LP=$O(MPITF(LP)) Q:LP=""  D
 .S STN=$$STA^XUAF4($G(MPITF(LP)))
 .Q:$P($$SITE^VASITE(),"^",3)=STN
 .K MPIFHL D LINK^HLUTIL3(+$G(MPITF(LP)),.MPIFHL)
 .I '$O(MPIFHL(0)) S ERROR="-1^Unknown Logical Link for Station # "_STN_" Unable to notify of Change of CMOR for patient "_DFN
 .I $D(ERROR) D EXC^RGHLLOG(224,ERROR,DFN) K ERROR Q
 .S HLL("LINKS",CNT)=CLIENT_"^"_$P(MPIFHL($O(MPIFHL(0))),"^"),CNT=CNT+1
 S MPILINK=$$MPILINK^MPIFAPI()
 I +MPILINK=-1 D EXC^RGHLLOG(224,"No MPI Link defined",DFN) Q
 S HLL("LINKS",9999)=CLIENT_U_MPILINK
 Q
CLEAN ; Clean up the partition and ready for the next message
 D STOP^RGHLLOG()
 K RGL,EVENT,SITE,REASON,ICN,DFN,CMOR,SCORE,X,Y,INDATE,INSCORE
 S COUNT=0
 Q
CHKSUB(DFN,FAC) ;check for an existing subscription if one does not exist add it
 Q
 ;;^ NO LONGER TO BE USED
 N MPIFSCN,MPIF,MPIFLL,MPIFLLI,MPIFLLN,FLAG,LOOP,HLER
 Q:FAC=""
 Q:DFN=""
 Q:FAC=+$$SITE^VASITE  ;don't add subscription for yourself
 S MPIFSCN=$$GETSCN(DFN)
 D GET^HLSUB(MPIFSCN,0,"MPIF CMOR RESULT CLIENT",.MPIFLL)
 D LINK^HLUTIL3("`"_FAC,.MPIF,"I") S MPIFLLI=$O(MPIF(0)) S MPIFLLN=MPIF(MPIFLLI)
 S FLAG=0,LOOP=0 F  S LOOP=$O(MPIFLL("LINKS",LOOP)) Q:'LOOP  I $P(MPIFLL("LINKS",LOOP),"^",2)=MPIFLLN S FLAG=1
 I FLAG=0 D UPD^HLSUB(MPIFSCN,MPIFLLN,0,$$NOW^XLFDT,,,.HLER)
 I $D(HLER) D EXC^RGHLLOG(224,"Msg#"_$G(HL("MID"))_" Unable to add/update SC for facility IEN "_FAC_", Link "_$G(MPIFLLN)_", for patient "_DFN_" SUB#"_$G(MPIFSCN),DFN) D STOP^RGHLLOG(1) Q  ; log exception
 Q
GETSCN(DFN) ;Return existing SCN or Activate a new subscription
 ;DFN - PATIENT (#2) file ien
 N MPIFAR,MPIFAN
 ;get subscription control #
 S MPIFSCN=+$P($$MPINODE^MPIFAPI(DFN),"^",5)
 ;if no SCN, create new and update 991.05, then return result
 I 'MPIFSCN S MPIFSCN=$$ACT^HLSUB S MPIFAR(991.05)=MPIFSCN S MPIFAN=$$UPDATE^MPIFAPI(DFN,"MPIFAR") I MPIFAN=-1 S MPIFSCN=""
 Q MPIFSCN
