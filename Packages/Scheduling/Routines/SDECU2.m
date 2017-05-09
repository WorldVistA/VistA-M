SDECU2 ;ALB/SAT - VISTA SCHEDULING RPCS ;MAR 15, 2017
 ;;5.3;Scheduling;**627,658**;Aug 13, 1993;Build 23
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
FLAGS(DFN,FNUM) ;get PRF flags
 ;INPUT:
 ; DFN  - Patient ID
 ; FNUM - PRF Flag file ID  26.15=PRF NATIONAL FLAG  26.11=PRF LOCAL FLAG
 ;RETURN:
 ;  Each | piece contains the following ;; pieces:
 ;   1. PRFAID   - PRF Assignment ID pointer to PRF ASSIGNMENT file (#26.13)
 ;   2. PRFSTAT  - PRF Assignment Status 0=INACTIVE 1=ACTIVE
 ;   3. PRFLID   - PRF Local Flag ID pointer to PRF LOCAL FLAG file (#26.11)
 ;   4. PRFLNAME - PRF Local Flag name
 ;   5. PRFLSTAT - PRF Local Flag status  0=INACTIVE 1=ACTIVE
 ;
 N PRFAID,PRFID,PRFLST,RET
 S RET=""
 S DFN=$G(DFN)
 Q:DFN="" ""
 Q:'$D(^DPT(DFN,0)) ""
 S FNUM=$G(FNUM)
 Q:(FNUM'=26.15)&(FNUM'=26.11) ""
 D FLST(.PRFLIST,FNUM)
 S PRFID="" F  S PRFID=$O(PRFLIST(PRFID)) Q:PRFID=""  D
 .S PRFAID="" F  S PRFAID=$O(^DGPF(26.13,"AFLAG",PRFID,DFN,PRFAID)) Q:PRFAID=""  D
 ..S RET=RET_$S(RET'="":"|",1:"")_PRFAID_";;"_$$GET1^DIQ(26.13,PRFAID_",",.03,"I")_";;"_+PRFID_";;"_$P(PRFLIST(PRFID),U,1)_";;"_$P(PRFLIST(PRFID),U,2)
 Q RET
FLST(PRFLIST,FNUM)  ;build flag list
 N PRFID,PRFN
 K PRFLIST
 S PRFN="" F  S PRFN=$O(^DGPF(FNUM,"B",PRFN)) Q:PRFN=""  D
 .S PRFID="" F  S PRFID=$O(^DGPF(FNUM,"B",PRFN,PRFID)) Q:PRFID=""  D
 ..S PRFLIST(PRFID_";DGPF("_FNUM_",")=$$GET1^DIQ(FNUM,PRFID_",",.01)_U_$$GET1^DIQ(FNUM,PRFID_",",.02,"I")
 Q
 ;
GAF(DFN) ;determine if GAF score needed
 N GAF,GAFR
 S GAFR=""
 S GAF=$$NEWGAF^SDUTL2(DFN)
 S:GAF="" GAF=-1
 S $P(GAFR,"|",1)=$S(+GAF:"New GAF Required",1:"No new GAF required")
 ;S $P(GAFR,"|",2)=$P(GAF,U,2)   ;alb/sat 658 removed 4 lines
 ;S $P(GAFR,"|",3)=$$FMTE^XLFDT($P(GAF,U,3))
 ;S $P(GAFR,"|",4)=$P(GAF,U,4)
 ;S $P(GAFR,"|",5)=$P($G(^VA(200,+$P(GAF,U,4),0)),U,1)
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
