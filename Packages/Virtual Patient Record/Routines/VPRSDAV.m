VPRSDAV ;SLC/MKB -- SDA Visit utilities ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**20**;Sep 01, 2011;Build 9
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^AUPNVSIT                     2028
 ; ^DDE                          7014
 ; ^DGPM                         1865
 ; ^DIC(42                      10039
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
 ; SDAMA301, ^TMP($J             4433
 ; SDOE                          2546
 ; VADPT                        10061
 ; VADPT2                         325
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
STUB(VST) ; -- switch to stub entity for deleted visits
 N ENT S ENT=+$O(^DDE("B","VPR VISIT STUB",0))
 I ENT<1 S DDEOUT=1 Q
 S DIENTY=ENT,DIEN=+$G(VST)
 Q
 ;
VDEL ; -- V file Entry Action: I ID["~" D VDEL^VPRSDAV
 S VPRVST=+$P($G(ID),"~",2),ID=+$G(ID),VPRVFN=+$G(FILE),VPRVT=DTYPE
 S DTYPE=$O(^DDE("B","VPR VFILE DELETE",0))
 Q
 ;
VAIP ; -- get admission info & Visit# [ID Action]
 ; Expects  DIEN = #405 ien ~ #9000010 ien
 ; Validates DFN = #2 ien
 ; Return VAIP(#)= array of movements
 ;        VPRVST = Visit#
 ;         VPRCA = Current Adm# (or 0)
 ;          DIEN = Movement#
 N VAERR,VADMVT K VAIP
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
MVTS(ADM) ; -- get all movements for an ADMission in DLIST(#)=mvt ien
 ; Expects DFN
 N DATE,DA,N
 S (DATE,N)=0 F  S DATE=$O(^DGPM("APCA",DFN,ADM,DATE)) Q:DATE<1  D
 . S DA=0 F  S DA=$O(^DGPM("APCA",DFN,ADM,DATE,DA)) Q:DA<1  S N=N+1,DLIST(N)=DA
 Q
 ;
VNUM(ADM) ; -- find Visit# for an admission
 N VAINDT,X,Y
 S X=+$G(^DGPM(+$G(ADM),0)),VAINDT=(9999999-$P(X,"."))_"."_$P(X,".",2)
 S Y=$O(^AUPNVSIT("AAH",DFN,VAINDT,0))
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
 . S VPRX("FLDS")="1;2;3;10;11;12",VPRX("SORT")="P"
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
