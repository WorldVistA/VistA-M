DGRRLU1A ;alb/aas,BPFO/MM DG Replacement and Rehosting RPC for VADPT (cont) - ;11/12/2003
 ;;5.3;Registration;**538**;Aug 13, 1993
 ;
 ;Continued from DGRRLU1
 ;
10 ; -- means test required, get current means test status and MAS Parameter display of notification
 ;    if (paramater && last means test indicator == "r") display message
 N DGMTLST,DIVRULE,DIVTXT,DGMSGF,DGMFLG,X,DGDOM,DGDOM1
 S DIVRULE="false"
 I $P($G(^DG(40.8,+$O(^DG(40.8,"AD",+$G(DIV),0)),"MT")),"^")="Y" S DIVRULE="true"
 S DGMSGF=1
 S DGMTLST=$$CMTS^DGMTU(DFN)
 S DGMFLG=$$MFLG^DGMTU(DGMTLST)
 ;S DGMTDATE=$P($G(^DGMT(408.31,+DGMTLST,0)),U)
 S DIVTXT=$P($G(^DG(40.8,+$O(^DG(40.8,"AD",+$G(DIV),0)),"MT")),"^",2)
 S X="  <businessRule alertId='meansTestRequired' lastMeansTestDate='"_$$CHARCHK^DGRRUTL($P(DGMTLST,"^",2))
 S X=X_"' lastMeansTestIndicator='"_$$CHARCHK^DGRRUTL($P(DGMTLST,"^",3))_"' masDivisionRule='"_$$CHARCHK^DGRRUTL(DIVRULE)_"' text='"_$$CHARCHK^DGRRUTL(DIVTXT)
 S X=X_"' addTxt='"_$$CHARCHK^DGRRUTL(DGMFLG)_"'></businessRule>"
 DO ADD^DGRRLU(X)
 ;
11 ; -- legacy data for patient, check to see if patient on M data base merged into current M database
 ; Beginning with release 4, the legacy alert will always return false.
 ; Alert no longer displayed.  It  will be removed in a future release. 
 DO ADD^DGRRLU("  <businessRule alertId='legacyDataExists' checkValue='"_$$CHARCHK^DGRRUTL("false")_"' facility=''></businessRule>")
 ;
12 ; -- fugitive felon -- to be released soon.
 NEW FUGITIVE
 SET FUGITIVE="false"
 IF $D(^DPT("AXFFP",1,DFN)) SET FUGITIVE="true"
 DO ADD^DGRRLU("  <businessRule alertId='fugitiveFelon' fugitiveStatus='"_$$CHARCHK^DGRRUTL(FUGITIVE)_"'></businessRule>")
 ;
