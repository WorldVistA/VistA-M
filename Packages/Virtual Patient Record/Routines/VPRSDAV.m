VPRSDAV ;SLC/MKB -- SDA Visit utilities ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**20,26,27,28,29**;Sep 01, 2011;Build 11
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNVSIT                     2028
 ; ^DDE                          7014
 ; ^DGPM                         1865
 ; ^DIC(42                      10039
 ; ^DIC(9.4                     10048
 ; ^DPT                         10035
 ; ^EDP(230                      7180
 ; ^SC                          10040
 ; ^SCE("AVSIT"                  2045
 ; ^SRF                          5675
 ; DGPTFAPI                      3157
 ; DGPTPXRM                      4457
 ; DIC                           2051
 ; DILFD                         2055
 ; DIQ                           2056
 ; ICDEX                         5747
 ; PXAPI, ^TMP("PXKENC",$J       1894
 ; PXPXRM                        4250
 ; SDAMA301, ^TMP($J             4433
 ; SDOE                          2546
 ; VADPT                        10061
 ; VADPT2                         325
 ;
QRY ; -- Query for all visit types
 ; Expects DSTRT,DSTOP,DMAX [from DDEGET]
 N BEG,END,IDT,TYPE,OK,VPRN,ID
 S BEG=DSTRT,END=DSTOP D IDT^VPRDVSIT
 S VPRN=0,IDT=BEG,TYPE=$G(FILTER("type")) ;I,O,E
 F  S IDT=$O(^AUPNVSIT("AA",DFN,IDT)) Q:IDT<1!(IDT>END)  D  Q:VPRN'<DMAX
 . S ID=0 F  S ID=$O(^AUPNVSIT("AA",DFN,IDT,ID)) Q:ID<1  D
 .. Q:"CS"[$P($G(^AUPNVSIT(ID,150)),U,3)  ;skip stop code child visits
 .. I TYPE'="" D  Q:'OK  ;filter
 ... N X S OK=0
 ... S X=$S($O(^EDP(230,"V",ID,0)):"E",$P($G(^AUPNVSIT(ID,0)),U,7)="H":"I",1:"O")
 ... I TYPE[X S OK=1 Q
 .. S VPRN=VPRN+1,DLIST(VPRN)=ID
 Q
 ;
VST ; -- get info for a VISIT in @VPRVST [ID Action]
 S DIEN=+$G(DIEN) I DIEN<1 S DDEOUT=1 Q
 N VADMVT,PX0A,EDP S PX0A=$G(^AUPNVSIT(DIEN,0))
 I PX0A="" D STUB(DIEN) Q
 ; ck DFN (in case re-added at diff Enc#)
 I $G(DFN),DFN'=$P(PX0A,U,5) D STUB(DIEN) Q
 S:'$G(DFN) DFN=+$P(PX0A,U,5)
 ; switch to Admission entity?
 I $P(PX0A,U,7)="H" D  Q:$G(VADMVT)
 . N VAINDT,ENT S VAINDT=+PX0A D ADM^VADPT2 Q:'$G(VADMVT)
 . S ENT=+$O(^DDE("B","VPR ADMISSION",0)) I ENT<1 K VADMVT Q
 . S DIENTY=ENT,DIFN=405,DIEN=VADMVT_"~"_DIEN
 . D VAIP
 ; switch to EDP Log entity?
 S EDP=+$O(^EDP(230,"V",DIEN,0)) I EDP D  Q:$G(EDP)
 . N ENT S EDP=+$O(^EDP(230,"V",DIEN,0))
 . S ENT=+$O(^DDE("B","VPR EDP LOG",0)) I ENT<1 K EDP Q
 . S DIENTY=ENT,DIFN=230,DIEN=EDP
 . D EDP1
 ; continue with Visit
 D ENCEVENT^PXAPI(DIEN)
 S VPRVST=$NA(^TMP("PXKENC",$J,DIEN,"VST",DIEN))
 ; validate Visit, Check-Out D/T
 N D S D=$P(+$G(@VPRVST@(0)),".")
 I D,'$$VALID^VPRSDA(D) S $P(@VPRVST@(0),U)=$P(@VPRVST@(0),U,2) ;created
 S D=$P($G(@VPRVST@(0)),U,18)
 I D,'$$VALID^VPRSDA(D) S $P(@VPRVST@(0),U,18)=""
 Q
 ;
LAST(DFN) ; -- return date.time of last visit (last treated)
 N IDT,X,Y S Y=""
 I '$G(DFN) Q ""
 S IDT=(9999999-DT-.000001),X=$O(^AUPNVSIT("AA",DFN,IDT))
 S:X Y=(9999999-$P(X,"."))_$S($L(X,".")>1:"."_$P(X,".",2),1:"")
 Q Y
 ;
STUB(VST) ; -- switch to stub entity for deleted visits
 N ENT S ENT=+$O(^DDE("B","VPR VISIT STUB",0))
 I ENT<1 S DDEOUT=1 Q
 S DIENTY=ENT,DIEN=+$G(VST)
 Q
 ;
VDEL ; -- old V file Entry Action: I ID["~" D VDEL^VPRSDAV
 ; Expects ID & FILE
 ; Returns VPRVST, VPRVFN, VPRVT & resets DTYPE for entity
 S VPRVST=+$P($G(ID),"~",2),ID=+$G(ID),VPRVFN=+$G(FILE),VPRVT=DTYPE
 S DTYPE=$O(^DDE("B","VPR VFILE DELETE",0))
 Q
 ;
DEL1 ; -- ID Action for Vfile Delete entities, returns VPR0=data
 N SEQ,VST S VPR0=""
 S SEQ=+$G(FILTER("sequence")) I SEQ D
 . S VPR0=$G(^XTMP("VPR-"_SEQ,+$G(DIEN),0)) Q:$L(VPR0)
 . S VST=$P($G(^XTMP("VPR-"_SEQ,+$G(DIEN))),U,5) S:VST VPR0="^^"_VST
 Q
 ;
VAIP ; -- get admission info & Visit# [ID Action]
 ; Expects  DIEN = #405 ien ~ #9000010 ien
 ; Validates DFN = #2 ien
 ; Return VAIP(#)= array of movements
 ;        VPRVST = Visit#
 ;         VPRCA = Current Adm# (or 0)
 ;          DIEN = Movement#
 N VAERR,VADMVT K VAIP,VAINDT
 S DIEN=$G(DIEN),DFN=+$G(DFN)
 S VPRVST=+$P(DIEN,"~",2),DIEN=+DIEN
 S:'DFN DFN=+$P($G(^DGPM(DIEN,0)),U,3)
 I 'DFN!'DIEN S DDEOUT=1 Q
 S VPRCA=+$G(^DPT(DFN,.105)) S:DIEN'=VPRCA VAIP("E")=DIEN
 D IN5^VADPT
 I $G(VAIP(13)),+VAIP(13)'=DIEN S DIEN=+VAIP(13),VPRVST=0
 S:'VPRVST VPRVST=$$VNUM(DIEN)
 I VPRVST<1 S DDEOUT=1 Q
 Q
 ;
MVTS(ADM) ; -- get movements for an ADMission in DLIST(#)=mvt ien
 ; Expects DFN
 N MVTS,IDX,DA,X0,PHYMVT,DATE,N,TS
 S ADM=+$G(ADM) Q:ADM<1
 S IDX=$NA(^DGPM("APCA",DFN,ADM)) ;get all physical mvts
 F  S IDX=$Q(@IDX) Q:$QS(IDX,3)'=ADM  D
 . S DA=$QS(IDX,5),DATE=+$G(^DGPM(DA,0))
 . I DATE,DA S MVTS(DATE,DA)=""
 S IDX=$NA(^DGPM("ATS",DFN,ADM))  ;add TS mvts to list
 F  S IDX=$Q(@IDX) Q:$QS(IDX,3)'=ADM  S DA=$QS(IDX,6) D
 . S X0=$G(^DGPM(DA,0)),PHYMVT=+$P(X0,U,24)
 . I PHYMVT,$D(MVTS(+X0,PHYMVT)) S MVTS(+X0,PHYMVT)=DA Q
 . S MVTS(+X0,DA)=DA
 ; create return DLIST from MVTS
 S (DATE,N)=0 F  S DATE=$O(MVTS(DATE)) Q:DATE<1  D
 . S DA=0 F  S DA=$O(MVTS(DATE,DA)) Q:DA<1  D
 .. S TS=$G(MVTS(DATE,DA))
 .. S N=N+1,DLIST(N)=DA_$S(TS:";"_TS,1:"")
 Q
 ;
VNUM(ADM) ; -- find Visit# for an admission [expects DFN]
 N Y,ADM0,ADMDT,HLOC,VIEN
 S ADM0=$G(^DGPM(+$G(ADM),0)),ADMDT=+ADM0
 S HLOC=+$G(^DIC(42,+$P(ADM0,U,6),44)),(Y,VIEN)=""
 F  S VIEN=$O(^AUPNVSIT("AET",DFN,ADMDT,HLOC,"P",VIEN)) Q:'VIEN  D  Q:Y
 . I $P(^AUPNVSIT(VIEN,0),U,7)="H" S Y=VIEN
 I 'Y D  ;try w/o location
 . N IDT S IDT=(9999999-$P(ADMDT,"."))_"."_$P(ADMDT,".",2)
 . S Y=$O(^AUPNVSIT("AAH",DFN,IDT,0))
 Q Y
 ;
WARDFAC(IEN) ; -- return #4 ien for a Ward Location
 N HLOC,Y
 S HLOC=+$G(^DIC(42,+$G(IEN),44)),Y=""
 S:HLOC Y=$P($G(^SC(HLOC,0)),U,4)
 Q Y
 ;
SPEC ; -- build DLIST(#)=45.7 iens using VAIP array
 N I,X,SPEC
 F I=13:1:17 S X=$G(VAIP(I,6)) S:X SPEC(+X)=""
 S (I,X)=0 F  S X=$O(SPEC(X)) Q:X<1  S I=I+1,DLIST(I)=X
 Q
 ;
VSTR() ; -- build Visit string of Type;date.time[;location]
 N Y S Y=""
 I $G(VAIP(13)) S Y="H;"_+VAIP(13)
 E  S X=$G(@VPRVST@(0)),Y=$P(X,U,7)_";"_+X_";"_$P(X,U,22)
 Q Y
 ;
CPT(VISIT) ; -- Return CPT code of encounter type
 N DA,Y,X,X0 S Y=""
 S DA=0 F  S DA=$O(^TMP("PXKENC",$J,VISIT,"CPT",DA)) Q:DA<1  S X0=$G(^(DA,0)) D  Q:$L(Y)
 . S X=$P(X0,U) I X?1"992"2N S Y=X Q
 Q Y
 ;
VPRV(VISIT) ; -- build DLIST(n)=#200 ien for V Providers
 N I,X,R S I=0
 F  S I=$O(^TMP("PXKENC",$J,VISIT,"PRV",I)) Q:I<1  S X=$G(^(I,0)) D
 . S R=$P(X,U,4)
 . S DLIST(I)=+X_U_$S(R="P":"PRIMARY",R="S":"SECONDARY",1:"")
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
 ;
VTO(VISIT) ; -- determine ToTime for a visit based on type
 N TYPE,INPT,Y S Y="",VISIT=+$G(VISIT)
 S TYPE=$P($G(@VPRVST@(0)),U,7),INPT=$P($G(@VPRVST@(150)),U,2)
 ; should not have any inpatient episodes here, handled via DGPM
 I "H^R"[TYPE,INPT Q Y
 ; look for an appointment check-out time
 I "A^I^O"[TYPE S Y=$$CKOUT(VISIT) I Y Q Y
 ; check Surgery for Time Out of OR
 I TYPE="S" D  I Y Q Y
 . N I S I=$O(^SRF("AV",VISIT,0))
 . S:I Y=$$GET1^DIQ(130,I_",",.232,"I")
 ; otherwise use the Visit Time
 I "H^R^A^I^O^S"'[TYPE!(+$G(@VPRVST@(0))<DT) S Y=+$G(@VPRVST@(0))
 Q Y
 ;
CKOUT(VISIT) ; -- get Check-out date from Outpt Enc or EDP Log file
 N X,Y,IEN S VISIT=+$G(VISIT)
 I $G(VPREDP) S Y=$$GET1^DIQ(230,VPREDP,.09,"I") Q Y
 S IEN=$O(^SCE("AVSIT",VISIT,0)),(X,Y)=""
 S:IEN X=$$GETOE^SDOE(IEN),Y=$P(X,U,7)
 Q Y
 ;
EDP1 ; -- get info for single EDP Log record [VST/ID Action]
 ;    Returns EDP0, EDP1, EDP3, VPRV, VPRVST to Entity
 S EDP0=$G(^EDP(230,DIEN,0)),EDP1=$G(^(1)),EDP3=$G(^(3))
 S VPRV=+$P(EDP0,U,12) I 'VPRV S DDEOUT=1 Q
 D ENCEVENT^PXAPI(VPRV)
 S VPRVST=$NA(^TMP("PXKENC",$J,VPRV,"VST",VPRV))
 Q
 ;
PTF1 ; -- get info for single PTF record [ID Action]
 ; Expects DIEN = #45 ien, returns VPRPTF array
 N VST,VPTF,X,Y K VPRPTF
 S VST="",DIEN=+$G(DIEN) D  I VST<1 S DDEOUT=1 Q
 . N ADM S ADM=$$FIND1^DIC(405,,"Q",DIEN,"APTF"),VST=+$$VNUM(ADM)
 . I 'VST!'$D(^AUPNVSIT(VST,0)) S VST=""
 S VPRPTF("VISIT")=VST
 D RPC^DGPTFAPI(.VPTF,DIEN) Q:VPTF(0)<1
 S X=$P($G(VPTF(1)),U,3),Y=$$CODEBA^ICDEX(X,80) I Y<1 S DDEOUT=1 Q
 S VPRPTF("DXLS")=Y_U_X ;ien^code
 D PTF^DGPTPXRM(DIEN,.VPRPTF)
 Q
 ;
APPT1(VPRID) ; -- get ^TMP node for single appt, returns VPRAPPT
 N DFN,VPRDT S VPRID=$G(VPRID)
 S DFN=$P(VPRID,",",2),VPRDT=$P(VPRID,",")
 I 'DFN!'VPRDT S DDEOUT=1 Q
 I '$D(^TMP($J,"SDAMA301",DFN)) D
 . N VPRX,VPRNUM
 . S VPRX(1)=VPRDT_";"_VPRDT,VPRX(4)=DFN
 . S VPRX("FLDS")="1;2;3;5;8;9;10;11;12;18;22",VPRX("SORT")="P"
 . S VPRNUM=$$SDAPI^SDAMA301(.VPRX)
 S VPRAPPT=$G(^TMP($J,"SDAMA301",DFN,VPRDT))
 S:VPRAPPT="" VPRAPPT=VPRDT_U_$P($G(^DPT(DFN,"S",VPRDT,0)),U,1,2) ;DDEOUT=1
 Q
 ;
APPTPRV() ; -- return the default/primary provider for VPRAPPT
 N Y,I,SDOE,LOC,VPROV S Y=""
 S SDOE=$P($G(VPRAPPT),U,12) I SDOE D
 . D GETPRV^SDOE(SDOE,"VPROV") S I=0
 . F  S I=$O(VPROV(I)) Q:I<1  I $P($G(VPROV(I)),U,4)="P" S Y=+VPROV(I) Q
 . I 'Y S I=$O(VPROV(0)) S:I Y=+VPROV(I) ;first, if no Primary
 I 'SDOE,+$G(VPRAPPT)>DT D  ;future
 . S LOC=+$P($G(VPRAPPT),U,2),Y=$$GET1^DIQ(44,LOC,16,"I") Q:Y
 . ;S I=+$O(^SC("ADPR",LOC,0)) I I S Y=+$G(^SC(LOC,"PR",I,0))
 . D GETS^DIQ(44,LOC,"2600*","I","VPROV")
 . S I="" F  S I=$O(VPROV(44.1,I)) Q:I=""  I $G(VPROV(44.1,I,.02,"I"))=1 S Y=$G(VPROV(44.1,I,.01,"I"))
 Q Y
