WVRADWP ;HCIOFO/FT-Display Report Data from Related Packages  ;9/29/04  14:35
 ;;1.0;WOMEN'S HEALTH;**4,5,7,15,16**;Sep 30, 1998
 ;
 ; This routine uses the following IAs:
 ;  #2479 - FILE 74 fields      (private)
 ;  #2480 - FILE 70 fileds      (private)
 ; #10035 - ^DPT( references    (supported)
 ; #10070 - ^XMD                (supported)
 ;
EN ; Determine which report to show (i.e., radiology/nuclear medicine)
 ; Called from Edit a Procedure option screen form.
 D EX
 Q:'$G(DA)
 Q:'$D(^WV(790.1,+DA,0))
 N WV7901
 S WV7901=$E(^WV(790.1,+DA,0),1,2) ;first 2 characters of accession code
 Q:WV7901=""
 I "^BU^MB^MS^MU^PU^VU^"[WV7901 D EN1 Q  ;show rad/nm report data
 Q
EN1 ; Set up radiology report data and call FM Browser
 N LOOP,WVDUP,WVIENS,WVLCNT,WVRADCSE,WVRADDFN,WVRADDTE,WVRADIEN,WVRPTIEN
 N WVJCN,WVJCN1
 S WVRADIEN=$P(^WV(790.1,DA,0),U,15)
 Q:WVRADIEN=""  ;no 'radiology mam case #'
 S WVRADDFN=$P(^WV(790.1,DA,0),U,2)
 Q:'WVRADDFN  ;no dfn
 S WVRADDTE=$O(^RADPT("ADC",WVRADIEN,WVRADDFN,0))
 Q:'WVRADDTE  ;no inverse exam date
 S WVRADCSE=$O(^RADPT("ADC",WVRADIEN,WVRADDFN,WVRADDTE,0))
 Q:'WVRADCSE  ;no case number
 S WVRPTIEN=+$P(^RADPT(WVRADDFN,"DT",WVRADDTE,"P",WVRADCSE,0),U,17)
 Q:'WVRPTIEN  ;no report in File 74
 K ^TMP($J,"WV RADRPT"),^TMP("WV RADRPT",$J),^TMP($J,"WV CH")
 S WVIENS=WVRADCSE_","_WVRADDTE_","_WVRADDFN_"," ;iens for FILE 70 entry
 ; get clincal history from FILE 70
 D GETS^DIQ(70.03,WVIENS,400,"EIZ","^TMP($J,""WV CH"")")
 ; get data from FILE 74
 D GETS^DIQ(74,WVRPTIEN_",","*","EI","^TMP($J,""WV RADRPT"")")
 S ^TMP("WV RADRPT",$J,1,0)="                   DAY-CASE #: "_$G(^TMP($J,"WV RADRPT",74,WVRPTIEN_",",.01,"E"))_$S($$AMEND(WVRPTIEN):"                    (AMENDED REPORT)",1:"")
 S ^TMP("WV RADRPT",$J,2,0)="               EXAM DATE/TIME: "_^TMP($J,"WV RADRPT",74,WVRPTIEN_",",3,"E")
 S ^TMP("WV RADRPT",$J,3,0)="          VERIFYING PHYSICIAN: "_^TMP($J,"WV RADRPT",74,WVRPTIEN_",",9,"E")
 S ^TMP("WV RADRPT",$J,4,0)="                    PROCEDURE: "_^TMP($J,"WV RADRPT",74,WVRPTIEN_",",102,"E")
 S ^TMP("WV RADRPT",$J,5,0)="             CATEGORY OF EXAM: "_^TMP($J,"WV RADRPT",74,WVRPTIEN_",",104,"E")
 S ^TMP("WV RADRPT",$J,6,0)="                         WARD: "_^TMP($J,"WV RADRPT",74,WVRPTIEN_",",106,"E")
 S ^TMP("WV RADRPT",$J,7,0)=" TREATING SERVICE (INPATIENT): "_^TMP($J,"WV RADRPT",74,WVRPTIEN_",",107,"E")
 S ^TMP("WV RADRPT",$J,8,0)="             PRINCIPAL CLINIC: "_^TMP($J,"WV RADRPT",74,WVRPTIEN_",",108,"E")
 S ^TMP("WV RADRPT",$J,9,0)="      CONTRACT SHARING SOURCE: "_^TMP($J,"WV RADRPT",74,WVRPTIEN_",",109,"E")
 S ^TMP("WV RADRPT",$J,10,0)="PRIMARY INTERPRETING RESIDENT: "_^TMP($J,"WV RADRPT",74,WVRPTIEN_",",112,"E")
 S ^TMP("WV RADRPT",$J,11,0)="   PRIMARY INTERPRETING STAFF: "_^TMP($J,"WV RADRPT",74,WVRPTIEN_",",115,"E")
 S ^TMP("WV RADRPT",$J,12,0)="            PRIMARY DIAGNOSIS: "_^TMP($J,"WV RADRPT",74,WVRPTIEN_",",113,"E")
 S ^TMP("WV RADRPT",$J,13,0)="         REQUESTING PHYSICIAN: "_^TMP($J,"WV RADRPT",74,WVRPTIEN_",",114,"E")
 S ^TMP("WV RADRPT",$J,14,0)="                 COMPLICATION: "_^TMP($J,"WV RADRPT",74,WVRPTIEN_",",116,"E")
 S ^TMP("WV RADRPT",$J,15,0)=" "
 S ^TMP("WV RADRPT",$J,16,0)="CLINICAL HISTORY:"
 S LOOP=0,WVLCNT=16
 S WVDUP=$$COMPARE()
 I WVDUP=1 D  ;Clinical History text in files 70 & 74 are different
 .S LOOP=0
 .F  S LOOP=$O(^TMP($J,"WV CH",70.03,WVIENS,400,LOOP)) Q:'LOOP  D
 ..S WVLCNT=WVLCNT+1
 ..S ^TMP("WV RADRPT",$J,WVLCNT,0)=^TMP($J,"WV CH",70.03,WVIENS,400,LOOP,0)
 ..Q
 .I WVLCNT>16 D  ;insert blank line if different texts exist
 ..S WVLCNT=WVLCNT+1
 ..S ^TMP("WV RADRPT",$J,WVLCNT,0)=" "
 ..Q
 .S LOOP=0
 .F  S LOOP=$O(^TMP($J,"WV RADRPT",74,WVRPTIEN_",",400,LOOP)) Q:'LOOP  D
 ..S WVLCNT=WVLCNT+1
 ..S ^TMP("WV RADRPT",$J,WVLCNT,0)=^TMP($J,"WV RADRPT",74,WVRPTIEN_",",400,LOOP)
 ..Q
 .Q
 I WVDUP=0 D  ;Clinical History field is same
 .S LOOP=0
 .F  S LOOP=$O(^TMP($J,"WV RADRPT",74,WVRPTIEN_",",400,LOOP)) Q:'LOOP  D
 ..S WVLCNT=WVLCNT+1
 ..S ^TMP("WV RADRPT",$J,WVLCNT,0)=^TMP($J,"WV RADRPT",74,WVRPTIEN_",",400,LOOP)
 ..Q
 .Q
 S WVLCNT=WVLCNT+1
 S ^TMP("WV RADRPT",$J,WVLCNT,0)=" "
 S WVLCNT=WVLCNT+1
 S ^TMP("WV RADRPT",$J,WVLCNT,0)="IMPRESSION TEXT:"
 S LOOP=0
 F  S LOOP=$O(^TMP($J,"WV RADRPT",74,WVRPTIEN_",",300,LOOP)) Q:'LOOP  D
 .S WVLCNT=WVLCNT+1
 .S ^TMP("WV RADRPT",$J,WVLCNT,0)=^TMP($J,"WV RADRPT",74,WVRPTIEN_",",300,LOOP)
 .Q
 S WVLCNT=WVLCNT+1
 S ^TMP("WV RADRPT",$J,WVLCNT,0)=" "
 S WVLCNT=WVLCNT+1
 S ^TMP("WV RADRPT",$J,WVLCNT,0)="REPORT TEXT:"
 S LOOP=0
 F  S LOOP=$O(^TMP($J,"WV RADRPT",74,WVRPTIEN_",",200,LOOP)) Q:'LOOP  D
 .S WVLCNT=WVLCNT+1
 .S ^TMP("WV RADRPT",$J,WVLCNT,0)=^TMP($J,"WV RADRPT",74,WVRPTIEN_",",200,LOOP)
 .Q
 K ^TMP($J,"WV RADRPT"),WVLCNT,^WV(790.1,DA,9)
 S WVJCN=0 F  S WVJCN=$O(^TMP("WV RADRPT",$J,WVJCN)) Q:WVJCN'>0  D
 .S ^WV(790.1,DA,9,WVJCN,0)=$G(^TMP("WV RADRPT",$J,WVJCN,0)) S WVJCN1=WVJCN
 S ^WV(790.1,DA,9,0)="^^"_WVJCN1_"^"_WVJCN1
 K ^TMP("WV RADRPT",$J),^TMP($J,"WV CH")
 Q
EX ; delete existing radiology report text stored in WH
 K ^WV(790.1,DA,9)
 Q
MAIL(DFN,WVACCESS,WVPROC,WVPROV) ; Send mail message to case manager when
 ; Radiology procedure is added to WH Procedure file (#790.1).
 ; Called from WVRALINK
 ;      DFN -> Patient ien
 ; WVACCESS -> File 790.1 ien (procedure entry)
 ;   WVPROC -> File 790.2 ien (procedure type)
 ;   WVPROV -> File 200   IEN (provider/requestor)
 Q:'$G(DFN)!('$G(WVACCESS))!('$G(WVPROC))
 N WVCMGR,WVLOOP,WVMSG,XMDUZ,XMSUB,XMTEXT,XMY
 S WVCMGR=+$$GET1^DIQ(790,DFN,.1,"I") ;get case manager
 S:WVCMGR XMY(WVCMGR)=""
 ; if no case manager, then get default case manager(s)
 I 'WVCMGR S WVLOOP=0 F  S WVLOOP=$O(^WV(790.02,WVLOOP)) Q:'WVLOOP  D
 .S WVCMGR=$$GET1^DIQ(790.02,WVLOOP,.02,"I")
 .S:WVCMGR XMY(WVCMGR)=""
 .Q
 Q:$O(XMY(0))'>0  ;no case manager(s)
 ;S:WVPROV XMY(WVPROV)=""
 S XMDUZ=.5 ;message sender
 S XMSUB="RAD/NM added a procedure for a WH patient"
 S WVMSG(1)="        Patient: "_$P($G(^DPT(DFN,0)),U,1)_" (SSN: "_$$SSN^WVUTL1(DFN)_")"
 S WVMSG(2)=" WH Accession #: "_$P($G(^WV(790.1,+WVACCESS,0)),U,1)
 S WVMSG(3)="      Procedure: "_$P($G(^WV(790.2,+WVPROC,0)),U,1)
 S WVMSG(4)=" "
 S WVMSG(5)="Please use the 'Edit a Procedure' option in the WOMEN'S"
 S WVMSG(6)="HEALTH package to complete/close this procedure."
 I ($E($P(WVMSG(2),"#: ",2),1,2)="MB")!($E($P(WVMSG(2),"#: ",2),1,2)="MS")!($E($P(WVMSG(2),"#: ",2),1,2)="MU") D
 .S WVMSG(5)="Please use CPRS to resolve the Clinical Reminder for this procedure and"
 .S WVMSG(6)="complete the result."
 .Q
 S XMTEXT="WVMSG("
 D ^XMD
 Q
AMEND(WVRPTIEN) ; Check if RAD/NM report is amended.
 ; WVRPTIEN - File 74 ien
 N WVAMEND
 K ^TMP("DILIST",$J),^TMP("DIERR",$J)
 D LIST^DIC(74.06,","_WVRPTIEN_",",.01)
 S WVAMEND=$O(^TMP("DILIST",$J,0))
 K ^TMP("DILIST",$J),^TMP("DIERR",$J)
 Q WVAMEND
 ;
COMPARE() ; Compares Clincal History fields in files 70 & 74
 ; Returns 1 (different) or 0 (same)
 N LOOP,WVFLAG,WV70CNT,WV70IEN,WV74CNT,WV74IEN,WVNODE70,WVNODE74
 S (LOOP,WV70CNT,WV74CNT,WVFLAG)=0
 S WV70IEN=WVIENS,WV74IEN=WVRPTIEN_","
 I '$O(^TMP($J,"WV CH",70.03,WV70IEN,400,0)) S WVFLAG=WVFLAG+1
 I '$O(^TMP($J,"WV RADRPT",74,WV74IEN,400,0)) S WVFLAG=WVFLAG+1
 I WVFLAG=1 Q 1  ;different (field was purged in one file, exists in
 ;                the other file)
 I WVFLAG=2 Q 0  ;same (field was purged in 70 & 74)
 F  S LOOP=$O(^TMP($J,"WV CH",70.03,WV70IEN,400,LOOP)) Q:'LOOP  D
 .S WV70CNT=WV70CNT+1
 .Q
 S LOOP=0
 F  S LOOP=$O(^TMP($J,"WV RADRPT",74,WV74IEN,400,LOOP)) Q:'LOOP  D
 .S WV74CNT=WV74CNT+1
 .Q
 I WV70CNT'=WV74CNT Q 1  ;line counts are different
 S LOOP=0
 F  S LOOP=$O(^TMP($J,"WV CH",70.03,WV70IEN,400,LOOP)) Q:'LOOP!(WVFLAG=1)  D
 .S WVNODE70=$G(^TMP($J,"WV CH",70.03,WV70IEN,400,LOOP,0))
 .S WVNODE74=$G(^TMP($J,"WV RADRPT",74,WV74IEN,400,LOOP))
 .I WVNODE70'=WVNODE74 S WVFLAG=1
 .Q
 Q WVFLAG
 ;