13 ; -- patient record flag
 N DGPFFLGS,DGPFFLG,DGRRNFLG
 S DGRRNFLG=0
 S DGPFFLG=""
 IF +$G(PARAMS("PATIENT_RECORD_FLAG")) DO  ; old version of patient record flag
 .I $L($T(GETACT^DGPFAPI)) S DGPFFLGS=$$GETACT^DGPFAPI(DFN,"DGPFFLGS") D
 .. I $G(DGPFFLGS)=0 Q
 .. N DGPFI
 .. S DGPFI=0
 .. F  S DGPFI=$O(DGPFFLGS(DGPFI)) Q:'DGPFI  D
 ...I DGPFI>1 S DGPFFLG=DGPFFLG_", "
 ...S DGPFFLG=DGPFFLG_$P($G(DGPFFLGS(+DGPFI,"FLAG")),U,2)
 .DO ADD^DGRRLU("  <businessRule alertId='patientRecordFlag' flag='"_$$CHARCHK^DGRRUTL(DGPFFLG)_"'></businessRule>")
 ;
 IF '+$G(PARAMS("PATIENT_RECORD_FLAG")) DO  ; new (06/17/04) version of patient record flag can be turned on with this param, the flag and the old code can be removed once the new stuff is approved
 .I '$L($T(GETACT^DGPFAPI)) S DGRRNFLG=1 D NOALRT
 .Q:DGRRNFLG=1
 .S DGPFFLGS=$$GETACT^DGPFAPI(DFN,"DGPFFLGS") D
 .. I $G(DGPFFLGS)=0 D NOALRT Q
 .. D ADD^DGRRLU("  <businessRule alertId='patientRecordFlag'>")
 .. N DGPFI
 .. S DGPFI=0
 .. F  S DGPFI=$O(DGPFFLGS(DGPFI)) Q:'DGPFI  D
 ...N APPRVBY,ASSIGNDT,CATEGORY,FLAG,FLAGTYPE,ORIGSITE,OWNER,REVDT,LINE
 ...S APPRVBY=$$CHARCHK^DGRRUTL($P($G(DGPFFLGS(DGPFI,"APPRVBY")),U,2))
 ...S ASSIGNDT=$P($P($G(DGPFFLGS(DGPFI,"ASSIGNDT")),U),".")
 ...S FLAG=$$CHARCHK^DGRRUTL($P($G(DGPFFLGS(DGPFI,"FLAG")),U,2))
 ...S FLAGTYPE=$$CHARCHK^DGRRUTL($P($G(DGPFFLGS(DGPFI,"FLAGTYPE")),U,2))
 ...S ORIGSITE=$$CHARCHK^DGRRUTL($P($G(DGPFFLGS(DGPFI,"ORIGSITE")),U,2))
 ...S OWNER=$$CHARCHK^DGRRUTL($P($G(DGPFFLGS(DGPFI,"OWNER")),U,2))
 ...S REVDT=$P($G(DGPFFLGS(DGPFI,"REVIEWDT")),U)
 ...S LINE="  <flag flagNumber='"_DGPFI_"' flag='"_FLAG_"' category='"_FLAGTYPE_"' type='"_FLAGTYPE_"' assigndt='"_ASSIGNDT_"' apprvBy='"_APPRVBY_"' revDate='"_REVDT
 ...S LINE=LINE_"' ownerSite='"_OWNER_"' origSite='"_ORIGSITE_"'>"
 ...D ADD^DGRRLU(LINE)
 ...D ADD^DGRRLU("  <narrations>")
 ...N DGRRNI
 ...S DGRRNI=0
 ...F  S DGRRNI=$O(DGPFFLGS(DGPFI,"NARR",DGRRNI)) Q:'DGRRNI  D
 ....N DGRRNL
 ....S DGRRNL=$G(DGPFFLGS(DGPFI,"NARR",DGRRNI,0))
 ....D ADD^DGRRLU("  <narration>"_$$CHARCHK^DGRRUTL(DGRRNL)_"</narration>")
 ...D ADD^DGRRLU("  </narrations>")
 ...D ADD^DGRRLU("  </flag>")
 ..D ADD^DGRRLU("  </businessRule>")
 ;
14 ; -- patient merged -- not a requirement
 DO ADD^DGRRLU("  <businessRule alertId='mergedPatient' recordMergedTo='"_$$CHARCHK^DGRRUTL($P($G(^DPT(DFN,0)),"^",19))_"'></businessRule>")
 ;
15 ; -- combat vet status -- being worked on by Edna Curtain.
 N CVSTATUS,CVEND,DGCV
 SET (CVSTATUS,CVEND,DGCV)=""
 I $L($T(CVEDT^DGCV)) S DGCV=$$CVEDT^DGCV(+DFN)
 I $P(DGCV,"^")=1 D
 . SET CVSTATUS=$S($P(DGCV,"^",2)>DT:"ELIGIBLE",1:"EXPIRED")
 . SET CVEND=$P(DGCV,"^",2)
 DO ADD^DGRRLU("  <businessRule alertId='combatvet' status='"_$$CHARCHK^DGRRUTL($G(CVSTATUS))_"' endDate='"_$$CHARCHK^DGRRUTL($G(CVEND))_"'></businessRule>")
16 ;Bad Address Indicator
 N DGRRBA
 S DGRRBA=$$BADADR^DGUTL3(DFN)
 DO ADD^DGRRLU("  <businessRule alertId='badAddress' indicator='"_$$CHARCHK^DGRRUTL($G(DGRRBA))_"'></businessRule>")
 ;
END QUIT
 ;
NOALRT ;Returns an empty alert for Patient Record Flag
 D ADD^DGRRLU("  <businessRule alertId='patientRecordFlag'>")
 S LINE="  <flag flagNumber='' category='' type='' assigndt='' apprvBy='' revDate='' ownerSite='' origSite=''>"
 D ADD^DGRRLU(LINE)
 D ADD^DGRRLU("  <narrations></narrations>")
 D ADD^DGRRLU("  </flag>")
 D ADD^DGRRLU("  </businessRule>")
 Q
