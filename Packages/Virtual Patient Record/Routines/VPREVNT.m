VPREVNT ;SLC/MKB -- VistA event listeners ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8,10,15**;Sep 01, 2011;Build 9
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
 ; ^AUTTHF                       4295
 ; ^DGPM                         1865
 ; ^DPT                         10035
 ; ^LR                            525
 ; ^OR(100                       5771
 ; ^PSB(53.79                    5909
 ; ^RADPT                        2480
 ; ^TIU(8925.1                   5677
 ; DIC                           2051
 ; DIQ                           2056
 ; TIULQ                         2693
 ; TIULX                         3058
 ; VADPT2                         325
 ;
DG ; -- DG FIELD MONITOR protocol listener
 N VPRFN S VPRFN=$G(DGFILE)
 I "^2^2.01^2.02^2.06^38.1^"'[(U_VPRFN_U) Q
 N DFN S DFN=+$G(DGDA)
 ; collect individual fields into single tasked update if possible
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
 N VAINDT,X,I,PTF
 S X=+$G(^DGPM(+$G(ADM),0)),VAINDT=(9999999-$P(X,"."))_"."_$P(X,".",2)
 S I=0 F  S I=$O(^AUPNVSIT("AAH",DFN,VAINDT,I)) Q:I<1  D
 . ; If Admission is deleted, update as Visit; else update as Admission
 . I DGPMT=1,'DGPMA D POST^VPRHS(DFN,"Encounter",I_";9000010") Q
 . D POST^VPRHS(DFN,"Encounter",ADM_"~"_I_";405")
 . S PTF=$P(DGPMA,U,16) D:PTF POST^VPRHS(DFN,"Diagnosis",PTF_";45")
 Q
 ;
NEWINPT() ; -- is DFN newly admitted?
 N Y S Y=0
 I DGPMT=1,DGPMA,'DGPMP,+$G(^DPT(DFN,.105))=DGPMDA S Y=1 ;new admission
 Q Y
 ;
SDAM ; -- SDAM APPOINTMENT EVENTS protocol listener
 I $G(SDATA) D  Q  ;appointments
 . N DFN,DATE,HLOC,ACT
 . S DFN=+$P(SDATA,U,2) Q:DFN<1
 . Q:$G(SDAMEVT)>5  ;only track make, cancel, no show, check in/out
 . S DATE=+$P(SDATA,U,3),HLOC=+$P(SDATA,U,4)
 . S ACT=$S($G(SDATA("AFTER","STATUS"))["CANCEL":"@",1:"")
 . ;Q:$P($G(^DPT(DFN,"S",DATE,0)),U)'=HLOC
 . D POST^VPRHS(DFN,"Appointment",(DATE_","_DFN_";2.98"),ACT)
 Q
 ;
PCE ; -- PXK VISIT DATA EVENT protocol listener
 N IEN,PX0A,PX0B,DFN,SUB,DA,ACT,X
 S IEN=+$O(^TMP("PXKCO",$J,0)) Q:IEN<1
 S PX0A=$G(^TMP("PXKCO",$J,IEN,"VST",IEN,0,"AFTER")),PX0B=$G(^("BEFORE"))
 S DFN=$S($L(PX0A):+$P(PX0A,U,5),1:+$P(PX0B,U,5)) Q:DFN<1
 ; Visit file
 S ACT=$S(PX0A="":"@",1:"")
 I $P(PX0A,U,7)'="H",PX0A'=PX0B,ACT="" D POST^VPRHS(DFN,"Encounter",IEN_";9000010")
 I $P(PX0A,U,7)="H",PX0B="" D  ;assign visit# (other edits via DGPM)
 . N VAINDT S VAINDT=+PX0A D ADM^VADPT2
 . D:$G(VADMVT) POST^VPRHS(DFN,"Encounter",VADMVT_"~"_IEN_";405")
 ; check V-files
 F SUB="IMM","XAM","POV","HF" D  ;"PED","SK","CPT"
 . S DA=0 F  S DA=$O(^TMP("PXKCO",$J,IEN,SUB,DA)) Q:DA<1  D
 .. N NODE,AFTER,BEFORE,DIFF,SUB0 S DIFF=0
 .. F NODE=0,12,13,811 D  Q:DIFF
 ... S AFTER=$G(^TMP("PXKCO",$J,IEN,SUB,DA,NODE,"AFTER")),BEFORE=$G(^("BEFORE"))
 ... I NODE=0 S SUB0=$S(AFTER'="":AFTER,1:BEFORE)
 ... I BEFORE'=AFTER S DIFF=1,ACT=$S(NODE'=0:"",AFTER'="":"",1:"@")
 .. Q:'DIFF  S X=$$NAME(SUB) Q:X=""
 .. D POST^VPRHS(DFN,$P(X,U),(DA_";"_$P(X,U,2)),ACT,IEN)
 ; delete visit itself last
 I PX0B,PX0A="" D POST^VPRHS(DFN,"Encounter",IEN_";9000010","@")
 Q
 ;
NAME(X) ; -- return container name for V-files
 I X="HF",$$FHX Q "FamilyHistory^9000010.23"
 I X="HF",$$SHX Q "SocialHistory^9000010.23"
 ; X="HF"  Q "HealthConcern^9000010.23"
 I X="IMM" Q "Vaccination^9000010.11"
 I X="XAM" Q "PhysicalExam^9000010.13"
 I X="POV" Q "Diagnosis^9000010.07"
 ; X="CPT" Q "Procedure^9000010.18"
 ; X="PED" Q "education^9000010.16"
 ; X="SK"  Q "Procedure^9000010.12"
 Q ""
 ;
FHX() ; -- return 1 or 0, if HF name is for FamilyHistory
 N X S X=+$G(SUB0),X=$P($G(^AUTTHF(X,0)),U)
 I X["FAMILY HISTORY" Q 1
 I X["FAMILY HX" Q 1
 Q 0
 ;
SHX() ; -- return 1 or 0, if HF name is for SocialHistory
 N X S X=+$G(SUB0),X=$P($G(^AUTTHF(X,0)),U)
 I (X["TOBACCO")!(X["SMOK") Q 1
 ; (X["LIVES")!(X["LIVING") Q 1
 ; (X["RELIGIO")!(X["SPIRIT") Q 1
 Q 0
 ;
XQOR(MSG,FD) ; -- CPRS protocol event listener
 ; FD   = frontdoor msg from CPRS (get ORIFN for new backdoor orders)
 ; else = backdoor msg/ack from Pharmacy, Lab, Radiology, etc.
 N VPRMSG,MSH,VPRPKG,VPRSDA,DFN,ORC,ACT
 S VPRMSG=$S($L($G(MSG)):MSG,1:"MSG") Q:'$O(@VPRMSG@(0))
 S MSH=0 F  S MSH=$O(@VPRMSG@(MSH)) Q:MSH'>0  Q:$E(@VPRMSG@(MSH),1,3)="MSH"
 Q:'MSH  Q:'$L($G(@VPRMSG@(MSH)))  S DFN=$$PID Q:DFN<1
 ;S VPRPKG=$S($G(FD):$P(@VPRMSG@(MSH),"|",5),1:$P(@VPRMSG@(MSH),"|",3))
 ;S VPRSDA=$$ORDCONT(VPRPKG),DFN=$$PID Q:DFN<1
 S ORC=MSH F  S ORC=$O(@VPRMSG@(+ORC)) Q:ORC'>0  I $E($G(@VPRMSG@(ORC)),1,3)="ORC" D
 . N ORDCNTRL,PKGIFN,ORIFN
 . S ORC=ORC_U_@VPRMSG@(ORC),ORDCNTRL=$TR($P(ORC,"|",2),"@","P")
 . ; QUIT if action failed, conversion, purge, or backdoor verify/new
 . I ORDCNTRL["U"!("DE^ZC^ZP^ZR^ZV^SN"[ORDCNTRL) Q
 . I $G(FD),ORDCNTRL'="NA" Q  ;only want NA msg, from CPRS
 . S ACT=$S(ORDCNTRL="OC":"@",1:"")
 . ; Update *Order containers
 . S ORIFN=+$P($P(ORC,"|",3),U),PKGIFN=$G(^OR(100,ORIFN,4))
 . Q:$O(^OR(100,ORIFN,2,0))  ;should not be getting parent orders
 . S VPRPKG=$$NMSP(ORIFN),VPRSDA=$$ORDCONT(VPRPKG)
 . D POST^VPRHS(DFN,VPRSDA,ORIFN_";100",ACT)
 . I ORIFN D  ;update replaced order
 .. N ORIG S ORIG=+$P($G(^OR(100,ORIFN,3)),U,5)
 .. I ORIG D POST^VPRHS(DFN,VPRSDA,ORIG_";100")
 . ; Update Referral or Document containers
 . I VPRPKG="GMRC",PKGIFN D GMRC
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
GMRC ; -- Referrals
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
 N IDT,RPT,I,X,VST,STS,ACT
 S IDT=+$O(^RADPT("AO",+PKGIFN,DFN,0)),I=0
 ; find report(s) for order
 F  S I=$O(^RADPT("AO",+PKGIFN,DFN,IDT,I)) Q:I<1  D
 . S X=+$P($G(^RADPT(DFN,"DT",IDT,"P",I,0)),U,17),VST=$P($G(^(0)),U,27)
 . Q:'X  S STS=$$GET1^DIQ(74,X_",",5,"I"),ACT=""
 . Q:STS'="V"&(STS'="EF")&(STS'="X")  I STS="X" S ACT="@"
 . S:VST VST(X)=VST S:'$D(RPT(X)) RPT(X)=IDT_"-"_I
 ; update Document container
 S X=0 F  S X=$O(RPT(X)) Q:X<1  D POST^VPRHS(DFN,"Document",X_"~"_RPT(X)_";74",ACT,$G(VST(X)))
 Q
 ;
LRAP(MSG) ; -- LR7O AP EVSEND OR protocol listener
 N VPRMSG,MSH,DFN,ORC
 S VPRMSG=$S($L($G(MSG)):MSG,1:"MSG") Q:'$O(@VPRMSG@(0))
 S MSH=0 F  S MSH=$O(@VPRMSG@(MSH)) Q:MSH'>0  Q:$E(@VPRMSG@(MSH),1,3)="MSH"
 Q:'MSH  Q:'$L($G(@VPRMSG@(MSH)))
 S DFN=$$PID Q:DFN<1
 S ORC=MSH F  S ORC=$O(@VPRMSG@(+ORC)) Q:ORC'>0  I $E($G(@VPRMSG@(ORC)),1,3)="ORC" D
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
 N I,SEG,Y S I=MSH
 F  S I=$O(@VPRMSG@(I)) Q:I'>0  S SEG=$E($G(@VPRMSG@(I)),1,3) Q:SEG="ORC"  I SEG="PID" D  Q
 . S Y=+$P(@VPRMSG@(I),"|",4)
 .;I '$D(^DPT(Y,0)) S:$L($P(@VPRMSG@(I),"|",5)) Y=+$P(@VPRMSG@(I),"|",5) ;alt ID for Lab
 Q Y
 ;
PSB ; -- VPR PSB EVENTS protocol listener (BCMA)
 N IEN,DFN,ORPK,TYPE,ORIFN
 S IEN=$S($P($G(PSBIEN),",",2)'="":+$P(PSBIEN,",",2),$G(PSBIEN)="+1":+$G(PSBIEN(1)),1:+$G(PSBIEN))
 S DFN=+$G(^PSB(53.79,IEN,0)),ORPK=$P($G(^(.1)),U)
 Q:DFN<1  Q:ORPK<1  S TYPE=$S(ORPK["V":"IV",ORPK["U":5,1:"") Q:TYPE=""
 S ORIFN=0 ;+$P($G(^PS(55,DFN,TYPE,+ORPK,0)),U,21)
 D:ORIFN POST^VPRHS(DFN,"Medication",ORIFN_";100")
 Q
 ;
GMRA(ACT) ; -- GMRA SIGN-OFF ON DATA protocol listener
 ;   also GMRA ENTERED IN ERROR [ACT=@]
 N DFN,IEN
 S DFN=+$G(GMRAPA(0)),IEN=+$G(GMRAPA)
 D POST^VPRHS(DFN,"Allergy",IEN_";120.8") ;,$G(ACT))
 Q
 ;
GMRASMT(DFN) ; -- GMRAHDR Allergy Assessment listener
 D POST^VPRHS(DFN,"Allergy")
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
MDC(OBS) ; -- MDC OBSERVATION UPDATE protocol listener
 N DFN,ID,ACT
 S DFN=+$G(OBS("PATIENT_ID","I")) Q:DFN<1
 S ID=$G(OBS("OBS_ID","I")) Q:'$L(ID)
 S ACT=$S('$G(OBS("STATUS","I")):"@",1:"")
 D POST^VPRHS(DFN,"Observation",ID_";704.117",ACT)
 ;I $G(OBS("DOMAIN","VITALS")) D POST^VPRHS(DFN,"Observation",ID,ACT)
 Q
 ;
CP(DFN,ID,ACT) ; -- CP Transaction file #702 AVPR index (via VPRPROC)
 S DFN=+$G(DFN),ID=+$G(ID)
 N VST S VST=$$GET1^DIQ(702,ID,".06:.03","I")
 D POST^VPRHS(DFN,"Procedure",ID_";702",$G(ACT),VST)
 Q
 ;
TIU(DFN,IEN) ; -- TIU Document file #8925 AVPR index
 N ACT,STS,DAD,VST,VPRTIU,PROC
 S DFN=+$G(DFN),IEN=+$G(IEN),ACT=""
 ; $$ISA^TIULX(IEN,$$LR) Q   ;update from order?
 S STS=$G(X(2)),DAD=$G(X(3)) ;X = FM data array for index
 I STS<7 Q                   ;not complete
 I STS=9 Q                   ;archived, leave in cache
 S:DAD IEN=DAD I 'DAD D      ;if addendum, repull entire note
 . I STS>13 S ACT="@"        ;deleted or retracted
 . I $G(X2(1))="" S ACT="@"  ;deleted (new title = null)
 D EXTRACT^TIULQ(IEN,"VPRTIU",,".03;1405",,1,"I")
 S VST=$G(VPRTIU(IEN,.03,"I"))
 D POST^VPRHS(DFN,"Document",IEN_";8925",ACT,VST)
 ;Update request?
 S PROC=$G(VPRTIU(IEN,1405,"I")) I PROC D
 . I PROC["SRF" D POST^VPRHS(DFN,"Procedure",+PROC_";130")
 . I PROC["GMR" D POST^VPRHS(DFN,"Referral",+PROC_";123")
 ; Also update alert containers if CWD
 I $$ISA^TIULX(IEN,27) D POST^VPRHS(DFN,"AdvanceDirective") Q  ;rebuild
 I $$ISA^TIULX(IEN,30) D POST^VPRHS(DFN,"Alert",IEN_";8925",ACT) Q
 I $$ISA^TIULX(IEN,31) D POST^VPRHS(DFN,"Alert",IEN_";8925",ACT) Q
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
