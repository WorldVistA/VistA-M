ORWDXC ; SLC/KCM - Utilities for Order Checking ;Apr 12, 2022@12:09:48
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,141,221,243,280,346,345,311,395,269,469,377,539,405**;Dec 17, 1997;Build 211
 ;
ON(VAL) ; returns E if order checking enabled, otherwise D
 S VAL=$$GET^XPAR("DIV^SYS^PKG","ORK SYSTEM ENABLE/DISABLE")
 Q
FILLID(VAL,DLG) ; Return the FillerID (namespace) for a dialog
 N DGRP
 S VAL="",DGRP=$P($G(^ORD(101.41,DLG,0)),U,5) Q:'DGRP
 S DLG=$$DEFDLG^ORWDXQ(DGRP)
 S VAL=$P($G(^ORD(101.41,DLG,0)),U,7),VAL=$$NMSP^ORCD(VAL)
 I VAL="PS" D
 . N X
 . S X=$P($P($G(^ORD(100.98,DGRP,0)),U,3)," ")
 . I $L(X) S VAL="PS"_$S(X="UD":"I",1:X)
 Q
DISPLAY(LST,DFN,FID) ; Return list of Order Checks for a FillerID (namespace)
 N I,ORX,ORY
 S ORX=1,ORX(1)="|"_FID
 D EN^ORKCHK(.ORY,DFN,.ORX,"DISPLAY")
 S I=0 F  S I=$O(ORY(I)) Q:I'>0  S LST(I)=$P(ORY(I),U,4)
 Q
ALLERGY(LST,DFN,FID,OIL,ORDRNUM) ; Return list of allergy Order Checks on select medication
 ; DFN = Patient IEN
 ; FID = PSI   (Inpatient)
 ;       PSO   (Outpatient)
 ;       PSH   (Non-VA)
 ; OIL = Orderable Item #
 ; ORDRNUM = Order # (file 100)
 I +ORDRNUM,+OIL Q  ;Only OIL or ORDRNUM is allowed, not both
 S FID=$S(FID="PSH":FID,FID="PSX":"PSH",FID="PSO":FID,FID="PSIV":"PSIV",1:"PSI")
 K ^TMP($J,"OROCOUTO;"),^TMP($J,"OROCOUTI;"),^TMP($J,"ORDSGCHK_CACHE")
 K ^TMP($J,"ORENHCHK")
 N X,Y,USID,ORCHECK,ORI,ORX,ORY,%DT,ORDODSG,CNT,ORL,RSLT,OILORD,ORALLCHKNM
 S ORALLCHKNM="ORALLERGYCHK"
 S OILORD=$S(+OIL:+OIL,1:+ORDRNUM)
 K ORX,ORY
 I OILORD>0 K ^TMP(ORALLCHKNM,$J,DFN,OILORD)
 S ORL=""
 ; do the ALLERGY order checks
 I +OIL D
 . D FNDDRUG(.USID,+OIL,DFN,FID)
 . I FID="PSX" S FID="PSO"
 . S (CNT,ORX)=0
 . F  S CNT=$O(USID(CNT)) Q:CNT=""  D
 . . S ORX(CNT)=+OIL_"|"_FID_"|"_USID(CNT)_"|",ORX=ORX+1,ORI=1
 I +ORDRNUM D
 . I FID="PSX" S FID="PSO"
 . D FNDDRG(.ORX,+ORDRNUM,FID)
 . S OIL=ORDRNUM
 ;S ORX(1)=+OIL_"|"_FID_"||",(ORX,ORI)=1
 D EN^ORKCHK(.ORY,DFN,.ORX,"ALLERGY",.OIL,0)
 I $D(ORY) D RETURN^ORCHECK   ; expects ORY, ORCHECK
 ; return ORCHECK as 1 dimensional list
 D FDBDOWN^ORCHECK(0)
 I $D(ORY),OILORD>0 M ^TMP(ORALLCHKNM,$J,DFN,OILORD)=ORY
 D CHK2LST
 K ^TMP($J,"OROCOUTO;"),^TMP($J,"OROCOUTI;"),^TMP($J,"DD"),^TMP($J,"ORDSGCHK_CACHE")
 Q
