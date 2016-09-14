SDECDIS ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
DISABIL(SDECY,DFN) ;GET rated disabilities for the given patient
 ;INPUT:
 ; DFN - (required) pointer to PATIENT file 2
 ;RETURN:
 ;  1. DFN          - patient ID pointer to PATIENT file 2
 ;  2. DISABILITIES - RATED DISABILITIES from multiple field .3721 separated by pipe
 ;                    each pipe piece contains the following ;; pieces:
 ;                     1. DISABILITY id pointer to DISABILITY CONDITION file 31
 ;                     2. DISABILITY NAME from DISABILITY CONDITION file
 ;                     3. DISABILITY % - percentage at which the VA rated this disability
 ;                     4. SERVICE_CONNECTED - 0=NO=Patient is not service connected for this disability
 ;                                            1=YES=Patient IS service connected for this disability
 ;                     5. EXTREMITY - BL = BOTH LOWER
 ;                                    BU = BOTH UPPER
 ;                                    RL = RIGHT LOWER
 ;                                    RU = RIGHT UPPER
 ;                                    LL = LEFT LOWER
 ;                                    LU = LEFT UPPER
 ;                     6. ORIG_DATE - ORIGINAL EFFECTIVE DATE in external format
 ;                     7. CURR_DATE         - CURRENT EFFECTIVE DATE in external format
 ;  3. SVCCONN - Y=YES=Patient Service Connected          ;$$GET1^DIQ(2,DFN_",",.301,"E")  ;$S(+PCE:SDD(27.11,PCE_",",50.02,"E"),1:"")
 ;               N=NO=Patient NOT Service Connected
 ; 4. SVCCONNP - Patient's service connected percentage   ;S RET("SVCCONNP")=$$GET1^DIQ(2,DFN_",",.302,"E")
 ; 5. PRIMARY  - from field .361 pointer to ELIGIBILITY CODE file 8
 ; 6. PRIMARY_NAME - name from ELIGIBILITY CODE file
 ; 7. SECONDARY - from PATIENT ELIGIBILITIES multiple field 361 separated by pipe (see SC^DGMTR)
 ;                each pipe piece contains the following ;; pieces:
 ;                 1. ELIGIBILITY id pointer to ELIGIBILITY CODE file 8
 ;                 2. ELIGIBILITY name from ELIGIBILITY CODE file
 ;
 N SDDATA,SDI,SDRET,SDTMP,SDTMP1
 S SDECY="^TMP(""SDECDIS"","_$J_",""DIS"")"
 K @SDECY
 S SDTMP="T00030DFN^T00100DISABILITIES^T00030SVCCONN^T00030SVCCONNP^T00030PRIMARY^T00030PRIMARY_NAME^T00030SECONDARY"
 S @SDECY@(0)=SDTMP_$C(30)
 S DFN=$G(DFN)
 I (DFN="")!('$D(^DPT(DFN,0))) S @SDECY@(1)="-1^Invalid patient id."_$C(30,31) Q
 S SDRET=DFN
 S SDTMP=""
 D GETS^DIQ(2,DFN,".3721*","IE","SDDATA")
 S SDI="" F  S SDI=$O(SDDATA(2.04,SDI)) Q:SDI=""  D
 .S SDTMP1=""
 .S $P(SDTMP1,";;",1)=SDDATA(2.04,SDI,.01,"I")   ;DISABILITY CONDITION id
 .S $P(SDTMP1,";;",2)=SDDATA(2.04,SDI,.01,"E")   ;name
 .S $P(SDTMP1,";;",3)=SDDATA(2.04,SDI,2,"I")     ;disability %
 .S $P(SDTMP1,";;",4)=SDDATA(2.04,SDI,3,"I")     ;service connected
 .S $P(SDTMP1,";;",5)=SDDATA(2.04,SDI,4,"I")     ;extremity affcted
 .S $P(SDTMP1,";;",6)=SDDATA(2.04,SDI,5,"E")     ;original effective date
 .S $P(SDTMP1,";;",7)=SDDATA(2.04,SDI,6,"E")     ;current effective date
 .S SDTMP=$S(SDTMP'="":SDTMP_"|",1:"")_SDTMP1
 S $P(SDRET,U,2)=SDTMP
 S $P(SDRET,U,3)=$$GET1^DIQ(2,DFN_",",.301,"I")  ;service connected
 S $P(SDRET,U,4)=$$GET1^DIQ(2,DFN_",",.302,"I")  ;service connected percentage
 S $P(SDRET,U,5)=$$GET1^DIQ(2,DFN_",",.361,"I")  ;primary eligibility code id
 S $P(SDRET,U,6)=$$GET1^DIQ(2,DFN_",",.361,"E")  ;primary eligibility code name
 S SDTMP=""
 D GETS^DIQ(2,DFN,"361*","IE","SDDATA")
 S SDI="" F  S SDI=$O(SDDATA(2.0361,SDI)) Q:SDI=""  D
 .S SDTMP1=""
 .S $P(SDTMP1,";;",1)=SDDATA(2.0361,SDI,.01,"I")   ;eligibility id
 .S $P(SDTMP1,";;",2)=SDDATA(2.0361,SDI,.01,"E")   ;eligibility name
 .S SDTMP=$S(SDTMP'="":SDTMP_"|",1:"")_SDTMP1
 S $P(SDRET,U,7)=SDTMP
 S @SDECY@(1)=SDRET_$C(30,31)
 Q
