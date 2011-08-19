ORWDXC ; SLC/KCM - Utilities for Order Checking ;07/27/11  07:10
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,141,221,243,280,346**;Dec 17, 1997;Build 5
 ;
ORMOCHAT ;PARSE MOCHA METRICS
 ;N ORMDT
 ;S ORMDT=0 F  S ORMDT=$O(^XTMP("ORMOCHAT",ORMDT)) Q:'ORMDT  D
 ;.N ORMX
 ;.S ORMX="" F  S ORMX=$O(^XTMP("ORMOCHAT",ORMDT,ORMX)) Q:'ORMX  D
 ;..S $P(^XTMP("ORMOCHAT",ORMDT,ORMX),U,5)=$P(^XTMP("ORMOCHAT",ORMDT,ORMX,"TOTAL"),U,2)-$P(^XTMP("ORMOCHAT",ORMDT,ORMX,"TOTAL"),U)
 ;..N ORMENHT,ORMENHC,ORMENHX S ORMENHT=0,ORMENHC=0,ORMENHX=0
 ;..F  S ORMENHC=$O(^XTMP("ORMOCHAT",ORMDT,ORMX,"ENH",ORMENHC)) Q:'ORMENHC  S ORMENHT=ORMENHT+$P(^XTMP("ORMOCHAT",ORMDT,ORMX,"ENH",ORMENHC),U,2)-$P(^XTMP("ORMOCHAT",ORMDT,ORMX,"ENH",ORMENHC),U),ORMENHX=ORMENHC
 ;..S $P(^XTMP("ORMOCHAT",ORMDT,ORMX),U,6)=ORMENHT
 ;..S $P(^XTMP("ORMOCHAT",ORMDT,ORMX),U,7)=ORMENHX
 ;..N ORDIFF S ORDIFF=$ZH-ORMX
 ;..S $P(^XTMP("ORMOCHAT",ORMDT,ORMX),U,8)=$$FMADD^XLFDT($$NOW^XLFDT,"","","",-ORDIFF)
 ;..S $P(^XTMP("ORMOCHAT",ORMDT,ORMX),U,9)="||"
 ;..W !,^XTMP("ORMOCHAT",ORMDT,ORMX)
 Q
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
 ; OIL(n)=OIptr^PS|PSIV|LR^PkgInfo
 ; ORREN - IF ORREN IS SET TO 1 THEN ORIFN IS THE ORDER GETTING RENEWED
 ;S ^XTMP("ORMOCHAT",0)=$$FMADD^XLFDT($$NOW^XLFDT,2)_U_$$NOW^XLFDT N ORMOCHAT S ORMOCHAT=$NA(^XTMP("ORMOCHAT",$$NOW^XLFDT,$ZH)) S @ORMOCHAT="ORWDXC ACCEPT"_U_$J_U_DFN_U_DUZ,$P(@ORMOCHAT@("TOTAL"),U,1)=$ZH
 N X,Y,USID,ORCHECK,ORI,ORX,ORY
 ; convert relative start date to real start date
 S ORL=ORL_";SC(",X=STRT,STRT=""
 D:X="AM" AM^ORCSAVE2 D:X="NEXT" NEXT^ORCSAVE2
 I $L(X) S %DT="FTX" D ^%DT S:Y'>0 Y="" S STRT=Y
 ; do the SELECT order checks
 S ORI=0 F  S ORI=$O(OIL(ORI)) Q:'ORI  D
 . Q:'OIL(ORI)
 . S USID=$$USID(OIL(ORI))
 . S OIL(ORI,"USID")=USID
 . S ORX=1,ORX(1)=+OIL(ORI)_"|"_FID_"|"_USID
 . D EN^ORKCHK(.ORY,DFN,.ORX,"SELECT")
 . I $D(ORY) D RETURN^ORCHECK ; expects ORY, ORCHECK
 . K ORX,ORY
 ; do the ACCEPT order checks
 S (ORI,ORX)=0 F  S ORI=$O(OIL(ORI)) Q:'ORI  D
 . Q:'OIL(ORI)
 . S ORX=ORX+1
 . S ORX(ORX)=+OIL(ORI)_"|"_FID_"|"_OIL(ORI,"USID")_"|"_STRT
 . I $P(OIL(ORI),U,2)="LR" S $P(ORX(ORX),"|",6)=$P(OIL(ORI),U,3)
 D EN^ORKCHK(.ORY,DFN,.ORX,"ACCEPT",.OIL)
 I $D(ORY) D RETURN^ORCHECK   ; expects ORY, ORCHECK
 ; return ORCHECK as 1 dimensional list
 D FDBDOWN^ORCHECK(0)
 D OPOS(DFN)
 D CHK2LST
 ;I $D(ORMOCHAT) S $P(@ORMOCHAT@("TOTAL"),U,2)=$ZH
 Q