REASON(LST,TYP,DFN,OID) ;Return list of pre-defined override reasons
 N ORRSN,RSNI,RSNTYP,ORDT,ORVP,ORIFN,ORLAST
 S ORDT="",ORIFN="",ORVP=DFN_";DPT(",ORLAST=""
 I OID D
 . F  S ORDT=$O(^OR(100,"AOI",OID,ORVP,ORDT),-1) Q:ORDT=""  D
 . . F  S ORIFN=$O(^OR(100,"AOI",OID,ORVP,ORDT,ORIFN)) Q:ORIFN=""!(ORLAST]"")  D
 . . . Q:'$D(^ORD(100.05,ORIFN,3,1))
 . . . S ORLAST=$G(^ORD(100.05,ORIFN,3,1,0))
 S ORRSN=0,RSNI=0
 I ORLAST]"" S LST($I(RSNI))=ORLAST
 F  S ORRSN=$O(^ORD(100.04,ORRSN)) Q:'ORRSN  D
 . S RSNTYP=$P(^ORD(100.04,ORRSN,0),"^",3)
 . I RSNTYP="B",TYP="R" Q  ;Quit if the reason type is 'B' for Both and the incoming option is 'R' only
 . Q:TYP'[RSNTYP&(RSNTYP'="B")  ;Otherwise quit if the reason type is not contained in the incoming option AND not 'B'
 . Q:$P(^ORD(100.04,ORRSN,0),"^",1)=ORLAST
 . S LST($I(RSNI))=$P(^ORD(100.04,ORRSN,0),"^",1)
 I 'RSNI S LST(1)="No predefined reasons available"
 Q
