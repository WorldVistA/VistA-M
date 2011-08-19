LRVRPOC ;DALOI/JMC - POINT OF CARE VERIFICATION ; 4 May 2004
 ;;5.2;LAB SERVICE;**290**;Sep 27, 1994
 ;
 ; Reference to DIVSET^XUSRB2 supported by DBIA #4055
 ; Reference to ADM^VADPT2 supported by DBIA #325
 ;
EN ; Entry Point Call with LRLL=Load/Worklist IEN
 ;
 N DIQUIET
 ;
 S LRLL=+$G(LRLL)
 ;
 ; See if already running
 L +^LAH("Z",LRLL):10
 E  D END Q
 ;
 I '$D(^LRO(68.2,LRLL,0))#2 D END Q
 S LRLL(0)=^LRO(68.2,LRLL,0)
 ;
 ; Must be POC Load/Work List
 I $$GET1^DIQ(68.2,LRLL,.03,"I")'=2 D  Q
 . S LAMSG="POC: Unable to process POC results using non-POC worklist "_$$GET1^DIQ(68.2,LRLL,.01)
 . D XQA^LA7UXQA(2,0,0,0,LAMSG,"")
 . D END
 ;
 ;
 ; If rollover has not completed
 ; then requeue task 1 hour in future and send alert.
 I $G(^LAB(69.9,1,"RO"))'=+$H D  Q
 . S ZTREQ=$$HADD^XLFDT($H,0,1,0,0)
 . S LAMSG="POC: Lab Rollover has not completed as of "_$$HTE^XLFDT($H,"1M")
 . D XQA^LA7UXQA(2,0,0,0,LAMSG,"")
 . D END
 ;
 D INIT^LRVRPOCU
 I LREND D  Q
 . D XQA^LA7UXQA(2,0,0,0,"POC: "_LAMSG,"")
 . D END
 ;
 S LAIEN=0
 F  S LAIEN=$O(^LAH(LRLL,1,LAIEN)) Q:LAIEN<1  D
 . I $$S^%ZTLOAD S ZTSTOP=1 Q  ; Task has been requested to stop
 . K LRERR
 . S LASSN=$P($G(^LAH(LRLL,1,LAIEN,.1,"PID","SSN")),"^")
 . ; Interface message number in ^LAHM(62.49
 . S LA76249=+$P($G(^LAH(LRLL,1,LAIEN,0)),U,13)
 . ; File #62.48 configuration link
 . S LA76248=""
 . I LA76249 S LA76248=$$GET1^DIQ(62.49,LA76249_",",.5,"I")
 . D LOOK,NEXT,ZAPALL^LRVR3(LRLL,LAIEN)
 D END
 Q
 ;
 ;
NEXT ; Clean up between entries
 D CLEAN^LRVRPOCU
 Q
 ;
 ;
END ; Clean up and quit
 ; Release lock
 L -^LAH("Z",LRLL)
 ;
 D SPALERT^LRVRPOCU,KVAR^VADPT,KILL^XUSCLEAN
 K ^TMP("LR",$J)
 I $D(ZTQUEUED),'$P($G(ZTREQ),"^") S ZTREQ="@"
 Q
 ;
 ;
LOOK ; Check for data
 K LRDFN,LRERR
 S LRODT=DT,(LREND,LRERR)=0
 S DFN=$$FIND1^DIC(2,"","X",LASSN,"SSN","","")
 I 'DFN D  Q
 . S LRERR=$$CREATE^LA7LOG(101,1)
 . D SENDACK^LRVRPOCU
 S LADFN=DFN
 I '$D(^LAH(LRLL,1,LAIEN,0))#2 D  Q
 . S LRERR=$$CREATE^LA7LOG(105,1)
 . D SENDACK^LRVRPOCU
 S LRCDT=$P($G(^LAH(LRLL,1,LAIEN,.1,"OBR","ORCDT")),"^")
 I LRCDT'?7N.E D  Q
 . S LRERR=$$CREATE^LA7LOG(104,1)
 . D SENDACK^LRVRPOCU
 S LRDFN=$$FNLRDFN(LADFN)
 I $S(LREND:1,LRDFN<1:1,1:0) Q
 S LRSSN=$S($G(^LAH(LRLL,1,LAIEN,.1,"PID","SSN")):^("SSN"),1:"???")
 I LRSSN'=$G(SSN(2)) D  Q
 . S LRERR=$$CREATE^LA7LOG(106,1)
 . D SENDACK^LRVRPOCU
 S LRTJ=""
 D DATA(LRLL,LAIEN)
 Q
 ;
 ;
FNLRDFN(DFN) ;Lookup/set LRDFN and define patient variables
 D KVAR^VADPT
 K ANS,ERR,LRDPF,PNM,X
 I $S(+DFN'=DFN:1,'$G(DFN):1,'$D(^DPT(DFN,0))#2:1,1:0) D  Q 0
 . S LREND=1,LRERR=$$CREATE^LA7LOG(108,1)
 . D SENDACK^LRVRPOCU
 S LRDFN=$$GET1^DIQ(2,DFN_",",63,"I","ANS","ERR")
 S PNM="Unknown"
 I LRDFN<1 S LRDFN=$$NEWPT(DFN)
 I LRDFN>0 D  Q LRDFN
 . D DEM^LRX
 . I $G(LREND) S LRDFN=0 Q
 . S VAINDT=LRCDT D ADM^VADPT2
 . S VAIP("D")=$S(VADMVT:LRCDT,1:LRCDT\1) D IN5PT^LRX
 . D DPT(SSN(2))
 . I LRERR S LREND=1,LRDFN=0
 Q 0
 ;
 ;
NEWPT(DFN) ;Set ^LR( root for patient
 S LRDPF="2^DPT(",X="^"_$P(LRDPF,"^",2)_DFN_",""LR"")"
 S LRDFN=$O(^LR("A"),-1) I 'LRDFN S LRDFN=1
 L +^LR(0):99
 D E2^LRDPA
 L -^LR(0)
 I $G(LRDFN)<1 S LREND=1,LRDFN=0
 Q LRDFN
 ;
 ;
DPT(LRASSN) ;
 N LRX,X,Y,DIC
 S (LRERR,LRDFN)=""
 S DFN=$$FIND1^DIC(2,"","X",LRASSN,"SSN","","")
 I 'DFN D  Q
 . N LASSN
 . S LASSN=LRASSN,LRERR=$$CREATE^LA7LOG(101,1)
 . D SENDACK^LRVRPOCU
 S LRDFN=$$GET1^DIQ(2,DFN_",",63,"I","ANS","ERR")
 I 'LRDFN D END^LRDPA Q:'$G(LRDFN)
 S LRX=$G(^LAH(LRLL,1,LAIEN,.1,"PID","LRDFN"))
 I LRX,LRX'=LRDFN D  Q
 . S LRERR=$$CREATE^LA7LOG(103,1)
 . D SENDACK^LRVRPOCU
 ;
 S LRX=$G(^LAH(LRLL,1,LAIEN,.1,"PID","DFN"))
 I LRX,LRX'=DFN D  Q
 . S LRERR=$$CREATE^LA7LOG(102,1)
 . D SENDACK^LRVRPOCU
 ;
 ; Determine ordering provider
 N LRX,LRY,X,Y
 S LRPRAC=""
 S LRX=$G(^LAH(LRLL,1,LAIEN,.1,"OBR","ORDP"))
 I '$P(LRX,"^",2),$P(LRX,"^")'="" D  Q:LRERR
 . S LRERR=$$CREATE^LA7LOG(119,1)
 . D SENDACK^LRVRPOCU
 ; Check if a valid provider
 I $P(LRX,"^",2) D  Q:LRERR
 . I $$PROVIDER^XUSER(+LRX) S LRPRAC=+LRX Q
 . S LRERR=$$CREATE^LA7LOG(119,1)
 . D SENDACK^LRVRPOCU
 ;
 ; If no ordering provider in message then check for inpatient provider.
 I 'LRPRAC D
 . I $G(VAIP(7)) S LRPRAC=+VAIP(7) Q
 . I $G(VAIP(18)) S LRPRAC=+VAIP(18) Q
 ;
 ; Use VADPT for inpatients - clinic enrollment for outpatient
 ; Check if ordering location/division from message
 S X=$G(^LAH(LRLL,1,LAIEN,.1,"OBR","EOL"))
 S LROLLOC=+X,LROLDIV=$P(X,"^",3)
 ;
 ; Check for inpatient location if no location
 I 'LROLLOC,$G(VAIP(5)) D
 . S LROLLOC=$$GET1^DIQ(42,+VAIP(5)_",",44,"I")
 . I 'LROLDIV S LROLDIV=$$GET1^DIQ(44,LROLLOC_",",3,"I")
 ;
 ; Check for outpatient appointments if no location
 I 'LROLLOC!('LRPRAC) D VASD^LRVRPOCU
 ;
 ; If no location then log error.
 I 'LROLLOC D  Q
 . S LRERR=$$CREATE^LA7LOG(107,1)
 . D SENDACK^LRVRPOCU
 ;
 ; If no in/outpatient provider then check for primary care provider
 I 'LRPRAC S LRPRAC=+$$OUTPTPR^SDUTL3(DFN,LRCDT)
 ;
 ; If no provider - none in message, no primary care and no provider on
 ; outpatient encounter then log error.
 I 'LRPRAC D  Q
 . S LRERR=$$CREATE^LA7LOG(110,1)
 . D SENDACK^LRVRPOCU
 ;
 ; If division in message does not match location's division then reject.
 ; Check if division not a VAMC and parent is a VAMC and division
 ;  matches parent - deal with multiple medical centers within an
 ;  integrated system.
 I LROLDIV D  Q:LRERR
 . N DIV,OK,LRX
 . S DIV=$$GET1^DIQ(44,LROLLOC_",",3,"I")
 . I LROLDIV=DIV Q
 . S X=$$NNT^XUAF4(DIV),OK=0
 . I $P(X,"^",3)'="VAMC" D  Q:OK
 . . S Y=$P($$PRNT^XUAF4($P(X,"^")),"^"),X=$$NNT^XUAF4(Y)
 . . I $P(X,"^",3)="VAMC",$P(Y,"^")=LROLDIV S OK=1
 . S LRX=$$NNT^XUAF4(LROLDIV)
 . S LRERR=$$CREATE^LA7LOG(112,1)
 . D SENDACK^LRVRPOCU
 ;
 ; Get location abbreviation
 S LRLLOC=$$GET1^DIQ(44,LROLLOC_",",1,"I")
 I LRLLOC="" S LRLLOC="NO ABRV "_LROLLOC
 Q
 ;
 ;
DATA(LRLL,LAIEN) ;Extract results into LROT(
 ;
 K LR642,LRDATA,LRERR,LRSPECX,LRCNT,LROSPEC,LROT,LRSAMP,LRSB,LRSPEC,LRTRAY,LRCUP,LRSQ,LRTS,LRX,LRY,LRZ
 S LRSQ=LAIEN,LRDATA=1,(LR642,LRCNT,LRERR)=0,(LRDAA,LRSAMP,LRSPEC)=""
 S LRLL(0)=^LRO(68.2,LRLL,0)
 S LROSPEC=$P($G(^LAH(LRLL,1,LAIEN,.1,"OBR","ORDSPEC")),"^")
 I LROSPEC="" D  Q
 . S LRERR=$$CREATE^LA7LOG(114,1)
 . D SENDACK^LRVRPOCU
 S LRX=$G(^LAH(LRLL,1,LAIEN,.1,"OBR","ORDNLT"))
 ;
 ; Change division to ordering division
 S LRDUZ(2)=$S(LROLDIV:LROLDIV,1:LRDIV)
 I LRDUZ(2)'=DUZ(2) D  Q:LRERR
 . N LA7X,LRY
 . S LRY=0
 . D DIVSET^XUSRB2(.LRY,"`"_LRDUZ(2))
 . I LRY Q
 . S LA7X="Unable to set user 'LRLAB,POC' to division "_$$GET1^DIQ(4,LRDUZ(2)_",",.01)
 . S LRERR=$$CREATE^LA7LOG(37,1)
 ;
 ; Ordering based on NLT codes from loadlist profile and OBR segment
 F I=1:1:$L(LRX,"^") S LRY=$P(LRX,"^",I) Q:LRY=""  D  Q:LRERR
 . I '$D(LRORDNLT(LRY,LROSPEC)) S LRERR=$$CREATE^LA7LOG(120,1) Q
 . S LRZ=LRORDNLT(LRY,LROSPEC)
 . S LRTST=$P(LRZ,"^"),LRSPEC=$P(LRZ,"^",2),LRSAMP=$P(LRZ,"^",3)
 . I '$D(^TMP("LR",$J,"VTO",LRTST)) S LRERR=$$CREATE^LA7LOG(118,1) Q
 . I 'LRSPEC S LRERR=$$CREATE^LA7LOG(114,1) Q
 . I 'LRSAMP S LRERR=$$CREATE^LA7LOG(115,1) Q
 . S LRCNT=LRCNT+1,LROT(LRSAMP,LRSPEC,LRCNT)=LRTST
 . I $P(LRZ,"^",4) S LR642=$P(LRZ,"^",4)
 . I 'LRDAA,LROLDIV,$D(^LAB(60,LRTST,8,LROLDIV,0)) S LRDAA=$P(^(0),U,2)
 I LRERR D SENDACK^LRVRPOCU Q
 I LRDAA<1 S LRDAA=$P(^LRO(68.2,LRLL,10,LRPROF,0),"^",2)
 ;
 ; Check for results to process
 I '$O(LROT(0)) D  Q
 . S LRERR=$$CREATE^LA7LOG(113,1)
 . D SENDACK^LRVRPOCU
 ;
 ; Setup workload suffix
 I LR642<1 S LR642=LRDFWKLD
 D WKLD^LRVRPOCU(LR642)
 ;
 ; Check if results have datanames/tests on this profile.
 F  S LRDATA=$O(^LAH(LRLL,1,LAIEN,LRDATA)) Q:LRDATA<1  D  Q:LRERR
 . I $P($G(^LAH(LRLL,1,LAIEN,LRDATA)),U)="" Q
 . S LRDATA(LRDATA)=^LAH(LRLL,1,LAIEN,LRDATA)
 . I $P(LRDATA(LRDATA),"^",4)<1 S LRERR=$$CREATE^LA7LOG(111,1) Q
 . S LRTST=+$G(LRVTS(LRDATA))
 . I 'LRTST S LRERR=$$CREATE^LA7LOG(116,1) Q
 . I '$D(^TMP("LR",$J,"VTO",LRTST)) S LRERR=$$CREATE^LA7LOG(118,1) Q
 I LRERR D SENDACK^LRVRPOCU Q
 ;
 K LRCOM
 S LRNT=$$NOW^XLFDT,LRORDTIM=""
 ;
 ; Setup the order in LRO(69
 S LRNOLABL="" ; Suppress label printing
 D
 . N LRSPEC,LRSAMP,ZTQUEUED
 . S ZTQUEUED=1
 . D ORDER^LROW2,^LRORDST
 ;
 ; Setup LRO(68
 D
 . N LRSPEC,LRSAMP
 . D ^LRWLST
 I '$G(LRAA) D  Q
 . S LRERR=$$CREATE^LA7LOG(109,1)
 . D SENDACK^LRVRPOCU
 ;
 S LRMETH="POC DEVICE"
 I LA76248 S LRMETH=$E($$GET1^DIQ(62.48,LA76248_",",.01),1,10)
 I LRMETH="" S LRMETH=$E($P(LRLL(0),U),1,5)_"(POC)"
 ;
 ; Store POC specimen id in file #63 as ordering site UID.
 S X=$G(^LAH(LRLL,1,LAIEN,.1,"OBR","FID"))
 I $P(X,"^")'="" D
 . N FDA,LA7DIE
 . S FDA(1,63.04,LRIDT_","_LRDFN_",",.342)=$P(X,"^")
 . I $P(X,"^",2) S FDA(1,63.04,LRIDT_","_LRDFN_",",.32)=$P(X,"^",2)
 . D FILE^DIE("","FDA(1)","LA7DIE(1)")
 ;
 ; Store ^LR( data [results]
 S LRVF=0,LRALERT=LROUTINE,LRUSI="POC.5"
 M LRSB=LRDATA
 D TEST^LRVR1
 S LRSB=0
 F  S LRSB=$O(LRSB(LRSB)) Q:LRSB<1  D  Q:LRERR
 . I '$G(^TMP("LR",$J,"TMP",LRSB,"P")) S LRERR=$$CREATE^LA7LOG(117,1) Q
 . S LRX=$$TMPSB^LRVER1(LRSB),LRY=$P(LRSB(LRSB),U,3)
 . F I=1:1:$L(LRX,"!") I $P(LRY,"!",I)="" S $P(LRY,"!",I)=$P(LRX,"!",I)
 . S $P(LRSB(LRSB),U,3)=LRY
 . S LRTS=$G(^TMP("LR",$J,"TMP",LRSB))
 . D V25^LRVER5
 . S LRX=LRNGS,LRY=$P(LRSB(LRSB),U,5)
 . F I=1:1:$L(LRX,U) I $P(LRY,"!",I)="" S $P(LRY,"!",I)=$P(LRX,U,I)
 . S $P(LRSB(LRSB),U,5)=LRY
 . I $P(LRSB(LRSB),U,9)="" S $P(LRSB(LRSB),U,9)=$S($G(LRDUZ(2)):LRDUZ(2),1:$G(DUZ(2)))
 . S ^LR(LRDFN,"CH",LRIDT,LRSB)=LRSB(LRSB)
 ;
 I LRERR D SENDACK^LRVRPOCU Q
 ;
 ; Call to set data and comments
 I $O(LRSB(0)) D
 . D LRSBCOM^LRVR4,A3^LRVR3
 . S LRSTORE=LRSTORE+1
 . I $G(LA76248) S LRSTORE(LA76248)=$G(LRSTORE(LA76248))+1
 ;
 ; Send application ack back to POC interface
 D SENDACK^LRVRPOCU
 Q
