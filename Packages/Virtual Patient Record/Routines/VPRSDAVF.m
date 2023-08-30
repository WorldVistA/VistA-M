VPRSDAVF ;SLC/MKB -- SDA Vfile utilities ;7/29/22  14:11
 ;;1.0;VIRTUAL PATIENT RECORD;**30**;Sep 01, 2011;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNVSIT                     2028
 ; ^AUTTHF                       4295
 ; ^DIC(9.4                     10048
 ; ^EDP(230                      7180
 ; ^PXRMINDX                     4290
 ; DILFD                         2055
 ; DIQ                           2056
 ; PXPXRM                        4250
 ;
 ;
 ; Queries called from GET^DDE, returns DLIST(#)=ien
 ; Expects context variables DFN, DSTRT, DSTOP, DMAX
 ;
EXAMS ; -- V Exams (Physical Exams)
 N FNUM S FNUM=9000010.13 G PXRM
 ;
HFACTORS ; -- V Health Factors (Health Concerns)
 N FNUM S FNUM=9000010.23 G PXRM
 ;
CPT ; -- V CPT (Procedures)
 N FNUM S FNUM=9000010.18 G PXRM
 ;
POV ; -- V POV (Diagnosis)
 N FNUM S FNUM=9000010.07 G PXRM
 ;
IMMS ; -- V Immunizations
 N FNUM S FNUM=9000010.11 G PXRM
 ;
PXRM ; -- Search PXRM index
 N VPRSTART,VPRSTOP,VPRIDT,VPRN,ID
 S VPRSTART=DSTRT,VPRSTOP=DSTOP,VPRN=0
 D SORT^VPRDJ09 ;sort ^PXRMINDX into ^TMP("VPRPX",$J,IDT)
 S VPRIDT=0 F  S VPRIDT=$O(^TMP("VPRPX",$J,VPRIDT)) Q:VPRIDT<1  D  Q:VPRN'<DMAX
 . S ID=0 F  S ID=$O(^TMP("VPRPX",$J,VPRIDT,ID)) Q:ID<1  D  Q:VPRN'<DMAX
 .. I FNUM=9000010.18,'$$VCPT(ID) Q
 .. S VPRN=VPRN+1,DLIST(VPRN)=ID
 K ^TMP("VPRPX",$J)
 Q
 ;
ICR ; -- V Imm Contraindications/Refusals [query]
 N ROOT,INDX,DATE,IDT,DA,TMP,VPRN S VPRN=0
 ; find records in ^PXRMINDX, sort by date
 S ROOT="^PXRMINDX(9000010.707,""PCI"","_DFN,INDX=ROOT_")",ROOT=ROOT_","
 F  S INDX=$Q(@INDX) Q:INDX'[ROOT  D
 . S DATE=$QS(INDX,6) Q:DATE<DSTRT  Q:DATE>DSTOP
 . S DA=$QS(INDX,8),IDT=9999999-DATE,TMP(IDT,DA)=""
 ; return [DMAX] entries
 S IDT=0 F  S IDT=$O(TMP(IDT)) Q:IDT<1  D  Q:VPRN'<DMAX
 . S DA=0 F  S DA=$O(TMP(IDT,DA)) Q:DA<1  S VPRN=VPRN+1,DLIST(VPRN)=DA
 Q
 ;
HFCVR ; -- V Health Factors, for COVID Vaccination Refusal [query]
 N ITEM,NAME,DATE,DA,X,VPRN S VPRN=0
 S ITEM=+$O(^AUTTHF("B","VA-SARS-COV-2 VACCINE REFUSAL",0)) Q:ITEM<1  D CVR
 S NAME="VA-SARS-COV-2 IMM REFUSAL"
 F  S NAME=$O(^AUTTHF("B",NAME)) Q:NAME'?1"VA-SARS-COV-2 IMM REFUSAL".E  S ITEM=+$O(^(NAME,0)) D CVR
 Q
CVR ;loop for ITEM
 S DATE=DSTRT F  S DATE=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),ITEM,DATE)) Q:DATE<1!(DATE>DSTOP)  D  Q:VPRN'<DMAX
 . S DA=0 F  S DA=$O(^PXRMINDX(9000010.23,"PI",+$G(DFN),ITEM,DATE,DA)) Q:DA<1  S VPRN=VPRN+1,DLIST(VPRN)=DA Q:VPRN'<DMAX
 Q
 ;
 ;
