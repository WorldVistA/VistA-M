VPR1P36 ;SLC/MKB/CMF -- Patch 36 CTP ;9/13/23  10:46
 ;;1.0;VIRTUAL PATIENT RECORD;**36**;Sep 01, 2011;Build 23
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ;
 ; This code is called from the HealthShare CallToPopulate utility to
 ; resend records corrected by VPR*1*36 in:
 ;    Observation           - Vital Observations missing Unit of Measure
 ;
 ;
ENV ;Main entry point for Environment check point.
 ;
 S XPDABORT=""
 D PROGCHK(.XPDABORT) ;checks programmer variables
 I XPDABORT="" K XPDABORT
 Q
 ;
 ;
PROGCHK(XPDABORT) ;checks for necessary programmer variables
 ;
 I '$G(DUZ)!($G(DUZ(0))'="@")!('$G(DT))!($G(U)'="^") D
 .D BMES^XPDUTL("*****")
 .D MES^XPDUTL("Your programming variables are not set up properly.")
 .D MES^XPDUTL("Installation aborted.")
 .D MES^XPDUTL("*****")
 .S XPDABORT=2
 Q
 ;
 ;
 ; This code is called from the HealthShare CallToPopulate utility to
 ; resend records corrected by VPR*1*36 in:
 ;    Observation           - Vital Observations missing Unit of Measure
 ;
 ;
