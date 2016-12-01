GMPLCLN ;ISP/TC - Problem File Cleanup Utilities ;01/21/16  09:31
 ;;2.0;Problem List;**40**;Aug 25, 1994;Build 9
 ;
 ;
 ; External References
 ;    BROWSE^DDBR           ICR   2607
 ;    XMZ^XMA2              ICR  10066
 ;    ENT1^XMD              ICR  10070
 ;    $$NOW^XLFDT           ICR  10103
 ;    $$FMADD^XLFDT         ICR  10103
 ;    $$FMTE^XLFDT          ICR  10103
 ;    $$REPEAT^XLFSTR       ICR  10104
 ;    $$LJ^XLFSTR           ICR  10104
 ;    MES^XPDUTL            ICR  10141
 ;
BLDLEMSG(GMPLMSG,GMPLNERR,GMPLFROM,GMPLNODE) ; Build Lock Error MailMan message and send to installer
 N GMPLTO,GMPXMSUB,SUB,GMPMAXER,GMPLEND,GMPI,GMPJ,GMPK,GMPCNT,GMPCNTR
 S GMPCNT=4,GMPK=""
 I GMPLNERR=0 Q
 S GMPMAXER=200
 K ^TMP("GMPXMZLE",$J)
 S SUB="GMPXMZLE"
 S ^TMP(SUB,$J,1,0)="A lock on the following record entries could not be obtained because another"
 S ^TMP(SUB,$J,2,0)="user was editing the entry. As a result these entries could not be corrected/"
 S ^TMP(SUB,$J,3,0)="updated."
 S ^TMP(SUB,$J,4,0)=""
 I $D(GMPLMSG) D
 . F  S GMPK=$O(GMPLMSG(GMPK)) Q:'GMPK  D
 . . S GMPCNT=GMPCNT+1
 . . S ^TMP(SUB,$J,GMPCNT,0)=$G(GMPLMSG(GMPK))
 S GMPCNT=GMPCNT+1
 I $D(GMPLMSG) S ^TMP(SUB,$J,GMPCNT,0)=""
 S GMPLEND=$S(GMPLNERR'>GMPMAXER:GMPLNERR+GMPCNT,1:GMPMAXER)
 S GMPLEND=$S(GMPLNERR'>GMPMAXER:GMPLEND-1,1:GMPLEND)
 S GMPJ=GMPLNERR+1
 F GMPI=GMPCNT:1:GMPLEND D
 . S GMPJ=GMPJ-1,GMPCNTR=$S($D(GMPLMSG):GMPI+1,1:GMPI)
 . S ^TMP(SUB,$J,GMPCNTR,0)=^TMP(GMPLNODE,$J,GMPJ,0)
 I GMPLEND=GMPMAXER S ^TMP(SUB,$J,GMPMAXER+1,0)="Maximum number of errors reached, will not report anymore."
 K ^TMP(GMPLNODE,$J)
 S GMPXMSUB="Lock Errors during Problem File Cleanup"
 S GMPLTO(DUZ)=""
 D SEND(SUB,GMPXMSUB,.GMPLTO,GMPLFROM)
 Q
BLDNEMSG(GMPLMSG,GMPLSUB,GMPLFROM,GMPLRNTM) ; Build No Error Found MailMan message and send to installer
 N GMPLTO,SUB,GMPJ,GMPCNT S GMPJ="",GMPCNT=3
 K ^TMP("GMPXMZNE",$J)
 S SUB="GMPXMZNE"
 S GMPLTO(DUZ)=""
 S ^TMP(SUB,$J,1,0)="A scan of your system's Problem file #9000011 has been performed on:"
 S ^TMP(SUB,$J,2,0)=""_$$FMTE^XLFDT(GMPLRNTM,1)_""
 S ^TMP(SUB,$J,3,0)=""
 I $D(GMPLMSG) D
 . F  S GMPJ=$O(GMPLMSG(GMPJ)) Q:'GMPJ  D
 . . S GMPCNT=GMPCNT+1
 . . S ^TMP(SUB,$J,GMPCNT,0)=$G(GMPLMSG(GMPJ))
 D SEND(SUB,GMPLSUB,.GMPLTO,GMPLFROM)
 Q
BLDERMSG(GMPLNERR) ; Build MailMan error message content and send to installer
 N GMPLTO,GMPLFROM,GMPXMSUB,SUB
 K ^TMP("GMPLXMZE",$J)
 S SUB="GMPLXMZE"
 S GMPXMSUB="Problem File Error Scan Complete"
 S GMPLFROM="GMPL*2.0*40 INSTALL"
 S GMPLTO(DUZ)=""
 S ^TMP(SUB,$J,1,0)="A scan of your system's Problem file #9000011 has been performed for possible"
 S ^TMP(SUB,$J,2,0)="errors. There are "_GMPLNERR_" record entries that contain a SNOMED CT concept code"
 S ^TMP(SUB,$J,3,0)="in the Diagnosis field #.01."
 S ^TMP(SUB,$J,4,0)=""
 S ^TMP(SUB,$J,5,0)="To see a report of these records, please access the SNOMED in Diagnosis Field"
 S ^TMP(SUB,$J,6,0)="Error Report [GMPL DIAG ERROR REPORT] which is attached to the Problem List Mgt"
 S ^TMP(SUB,$J,7,0)="Menu [GMPL MGT MENU]."
 S ^TMP(SUB,$J,8,0)=""
 S ^TMP(SUB,$J,9,0)="These record entries will initially be corrected with the installation of"
 S ^TMP(SUB,$J,10,0)="GMPL*2.0*40 or by running the Generate SNOMED in Diagnosis Field Err/Cleanup"
 S ^TMP(SUB,$J,11,0)="Rpt [GMPL GENERATE DIAG RPTS] menu option off the Problem List Mgt Menu."
 S ^TMP(SUB,$J,12,0)=""
 S ^TMP(SUB,$J,13,0)="Once the cleanup is complete, a separate MailMan message will be sent to the"
 S ^TMP(SUB,$J,14,0)="installer containing instructions on how to access the cleanup report."
 D SEND(SUB,GMPXMSUB,.GMPLTO,GMPLFROM)
 Q
BLDCLMSG(GMPLMSG,GMPLSUB,GMPLFROM,GMPLNCLN) ; Build MailMan cleanup message content and send to installer
 N GMPLTO,SUB,GMPJ,GMPCNT S GMPJ="",GMPCNT=3
 K ^TMP("GMPLXMZC",$J)
 S SUB="GMPLXMZC"
 S GMPLTO(DUZ)=""
 S ^TMP(SUB,$J,1,0)="A cleanup of the Problem file has been performed and "_GMPLNCLN_" record"
 S ^TMP(SUB,$J,2,0)="entries have been corrected."
 S ^TMP(SUB,$J,3,0)=""
 I $D(GMPLMSG) D
 . F  S GMPJ=$O(GMPLMSG(GMPJ)) Q:'GMPJ  D
 . . S GMPCNT=GMPCNT+1
 . . S ^TMP(SUB,$J,GMPCNT,0)=$G(GMPLMSG(GMPJ))
 D SEND(SUB,GMPLSUB,.GMPLTO,GMPLFROM)
 Q
BLDRPMSG(GMPLNERR,GMPLRNTM) ; Build Error Report Mailman Message and send to installer
 N GMPLTO,GMPLFROM,GMPXMSUB,SUB,GMPLREC,GMPLCNT,GMPLDA S GMPLCNT=20,GMPLDA=""
 K ^TMP("GMPLXMZR",$J)
 S SUB="GMPLXMZR"
 S GMPXMSUB="Incorrect Mapping Report"
 S GMPLFROM="GMPL*2.0*40 INSTALL"
 S GMPLTO(DUZ)=""
 S ^TMP(SUB,$J,1,0)=""
 S ^TMP(SUB,$J,2,0)="Problem file scan runtime: "_$$FMTE^XLFDT(GMPLRNTM,1)
 S ^TMP(SUB,$J,3,0)=""
 S ^TMP(SUB,$J,4,0)="A scan of your system's Problem file #9000011 has been performed for possible"
 S ^TMP(SUB,$J,5,0)="errors. There are "_GMPLNERR_" record entries that contain an incorrect SNOMED CT"
 S ^TMP(SUB,$J,6,0)="428283002 to ICD-9-CM V15.89 code mapping for the term ""History of polyp of"
 S ^TMP(SUB,$J,7,0)="colon"". As a result the V15.89 code is incorrectly stored in the Diagnosis"
 S ^TMP(SUB,$J,8,0)="field #.01."
 S ^TMP(SUB,$J,9,0)=""
 S ^TMP(SUB,$J,10,0)="This report contains a list of these erroneous record entries which will be"
 S ^TMP(SUB,$J,11,0)="corrected after the installation of GMPL*2.0*40. Once the cleanup is complete,"
 S ^TMP(SUB,$J,12,0)="the correct V12.72 code will be stored in the Diagnosis field."
 S ^TMP(SUB,$J,13,0)=""
 S ^TMP(SUB,$J,14,0)="**ATTENTION CACs!!**: Once the cleanup is complete, please also review the"
 S ^TMP(SUB,$J,15,0)="Colonoscopy clinical reminders for the corresponding patients and verify that"
 S ^TMP(SUB,$J,16,0)="the corrections have been updated appropriately for those as well."
 S ^TMP(SUB,$J,17,0)=""
 S ^TMP(SUB,$J,18,0)=""
 S ^TMP(SUB,$J,19,0)="IEN"_$J("PATIENT",22)_$J("PROVIDER NARRATIVE",44)
 S ^TMP(SUB,$J,20,0)=$$REPEAT^XLFSTR("-",15)_$J($$REPEAT^XLFSTR("-",30),33)_$J($$REPEAT^XLFSTR("-",28),31)
 F  S GMPLDA=$O(^TMP("GMPLVCDE",$J,GMPLDA)) Q:'GMPLDA  D
 . S GMPLREC=$G(^TMP("GMPLVCDE",$J,GMPLDA)),GMPLCNT=GMPLCNT+1
 . S ^TMP(SUB,$J,GMPLCNT,0)=$$LJ^XLFSTR($G(GMPLDA),18)_$$LJ^XLFSTR($P(GMPLREC,U,1),33)_$$LJ^XLFSTR($P(GMPLREC,U,2),28)
 D SEND(SUB,GMPXMSUB,.GMPLTO,GMPLFROM)
 Q
SEND(GMPLNODE,GMPLSUB,GMPLTO,GMPLFROM) ; Send a MailMan message whose text is in
 ;^TMP(GMPLNODE,$J,N,0). GMPLSUB is the subject. GMPLTO is the optional
 ;list of addresses, setup exactly like ;the MailMan XMY array.
 ;GMPLFROM is the optional message from, if it is not defined then from will be
 ;Problem List Support. This can be free text or a DUZ.
 ;
 N GMPLNL,XMDUZ,XMSUB,XMY,XMZ
 ;
 ;Make sure the subject does not exceed 64 characters.
 S XMSUB=$E(GMPLSUB,1,64)
 ;
 ;Make the default sender Problem List.
 S XMDUZ=$S($G(GMPLFROM)="":"Problem List Support",1:GMPLFROM)
 ;
RETRY ;Get the message number.
 D XMZ^XMA2
 I XMZ<1 G RETRY
 ;
 ;Load the message
 M ^XMB(3.9,XMZ,2)=^TMP(GMPLNODE,$J)
 K ^TMP(GMPLNODE,$J)
 S GMPLNL=$O(^XMB(3.9,XMZ,2,""),-1)
 S ^XMB(3.9,XMZ,2,0)="^3.92^"_+GMPLNL_U_+GMPLNL_U_DT
 ;
 ;Send message to TO list if it is defined.
 I $D(GMPLTO) M XMY=GMPLTO D ENT1^XMD Q
 ;
BLDERRPT(GMPLNERR,GMPLRNTM) ; Build Error Report
 N GMPDLM,GMPDA,GMPX,GMPJ,SUB,GMPLPSUB S (GMPDLM,GMPDA)="",GMPJ=20
 S GMPLPSUB=$O(^XTMP("GMPLERPT;"))
 I GMPLPSUB["GMPLERPT" K ^XTMP(GMPLPSUB)
 S SUB="GMPLERPT;"_$H
 S ^XTMP(SUB,0)=$$FMADD^XLFDT($$NOW^XLFDT,30)_U_$$NOW^XLFDT()_U_"SNOMED in Diagnosis Field Error Rpt"
 S ^XTMP(SUB,1,0)=""
 S ^XTMP(SUB,2,0)="**NOTE**: This report is retroactive as of the last Problem file scan runtime:"
 S ^XTMP(SUB,3,0)=""_$$FMTE^XLFDT(GMPLRNTM,1)_". This report will expire and be purged from the system in"
 S ^XTMP(SUB,4,0)="30 days. If the Generate SNOMED in Diagnosis Field Err/Cleanup Rpt [GMPL"
 S ^XTMP(SUB,5,0)="GENERATE DIAG RPTS] menu option is run prior to the 30 days, then this report"
 S ^XTMP(SUB,6,0)="will expire on the date/time the option is run. Whichever comes first."
 S ^XTMP(SUB,7,0)=""
 S ^XTMP(SUB,8,0)="A scan of your system's Problem file #9000011 has been performed for possible"
 S ^XTMP(SUB,9,0)="errors. The following "_GMPLNERR_" record entries contain a SNOMED CT concept code"
 S ^XTMP(SUB,10,0)="in the Diagnosis field #.01. This report contains 4 columns. Please scroll to"
 S ^XTMP(SUB,11,0)="the right to see a full display of the Problem text."
 S ^XTMP(SUB,12,0)=""
 S ^XTMP(SUB,13,0)="These record entries will be corrected and upon completion, a separate MailMan"
 S ^XTMP(SUB,14,0)="message will be sent to the installer containing instructions on how to access"
 S ^XTMP(SUB,15,0)="the cleanup report."
 S ^XTMP(SUB,16,0)=""
 S ^XTMP(SUB,17,0)=""
 S ^XTMP(SUB,18,0)=$J("DATE LAST",27)
 S ^XTMP(SUB,19,0)="IEN"_$J("MODIFIED",23)_$J("DIAGNOSIS",16)_$J("PROBLEM",19)
 S ^XTMP(SUB,20,0)=$$REPEAT^XLFSTR("-",15)_$J($$REPEAT^XLFSTR("-",12),15)_$J($$REPEAT^XLFSTR("-",18),21)_$J($$REPEAT^XLFSTR("-",25),28)
 F  S GMPDLM=$O(^TMP("GMPLSCT",$J,GMPDLM)) Q:'GMPDLM  D
 . F  S GMPDA=$O(^TMP("GMPLSCT",$J,GMPDLM,GMPDA)) Q:'GMPDA  D
 . . S GMPX=$G(^TMP("GMPLSCT",$J,GMPDLM,GMPDA)),GMPJ=GMPJ+1
 . . S ^XTMP(SUB,GMPJ,0)=$$LJ^XLFSTR($G(GMPDA),18)_$$LJ^XLFSTR($P(GMPX,U,1),15)_$$LJ^XLFSTR($P(GMPX,U,2),21)_$$LJ^XLFSTR($P(GMPX,U,3),$L($P(GMPX,U,3)))
 Q
 ;
BLDCLRPT(GMPLNCLN,GMPLRNTM) ; Build Cleanup Report
 N GMPLDLM,GMPLDA,GMPX,GMPJ,SUB,GMPLPSUB S (GMPLDLM,GMPLDA)="",GMPJ=21
 S GMPLPSUB=$O(^XTMP("GMPLCRPT;"))
 I GMPLPSUB["GMPLCRPT" K ^XTMP(GMPLPSUB)
 S SUB="GMPLCRPT;"_$H
 S ^XTMP(SUB,0)=$$FMADD^XLFDT($$NOW^XLFDT,30)_U_$$NOW^XLFDT()_U_"SNOMED in Diagnosis Field Cleanup Rpt"
 S ^XTMP(SUB,1,0)=""
 S ^XTMP(SUB,2,0)="**NOTE**: This report is retroactive as of the last Problem file cleanup runtime"
 S ^XTMP(SUB,3,0)=":"_$$FMTE^XLFDT(GMPLRNTM,1)_". This report will expire and be purged from the system in"
 S ^XTMP(SUB,4,0)="30 days. If the Generate SNOMED in Diagnosis Field Err/Cleanup Rpt [GMPL"
 S ^XTMP(SUB,5,0)="GENERATE DIAG RPTS] menu option is run prior to the 30 days, then this report"
 S ^XTMP(SUB,6,0)="will expire on the date/time the option is run. Whichever comes first."
 S ^XTMP(SUB,7,0)=""
 S ^XTMP(SUB,8,0)="A cleanup of the Problem file has been performed and the following "_GMPLNCLN
 S ^XTMP(SUB,9,0)="record entries have been corrected. This report contains 7 columns."
 S ^XTMP(SUB,10,0)="Please scroll to the right for more information."
 S ^XTMP(SUB,11,0)=""
 S ^XTMP(SUB,12,0)="These entries no longer contain a SNOMED CT concept code in the Diagnosis field"
 S ^XTMP(SUB,13,0)="#.01. The correct primary ICD diagnosis and secondary diagnosis code(s) is now"
 S ^XTMP(SUB,14,0)="stored in the appropriate fields. The corresponding SNOMED CT concept and"
 S ^XTMP(SUB,15,0)="designation codes have also been correctly filed in their respective fields. The "
 S ^XTMP(SUB,16,0)="provider narrative and problem fields were also updated accordingly as well."
 S ^XTMP(SUB,17,0)=""
 S ^XTMP(SUB,18,0)=""
 S ^XTMP(SUB,19,0)=$J("DATE LAST",27)_$J("PRIMARY",13)_$J("SNOMED CT",44)_$J("SNOMED CT",21)
 S ^XTMP(SUB,20,0)="IEN"_$J("MODIFIED",23)_$J("DIAGNOSIS",16)_$J("SECONDARY DIAGNOSIS",22)_$J("CONCEPT CODE",23)_$J("DESIGNATION CODE",25)_$J("PROBLEM",12)
 S ^XTMP(SUB,21,0)=$$REPEAT^XLFSTR("-",15)_$J($$REPEAT^XLFSTR("-",12),15)_$J($$REPEAT^XLFSTR("-",9),12)_$J($$REPEAT^XLFSTR("-",27),30)_$J($$REPEAT^XLFSTR("-",18),21)_$J($$REPEAT^XLFSTR("-",18),21)_$J($$REPEAT^XLFSTR("-",33),36)
 F  S GMPLDLM=$O(^TMP("GMPLCLNP",$J,GMPLDLM)) Q:'GMPLDLM  D
 . F  S GMPLDA=$O(^TMP("GMPLCLNP",$J,GMPLDLM,GMPLDA)) Q:'GMPLDA  D
 . . S GMPX=$G(^TMP("GMPLCLNP",$J,GMPLDLM,GMPLDA)),GMPJ=GMPJ+1
 . . S ^XTMP(SUB,GMPJ,0)=$$LJ^XLFSTR($G(GMPLDA),18)_$$LJ^XLFSTR($P(GMPX,U,1),15)_$$LJ^XLFSTR($P($P(GMPX,U,2),"/"),12)_$$LJ^XLFSTR($P($P(GMPX,U,2),"/",2,$L($P(GMPX,U,2),"/")),30)
 . . S ^XTMP(SUB,GMPJ,0)=^XTMP(SUB,GMPJ,0)_$$LJ^XLFSTR($P(GMPX,U,3),21)_$$LJ^XLFSTR($P(GMPX,U,4),21)_$$LJ^XLFSTR($P(GMPX,U,5),$L($P(GMPX,U,5)))
 K ^TMP("GMPLCLNP",$J)
 Q
 ;
VWERRPT ; View Error Report
 N GMPLX
 S GMPLX=$O(^XTMP("GMPLERPT;"))
 I GMPLX["GMPLERPT",$D(^XTMP(GMPLX)) D BROWSE^DDBR("^XTMP("""_GMPLX_""")","NR","Erroneous Problem File Record Entries Report")
 E  D
 . N GMPLTEXT
 . S GMPLTEXT(1)="There are currently no Problem File entries that contain this error."
 . D MES^XPDUTL(.GMPLTEXT)
 Q
VWCLRPT ; View Cleanup Report
 N GMPLX
 S GMPLX=$O(^XTMP("GMPLCRPT;"))
 I GMPLX["GMPLCRPT",$D(^XTMP(GMPLX)) D BROWSE^DDBR("^XTMP("""_GMPLX_""")","NR","Problem File Cleanup Report")
 E  D
 . N GMPLTEXT
 . S GMPLTEXT(1)="There are currently no Problem File entries that need correction."
 . D MES^XPDUTL(.GMPLTEXT)
 Q
