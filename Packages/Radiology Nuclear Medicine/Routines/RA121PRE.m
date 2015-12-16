RA121PRE ;BP/KAM - Pre-init Driver, patch 121 ; 2/26/15 1:57pm
VERSION ;;5.0;Radiology/Nuclear Medicine;**121**;Mar 16, 1998;Build 24
 ; Backup 73.2 file during a pre-install process.
 ; Backup 78.3 file during a pre-install process.
 ; Update file 78.3
 Q
PRE ;
 I '$D(^XTMP("PRE 2015-UPDATE BACKUP OF 73.2")) D
 . N X1,X2,X
 . S X1=DT,X2=180 D C^%DTC
 . S ^XTMP("PRE 2015-UPDATE BACKUP OF 73.2",0)=$G(X)_"^"_$G(DT)_"^"_"Backup of file 73.2 before 2015 update is performed Patch RA*5*121"
 . D EN^DDIOL("Backing up file 73.2 to ^XTMP.","","!!?1")
 . M ^XTMP("PRE 2015-UPDATE BACKUP OF 73.2",73.2)=^RA(73.2)
 . D EN^DDIOL("File 73.2 Backup complete","","!!?1")
 ;Q
PREDIAG ; Backup the 78.3 [DIAGNOSIS FILE]
 I '$D(^XTMP("PRE DIAGNOSIS FILE UPDATE BACKUP OF 78.3")) D
 . N X1,X2,X
 . S X1=DT,X2=180 D C^%DTC
 . S ^XTMP("PRE DIAGNOSIS FILE UPDATE BACKUP OF 78.3",0)=$G(X)_"^"_$G(DT)_"^"_"Backup of file 78.3 before update is performed by Patch RA*5*121"
 . M ^XTMP("PRE DIAGNOSIS FILE UPDATE BACKUP OF 78.3",78.3)=^RA(78.3)
 . D EN^DDIOL("File 78.3 Backup complete","","!!?1")
 ;Q
 ;
DIAGUP ; Update the Diagnosis Code File 78.3
 ;
 N KDA,KDAIEN,RECORD,CNT
 F CNT=1:1:25 S RECORD=$P($T(INTARR+CNT),";;",2,99) D
 . S KDA(1,78.3,"+1,",.01)=$P(RECORD,"^",2) ; DIAG CODE
 . S KDA(1,78.3,"+1,",2)=$P(RECORD,"^",3)   ; DIAG DESC
 . S KDA(1,78.3,"+1,",3)=$P(RECORD,"^",4)   ; PRINT ON ABN REPORT
 . S KDA(1,78.3,"+1,",4)=$P(RECORD,"^",5)   ; GENERATE ALERT
 . S KDAIEN(1)=$P(RECORD,"^")
 . D UPDATE^DIE("","KDA(1)","KDAIEN","KDAMSG")
 . ;
 . ;Capture any "DIERR" messages - they will tell us if an IEN already existed.  They shouldn't but you never know.
 . ;
 . I $D(KDAMSG("DIERR")) D
 .. S ^XTMP("PRE DIAGNOSIS FILE UPDATE BACKUP OF 78.3","DIERR",KDAIEN(1))=KDAMSG("DIERR",1,"TEXT",1)
 Q
 ; 
INTARR ; NUMBER^CODE^DESC^PRINT^ALERT
 ;;1210^LUNGRADS 0: INCOMPLETE^Report subject to change, either because LDCT must be repeated, or prior lung CT must be found for comparison.^Y^y
 ;;1211^LUNGRADS 1: NEGATIVE^No nodules or definitely benign nodules. Continue annual screening with LDCT in 12 months.^N^n
 ;;1212^LUNGRADS 2: BENIGN NODULE APPEARANCE OR BEHAVIOR^Very low likelihood of cancer.^N^n
 ;;1213^LUNGRADS 3: PROBABLY BENIGN NODULE^Low likelihood of becoming clinically active cancer. Follow-up in 6 months suggested.^N^n
 ;;1214^LUNGRADS 4A: SUSPICIOUS NODULE^Additional testing or biopsy recommended. Follow-up LDCT in 3 months, or PET/CT if solid component = 8 mm.^Y^y
 ;;1215^LUNGRADS 4B: SUSPICIOUS NODULE^Additional testing or biopsy recommended, which could include CT with or without contrast, PET/CT, or tissue sampling.^Y^y
 ;;1216^LUNGRADS 4X: SUSPICIOUS NODULE WITH ADDITIONAL FEATURES^Category 3 or 4 nodules with additional suspicious features.  Additional testing or biopsy recommended.^Y^y
 ;;1217^LUNGRADS 5: SIGNIFICANT INCIDENTAL FINDING^Secondary diagnostic code for potentially significant finding requiring follow-up other than lung nodule, node or mass.^Y^y
 ;;1218^LUNGRADS C: PRIOR LUNG CANCER^Secondary diagnostic code for patient with prior diagnosis of lung cancer who returned to screening.^N^n
 ;;1250^PR 1^Concur with interpretation^N^n
 ;;1251^PR 2A^Discrepancy in interpretation, not ordinarily expected to be made. Unlikely to be clinically significant.^N^n
 ;;1252^PR 2B^Discrepancy in interpretation, not ordinarily expected to be made. Likely to be clinically significant.^Y^n
 ;;1253^PR 3A^Discrepancy in interpretation, should be made most of the time. Unlikely to be clinically significant.^Y^n
 ;;1254^PR 3B^Discrepancy in interpretation, should be made most of the time. Likely to be clinically significant.^Y^n
 ;;1255^PR 4A^Discrepancy in interpretation, should be made almost every time. Unlikely to be clinically significant.^Y^n
 ;;1256^PR 4B^Discrepancy in interpretation, should be made almost every time. Likely to be clinically significant.^Y^n
 ;;1260^NVCC^A report of a NVCC imaging exam has been entered.^N^y
 ;;1261^VACAA^A report of a VACAA imaging exam has been entered.^N^y
 ;;1262^CONTRACT^A report of a contracted imaging exam has been entered.^N^y
 ;;1263^NOT ORDERED BY VA^A report of an imaging study ordered by an outside institution has been entered.^N^y
 ;;1111^ALMOST ENTIRELY FATTY^The breasts are almost entirely fatty^Y^n
 ;;1112^SCATTERED AREAS OF FIBROGLANDULAR DENSITY^There are scattered areas of fibroglandular density^Y^n
 ;;1113^HETEROGENEOUSLY DENSE^The breasts are heterogeneously dense, which may obscure small masses.^Y^n
 ;;1114^EXTREMELY DENSE^The breasts are extremely dense, which lowers the sensitivity of mammmography.^Y^n
 ;;1300^INCIDENTAL LUNG NODULE(NONSCREENING)^A lung nodule was found in a patient not enrolled in a lung cancer screening program^Y^y
