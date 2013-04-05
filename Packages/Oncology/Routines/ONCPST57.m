ONCPST57 ;Hines OIFO/RVD - Post-Install Routine for Patch ONC*2.11*57 ;11/02/12
 ;;2.11;ONCOLOGY;**57**;Mar 07, 1995;Build 6
 ;
 ;Set the COLLABORATIVE STAGING URL (160.1,19) value in all ONCOLOGY
 ;SITE PARAMETERS entries = http://127.0.0.1:1757/cgi_bin/oncsrv.exe
 N RC
 ;S RC=$$UPDCSURL^ONCSAPIU("http://websrv.oncology.domain.ext/oncsrv.exe") ;old server
 ;next is DC production server.
 S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:1757/cgi_bin/oncsrv.exe")
 ;next is DC test server, comment out for final release.
 ;S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:1755/cgi_bin/oncsrv.exe")
 ;For testing purposes, HINES test account. Comment out for final release.
 ;S RC=$$UPDCSURL^ONCSAPIU("http://127.0.0.1:1755/cgi-bin/oncsrv.exe")
 ;
 D HIST,PR6,PR3,ITEM9
 Q
HIST ;re-initialize if Histology 96703
 N I,J,ONCPIC
 D BMES^XPDUTL("Converting Histology 96703...")
 F I=3120000:0 S I=$O(^ONCO(165.5,"ADX",I)) Q:I'>0  F J=0:0 S J=$O(^ONCO(165.5,"ADX",I,J)) Q:J'>0  D
 .I $P($G(^ONCO(165.5,J,2.2)),U,3)=96703 D
 ..F ONCPIC=1:1:12 S $P(^ONCO(165.5,J,"CS"),U,ONCPIC)=""
 ..F ONCPIC=1:1:19 S $P(^ONCO(165.5,J,"CS1"),U,ONCPIC)=""
 ..F ONCPIC=1:1:19 S $P(^ONCO(165.5,J,"CS2"),U,ONCPIC)=""
 ..S $P(^ONCO(165.5,J,"CS3"),U,1)=""
 D BMES^XPDUTL("Done Converting Histology 96703!!!")
 Q
 ;
PRE57 ;entry point of p57 pre-init.
 ;clean-up file 160.16 & 165.2
 K ^ONCO(165.2)
 K ^ONCO(160.16) ;delete old entries of file #160.16, to be replaced in p57.
 D BMES^XPDUTL("Done removing files #160.16 & #165.2!!!")
 Q
 ;
PR6 ;process form for FOLLOWUP RATE REPORT
 N ONCIEN,VAL
 S ONCIEN=$O(^ONCO(160.2,"B","FOLLOWUP RATE REPORT",0))
 D BMES^XPDUTL("Updating file #160.2 for followup rate form...")
 I '$G(ONCIEN) D BMES^XPDUTL("No FOLLOWUP RATE REPORT form in your system, please inform your ONCOLOGY Dept...") Q
 F NNN=1:1 S VAL=$P($T(DAT6+NNN),";;",2) Q:VAL=""  S ^ONCO(160.2,ONCIEN,1,NNN,0)=VAL
 D BMES^XPDUTL("Done updating file #160.2 for FOLLOWUP RATE REPORT form!!!")
 Q
PR3 ;process form FOLLOWUP RATE REPORT 1
 N ONCIEN3,VAL
 S ONCIEN3=$O(^ONCO(160.2,"B","FOLLOWUP RATE REPORT 1",0))
 D BMES^XPDUTL("Updating file #160.2 for followup rate report 1 form...")
 I '$G(ONCIEN3) D BMES^XPDUTL("No FOLLOWUP RATE REPORT 1 form in your system, please inform your ONCOLOGY Dept...") Q
 F NNN=1:1 S VAL=$P($T(DAT3+NNN),";;",2) Q:VAL=""  S ^ONCO(160.2,ONCIEN3,1,NNN,0)=VAL
 D BMES^XPDUTL("Done updating file #160.2 for FOLLOWUP RATE REPORT 1 form!!!")
 Q
ITEM9 ; Item #9: clean up any data in discontinued fields for >=2013 cases
 N ONCZZDXD
 S ONCZZDXD=3121231 F  S ONCZZDXD=$O(^ONCO(165.5,"ADX",ONCZZDXD)) Q:ONCZZDXD=""  F ONCZZIEN=0:0 S ONCZZIEN=$O(^ONCO(165.5,"ADX",ONCZZDXD,ONCZZIEN)) Q:ONCZZIEN'>0  D
 .K DIE
 .S DIE="^ONCO(165.5,",DA=ONCZZIEN,DR="159///@" D ^DIE
 .S DIE="^ONCO(165.5,",DA=ONCZZIEN,DR="193///@" D ^DIE
 .S DIE="^ONCO(165.5,",DA=ONCZZIEN,DR="194///@" D ^DIE
 .S DIE="^ONCO(165.5,",DA=ONCZZIEN,DR="195///@" D ^DIE
 .S DIE="^ONCO(165.5,",DA=ONCZZIEN,DR="196///@" D ^DIE
 .Q
 Q
