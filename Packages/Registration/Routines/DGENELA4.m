DGENELA4 ;ALB/CJM,KCL,RTK,LBD,EG,CKN,DLF,TDM,JLS,HM - Patient Eligibility API ;5/10/11 12:03pm
 ;;5.3;Registration;**232,275,306,327,314,367,417,437,456,491,451,564,672,659,653,688,803,754,841,909,972,952**;Aug 13,1993;Build 160
 ;
 ;
PRIORITY(DFN,DGELG,DGELGSUB,ENRDATE,APPDATE) ;
 ; Description: Used to compute the priority group and subgroup for a
 ; patient, also returning the subset of the eligibility data on which 
 ; the priority subgroup is based.
 ;
 ;Input:
 ;      DFN - ien of patient
 ;    DGELG - ELIGIBILITY object array (optional, pass by reference)
 ;  ENRDATE - The Enrollment Date. This date is used in the priority
 ;            determination only if the application date is not passed.
 ;  APPDATE - The Enrollment Application Date.  This date is used
 ;            to determine the priority. If the application date
 ;            is not passed then the enrollment date (ENRDATE) is used.
 ;
 ;Output:
 ;  Function Value - returns the priority and subgroup computed by the
 ;    function as a 2 piece string 'PRIORITY^SUBGROUP'
 ;  DGELGSUB - this local array will contain the eligibility data on
 ;    which the priority determination was based, pass by reference
 ;    if needed.
 ;
 N CODE,HICODE,PRI,HIPRI,PRIORITY,SUBGRP,HISUB,SUB,DGPAT
 K DGELGSUB S DGELGSUB=""
 S (HICODE,HIPRI,SUBGRP,HISUB)=""
 D
 .I '$D(DGELG),'$$GET^DGENELA(DFN,.DGELG) Q  ;cannot proceed with eligibility
 .; can't proceed without an Enrollment Date or Application Date
 .I '$G(ENRDATE),'$G(APPDATE) Q
 .I $$GET^DGENPTA(DFN,.DGPAT)
 .; determine priority/subgroup based on primary eligibility
 .S HICODE=$$NATCODE^DGENELA(DGELG("ELIG","CODE"))
 .S PRIORITY=$$PRI(HICODE,.DGELG,$G(ENRDATE),$G(APPDATE))
 .S HIPRI=$P(PRIORITY,"^"),HISUB=$P(PRIORITY,"^",2)
 .S CODE=""
 .;
 .; determine if other eligibilities result in higher priority/subgroup
 .F  S CODE=$O(DGELG("ELIG","CODE",CODE)) Q:('CODE!(HIPRI=1))  D
 ..S PRIORITY=$$PRI($$NATCODE^DGENELA(CODE),.DGELG,$G(ENRDATE),$G(APPDATE))
 ..S PRI=$P(PRIORITY,"^"),SUB=$P(PRIORITY,"^",2)
 ..S:((PRI>0)&((PRI<HIPRI)!(HIPRI=""))) HIPRI=PRI,HICODE=$$NATCODE^DGENELA(CODE),HISUB=SUB
 ..S:((PRI=HIPRI)&((SUB>0)&(SUB<HISUB))) HIPRI=PRI,HICODE=$$NATCODE^DGENELA(CODE),HISUB=SUB
 .;
 .;set the DGELGSUB() array with the eligibility information used in the
 .;priority determination
 .S DGELGSUB("CODE")=HICODE,DGELGSUB("SC")=DGELG("SC"),DGELGSUB("SCPER")=DGELG("SCPER"),DGELGSUB("POW")=DGELG("POW"),DGELGSUB("A&A")=DGELG("A&A"),DGELGSUB("HB")=DGELG("HB")
 .S DGELGSUB("VAPEN")=DGELG("VAPEN"),DGELGSUB("VACKAMT")=DGELG("VACKAMT"),DGELGSUB("DISRET")=DGELG("DISRET"),DGELGSUB("DISLOD")=DGELG("DISLOD")
 .S DGELGSUB("MEDICAID")=DGELG("MEDICAID"),DGELGSUB("AO")=DGELG("AO"),DGELGSUB("IR")=DGELG("IR"),DGELGSUB("EC")=DGELG("EC"),DGELGSUB("MTSTA")=DGELG("MTSTA")
 .;Purple Heart Added to DGELGSUB
 .S DGELGSUB("VCD")=DGELG("VCD"),DGELGSUB("PH")=DGELG("PH")
 .;Added for HVE Phase III (DG*5.3*564)
 .S DGELGSUB("UNEMPLOY")=DGELG("UNEMPLOY"),DGELGSUB("CVELEDT")=DGELG("CVELEDT"),DGELGSUB("SHAD")=DGELG("SHAD")
 .;added dg*5.3*659
 .S DGELGSUB("RADEXPM")=DGELG("RADEXPM")
 .S DGELGSUB("AOEXPLOC")=DGELG("AOEXPLOC")
 .S DGELGSUB("MOH")=DGELG("MOH")
 .S DGELGSUB("MOHAWRDDATE")=DGELG("MOHAWRDDATE") ;added with DG*5.3*972 HM
 .S DGELGSUB("MOHSTATDATE")=DGELG("MOHSTATDATE") ;added with DG*5.3*972 HM
 .S DGELGSUB("MOHEXEMPDATE")=DGELG("MOHEXEMPDATE") ;added with DG*5.3*972 HM
 .S DGELGSUB("CLE")=DGELG("CLE")         ;added with DG*5.3*909
 .S DGELGSUB("CLEDT")=DGELG("CLEDT")     ;added with DG*5.3*909
 .S DGELGSUB("CLEST")=DGELG("CLEST")     ;added with DG*5.3*909
 .S DGELGSUB("CLESOR")=DGELG("CLESOR")   ;added with DG*5.3*909
 .S DGELGSUB("OTHTYPE")=DGELG("OTHTYPE") ; DG*5.3*952
 .I $G(DGPAT("INELDATE"))'="" S (HIPRI,HISUB)=""
 ;
 Q HIPRI_$S(HIPRI:"^"_HISUB,1:"")
 ;
 ;
PRI(CODE,DGELG,ENRDATE,APPDATE) ;
 ; Description: Returns the priority group and subgroup based on a
 ; single eligibility code.
 ;Input -
 ;  CODE - pointer to file #8.1, MAS Eligibility Code
 ;  DGELG - local array obtained by calling $$GET, pass by reference
 ;  ENRDATE - The Enrollment Date. This date is used in the priority
 ;            determination only if the application date is not passed.
 ;  APPDATE - The Enrollment Application Date.  This date is used
 ;            to determine the priority. If the application date
 ;            is not passed then the enrollment date (ENRDATE) is used.
 ;
 ;Output -
 ;  Function Value - returns the priority and subgroup computed by the
 ;   function as a 2 piece string 'PRIORITY^SUBGROUP'
 ;
 N CODENAME,PRIORITY,MTSTA,SUBGRP,DGEGT,PRISUB,DGMTI,MTTHR,GMTTHR,STAEXP
 N NODE2,DGNCM,DGNETW,DGMEDEX,DGEDEX,DGASSTS,DGMTYR,MTTEST1,MTTEST2,DGAICM
 S SUBGRP=""
 ;
 ; use the Application Date when determining the priority, otherwise use
 ; the Enrollment Date (ESP DG*5,3*491)
 S ENRDATE=$S($G(APPDATE):APPDATE,1:$G(ENRDATE))
 ;
 ;get the name of the national eligibility code
 S CODENAME=$$CODENAME^DGENELA(CODE)
 ;
 ;get the means test code
 S MTSTA=""
 I DGELG("MTSTA") S MTSTA=$P($G(^DG(408.32,DGELG("MTSTA"),0)),"^",2)
 ;
 ;get MT and GMT thresholds
 S DGMTI=$P($$LST^DGMTU(DFN),"^")
 S MTTHR=$$GET1^DIQ(408.31,+DGMTI,.12,"I")
 S GMTTHR=$$GET1^DIQ(408.31,+DGMTI,.27,"I")
 S DGNCM=$$GET1^DIQ(408.31,+DGMTI,.04,"I")
 S DGNETW=$$GET1^DIQ(408.31,+DGMTI,.05,"I")
 D ALL^DGMTU21(DFN,"V",DT,"I",+DGMTI)
 S DGAICM=0
 S:$G(DGINC("V")) DGAICM=+DGINC("V")
 S (DGMEDEX,DGEDEX,DGASSTS)=0
 S DGMTYR=$$GET1^DIQ(408.21,+DGAICM,.01,"E")
 I $D(^DGMT(408.21,DGAICM,2))  D
 .S NODE2=^DGMT(408.21,DGAICM,2)
 .S DGASSTS=DGASSTS+$P(NODE2,U,1)+$P(NODE2,U,2)+$P(NODE2,U,3)+$P(NODE2,U,4)-$P(NODE2,U,5)
 .S DGASSTS=DGASSTS+$P(NODE2,U,6)+$P(NODE2,U,7)+$P(NODE2,U,8)+$P(NODE2,U,9)
 S:$D(^DGMT(408.21,DGAICM,1)) DGMEDEX=$P(^DGMT(408.21,DGAICM,1),"^",12)
 S:$D(^DGMT(408.21,DGAICM,1)) DGEDEX=$P(^DGMT(408.21,DGAICM,1),"^",3)
 ;
 ; get expiration dates for Special Treatment Authority
 S STAEXP("AO")=$$STAEXP^DGENELA4("AO")
 S STAEXP("EC")=$$STAEXP^DGENELA4("EC")
 ;
 ;get the Enrollment Group Threshold (EGT) setting
 S DGEGT=""
 I $$GET^DGENEGT($$FINDCUR^DGENEGT(),.DGEGT)
 I '$G(DGELG("RADEXPM")) S DGELG("RADEXPM")=""
 I '$G(DGELG("SHAD")) S DGELG("SHAD")=""
 ;
 D  ;drops out when priority determined
 .S PRIORITY=""
 .I ((DGELG("SC")="Y")&(DGELG("SCPER")>49))!(CODENAME="SERVICE CONNECTED 50% to 100%") S PRIORITY=1 Q
 .I (DGELG("SC")="Y")&(DGELG("SCPER")>0)&(DGELG("UNEMPLOY")="Y")&(DGELG("VACKAMT")>0)&(DGELG("VAPEN")'="Y")&(DGELG("A&A")'="Y")&(DGELG("HB")'="Y") S PRIORITY=1 Q
 .I (DGELG("MOH")="Y")&(DGPAT("VETERAN")="Y") S PRIORITY=1 Q   ;Added for DG*5.3*841 added I DGELG("MOH")="Y" S PRIORITY=1 DG*5.3*972 HM
 .I ((DGELG("SC")="Y")&(DGELG("SCPER")>29)&(CODENAME="SC LESS THAN 50%")) S PRIORITY=2 Q
 .I ((DGELG("SC")="Y")&(DGELG("SCPER")>9)&(CODENAME="SC LESS THAN 50%"))!(DGELG("POW")="Y")!(CODENAME="PRISONER OF WAR")!(DGELG("DISRET")=1)!(DGELG("DISLOD")=1)!(CODENAME="PURPLE HEART RECIPIENT")!(DGELG("PH")="Y") S PRIORITY=3 Q
 .I (DGELG("A&A")="Y")!(CODENAME="AID & ATTENDANCE")!(DGELG("HB")="Y")!(CODENAME="HOUSEBOUND")!(DGELG("VCD")="Y") S PRIORITY=4 Q
 .I (MTSTA="A")!(DGELG("MEDICAID")=1)!(DGELG("VAPEN")="Y")!(CODENAME="NSC, VA PENSION") S PRIORITY=5 Q
 .I (CODENAME="WORLD WAR I")!(CODENAME="MEXICAN BORDER WAR")!(DGELG("VACKAMT")>0)!((DGELG("CVELEDT"))&(DGELG("CVELEDT")'<DT))!(DGELG("SHAD")=1) S PRIORITY=6 Q
 .I DGELG("EC")="Y" I (STAEXP("EC")<1)!($$DT^XLFDT<STAEXP("EC")) S PRIORITY=6 Q
 .I DGELG("IR")="Y" I (DGELG("RADEXPM")=2)!(DGELG("RADEXPM")=3)!(DGELG("RADEXPM")=4) S PRIORITY=6 Q
 .I (DGELG("AO")="Y"),(DGELG("AOEXPLOC"))="V" I (STAEXP("AO")<1)!($$DT^XLFDT<STAEXP("AO")) S PRIORITY=6 Q
 .I DGELG("CLE")="Y" S PRIORITY=6 Q  ; Added for DG*5.3*909 Camp Lejeune
 .I (MTSTA="G")!((MTSTA="P")&(GMTTHR>MTTHR)) S PRIORITY=7 D  Q
 ..I ((DGELG("SC")="Y")&(DGELG("SCPER")=0)&(DGELG("VACKAMT")<1)&(CODENAME="SC LESS THAN 50%")) S SUBGRP=$$SUBPRI(DFN,.PRIORITY,1) Q
 ..S SUBGRP=$$SUBPRI(DFN,.PRIORITY,3)
 .S MTTEST1=MTTHR
 .I GMTTHR>MTTHR S MTTEST1=GMTTHR
 .S MTTEST2=MTTEST1+(MTTEST1*0.10)+0.01 ; Add 10% to the test threshold
 .I $$SC^DGMTR(DFN),DGMTYR>2007,DGNCM>MTTEST1,MTTEST2>DGNCM,ENRDATE>3090614 S PRIORITY=8,SUBGRP=$$SUBPRI(DFN,.PRIORITY,2) Q
 .I $$SC^DGMTR(DFN),DGMTYR>2007,(DGNCM-DGMEDEX-DGEDEX)<MTTHR,DGNCM+DGNETW>79999.99 S PRIORITY=8,SUBGRP=$$SUBPRI(DFN,.PRIORITY,2) Q
 .I DGELG("SC")="N",DGMTYR>2007,DGNCM>MTTEST1,MTTEST2>DGNCM,ENRDATE>3090614 S PRIORITY=8,SUBGRP=$$SUBPRI(DFN,.PRIORITY,4) Q
 .I DGELG("SC")="N",DGMTYR>2007,(DGNCM-DGMEDEX-DGEDEX)<MTTHR,DGNCM+DGNETW>79999.99 S PRIORITY=8,SUBGRP=$$SUBPRI(DFN,.PRIORITY,4) Q
 .I ((DGELG("SC")="Y")&(DGELG("SCPER")=0)&(DGELG("VACKAMT")<1)&(CODENAME="SC LESS THAN 50%")) S PRIORITY=8,SUBGRP=$$SUBPRI(DFN,.PRIORITY,1) Q
 .I ((MTSTA="C")!(MTSTA="P")) S PRIORITY=8,SUBGRP=$$SUBPRI(DFN,PRIORITY,3) Q
 ;
 Q PRIORITY_$S(PRIORITY:"^"_SUBGRP,1:"")
 ;
SUBPRI(DFN,PRIORITY,SUBGRP) ;calculate sub-priority if under EGT
 ;
 N PRVPRI,DONE,PRVENST,ENRDT,DGENRIEN,EGT,DGENRC,TODAY,X
 Q:'$G(DFN)
 S U="^"
 S:$G(PRIORITY)="" PRIORITY=""
 S:$G(SUBGRP)="" SUBGRP=""
 D NOW^%DTC S TODAY=X
 Q:'$$GET^DGENEGT($$FINDCUR^DGENEGT(),.EGT) SUBGRP  ;EGT isn't set
 Q:TODAY<EGT("EFFDATE") SUBGRP  ;EGT is not in effect
 I "^1^3^"[(U_EGT("TYPE")_U) Q SUBGRP
 I EGT("TYPE")=2,(PRIORITY+(SUBGRP*.01))<(EGT("PRIORITY")+(EGT("SUBGRP")*.01)) Q SUBGRP
 I EGT("TYPE")=4 Q:(PRIORITY<EGT("PRIORITY")) SUBGRP  Q:(PRIORITY>EGT("PRIORITY")) $$SUBCNV(SUBGRP)
 ;I $G(ENRDATE) Q:$$ABOVE2^DGENEGT1(ENRDATE,PRIORITY,SUBGRP) SUBGRP
 S DGENRIEN=$$FINDCUR^DGENA(DFN)
 I 'DGENRIEN,$G(ENRDATE),ENRDATE<EGT("EFFDATE") Q SUBGRP
 S DONE=0
 F  Q:DONE  D
 .I 'DGENRIEN S DONE=2 Q
 .I '$$GET^DGENA(DGENRIEN,.DGENRC) S DONE=2 Q
 .S DGENRIEN=$$FINDPRI^DGENA(DGENRIEN)
 .Q:DGENRC("STATUS")=6   ;deceased
 .I $P($G(^DGEN(27.15,+DGENRC("STATUS"),0)),"^",2)="N" S DONE=2 Q
 .S ENRDT=$G(DGENRC("APP")) S:'ENRDT ENRDT=$G(DGENRC("EFFDATE"))
 .I ENRDT,ENRDT<EGT("EFFDATE") S DONE=1 Q
 .; HEC is the authoritative source on continuous enrollment
 .I $$OVRRIDE^DGENEGT1(DFN,.EGT) S DONE=1
 ;
 Q $S(DONE=2:$$SUBCNV(SUBGRP),1:SUBGRP)
 ;
SUBCNV(SUBGRP) ;return new subgrp
 I SUBGRP=1 Q 5
 I SUBGRP=3 Q 7
 Q SUBGRP
 ;
STAEXP(STATYP) ;return expiration date for Special Treatment Authority (STA)
 ;Input -
 ;  STATYP - STA Type (Only AO & EC (SWAC) currently supported)
 ;
 ;Output -
 ;  Function Value - returns the requested expiration date from the
 ;                   MAS PARAMETERS file (#43), otherwise returns 0
 ;
 I STATYP="AO" Q +$P($G(^DG(43,1,"ENR")),U,1)  ;AO Exp Dt
 I STATYP="EC" Q +$P($G(^DG(43,1,"ENR")),U,2)  ;EC (SWAC) Exp Dt
 Q 0