ACCEPT(LST,DFN,FID,STRT,ORL,OIL,ORIFN,ORREN,ORRENFLDS,ALLACC)    ; Return list of Order Checks on Accept Order
 K ^TMP($J,"OROCOUTO;"),^TMP($J,"OROCOUTI;"),^TMP($J,"ORDSGCHK_CACHE")
 ; OIL(n)=OIptr^PS|PSIV|LR^PkgInfo
 ; ORREN - IF ORREN IS SET TO 1 THEN ORIFN IS THE ORDER GETTING RENEWED
 K ^TMP($J,"ORENHCHK")
 N ACCEPT,X,Y,USID,ORCHECK,ORI,ORX,ORY,%DT,ORDODSG,ORDITM,ORALLCHKNM
 ; convert relative start date to real start date
 S ORL=ORL_";SC(",X=STRT,STRT="",ORDODSG=0
 D:X="AM" AM^ORCSAVE2 D:X="NEXT" NEXT^ORCSAVE2
 I $L(X) S %DT="FTX" D ^%DT S:Y'>0 Y="" S STRT=Y
 S ACCEPT=$S('+$G(ALLACC):"ACCEPT",1:"ALLACC")
 ; do the SELECT order checks
 S (ORI,ORX)=0 F  S ORI=$O(OIL(ORI)) Q:'ORI  D
 . Q:'OIL(ORI)
 . S USID=$$USID(OIL(ORI))
 . S OIL(ORI,"USID")=USID
 . S ORX=ORX+1,ORX(ORX)=+OIL(ORI)_"|"_FID_"|"_USID
 . S:$P(OIL(ORI),U,2)="PSIV" $P(ORX(ORX),"|",7)=$P($P(OIL(ORI),U,3),";")
 D EN^ORKCHK(.ORY,DFN,.ORX,"SELECT",.OIL,.ORDODSG)
 I $D(ORY) D RETURN^ORCHECK ; expects ORY, ORCHECK
 K ORX,ORY
 ; do the ACCEPT order checks
 S (ORI,ORX)=0 F  S ORI=$O(OIL(ORI)) Q:'ORI  D
 . Q:'OIL(ORI)
 . S ORX=ORX+1
 . S ORX(ORX)=+OIL(ORI)_"|"_FID_"|"_OIL(ORI,"USID")_"|"_STRT
 . S:$P(OIL(ORI),U,2)="LR" $P(ORX(ORX),"|",6)=$P(OIL(ORI),U,3)
 D EN^ORKCHK(.ORY,DFN,.ORX,ACCEPT,.OIL,.ORDODSG)
 I $D(ORY) D RETURN^ORCHECK   ; expects ORY, ORCHECK
 ; return ORCHECK as 1 dimensional list
 D FDBDOWN^ORCHECK(0)
 D OPOS(DFN)
 I '$G(DT) S DT=$$DT^XLFDT
 S ORALLCHKNM="ORALLERGYCHK"
 S ORDITM=+$P($G(OIL(1)),U,1)
 I $D(ORY),ORDITM>0,'$D(^TMP(ORALLCHKNM,$J,DFN,ORDITM)) D
 . N ORCNTR
 . S ORCNTR=0
 . F  S ORCNTR=$O(ORY(ORCNTR)) Q:ORCNTR=""  D
 . . I $P(ORY(ORCNTR),U,2)=3 S ^TMP(ORALLCHKNM,$J,DFN,ORDITM,ORCNTR)=$G(ORY(ORCNTR))
 D CHK2LST
 D CHECKIT(.LST)
 K ^TMP($J,"OROCOUTO;"),^TMP($J,"OROCOUTI;"),^TMP($J,"DD"),^TMP($J,"ORDSGCHK_CACHE")
 D CANCEL^ORNORC(.LST,DFN,FID,ORL,.OIL,STRT) ; ajb add order check data to 100.3
 Q
DELAY(LST,DFN,FID,STRT,ORL,OIL) ; Return list of Order Checks on Accept Delayed
 K ^TMP($J,"OROCOUTO;"),^TMP($J,"OROCOUTI;"),^TMP($J,"DD"),^TMP($J,"ORDSGCHK_CACHE")
 ; OIL(n)=OIptr^PS|PSIV|LR^PkgInfo
 N X,Y,ORCHECK,ORI,ORX,ORY,%DT
 ; convert relative start date to real start date
 S ORL=ORL_";SC(",X=STRT,STRT=""
 D:X="AM" AM^ORCSAVE2 D:X="NEXT" NEXT^ORCSAVE2
 I $L(X) S %DT="FTX" D ^%DT S:Y'>0 Y="" S STRT=Y
 ; do the ACCEPT order checks
 S (ORI,ORX)=0 F  S ORI=$O(OIL(ORI)) Q:'ORI  D
 . S ORX=ORX+1
 . S ORX(ORX)=+OIL(ORI)_"|"_FID_"|"_$$USID(OIL(ORI))_"|"_STRT
 . I $P(OIL(ORI),U,2)="LR" S $P(ORX(ORX),"|",6)=$P(OIL(ORI),U,3)
 D EN^ORKCHK(.ORY,DFN,.ORX,"ALL",.OIL)
 I $D(ORY) D RETURN^ORCHECK   ; expects ORY, ORCHECK
 ; return ORCHECK as 1 dimensional list
 D CHK2LST
 K ^TMP($J,"OROCOUTO;"),^TMP($J,"OROCOUTI;"),^TMP($J,"DD"),^TMP($J,"ORDSGCHK_CACHE")
 Q
SESSION(LST,ORVP,ORLST) ; Return list of Order Checks on Release Order
 K ^TMP($J,"OROCOUTO;"),^TMP($J,"OROCOUTI;"),^TMP($J,"DD")
 N I,ORES,ORCHECK
 S ORVP=+ORVP_";DPT("
 S I=0 F  S I=$O(ORLST(I)) Q:'I  D
 . I +$P(ORLST(I),";",2)'=1 Q  ; order not new
 . I $P(ORLST(I),U,3)="0" Q    ; order not being released
 . S ORES($P(ORLST(I),U))=""
 D SESSION^ORCHECK
 D OPOS(+ORVP)
 D CHK2LST
 D CHECKIT(.LST)
 K ^TMP($J,"OROCOUTO;"),^TMP($J,"OROCOUTI;"),^TMP($J,"DD")
 Q
SAVECHK(OK,ORVP,RSN,LST)    ; Save order checks for session
 N ORCHECK,ORIFN S OK=1
 D LST2CHK
 I $L(RSN)>0 S ORCHECK("OK")=RSN
 S ORIFN=0 F  S ORIFN=$O(ORCHECK(ORIFN)) Q:'ORIFN  D OC^ORCSAVE2
 Q
SAVEMCHK(OK,ORVP,LST)    ; TDP - Save order checks for session with
 ; multiple Reasons/Comments
 N ORCHECK,ORCOMMENTS,ORREASONS,ORIFN S OK=1
 D LST2CHK
 S ORIFN=0 F  S ORIFN=$O(ORCHECK(ORIFN)) Q:'ORIFN  D OC^ORCSAVE2
 Q
DELORD(OK,ORIFN)      ; ACTUALLY only cancel the order
 S OK=1
 D ORCAN^ORNORC(+ORIFN,"AC") ; ajb add order data to #100.3
 D CANCEL^ORCSAVE2(ORIFN)
 Q
USID(ORITMX) ; Return universal svc ID for an orderable item
 ; ORITMX = OI^NMSP^PKGINFO
 N RSLT,ORDRUG S RSLT=""
 I $E($P(ORITMX,U,2),1,2)="PS" D
 . I $P(ORITMX,U,2)="PSIV" D
 . . N PSOI,TYPE,VOL S VOL=""
 . . S PSOI=+$P($G(^ORD(101.43,+ORITMX,0)),U,2)
 . . S TYPE=$P($P(ORITMX,U,3),";")
 . . I TYPE="B" S VOL=$P($P(ORITMX,U,3),";",2)
 . . D ENDDIV^PSJORUTL(PSOI,TYPE,VOL,.ORDRUG)
 . . S ORDRUG=+ORDRUG
 . E  S ORDRUG=+$P(ORITMX,U,3)
 . S RSLT=$$ENDCM^PSJORUTL(ORDRUG)
 . S RSLT=$P(RSLT,U,3)_"^^99NDF^"_ORDRUG_U_$$NAME50^ORPEAPI(ORDRUG)_"^99PSD"
 E  S RSLT=$$USID^ORMBLD(+ORITMX)
 I +$P(RSLT,U)=0,+($P(RSLT,U,4)=0) S RSLT="" ; has to be null (why?)
 Q RSLT
 ;
CHK2LST ; creates list that can be passed to broker from ORCHECK array
 ; expects ORCHECK to be present and populates LST
 D REMDUPS ;similar to REMDUPS^ORCHECK
 N ORIFN,ORID,CDL,I,ILST,LASTIFN,RESERVED,ORCHECK2,ORNUM,OLIST,SORT
 S ILST=0,LASTIFN=0,RESERVED=0,OLIST=0,SORT=""
 S ORIFN="" F  S ORIFN=$O(ORCHECK(ORIFN)) Q:ORIFN=""  D
 . S CDL=0 F  S CDL=$O(ORCHECK(ORIFN,CDL)) Q:'CDL  D
 . . S SORT=$S(+SORT=0:CDL,CDL<+SORT:CDL,1:+SORT)
 . . S I=0 F  S I=$O(ORCHECK(ORIFN,CDL,I)) Q:'I  D
 . . . S ORCHECK2(ORIFN,CDL,+ORCHECK(ORIFN,CDL,I),I)=ORCHECK(ORIFN,CDL,I)
 . S:SORT'="" SORT(SORT,ORIFN)="",SORT=""
 K ORCHECK
 S ORIFN="" F  S ORIFN=$O(ORCHECK2(ORIFN)) Q:ORIFN=""  D
 . S CDL=0 F  S CDL=$O(ORCHECK2(ORIFN,CDL)) Q:'CDL  D
 . . S ORNUM=0 F  S ORNUM=$O(ORCHECK2(ORIFN,CDL,ORNUM)) Q:'ORNUM  D
 . . . S I=0 F  S I=$O(ORCHECK2(ORIFN,CDL,ORNUM,I)) Q:'I  D
 . . . . S OLIST=OLIST+1,ORCHECK(ORIFN,CDL,OLIST)=ORCHECK2(ORIFN,CDL,ORNUM,I)
 S SORT=0 F  S SORT=$O(SORT(SORT)) Q:'SORT  D
 . S ORIFN="" F  S ORIFN=$O(SORT(SORT,ORIFN)) Q:ORIFN=""  D
 . . S CDL=0 F  S CDL=$O(ORCHECK(ORIFN,CDL)) Q:'CDL  D
 . . . S I=0 F  S I=$O(ORCHECK(ORIFN,CDL,I)) Q:'I  D
 . . . . I LASTIFN'=ORIFN S LASTIFN=ORIFN,RESERVED=ILST+1,ILST=ILST+1 ; saves a spot for the RDI warning at the top of each order's checks
 . . . . S ORID=ORIFN I +ORID,(+ORID=ORID) S ORID=ORID_";1"
 . . . . I '$P(ORCHECK(ORIFN,CDL,I),U,2) Q  ; CDL="" means don't show
 . . . . I $P(ORCHECK(ORIFN,CDL,I),U,1)=99 S LST(RESERVED)=ORID_U_ORCHECK(ORIFN,CDL,I) Q  ;Put RDI warning at the top of each order's checks
 . . . . S ILST=ILST+1,LST(ILST)=ORID_U_ORCHECK(ORIFN,CDL,I)
 Q
LST2CHK ; create ORCHECK array from list passed by broker and
 ; create ORREASON and ORCOMMENTS arrays from lists passed by broker
 N ORIFN,CDL,I,ILST,X S I=0
 S ILST="" F  S ILST=$O(LST("ORCHECKS",ILST)) Q:$L(ILST)'>0  D
 . I $D(LST("ORCHECKS",ILST,0)) D
 . . N J S J=0 S X=LST("ORCHECKS",ILST,J) F  S J=$O(LST("ORCHECKS",ILST,J)) Q:'J  S X=X_LST("ORCHECKS",ILST,J)
 . I '$D(LST("ORCHECKS",ILST,0)) S X=LST("ORCHECKS",ILST)
 . S ORIFN=$P(X,U),CDL=$P(X,U,3)
 . I +$G(ORIFN)>0,+$G(CDL)>0 D  ;cla 12/16/03
 . . S I=I+1,ORCHECK(+ORIFN,CDL,I)=$P(X,U,2,4)
 ;TDP - Added below code to handle Override Reasons
 S ILST="" F  S ILST=$O(LST("ORREASONS",ILST)) Q:ILST=""  D
 . ;
 . S X=LST("ORREASONS",ILST) ;I $D(LST("ORREASONS",ILST))
 . ;. S ILST="" F  S ILST=$O(LSTR("ORREASONS",ILST)) Q:$L(ILST)'>0  D
 . S ORIFN=+$P(X,U)
 . Q:+ORIFN<1
 . S ORREASONS(ORIFN)=$P(X,U,2)
 ;TDP - Added below code to handle Remote Allergy Comments
 S ILST="" F  S ILST=$O(LST("ORCOMMENTS",ILST)) Q:ILST=""  D
 . S X=LST("ORCOMMENTS",ILST)
 . S ORIFN=+$P(X,U)
 . Q:+ORIFN<1
 . S ORCOMMENTS(ORIFN)=$P(LST("ORCOMMENTS",ILST),U,2)
 Q
CHECKIT(X) ;remove uncessesary duplication of Duplicate Therapy checks
 N I,J,K,Y,Z
 S I=0 F  S I=$O(X(I)) Q:'I  I $P(X(I),U,2)=17 D
 .Q:$P($G(^ORD(100.8,17,0)),U)'="DUPLICATE DRUG THERAPY"
 .N STR S STR=$P($P(X(I),"{",2),"}")
 .N CLASS S CLASS=$P(X(I),"in the same therapeutic categor(ies): ",2)
 .S Z(+X(I),I)=CLASS
 .S J=0 F  S J=J+1 Q:J>$L(STR,", ")  D
 ..S Y(+X(I),I,J)=$P(STR,", ",J)
 S I="" F  S I=$O(Y(I)) Q:'$L(I)  D
 .S J=0 F  S J=$O(Y(I,J)) Q:'J  D
 ..S K=J F  S K=$O(Y(I,K)) Q:'K!('$D(Y(I,J)))  D
 ...N A,B M A=Y(I,J),B=Y(I,K)
 ...I $$AINB(.A,.B) D
 ....N ADDCLASS S ADDCLASS=$P(Z(I,J),U)
 ....K X(J),Y(I,J)
 ....I X(K)'[ADDCLASS S X(K)=X(K)_", "_ADDCLASS
 ...Q:'$D(Y(I,J))
 ...I $$AINB(.B,.A) D
 ....N ADDCLASS S ADDCLASS=$P(Z(I,K),U)
 ....K X(K),Y(I,K)
 ....I X(J)'[ADDCLASS S X(J)=X(J)_", "_ADDCLASS
 Q