XAM1 ; -- get info for single XAM record [ID Action]
 ; Expects/updates DIEN = #9000010.13 ien
 ;       Returns VPRVST = #9000010 ien
 ;              VPRVST0 = Visit zero node
 ;                VPRXM array
 K VPRXM D:$$ZERO^VPRENC("XAM",+DIEN) VXAM^PXPXRM(+DIEN,.VPRXM)
 S VPRVST=$G(VPRXM("VISIT")),VPRVST0=$G(^AUPNVSIT(+VPRVST,0))
 S VPRXM=DIEN,DIEN=+DIEN
 Q
 ;
HF1 ; -- get info for single HF record [ID Action]
 ; Expects/updates DIEN = #9000010.23 ien
 ;       Returns VPRVST = #9000010 ien
 ;              VPRVST0 = Visit zero node
 ;                VPRHF array
 K VPRHF D:$$ZERO^VPRENC("HF",+DIEN) VHF^PXPXRM(+DIEN,.VPRHF)
 S VPRVST=+$G(VPRHF("VISIT")),VPRVST0=$G(^AUPNVSIT(+VPRVST,0))
 S VPRHF=DIEN,DIEN=+DIEN
 Q
 ;
POV1 ; -- get info for single POV record [ID Action]
 ; Expects/updates DIEN = #9000010.07 ien
 ;       Returns VPRVST = #9000010 ien
 ;              VPRVST0 = Visit zero node
 ;               VPREDP = #230 ien or 0
 ;               VPRPOV array
 K VPRPOV D:$$ZERO^VPRENC("POV",+DIEN) VPOV^PXPXRM(+DIEN,.VPRPOV)
 S VPRVST=+$G(VPRPOV("VISIT")),VPRVST0=$G(^AUPNVSIT(VPRVST,0))
 S VPREDP=+$O(^EDP(230,"V",VPRVST,0)) ;#230 ien if EDP, or 0
 S VPRPOV=DIEN,DIEN=+DIEN
 Q
 ;
POVNARR() ; -- build Original Text for POV
 N NARR,MOD,Y S Y=""
 S NARR=$G(VPRPOV("PROVIDER NARRATIVE")),MOD=$G(VPRPOV("MODIFIER"))
 S:NARR Y=$$GET1^DIQ(9999999.27,NARR_",",.01)
 I $L(MOD),$L(Y) S Y=$$EXTERNAL^DILFD(9000010.07,.06,,MOD)_" "_Y
 Q Y
 ;
CPT1 ; -- get info for single V CPT record [ID Action]
 ; Expects/updates DIEN = #9000010.18 ien
 ;       Returns VPRVST = #9000010 ien
 ;              VPRVST0 = Visit zero node
 ;               VPRCPT array
 K VPRCPT D:$$ZERO^VPRENC("CPT",+DIEN) VCPT^PXPXRM(+DIEN,.VPRCPT)
 S VPRVST=+$G(VPRCPT("VISIT")),VPRVST0=$G(^AUPNVSIT(VPRVST,0))
 S VPRCPT=DIEN,DIEN=+DIEN
 Q
 ;
VCPT(DA) ; -- ok to include V-CPT record in SDA?
 N X0,CODE,PKG,VST S DA=+$G(DA)
 ; skip eval/mgt codes
 S X0=$$ZERO^VPRENC("CPT",DA),CODE=$P(X0,U) I CODE>99200,CODE<99500 Q 0
 ; skip Surgery (duplicates of #130)
 S PKG=$$GET1^DIQ(9000010.18,DA,81202,"I")
 I PKG,$P($G(^DIC(9.4,PKG,0)),U,2)="SR" Q 0
 ; skip V IMMUNIZATIONS codes
 S VST=+$P(X0,U,3)
 I $$DUP(VST,CODE,"IMM") Q 0
 ; else ok
 Q 1
 ;
DUP(VST,CPT,SUB) ; -- find V CPT match in VSUB file (IMM or SK)
 N VFL,GBL,IEN,ITM,SYS,Y
 I '$G(VST)!($G(CPT)="")!($G(SUB)="") Q 0
 S VFL="^AUPNV"_SUB,GBL="^AUTT"_SUB,Y=0
 S IEN=0 F  S IEN=$O(@VFL@("AD",+VST,IEN)) Q:IEN<1  D  Q:Y
 . S ITM=+$G(@VFL@(IEN,0)),SYS=+$O(@GBL@(ITM,3,"B","CPT",0))
 . I SYS,+$O(@GBL@(ITM,3,SYS,1,"B",CPT,0)) S Y=IEN
 Q Y
