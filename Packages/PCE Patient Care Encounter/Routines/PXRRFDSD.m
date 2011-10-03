PXRRFDSD ;ISL/PKR - Go through the encounters attaching a diagnosis and then sort based on the diagnosis. ;06/08/98
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**3,10,12,31,54,121**;Aug 12, 1996
SORT ;
 N BUSY,COUNT,DIAGTOT,DCIEN,ENCTOT,ICD9IEN,INFOTYPE,FACILITY,HLOC
 N POV,POVIEN,PNAME,PRIMARY,STOIND,VACODE,VIEN
 ;
 ;The ^XTMP array created in PXRRFDSE can have four possible structures.
 ;If the encounters were sorted by location then the structure will be:
 ;  ^XTMP(PXRRXTMP,FACILITY,1,1,HLOC,VIEN).
 ;If the encounters were sorted by person class then the structure will be:
 ;  ^XTMP(PXRRXTMP,FACILITY,1,VACODE,1,VIEN).
 ;If the encounters were sorted by provider then the structure will be:
 ;  ^XTMP(PXRRXTMP,FACILITY,PNAME,1,1,VIEN).
 ;If none of the above screens were used then the structure will be:
 ;  ^XTMP(PXRRXTMP,FACILITY,1,1,1,VIEN).
 ;
 I '(PXRRQUE!$D(IO("S"))) D INIT^PXRRBUSY(.BUSY)
 ;
 ;Allow the task to be cleaned up on successful completion.
 S ZTREQ="@"
 ;
 I $P(PXRRFDDC,U,1)="P" S PRIMARY=1
 E  S PRIMARY=0
 ;
 S DIAGTOT=0
 ;Initialize the storage index.
 S STOIND=0
 ;
 S FACILITY=""
FAC S FACILITY=$O(^XTMP(PXRRXTMP,"ENCTR",FACILITY))
 I FACILITY="" G SETPR
 S STOIND=STOIND+1
 S ^XTMP(PXRRXTMP,"INFO","FACILITY",FACILITY,FACILITY)=STOIND
 ;
 S PNAME=""