AINB(A,B) ;if array A is a subset of array B then return 1, else return 0
 N I,RET
 S RET=1
 S I=0 F  S I=$O(A(I)) Q:'I  I '$$XINA(A(I),.B) S RET=0 Q
 Q RET
XINA(X,A) ;if string X is an entry in array A then return 1, else return 0
 N I,RET
 S RET=0
 S I=0 F  S I=$O(A(I)) Q:'I  I X=A(I) S RET=1 Q
 Q RET
REMDUPS ;
 N IFN,CDL,I,J,CDL2 S IFN="NEW"
 S CDL=0 F  S CDL=$O(ORCHECK(IFN,CDL)) Q:'CDL  D
 . S I=0 F  S I=$O(ORCHECK(IFN,CDL,I)) Q:'I  D
 .. S CDL2=0 F  S CDL2=$O(ORCHECK(IFN,CDL2)) Q:'CDL2  D
 ... S J=I F  S J=$O(ORCHECK(IFN,CDL2,J)) Q:'J  I $TR($P($G(ORCHECK(IFN,CDL,I)),U,3),";",",")=$TR($P($G(ORCHECK(IFN,CDL2,J)),U,3),";",",") D
 .... I CDL2<=CDL K ORCHECK(IFN,CDL2,J) S ORCHECK=$G(ORCHECK)-1
 .... I CDL2>CDL S $P(ORCHECK(IFN,CDL,I),U,7)="X"
 .. I $P(ORCHECK(IFN,CDL,I),U,7)="X" K ORCHECK(IFN,CDL,I) S ORCHECK=$G(ORCHECK)-1
 Q
