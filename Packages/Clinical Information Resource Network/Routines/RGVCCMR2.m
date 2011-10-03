RGVCCMR2 ;GAI/TMG,ALS-CMOR ACTIVITY SCORE GENERATOR (PART 2) ;10-6-1997
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**19,34**;30 Apr 99
 ;Reference to ^DGPT( and ^DGPT("B" supported by IA #92
 ;Reference to ^DIC(40.7 supported by IA #2501
 ;Reference to ^LR( supported by IA #2466
 ;Reference to ^PS(55 supported by IA #2470
 ;Reference to ^PSRX( supported by IA #2471
 ;Reference to ^RARPT( and ^RARPT("C" supported by IA #2442
 ;Reference to ^SCE( and ^SCE("C" supported by IA #2443
 ;
EN S U="^"
 I '$D(RUNTYPE) I '$D(RGDFN) S RUNTYPE="I",RGDFN=0 K ^XTMP("RGVCCMR")
 I RUNTYPE'="I",($G(RGDFN)'=0) D NOW^%DTC S ^XTMP("RGVCCMR","@@@@","RESTARTED")=% G BATCH
 I RUNTYPE="I"!($G(RGDFN)=0) K ^XTMP("RGVCCMR")
 D NOW^%DTC
 ;set purge date of XTMP = 30 days
 S ^XTMP("RGVCCMR",0)=$$FMADD^XLFDT($$NOW^XLFDT,30)_U_$$NOW^XLFDT_U_"CMOR CALCULATION DATA"
BATCH I '$D(DT) S X="T",%DT="" D ^%DT S DT=Y
 D NOW^%DTC
 I $G(RGDFN)=0!(RUNTYPE="I") S ^XTMP("RGVCCMR","@@@@","STARTED")=%,$P(^RGSITE(991.8,1,"CMOR"),U,2)=%
 S $P(^RGSITE(991.8,1,"CMOR"),U,8)=RUNTYPE
 S:'$D(^XTMP("RGVCCMR","@@@@","BIG")) ^XTMP("RGVCCMR","@@@@","BIG")=0
ALLPTS S ^XTMP("RGVCCMR","@@@@","SECTION")="ALL"
 S $P(^RGSITE(991.8,1,"CMOR"),U,7)="R"
 S:'$D(^XTMP("RGVCCMR","@@@@","DFNCOUNT")) ^XTMP("RGVCCMR","@@@@","DFNCOUNT")=0
 F  S RGDFN=$O(^DPT(+RGDFN)) Q:+RGDFN'>0  I $D(^DPT(+RGDFN,0)) S DPT0=^(0) G:$P($G(^RGSITE(991.8,1,"CMOR")),U,4)="Y" STOP D
 .S QUIT=0 D CKPT I QUIT Q
 .S FILEFLG=0
 .D CALCI S ^XTMP("RGVCCMR","@@@@","CURR DFN")=RGDFN S $P(^RGSITE(991.8,1,"CMOR"),U)=RGDFN
 .I FILEFLG=1 D
 ..I SCORE>^XTMP("RGVCCMR","@@@@","BIG") S ^XTMP("RGVCCMR","@@@@","BIG")=SCORE
 ..S RATING=SCORE\100 S:'$D(^XTMP("RGVCCMR","@@@@","RATING",RATING)) ^XTMP("RGVCCMR","@@@@","RATING",RATING)=0
 ..S ^XTMP("RGVCCMR","@@@@","RATING",RATING)=^XTMP("RGVCCMR","@@@@","RATING",RATING)+1
STOP I $P($G(^RGSITE(991.8,1,"CMOR")),U,4)="Y" S $P(^RGSITE(991.8,1,"CMOR"),U,7)="SM",$P(^RGSITE(991.8,1,"CMOR"),U,4)=""
 E  S $P(^RGSITE(991.8,1,"CMOR"),U,7)="SN"
 D NOW^%DTC
 S ^XTMP("RGVCCMR","@@@@","STOPPED")=%
 S $P(^RGSITE(991.8,1,"CMOR"),U,3)=%
 D COUNT,KILL
 Q
CALC ;API ENTRY POINT DBIA #2710
 ;VARIABLES:  Input
 ;              RGDFN - IEN of the patient in the Patient
 ;                      file (#2).  RGDFN is not passed as a
 ;                      formal parameter, but is defined before
 ;                      calling CALC.
 ;
 ;            Output:  None  (result sets score into PATIENT (#2))
 ;
 N SCORE,X,STDT,%DT,APSTDT,YR,NXPC,PCCODE,XRCODE,LRCODE,NXSCE,SCED,VISIT,NXPTF,PTFD,ADM,NXXR,RARPTD,XRAY,NXRX,PSOVER,RXDT,RXIEN,RX,RGRXST,LRSCORE,LRDFN,LRSTDT,TEST,NXLR,FILEFLG,DIE,DR,DA
CALCI S SCORE=0,X="T-1065",%DT="" D ^%DT S STDT=Y,X="T",%DT="" D ^%DT
 S APSTDT=Y,YR=$E(DT,1,3)
 ; Remove call to RGRSWPT, routine being deleted.
 ; Remove call to FBUTL for Fee Basis redesign.
 ;I '+$$ACTIVE^RGRSWPT(RGDFN) D  Q
 ;.I '$$AUTH^FBUTL(RGDFN,"2961001") Q
 ;.D FILE
 I '$D(DT) D NOW^%DTC S DT=%\1
OPT ;  outpatient visit section
 ;  each visit valued as follows:    current fy = 30 pts.
 ;                                           fy - 1 = 20 pts
 ;                                           fy - 2 = 10 pts
 ;  primary care visits (based on the PCCODE array) = 50 pts each in
 ;  addition to the visit value
 ;  XRCODE = ien of xray stop code  LRCODE = ien of lab stop code 
 ;  encounters with a stop code for lab or xray are not counted to
 ;  avoid duplication since lab & xray are counted separately 
 ;  in the XR & LR sections
 K PCCODE S NXPC=0 F  S NXPC=$O(^RGSITE(991.8,1,"PC",NXPC)) Q:+NXPC'>0  I $D(^DIC(40.7,+$P($G(^RGSITE(991.8,1,"PC",NXPC,0)),U),0)) S PCCODE($P($G(^RGSITE(991.8,1,"PC",NXPC,0)),U))=""
 I '$D(PCCODE) S PCCODE=""
 S XRCODE=0 I $D(^DIC(40.7,"C",105)) S XRCODE=$O(^DIC(40.7,"C",105,0))
 S LRCODE=0 I $D(^DIC(40.7,"C",108)) S LRCODE=$O(^DIC(40.7,"C",108,0))
 K VISIT S NXSCE=0 F  S NXSCE=$O(^SCE("C",+RGDFN,NXSCE)) Q:+NXSCE'>0  I $D(^SCE(+NXSCE,0)) S SCE0=^(0) D
 .I $P(SCE0,U,3)=XRCODE!($P(SCE0,U,3))=LRCODE Q
 .I $P(SCE0,U)>STDT I '$D(VISIT(+$P(SCE0,U)\1)) S VISIT(+$P(SCE0,U)\1)=30+(($E($P(SCE0,U),1,3)-YR)*10) S SCORE=SCORE+30+(($E($P(SCE0,U),1,3)-YR)*10)
 .I $D(PCCODE(+$P(SCE0,U,3))) I '$D(VISIT($P(SCE0,U)\1)) S VISIT(+$P(SCE0,U)\1)=50 S SCORE=SCORE+50
 .I $D(PCCODE(+$P(SCE0,U,3))) I $D(VISIT($P(SCE0,U)\1)) S VISIT(+$P(SCE0,U)\1)=VISIT(+$P(SCE0,U)\1)+50 S SCORE=SCORE+50
ADM ;  past admission section
 ;  each admission valued as follows:  current fy = 50 pts
 ;                                             fy - 1 = 40 pts
 ;                                             fy - 2 = 30 pts
 K ADM S NXPTF=0 F  S NXPTF=$O(^DGPT("B",+RGDFN,NXPTF)) Q:+NXPTF'>0  I $D(^DGPT(NXPTF,0)) S PTF0=^(0) D
 .I $P(PTF0,U,2)>STDT I '$D(ADM($P(PTF0,U,2)\1)) S ADM(+$P(PTF0,U,2)\1)=50+(($E($P(PTF0,U,2),1,3)-YR)*10) S SCORE=SCORE+50+(($E($P(PTF0,U,2),1,3)-YR)*10)
 .I $D(ADM(+$P(PTF0,U,2)\1)) I $O(^DGPT(+NXPTF,"S",0)) S ADM($P(PTF0,U,2)\1)=ADM($P(PTF0,U,2)\1)+10 S SCORE=SCORE+10
XRAY ; radiololgy section - each radiology exam valued at 20 pts
 ;
 S X="T-365",%DT="" D ^%DT S XRSTDT=Y
 K XRAY S NXXR=0 F  S NXXR=$O(^RARPT("C",+RGDFN,NXXR)) Q:+NXXR'>0  I $D(^RARPT(+NXXR,0)),$P(^(0),U,3)>XRSTDT S RARPT0=^(0) D
 .I '$D(XRAY($P(RARPT0,U,3)\1)) S XRAY($P(RARPT0,U,3)\1)=20 S SCORE=SCORE+20
RX ;  prescription section 
 ;
 ;  currently active prescriptions valued at 20 pts
 K RX,^TMP("PSOR",$J) S NXRX=0
 ;check for version of Outpatient Pharmacy used
 ;if under 7.0 use direct global access, else use api PSOORDER
 S PSOVER=$$VERSION^XPDUTL("PSO")
 S RXDT=$$FMADD^XLFDT(DT,-121) F  S RXDT=$O(^PS(55,RGDFN,"P","A",RXDT)) Q:RXDT'>0  S RXIEN=0 F  S RXIEN=$O(^PS(55,RGDFN,"P","A",RXDT,RXIEN)) Q:RXIEN'>0  D
 . I PSOVER<7 DO  ;
 .. I $D(^PSRX(+RXIEN,0)),$P(^(0),U,15)=0 S RX(NXRX)=20 S SCORE=SCORE+20
 . I PSOVER'<7 D EN^PSOORDER(RGDFN,RXIEN) I $D(^TMP("PSOR",$J,RXIEN)) D
 .. S RGRXST=$P($P(^TMP("PSOR",$J,RXIEN,0),"^",4),";") I RGRXST="A"!(RGRXST="S")!(RGRXST="H") S RX(NXRX)=20 K RGRXST S SCORE=SCORE+20
 K ^TMP("PSOR",$J)
LR ;  laboratory section
 ;  "CH" = chemistry; "CY" = cytotology; "EM" = electron microscopy;
 ;  "MI = microbiology; "SP" = surgical pathology
 ; each lab test done in the past year is valued at 10 points
 ;
 S LRSCORE=0 I $D(^DPT(+RGDFN,"LR")) S LRDFN=^DPT(+RGDFN,"LR") I $D(^LR(+LRDFN)) S X="T-365",%DT="" D ^%DT S LRSTDT=Y-.0001 F TEST="CH","CY","EM","MI","SP" D
 .S NXLR=0 F  S NXLR=$O(^LR(+LRDFN,TEST,NXLR)) Q:+NXLR'>0  I $D(^(NXLR,0)),$P(^(0),U)>LRSTDT S LRSCORE=LRSCORE+10
 S SCORE=SCORE+LRSCORE
FILE ;  file score & date calculated in appropriate locations in the
 ;  PATIENT file 'MPI' node
 ;  scores are filed even if zero
 ;  FILEFLG variable used to illiminate unnecessary statistcal processing
 S FILEFLG=1
 S DIE="^DPT(",DA=RGDFN,DR="991.06///^S X=SCORE;991.07///TODAY" D ^DIE
 I $D(^XTMP("RGVCCMR","@@@@","DFNCOUNT")) S ^XTMP("RGVCCMR","@@@@","DFNCOUNT")=^XTMP("RGVCCMR","@@@@","DFNCOUNT")+1
 Q
KILL K ADM,APSTDT,DA,DIE,DIC,RGDFN,DGS0,DPT0,DR,LRCODE,LRDFN,LRSCORE,LRSTDT
 K NUM,NXLR,NXPTF,NXRX,NXSCE,NXXR,PCCODE,PTF0,PTNAM
 K QUIT,RARPT0,RATE,RATING,RX,RXDT,RXIEN,SCE0,SCORE,SSN,STDT,TEST,VISIT,X
 K XRAY,XRCODE,XRSTDT,Y,YR,%,%DT,NXPC,PSOVER,RUNTYPE,FILEFLG
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
CKPT S PTNAM=$P(DPT0,U),SSN=$P(DPT0,U,9)
 I PTNAM?1"ZZ".E S QUIT=1
 I SSN?1"00000".E S QUIT=1
 Q
COUNT S ^XTMP("RGVCCMR","@@@@","RATING","TCOUNT")=0,RATE="" F  S RATE=$O(^XTMP("RGVCCMR","@@@@","RATING",RATE)) Q:RATE'?.N  D
 .;.W !,RATE
 .S ^XTMP("RGVCCMR","@@@@","RATING","TCOUNT")=^XTMP("RGVCCMR","@@@@","RATING","TCOUNT")+^XTMP("RGVCCMR","@@@@","RATING",RATE)
 Q
