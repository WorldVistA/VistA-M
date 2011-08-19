MPIF002 ;CIOFOSF/CMC-UTILITY ROUTINE OF APIS ;JUL 12, 1996
 ;;1.0; MASTER PATIENT INDEX VISTA ;**20,27,33,43,52**;30 Apr 99;Build 7
 ;
 ;Integration Agreements Utilized:
 ;  ^DPT( - #2070
 ;
GETICNH(DFN,ICNHA) ;Return all ICNs (including checksum) in ICN History for patient DFN
 ; DFN = IEN of patient in the Patient (#2) file
 ; ICNHA - array where ICN History will be returned.
 N IEN,ICN,CNT,RET
 I '$D(^DPT(DFN)) S ICNHA="-1^NO SUCH DFN" Q
 I '$D(^DPT(DFN,"MPIFHIS")) S ICNHA="-1^NO ICN HISTORY" Q
 S (IEN,CNT)=0,RET=""
 F  S IEN=$O(^DPT(DFN,"MPIFHIS",IEN)) Q:IEN=""  D
 .S ICN=$P($G(^DPT(DFN,"MPIFHIS",IEN,0)),"^")_"V"_$P($G(^DPT(DFN,"MPIFHIS",IEN,0)),"^",2)
 .I ICN'="" S CNT=CNT+1,ICNHA(CNT)=""""_ICN_""""
 I CNT=0 S ICNHA="-1^NO ICN HISTORY" Q
 S ICNHA=CNT
 Q
GETCMORH(DFN,CMORHA) ;Return all CMORs in CMOR History for patient DFN
 ; DFN = IEN of patient in the Patient (#2) file
 ; CMORHA - array where CMOR history will be returned
 N IEN,CMOR,CNT,RET
 I '$D(^DPT(DFN)) S CMORHA="-1^NO SUCH DFN" Q
 I '$D(^DPT(DFN,"MPICMOR")) S CMORHA="-1^NO CMOR HISTORY" Q
 S (IEN,CNT)=0,RET=""
 F  S IEN=$O(^DPT(DFN,"MPICMOR",IEN)) Q:IEN=""  D
 .S CMOR=$P($G(^DPT(DFN,"MPICMOR",IEN,0)),"^")
 .I CMOR'="" S CMOR=$P($$NNT^XUAF4(CMOR),"^",2)
 .I CMOR'="" S CNT=CNT+1,CMORHA(CNT)=""""_CMOR_""""
 I CNT=0 S CMORHA="-1^NO CMOR HISTORY" Q
 S CMORHA=CNT
 Q
GETDFNS(SSN) ; Find DFN for a given SSN - all if there are more than one
 ; SSN - SSN for patient attempted to be found in the Patient file (#2)
 ; Return - list of DFNs or -1^error msg
 N DFN,LIST,CNT,NODE
 I '$D(^DPT("SSN",SSN)) Q "-1^No such SSN"
 S (DFN,LIST)="",CNT=0
 F  S DFN=$O(^DPT("SSN",SSN,DFN)) Q:DFN=""  D
 .I $D(^DPT(DFN)) D
 ..S LIST=LIST_DFN_"^",CNT=CNT+1
 ..S NODE=$$MPINODE^MPIFAPI(DFN),ICN=$P($G(^DPT(DFN,"MPI")),"^")
 ..I ICN'="",'$D(^DPT("AICN",ICN,DFN)) S ^DPT("AICN",ICN,DFN)=""
 ..; check if missing AICN x-ref and set if missing
 I CNT=0 Q "-1^No such SSN"
 Q LIST
GETICNS(SSN) ; Find all ICNs for a given SSN -- all if there are more than one
 ; patient with that SSN
 ; SSN - SSN for patient attempted to be found in the Patient file (#2)
 ; Returned is a list of ICNs for this SSN
 N XX,DFNS,DFN,LIST,ICN,NODE
 S LIST=""
 I $G(SSN)'="" S DFNS=$$GETDFNS(SSN)
 I +DFNS=-1 Q DFNS
 F XX=1:1 S DFN=$P(DFNS,"^",XX) Q:DFN=""  D
 .S ICN=$$GETICN^MPIF001(DFN)
 .I +ICN>0 S LIST=LIST_ICN_"^"
 .I +ICN<0 S NODE=$$MPINODE^MPIFAPI(DFN),ICN=$P(NODE,"^") I ICN'="",'$D(^DPT("AICN",ICN,DFN)) S ^DPT("AICN",ICN,DFN)=""
 Q LIST
TWODFNS(DFN1,DFN2,ICN) ;Logging Exceptions when there are two DFNs trying to have the same ICN, which isn't allowed.
 N ARR1,ARR2,NAME1,NAME2,SSN1,SSN2,TEXT
 I $G(DFN1)=""!($G(DFN2)="") Q
 I '$D(^DPT(DFN1))!('$D(^DPT(DFN2))) Q
 D GETDATA^MPIFQ0("^DPT(",DFN1,"MPIFD1",".01;.09","EI")
 S NAME1=$G(MPIFD1(2,DFN1,.01,"E")),SSN1=$G(MPIFD1(2,DFN1,.09,"E"))
 D GETDATA^MPIFQ0("^DPT(",DFN2,"MPIFD2",".01;.09","EI")
 S NAME2=$G(MPIFD2(2,DFN2,.01,"E")),SSN2=$G(MPIFD2(2,DFN2,.09,"E"))
 D ADD^XDRDADDS(.XDRSLT1,2,DFN1,DFN2)
 ;** 52 replace CIRN exception logging and notification with the creation of Local POTENTIAL DUP MERGE with status of UNVERIFIED
 K MPIFD1,MPIFD2
 Q
CLEAN(DFN,ARR,MPIRETN) ; clean up MPI data from DPT for "stub" records
 ; called from UPDATE^MPIFAPI
 N ICN,CMOR
 S ICN=+$$GETICN^MPIF001(DFN),CMOR=$$SITE^VASITE()
 I +ICN<0 S MPIRETN="-1^PT HAS NO ICN" Q
 I $E(ICN,1,3)'=$P(CMOR,"^",3) S MPIRETN="-1^not a local ICN not cleaned up" Q
 S CMOR=$P(CMOR,"^",1)
 S ^DPT(DFN,"MPI")=""
 K ^DPT("AICNL",1,ICN),^DPT("AICN",ICN),^DPT("ACMOR",CMOR,DFN)
 S MPIRETN=0
 Q
 ;**43 COMPARE AND MIMDQ ADDED in patch 43
COMPARE(DFN,INDEX,COMMON,MORE) ; Checking if TFs in common between CURRENT PT (DFN)
 ; and ^TMP("MPIFVQQ",$J,INDEX,"TF",ien) OR if patient is shared to exclude those with TYPE of OTHER
 ; INDEX is the selection entry
 ; COMMON is the value returned indicating if there are TFs in common
 N ARR,IEN,ST,TYPE S (MORE,COMMON)=0
 D TFL^VAFCTFU1(.ARR,DFN)
 S IEN=0 F  S IEN=$O(ARR(IEN)) Q:IEN=""!(IEN="ST#")  S ARR("ST#",$P(ARR(IEN),"^"))=$$GET1^DIQ(4,$$IEN^XUAF4($P(ARR(IEN),"^"))_",",13,"E")
 S IEN=0 F  S IEN=$O(ARR("ST#",IEN)) Q:IEN=""  D
 .Q:IEN=$P($$SITE^VASITE(),"^",3)!(IEN=200)
 .I $G(ARR("ST#",IEN))'="OTHER" S MORE=1
 S IEN=0
 F  S IEN=$O(^TMP("MPIFVQQ",$J,INDEX,"TF",IEN)) Q:IEN=""!(COMMON)  D
 .S ST=$P(^TMP("MPIFVQQ",$J,INDEX,"TF",IEN),"^")
 .Q:ST=200
 .I $D(ARR("ST#",ST)) I $P($G(ARR("ST#",ST)),"^")'="OTHER" S COMMON=1
 Q
MIMDQ(ICN,ICN2,DFN,MSG) ; while reviewing potential duplicates, site picked to link 2 patients together with TFs in common
 ; send exception to IMDQ team
 D START^RGHLLOG()
 D EXC^RGHLLOG(208,MSG,DFN)
 D STOP^RGHLLOG()
 W !,"Unable to match these ICNs together as"_$P(MSG,"-",2)
 W !,"Exception has been sent to IMDQ team for assistance in resolving this",!,"MPI Duplicate. Local Exception has been automatically marked as processed."
 Q
 Q