REMDUPSX ;similar to REMDUPS^ORCHECK
 N IFN,CDL,I,J S IFN="NEW"
 S CDL=0 F  S CDL=$O(ORCHECK(IFN,CDL)) Q:'CDL  D
 . S I=0 F  S I=$O(ORCHECK(IFN,CDL,I)) Q:'I  D
 . . S J=I F  S J=$O(ORCHECK(IFN,CDL,J)) Q:'J  I $G(ORCHECK(IFN,CDL,I))=$G(ORCHECK(IFN,CDL,J)) K ORCHECK(IFN,CDL,J) S ORCHECK=$G(ORCHECK)-1
 Q
OPOS(DFN) ;handles saving and removing order checks that should only be displayed once per cprs session
 ; expects ORCHECK
 ; sets these order checks into the "Once Per cprs Session" global ^TMP($J,"OC-OPOS",DFN)
 N I,J,K
 S I="" F  S I=$O(ORCHECK(I)) Q:'$L(I)  D
 .S J=0 F  S J=$O(ORCHECK(I,J)) Q:'J  D
 ..S K=0 F  S K=$O(ORCHECK(I,J,K)) Q:'K  D
 ...N ORTXT,ORTXTO,ORTXT0,ORTXTI,ORXTRAI
 ...S ORTXTO="These checks could not be completed for this patient:"
 ...Q:(ORCHECK(I,J,K)'[ORTXTO)
 ...S ORTXT=ORTXTO
 ...S ORXTRAI=$P($P(ORCHECK(I,J,K),"||",2),"&")
 ...S ORTXTI=0 F  S ORTXTI=$O(^TMP($J,"ORK XTRA TXT",ORXTRAI,ORTXTO,ORTXTI))  Q:'ORTXTI  D
 ....S ORTXT=ORTXT_$G(^TMP($J,"ORK XTRA TXT",ORXTRAI,ORTXTO,ORTXTI))
 ...I $D(^TMP($J,"OC-OPOS",DFN,$E(ORTXT,1,225))) K ORCHECK(I,J,K) Q
 ...S ^TMP($J,"OC-OPOS",DFN,$E(ORTXT,1,225))="" Q
 Q
FNDDRUG(USID,OI,DFN,FID) ;Identify and return potential drug items based on
 ; the Orderable Item
 N X,RSLT
 D OISLCT(.RSLT,OI,$S($G(FID)="PSO":"O",$G(FID)="PSH":"X",$G(FID)="PSIV":"I",1:"U"),DFN)
 S X=0 F  S X=$O(RSLT(X)) Q:+X=0  D
 . S USID(X)=$$DRUG($G(RSLT(X)))
 K RSLT
 Q
OISLCT(LST,OI,PSTYPE,ORVP) ; Return Dispense Drug IENs ;Modified from OISLCT^ORWDPS2
 ;TDP note - PSTYPE needs to be - O:Outpt, U:Unit Dose, I:IV, X:Non-VA Med
 N ILST,ORDOSE,ORWPSOI,ORWDOSES,X1,X2
 K ^TMP("PSJINS",$J),^TMP("PSJMR",$J),^TMP("PSJNOUN",$J),^TMP("PSJSCH",$J),^TMP("PSSDIN",$J)
 S ILST=0
 S ORWPSOI=0
 S:+OI ORWPSOI=+$P($G(^ORD(101.43,+OI,0)),U,2)
 ;D START^PSSJORDF(ORWPSOI,$S(PSTYPE="U":"I",1:"O")) ; dflt route, schedule, etc.
 I '$L($T(DOSE^PSSOPKI1)) D DOSE^PSSORUTL(.ORDOSE,ORWPSOI,PSTYPE,ORVP)       ; dflt doses
 I $L($T(DOSE^PSSOPKI1)) D DOSE^PSSOPKI1(.ORDOSE,ORWPSOI,PSTYPE,ORVP)       ; dflt doses NEW PKI CODE from pharmacy
 ;
 ; Modified from DISPLST^ORWDPS2, set up list of dispense drugs ien
 N DD
 S DD=0 F  S DD=$O(ORDOSE("DD",DD)) Q:'DD  D
 . S ILST=ILST+1
 . S LST(ILST)=DD
 Q
DRUG(ORDD) ;Returns 6 ^-piece identifier for Dispense Drug ;Modified from DRUG^ORCHECK
 N ORNDF,Y
 ;Next line requires work to make it usable. Variables used that are not available, like Order #
 ;I ORDG=+$O(^ORD(100.98,"B","IV RX",0)) S ORDD=$$IV^ORCHECK G D1
 S ORDD=+ORDD
 Q:ORDD=0 "" S ORNDF=$$ENDCM^PSJORUTL(ORDD)
D1 S Y=$P(ORNDF,U,3)_"^^99NDF^"_ORDD_U_$$NAME50^ORPEAPI(ORDD)_"^99PSD"
 Q Y
FNDDRG(ORX,ORDER,PKG) ;
 N ORI,INST,PTR,ITEM,USID,START,ORDD
 S ORI=0
 F  S ORI=$O(^OR(100,ORDER,4.5,"ID","ORDERABLE",ORI)) Q:ORI'>0  D
 . S INST=$P($G(^OR(100,ORDER,4.5,ORI,0)),U,3),PTR=$P($G(^(0)),U,2),ITEM=+$G(^(1))
 . ;S USID=$S(PKG?1"PS".E:$$DRUG(ITEM,PTR,ORDER),1:$$USID^ORMBLD(ITEM))
 . S ORDD=$O(^OR(100,ORDER,4.5,"ID","DRUG",0)),ORDD=+$G(^OR(100,ORDER,4.5,+ORDD,1))
 . S USID=$$DRUG(ORDD)
 . S START=$$START^ORCHECK(ORDER)
 . ;S SPEC=$S(PKG="LR":$$VALUE^ORCSAVE2(ORDER,"SPECIMEN",INST),1:"")
 . ;S ORX=+$G(ORX)+1,ORX(ORX)=ITEM_"|"_PKG_"|"_USID_"|"_START_"|"_ORDER_"|"_SPEC
 . S ORX=+$G(ORX)+1,ORX(ORX)=ITEM_"|"_PKG_"|"_USID_"|"_START_"|"_ORDER_"|"
 Q
CLRALLGY(ORY,DFN) ;Clears the ^TMP data containing the temporary allergy order checks for a patient
 ;   DFN = PATIENT IEN
 N ORALLCHKNM
 S ORALLCHKNM="ORALLERGYCHK"
 I +$G(DFN)=0 Q
 K ^TMP(ORALLCHKNM,$J,+DFN)
 Q
