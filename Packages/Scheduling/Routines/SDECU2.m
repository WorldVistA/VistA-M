SDECU2 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
SCIEN(PAT,CLINIC,DATE) ;PEP; returns ien for appt in ^SC
 NEW X,IEN
 S X=0 F  S X=$O(^SC(CLINIC,"S",DATE,1,X)) Q:'X  Q:$G(IEN)  D
 . Q:$P($G(^SC(CLINIC,"S",DATE,1,X,0)),U,9)="C"  ;cancelled
 . I +$G(^SC(CLINIC,"S",DATE,1,X,0))=PAT S IEN=X
 Q $G(IEN)
 ;
CI(PAT,CLINIC,DATE,SDIEN) ;PEP; -- returns 1 if appt already checked-in
 NEW X
 S X=$G(SDIEN)   ;ien sent in call
 I 'X S X=$$SCIEN(PAT,CLINIC,DATE) I 'X Q 0
 S X=$P($G(^SC(CLINIC,"S",DATE,1,X,"C")),U)
 Q $S(X:1,1:0)
 ;
APPTYP(PAT,DATE) ;PEP; -- returns type of appt (scheduled or walk-in)
 NEW X S X=$P($G(^DPT(PAT,"S",DATE,0)),U,7)
 Q $S(X=3:"SCHED",X=4:"WALK-IN",1:"??")
 ;
CO(PAT,CLINIC,DATE,SDIEN) ;PEP; -- returns 1 if appt already checked-out
 NEW X
 S X=$G(SDIEN)   ;ien sent in call
 I 'X S X=$$SCIEN(PAT,CLINIC,DATE) I 'X Q 0
 S X=$P($G(^SC(CLINIC,"S",DATE,1,X,"C")),U,3)
 Q $S(X:1,1:0)
 ;
GETVST(PAT,DATE) ;PEP; returns visit ien for appt date and patient
 NEW X
 I ('PAT)!('DATE) Q 0
 S X=$G(^DPT(PAT,"S",DATE,0)) I 'X Q 0   ;appt node
 S X=$P(X,U,20) I 'X Q 0                 ;outpt encounter ptr
 S X=$G(^SCE(X,0)) I 'X Q 0              ;outpt encounter node
 I $P(X,U,2)'=PAT Q 0                    ;patient ptr
 Q $P(X,U,5)                             ;visit ptr
 ;
PDEMO(RET,DFN) ;GET specific patient demographics
 ;INPUT:
 ; DFN - Pointer to PATIENT file 2
 ;RETURN:
 ;  .RET = Return Array
 ;   RET("DOB")      = Date of Birth
 ;   RET("ELIGIEN")  = Pointer to MAS ELIGIBILITY CODE file 8.1
 ;   RET("ELIGNAME") = NAME from MAS ELIGIBILITY CODE file
 ;   RET("GENDER")
 ;   RET("HRN")      = health record number
 ;   RET("INSTIEN")  = Institution IEN
 ;   RET("INSTNAME") = Institution Name
 ;   RET("NAME")     = Patient name
 ;   RET("PADDRES1")= STREET ADDRESS [LINE 1]
 ;   RET("PADDRES2")= STREET ADDRESS [LINE 2]
 ;   RET("PADDRES3")= STREET ADDRESS [LINE 3]
 ;   RET("PZIP+4")   = ZIP+4
 ;   RET("PCITY")    = CITY
 ;   RET("PSTATE")   = STATE name
 ;   RET("PCOUNTRY") = COUNTRY name
 ;   RET("BADADD")   = BAD ADDRESS INDICATOR
 ;                     1=UNDELIVERABLE
 ;                     2=HOMELESS
 ;                     3=OTHER
 ;                     4=ADDRESS NOT FOUND
 ;   RET("HPHONE")   = Home phone
 ;   RET("OPHONE")   = Office phone
 ;   RET("PRIGRP")   = ENROLLMENT PRIORITY text from PATIENT ENROLLMENT file
 ;             Valid Values:
 ;               GROUP 1
 ;               GROUP 2
 ;               GROUP 3
 ;               GROUP 4
 ;               GROUP 5
 ;               GROUP 6
 ;               GROUP 7
 ;               GROUP 8
 ;   RET("SSN")      = Social Security number
 ;   RET("SVCCONN")  = SERVICE CONNECTED field from PATIENT ENROLLMENT file
 ;             Valid values:
 ;             YES
 ;             NO
 ;   RET("SVCCONNP") = SERVICE CONNECTED PERCENTAGE field from PATIENT ENROLLMENT file
 ;             Numeric between 0-100
 ;   RET("TYPEIEN") = Pointer to TYPE OF PATIENT file 391
 ;   RET("TYPENAME")= NAME from TYPE OF PATIENT file 391
 N SDD,SDM
 N PCE,PD,PM,PTINFO
 ;collect demographics
 Q:'+$G(DFN)
 Q:'$D(^DPT(DFN,0))
 K RET
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
 S RET("HRN")=$$HRN^SDECPAT(DFN,DUZ(2))
 S PCE=$P($G(^DPT(DFN,"ENR")),U,1)
 D:+PCE GETS^DIQ(27.11,+PCE_",",".07;50.01;50.02;50.03","IE","SDD","SDM")
 S RET("PRIGRP")=$S(+PCE:SDD(27.11,PCE_",",.07,"E"),1:"")
 S RET("ELIGIEN")=$S(+PCE:SDD(27.11,PCE_",",50.01,"I"),1:"")
 S RET("ELIGNAME")=$S(+PCE:SDD(27.11,PCE_",",50.01,"E"),1:"")
 S RET("SVCCONN")=$$GET1^DIQ(2,DFN_",",.301,"E")  ;$S(+PCE:SDD(27.11,PCE_",",50.02,"E"),1:"")
 S RET("SVCCONNP")=$$GET1^DIQ(2,DFN_",",.302,"E")  ;$S(+PCE:SDD(27.11,PCE_",",50.03,"I"),1:"")
 S RET("TYPEIEN")=$$GET1^DIQ(2,DFN_",",391,"I")
 S RET("TYPENAME")=$$GET1^DIQ(2,DFN_",",391,"E")
 ;get address
 K SDD,SDM D GETS^DIQ(2,DFN_",",".111;.1112;.112;.113;.114;.115;.116;.121;.131;.132;.1173","IE","SDD","SDM")
 S RET("PADDRES1")=$G(SDD(2,DFN_",",.111,"E"))  ; STREET ADDRESS [LINE 1]
 S RET("PADDRES2")=$G(SDD(2,DFN_",",.112,"E"))  ; STREET ADDRESS [LINE 2]
 S RET("PADDRES3")=$G(SDD(2,DFN_",",.113,"E"))  ; STREET ADDRESS [LINE 3]
 S RET("PZIP+4")=$G(SDD(2,DFN_",",.1112,"E"))    ; ZIP+4
 S RET("PCITY")=$G(SDD(2,DFN_",",.114,"E"))      ; CITY
 S RET("PSTATE")=$G(SDD(2,DFN_",",.115,"E"))     ; STATE name
 S RET("PCOUNTRY")=$G(SDD(2,DFN_",",.1173,"I"))  ; COUNTRY
 I RET("PCOUNTRY")'="",'+RET("PCOUNTRY") S RET("PCOUNTRY")=$O(^HL(779.004,"B",RET("PCOUNTRY"),0))
 S RET("BADADD")=$G(SDD(2,DFN_",",.121,"I"))     ;bad address indicator
 ;get phone
 S RET("HPHONE")=$G(SDD(2,DFN_",",.131,"E"))     ;phone number (residence) (home phone)
 S RET("OPHONE")=$G(SDD(2,DFN_",",.132,"E"))     ;phone number (work) (office phone)
 Q
 ;