PRV S PNAME=$O(^XTMP(PXRRXTMP,"ENCTR",FACILITY,PNAME))
 I PNAME="" G FAC
 ;Start INFOTYPE with "G" so it always comes after FACILITY.
 S INFOTYPE="G"
 I ($L(PNAME)>1)&(+PNAME=0)&(INFOTYPE'["PRV") D
 . S INFOTYPE=INFOTYPE_"PRV"
 ;
 ;Check for a user request to stop the task.
 I $$S^%ZTLOAD S ZTSTOP=1 D EXIT^PXRRFDD
 ;
 S VACODE=""
PCLASS S VACODE=$O(^XTMP(PXRRXTMP,"ENCTR",FACILITY,PNAME,VACODE))
 I VACODE="" G PRV
 I ($L(VACODE)>1)&(+VACODE=0)&(INFOTYPE'["PC") D
 . S INFOTYPE=INFOTYPE_"PC"
 ;
 S HLOC=""
LOC S HLOC=$O(^XTMP(PXRRXTMP,"ENCTR",FACILITY,PNAME,VACODE,HLOC))
 I HLOC="" G PCLASS
 ;The location is stored in the form NAME_U_STOP CODE
 I ($L(HLOC)>1)&(+$P(HLOC,U,2)>0)&(INFOTYPE'["LOC") D
 . S INFOTYPE=INFOTYPE_"LOC"
 ;
 S STOIND=STOIND+1
 S ^XTMP(PXRRXTMP,"INFO",INFOTYPE,FACILITY,PNAME,VACODE,HLOC)=STOIND
 ;
 S VIEN=""
ENC S VIEN=$O(^XTMP(PXRRXTMP,"ENCTR",FACILITY,PNAME,VACODE,HLOC,VIEN))
 I (VIEN="")!(VIEN=0) G LOC
 ;Count the encounters
 I '$D(ENCTOT(STOIND)) S ENCTOT(STOIND)=1
 E  S ENCTOT(STOIND)=ENCTOT(STOIND)+1
 ;
 ;If this is an interactive session let the user know that something
 ;is happening.
 I '(PXRRQUE!$D(IO("S"))) D SPIN^PXRRBUSY("Sorting diagnoses",.BUSY)
 ;
 ;Initialzide the diagnosis counter.
 I '$D(DIAGTOT(STOIND)) S DIAGTOT(STOIND)=0
 ;
 ;Get the diagnoses associated with this VIEN.
 S POVIEN=""
DIAG S POVIEN=$O(^AUPNVPOV("AD",VIEN,POVIEN))
 I POVIEN="" G ENC
 S POV=^AUPNVPOV(POVIEN,0)
 ;
 ;Apply the primary/secondary screen.  If this field does not contain P
 ;then we take it to be secondary.
 I PRIMARY I $P(POV,U,12)'="P" G DIAG
 ;
 ;Count the ICD9 entries.
 S ICD9IEN=$P(POV,U,1)
 I '$D(^TMP(PXRRXTMP,$J,"DIAG",STOIND,"ICD9",ICD9IEN)) S ^TMP(PXRRXTMP,$J,"DIAG",STOIND,"ICD9",ICD9IEN)=1
 E  S ^TMP(PXRRXTMP,$J,"DIAG",STOIND,"ICD9",ICD9IEN)=^TMP(PXRRXTMP,$J,"DIAG",STOIND,"ICD9",ICD9IEN)+1
 S DIAGTOT(STOIND)=DIAGTOT(STOIND)+1
 ;
 ;Count the diagnostic categories.
 ;This will probably require a DBIA.
 ;S DCIEN=$P(^ICD9(ICD9IEN,0),U,5)
 S DCIEN=$P($$ICDDX^ICDCODE(ICD9IEN),U,6)
 I DCIEN'>0 S DCIEN=0
 I '$D(^TMP(PXRRXTMP,$J,"DIAG",STOIND,"DC",DCIEN)) S ^TMP(PXRRXTMP,$J,"DIAG",STOIND,"DC",DCIEN)=1
 E  S ^TMP(PXRRXTMP,$J,"DIAG",STOIND,"DC",DCIEN)=^TMP(PXRRXTMP,$J,"DIAG",STOIND,"DC",DCIEN)+1
 ;
 G DIAG
 ;
SETPR ;Rearrange the information for printing.
 S STOIND=""
NEXTSTO S STOIND=$O(^TMP(PXRRXTMP,$J,"DIAG",STOIND))
 I STOIND="" G EXIT
 I '(PXRRQUE!$D(IO("S"))) D SPIN^PXRRBUSY("Sorting diagnoses",.BUSY)
 ;
 S ICD9IEN=""
NEXTIC S ICD9IEN=$O(^TMP(PXRRXTMP,$J,"DIAG",STOIND,"ICD9",ICD9IEN))
 I ICD9IEN="" G STDC
 S COUNT=^TMP(PXRRXTMP,$J,"DIAG",STOIND,"ICD9",ICD9IEN)
 S DIAGTOT=DIAGTOT+COUNT
 S ^XTMP(PXRRXTMP,"PRINT",STOIND,"ICD9",COUNT,ICD9IEN)="DIAG"_ICD9IEN
 G NEXTIC
 ;
 ;
STDC S DCIEN=""
NEXTDC S DCIEN=$O(^TMP(PXRRXTMP,$J,"DIAG",STOIND,"DC",DCIEN))
 I DCIEN="" G NEXTSTO
 S COUNT=^TMP(PXRRXTMP,$J,"DIAG",STOIND,"DC",DCIEN)
 S ^XTMP(PXRRXTMP,"PRINT",STOIND,"DC",COUNT,DCIEN)=""
 G NEXTDC
 ;
EXIT ;
 ;Kill the arrays we are done with.
 K ^TMP(PXRRXTMP,$J,"DIAG")
 K ^XTMP(PXRRXTMP,"ENCTR")
 ;
 S STOIND=""
 F  S STOIND=$O(ENCTOT(STOIND)) Q:STOIND=""  D
 . S ^XTMP(PXRRXTMP,"TOTALS","DIAGTOT",STOIND)=DIAGTOT(STOIND)
 . S ^XTMP(PXRRXTMP,"TOTALS","ENCTOT",STOIND)=ENCTOT(STOIND)
 ;
 I '(PXRRQUE!$D(IO("S"))) D DONE^PXRRBUSY("done")
 ;
 ;Print the report.
 I PXRRQUE D
 . N DESC,ROUTINE,TASK
 . S DESC="Frequency of diagnosis report - print"
 . S ROUTINE="PXRRFDP"
 . S TASK=^XTMP(PXRRXTMP,"PRZTSK")
 . S ZTDTH=$$NOW^XLFDT
 . D REQUE^PXRRQUE(DESC,ROUTINE,TASK)
 E  D ^PXRRFDP
 ;
 Q
