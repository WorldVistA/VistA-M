PXRMXX1 ; SLC/PJH - Build list of reminder findings;08/03/2005
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;
 ;Called at REM, REPORT and PSMERG from PXRMXX
 ;
 ;Merge the patients found by the pharmacy API
 ;--------------------------------------------
PSMERG(TYP,NODE,SEARCH) ;
 N DATA,DATE,DCNT,DFN,DRUG,DSUP,FCNT,FINDING,FIEN,FLD,FTYP,FREC,FUNIQ
 N LAST,LDATE,NEXT,RDATE,SDATE,STOPDATE,TERM,TIEN,VTYP
 ;
 S DFN="",VTYP=$S(TYP="PXRMPSI":"I",1:"O")
 F  S DFN=$O(^TMP(TYP_NODE,$J,DFN)) Q:'DFN  D
 .;Get last entry for this patient created by reminder evaluation
 .S LAST=$O(^TMP(NODE,$J,DFN,"FIND",""),-1),NEXT=LAST+1,DCNT=0
 .;If this is a new patient update patient and finding count
 .I NEXT=1 S PXRMFCNT=PXRMFCNT+1,PXRMCNT=PXRMCNT+1
 .;Scan through medications found for this patient 
 .F  S DCNT=$O(^TMP(TYP_NODE,$J,DFN,DCNT)) Q:'DCNT  D
 ..;Move data fields into FIEVAL format
 ..S FINDING=$P($G(^TMP(TYP_NODE,$J,DFN,DCNT,0)),U) Q:FINDING=""
 ..S DATA=$G(^TMP(TYP_NODE,$J,DFN,DCNT,1)),DATE=$P(DATA,U)
 ..S RDATE=$P(DATA,U,2),DRUG=$P(DATA,U,3),DSUP=$P(DATA,U,4)
 ..;Stop date
 ..S STOPDATE=$P(DATA,U,5)
 ..I +STOPDATE S DSUP=$$FMDIFF^XLFDT(STOPDATE,DATE,"")
 ..;Determine finding item/type
 ..S FTYPE=$P(FINDING,";",2),FIEN=$P(FINDING,";") Q:FIEN=""  Q:FTYPE=""
 ..;Create file entry for each term
 ..S TIEN=""
 ..F  S TIEN=$O(SEARCH(FTYPE,FIEN,TIEN)) Q:TIEN=""  D
 ...F FLD="FINDING","DATE","RDATE","DRUG","DSUP","STOPDATE" D
 ....S ^TMP(NODE,$J,DFN,"FIND",NEXT,FLD)=@FLD
 ...;Get term name (no transforms)
 ...S ^TMP(NODE,$J,DFN,"FIND",NEXT,"TERM")=$P($G(^PXRMD(811.5,TIEN,0)),U)
 ...;Update header
 ...S ^TMP(NODE,$J,DFN,"FIND",NEXT)=DATE_U_VTYP
 ...;Update finding header
 ...S LDATE=$P($G(^TMP(NODE,$J,DFN)),U)
 ...I DATE>LDATE S ^TMP(NODE,$J,DFN)=DATE_U_VTYP
 ...;Save count by finding for report
 ...S FREC=$G(PXRMFIEN(FINDING)),FCNT=$P(FREC,U),FUNIQ=$P(FREC,U,2)
 ...S FCNT=FCNT+1 I '$G(FUNIQ(FIEN)) S FUNIQ=FUNIQ+1
 ...S PXRMFIEN(FINDING)=FCNT_U_FUNIQ,FUNIQ(FINDING)=1
 ...;Update count
 ...S NEXT=NEXT+1
 Q
 ;
 ;Build list of related findings
 ;------------------------------
REM(PXRMITEM,OUTPUT,LAB) ;
 N COHORT,FTYPE,FIEN,FNODE,TNAM,TIEN
 S FTYPE=""
 ;Check if terms findings exist on the reminder
 F  S FTYPE=$O(^PXD(811.9,PXRMITEM,20,"E",FTYPE)) Q:FTYPE=""  D
 .;Check terms ONLY
 .I FTYPE="PXRMD(811.5," D  Q
 ..N FTYPE S TIEN=""
 ..;Scan through terms in this reminder
 ..F  S TIEN=$O(^PXD(811.9,PXRMITEM,20,"E","PXRMD(811.5,",TIEN)) Q:'TIEN  D
 ...;Get the cohort flag
 ...S FNODE=$O(^PXD(811.9,PXRMITEM,20,"E","PXRMD(811.5,",TIEN,""))
 ...S COHORT="",FTYPE=""
 ...I FNODE S COHORT=$P($G(^PXD(811.9,PXRMITEM,20,FNODE,0)),U,7)
 ...;Scan through term looking for findings
 ...F  S FTYPE=$O(^PXRMD(811.5,TIEN,20,"E",FTYPE)) Q:FTYPE=""  D
 ....;Taxonomy findings
 ....I FTYPE="PXD(811.2," D RTAX Q
 ....;If Lab test and not in cohort ignore
 ....I FTYPE="LAB(60,",COHORT="" D  Q
 .....;Only applies to lab extract reminder 
 .....I $G(REM(PXRMITEM))'="VA-NATIONAL EPI LAB EXTRACT" Q
 .....;Get the term name for this lab test
 .....S TNAM=$P($G(^PXRMD(811.5,TIEN,0)),U) Q:TNAM=""
 .....S LAB(TNAM)=TIEN Q
 ....;Other findings
 ....D RSET
 Q
 ;
 ;Save report details
 ;-------------------