DAT3 ;data for FOLLOWUP RATE REPORT
 ;;|SETTAB(68)|
 ;;|NOW|
 ;; FOLLOW-UP RATE FOR ALL PATIENTS (LIVING AND DEAD)      NUMBER   PERCENT
 ;; 
 ;;        Total patients from registry reference date    |TOTAL#||TAB|100%
 ;; 
 ;;    1.  Less benign/borderline cases                 - |BENIGN|
 ;;    2.  Less Carcinoma in situ cervix cases          - |CERVIX|
 ;;    3.  Less in situ/localized basal and squamous    - |LOCAL BASAL|
 ;;        cell carcinoma of skin cases     "
 ;;    4.  Less foreign residents                       - |FOREIGN|
 ;;    5.  Less non-analytic cases                      - |NONANALYTIC|
 ;;    6.  Less 2006+ Class of Case 00 case             - |CC|
 ;;    7.  Less 2006+ Patient Age 100+ case             - |P100|
 ;; 
 ;;         SUBTOTAL CASES = ANALYTIC CASES           (A) |ANALYTIC||TAB|100%
 ;;         Class of Case 00-22
 ;; 
 ;;    1.  Less number dead                           (B) |DEAD||TAB||%DEAD|%
 ;; 
 ;;         SUBTOTAL CASES (NUMBER LIVING)            (C) |LIVING||TAB||%LIVING|%
 ;; 
 ;;    1.  Less number current (known to be alive
 ;;        in the last 15 months)                     (D) |CURRENT||TAB||%CURRENT-TOTAL|%
 ;; 
 ;;         TOTAL (LOST TO FOLLOW UP OR NOT CURRENT)  (E) |LTF| *|TAB||%LTF-TOTAL|%
 ;;         (* should be less than 20%)
 ;; 
 ;;     Successful follow-up currency (all patients)  (F) |SFC| **|TAB||%SFC|
 ;;         (** should be 80%)
 ;;========================================================================
 ;; 
 ;;     FOLLOW UP RATE FOR LIVING PATIENTS ONLY          NUMBER     PERCENT
 ;; 
 ;;        Enter the total number from Line C          |LIVING||TAB|100%
 ;;        Subtract the total number from Line D     - |CURRENT||TAB||%CURRENT-ALIVE|%
 ;;        Total lost/not current of living patients - |LTF||TAB||%LTF-ALIVE|%
DAT6 ;data for FOLLOWUP RATE REPORT 1
 ;;|SETTAB(68)|
 ;;|NOW|
 ;; FOLLOW-UP RATE FOR ALL PATIENTS (LIVING AND DEAD)      NUMBER   PERCENT 
 ;; 
 ;;        Total patients diagnosed within last 5 years
 ;;        or from registry reference date, whichever is
 ;;        shorter                                        |TOTAL#||TAB|100%
 ;; 
 ;;    1.  Less benign/borderline cases                 - |BENIGN|
 ;;    2.  Less carcinoma in situ cervix cases          - |CERVIX| 
 ;;    3.  Less in situ/localized basal and squamous    - |LOCAL BASAL|
 ;;        cell carcinoma of skin cases              
 ;;    4.  Less foreign residents                       - |FOREIGN| 
 ;;    5.  Less non-analytic                            - |NONANALYTIC|
 ;;    6.  Less 2006+ Class of Case 00 case             - |CC|
 ;;    7.  Less 2006+ Patient Age 100+ case             - |P100|
 ;; 
 ;;         SUBTOTAL CASES = ANALYTIC CASES           (A) |ANALYTIC||TAB|100%
 ;;         Class of Case 00-22 
 ;; 
 ;;    1.  Less number dead                           (B) |DEAD||TAB||%DEAD|%
 ;; 
 ;;         SUBTOTAL CASES (NUMBER LIVING)            (C) |LIVING||TAB||%LIVING|%
 ;; 
 ;;    1.  Less number current (known to be alive 
 ;;        in the last 15 months)                     (D) |CURRENT||TAB||%CURRENT-TOTAL|%
 ;; 
 ;;         TOTAL (LOST TO FOLLOW UP OR NOT CURRENT)  (E) |LTF| *|TAB||%LTF-TOTAL|%
 ;; 
 ;;         (* should be less than 10%) 
 ;; 
 ;;     Successful follow-up currency (all patients)  (F) |SFC| **|TAB||%SFC|%
 ;;         (** should be 90%)
 ;;=========================================================================
 ;; 
 ;;     FOLLOW UP RATE FOR LIVING PATIENTS ONLY          NUMBER     PERCENT
 ;; 
 ;;        Enter the total number from Line C          |LIVING||TAB|100%
 ;;        Subtract the total number from Line D     - |CURRENT||TAB||%CURRENT-ALIVE|%
 ;;        Total lost/not current of living patients - |LTF||TAB||%LTF-ALIVE|%