DELAY(LST,DFN,FID,STRT,ORL,OIL) ; Return list of Order Checks on Accept Delayed
 ; OIL(n)=OIptr^PS|PSIV|LR^PkgInfo
 N X,Y,ORCHECK,ORI,ORX,ORY
 ; convert relative start date to real start date
 S ORL=ORL_";SC(",X=STRT,STRT=""
 D:X="AM" AM^ORCSAVE2 D:X="NEXT" NEXT^ORCSAVE2
 I $L(X) S %DT="FTX" D ^%DT S:Y'>0 Y="" S STRT=Y
 ; do the ACCEPT order checks
 S (ORI,ORX)=0 F  S ORI=$O(OIL(ORI)) Q:'ORI  D
 . S ORX=ORX+1
 . S ORX(ORX)=+OIL(ORI)_"|"_FID_"|"_$$USID(OIL(ORI))_"|"_STRT
 . I $P(OIL(ORI),U,2)="LR" S $P(ORX(ORX),"|",6)=$P(OIL(ORI),U,3)
 D EN^ORKCHK(.ORY,DFN,.ORX,"ALL")
 I $D(ORY) D RETURN^ORCHECK   ; expects ORY, ORCHECK
 ; return ORCHECK as 1 dimensional list
 D CHK2LST
 Q
SESSION(LST,ORVP,ORLST)  ; Return list of Order Checks on Release Order
 K ^TMP($J,"OROCOUTO;"),^TMP($J,"OROCOUTI;"),^TMP($J,"DD")
 ;S ^XTMP("ORMOCHAT",0)=$$FMADD^XLFDT($$NOW^XLFDT,2)_U_$$NOW^XLFDT N ORMOCHAT S ORMOCHAT=$NA(^XTMP("ORMOCHAT",$$NOW^XLFDT,$ZH)) S @ORMOCHAT="ORWDXC SESSION"_U_$J_U_ORVP_U_DUZ,$P(@ORMOCHAT@("TOTAL"),U,1)=$ZH
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
 ;I $D(ORMOCHAT) S $P(@ORMOCHAT@("TOTAL"),U,2)=$ZH
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
 ..S K=J F  S K=$O(Y(I,K)) Q:'K  D
 ...N A,B M A=Y(I,J),B=Y(I,K)
 ...I $$AINB(.A,.B) K X(J)
 ...I $$AINB(.B,.A) K X(K)
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
REMDUPS ;similar to REMDUPS^ORCHECK
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
 ...Q:(ORCHECK(I,J,K)'["These checks will NOT be performed for this patient")
 ...I $L(ORCHECK(I,J,K),"&")>1  I $D(^TMP($J,"OC-OPOS",DFN,$E($P(ORCHECK(I,J,K),"&",2),1,225))) K ORCHECK(I,J,K) Q
 ...I $D(^TMP($J,"OC-OPOS",DFN,$E(ORCHECK(I,J,K),1,225))) K ORCHECK(I,J,K) Q
 ...I $L(ORCHECK(I,J,K),"&")>1 S ^TMP($J,"OC-OPOS",DFN,$E($P(ORCHECK(I,J,K),"&",2),1,225))="" Q
 ...S ^TMP($J,"OC-OPOS",DFN,$E(ORCHECK(I,J,K),1,225))=""
 Q
