HMPUTIL2 ; Agilex/hrubovcak -- HMP utilities routine ;Jun 10, 2015@15:13:03
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**2**;Sep 01, 2011;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
ADHOC(HMPDMN,HMPFCNT,DFN,UID,STMPTM,DLTFLG) ; Add syncStart metastamp and syncStatus to unsolicited updates
 ; HMPDMN,HMPFCNT,DFN,UID,STMPTM  - all required
 ; DLTFLG - boolean 1 to delete, zero otherwise (optional)
 ; requires HMPFSTRM and ARGS in symbol table
 Q:($G(HMPDMN)="")!($G(DFN)="")!($G(UID)="")!($G(STMPTM)="")
 ; set error trap
 N $ES,$ET,ERRPAT
 S $EC="",$ET="D ERRHDLR^HMPDERRH",ERRPAT=DFN
 ;
 S DLTFLG=+$G(DLTFLG)  ; optional parameter
 ;Build SyncStart
 N H,HMPDAT,HMPID,HMPJSN,HMPSUB,HMPTOT,HMPVAR,HMPX,HMPZ,JSNERR,STS,STSJSON,X,Y
 S HMPSUB=$O(^TMP("HMP",$J,0)) Q:'HMPSUB
 S HMPID=$$SYS^HMPUTILS
 S HMPZ=0,HMPFCNT=$G(HMPFCNT)+1
 D  ; start of JSON, based on DFN
 .I DFN'="OPD" S HMPJSN="{""collection"":"""_"syncStart"_$C(34)_$$PIDS^HMPDJFS(DFN)_"," Q
 .;operational data synch
 .S HMPJSN="{""collection"":"""_"OPDsyncStart"_$C(34)_","""_"systemId"":"""_$P(HMPID,";")_$C(34)_","
 .Q:'DLTFLG  ; deletion logic follows
 .S H=$$FMTH^XLFDT($P($G(HMPFSTRM),"~",3))  ; days in $H format
 .S X=$$HTFM^XLFDT($P(H,",")_","_(+$G(ARGS("hmp-fst"))))  ; add $H seconds or zero, get FileMan date
 .S HMPVAR("JSON DEL DATE/TIME")=$$JSONDT^HMPUTILS(X)  ; delete date/time into JSON format
 .S X=$P($G(UID),":",4)_";"_$P(UID,":",5)  ; UID pieces needed below
 .S HMPVAR("REMOVED JSON")="{""pid"":"""_X_""",""removed"":""true"",""stampTime"":"_HMPVAR("JSON DEL DATE/TIME")_",""uid"":"""_UID_"""}"
 ;
 S:HMPFCNT>1 HMPJSN="},"_HMPJSN
 S HMPJSN=HMPJSN_"""metaStamp"":"_"{"
 I DFN'="OPD" S HMPJSN=HMPJSN_$E($$PIDS^HMPDJFS(DFN),2,$L($$PIDS^HMPDJFS(DFN)))_","
 S HMPJSN=HMPJSN_"""stampTime"":"""_STMPTM_$C(34)_",""sourceMetaStamp"":"_"{"
 S HMPJSN=HMPJSN_$C(34)_$P(HMPID,";")_$C(34)_":{"
 I DFN'="OPD" S HMPJSN=HMPJSN_$E($$PIDS^HMPDJFS(DFN),2,$L($$PIDS^HMPDJFS(DFN)))_","
 S HMPJSN=HMPJSN_"""stampTime"":"""_STMPTM_$C(34)_","
 S HMPJSN=HMPJSN_"""domainMetaStamp"""_":"_"{"
 ; transform the domain name for quick orders to match the uid
 S HMPVAR("DOMAIN")=HMPDMN S:HMPVAR("DOMAIN")="quick" HMPVAR("DOMAIN")="qo"
 S HMPTOT=1
 S HMPJSN=HMPJSN_$C(34)_HMPVAR("DOMAIN")_$C(34)_":{"
 S HMPJSN=HMPJSN_"""domain"":"""_HMPVAR("DOMAIN")_$C(34)_","
 S HMPJSN=HMPJSN_"""stampTime"":"""_STMPTM_$C(34)_","
 I DFN="OPD" S HMPJSN=HMPJSN_"""itemMetaStamp"""_":"_"{"
 E  S HMPJSN=HMPJSN_"""eventMetaStamp"""_":"_"{"
 ;
 I $L(HMPJSN)>1000 S HMPZ=HMPZ+1,^TMP("HMPF",$J,HMPFCNT,.3,HMPZ)=HMPJSN,HMPJSN=""
 S HMPVAR("DATETIME")=$P(UID,":",4,99)
 ;I DLTFLG S HMPVAR("DATETIME")=$P(UID,":",4,99))
 S HMPJSN=HMPJSN_$C(34)_UID_":"_HMPVAR("DOMAIN")_":"_HMPVAR("DATETIME")_$C(34)_":{"
 ; determine date/time to use
 S Y=STMPTM S:$G(HMPVAR("JSON DEL DATE/TIME")) Y=HMPVAR("JSON DEL DATE/TIME")
 S HMPJSN=HMPJSN_"""stampTime"":"""_Y_$C(34)_"}}},"  ; put date/time into JSON array
 ;
 I $L(HMPJSN)>1000 S HMPZ=HMPZ+1,^TMP("HMPF",$J,HMPFCNT,.3,HMPZ)=HMPJSN,HMPJSN=""
 S HMPZ=HMPZ+1
 S HMPJSN=$E(HMPJSN,1,$L(HMPJSN)-1)_"}}}}},"
 ;Save syncStart
 S ^TMP("HMPF",$J,HMPFCNT,.3,HMPZ)=HMPJSN
 ;Merge in data section from FRESHITM^HMPDJFSG
 S HMPSUB=""
 F  S HMPSUB=$O(^TMP("HMP",$J,HMPSUB)) Q:'HMPSUB  D
 .S HMPFCNT=HMPFCNT+1
 .I DFN'="OPD" S ^TMP("HMPF",$J,HMPFCNT,.3)="{""collection"":"""_HMPVAR("DOMAIN")_$C(34)_$$PIDS^HMPDJFS(DFN)_",""seq"":1,""total"":1,""object"":"
 .I DFN="OPD",DLTFLG S ^TMP("HMPF",$J,HMPFCNT,.3)="{""collection"":"""_HMPVAR("DOMAIN")_""",""seq"":1,""total"":1,""object"":"_HMPVAR("REMOVED JSON") ;;US5647
 .I DFN="OPD",'DLTFLG  D  ;US5859
 ..S ^TMP("HMPF",$J,HMPFCNT,.3)="{""collection"":"""_HMPVAR("DOMAIN")_""",""seq"":1,""total"":1,""object"":"
 ..S HMPX="""stampTime"":"_$C(34)_STMPTM_$C(34)_","
 ..S HMPDAT=$G(^TMP("HMP",$J,HMPSUB,1))
 ..S ^TMP("HMP",$J,HMPSUB,1)="{"_HMPX_$P(HMPDAT,"{",2,999)  ; add stamp time to start of data
 .; merge into "HMPF" subscript
 .M ^TMP("HMPF",$J,HMPFCNT,1)=^TMP("HMP",$J,HMPSUB,1)
 ;
 ; Build and add syncStatus
 S STS("uid")="urn:va:syncStatus:"_HMPVAR("DATETIME"),STS("initialized")="true"
 S STS("domainTotals",HMPVAR("DOMAIN"))=1
 D ENCODE^HMPJSON("STS","STSJSON","JSNERR")
 I $D(JSNERR) S $EC=",JSON encode error in routine "_$T(+0)_"," Q
 S HMPFCNT=HMPFCNT+1
 M ^TMP("HMPF",$J,HMPFCNT)=STSJSON
 S ^TMP("HMPF",$J,HMPFCNT,.3)=$$WRAP("syncStatus",$$PIDS^HMPDJFS(DFN),1,1)
 ;
 Q
 ;
WRAP(DOMAIN,PIDS,OFFSET,DOMSIZE) ; function, JSON wrapper
 N X S X=""
 S:$G(DOMAIN)'="syncStart" X="},{""collection"":"""_$P(DOMAIN,"#")_$C(34)_PIDS
 S X=X_","
 S:$G(OFFSET)>-1 X=X_"""seq"":"_OFFSET_","
 S:$G(DOMSIZE)>-1 X=X_"""total"":"_DOMSIZE_","
 S:$G(OFFSET)>-1 X=X_"""object"":"
 Q X
 ;