GAF(DFN) ;determine if GAF score needed
 N GAF,GAFR
 S GAFR=""
 S GAF=$$NEWGAF^SDUTL2(DFN)
 S:GAF="" GAF=-1
 S $P(GAFR,"|",1)=$S(+GAF:"New GAF Required",1:"No new GAF required")
 S $P(GAFR,"|",2)=$P(GAF,U,2)
 S $P(GAFR,"|",3)=$$FMTE^XLFDT($P(GAF,U,3))
 S $P(GAFR,"|",4)=$P(GAF,U,4)
 S $P(GAFR,"|",5)=$P($G(^VA(200,+$P(GAF,U,4),0)),U,1)
 Q GAFR
 ;
ETH(DFN,PETH,PETHN) ;get ethnicity list
 ;INPUT:
 ;  DFN = Patient ID pointer to PATIENT file
 ;RETURN:
 ;   PETH   - Patient Ethnicity list separated by pipe |
 ;               Pointer to ETHNICITY file 10.2
 ;   PETHN  - Patient Ethnicity names separated by pipe |
 N SDI,SDID
 S (PETH,PETHN)=""
 S SDI=0 F  S SDI=$O(^DPT(DFN,.06,SDI)) Q:SDI'>0  D
 .S SDID=$P($G(^DPT(DFN,.06,SDI,0)),U,1)
 .S PETH=$S(PETH'="":PETH_"|",1:"")_SDID
 .S PETHN=$S(PETHN'="":PETHN_"|",1:"")_$P($G(^DIC(10.2,SDID,0)),U,1)
 Q
RACELST(DFN,RACEIEN,RACENAM) ;get list of race information for given patient
 ;INPUT:
 ;  DFN = Patient ID pointer to PATIENT file
 ;RETURN:
 ;   RACEIEN  - Patient race list separated by pipe |
 ;               Pointer to RACE file 10
 ;   RACENAM  - Patient race names separated by pipe |
 N SDI,SDID
 S (RACEIEN,RACENAM)=""
 S SDI=0 F  S SDI=$O(^DPT(DFN,.02,SDI)) Q:SDI'>0  D
 .S SDID=$P($G(^DPT(DFN,.02,SDI,0)),U,1)
 .S RACEIEN=$S(RACEIEN'="":RACEIEN_"|",1:"")_SDID
 .S RACENAM=$S(RACENAM'="":RACENAM_"|",1:"")_$P($G(^DIC(10,SDID,0)),U,1)
 Q
