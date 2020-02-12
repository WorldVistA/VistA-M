VPREVNT ;SLC/MKB -- VistA event listeners ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8,10,15,17,19,21**;Sep 01, 2011;Build 1
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; DG FIELD MONITOR              3344
 ; DGPM MOVEMENT EVENTS          1181
 ; FH EVSEND OR                  6097
 ; GMPL EVENT                    6065
 ; GMRA ENTERED IN ERROR         1467
 ; GMRA SIGN-OFF ON DATA         1469
 ; GMRC EVSEND OR                3140
 ; IBCN NEW INSURANCE            7010
 ; LR7O AP EVSEND OR             7011
 ; LR70 CH EVSEND OR             6087
 ; MDC OBSERVATION UPDATE        6084
 ; OR EVSEND FH                  6090
 ; OR EVSEND GMRC                3135
 ; OR EVSEND LRCH                6091
 ; OR EVSEND ORG                 6092
 ; OR EVSEND PS                  6093
 ; OR EVSEND RA                  6094
 ; OR EVSEND VPR                 6095
 ; PS EVSEND OR                  2415
 ; PSB EVSEND VPR                6085
 ; PXK VISIT DATA EVENT          1298
 ; RA EVSEND OR                  6086
 ; SCMC PATIENT TEAM CHANGES     7012
 ; SCMC PATIENT TEAM POSITION    7013
 ; SDAM APPOINTMENT EVENTS       1320
 ; ^AUPNPROB                     5703
 ; ^AUPNVSIT                     2028
 ; ^DGPM                         1865
 ; ^DPT                         10035
 ; ^GMR(120.8                    6973
 ; ^GMR(120.86                   3449
 ; ^LR                            525
 ; ^OR(100                       5771
 ; ^PSB(53.79                    5909
 ; ^RADPT                        2480
 ; ^TIU(8925.1                   5677
 ; %ZTLOAD                      10063
 ; DIC                           2051
 ; DIQ                           2056
 ; PSSUTLA1                      3373
 ; TIULX                         3058
 ; VADPT2                         325
 ; XLFDT                        10103
 ;
DG ; -- DG FIELD MONITOR protocol listener
 N VPRFN S VPRFN=$G(DGFILE)
 I "^2^2.01^2.02^2.06^38.1^"'[(U_VPRFN_U) Q
 N DFN S DFN=+$G(DGDA)
 ; collect individual fields into single tasked update if possible
 D QUE^VPRHS(DFN) Q  ;skip fld check
 I VPRFN=2 D:$$FLD(+$G(DGFIELD)) QUE^VPRHS(DFN) Q
 D POST^VPRHS(DFN,"Patient",DFN_";2")
 Q
 ;
FLD(X) ; -- Return 1 or 0, if X is a field tracked by VPR
 ;    via DG FIELD MONITOR
 S X=U_+$G(X)_U
 I "^.01^.02^.03^.05^.07^.08^.09^.092^.093^.351^"[X Q 1     ;demographic
 I "^.111^.1112^.112^.113^.114^.115^.131^.132^.134^"[X Q 1  ;addr/phone
 I "^.211^.212^.213^.214^.216^.217^.218^.219^.21011^"[X Q 1 ;NOK
 I "^.331^.332^.333^.334^.335^.336^.337^.338^.339^"[X Q 1   ;ECON
 I "^.301^.302^.32102^.32103^.3215^.32201^.5295^"[X Q 1     ;serv conn
 I "^.14^.323^.361^1901^"[X Q 1
 Q 0
 ;
DGPM ; -- DGPM MOVEMENT EVENTS protocol listener
 ;    [expects DFN,DGPM* variables]
 I $$NEWINPT,$$ON^VPRHS,'$$SUBS^VPRHS(DFN) D NEW^VPRHS(DFN) Q
 N ADM S ADM=DGPMDA
 I DGPMT'=1 S ADM=$S(DGPMA:$P(DGPMA,U,14),1:$P(DGPMP,U,14)) Q:ADM<1
 ; loop to find all Visits (have seen >1 per admission)
 ; if no visit# yet, will be updated when assigned in PCE section
 N ADM0,VAINDT,X,VPRI,PTF,DXLS
 S ADM0=$G(^DGPM(+$G(ADM),0)),X=+ADM0
 S VAINDT=(9999999-$P(X,"."))_"."_$P(X,".",2)
 S VPRI=0 F  S VPRI=$O(^AUPNVSIT("AAH",DFN,VAINDT,VPRI)) Q:VPRI<1  D
 . ; If Admission is deleted, update as Visit; else update as Admission
 . I DGPMT=1,'DGPMA D POST^VPRHS(DFN,"Encounter",VPRI_";9000010") Q
 . D POST^VPRHS(DFN,"Encounter",ADM_"~"_VPRI_";405")
 . S PTF=$P(ADM0,U,16) Q:PTF<1
 . ;S DXLS=$$GET1^DIQ(45,PTF,79,"I") Q:'DXLS
 . ;D POST^VPRHS(DFN,"Diagnosis",PTF_U_DXLS_";45",,VPRI)
 . D POST^VPRHS(DFN,"Diagnosis",PTF_";45",,VPRI)
 Q
 ;
NEWINPT() ; -- is DFN newly admitted?
 N Y S Y=0
 I DGPMT=1,DGPMA,'DGPMP,+$G(^DPT(DFN,.105))=DGPMDA S Y=1 ;new admission
 Q Y
 ;
SDAM ; -- SDAM APPOINTMENT EVENTS protocol listener
 N DFN,DATE,ACT Q:'$G(SDATA)
 Q:$G(SDAMEVT)>5  ;only track make, cancel, no show, check in/out
 ; quit if status has not changed
 Q:$G(SDATA("BEFORE","STATUS"))=$G(SDATA("AFTER","STATUS"))
 S DFN=+$P(SDATA,U,2) Q:DFN<1
 S DATE=+$P(SDATA,U,3),ACT=$S($G(SDAMEVT)=2:"@",1:"")
 D POST^VPRHS(DFN,"Appointment",(DATE_","_DFN_";2.98"),ACT)
 Q
 ;
PCE ; -- PXK VISIT DATA EVENT protocol listener [moved to PX^VPRENC]
 Q:'$P($G(^VPR(1,0)),U,2)  ;monitoring disabled
 N VST,PX0A,PX0B,DFN,SUB,DA,ACT,X,VADMVT
 S VST=+$O(^TMP("PXKCO",$J,0)) Q:VST<1
 S PX0A=$G(^TMP("PXKCO",$J,VST,"VST",VST,0,"AFTER")),PX0B=$G(^("BEFORE"))
 S DFN=$S($L(PX0A):+$P(PX0A,U,5),1:+$P(PX0B,U,5))
 Q:DFN<1  Q:'$$VALID^VPRHS(DFN)
 ; get or set up ^XTMP
 S VPRPX=$NA(^XTMP("VPRPX"_DFN))
 L +@VPRPX@(0):5 ;I'$T
 ; if deleted within current session, kill VPRPX and Quit
 I PX0A="",$G(@VPRPX@(VST)) K @VPRPX@(VST) L -@VPRPX@(0) Q
 ; Visit file
 I PX0A="" S @VPRPX@(VST)=$$NOW^XLFDT_U_VST_";9000010^@"
 I PX0A D  ;new or updated visit
 . I $P(PX0A,U,7)="H" D  ;find admission movement
 .. N VAINDT S VAINDT=+PX0A D ADM^VADPT2
 . S ID=$S($G(VADMVT):VADMVT_"~"_VST_";405",1:VST_";9000010")
 . S @VPRPX@(VST)=$$NOW^XLFDT_U_ID
 ; V-files
 F SUB="IMM","XAM","POV","HF" D  ;"PED","SK","CPT"
 . S DA=0 F  S DA=$O(^TMP("PXKCO",$J,VST,SUB,DA)) Q:DA<1  D
 .. S ACT=$S($G(^TMP("PXKCO",$J,VST,SUB,DA,0,"AFTER")):"",1:"@")
 .. S @VPRPX@(VST,SUB,DA)=ACT
PCEQ ; task?
 I '$G(@VPRPX@(0)) D QUE(DFN,10)
 L -@VPRPX@(0)
 Q
 ;
QUE(DFN,M) ; -- begin tasking to post encounters, documents
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC,ZTSK
 S ZTRTN="PX^VPRHS",ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,,,M)
 S ZTDESC="VPR Encounter Session",ZTIO="",ZTSAVE("DFN")=""
 S ^XTMP("VPRPX"_DFN,0)=$$FMADD^XLFDT(DT,1)_U_DT_"^Encounters for HealthShare"
 D ^%ZTLOAD
 Q
 ;
XQOR(MSG,FD) ; -- CPRS protocol event listener
 ; FD   = frontdoor msg from CPRS (get ORIFN for new backdoor orders)
 ; else = backdoor msg/ack from Pharmacy, Lab, Radiology, etc.
 N VPRMSG,VPRPKG,VPRSDA,DFN,ORC,ACT
 S VPRMSG=$S($L($G(MSG)):MSG,1:"MSG") Q:'$O(@VPRMSG@(0))
 S DFN=$$PID Q:DFN<1
 S ORC=0 F  S ORC=$O(@VPRMSG@(+ORC)) Q:ORC'>0  I $E($G(@VPRMSG@(ORC)),1,3)="ORC" D
 . N ORDCNTRL,PKGIFN,ORIFN,STS
 . S ORC=ORC_U_@VPRMSG@(ORC),ORDCNTRL=$TR($P(ORC,"|",2),"@","P")
 . ; QUIT if action failed, conversion, purge, or backdoor verify/new
 . I ORDCNTRL["U"!("DE^ZC^ZP^ZR^ZV^SN"[ORDCNTRL) Q
 . I $G(FD),ORDCNTRL'="NA" Q  ;only want NA msg, from CPRS
 . S ACT=$S(ORDCNTRL="OC":"@",1:"")
 . ; Update *Order containers
 . S ORIFN=+$P($P(ORC,"|",3),U),PKGIFN=$G(^OR(100,ORIFN,4))
 . Q:$O(^OR(100,ORIFN,2,0))  ;should not be getting parent orders
 . S STS=$P($G(^OR(100,ORIFN,3)),U,3) Q:STS=10  Q:STS=11
 . S VPRPKG=$$NMSP(ORIFN),VPRSDA=$$ORDCONT(VPRPKG)
 . D POST^VPRHS(DFN,VPRSDA,ORIFN_";100",ACT)
 . I ORIFN D  ;update replaced order
 .. N ORIG S ORIG=+$P($G(^OR(100,ORIFN,3)),U,5)
 .. I ORIG D POST^VPRHS(DFN,VPRSDA,ORIG_";100")
 . ; Update Referral or Document containers
 . I VPRPKG="GMRC",PKGIFN D POST^VPRHS(DFN,"Referral",+PKGIFN_";123") Q
 . Q:ORDCNTRL'="RE"
 . I $E(VPRPKG,1,2)="RA" D RAD Q
 . I $E(VPRPKG,1,2)="LR" D LRD Q
 Q
 ;
NMSP(IFN) ; -- Returns package namespace from pointer
 N X,Y S X=$P($G(^OR(100,+$G(IFN),0)),U,14)
 S Y=$$GET1^DIQ(9.4,+X_",",1)
 Q Y
 ;
ORDCONT(NMSP) ; -- Returns SDA Order container name
 S NMSP=$G(NMSP)
 I $E(NMSP,1,2)="LR"  Q "LabOrder"
 I $E(NMSP,1,2)="PS"  Q "Medication"
 I $E(NMSP,1,2)="RA"  Q "RadOrder"
 Q "OtherOrder"
 ;
GMRC ; -- Referrals [from XQOR: no longer used]
 N VST S VST=$$GET1^DIQ(123,+PKGIFN,"16:.03","I")
 D POST^VPRHS(DFN,"Referral",+PKGIFN_";123",,VST)
 ; update CP in Procedures?
 I ORDCNTRL="RE",$$GET1^DIQ(123,+PKGIFN,1.01,"I") D  ;CP
 . N VPRC,ID D FIND^DIC(702,,"@","Q",+PKGIFN,,"ACON",,,"VPRC")
 . S I=0 F  S I=$O(VPRC("DILIST",2,I)) Q:I<1  D
 .. S ID=+$G(VPRC("DILIST",2,I))
 .. D POST^VPRHS(DFN,"Procedure",ID_";702",,VST)
 Q
 ;
RAD ; -- Radiology documents
 N IDT,RPT,I,X,STS,ACT
 S IDT=+$O(^RADPT("AO",+PKGIFN,DFN,0)),I=0
 ; find report(s) for order
 F  S I=$O(^RADPT("AO",+PKGIFN,DFN,IDT,I)) Q:I<1  D
 . S X=+$P($G(^RADPT(DFN,"DT",IDT,"P",I,0)),U,17) ;,VST=$P($G(^(0)),U,27)
 . Q:'X  S STS=$$GET1^DIQ(74,X_",",5,"I"),ACT=""
 . Q:STS'="V"&(STS'="EF")&(STS'="X")  I STS="X" S ACT="@"
 . S:'$D(RPT(X)) RPT(X)=IDT_"-"_I ;S:VST VST(X)=VST
 ; update Document container
 S X=0 F  S X=$O(RPT(X)) Q:X<1  D POST^VPRHS(DFN,"Document",X_"~"_RPT(X)_";74",ACT)
 Q
 ;
LRAP(MSG) ; -- LR7O AP EVSEND OR protocol listener
 N VPRMSG,DFN,ORC
 S VPRMSG=$S($L($G(MSG)):MSG,1:"MSG") Q:'$O(@VPRMSG@(0))
 S DFN=$$PID Q:DFN<1
 S ORC=0 F  S ORC=$O(@VPRMSG@(+ORC)) Q:ORC'>0  I $E($G(@VPRMSG@(ORC)),1,3)="ORC" D
 . N ORDCNTRL,PKGIFN
 . S ORC=ORC_U_@VPRMSG@(ORC),ORDCNTRL=$TR($P(ORC,"|",2),"@","P")
 . Q:ORDCNTRL'="RE"  S PKGIFN=$P($P(ORC,"|",4),U)
 . D LRD
 Q
 ;
LRD ; -- AP/MI documents [from XQOR, LRAP: expects PKGIFN]
 N SUB,IDT,LRDFN,X
 S SUB=$P($G(PKGIFN),";",4),IDT=$P($G(PKGIFN),";",5)
 Q:'IDT  Q:SUB=""  Q:SUB="CH"
 S LRDFN=+$G(^DPT(DFN,"LR"))
 I SUB'="MI" Q:$O(^LR(LRDFN,SUB,IDT,.05,0))  ;report in TIU
 Q:'$P($G(^LR(LRDFN,SUB,IDT,0)),U,3)         ;report not complete
 S X=IDT_","_LRDFN_"~"_SUB_";"_$S(SUB="MI":63.05,1:63.08)
 D POST^VPRHS(DFN,"Document",X)
 Q
 ;
PID() ; -- Returns patient from PID segment in current msg
 N I,SEG,Y S I=0
 F  S I=$O(@VPRMSG@(I)) Q:I'>0  S SEG=$E($G(@VPRMSG@(I)),1,3) Q:SEG="ORC"  I SEG="PID" D  Q
 . S Y=+$P(@VPRMSG@(I),"|",4)
 .;I '$D(^DPT(Y,0)) S:$L($P(@VPRMSG@(I),"|",5)) Y=+$P(@VPRMSG@(I),"|",5) ;alt ID for Lab
 Q Y
 ;
PSB ; -- VPR PSB EVENTS protocol listener (BCMA)
 N IEN,DFN,ORPK,ORIFN
 S IEN=$S($P($G(PSBIEN),",",2)'="":+$P(PSBIEN,",",2),$G(PSBIEN)="+1":+$G(PSBIEN(1)),1:+$G(PSBIEN))
 S DFN=+$G(^PSB(53.79,IEN,0)),ORPK=$P($G(^(.1)),U)
 Q:DFN<1  Q:ORPK<1
 S ORIFN=$S($L($T(PLACER^PSSUTLA1)):$$PLACER^PSSUTLA1(DFN,ORPK),1:0)
 D:ORIFN POST^VPRHS(DFN,"Medication",ORIFN_";100")
 Q
 ;
GMRA(ACT) ; -- GMRA SIGN-OFF ON DATA protocol listener
 ;   also GMRA ENTERED IN ERROR [ACT=@]
 N DFN,IEN,NEW,I
 S DFN=+$G(GMRAPA(0)),IEN=+$G(GMRAPA)
 D POST^VPRHS(DFN,"Allergy",IEN_";120.8") ;,$G(ACT))
 ; update assessment?
 I $G(ACT)="@" D:'$P($G(^GMR(120.86,DFN,0)),U,2) POST^VPRHS(DFN,"Allergy",DFN_";120.86")
 I $G(ACT)="" D  D:NEW POST^VPRHS(DFN,"Allergy",DFN_";120.86","@")
 . S NEW=1,I=0 ;is the current allergy the first, only active one?
 . F  S I=$O(^GMR(120.8,"B",DFN,I)) Q:I<1  I I'=IEN,'$G(^GMR(120.8,I,"ER")) S NEW=0 Q
 Q
 ;
GMRASMT(DFN) ; -- GMRAHDR Allergy Assessment listener
 N ACT S ACT=$S($P($G(^GMR(120.86,DFN,0)),U,2):"@",1:"")
 D POST^VPRHS(DFN,"Allergy",DFN_";120.86",ACT)
 Q
 ;
GMPL(DFN,IEN) ; -- GMPL EVENT protocol listener
 S DFN=+$G(DFN),IEN=+$G(IEN)
 N ACT S ACT=$S($P($G(^AUPNPROB(IEN,1)),U,2)="H":"@",1:"")
 D POST^VPRHS(DFN,"Problem",IEN_";9000011",ACT)
 Q
 ;
GMRV(DFN,IEN,ERR) ; -- Vital Measurement file #120.5 AVPR index
 S DFN=+$G(DFN),IEN=+$G(IEN)
 N ACT S ACT=$S($G(ERR):"@",1:"")
 D POST^VPRHS(DFN,"Observation",IEN_";120.5",ACT)
 Q
 ;
MDC(OBS) ; -- MDC OBSERVATION UPDATE protocol listener [not in use]
 N DFN,ID,ACT
 S DFN=+$G(OBS("PATIENT_ID","I")) Q:DFN<1
 S ID=$G(OBS("OBS_ID","I")) Q:'$L(ID)
 S ACT=$S('$G(OBS("STATUS","I")):"@",1:"")
 D POST^VPRHS(DFN,"Observation",ID_";704.117",ACT)
 ;I $G(OBS("DOMAIN","VITALS")) D POST^VPRHS(DFN,"Observation",ID,ACT)
 Q
 ;
CP(DFN,ID,ACT) ; -- CP Transaction file #702 AVPR index
 ; via VPRPROC [not in use]
 S DFN=+$G(DFN),ID=+$G(ID)
 N VST S VST=$$GET1^DIQ(702,ID,".06:.03","I")
 D POST^VPRHS(DFN,"Procedure",ID_";702",$G(ACT),VST)
 Q
 ;
TIU(DFN,IEN) ; -- TIU Document file #8925 AEVT index
 N ACT,STS,DAD
 S DFN=+$G(DFN),IEN=+$G(IEN),ACT="" Q:IEN<1
 Q:DFN<1  Q:'$$VALID^VPRHS(DFN)  ;not subscribed
 S STS=$G(X(2)),DAD=$G(X(3))     ;X = FM data array for index
 I STS<7 Q                       ;not complete
 I STS=9 Q                       ;archived, leave in cache
 S:DAD IEN=DAD I 'DAD D          ;if addendum, repull entire note
 . I STS>13 S ACT="@"            ;deleted or retracted
 . I $G(X2(1))="" S ACT="@"      ;deleted (new title = null)
 ;
 ; add to ^XTMP("VPRPX") temporary list w/encounters
 D TIU^VPRENC(IEN,ACT)
 ;
 ; update alert containers if CWD
 I $$ISA^TIULX(IEN,27) D POST^VPRHS(DFN,"AdvanceDirective") Q  ;rebuild
 I $$ISA^TIULX(IEN,30) D POST^VPRHS(DFN,"Alert",IEN_";8925",ACT) Q
 I $$ISA^TIULX(IEN,31) D POST^VPRHS(DFN,"Alert",IEN_";8925",ACT)
 Q
 ;
LR() ; -- Return ien of Lab class
 N Y S Y=+$O(^TIU(8925.1,"B","LR LABORATORY REPORTS",0))
 I Y>0,$S($P($G(^TIU(8925.1,Y,0)),U,4)="CL":0,$P($G(^(0)),U,4)="DC":0,1:1) S Y=0
 Q Y
 ;
IBCN ; -- IBCN NEW INSURANCE EVENTS listener
 I $G(DFN) D POST^VPRHS(DFN,"MemberEnrollment") ;rebuild container
 Q
 ;
PCMMT ; -- SCMC PATIENT TEAM CHANGES protocol listener
 I '$G(SCPCTM) Q  ;not pc change
 N DFN S DFN=$S($G(SCPTTMAF):+SCPTTMAF,1:+$G(SCPTTMB4)) Q:'DFN
 D POST^VPRHS(DFN,"Patient",DFN_";2")
 Q
 ;
PCMMTP ; -- SCMC PATIENT TEAM POSITION CHANGES protocol listener
 I '$G(SCPCTP) Q  ;not pc change
 N TM,DFN
 S TM=$S($G(SCPTTPAF):+SCPTTPAF,1:+$G(SCPTTPB4)) Q:'TM
 S DFN=+$$GET1^DIQ(404.42,TM_",",.01,"I")
 D POST^VPRHS(DFN,"Patient",DFN_";2")
 Q
 ;
 ; Deprecated calls:
 ;
DOCDEF(IEN) ; -- TIU Document Definition file #8925.1 AVPR index
 Q
 ;
DOCITM(DAD) ; -- TIU Document Def'n Items subfile #8925.14 AVPR1 index
 Q
 ;
USR(IEN) ; -- USR Authorization/Subscription file #8930.1 AVPR index
 Q
 ;
XU(IEN,ACT) ; -- XU USER ADD/CHANGE/TERMINATE option listener
 Q
