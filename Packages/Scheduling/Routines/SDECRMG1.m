SDECRMG1 ;ALB/SAT - VISTA SCHEDULING RPCS ;APR 08, 2016
 ;;5.3;Scheduling;**627,642**;Aug 13, 1993;Build 23
 ;
 ; The following entry point causes the ^XTMP("SDEC","IDX" global
 ; to be rebuilt based on the scheduling of the SDEC BUILD IDX option.
WAIT(SDCY,MAXREC,DFN,SDBEG,SDEND,CLINIC,PRI,SVCCONN,SVCCON,ORIGDT,DESDT,DESDTR,PRIGRP,SORT,PTS,SDMAX,URG,SDSVC,SDLASTE,ORIGDTR,SDCNT,MGIENS,SDALL)  ;EP
 ;Key stored in 56th piece
 ;SVCCONNP - 37th piece
 ;Desired DATE - 24th piece
 ;Origination Date - ORIGDT - 8th piece
 ;Priority Group - 33th piece
 ;IEN in 7th piece
 Q:+URG   ;only check consults if urgency filter passed in
 N LP,NOD,GBL,DLM,TYP,SDCF,SDI,X
 N RET,WLIEN1,LASTSUB
 S SDCF=1
 I +CLINIC S SDCF=0 D
 .S SDI="" F  S SDI=$O(CLINIC(SDI)) Q:SDI=""  D  Q:SDCF=1
 ..S:$O(^SDWL(409.32,"B",SDI,0)) SDCF=1
 Q:'+SDCF
 S SDMAX=$G(SDMAX,50)
 S GBL="~SDWL(409.3,"
 S DLM="|",TYP="E",LASTSUB=""
 S WLIEN1=$G(WLIEN1),MAXREC=$G(MAXREC),SDBEG=$G(SDBEG),SDEND=$G(SDEND),DFN=$G(DFN),CLINIC=$G(CLINIC)
 S:SDBEG="" SDBEG=1000101
 S:SDEND="" SDEND=$S(DFN'="":9991231,1:$$FMADD^XLFDT($$NOW^XLFDT,-90))
 S SVCCONN=$G(SVCCONN)
 S SVCCON=$G(SVCCON)
 S SDSVC=$G(SDSVC)
 S SDLASTE=$G(SDLASTE)
 F  D  Q:SDLASTE=""  Q:SDCNT'<SDMAX
 .D WLGET^SDEC(.RET,WLIEN1,SDMAX-SDCNT,SDBEG,SDEND,DFN,SDLASTE,+$D(SORT("B","ETOPD")))
 .S X=$O(@RET@(9999999),-1) S NOD=@RET@(X) S SDLASTE=$P(NOD,U,56)
 .I 'X S SDLASTE="" Q
 .S LP=0 F  S LP=$O(@RET@(LP)) Q:LP=""  D  Q:SDCNT'<SDMAX
 ..S NOD=@RET@(LP)
 ..Q:$D(MGIENS("E"_$P(NOD,U,7)))
 ..D WAIT1(MAXREC,DFN,SDBEG,SDEND,.CLINIC,.PRI,SVCCONN,SVCCON,.ORIGDT,.DESDT,DESDTR,PRIGRP,.SORT,.PTS,SDMAX,.URG,.SDSVC,.SDLASTA,.ORIGDTR,.SDCNT,NOD)
 Q
WAIT1(MAXREC,DFN,SDBEG,SDEND,CLINIC,PRI,SVCCONN,SVCCON,ORIGDT,DESDT,DESDTR,PRIGRP,SORT,PTS,SDMAX,URG,SDSVC,SDLASTA,ORIGDTR,SDCNT,NOD,MGIENS,SDALL) ;get/check/process 1 entry
 N CLGP,DDTE,DESGP,IEN,ODTE,ORIGGP,PGRP,PT,SCPRI,SORTSTR,SVCP,SVCPINV,TYP,WAITD
 S TYP="E"
 S PGRP=$P(NOD,U,33)   ;compare to ENROLLMENT PRIORITY 28 instead of Patient's Priority Group in 33
 S PT=$P(NOD,U,1)
 I PTS'="",PT'="",$D(PTS(PT))=0 Q             ;No match on patients
 I PGRP="" S PGRP="GROUP 0"
 I PRIGRP=1,$D(PRI(PGRP))=0 Q                 ;No match on priority group
 S CLGP=$P(NOD,U,16) ;I CLGP'="" S CLGP=$$GET1^DIQ(409.32,CLGP_",",.01,"I")
 I +CLINIC,CLGP="" Q
 I +CLINIC,CLGP'="",$D(CLINIC(CLGP))=0 Q       ;match clinic filter
 I CLGP'="",$$GET1^DIQ(44,CLGP_",",50.01,"I")=1 Q  ;do not return if OOS? is yes
 S DESGP=$P(NOD,U,24)
 I DESDT'="",DESGP'="",$D(DESDT(DESGP))=0 Q      ;match date of request with desired date
 I DESDTR'="",DESGP'="",(DESGP<$P(DESDTR,"~",1))!(DESGP>$P(DESDTR,"~",2)) Q  ;match date of request with range of desired dates
 S ORIGGP=$P(NOD,U,8)
 I ORIGDTR'="",ORIGGP'="",(ORIGGP<$P(ORIGDTR,"~",1))!(ORIGGP>$P(ORIGDTR,"~",2)) Q  ;match origination date range with file entry date
 I ORIGDT'="",ORIGGP'="",$D(ORIGDT(ORIGGP))=0 Q             ;match origination date with file entry date
 S IEN=$P(NOD,U,7)
 S SVCP=$P(NOD,U,37)
 S SVCPINV=100-SVCP
 I SVCCONN'="",SVCCONN'="BOTH" Q:(SVCCONN="NO")&($P(NOD,U,36)="")  Q:SVCCONN'=$P(NOD,U,36)   ;SCVisit for filter (patient)
 ;S SCPRI=$S($P(NOD,U,36)="YES":0,1:1)                                                        ;SCVisit for sorting
 S SCPRI=$P(NOD,U,26)="YES"
 I SVCCON'="",SVCCON'="BOTH" Q:(SVCCON="NO")&($P(NOD,U,44)="")  Q:SVCCON'=$P(NOD,U,44)       ;SERVICERELATED for filter (request)
 I +SDSVC Q:$P(NOD,U,15)=""  Q:'$D(SDSVC($P(NOD,U,15)))             ;Service/Clinic Stop
 S WAITD=$$FMDIFF^XLFDT($P($$NOW^XLFDT,".",1),$$CVTDT($P(NOD,U,8)))
 S WAITD=9999999-WAITD                          ;Wait days for sorting
 S ODTE=$P($$CVTDT($P(NOD,U,8)),".")   ;Origination date for sorting
 S DDTE=$P($$CVTDT($P(NOD,U,24)),".")  ;Desired date for sorting
 ;S SORTSTR=$$SORT(.SORT)
 S SORTSTR=$$SORT(.SORT,IEN,WAITD,TYP,PT,SVCPINV,PGRP,CLGP,DDTE,ODTE,SCPRI,.MGIENS)
 D SETNODE(WAITD,TYP,IEN,NOD,56,SORTSTR,.SDCNT)
 ;S SDCNT=SDCNT+1
 Q
APPT(SDECY,MAXREC,DFN,SDBEG,SDEND,CLINIC,PRI,SVCCONN,SVCCON,ORIGDT,DESDT,DESDTR,PRIGRP,SORT,PTS,SDMAX,URG,SDSVC,SDLASTA,ORIGDTR,SDCNT,MGIENS,SDALL)  ; EP get data from appt request file
  Q:'$$TEST("ARGET^SDECAR1")
  Q:+URG   ;only check consults if urgency filter passed in
 ;Key stored in 56th piece
 ;SVCCONNP - 30th piece
 ;Desired DATE - 20th piece
 ;Origination Date - ORIGDT - 8th piece
 ;Priority Group - 26th piece
 ;IEN in 7th piece
 N LP,NOD,GBL,DLM,TYP,X
 N RET,LASTSUB
 S SDMAX=$G(SDMAX,50)
 S SVCCONN=$G(SVCCONN)
 S SVCCON=$G(SVCCON)
 S SDSVC=$G(SDSVC)
 S LASTSUB=""
 S DLM="|",TYP="A"
 S GBL="~SDEC(409.85,"
 S MAXREC=$G(MAXREC),SDBEG=$G(SDBEG),SDEND=$G(SDEND),DFN=$G(DFN),CLINIC=$G(CLINIC)
 S:SDBEG="" SDBEG=1000101
 S:SDEND="" SDEND=$S(DFN'="":9991231,1:$$FMADD^XLFDT($$NOW^XLFDT,-90))
 S SDLASTA=$G(SDLASTA)
 F  D  Q:SDLASTA=""  Q:SDCNT'<SDMAX   ;we throw some records out based on filters; continue until there are SDMAX records
 .D ARGET^SDEC(.RET,,SDMAX-SDCNT,SDBEG,SDEND,DFN,SDLASTA)
 .S X=$O(@RET@(9999999),-1) S NOD=@RET@(X) S SDLASTA=$P(NOD,U,56)  ;get LASTSUB
 .I 'X S SDLASTA="" Q
 .S LP=0 F  S LP=$O(@RET@(LP)) Q:LP=""  D  Q:SDCNT'<SDMAX
 ..S NOD=@RET@(LP)
 ..Q:$D(MGIENS("A"_$P(NOD,U,7)))
 ..D APPT1(MAXREC,DFN,SDBEG,SDEND,.CLINIC,.PRI,SVCCONN,SVCCON,.ORIGDT,.DESDT,DESDTR,PRIGRP,.SORT,.PTS,SDMAX,.URG,.SDSVC,.SDLASTA,.ORIGDTR,.SDCNT,NOD)
 Q
APPT1(MAXREC,DFN,SDBEG,SDEND,CLINIC,PRI,SVCCONN,SVCCON,ORIGDT,DESDT,DESDTR,PRIGRP,SORT,PTS,SDMAX,URG,SDSVC,SDLASTA,ORIGDTR,SDCNT,NOD,MGIENS) ;get/check/process 1 entry
 N CLGP,DDTE,DESGP,IEN,ODTE,ORIGGP,PGRP,PT,SCPRI,SORTSTR,SVCP,SVCPINV,TYP,WAITD
 S TYP="A"
 S PGRP=$P(NOD,U,26)   ;compare to ENROLLMENT PRIORITY 22 instead of Patient's Priority Group in 26
 I PGRP="" S PGRP="GROUP 0"              ;Priority Grp
 S PT=$P(NOD,U,1)                        ;Patient
 I PTS'="",PT'="",$D(PTS(PT))=0 Q         ;match clinic
 I PRIGRP=1,$D(PRI(PGRP))=0 Q          ;No match on priority group
 S CLGP=$P(NOD,U,12)
 I +CLINIC,$D(CLINIC(+CLGP))=0 Q         ;match clinic
 I CLGP'="",$$GET1^DIQ(44,CLGP_",",50.01,"I")=1 Q  ;do not return if OOS? is yes
 S DESGP=$P(NOD,U,20)
 I DESDT'="",DESGP'="",$D(DESDT(DESGP))=0 Q      ;match date of request with desired date
 I DESDTR'="",DESGP'="",(DESGP<$P(DESDTR,"~",1))!(DESGP>$P(DESDTR,"~",2)) Q  ;match date of request with range of desired dates
 S ORIGGP=$P(NOD,U,8)
 I ORIGGP'="",(ORIGGP>SDEND)!(ORIGGP<SDBEG) Q
 I ORIGDTR'="",ORIGGP'="",(ORIGGP<$P(ORIGDTR,"~",1))!(ORIGGP>$P(ORIGDTR,"~",2)) Q  ;match origination date range with file entry date
 I ORIGDT'="",ORIGGP'="",$D(ORIGDT(ORIGGP))=0 Q             ;match origination date with file entry date
 S IEN=$P(NOD,U,7)
 S SVCP=$P(NOD,U,30)
 S SVCPINV=100-SVCP
 I SVCCONN'="",SVCCONN'="BOTH" Q:(SVCCONN="NO")&($P(NOD,U,29)="")  Q:SVCCONN'=$P(NOD,U,29)       ;SCVisit for filter (patient)
 ;S SCPRI=$S($P(NOD,U,36)="YES":0,1:1)            ;SCVisit for sorting
 I SVCCON'="",SVCCON'="BOTH" Q:(SVCCON="NO")&($P(NOD,U,37)="")  Q:SVCCON'=$P(NOD,U,37)           ;SERVICERELATED for filter (request)
 S SCPRI=1                                       ;SCVisit for sorting
 I +SDSVC Q:$P(NOD,U,58)=""  Q:'$D(SDSVC($P(NOD,U,58)))             ;Service/Clinic Stop
 S WAITD=$$FMDIFF^XLFDT($P($$NOW^XLFDT,".",1),$P(NOD,U,8))
 S WAITD=9999999-WAITD
 S ODTE=$P($$CVTDT($P(NOD,U,8)),".")
 S DDTE=$P($$CVTDT($P(NOD,U,20)),".")
 ;S SORTSTR=$$SORT(.SORT)
 S SORTSTR=$$SORT(.SORT,IEN,WAITD,TYP,PT,SVCPINV,PGRP,CLGP,DDTE,ODTE,SCPRI,.MGIENS)
 D SETNODE(WAITD,TYP,IEN,NOD,56,SORTSTR,.SDCNT)
 ;S SDCNT=SDCNT+1
 Q
 ;
 ;Return recall list
RECALL(RET,MAXREC,DFN,SDBEG,SDEND,CLINIC,PRI,SVCCONN,SVCCON,ORIGDT,DESDT,DESDTR,PRIGRP,SORT,PTS,SDMAX,URG,SDSVC,SDLASTR,ORIGDTR,SDCNT,MGIENS,SDALL) ;EP
 Q:'$$TEST("RECGET^SDEC52")
 Q:+URG   ;only check consults if urgency filter passed in
 ;Key stored in 42nd piece
 ;SVCCONNP - 29th piece
 ;Desired DATE - 19th piece - External format
 ;Origination Date - ORIGDT - 32nd piece
 ;Priority Group - 25th piece
 ;IEN - 1st piece
 N LP,NOD,GBL,SVCP,PG,DD,OD,DLM,TYP,PT,SORTSTR,SVCP,SCPRI,ORIGGP
 N CLGP,IEN,PGRP,SDECY,SVCP,SVCPINV,LASTSUB,ODTE,DDTE,WAITD,X
 Q:$G(SVCCON)'=""   ;only SD WAIT LIST and SDEC APPT REQUEST have this value
 S SDSVC=$G(SDSVC)
 S SDMAX=$G(SDMAX,50)
 S GBL="~SD(403.5,"
 S DLM="|",TYP="R",LASTSUB=""
 S DFN=$G(DFN),SDBEG=$G(SDBEG),SDEND=$G(SDEND),MAXREC=$G(MAXREC),SDLASTR=$G(SDLASTR),CLINIC=$G(CLINIC)
 F  D  Q:SDLASTR=""  Q:SDCNT'<SDMAX   ;we throw some records out based on filters; continue until there are SDMAX records
 .D RECGET^SDEC(.SDECY,DFN,SDBEG,SDEND,SDMAX-SDCNT,SDLASTR)
 .S X=$O(@SDECY@(9999999),-1) S NOD=@SDECY@(X) S SDLASTR=$P(NOD,U,42)  ;get LASTSUB  ;alb/sat 642 change 56 to 42
 .I 'X S SDLASTR="" Q
 .S LP=0 F  S LP=$O(@SDECY@(LP)) Q:LP=""  D
 ..S NOD=@SDECY@(LP)
 ..S SVCP=$P(NOD,U,29)                             ;Service connected percentage
 ..S SVCPINV=100-SVCP
 ..S PGRP=$P(NOD,U,25)
 ..S PT=$P(NOD,U,2)                                ;Patient
 ..I PTS'="",PT'="",$D(PTS(PT))=0 Q
 ..I PGRP="" S PGRP="GROUP 0"                      ;Priority Grp
 ..I PRIGRP'="",$D(PRI(PGRP))=0 Q                 ;No match on priority group
 ..S CLGP=$P(NOD,U,16)
 ..I +CLINIC,CLGP'="",$D(CLINIC(CLGP))=0 Q                 ;match clinic
 ..I CLGP'="",$$GET1^DIQ(44,CLGP_",",50.01,"I")=1 Q  ;do not return if OOS? is yes
 ..I +SDSVC N SDSVCN S SDSVCN=$$GET1^DIQ(44,+$P(NOD,U,16)_",",8,"E") Q:SDSVCN=""  Q:'$D(SDSVC(SDSVCN))   ;check service
 ..S DESGP=$P(NOD,U,19)
 ..I DESDT'="",DESGP'="",$D(DESDT(DESGP))=0 Q      ;match date of request with desired date
 ..I DESDTR'="",DESGP'="",(DESGP<$P(DESDTR,"~",1))!(DESGP>$P(DESDTR,"~",2)) Q  ;match date of request with range of desired dates
 ..S ORIGGP=$P(NOD,U,32)
 ..I ORIGDTR'="",ORIGGP'="",(ORIGGP<$P(ORIGDTR,"~",1))!(ORIGGP>$P(ORIGDTR,"~",2)) Q  ;match origination date range with file entry date
 ..I ORIGDT'="",ORIGGP'="",$D(ORIGDT(ORIGGP))=0 Q             ;match origination date with file entry date
 ..S IEN=$P(NOD,U,1)
 ..I SVCCONN'="",SVCCONN'="BOTH" Q:(SVCCONN="NO")&($P(NOD,U,28)="")  Q:SVCCONN'=$P(NOD,U,28)           ;SCVisit for filter (patient)
 ..S SCPRI=0                               ;SCVisit for sorting
 ..S WAITD=$$FMDIFF^XLFDT($P($$NOW^XLFDT,".",1),$$CVTDT($P(NOD,U,19)))
 ..S WAITD=9999999-WAITD
 ..S ODTE=$P($$CVTDT($P(NOD,U,32)),".")
 ..S DDTE=$P($$CVTDT($P(NOD,U,19)),".")
 ..;S SORTSTR=$$SORT(.SORT)
 ..S SORTSTR=$$SORT(.SORT,IEN,WAITD,TYP,PT,SVCPINV,PGRP,CLGP,DDTE,ODTE,SCPRI)
 ..D SETNODE(WAITD,TYP,IEN,NOD,42,SORTSTR,.SDCNT)
 ..;S SDCNT=SDCNT+1
 Q
 ;
SETNODE(S1,S2,S3,VAL,KEYP,SLIST,CNT) ;EP-
 ;  S1    =Wait Days
 ;  S2    =Request Type - A C E R
 ;  S3    =Request Type IEN
 ;  VAL   = Request Type data from rpc call
 ;  KEYP  = Storage piece number where LASTSUB is stored
 ;  SLIST = Sort String from $$SORT
 Q:'$L($D(S1))!'$L($D(S2))!'$L($D(S3))
 N KEY,DLM
 S DLM="|"
 Q:$D(^TMP("SDECIDX",$J,"XREF-ID",S2_DLM_S3))  ;quit if duplicate
 ;S KEY=9999999-S1_DLM_S2_DLM_S3_DLM_SLIST
 S KEY=SLIST_DLM_S3
 S CNT=$G(CNT)+1
 S VAL=$P(VAL,$C(30))
 S:$G(KEYP) $P(VAL,U,KEYP)=KEY
 S ^TMP("SDECIDX",$J,"DATA",CNT)=$G(VAL)
 S ^TMP("SDECIDX",$J,"XREF",KEY)=S2_U_S3_U_KEY
 S ^TMP("SDECIDX",$J,"COUNT")=CNT
 S ^TMP("SDECIDX",$J,"XREF-ID",S2_DLM_S3)=""
 Q
 ;
SETNODEP(GBL,VAL) ;EP-
 Q:'$L($D(GBL))
 S ^XTMP("SDEC","IDX","PATTERNS",GBL)=$P($G(VAL),$C(30))
 Q
 ;
PC(VAL,PIECE,DLM) ;EP-
 S DLM=$G(DLM,U)
 Q $P($G(VAL),DLM,+$G(PIECE))
 ;
 ;SORT(SORT)   ;Sort out the variables
SORT(SORT,IEN,WAITD,TYP,PT,SVCPINV,PGRP,CLGP,DDTE,ODTE,SCPRI,MGIENS) ;
 N SOR,SCNT,SD,STRING,DLM,STR
 N STCNT,STID,STJ,STTYP
 S SCNT=0,(STR,STRING)="",DLM="|"
 I $D(MGIENS(TYP_IEN)) S STRING="0|0|0"
 S SOR=""  F  S SOR=$O(SORT(SOR)) Q:SOR'>0  D
 .S SCNT=SCNT+1
 .S SD=$G(SORT(SOR))
 .S STR=""
 .;I SD?1A1.N.A D
 .;.S STCNT=-1
 .;.S STTYP=$E(SD,1),SD=$E(SD,2,$L(SD))
 .;.F STJ=1:1:$L(SD,"~") D
 .;..S STID=$P(SD,"~",STJ)
 .;..Q:TYP'=STTYP
 .;..Q:STID'=IEN
 .;..S STCNT=STCNT+1 S STR="0|"_STCNT
 .S STR=$S(SD="RTOPD":$S(TYP="R":0,1:1),SD="ATOPD":$S(TYP="A":0,1:1),SD="ETOPD":$S(TYP="E":0,1:1),SD="CTOPD":$S(TYP="C":0,1:1),1:"")
 .S:STR=0 STR=STR_"|"_$$PAD(999999999-IEN)
 .I SD="PRIORITYGROUP" D
 ..S STR=$S(PGRP="GROUP 0":0,PGRP="GROUP 1":1,PGRP="GROUP 2":2,PGRP="GROUP 3":3,PGRP="GROUP 4":4,PGRP="GROUP 5":5,PGRP="GROUP 6":6,PGRP="GROUP 7":7,PGRP="GROUP 8":8,1:0)
 ..S STR=STR_DLM_0
 ..;I +SCPRI S STR=$S(STR=0:0,1:1)_DLM_0
 ..;E  S STR=STR_DLM_1
 .S:STR="" STR=$S(SD="WAITTIME":WAITD,SD="REQUESTTYPE":TYP,SD="PATIENTNAME":PT,SD="SCVISIT":SVCPINV,SD="CLINICS":CLGP,SD="DESIREDDATE":DDTE,SD="ORIGINATIONDATE":ODTE,1:"")
 .I SD="PATIENTNAME" S STR=$$GET1^DIQ(2,PT_",",.01)
 .I SD="CLINICS" S STR=$$GET1^DIQ(44,CLGP_",",.01)
 .I STRING="" S STRING=STR
 .E  S STRING=STRING_DLM_STR
 Q STRING
 ;
PAD(STRING,CHAR,CNT) ;prepend characters (default is 0 zero) to STRING
 N SDI,SDR
 S STRING=$G(STRING)
 S CHAR=$G(CHAR)
 S:CHAR="" CHAR="0"
 S CNT=$G(CNT)
 S:+CNT CNT=+CNT+1
 S:'+CNT CNT=10   ;(9 characters)
 S $P(SDR,CHAR,CNT-$L(STRING))=STRING
 Q SDR
 ; Test for tag/routine
TEST(X) ;EP
 N Z
 S:X[U Z=$P(X,U),X=$P(X,U,2)
 Q:'$L(X)!(X'?.1"%"1.AN) 0
 X ^%ZOSF("TEST")
 Q $S('$T:0,$G(Z)="":1,Z'?.1"%"1.AN:0,1:$T(@Z^@X)'="")
 ;
TMPGBL() ;EP-
 K ^TMP("SDECIDX",$J) Q $NA(^($J))
 ; Convert external dates to FileMan format
CVTDT(VAL) ;EP-
 D DT^DILF(,VAL,.VAL)
 Q VAL
 ; Returns inverse date value
INVDT(VAL) ;EP-
 Q:(VAL<1) VAL
 Q (9999999.9999-VAL)
RECCNT(DATA) ;EP-
 S DATA=$G(^TMP("SDECIDX",$J,"COUNT"))
 Q
