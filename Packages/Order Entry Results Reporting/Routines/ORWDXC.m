ORWDXC ; SLC/KCM - Utilities for Order Checking ;01/28/15  08:30
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,141,221,243,280,346,345,311,395**;Dec 17, 1997;Build 11
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
ACCEPT(LST,DFN,FID,STRT,ORL,OIL,ORIFN,ORREN)    ; Return list of Order Checks on Accept Order
 K ^TMP($J,"OROCOUTO;"),^TMP($J,"OROCOUTI;"),^TMP($J,"ORDSGCHK_CACHE")
 ; OIL(n)=OIptr^PS|PSIV|LR^PkgInfo
 ; ORREN - IF ORREN IS SET TO 1 THEN ORIFN IS THE ORDER GETTING RENEWED
 K ^TMP($J,"ORENHCHK")
 N X,Y,USID,ORCHECK,ORI,ORX,ORY,%DT,ORDODSG
 ; convert relative start date to real start date
 S ORL=ORL_";SC(",X=STRT,STRT="",ORDODSG=0
 D:X="AM" AM^ORCSAVE2 D:X="NEXT" NEXT^ORCSAVE2
 I $L(X) S %DT="FTX" D ^%DT S:Y'>0 Y="" S STRT=Y
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
 D EN^ORKCHK(.ORY,DFN,.ORX,"ACCEPT",.OIL,.ORDODSG)
 I $D(ORY) D RETURN^ORCHECK   ; expects ORY, ORCHECK
 ; return ORCHECK as 1 dimensional list
 D FDBDOWN^ORCHECK(0)
 D OPOS(DFN)
 D CHK2LST
 K ^TMP($J,"OROCOUTO;"),^TMP($J,"OROCOUTI;"),^TMP($J,"DD"),^TMP($J,"ORDSGCHK_CACHE")
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
 N ORES,ORCHECK
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
DELORD(OK,ORIFN)      ; Delete order
 N STS,DIK,DA
 S STS=$P(^OR(100,+ORIFN,8,1,0),U,15),OK=0
 I (STS=10)!(STS=11) D  Q  ; makes sure it's an unreleased order
 . ;*400 - Delete unused replacement order
 . N OLDIFN,DA,DIE,DR S OLDIFN=$P(^OR(100,+ORIFN,3),U,5) I $G(OLDIFN) D
 . . S DA=+OLDIFN,DIE="^OR(100,",DR="9.1///@"
 . . D ^DIE K DA,DIE,DR
 . S DA=+ORIFN,DIK="^OR(100," Q:'DA
 . D ^DIK
 . S OK=1
 . D DELETE^OROCAPI1(+ORIFN)
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
 N ORIFN,ORID,CDL,I,ILST,LASTIFN,RESERVED,ORCHECK2,ORNUM,OLIST S ILST=0,LASTIFN=0,RESERVED=0,OLIST=0
 S ORIFN="" F  S ORIFN=$O(ORCHECK(ORIFN)) Q:ORIFN=""  D
 . S CDL=0 F  S CDL=$O(ORCHECK(ORIFN,CDL)) Q:'CDL  D
 . . S I=0 F  S I=$O(ORCHECK(ORIFN,CDL,I)) Q:'I  D
 . . . S ORCHECK2(ORIFN,CDL,+ORCHECK(ORIFN,CDL,I),I)=ORCHECK(ORIFN,CDL,I)
 K ORCHECK
 S ORIFN="" F  S ORIFN=$O(ORCHECK2(ORIFN)) Q:ORIFN=""  D
 . S CDL=0 F  S CDL=$O(ORCHECK2(ORIFN,CDL)) Q:'CDL  D
 . . S ORNUM=0 F  S ORNUM=$O(ORCHECK2(ORIFN,CDL,ORNUM)) Q:'ORNUM  D
 . . . S I=0 F  S I=$O(ORCHECK2(ORIFN,CDL,ORNUM,I)) Q:'I  D
 . . . . S OLIST=OLIST+1,ORCHECK(ORIFN,CDL,OLIST)=ORCHECK2(ORIFN,CDL,ORNUM,I)
 S ORIFN="" F  S ORIFN=$O(ORCHECK(ORIFN)) Q:ORIFN=""  D
 . S CDL=0 F  S CDL=$O(ORCHECK(ORIFN,CDL)) Q:'CDL  D
 . . S I=0 F  S I=$O(ORCHECK(ORIFN,CDL,I)) Q:'I  D
 . . . I LASTIFN'=ORIFN S LASTIFN=ORIFN,RESERVED=ILST+1,ILST=ILST+1 ; saves a spot for the RDI warning at the top of each order's checks
 . . . S ORID=ORIFN I +ORID,(+ORID=ORID) S ORID=ORID_";1"
 . . . I '$P(ORCHECK(ORIFN,CDL,I),U,2) Q  ; CDL="" means don't show
 . . . I $P(ORCHECK(ORIFN,CDL,I),U,1)=99 S LST(RESERVED)=ORID_U_ORCHECK(ORIFN,CDL,I) Q  ;Put RDI warning at the top of each order's checks
 . . . S ILST=ILST+1,LST(ILST)=ORID_U_ORCHECK(ORIFN,CDL,I)
 Q