EN(START,STOP,TYPE,FMT,PAT,VPRY) ; -- entry point to test CTP
 N VPRBDT,VPREDT,VPRTYPE,VPRPAT,VPRPT,VPRFMT,VPRII,VPRN,VPR36
 S VPRBDT=$G(START,3190401)
 S VPR36=$$PATCH(36)
 S VPREDT=$S(+$G(STOP):STOP,VPR36'=0:VPR36,1:DT)
 S VPRPAT=$NA(^VPR(1,2)) I $L($G(PAT)) D
 . I +PAT=PAT S VPRPT(+PAT)="",VPRPAT="VPRPT" Q
 . I ($E(PAT)="^")!($E(PAT)?1.A),$D(@PAT)>9 S VPRPAT=PAT Q
 ;
 S VPRY=$G(VPRY,$NA(^XTMP("VPRP36"))) K @VPRY
 S @VPRY@(0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"Call To Populate SDA P36"
 S (VPRN,VPRN("D"),VPRN("U"))=0
 S VPRFMT=$G(FMT,"OBS"),VPRII=0
 ;
 S VPRTYPE=$G(TYPE,"OBS") ;default=all tags in routine
 D CTP
 ;
 D BMES^XPDUTL(" Total results returned: "_VPRN)
 D MES^XPDUTL("               #updates: "_$G(VPRN("U")))
 D MES^XPDUTL("               #deletes: "_$G(VPRN("D")))
 M @VPRY@("Tot")=VPRN
 S @VPRY@("Tot")=VPRN_U_VPRN("U")_U_VPRN("D")_U_VPRII
 D:$D(@VPRY@("Tot","OBS"))
 . D MES^XPDUTL("            #OBS Domain: "_@VPRY@("Tot","OBS"))
 Q
 ;
PATCH(P) ; -- return patch P installation date
 N Y,VPRI S P=+$G(P)
 S Y=$$INSTALDT^XPDUTL("VPR*1.0*"_P,.VPRI)
 I Y S Y=$O(VPRI(0)) ;[first]install date.time
 Q Y
 ;
CTP ; -- main loops,called from VPRZCTP on HealthShare
 ; Expects VPRBDT,VPREDT,VPRTYPE,VPRPAT,VPRN
 N STN,DFN,ICN,VPRT,TAG
 S STN=$P($$SITE^VASITE,U,3) Q:$G(VPRTYPE)=""
 I '$D(VPRPAT) S VPRPAT=$S($D(VPRPT):"VPRPT",1:$NA(^VPR(1,2)))
 S DFN=0 F  S DFN=$O(@VPRPAT@(DFN)) Q:DFN<1  D
 . S ICN=$$ICN(DFN) Q:ICN<0
 . F VPRT=1:1:$L(VPRTYPE,",") S TAG=$P(VPRTYPE,",",VPRT) I $L(TAG) D
 .. S TAG=$E($$UP^XLFSTR(TAG),1,8) I $L($T(@TAG)) D @TAG
 Q
 ;
ICN(DFN) ; -- return ICN or -1^invalid
 N Y I $G(DFN)<1 S Y="-1^ERROR" G ICQ
 I '$D(^DPT(DFN,0)) S Y="-1^UNDEFINED" G ICQ
 I '$D(^VPR(1,2,+$G(DFN),0)) S Y="-1^UNSUBSCRIBED" G ICQ
 I $$MERGED^VPRHS(DFN) S Y="-1^MERGED" G ICQ
 S Y=$$GETICN^MPIF001(DFN) ;-1^error or ICN
ICQ ;exit
 Q Y
 ;
POST(TYPE,ID,ACT,VST) ; -- post an update to
 ; @VPRY@(SEQ) = ICN ^ TYPE ^ ID ^ U/D ^ VISIT# ^ DFN
 ;
 S TYPE=$G(TYPE),ID=$G(ID) Q:TYPE=""  Q:ID=""
 S ACT=$S($G(ACT)="@":"D",1:"U")
 ; add/update list
 S VPRN(TAG)=+$G(VPRN(TAG))+1
 S VPRN(ACT)=+$G(VPRN(ACT))+1
 S VPRN=+$G(VPRN)+1,VPRII=+$G(VPRII)+1
 I VPRFMT'="CNT" D  ;include data node, if not just counts
 . S @VPRY@(VPRII)=$G(ICN)_U_$G(TYPE)_U_$G(ID)_U_$G(ACT)_U_$G(VST)_U_DFN
 S @VPRY@("DFN",DFN,VPRII)=""
 S @VPRY@("DOMAIN",DFN,TYPE,VPRII)=""
 Q
 ;
OBS ; -- Vital Observations missing Unit of Measure
 ; Expects DFN,VPRBDT,VPREDT,VPRN
 N GMRVSTR,VPRIDT,VPRTYP,ID,X0,TYP,GUID,DMAX,DRANGE
 S GMRVSTR="BP;T;R;P;HT;WT;CVP;CG;PO2;PN" ;CPRS vitals data set
 S DMAX=99999
 S GMRVSTR(0)=$G(VPRBDT)_U_$G(VPREDT)_U_DMAX_U_1
 D EN1^GMRVUT0
 S VPRIDT=0 F  S VPRIDT=$O(^UTILITY($J,"GMRVD",VPRIDT)) Q:VPRIDT<1  D  Q:VPRN'<DMAX
 . S VPRTYP="" F  S VPRTYP=$O(^UTILITY($J,"GMRVD",VPRIDT,VPRTYP)) Q:VPRTYP=""  D 
 .. S ID=$O(^UTILITY($J,"GMRVD",VPRIDT,VPRTYP,0)) Q:'ID
 .. S X0=$G(^UTILITY($J,"GMRVD",VPRIDT,VPRTYP,ID))
 .. S TYP=$P(X0,U,3)
 .. Q:TYP=""
 .. D POST("Observation",ID_";120.5","U") ; Send update with Unit of Measure
 K ^UTILITY($J,"GMRVD")
 Q
 ;
 ;
PO ;Main entry point for Post-init items.
 ; Queue off predictor to run after 10:00pm
 D BMES^XPDUTL(" Queuing CTP predictor to run after 10:00pm.")
 N DAY,DONE,QQ,TIME,ZTIO,ZTSK,ZTRTN,ZTDESC,ZTSAVE,ZTDTH,Y
 S ZTIO="",ZTRTN="PREDICTOR^VPR1P36"
 ;schedule job after 10:00pm
 K SCH S QQ=$$NOW^XLFDT,DAY=$P(QQ,"."),TIME=$P(QQ,".",2)
 I TIME<"215900" S SCH=DAY_".2205"
 I TIME>"220000" S SCH=$$NOW^XLFDT
 S ZTDTH=SCH
 S ZTDESC="VPR*1*36 post-install of CTP predictor."
 D ^%ZTLOAD
 I '$G(ZTSK) D MES^XPDUTL("   **** Queuing CTP predictor failed!!!") Q
 D MES^XPDUTL("   Job number #"_ZTSK_" was queued.")
 Q
 ;
PREDICTOR ;-- capture CTP predictor as Post Init on patch install (optional)
 N VPRPRED
 D EN(,,"OBS","CNT",,.VPRPRED)
 ;
MSG ; add post message and send to VPR developers in Outlook
 N VPRN,LINE,VPRSITE
 S VPRSITE=$$SITE^VASITE
 I $D(@VPRPRED@("Tot")) S VPRN=@VPRPRED@("Tot")
 ;I 'VPRN Q
 S LINE=1
 S VPRMSG(LINE,0)="There's been a VPR*1*36 PREDICTOR run at site: "_+(VPRSITE)_"." S LINE=LINE+1
 S VPRMSG(LINE,0)=" ",LINE=LINE+1
 S VPRMSG(LINE,0)="Total 'Observation' results returned: "_$P(VPRN,U),LINE=LINE+1
 S VPRMSG(LINE,0)="               #updates: "_$P(VPRN,U,2),LINE=LINE+1
 S VPRMSG(LINE,0)="               #deletes: "_$P(VPRN,U,3),LINE=LINE+1
 D:$D(@VPRPRED@("Tot","OBS"))
 . S VPRMSG(LINE,0)="            #OBS Domain: "_@VPRPRED@("Tot","OBS")
 S VPRMSG(LINE,0)=" " S LINE=LINE+1
 N XMSUB,XMDUZ,XMY,XMTEXT,XMDUN
 S XMSUB="VPR*1*36 >> PREDICTOR TASK COMPLETED AT SITE: #"_+(VPRSITE)
 S XMDUZ=.5
 K XMY
 S XMY(DUZ)=""
 S XMY("liana.buciuman@domain.ext")=""
 S XMY("m.robert.yorty@domain.ext")=""
 S XMTEXT="VPRMSG(" D ^XMD
 Q
