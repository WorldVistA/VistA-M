SDECU3 ;ALB/SAT - VISTA SCHEDULING RPCS ;MAR 15, 2017
 ;;5.3;Scheduling;**658**;Aug 13, 1993;Build 23
 ;
 Q
 ;
PDEMO(RET,DFN) ;GET specific patient demographics
 ;INPUT:
 ; DFN - Pointer to PATIENT file 2
 ;RETURN:
 ; .RET = Return Array
 ; RET("DOB")      = Date of Birth
 ; RET("ELIGIEN")  = Pointer to MAS ELIGIBILITY CODE file 8.1
 ; RET("ELIGNAME") = NAME from MAS ELIGIBILITY CODE file
 ; RET("GENDER")
 ; RET("HRN")      = health record number
 ; RET("INSTIEN")  = Institution IEN
 ; RET("INSTNAME") = Institution Name
 ; RET("NAME")     = Patient name
 ; RET("PADDRES1")= STREET ADDRESS [LINE 1] (.111)
 ; RET("PADDRES2")= STREET ADDRESS [LINE 2] (.112)
 ; RET("PADDRES3")= STREET ADDRESS [LINE 3] (.113)
 ; RET("PZIP+4")   = ZIP+4 (.1112)
 ; RET("PCITY")    = CITY  (.114)
 ; RET("PSTATE")   = STATE name   (from .115)
 ; RET("PCOUNTRY") = COUNTRY name  (from .1173)
 ; RET("BADADD")   = BAD ADDRESS INDICATOR  (.121)
 ;                   1=UNDELIVERABLE
 ;                   2=HOMELESS
 ;                   3=OTHER
 ;                   4=ADDRESS NOT FOUND
 ; RET("HPHONE")   = Home phone  (.131)
 ; RET("OPHONE")   = Office phone  (.132)
 ; RET("PRIGRP")   = ENROLLMENT PRIORITY text from PATIENT ENROLLMENT file
 ;           Valid Values:
 ;             GROUP 1
 ;             GROUP 2
 ;             GROUP 3
 ;             GROUP 4
 ;             GROUP 5
 ;             GROUP 6
 ;             GROUP 7
 ;             GROUP 8
 ; RET("SIMILAR")  = Similar Patients
 ;                   MESSSAGE | Patients
 ;                   Message
 ;                   Patients separated by ;;
 ;                    Each ;; piece contains the following ~ pieces
 ;                    DFN ~ NAME ~ DOB ~ SSN
 ; RET("SSN")      = Social Security number
 ; RET("SUBGRP")   = Enrollment Subgroup
 ; RET("SVCCONN")  = SERVICE CONNECTED field from PATIENT ENROLLMENT file
 ;           Valid values:
 ;           YES
 ;           NO
 ; RET("SVCCONNP") = SERVICE CONNECTED PERCENTAGE field from PATIENT ENROLLMENT file
 ;           Numeric between 0-100
 ; RET("TYPEIEN") = Pointer to TYPE OF PATIENT file 391
 ; RET("TYPENAME")= NAME from TYPE OF PATIENT file 391
 ;
 ; RET("NOK")       - Primary Next of Kin  (.211)
 ; RET("KNAME")   - Primary Next of Kin name
 ; RET("KREL")    - Primary Next of Kin Relationship to Patient (.212)
 ; RET("KPHONE")  - Primary Next of Kin Phone (.219)
 ; RET("KSTREET") - Primary Next of Kin Street Address [Line 1] (.213)
 ; RET("KSTREET2") - Primary Next of Kin Street Address [Line 2] (.214)
 ; RET("KSTREET3") - Primary Next of Kin Street Address [Line 3] (.215)
 ; RET("KCITY")   - Primary Next of Kin City (.216)
 ; RET("KSTATE")  - Primary Next of Kin State (.217)
 ; RET("KZIP")    - Primary Next of Kin Zip (.218)
 ; RET("NOK2")    - Secondary Next of Kin  (.2191)
 ; RET("K2NAME")     - Secondary Next of Kin name  (.2191)
 ; RET("K2REL")   - Secondary Next of Kin Relationship to Patient (.2192)
 ; RET("K2PHONE") - Secondary Next of Kin Phone (.2199)
 ; RET("K2STREET") - Secondary Next of Kin Street Address [Line 1] (.2193)
 ; RET("K2STREET2") - Secondary Next of Kin Street Address [Line 2] (.2194)
 ; RET("K2STREET3") - Secondary Next of Kin Street Address [Line 3] (.2195)
 ; RET("K2CITY")    - Secondary Next of Kin City (.2196)
 ; RET("K2STATE")   - Secondary Next of Kin State (.2197)
 ; RET("K2ZIP")     - Secondary Next of Kin Zip (.2198)
 ; RET("PCOUNTY")  - Patient County (.117)
 ; RET("PETH")     - List of Patient Ethnicities/Names  Eth|Name^...  Use ETH^SDECU2
 ; RET("PRACE")     - List of Patient Races/Names   RACE|NAME^...  Use RACELST^SDECU2
 ; RET("PMARITAL")  - Patient Marital Status
 ; RET("PRELIGION") - Patient Religious Preference
 ; RET("PTACTIVE")  - Patient Temporary Address Active? (.12105)
 ; RET("PTADDRESS1") - Patient Temporary Address Line 1 (.1211)
 ; RET("PTADDRESS2") - Patient Temporary Address Line 2 (.1212)
 ; RET("PTADDRESS3") - Patient Temporary Address Line 3 (.1213)
 ; RET("PTCITY")     - Patient Temporary City (.1214)
 ; RET("PTSTATE")    - Patient Temporary State (.1215)
 ; RET("PTZIP")      - Patient Temporary Zip (.1216)
 ; RET("PTZIP+4")    - Patient Temporary Zip+4 (.12112)
 ; RET("PTCOUNTRY")  - Patient Temporary Country (.1223)
 ; RET("PTCOUNTY")   - Patient Temporary County (.12111)
 ; RET("PTPHONE")    - Patient Temporary Phone (.1219)
 ; RET("PTSTART")    - Patient Temporary Address Start Date (.1217)
 ; RET("PTEND")      - Patient Temporary Address End Date (.1218)
 ; RET("PCELL")      - Patient Cell Phone (.134)
 ; RET("PPAGER")     - Patient Pager Number (.135)
 ; RET("PEMAIL")     - Patient Email Address (.133)
 ; RET("PF_FFF")   - Patient FUGITIVE FELON FLAG 1=YES
 ; RET("PF_VCD")   - Patient VETERAN CATASTROPHICALLY DISABLED? Y=YES N=NO
 ; RET("PFNATIONAL")   - Patient national Flags (PRF ASSIGNMENT/PRF NATIONAL FLAG) separated by |
 ;                  Each | piece contains the following ;; pipe pieces:
 ;                   1. PRFAID   - PRF Assignment ID pointer to PRF ASSIGNMENT file (#26.13)
 ;                   2. PRFSTAT  - PRF Assignment Status 0=INACTIVE 1=ACTIVE
 ;                   3. PRFNID   - PRF National Flag ID pointer to PRF NATIONAL FLAG file (#26.15)
 ;                   4. PRFNNAME - PRF National Flag name
 ;                   5. PRFNSTAT - PRF National Flag status  0=INACTIVE 1=ACTIVE
 ; RET("PFLOCAL")   - Patient Local Flags (PRF ASSIGNMENT/PRF Local FLAG) separated by |
 ;                   Each | piece contains the following ;; pipe pieces:
 ;                    1. PRFAID   - PRF Assignment ID pointer to PRF ASSIGNMENT file (#26.13)
 ;                    2. PRFSTAT  - PRF Assignment Status 0=INACTIVE 1=ACTIVE
 ;                    3. PRFLID   - PRF Local Flag ID pointer to PRF LOCAL FLAG file (#26.11)
 ;                    4. PRFLNAME - PRF Local Flag name
 ;                    5. PRFLSTAT - PRF Local Flag status  0=INACTIVE 1=ACTIVE
 ;   RET("PF_8G")          - Category 8G  (not returned yet)
 ;
 N SDD,SDI,SDM
 N PCE,PCOUNTY,PD,PTCOUNTY,PETHL,PM,PTINFO
 Q:'+$G(DFN)
 Q:'$D(^DPT(DFN,0))
 ;collect demographics
 K RET
 S (PCOUNTY,PTCOUNTY,RET("PCOUNTY"),RET("PTCOUNTY"))=""
 ;get data from PTINFO and PATIENT/IHS
 D PTINFO^SDECPTCX(.PTINFO,DFN)
 D GETS^DIQ(9000001,DFN_",","**","IE","PD","PM")
 I '$D(PM) D
 .S RET("INSTIEN")=$G(PD(9000001.41,+DUZ(2)_","_DFN_",",.01,"I"))
 .S RET("INSTNAME")=$G(PD(9000001.41,+DUZ(2)_","_DFN_",",.01,"E"))
 E  S (RET("INSTIEN"),RET("INSTNAME"))=""
 S RET("NAME")=$P($G(PTINFO),U)
 S RET("GENDER")=$P($G(PTINFO),U,2)
 S RET("DOB")=$$FMTE^XLFDT($P($G(PTINFO),U,3))
 S RET("SSN")=$P($G(PTINFO),U,4)
 ;
 S RET("HRN")=$$HRN^SDECPAT(DFN,DUZ(2))
 ;
 ;patient enrollment
 S PCE=$P($G(^DPT(DFN,"ENR")),U,1)
 D:+PCE GETS^DIQ(27.11,+PCE_",",".07;.12;50.01;50.02;50.03","IE","SDD","SDM")
 S RET("PRIGRP")=$S(+PCE:SDD(27.11,PCE_",",.07,"E"),1:"")
 S RET("SUBGRP")=$S(+PCE:SDD(27.11,PCE_",",.12,"E"),1:"")
 S RET("ELIGIEN")=$S(+PCE:SDD(27.11,PCE_",",50.01,"I"),1:"")
 S RET("ELIGNAME")=$S(+PCE:SDD(27.11,PCE_",",50.01,"E"),1:"")
 S RET("SVCCONN")=$$GET1^DIQ(2,DFN_",",.301,"E")  ;$S(+PCE:SDD(27.11,PCE_",",50.02,"E"),1:"")
 S RET("SVCCONNP")=$$GET1^DIQ(2,DFN_",",.302,"E")  ;$S(+PCE:SDD(27.11,PCE_",",50.03,"I"),1:"")
 S RET("TYPEIEN")=$$GET1^DIQ(2,DFN_",",391,"I")
 S RET("TYPENAME")=$$GET1^DIQ(2,DFN_",",391,"E")
 ;
 ;get addresses
 K SDD,SDM D GETS^DIQ(2,DFN_",",".05;.08;.111:.135;.211:.2207","IE","SDD","SDM")
 S RET("PADDRES1")=$G(SDD(2,DFN_",",.111,"E"))  ; STREET ADDRESS [LINE 1]
 S RET("PADDRES2")=$G(SDD(2,DFN_",",.112,"E"))  ; STREET ADDRESS [LINE 2]
 S RET("PADDRES3")=$G(SDD(2,DFN_",",.113,"E"))  ; STREET ADDRESS [LINE 3]
 S RET("PZIP+4")=$G(SDD(2,DFN_",",.1112,"E"))    ; ZIP+4
 S RET("PCITY")=$G(SDD(2,DFN_",",.114,"E"))      ; CITY
 N PSTATE S PSTATE=$G(SDD(2,DFN_",",.115,"I"))
 S RET("PSTATE")=$G(SDD(2,DFN_",",.115,"E"))     ; STATE name
 I PSTATE'="" D
 .S PCOUNTY=$G(SDD(2,DFN_",",.117,"I"))
 .S:PCOUNTY'="" RET("PCOUNTY")=$P($G(^DIC(5,PSTATE,1,PCOUNTY,0)),U,1)  ;  - Patient County (.117)
 S RET("PCOUNTRY")=$G(SDD(2,DFN_",",.1173,"I"))  ; COUNTRY
 I RET("PCOUNTRY")'="",'+RET("PCOUNTRY") S RET("PCOUNTRY")=$O(^HL(779.004,"B",RET("PCOUNTRY"),0))
 S RET("BADADD")=$G(SDD(2,DFN_",",.121,"I"))     ;bad address indicator
 S RET("PTACTIVE")=$G(SDD(2,DFN_",",.12105,"I"))
 S RET("PTADDRESS1")=$G(SDD(2,DFN_",",.1211,"E"))
 S RET("PTADDRESS2")=$G(SDD(2,DFN_",",.1212,"E"))
 S RET("PTADDRESS3")=$G(SDD(2,DFN_",",.1213,"E"))
 S RET("PTCITY")=$G(SDD(2,DFN_",",.1214,"E"))
 N PTSTATE S PTSTATE=$G(SDD(2,DFN_",",.1215,"I"))
 S RET("PTSTATE")=$G(SDD(2,DFN_",",.1215,"E"))     ; Patient Temporary STATE name
 S RET("PTZIP")=$G(SDD(2,DFN_",",.1216,"E"))       ; Patient Temporary Zip (.1216)
 S RET("PTZIP+4")=$G(SDD(2,DFN_",",.12112,"E"))    ; Patient Temporary Zip+4 (.12112)
 S RET("PTCOUNTRY")=$G(SDD(2,DFN_",",.1223,"I"))   ; Patient Temp COUNTRY
 I PTSTATE'="" D
 .S PTCOUNTY=$G(SDD(2,DFN_",",.12111,"I"))
 .S:PTCOUNTY'="" RET("PTCOUNTY")=$P($G(^DIC(5,PTSTATE,1,PTCOUNTY,0)),U,1)  ;  - Patient Temp County (.12111)
 S RET("PTSTART")=$G(SDD(2,DFN_",",.1217,"E"))   ; Patient Temporary Address Start Date (.1217)
 S RET("PTEND")=$G(SDD(2,DFN_",",.1218,"E"))     ; Patient Temporary Address End Date (.1218)
 ;
 ;get phones
 S RET("HPHONE")=$G(SDD(2,DFN_",",.131,"E"))     ; phone number (residence) (home phone)
 S RET("OPHONE")=$G(SDD(2,DFN_",",.132,"E"))     ; phone number (work) (office phone)
 S RET("PTPHONE")=$G(SDD(2,DFN_",",.1219,"E"))   ; Patient Temporary Phone (.1219)
 S RET("PCELL")=$G(SDD(2,DFN_",",.134,"E"))      ; Patient Cell Phone (.134)
 S RET("PPAGER")=$G(SDD(2,DFN_",",.135,"E"))     ; Patient Pager Number (.135)
 S RET("PEMAIL")=$G(SDD(2,DFN_",",.133,"E"))     ; Patient Email Address (.133)
 ;
 ; Return data to add:
 S RET("NOK")=$G(SDD(2,DFN_",",.211,"I"))       ;Primary Next of Kin  (.211)
 S RET("KNAME")=$G(SDD(2,DFN_",",.211,"E"))      ;Primary Next of Kin name  (.211)
 S RET("KREL")=$G(SDD(2,DFN_",",.212,"E"))    ;Primary Next of Kin Relationship to Patient (.212)
 S RET("KPHONE")=$G(SDD(2,DFN_",",.219,"E"))  ;Primary Next of Kin Phone (.219)
 S RET("KSTREET")=$G(SDD(2,DFN_",",.213,"E")) ;Primary Next of Kin Street Address [Line 1] (.213)
 S RET("KSTREET2")=$G(SDD(2,DFN_",",.214,"E")) ;Primary Next of Kin Street Address [Line 2] (.214)
 S RET("KSTREET3")=$G(SDD(2,DFN_",",.215,"E")) ;Primary Next of Kin Street Address [Line 3] (.215)
 S RET("KCITY")=$G(SDD(2,DFN_",",.216,"E"))    ;Primary Next of Kin City (.216)
 S RET("KSTATE")=$G(SDD(2,DFN_",",.217,"E"))   ;Primary Next of Kin State (.217)
 S RET("KZIP")=$G(SDD(2,DFN_",",.218,"E"))     ;Primary Next of Kin Zip (.218)
 ;
 S RET("NOK2")=$G(SDD(2,DFN_",",.2191,"I"))       ;Secondary Next of Kin  (.2191)
 S RET("K2NAME")=$G(SDD(2,DFN_",",.2191,"E"))      ;Secondary Next of Kin name  (.2191)
 S RET("K2REL")=$G(SDD(2,DFN_",",.2192,"E"))    ;Secondary Next of Kin Relationship to Patient (.2192)
 S RET("K2PHONE")=$G(SDD(2,DFN_",",.2199,"E"))  ;Secondary Next of Kin Phone (.2199)
 S RET("K2STREET")=$G(SDD(2,DFN_",",.2193,"E")) ;Secondary Next of Kin Street Address [Line 1] (.2193)
 S RET("K2STREET2")=$G(SDD(2,DFN_",",.2194,"E")) ;Secondary Next of Kin Street Address [Line 2] (.2194)
 S RET("K2STREET3")=$G(SDD(2,DFN_",",.2195,"E")) ;Secondary Next of Kin Street Address [Line 3] (.2195)
 S RET("K2CITY")=$G(SDD(2,DFN_",",.2196,"E"))    ;Secondary Next of Kin City (.2196)
 S RET("K2STATE")=$G(SDD(2,DFN_",",.2197,"E"))   ;Secondary Next of Kin State (.2197)
 S RET("K2ZIP")=$G(SDD(2,DFN_",",.2198,"E"))     ;Secondary Next of Kin Zip (.2198)
 ;
 S RET("PMARITAL")=$G(SDD(2,DFN_",",.05,"E"))    ;Patient Marital Status (.05)
 S RET("PRELIGION")=$G(SDD(2,DFN_",",.08,"E"))   ;Patient Religious Preference (.08)
 ;
 N PETH,PETHN D ETH^SDECU2(DFN,.PETH,.PETHN)
 S PETHL="" F SDI=1:1:$L(PETH,"|") S PETHL=PETHL_$S(PETHL'="":U,1:"")_$P(PETH,"|",SDI)_"|"_$P(PETHN,"|",SDI)
 S RET("PETH")=PETHL     ;List of Patient Ethnicities/Names  Eth|Name^...  Use ETH^SDECU2
 N RACE,RACEL,RACEN D RACELST^SDECU2(DFN,.RACE,.RACEN)
 S RACEL="" F SDI=1:1:$L(RACE,"|") S RACEL=RACEL_$S(RACEL'="":U,1:"")_$P(RACE,"|",SDI)_"|"_$P(RACEN,"|",SDI)
 S RET("PRACE")=RACEL    ;List of Patient Races/Names   RACE|NAME^...  Use RACELST^SDECU2
 S RET("PFNATIONAL")=$$FLAGS^SDECU2(DFN,26.15)
 S RET("PFLOCAL")=$$FLAGS^SDECU2(DFN,26.11)
 S RET("PF_FFF")=$$GET1^DIQ(2,DFN_",",1100.01,"I")
 S RET("PF_VCD")=$$GET1^DIQ(2,DFN_",",.39,"I")
 S RET("SIMILAR")=$$SIM(DFN)
 ;
 Q
 ;
SIM(DFN)  ;get similar patient data
 N MI,MSG,NOD,PATS,RET,SIM
 S (MSG,PATS,SIM)=""
 D GUIBS5A^DPTLK6(.RET,DFN)
 S MI=1 F  S MI=$O(RET(MI)) Q:MI=""  D
 .S NOD=RET(MI)
 .I $P(NOD,U,1)=0 S MSG=MSG_$S(MSG'="":" ",1:"")_$P(NOD,U,2)
 .I $P(NOD,U,1)=1 S PATS=PATS_$S(PATS'="":";;",1:"")_$TR($P(NOD,U,2,5),U,"~") S:(MSG'="")&($E(MSG,$L(MSG))'=".") MSG=MSG_"."
 S SIM=MSG_"|"_PATS
 Q SIM
