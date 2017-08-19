HMPEVNT ;SLC/MKB,ASMR/JD,RRB,CPC,MBS -- VistA event listeners;Aug 29, 2016 20:06:27
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2,3**;May 15, 2016;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; DG FIELD MONITOR              3344
 ; DGPM MOVEMENT EVENTS          1181
 ; GMRA ENTERED IN ERROR         1467
 ; GMRA SIGN-OFF ON DATA         1469
 ; GMRC EVSEND OR                3140
 ; LR70 CH EVSEND OR             6087
 ; MDC OBSERVATION UPDATE        6084
 ; PS EVSEND OR                  2415
 ; PSB EVSEND HMP                6085
 ; PXK VISIT DATA EVENT          1298
 ; RA EVSEND OR                  6086
 ; SDAM APPOINTMENT EVENTS       1320
 ; ^AUPNVSIT                     2028
 ; ^DPT                         10035
 ; ^OR(100                       5771
 ; DIQ                           2056
 ; GMVUTL                        5046
 ; TIUSRVLO                      2834
 ; VADPT                        10061
 ; VASITE                       10112
 ; XLFDT                        10103
 ; XTHC10                        5515
 ; ORDRNUM^PSSUTLA2              6426  ;DE6363 - JD - 8/23/16
 ;
 ; DE2818 - SQA findings.
 ;          1) Correct unkilled variables by modifying line tags to accept variables as
 ;          parameters and modifying associated protocol routine calls to pass variables
 ;          as parameters. RRB - 10/28/2015
 ;
 ;Oct 15, 2015 - PB - modified to trigger an unsolicited sync action when an order is discontinued and the patient is subscribed to eHMP
 ;
 ;DE3327 - 5/4/16 - JD - Removed the server hardcoding (hmp-development-box).
 ;                       *** NOTE ***
 ;                       It is understood that as of the date of modifying this code (5/4/16), there
 ;                       is one AND ONLY one server entry in the HMP Subscription file (#800000)
 ;                       per site.  This will be fixed in future releases to accommodate multiple
 ;                       servers per site.
 ;
 Q
 ;
DG(DGDA,DGFIELD,DGFILE) ; -- DG FIELD MONITOR protocol listener  /DE2818 
 Q:$G(DGFILE)'=2         ;Patient file only
 N DFN S DFN=+$G(DGDA)
 ; operational pt-select - *s68 BEGIN
 I "^.01^.02^.03^.09^.101^.351^.361^"[(U_+$G(DGFIELD)_U) D
 . ; -- if patient entry has been deleted, delete pt-select object
 . I $G(DGFIELD)=".01",'$D(^DPT(DFN)) D POSTX("pt-select",DFN,"@") Q  ; *s68 - END
 . D POSTX("pt-select",DFN_"&"_$G(DGFIELD))
 ; subscribed patient
 I $D(^HMP(800000,"AITEM",DFN)),$$FLD(+$G(DGFIELD)) D POST(DFN,"patient",DFN)
 Q
 ;
FLD(X) ; --Return 1 or 0, if X is a field tracked by HMP
 S X=U_+$G(X)_U
 I "^.01^.02^.03^.05^.08^.09^.351^.361^.364^"[X Q 1         ;demographic
 I "^.111^.1112^.112^.113^.114^.115^.131^.132^.134^"[X Q 1  ;addr/phone
 I "^.211^.212^.213^.214^.216^.217^.218^.219^"[X Q 1        ;NOK
 I "^.301^.302^1901^.32102^.32103^.32201^.5295^"[X Q 1      ;serv conn
 ;New fields.  JD - 9/24/15
 I "^.133^"[X Q 1                                           ;email address
 I "^.1211^.1212^.1213^.1214^.1215^.1216^"[X Q 1            ;temporary address
 I "^.331^.332^.333^.334^.335^.336^.337^.338^.339^.33011^"[X Q 1  ;emergency contact addr/phone
 I "^.215^.21011^"[X Q 1                                    ;NOK addr line 3 and work phone
 I "^.3731^"[X Q 1                                          ;service connected conditions
 I "^.18^3^8^16^"[X Q 1                                     ;insurance  
 Q 0
 ;
DGPM(DGPMA,DGPMDA,DGPMP,DGPMT) ; -- DGPM MOVEMENT EVENTS protocol listener  /DE2818
 ;    [expects DFN,DGPM* variables]
 N ADM,ACT S ADM=DGPMDA
 I DGPMT'=1 S ADM=$S(DGPMA:$P(DGPMA,U,14),1:$P(DGPMP,U,14)) Q:ADM<1
 S ACT=$S(DGPMA:"",1:"@")
 I $D(^HMP(800000,"AITEM",DFN)) D POST(DFN,"visit","H"_ADM,ACT)
 ; update roster(s) if current movement
 N ADMX,MVTX,PREV,NEW,OLD,WARD
 S ADMX=$Q(^DGPM("ATID1",DFN)) Q:$QS(ADMX,4)'=ADM
 S MVTX=$Q(^DGPM("APMV",DFN,ADM)) Q:$QS(MVTX,5)'=DGPMDA
 S PREV=$G(DGPMP) I 'PREV,DGPMT'=1 D  ;previous or edited mvt
 . S MVTX=$Q(@MVTX) Q:DFN'=$QS(MVTX,2)  Q:ADM'=$QS(MVTX,3)
 . S PREV=$G(^DGPM(+$QS(MVTX,5),0))
 S NEW=$P(DGPMA,U,6),OLD=$P(PREV,U,6)
 I NEW'=OLD F WARD=NEW,OLD I WARD D
 . S I=0 F  S I=$O(^HMPROSTR("AD",WARD_";DIC(42,",I)) Q:I<1  D POSTX("roster",I)
 Q
 ;-find visit# for corresponding admission [not used]
 N ADM,PTF,IDT,ID,ACT
 I DGPMA S ADM=+DGPMA,PTF=+$P(DGPMA,U,16)
 E  S ADM=+DGPMP,PTF=+$P(DGPMP,U,16)
 I DGPMT'=1 D  Q:ADM<1
 . N VAIP S VAIP("E")=DGPMDA
 . D IN5^VADPT S ADM=+VAIP(13,1),PTF=+VAIP(12)
 S IDT=9999999-$P(ADM,".") S:ADM["." IDT=IDT_"."_$P(ADM,".",2)
 S ID=+$O(^AUPNVSIT("AAH",DFN,IDT,0)) Q:'ID
 S ACT=$S(DGPMA:"",1:"@")
 D POST(DFN,"visit",ID,ACT)
 ; POST(DFN,"ptf",PTF,ACT):DGPMT=3
 Q
 ;
NEWINPT() ; -- is DFN newly admitted?
 N Y S Y=0
 I DGPMT=1,DGPMA,'DGPMP,+$G(^DPT(DFN,.105))=DGPMDA S Y=1 ;new admission
 Q Y
 ;
PCMMT(SCPTTMAF,SCPTTMB4) ; -- SCMC PATIENT TEAM CHANGES protocol listener /DE2818
 ;I '$P($G(SCPTTMB4),U,8),'$P($G(SCPTTMAF),U,8) Q  ;not pc change ;DE5410 removed to track changes to other teams
 N DFN S DFN=$S($G(SCPTTMAF):+SCPTTMAF,1:+$G(SCPTTMB4)) Q:'DFN
 D POST(DFN,"patient",DFN)
 Q
 ;
PCMMTP(SCPTTPAF,SCPTTPB4) ; -- SCMC PATIENT TEAM POSITION CHANGES protocol listener /DE2818
 ;I '$P($G(SCPTTPB4),U,5),'$P($G(SCPTTPAF),U,5) Q  ;not pc change ;DE5410 removed to track changes to other teams
 N TM,DFN
 S TM=$S($G(SCPTTPAF):+SCPTTPAF,1:+$G(SCPTTPB4)) Q:'TM
 ;DE2818
 S DFN=$$GET1^DIQ(404.42,+TM_",",.01,"I")  ;ICR 1922
 D POST(DFN,"patient",DFN)
 Q
 ;
SDAM(SDATA) ; -- SDAM APPOINTMENT EVENTS protocol listener /DE2818
 I $G(SDATA)'="" D  Q  ;appointments ;DE5411 still process if Piece 1 not set, catches auto-rebook status
 . N DFN,DATE,HLOC,STS,REASON,PROV
 . S DFN=+$P(SDATA,U,2) I '(DFN>0) D LOGDPT^HMPLOG(DFN) Q  ;DE4496 19 August 2016
 . Q:'$D(^HMP(800000,"AITEM",DFN))
 . S DATE=+$P(SDATA,U,3),HLOC=+$P(SDATA,U,4),(PROV,REASON)=""
 . D POST(DFN,"appointment","A;"_DATE_";"_HLOC_";"_REASON_";"_$TR($P(PROV,U,1,2),"^",";"))
 Q
 ;
PCE ; -- PXK VISIT DATA EVENT protocol listener, used by HMP PCE EVENTS protocol
 N ACT,DA,DFN,HMPPXK,IEN,PX0A,PX0B,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK ;DE4195 and DE6485
 S IEN=+$O(^TMP("PXKCO",$J,0)) Q:IEN<1
 S PX0A=$G(^TMP("PXKCO",$J,IEN,"VST",IEN,0,"AFTER")),PX0B=$G(^("BEFORE"))
 S DFN=$S($L(PX0A):+$P(PX0A,U,5),1:+$P(PX0B,U,5))
 Q:'(DFN>0)  Q:'$D(^HMP(800000,"AITEM",DFN))  ;DE4496 19 August 2016
 ; Visit file
 S ACT=$S(PX0A="":"@",1:"")
 ;DE4195 - put subsequent processing into taskman
 M HMPPXK=^TMP("PXKCO",$J)
 ; DE6485, add null device in ZTIO
 S ZTRTN="PCE2^HMPEVNT",ZTDTH=$H,ZTIO="",ZTSAVE("HMPPXK(")="",ZTSAVE("DFN")="",ZTSAVE("IEN")="",ZTSAVE("ACT")=""
 S ZTDESC="HMP PXK VISIT EVENT HANDLER"
 D ^%ZTLOAD
 Q
PCE2 ; DE4195 - run in taskman
 N DA,SUB
 D POST(DFN,"visit",IEN,ACT)
 ; check V-files
 ;DE4879 - Removed Health Factors from loop (was SUB="HF","IMM",...)
 F SUB="IMM","XAM","CPT","PED","POV","SK" D
 . S DA=0 F  S DA=$O(HMPPXK(IEN,SUB,DA)) Q:DA<1  D
 .. S ACT=$S($G(HMPPXK(IEN,SUB,DA,0,"AFTER"))="":"@",1:"")
 .. D POST(DFN,$$NAME(SUB),DA,ACT)
 Q
 ;
NAME(X) ; -- return object name for V-files
 N Y S Y=""
 I X="HF"  S Y="factor"
 I X="IMM" S Y="immunization"
 I X="XAM" S Y="exam"
 I X="CPT" S Y="cpt"
 I X="PED" S Y="education"
 I X="POV" S Y="pov"
 I X="SK"  S Y="skin"
 Q Y
 ;
ZPCE ; -- old PXK VISIT DATA EVENT protocol listener [not in use]
 N IEN,PX0,PX150,DFN,DA
 S IEN=+$O(^TMP("PXKCO",$J,0)) Q:IEN<1
 S PX0=$G(^TMP("PXKCO",$J,IEN,"VST",IEN,0,"AFTER")) Q:$P(PX0,U,7)="E"
 I PX0="" D POST(DFN,"visit",IEN,"@") Q  ;deleted
 S PX150=$G(^TMP("PXKCO",$J,IEN,"VST",IEN,150,"AFTER")) Q:$P(PX150,U,3)'="P"
 S DFN=+$P(PX0,U,5) Q:'(DFN>0)  Q:'$D(^HMP(800000,"AITEM",DFN))  ;DE4496 19 August 2016
 D POST(DFN,"visit",IEN)
 S DA=0 F  S DA=$O(^TMP("PXKCO",$J,IEN,"IMM",DA)) Q:DA<1  D POST(DFN,"immunization",DA)
 S DA=0 F  S DA=$O(^TMP("PXKCO",$J,IEN,"HF",DA)) Q:DA<1  D POST(DFN,"factor",DA)
 Q
 ;
XQOR(MSG) ; -- messaging listener (update meds, labs, xrays, consults)
 N HMPMSG,HMPPKG,MSH,ORC,DFN
 S HMPMSG=$S($L($G(MSG)):MSG,1:"MSG") Q:'$O(@HMPMSG@(0))
 S MSH=0 F  S MSH=$O(@HMPMSG@(MSH)) Q:MSH'>0  Q:$E(@HMPMSG@(MSH),1,3)="MSH"
 Q:'MSH  Q:'$L($G(@HMPMSG@(MSH)))
 S HMPPKG=$$TYPE($P(@HMPMSG@(MSH),"|",3))  Q:'$L(HMPPKG)
 S DFN=$$PID Q:'(DFN>0)  Q:'$D(^HMP(800000,"AITEM",DFN))  ;DE4496 19 August 2016
 S ORC=MSH F  S ORC=$O(@HMPMSG@(+ORC)) Q:ORC'>0  I $E(@HMPMSG@(ORC),1,3)="ORC" D
 . N ORDCNTRL,PKGIFN,ORIFN,PORIFN
 . S ORC=ORC_U_@HMPMSG@(ORC),ORDCNTRL=$TR($P(ORC,"|",2),"@","P")
 . ; QUIT if action failed, conversion, purge, or backdoor verify/new
 . ;I ORDCNTRL["U"!("DE^ZC^ZP^ZR^ZV^SN"[ORDCNTRL) Q
 . I ORDCNTRL["U"!("DE^ZP^ZR^ZV^SN"[ORDCNTRL) Q  ;Oct 15, 2015 - PB - modified to trigger an unsolicited sync action when a signed order is discontinued
 . S ORIFN=+$P($P(ORC,"|",3),U),PKGIFN=$P($P(ORC,"|",4),U)
 . ; If this is a child order get the parent and send it too
 . ; PORIFN = PARENT ORDER IFN
 . S PORIFN=+$P($G(^OR(100,ORIFN,3)),U,9)
 . I $$RESULT D  ;update ancillary domains
 .. D POST(DFN,HMPPKG,PKGIFN)
 .. D:HMPPKG="image" POST(DFN,"document",PKGIFN)
 .. I HMPPKG="lab",PKGIFN'["CH",'$$LRTIU(DFN,PKGIFN) D POST(DFN,"document",$P(PKGIFN,";",4,5))
 . I ORIFN,ORDCNTRL'="ZD" D  ;update order(s)
 .. D POST(DFN,"order",ORIFN)
 .. I PORIFN D POST(DFN,"order",PORIFN)
 .. N ORIG S ORIG=+$P($G(^OR(100,ORIFN,3)),U,5)
 .. I ORIG D POST(DFN,"order",ORIG) ;need fwd ptrs, sig flds
 Q
 ;
RESULT() ; -- Return 1 or 0, if message broadcasts a result
 ;           [may modify PKGIFN for use in POST]
 N Y S Y=0
 I HMPPKG="consult" S Y=1,PKGIFN=+PKGIFN G RQ
 I HMPPKG="med"     S Y=1,PKGIFN=ORIFN G RQ
 I HMPPKG="lab"     S:ORDCNTRL="RE"&($L(PKGIFN,";")>3) Y=1 G RQ
 I HMPPKG="image"   S:PKGIFN["~" Y=1,PKGIFN=$TR($P(PKGIFN,"~",2,3),"~","-") G RQ
RQ Q Y
 ;
LRTIU(DFN,ORPK) ; -- Return 1 or 0, if LR report is in TIU
 I $G(DFN)<1!'$L($G(ORPK)) Q 0
 I ORPK["CH"!(ORPK["MI") Q 0
 N SUB,IDT,LRDFN
 S SUB=$P(ORPK,";",4),IDT=+$P(ORPK,";",5),LRDFN=+$G(^DPT(+DFN,"LR"))
 I $O(^LR(LRDFN,SUB,IDT,.05,0)) Q 1
 Q 0
 ;
NA(MSG) ; -- messaging listener (new backdoor orders)
 N HMPMSG,HMPPKG,MSH,ORC,DFN
 S HMPMSG=$S($L($G(MSG)):MSG,1:"MSG") Q:'$O(@HMPMSG@(0))
 S MSH=0 F  S MSH=$O(@HMPMSG@(MSH)) Q:MSH'>0  Q:$E(@HMPMSG@(MSH),1,3)="MSH"
 Q:'MSH  Q:'$L($G(@HMPMSG@(MSH)))
 S HMPPKG=$$TYPE($P(@HMPMSG@(MSH),"|",5))  Q:'$L(HMPPKG)
 S DFN=$$PID Q:'(DFN>0)  Q:'$D(^HMP(800000,"AITEM",DFN))  ;DE4496 19 August 2016
 S ORC=MSH F  S ORC=$O(@HMPMSG@(+ORC)) Q:ORC'>0  I $E(@HMPMSG@(ORC),1,3)="ORC" D
 . N ORDCNTRL,ORIFN
 . S ORC=ORC_U_@HMPMSG@(ORC),ORDCNTRL=$TR($P(ORC,"|",2),"@","P")
 . Q:ORDCNTRL'="NA"
 . S ORIFN=+$P($P(ORC,"|",3),U) D POST(DFN,"order",ORIFN)
 . I HMPPKG="med" D POST(DFN,HMPPKG,ORIFN)
 Q
 ;
TYPE(NAME) ; -- Returns type name for XML
 I NAME="LABORATORY"  Q "lab"
 I NAME="PHARMACY"    Q "med"
 I NAME="CONSULTS"    Q "consult"
 I NAME="PROCEDURES"  Q "consult"
 I NAME="RADIOLOGY"   Q "image"
 I NAME="IMAGING"     Q "image"
 I NAME="ORDER ENTRY" Q "order"
 I NAME="DIETETICS"   Q "diet"
 Q ""
 ;
PID() ; -- Returns patient from PID segment in current msg
 N I,SEG,Y S I=MSH
 F  S I=$O(@HMPMSG@(I)) Q:I'>0  S SEG=$E(@HMPMSG@(I),1,3) Q:SEG="ORC"  I SEG="PID" D  Q
 . S Y=+$P(@HMPMSG@(I),"|",4)
 .;I '$D(^DPT(Y,0)) S:$L($P(@HMPMSG@(I),"|",5)) Y=+$P(@HMPMSG@(I),"|",5) ;alt ID for Lab
 Q Y
 ;
PV1() ; -- Returns patient class from PV1 segment in current msg
 N I,SEG,Y S I=MSH,Y=""
 F  S I=$O(@HMPMSG@(I)) Q:I'>0  S SEG=$E(@HMPMSG@(I),1,3) Q:SEG="ORC"  I SEG="PV1" D  Q
 . S Y=$P(@HMPMSG@(I),"|",3)
 I Y="",$G(ORIFN) S Y=$$GET1^DIQ(100,+ORIFN_",",10,"I")
 Q Y
 ;
GMRA(ACT) ; -- GMRA SIGN-OFF ON DATA protocol listener
 ;   also GMRA ENTERED IN ERROR [ACT=@]
 N DFN,IEN
 S DFN=+$G(GMRAPA(0)),IEN=+$G(GMRAPA)
 D POST(DFN,"allergy",IEN,$G(ACT))
 Q
 ;
GMPL(DFN,IEN) ; -- GMPL EVENT protocol listener
 S DFN=+$G(DFN),IEN=+$G(IEN)
 ;N ACT S ACT=$S($P($G(^AUPNPROB(IEN,1)),U,2)="H":"@",1:"")
 D POST(DFN,"problem",IEN) ;,ACT)
 Q
 ;
GMRV(DFN,IEN,ERR) ; -- Vital Measurement file #120.5 AHMP index
 S DFN=+$G(DFN),IEN=+$G(IEN)
 N ACT S ACT=$S($G(ERR):"@",1:"")
 D POST(DFN,"vital",IEN,ACT)
 Q
 ;
MDC(OBS) ; -- MDC OBSERVATION UPDATE protocol listener
 N DFN,ID,ACT
 S DFN=+$G(OBS("PATIENT_ID","I")) Q:'(DFN>0)  ;DE4496 19 August 2016
 S ID=$G(OBS("OBS_ID","I")) Q:'$L(ID)
 S ACT=$S('$G(OBS("STATUS","I")):"@",1:"")
 D POST(DFN,"obs",ID,ACT)
 I $G(OBS("DOMAIN","VITALS")) D POST(DFN,"vital",ID,ACT)
 Q
 ;
CP(DFN,ID,ACT) ; -- CP Transaction file #702 AHMP index
 S DFN=+$G(DFN),ID=$G(ID)
 D POST(DFN,"document",ID,$G(ACT)) ;de3944 also need to generate document for procedure to link results to
 D POST(DFN,"procedure",ID,$G(ACT))
 Q
 ;
SR(DFN,IEN,ACT) ; -- Surgery [SROERR] update
 S DFN=+$G(DFN),IEN=+$G(IEN)
 D POST(DFN,"surgery",IEN,$G(ACT))
 Q
 ;*s68 - BEGINS
TIU(DFN,IEN) ; -- TIU Document file #8925 AHMP index
 N ACT,STS,DAD,REPCAT
 S DFN=+$G(DFN),IEN=+$G(IEN),ACT=""
 S STS=$G(X(2)),DAD=$G(X(3)) ;X = FM data array for index
 S:DAD IEN=DAD I 'DAD D      ;if addendum, repull entire note
 . ;I STS=15 S ACT="@"       ;retracted; DE3693 - do not delete note from JDS if retracted, March 18, 2016
 . I $G(X2(1))="" S ACT="@"  ;deleted (new title = null)
 D POST(DFN,"document",IEN,ACT)
 ;DE3944 update surgery based on reports
 S REPCAT=$$CATG^HMPDTIU($$GET1^DIQ(8925,IEN_",",".01","I"))
 I REPCAT="SR" D
 . N REPCASE S REPCASE=$$GET1^DIQ(8925,IEN_",","1701","I")
 . S REPCASE=$P(REPCASE,"Case #: ",2)
 . I REPCASE D POST(DFN,"surgery",REPCASE)
 ;DE3241 - If TIU update changes CWADF values, trigger patient update so change get in fresh. stream
 ;If this note has a parent document type of "CLINICAL WARNING", "CRISIS NOTE", or "ADVANCE DIRECTIVE"...
 ;parent document type is "Document Class"...
 ;AND this note's status is COMPLETED or AMENDED
 ;THEN this document may update the C, W, or D CWADF values and patient fresh. stream update needs to be triggered
 N DADTYPE,DADNAME,STATUS
 S DADTYPE=$$GET1^DIQ(8925,IEN_",",".04","I") Q:'DADTYPE  Q:$$GET1^DIQ(8925.1,DADTYPE_",",".04","I")'="DC"
 S DADNAME=$$GET1^DIQ(8925.1,DADTYPE_",",".01")
 I $S(DADNAME="CLINICAL WARNING":0,DADNAME="CRISIS NOTE":0,DADNAME="ADVANCE DIRECTIVE":0,1:1) Q
 D POST(DFN,"patient",DFN)
 Q
 ; Deprecated calls
DOCDEF ;
DOCITEM ;
USR ;
 Q
 ; *s68 - END
PSB(PSBIEN) ; -- HMP PSB EVENTS protocol listener (BCMA) /DE2818
 N IEN,DFN,ORPK,TYPE,ORIFN
 S IEN=$S($P($G(PSBIEN),",",2)'="":+$P(PSBIEN,",",2),$G(PSBIEN)="+1":+$G(PSBIEN(1)),1:+$G(PSBIEN))
 S DFN=+$G(^PSB(53.79,IEN,0)),ORPK=$P($G(^(.1)),U)
 Q:'(DFN>0)  Q:ORPK<1  S TYPE=$S(ORPK["V":"IV",ORPK["U":5,1:"") Q:TYPE=""  ;DE4496 19 August 2016
 S ORIFN=$$ORDRNUM^PSSUTLA2(DFN,TYPE,+ORPK)  ;DE4382 get order number from PSSUTLA2. ICR 6426
 D:ORIFN POST(DFN,"med",ORIFN)
 Q
 ;
XU(IEN,ACT) ; -- XU USER ADD/CHANGE/TERMINATE option listener
 S IEN=+$G(IEN) Q:IEN<1
 D POSTX("user",IEN,$G(ACT))
 Q
 ;
POST(DFN,TYPE,ID,ACT) ; -- track updated patient data
 S DFN=+$G(DFN),TYPE=$G(TYPE),ID=$G(ID)
 Q:'(DFN>0)  Q:TYPE=""  Q:ID=""   ;incomplete request - DE4496 19 August 2016
 Q:$G(^XTMP("HMP-off",TYPE))   ;domain turned 'off'
 Q:'$D(^HMP(800000,"AITEM",DFN))  ;patient not subscribed to
 N HMPDT S HMPDT="HMP-"_DT
 ;S ^XTMP(HMPDT,$$NEXT)=DFN_U_TYPE_U_ID_U_$G(ACT)
 N NODES
 D POST^HMPDJFS(DFN,TYPE,ID,$G(ACT),"",.NODES)
 Q
 ;
POSTX(TYPE,ID,ACT) ; -- track updated reference items
 S TYPE=$G(TYPE),ID=$G(ID)
 Q:TYPE=""  Q:ID=""            ;incomplete request
 Q:$G(^XTMP("HMP-off",TYPE))   ;domain turned 'off'
 N HMPDT S HMPDT="HMP-"_DT ;"HMPEF-"_DT
 ;S ^XTMP(HMPDT,$$NEXT)=U_TYPE_U_ID_U_$G(ACT)
 N NODES
 D POST^HMPDJFS("OPD",TYPE,ID,$G(ACT),"",.NODES)
 Q
 ;
NEXT() ; -- Return next sequential number in ^XTMP(HMPDT,n)
 L +^XTMP(HMPDT):5 ;I'$T ??
 N Y S Y=+$O(^XTMP(HMPDT,"A"),-1)+1
 I '$D(^XTMP(HMPDT,0)) S ^(0)=$$FMADD^XLFDT(DT,3)_U_DT_"^HMP Updates"
 L -^XTMP(HMPDT)
 Q Y
 ;
HTTP(URL,DFN,TYPE,ID) ; -- send message that TYPE/ID has been updated [not in use]
 N DIV,X,HMPX
 S DFN=+$G(DFN) Q:'(DFN>0)  ;patient req'd - DE4496 19 August 2016
 S DIV=$P($$SITE^VASITE,U,3) ;station number
 S URL=$G(URL)_"?division="_DIV_"&dfn="_+$G(DFN)
 I $L($G(TYPE)) S URL=URL_"&type="_TYPE
 I $L($G(ID))   S URL=URL_"&id="_ID
 S ^XTMP("HMP",DFN,"HTTP")=$H
 S X=$$GETURL^XTHC10(URL,,"HMPX")
 ; I X>200 = ERROR
 Q
DGREG ; register a newly registered patient in eHMP during the initial registration - Sep 29, 2015 - Phil Burkhalter
 Q:'($G(DFN)>0)  ;DE4496 19 August 2016
 Q:'$D(^DPT(DFN,0))  ; Quit if patient is not in the patient file
 ;check the XPAR for HMP Auto Enrollment with newly registered patients, 
 ;if set to yes for automatically adding a new HMP subscription:
 ;add the patient to HMP(800000 and to a pt-select update. Only want to do an update for the one patient if possible.
 ;if set to no for automatically adding a new HMP subscrption:
 ;only do the pt-select update, DO NOT add to the HMP subscription
 S X=$$GET^XPAR("SYS","HMP AUTOSYNC REG")  ;X=1 Yes auto subscribe patient to HMP, X="" or X=0 No don't auto subscribe the patient to HMP
 I $G(X)'=1 D POSTX(DFN,"patient",DFN) Q  ; Do pt-select
 I $G(X)=1 D
 .Q:$D(^HMP(800000,"AITEM",DFN))  ; Quit if the patient has already been added to the eHMP subscription
 .S ARGS("command")="putPtSubscription",ARGS("localId")=$G(DFN)
 .;DE3327
 .I '$L($G(ARGS("server"))) S ARGS("server")=$P($G(^HMP(800000,1,0)),"^")  ; See comments at the top
 .D API^HMPDJFS(.RSLT,.ARGS) D POSTX(DFN,"patient",DFN)  ; add patient to HMP(800000 and if patient is added, add patient to the freshness stream
 .K ARGS,RSLT
 K X
 Q
