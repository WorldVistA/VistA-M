PSOCLOU ; HEC/hrub - clozapine support utilities ;26 DEC 2019 6:26:10
 ;;7.0;OUTPATIENT PHARMACY;**457,574**;DEC 1997;Build 53
 ;
 ; 29 April 2019 - code moved from PSOCLO1 for PSO*7*457
 ;
 Q
 ;
ANCWARN(PSOYS) ; ANC warnings
 I PSOYS("rANC")<1000 W !,"Test ANC labs daily until levels stabilize to ANC greater than or equal to 1000.",! Q
 I PSOYS("rANC")<1500 W !,"Test ANC labs 3x weekly until levels stabilize to greater than or equal to 1500.",!
 Q
 ;
NOTAUTH ;
 W !!,"You Are Not Authorized to Override! See Clozapine Manager with PSOLOCKCLOZ key."
 Q
 ;
AUTHMSG ;
 W !!,"Permission to dispense clozapine has been authorized by NCCC.",!
 Q
 ;
CLOZDISP(PRVDRIEN) ; Boolean function, does PRVDRIEN have (DEA# or VA#) and the YSCL AUTHORIZED key?
 ;
 Q:'($G(PRVDRIEN)>0) ""  ; return null for bad input
 N NMBR,RSLT,X S RSLT=0,NMBR=0
 ; providers may have both DEA# and VA#
 S:$L($$GET1^DIQ(200,PRVDRIEN,53.2)) NMBR=NMBR+1  ; (#53.2) DEA# [2F]
 S:$L($$GET1^DIQ(200,PRVDRIEN,53.3)) NMBR=NMBR+1  ; (#53.3) VA# [3F]
 I NMBR S:$D(^XUSEC("YSCL AUTHORIZED",PRVDRIEN)) RSLT=1
 Q RSLT
 ;
CLZPTNFO(PTNFO,CLZDFN) ; clozapine patient info, PTNFO passed by ref.
 ;
 Q:'($G(CLZDFN)>0)  ; must have DFN
 N C,IEN,X K PTNFO
 S PTNFO(55,"pharmDFN")=$$GET1^DIQ(55,CLZDFN,.01,"I") D:PTNFO(55,"pharmDFN")  ; if patient in file #55
 . S PTNFO(55,"clozReg#")=$$GET1^DIQ(55,CLZDFN,53)  ; (#53) CLOZAPINE REGISTRATION NUMBER
 . S PTNFO(55,"clozStatus")=$$GET1^DIQ(55,CLZDFN,54,"I")  ; (#54) CLOZAPINE STATUS
 . S PTNFO(55,"clozPrvdr")=$$GET1^DIQ(55,CLZDFN,57,"I")  ; (#57) RESPONSIBLE PROVIDER
 . S PTNFO(55,"clozRegDt")=$$GET1^DIQ(55,CLZDFN,58,"I")  ; (#58) REGISTRATION DATE
 ;
 Q:'PTNFO(55,"pharmDFN")  ; stop if not in file #55
 ;
 I $L($G(XQY0)) D
 . S:XQY0["PSO" PTNFO("pharmStat")="OUT"
 . S:XQY0["PSJ" PTNFO("pharmStat")="IN"
 ;
 S PTNFO(2,"wardLoc")=$$GET1^DIQ(2,CLZDFN,.1)  ; (#.1) WARD LOCATION
 ;
 S X=$$CL^YSCLTST2(CLZDFN),PTNFO("lab","WBC")="",PTNFO("lab","ANC")="",PTNFO("labNm","WBC")="",PTNFO("labNm","ANC")=""
 I '(X<0) D  ; lab test names and results
 . S PTNFO("ysRslt")=X,PTNFO("lab","dt")=$P(X,U,6)
 . S PTNFO("labNm","WBC")=$P(X,U,3) S:$L(PTNFO("labNm","WBC")) PTNFO("lab","WBC")=+$P(X,U,2)
 . S PTNFO("labNm","ANC")=$P(X,U,5) S:$L(PTNFO("labNm","ANC")) PTNFO("lab","ANC")=+$P(X,U,4)
 ;
 S C=0,IEN=0  ; entry count & ien
 F  S IEN=$O(^YSCL(603.01,"C",CLZDFN,IEN)) Q:'IEN  S C=C+1 D  ; get file #603.01 info, may be duplicates
 . S PTNFO(603.01,IEN,"cloz#")=$$GET1^DIQ(603.01,IEN,.01)  ; (#.01) CLOZAPINE REGISTRATION NUMBER
 . S PTNFO(603.01,IEN,"clozDFN")=$$GET1^DIQ(603.01,IEN,1,"I")  ; (#1) CLOZAPINE PATIENT
 . S PTNFO(603.01,IEN,"dispFrq")=$$GET1^DIQ(603.01,IEN,2,"I")  ; (#2) DISPENSE FREQUENCY
 . S PTNFO(603.01,IEN,"ovrdDt")=$$GET1^DIQ(603.01,IEN,3,"I")  ; (#3) OVERRIDE DATE
 ;
 S PTNFO(603.01,0,"total")=C
 ;
 Q
 ;
FINDNEXT() ; Find the next pseudo Clozapine registration number, return -1 if none left
 D DT^DICRW
 N N,NUM,PRFIX,RGRSLT,RGZRO,STNUM,Y
 D XTMPZRO
 S STNUM=+$P($$SITE^VASITE,U,3),RGZRO=$G(^XTMP("PSJ CLOZ",0)),Y=$P(RGZRO,U,4)
 S PRFIX=$E(Y)  ; last temp registration prefix
 I '(PRFIX]"A") S N=0,Y=STNUM_"999" D  I N Q -1  ; no more temp numbers
 . S:$D(^XTMP("PSJ CLOZ","B",Y)) N=1 Q:N
 . S:$D(^YSCL(603.01,"B",Y)) N=1 Q:N
 . S:$D(^PS(55,"ASAND1",Y)) N=1
 S:'(PRFIX?1U) PRFIX="Z"  ; start at Z if no prefix found
 S N=0 F  L +^XTMP("PSJ CLOZ",0):DILOCKTM S Y=$T Q:Y!(N>2)  S N=N+Y  ; try until LOCK or 3 attempts
 I 'Y Q -1  ; couldn't get a LOCK 
 ;ajf ; Defect 1181858 - Setting temp number 
 ;S NUM=+$E(RGZRO,5,7)  ; numeric value after station #
 S NUM=+$E($P(RGZRO,"^",4),5,7)  ; numeric value after station #
 I (NUM<0)!(NUM>998) S NUM=0  ; adjust if needed
 S RGRSLT=""  ; registration number to return
 F  D  Q:$L(RGRSLT)
 . S N=1000+NUM  ; pad NUM
 . S Y=PRFIX_STNUM_($E(N,2,4))  ; potential registration number
 . ; check if registration number in use
 . I '$D(^XTMP("PSJ CLOZ","B",Y)),'$D(^YSCL(603.01,"B",Y)),'$D(^PS(55,"ASAND1",Y)) S RGRSLT=Y Q
 . S NUM=NUM+1 Q:NUM<1000  ; keep looking on same prefix
 . S Y=$E(PRFIX),Y=$C($A(Y)-1),PRFIX=Y ; make 1st char. of prefix previous ASCII character
 . I ("A"]PRFIX) S RGRSLT=-1  Q  ; No more pseudo numbers left
 . S NUM=0  ; reset counter
 ;
 L -^XTMP("PSJ CLOZ",0)
 Q RGRSLT
 ;
LABRSLT(DFN,PSOYS,CLOZPAT) ; get lab tests
 ; PSOYS, CLOZPAT both passed by ref.
 N X
 S PSOYS=$$CL^YSCLTST2(DFN),PSOYS("rWBC")="",PSOYS("rANC")=""
 D:'(PSOYS<0)  ; if less than zero no lab tests
 . S X=$P(PSOYS,U,2) S:$L(X) PSOYS("rWBC")=+X  ; WBC result
 . S X=$P(PSOYS,U,4) S:$L(X) PSOYS("rANC")=+X  ; ANC result
 S X=$P(PSOYS,U,7),CLOZPAT=$S(X="M":2,X="B":1,1:0)
 Q
 ;
OVRDRSN(DFN,PSOYS,PSCLZREG,CLOZPAT) ; function, return override reason
 ;PSOYS, PSCLZREG, CLOZPAT passed by ref.
 N OVRDRSN S OVRDRSN=""
 ;
 D LABRSLT(DFN,.PSOYS,.CLOZPAT)  ; update lab results
 S PSCLZREG=$$GET1^DIQ(55,DFN,53),PSCLZREG("status55")=$$GET1^DIQ(55,DFN,54,"I")
 ;
 I $$OVERRIDE^YSCLTST2(DFN,0) S OVRDRSN=7  ; NCCC AUTHORIZED
 ; no reg # or (temp. reg # and active)
 I 'OVRDRSN,PSCLZREG=""!((PSCLZREG?1U6N)&(PSCLZREG("status55")="A")) D
 . Q:PSOYS("rANC")<1500  ; must be at least 1500
 . Q:'$L(PSOYS("rWBC"))  ; must have WBC result (any value)
 . S OVRDRSN=8  ; REGISTER NON-DUTY HR/WEEKEND (MAX4DAY)
 ;
 I 'OVRDRSN,PSCLZREG("status55")="A",PSCLZREG?2U5N D  ; active, normal reg #
 . ; if no ANC reult, return 9
 . I '($L(PSOYS("rANC")))  S OVRDRSN=9 Q  ;PRESCRIBER APPROVED 4 DAY SUPPLY
 ;
 I 'OVRDRSN,PSCLZREG("status55")="A",PSCLZREG?2U5N D  ; active, normal reg #
 . I PSOYS("rANC")<1500&'(PSOYS("rANC")<1000) S OVRDRSN=10  ; MILD NEUTROPENIA PRESCRIBER APPROVED
 ;
 Q OVRDRSN
 ;
OVRDTMBR ; select override team member, returned in PSSPHARM
 S ANQX=0  ; flag, exit clozapine logic
 S PSSPHARM=""  ; null if no selection
 N CNT,DIR,IEN,LPXIT,PSOTMND,R,V,X,Y
 S PSOTMND="PSO CLOZ TEAM"
 K ^TMP($J,PSOTMND)
 S ^TMP($J,PSOTMND,0,"date")=$P($$FMTE^XLFDT($$NOW^XLFDT),"@")
 S ^TMP($J,PSOTMND,0,"duzXcld")=0  ; indicates user was excluded
 ; create alphabetic list of key holders
 S IEN=0 F  S IEN=$O(^XUSEC("PSOLOCKCLOZ",IEN)) Q:'IEN  D
 . I IEN=DUZ S ^TMP($J,PSOTMND,0,"duzXcld")=IEN Q  ; set flag, exclude user from list
 . Q:$$GET1^DIQ(200,IEN_",",7,"I")  ; (#7) DISUSER [7S], skip if set
 . S X=$$GET1^DIQ(200,IEN_",",2,"I") Q:X=""  ; (#2) ACCESS CODE [3F], skip if null
 . S X=$$GET1^DIQ(200,IEN_",",.01) Q:X=""
 . S ^TMP($J,PSOTMND,"B",X,IEN)=""
 ; count members, create numeric list
 S CNT=0,V=$NA(^TMP($J,PSOTMND,"B"))
 F  S V=$Q(@V) Q:V=""  Q:'($QS(V,2)=PSOTMND)  D
 . S IEN=$QS(V,5),Y=$QS(V,4)_" (user #"_IEN_")"
 . S CNT=CNT+1,^TMP($J,PSOTMND,CNT)=Y
 . S ^TMP($J,PSOTMND,CNT,"IEN")=IEN
 ;
 S ^TMP($J,PSOTMND,0)=CNT
 I CNT=0 D  Q
 . S ANQX=1  ; no member selected
 . W !!,"No active approving members available"_$S(^TMP($J,PSOTMND,0,"duzXcld"):" (other than you).",1:".")
 . S DIR(0)="EA",DIR("A")="Enter: " D ^DIR
 . K ^TMP($J,PSOTMND)
 ;
 S LPXIT=0 F  D  Q:LPXIT
 . D DISPTM(PSOTMND)
 . N MMBRNO K DIR S R=^TMP($J,PSOTMND,0)
 . S DIR(0)="NA^1:"_R,DIR("A")="Select Approving Team Member or '^' to exit (1-"_R_"): "
 . S DIR("?")="Enter an integer to select from the list"_$S(^TMP($J,PSOTMND,0,"duzXcld"):" (you were excluded).",1:".")
 . S DIR("A",1)=" " D ^DIR
 . I 'Y!$D(DUOUT)!$D(DTOUT) S ANQX=1,LPXIT=1 Q  ; no member selected
 . S MMBRNO=Y
 . K DIR S DIR(0)="YA",DIR("A")="Is this correct? ",DIR("B")="NO"
 . S DIR("A",1)=" ",DIR("A",2)="You selected "_^TMP($J,PSOTMND,MMBRNO)
 . D ^DIR I $D(DUOUT)!$D(DTOUT) S LPXIT=1,ANQX=1 Q  ; time out or '^', no member selected
 . Q:'Y  S PSSPHARM=^TMP($J,PSOTMND,MMBRNO,"IEN"),LPXIT=1
 ;
 K ^TMP($J,PSOTMND)  ; clean up
 Q
 ;
DISPTM(PSOTMND) ; display team members
 Q:$G(PSOTMND)=""
 Q:'$G(^TMP($J,PSOTMND,0))  ; nothing to display
 N CNT,DIR,DUOUT,LPXIT,R
 W !!,"    Clozapine Team Members   "_$G(^TMP($J,PSOTMND,0,"date")),!
 S (CNT,LPXIT,R)=0
 F  S CNT=$O(^TMP($J,PSOTMND,CNT)) Q:'CNT!LPXIT  S Y=^(CNT) D
 . S R=R+1 W !,$J(CNT,3)_". "_Y Q:(R<20)  ; display 20 at a time
 . Q:'$O(^TMP($J,PSOTMND,CNT))  ; nothing left to display
 . K DIR,DUOUT S DIR(0)="EA",DIR("A")="<ENTER> to see more members, '^' to exit: "
 . D ^DIR S R=0 S:$D(DUOUT) LPXIT=1
 ;
 Q
 ;
CRXTMP(DFN,PSOYS) ; create XTMP entry for 4 day supply tracking
 I $G(DFN) D CRXTMP^PSOCLUTL(DFN,PSOYS)
 Q
CRXTMPI(DFN,PSOYS) ; create XTMP entry for 4 day supply tracking
 I $G(DFN) D CRXTMPI^PSOCLUTL(DFN,PSOYS)
 Q
 ; ** NCC REMEDIATION add new reasons 8-11 ** 457/RTW  11 ;;EMERGENCY OVERRIDE NO ANC LAST 7 DAYS
OVRDTXT(RSNCODE) ; function, return text for override
 Q:'($G(RSNCODE)>0) ""  ; no reason code, return null
 Q:$G(RSNCODE)=1 "NO WBC IN LAST 7 DAYS"
 Q:$G(RSNCODE)=2 "NO VERIFIED WBC"
 Q:$G(RSNCODE)=3 "LAST WBC RESULT < 3500"
 Q:$G(RSNCODE)=4 "3 SEQ. WBC DECREASE"
 Q:$G(RSNCODE)=5 "LAST ANC RESULT < 2000"
 Q:$G(RSNCODE)=6 "SEQ. ANC DECREASE"
 Q:$G(RSNCODE)=7 "NCCC AUTHORIZED"
 Q:$G(RSNCODE)=8 "REGISTER NON-DUTY HR/WEEKEND (MAX 4DAY)"
 Q:$G(RSNCODE)=9 "PRESCRIBER APPROVED 4 DAY SUPPLY"
 Q:$G(RSNCODE)=10 "MILD NEUTROPENIA PRESCRIBER APPROVED"
 Q ""  ; shouldn't get here, return null
 ;
HASKEY(USRNUM) ; Boolean function, does USRNUM hold the PSOLOCKCLOZ security key?
 I '($G(USRNUM)>0) S USRNUM=DUZ  ; default to current user
 Q $D(^XUSEC("PSOLOCKCLOZ",USRNUM))
 ;
XTMPZRO ;set zero node in ^XTMP("PSJ CLOZ")
 N Y
 S Y=$$FMADD^XLFDT($$DT^XLFDT,366)  ; one year (366 days) in the future
 S $P(^XTMP("PSJ CLOZ",0),U)=Y,$P(^XTMP("PSJ CLOZ",0),U,2)=DT,$P(^XTMP("PSJ CLOZ",0),U,3)="CLOZAPINE WEEKEND REGISTRATION"
 Q
 ;