LST2CHK ; create ORCHECK array from list passed by broker
 N ORIFN,CDL,I,ILST S I=0
 S ILST="" F  S ILST=$O(LST("ORCHECKS",ILST)) Q:$L(ILST)'>0  D
 . I $D(LST("ORCHECKS",ILST,0)) D
 . . N J S J=0 S X=LST("ORCHECKS",ILST,J) F  S J=$O(LST("ORCHECKS",ILST,J)) Q:'J  S X=X_LST("ORCHECKS",ILST,J)
 . I '$D(LST("ORCHECKS",ILST,0)) S X=LST("ORCHECKS",ILST)
 . S ORIFN=$P(X,U),CDL=$P(X,U,3)
 . I +$G(ORIFN)>0,+$G(CDL)>0 D  ;cla 12/16/03
 . . S I=I+1,ORCHECK(+ORIFN,CDL,I)=$P(X,U,2,4)
 Q
CHECKIT(X) ;remove uncessesary duplication of Duplicate Therapy checks
 N I,J,Y
 S I=0 F  S I=$O(X(I)) Q:'I  I $P(X(I),U,2)=17 D
 .Q:$P($G(^ORD(100.8,17,0)),U)'="DUPLICATE DRUG THERAPY"
 .N STR S STR=$P($P(X(I),"{",2),"}")
 .S J=0 F  S J=J+1 Q:J>$L(STR,", ")  S Y(+X(I),I,J)=$P(STR,", ",J)
 S I=0 F  S I=$O(Y(I)) Q:'I  D
 .S J=0 F  S J=$O(Y(I,J)) Q:'J  D
 ..S K=J F  S K=$O(Y(I,K)) Q:'K!('$D(Y(I,J)))  D
 ...N A,B M A=Y(I,J),B=Y(I,K)
 ...I $$AINB(.A,.B) K X(J),Y(I,J)
 ...Q:'$D(Y(I,J))
 ...I $$AINB(.B,.A) K X(K),Y(I,K)
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
 N IFN,CDL,I S IFN="NEW"
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
 ...N ORTXT,ORTXT0,ORTXTI,ORXTRAI
 ...S ORTXTO="These checks could not be completed for this patient:"
 ...Q:(ORCHECK(I,J,K)'[ORTXTO)
 ...S ORTXT=ORTXTO
 ...S ORXTRAI=$P($P(ORCHECK(I,J,K),"||",2),"&")
 ...S ORTXTI=0 F  S ORTXTI=$O(^TMP($J,"ORK XTRA TXT",ORXTRAI,ORTXTO,ORTXTI))  Q:'ORTXTI  D
 ....S ORTXT=ORTXT_$G(^TMP($J,"ORK XTRA TXT",ORXTRAI,ORTXTO,ORTXTI))
 ...I $D(^TMP($J,"OC-OPOS",DFN,$E(ORTXT,1,225))) K ORCHECK(I,J,K) Q
 ...S ^TMP($J,"OC-OPOS",DFN,$E(ORTXT,1,225))="" Q
 Q