REPORT(NODE) ;
 N RDATE,CNT,CN1,COUNT,DATA,LAST,OLD,DESC
 ;format rundate as MMDDYY
 S RDATE=$$DT^XLFDT,RDATE=$E(RDATE,4,5)_$E(RDATE,6,7)_$E(RDATE,2,3)
 ;Task Name
 S DESC="LREPI "_$E(PXRMEDT,2,3)_"/"_$E(PXRMEDT,4,5)_" "_RDATE
 S DATA=$G(^PXRMXT(810.3,0))
 ;Find next entry in report file
 S LAST=$P(DATA,U,3),COUNT=$P(DATA,U,4)+1,CNT=LAST+1
 S $P(^PXRMXT(810.3,0),U,3)=CNT,$P(^PXRMXT(810.3,0),U,4)=COUNT
 ;Save Task and extract parameters
 S ^PXRMXT(810.3,CNT,0)=DESC_U_PXRMBDT_U_PXRMEDT_U_$G(ZTSK)_U_DUZ_U_$$NOW^XLFDT_U_PXRMCNT_U_PXRMFCNT
 S $P(^PXRMXT(810.3,CNT,50),U)=1
 S $P(^PXRMXT(810.3,CNT,100),U)="N"
 ;Transfer findings into report file
 N DATE,DFN,DRUG,DSUP,ENC,EREC,ETYP,IC,FINDING,RESULT
 N TERM,ALTTRM,TIEN,TNDBID,VALUE,VIEN
 S DFN=0,CN1=0
 F  S DFN=$O(^TMP(NODE,$J,DFN)) Q:'DFN  Q:TSTOP=1  D
 .;Check if stop task requested
 .I $$S^%ZTLOAD S TSTOP=1 Q
 .S ENC=0
 .F  S ENC=$O(^TMP(NODE,$J,DFN,"FIND",ENC)) Q:'ENC  D
 ..;DINUM
 ..S CN1=CN1+1
 ..;Encounter type
 ..S ETYP=$P($G(^TMP(NODE,$J,DFN,"FIND",ENC)),U,2)
 ..;Finding details
 ..F IC="DATE","FINDING","RESULT","TERM","ALTTRM","VALUE","VIEN" D
 ...S @IC=$P($G(^TMP(NODE,$J,DFN,"FIND",ENC,IC)),U)
 ..;Drug details
 ..F IC="DRUG","DSUP" D
 ...S @IC=$P($G(^TMP(NODE,$J,DFN,"FIND",ENC,IC)),U)
 ..;Get the term ien for the original term if a mapping occurred
 ..S TIEN="",TNDBID=""
 ..I TERM]"" S TIEN=$O(^PXRMD(811.5,"B",TERM,"")),TNDBID=ALTTRM
 ..;Save value if the result is null
 ..I RESULT="" S RESULT=VALUE
 ..;Save data to file
 ..S EREC=DFN_U_U_TIEN_U_FINDING_U_TNDBID_U_DATE_U_VIEN_U_ETYP
 ..S ^PXRMXT(810.3,CNT,1,CN1,0)=EREC
 ..S EREC=RESULT_U_VALUE_U_DRUG_U_DSUP
 ..S ^PXRMXT(810.3,CNT,1,CN1,1)=EREC
 ;
 ;Set top node for ^DIK re-index
 S ^PXRMXT(810.3,CNT,1,0)="^810.31A^"_CN1_U_CN1
 ;
 ;Write finding totals to report file
 N FCNT,FUNIQ,FIEN,FFIEN
 S FIEN="",CN1=0
 F  S FIEN=$O(PXRMFIEN(FIEN)) Q:FIEN=""  D
 .S FCNT=+$P(PXRMFIEN(FIEN),U),FUNIQ=+$P(PXRMFIEN(FIEN),U,2)
 .S FFIEN=FIEN I FFIEN="NO FINDING" S FFIEN=""
 .S CN1=CN1+1,^PXRMXT(810.3,CNT,2,CN1,0)=FFIEN_U_FCNT_U_FUNIQ
 ;
 ;Set top node for ^DIK re-index
 S ^PXRMXT(810.3,CNT,2,0)="^810.32A^"_CN1_U_CN1
 ;
 ;Re-index the file for this batch
 N DIK,DA
 S DIK="^PXRMXT(810.3,",DA=CNT
 D IX1^DIK
 ;
 Q
 ;
 ;Store finding for term
 ;----------------------
RSET N FIEN
 S FIEN=""
 F  S FIEN=$O(^PXRMD(811.5,TIEN,20,"E",FTYPE,FIEN)) Q:'FIEN  D
 .S OUTPUT(FTYPE,FIEN,TIEN)=""
 Q
 ;
 ;Store the taxonomy ICD9 codes
 ;-----------------------------
RTAX N FIEN,ISUB,TXIEN
 S TXIEN=""
 ;Scan taxonomy section of the term
 F  S TXIEN=$O(^PXRMD(811.5,TIEN,20,"E",FTYPE,TXIEN)) Q:'TXIEN  D
 .S ISUB=""
 .;Extract ICD9 codes from expanded taxonomy file
 .F  S ISUB=$O(^PXD(811.3,TXIEN,80,ISUB)) Q:'ISUB  D
 ..S FIEN=$P($G(^PXD(811.3,TXIEN,80,ISUB,0)),U) Q:'FIEN
 ..S OUTPUT("ICD9(",FIEN,TIEN)=""
 Q
