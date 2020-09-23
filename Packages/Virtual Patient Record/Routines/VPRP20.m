VPRP20 ;SLC/MKB -- Patch 20 postinit ;3/4/20  12:07
 ;;1.0;VIRTUAL PATIENT RECORD;**20**;Sep 01, 2011;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
PSTINT ; -- post-init [add AVPR index to #230]
 N VPRX,VPRY
 S VPRX("FILE")=230
 S VPRX("NAME")="AVPR"
 S VPRX("TYPE")="MU"
 S VPRX("USE")="A"
 S VPRX("EXECUTION")="F"
 S VPRX("ACTIVITY")=""
 S VPRX("SHORT DESCR")="Trigger updates to VPR"
 S VPRX("DESCR",1)="This is an action index that updates the Virtual Patient Record (VPR)"
 S VPRX("DESCR",2)="when this record is closed. No actual cross-reference nodes are set"
 S VPRX("DESCR",3)="or killed."
 S VPRX("SET")="D:$L($T(EDP^VPRENC)) EDP^VPRENC(DA)"
 S VPRX("KILL")="Q"
 S VPRX("WHOLE KILL")="Q"
 S VPRX("VAL",1)=.07              ;Closed
 D CREIXN^DDMOD(.VPRX,"kW",.VPRY) ;VPRY=ien^name of index
 Q
 ;
 ; ------------------------------------------------------------------
 ; This code is called from the HealthShare CallToPopulate utility to
 ; populate extension properties created by VPR*1*20 (BMS/VHIE) in:
 ;    Encounters (Admissions & EDIS)
 ;    Appointments, including Scheduled Admissions
 ;    Documents
 ;    Lab Orders (CH only)
 ;    Procedures (Surgeries)
 ;    Vaccinations
 ;
EN(START,STOP,PAT) ; -- entry point to test CTP
 N VPRBDT,VPREDT,VPRPT,VPRFMT,VPRII,VPRY,VPRN
 S VPRBDT=$G(START,1410102)
 S VPREDT=$G(STOP,4141015) S:VPREDT?7N VPREDT=VPREDT_".24" ;end of day
 I $G(PAT),+PAT=PAT S VPRPT(+PAT)=""
 ;
 S VPRY=$NA(^XTMP("VPRP20")) K @VPRY
 S @VPRY@(0)=$$FMADD^XLFDT(DT,7)_U_DT_U_"Call To Populate SDA P20"
 S (VPRN,VPRN("D"),VPRN("U"))=0
 S VPRFMT="OPS",VPRII=0
 ;
 D CTP
 ;
 W !!," Total results returned: "_VPRN
 W !,"               #updates: "_$G(VPRN("U"))
 W !,"               #deletes: "_$G(VPRN("D"))
 S @VPRY@("Tot")=VPRN_U_VPRN("U")_U_VPRN("D")_U_VPRII
 Q
 ;
POST(TYPE,ID,ACT,VST,EXT) ; -- post an update to
 ; @VPRY@(SEQ) = ICN ^ TYPE ^ ID ^ U/D ^ VISIT# ^ DFN ^ EXTID
 ;
 S TYPE=$G(TYPE),ID=$G(ID) Q:TYPE=""  Q:ID=""
 S ACT=$S($G(ACT)="@":"D",1:"U")
 ; add/update list
 S VPRN(ACT)=+$G(VPRN(ACT))+1 I VPRFMT'="DFN" D
 . S VPRN=+$G(VPRN)+1,VPRII=+$G(VPRII)+1
 . S @VPRY@(VPRII)=$G(ICN)_U_$G(TYPE)_U_$G(ID)_U_$G(ACT)_U_$G(VST)_U_DFN_U_$G(EXT)
 I VPRFMT="DFN",'$G(VPRPT) D
 . S VPRN=+$G(VPRN)+1,VPRPT=DFN
 . S VPRII=+$G(VPRII)+1,@VPRY@(VPRII)=ICN_U_DFN_U_STN
 Q
 ;
CTP ; -- application loops [called from VPRZCTP on HealthShare]
 N STN,VPRPLIST,DFN,ICN
 S STN=$P($$SITE^VASITE,U,3)
 S VPRPLIST=$S($D(VPRPT):"VPRPT",1:$NA(^VPR(1,2)))
 S DFN=0 F  S DFN=$O(@VPRPLIST@(DFN)) Q:DFN<1  I $$VALID^VPRHS(DFN) D
 . S ICN=$$GETICN^MPIF001(DFN),VPRPT="" Q:ICN<0
 . D VSIT
 . D SDAM ;,DGS
 . D TIU,RAD,LRAP,LRMI
 . D ORD
 . D SRF
 . D IMM
 Q
 ;
VSIT ; -- Encounters via #9000010
 ; Admissions and EDIS only
 N BEG,END,IDT,ID,VAINDT,VADMVT,VAERR
 S BEG=VPRBDT,END=VPREDT D IDT^VPRDVSIT
 S IDT=BEG F  S IDT=$O(^AUPNVSIT("AA",DFN,IDT)) Q:IDT<1!(IDT>END)  D
 . S ID=0 F  S ID=$O(^AUPNVSIT("AA",DFN,IDT,ID)) Q:ID<1  D
 .. Q:$G(^XTMP("VPRPX",ID_"~"_DFN))  ;already queued
 .. I $P($G(^AUPNVSIT(ID,0)),U,7)="H" S VAINDT=+$P(^(0),U) D  Q
 ... K VADMVT D ADM^VADPT2 Q:$G(VADMVT)<1
 ... D POST("Encounter",VADMVT_"~"_ID_";405",,,ID)
 .. Q:'$O(^EDP(230,"V",ID,0))
 .. D POST("Encounter",ID_";9000010",,,ID)
 Q
 ;
SDAM ; -- Appointments via #2.98/44
 ; Re-send non-cancelled appts for new properties,
 ;    only send past appointments with an Outpt Encounter
 ; Remove cancelled appts since SD*5.3*722
 N VPRX,VPRNUM,VPRDT,X0,ACT
 S VPRX("FLDS")="1;3;12",VPRX("SORT")="P"
 S VPRX(1)=VPRBDT_";"_VPREDT,VPRX(4)=DFN
 S VPRNUM=$$SDAPI^SDAMA301(.VPRX),VPRDT=0
 F  S VPRDT=$O(^TMP($J,"SDAMA301",DFN,VPRDT)) Q:VPRDT<1  D
 . S X0=$G(^TMP($J,"SDAMA301",DFN,VPRDT)),ACT=""
 . ; remove cancels after SD*722
 . I $P(X0,U,3)["CANCEL" Q:VPRDT<3191106  S ACT="@"
 . E  Q:'$P(X0,U,12)&(VPRDT<DT)  ;past appt needs OE
 . D POST("Appointment",(VPRDT_","_DFN_";2.98"),ACT)
 K ^TMP($J,"SDAMA301",DFN)
 Q
 ;
DGS ; check Sch Admissions #41.1
 N VPRDA,X0,DATE,ACT
 S VPRDA=0 F  S VPRDA=$O(^DGS(41.1,"B",DFN,VPRDA)) Q:VPRDA<1  D
 . S X0=$G(^DGS(41.1,VPRDA,0)),DATE=$P(X0,U,2)
 . Q:DATE<VPRBDT  Q:DATE>VPREDT
 . S ACT=$S($P(X0,U,13):"@",1:"") ;cancelled
 . I ACT="@",DATE<3200401 Q       ;never sent
 . D POST("Appointment",VPRDA_";41.1",ACT)
 Q
 ;
TIU ; -- Documents via #8925
 N VPRD,VPRDA,VST
 D LIST^TIUVPR(.VPRD,DFN,38,VPRBDT,VPREDT)
 S VPRDA=0 F  S VPRDA=+$O(@VPRD@(VPRDA)) Q:VPRDA<1  D
 . Q:$G(^XTMP("VPRPX","DOC",VPRDA))  ;queued
 . S VST=$$GET1^DIQ(8925,VPRDA,.03,"I")
 . D POST("Document",VPRDA_";8925",,VST,VPRDA_";TIU")
 K @VPRD
 Q
RAD ; -- Documents via #74
 N VPRXID,STS,RARPT
 K ^TMP($J,"RAE1") D EN1^RAO7PC1(DFN,VPRBDT,VPREDT,"99P")
 S VPRXID="" F  S VPRXID=$O(^TMP($J,"RAE1",DFN,VPRXID)) Q:VPRXID=""  D
 . S STS=$P($G(^TMP($J,"RAE1",DFN,VPRXID)),U,3),RARPT=+$P($G(^(VPRXID)),U,5)
 . Q:STS="No Report"!(STS="Deleted")!(STS["Draft")!(STS["Released/Not")
 . Q:RARPT<1  Q:$D(RARPT(RARPT))  ;already have report, for sets
 . D POST("Document",RARPT_";74",,,RARPT_";RA")
 . S RARPT(+RARPT)=""
 K ^TMP($J,"RAE1")
 Q
LRAP ; -- Documents via #63.0*
 N SUB,IDT,LRDFN
 D RR^LR7OR1(DFN,,VPRBDT,VPREDT,"AP")
 S LRDFN=+$G(^DPT(DFN,"LR")) Q:LRDFN<1
 S SUB="" F  S SUB=$O(^TMP("LRRR",$J,DFN,SUB)) Q:SUB=""  D
 . S IDT=0 F  S IDT=$O(^TMP("LRRR",$J,DFN,SUB,IDT)) Q:IDT<1  I $O(^(IDT,0)) D
 .. Q:$O(^LR(LRDFN,SUB,IDT,.05,0))        ;report in TIU
 .. Q:'$P($G(^LR(LRDFN,SUB,IDT,0)),U,11)  ;not final results
 .. D POST("Document",(IDT_","_LRDFN_"~"_SUB_";63.08"),,,IDT_";"_SUB)
 K ^TMP("LRRR",$J,DFN)
 Q
LRMI ; -- Documents via #63.05
 N IDT,LRDFN
 D RR^LR7OR1(DFN,,VPRBDT,VPREDT,"MI")
 S LRDFN=+$G(^DPT(DFN,"LR")) Q:LRDFN<1
 S IDT=0 F  S IDT=$O(^TMP("LRRR",$J,DFN,"MI",IDT)) Q:IDT<1  I $O(^(IDT,0)) D
 . Q:'$P($G(^LR(LRDFN,"MI",IDT,0)),U,3)  ;not final results
 . D POST("Document",(IDT_","_LRDFN_"~MI;63.05"),,,IDT_";MI")
 K ^TMP("LRRR",$J,DFN)
 Q
 ;
ORD ; -- Lab Orders via #100
 N IDX,VPRDT,VPRDA,ORIFN,X0,X3,X4,PKG,ORDAD
 S IDX=$NA(^PXRMINDX(100,"PI",DFN))
 F  S IDX=$Q(@IDX) Q:$QS(IDX,3)'=DFN  D
 . S VPRDT=$QS(IDX,5) Q:VPRDT<VPRBDT  Q:VPRDT>VPREDT
 . S VPRDA=$QS(IDX,7) Q:$P(VPRDA,";",3)>1  ;multiple OI's
 . S ORIFN=+VPRDA,X0=$G(^OR(100,ORIFN,0)),X3=$G(^(3)),X4=$G(^(4))
 . S PKG=$P(X0,U,14) Q:$$NMSP(PKG)'="LR"
 . I $O(^OR(100,ORIFN,2,0)) D  Q  ;parent, pre-17 OpsMode
 .. S:(3190401<VPRDT)&(VPRDT<3191104) ORDAD(ORIFN)=""
 . Q:$P(X3,U,3)=13  ;cancelled
 . Q:$P(X3,U,3)=14  ;lapsed
 . Q:X4'["CH"       ;no results, or not CH
 . D POST("LabOrder",ORIFN_";100",,,ORIFN)
 ; delete any parent orders that got posted after Ops Mode
 S ORIFN=0 F  S ORIFN=$O(ORDAD(ORIFN)) Q:ORIFN<1  D POST("LabOrder",ORIFN_";100","@",,ORIFN)
 Q
 ;
NMSP(X) ; -- return pkg namespace (if non-PS order in group)
 N Y S Y=$P($G(^DIC(9.4,+X,0)),U,2)
 Q $E(Y,1,2)
 ;
SRF ; -- Procedures via #130
 N VPRS,VPRI,I,X,ID
 D LIST^SROESTV(.VPRS,DFN,VPRBDT,VPREDT,,1)
 S VPRI=0 F  S VPRI=$O(@VPRS@(VPRI)) Q:VPRI<1  I $G(@VPRS@(VPRI)) D
 . S I=+$O(@VPRS@(VPRI,0)) Q:I<1
 . S X=$G(@VPRS@(VPRI,I)) ;TIU ien ^ $$RESOLVE^TIUSRVLO data string
 . I $P(X,U,7)'="completed",$P(X,U,7)'="amended" Q
 . I $P(X,U,2)["Addendum to " Q
 . S VST=+$$GET1^DIQ(8925,+X,.03,"I") Q:VST<1
 . S ID=+$G(@VPRS@(VPRI)) Q:'$O(^SRO(136,ID,3,0))
 . D POST("Procedure",ID_";130",,VST,ID_";SR")
 K @VPRS
 Q
 ;
IMM ; -- Vaccinations via #9000010.11
 N VPRSTART,VPRSTOP,FNUM,VPRIDT,ID,VST
 S VPRSTART=VPRBDT,VPRSTOP=VPREDT,FNUM=9000010.11
 D SORT^VPRDJ09 ;sort ^PXRMINDX into ^TMP("VPRPX",$J,IDT)
 S VPRIDT=0 F  S VPRIDT=$O(^TMP("VPRPX",$J,VPRIDT)) Q:VPRIDT<1  D
 . S ID=0 F  S ID=$O(^TMP("VPRPX",$J,VPRIDT,ID)) Q:ID<1  D
 .. S VST=$$GET1^DIQ(9000010.11,ID,.03,"I")
 .. D POST("Vaccination",ID_";9000010.11",,VST,ID)
 K ^TMP("VPRPX",$J)
 Q
