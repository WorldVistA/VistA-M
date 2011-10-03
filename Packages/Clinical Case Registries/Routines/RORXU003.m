RORXU003 ;HCIOFO/BH,SG - REPORT BUILDER UTILITIES ; 7/19/06 12:34pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1**;Feb 17, 2006;Build 24
 ;
 ; This routine uses the following IAs:
 ;
 ; #1894         ENCEVENT^PXKENC (controlled)
 ;
 Q
 ;
 ;***** SEARCHES FOR UTLIZATION
 ;
 ; STDT          Start date for search (FileMan)
 ; ENDT          End date for search   (FileMan)
 ;
 ; RORDFN        Patient IEN in the PATIENT file (#2)
 ;
 ; CHK           Reference to a local array that identifies the
 ;               packages files that need to be checked i.e. CHK("O"):
 ;                 A   Allergy
 ;                 C   Cytopathology
 ;                 I   Inpatients
 ;                 IP  Inpatient Pharmacy
 ;                 IV  IV Medications
 ;                 L   Laboratory
 ;                 M   Microbiology
 ;                 O   Outpatient
 ;                 OP  Outpatient Pharmacy
 ;                 R   Radiology
 ;                 SP  Surgical Pathology
 ;
 ;               If set to "ALL", Outpatients, Inpatients, Radiology,
 ;               Allergy, Pharmacy, Microbiology, Surgical Pathology,
 ;               Cytopathology, and Lab data will be checked.
 ;
 ; Return Values:
 ;       0  No utilization has been found
 ;       1  The patient has had utilization. The subsequent "^"-pieces
 ;          will indicate the utilization areas (the same codes as
 ;          those for the CHK parameter)
 ;
 ;          For example, if a patient had utilization for Inpatients, 
 ;          Outpatient, Pharmacy, and Lab the string would look as
 ;          follows: 1^O^I^OP^L
 ;
UTIL(STDT,ENDT,RORDFN,CHK) ;
 N IEN,LRDFN,RES,RORMSG,RORVAL
 S RORVAL=""
 ;
 ;--- Outpatient data
 I $D(CHK("ALL"))!$D(CHK("O")) D
 . S RES=$$OUTPAT(STDT,ENDT,RORDFN)
 . S:RES RORVAL=RORVAL_U_$P(RES,U,2,999)
 ;
 ;--- Inpatient data
 I $D(CHK("ALL"))!$D(CHK("I")) D
 . S RES=$$INPAT(STDT,ENDT,RORDFN)
 . S:RES RORVAL=RORVAL_U_$P(RES,U,2,999)
 ;
 ;--- Radiology data
 I $D(CHK("ALL"))!$D(CHK("R")) D
 . S RES=$$RAD(STDT,ENDT,RORDFN)
 . S:RES RORVAL=RORVAL_U_$P(RES,U,2,999)
 ;
 ;--- Allergy data
 I $D(CHK("ALL"))!$D(CHK("A")) D
 . S RES=$$ALLERGY(STDT,ENDT,RORDFN)
 . S:RES RORVAL=RORVAL_U_$P(RES,U,2,999)
 ;
 ;--- Pharmacy data
 I $D(CHK("ALL"))!$D(CHK("IP"))!$D(CHK("OP"))!$D(CHK("IV")) D
 . S RES=$$PHARM(STDT,ENDT,RORDFN,.CHK)
 . S:RES RORVAL=RORVAL_U_$P(RES,U,2,999)
 ;
 S LRDFN=+$$LABREF^RORUTL18(RORDFN)
 ;
 I LRDFN>0  D
 . ;--- Microbiology
 . I $D(CHK("ALL"))!$D(CHK("M")) D
 . . S RES=$$MICRO(STDT,ENDT,LRDFN)
 . . S:RES RORVAL=RORVAL_U_$P(RES,U,2,999)
 . ;--- Surgical Pathology
 . I $D(CHK("ALL"))!$D(CHK("SP")) D
 . . S RES=$$SURGP(STDT,ENDT,LRDFN)
 . . S:RES RORVAL=RORVAL_U_$P(RES,U,2,999)
 . ;--- Cytopathology
 . I $D(CHK("ALL"))!$D(CHK("C")) D
 . . S RES=$$CYTO(STDT,ENDT,LRDFN)
 . . S:RES RORVAL=RORVAL_U_$P(RES,U,2,999)
 ;
 ;--- Lab data
 I $D(CHK("ALL"))!$D(CHK("L")) D
 . S RES=$$LAB(STDT,ENDT,RORDFN)
 . S:RES RORVAL=RORVAL_U_$P(RES,U,2,999)
 ;
 S $P(RORVAL,U)=(RORVAL'="")
 Q RORVAL
 ;
 ;***** CHECKS ALLERGY DATA
ALLERGY(STDT,ENDT,RORDFN) ;
 N DTE,IEN,RC
 S RC=0
 S DTE=$O(^GMR(120.8,"AODT",STDT),-1)
 S ENDT=ENDT_".999999"
 F  S DTE=$O(^GMR(120.8,"AODT",DTE))  Q:'DTE!(DTE'<ENDT)  D  Q:RC
 . S IEN=0
 . F  S IEN=$O(^GMR(120.8,"AODT",DTE,IEN))  Q:'IEN  D  Q:RC
 . . S:$D(^GMR(120.8,"B",RORDFN,IEN)) RC="1^A"
 Q RC
 ;
 ;***** CHECKS CYTOPATHOLOGY DATA
CYTO(STDT,ENDT,LRDFN) ;
 N IDT
 S IDT=$O(^LR(LRDFN,"CY",9999999-STDT))
 S IDT=$O(^LR(LRDFN,"CY",IDT),-1)
 Q $S(IDT&(IDT>(9999999-ENDT)):"1^C",1:0)
 ;
 ;***** CHECKS INPATIENT DATA
INPAT(STDT,ENDT,DFN) ;
 N ADMDT,DATE,DISDT,IEN,QUIT,RC,VAIP
 S STDT=STDT\1
 ;--- Check for an admission date inside the time frame
 S QUIT=0,DATE=(ENDT\1)_".999999"
 F  S DATE=$O(^DGPT("AAD",DFN,DATE),-1)  Q:'DATE!(DATE<STDT)  D  Q:QUIT
 . S IEN=""
 . F  S IEN=$O(^DGPT("AAD",DFN,DATE,IEN),-1)  Q:'IEN  D  Q:QUIT
 . . S:'$$PTF^RORXU001(IEN,"FP") QUIT=1
 Q:QUIT=1 "1^I"
 ;--- Check for an earlier admission that overlaps the date range
 S QUIT=0,VAIP("D")=STDT
 F  D  Q:QUIT
 . D IN5^VADPT
 . S VAIP("D")=+$G(VAIP(13,1))
 . I VAIP("D")'>0  S QUIT=2  Q
 . S VAIP("D")=$$FMADD^XLFDT(VAIP("D"),,,,-1)
 . S IEN=+$G(VAIP(12))  Q:IEN'>0
 . S RC=$$PTF^RORXU001(IEN,"FP",,.DISDT)
 . S QUIT=$S(RC:0,$G(DISDT)'>0:1,DISDT>STDT:1,1:2)
 Q $S(QUIT=1:"1^I",1:0)
 ;
 ;***** CHECKS LAB DATA
LAB(STDT,ENDT,RORDFN) ;
 N PTID,RC,RORMSG,RORTMP
 S PTID=$$PTID^RORUTL02(RORDFN)  Q:PTID<0 0
 S RORTMP=$$ALLOC^RORTMP()
 ;--- Get the Lab data
 S ENDT=(ENDT\1+1)_"^CD",STDT=STDT_"^CD"
 S RC=$$GCPR^LA7QRY(PTID,STDT,ENDT,"CH","*",.RORMSG,RORTMP)
 S RC=$S(($D(RORMSG)>1)&(RC=""):0,$D(@RORTMP)>1:"1^L",1:0)
 ;--- Cleanup
 D FREE^RORTMP(RORTMP)
 Q RC
 ;
 ;***** CHECKS MICROBIOLOGY DATA
MICRO(STDT,ENDT,LRDFN) ;
 N RC,RORTMP
 S RC=0,RORTMP=$$ALLOC^RORTMP()
 D:$$GETDATA^LA7UTL1A(LRDFN,STDT,ENDT,"CD",RORTMP)'<0
 . S:$D(@RORTMP@(LRDFN)) RC="1^M"
 D FREE^RORTMP(RORTMP)
 Q RC
 ;
 ;***** CHECKS OUTPATIENT DATA
OUTPAT(STDT,ENDT,RORDFN) ;
 S STDT=$P(STDT,".",1),STDT=STDT-1,STDT=STDT+.9999
 S ENDT=$P(ENDT,".",1),ENDT=ENDT+1
 N QUERY,RORDST,RORECNT
 S RORECNT=0
 S RORDST=$NA(^TMP("RORXU003",$J,"OUT"))
 D OPEN^SDQ(.QUERY)
 D INDEX^SDQ(.QUERY,"PATIENT/DATE","SET")
 D PAT^SDQ(.QUERY,RORDFN,"SET")
 D DATE^SDQ(.QUERY,STDT,ENDT,"SET")
 D SCANCB^SDQ(.QUERY,"D SCAN^RORXU003()","SET")
 D ACTIVE^SDQ(.QUERY,"TRUE","SET")
 D SCAN^SDQ(.QUERY,"FORWARD")
 D CLOSE^SDQ(.QUERY)
 Q $S(RORECNT:"1^O",1:0)
 ;
 ;***** CHECKS PHARMACY DATA
PHARM(STDT,ENDT,RORDFN,CHK) ;
 N BUF,II,IP,IV,OP,ORD,RC,RORLST,SKIP,TMP,TYPE
 S ENDT=$$FMADD^XLFDT(ENDT\1,1)
 I '$D(CHK("ALL"))  D
 . S IP='$D(CHK("IP"))
 . S IV='$D(CHK("IV"))
 . S OP='$D(CHK("OP"))
 E  S (OP,IP,IV)=0
 ;=== Get the list of orders
 K ^TMP("PS",$J)
 D OCL^PSOORRL(RORDFN,STDT,ENDT)
 Q:$D(^TMP("PS",$J))<10 0
 S RORLST=$$ALLOC^RORTMP()
 ;=== Preselect the orders
 S II=0
 F  S II=$O(^TMP("PS",$J,II))  Q:'II  D
 . S BUF=$G(^TMP("PS",$J,II,0)),ORD=$P(BUF,U)  Q:ORD'>0
 . S TMP=$L(ORD),TYPE=$E(ORD,TMP-2,TMP)
 . S TYPE=$S(TYPE="R;O":"R",TYPE="U;I":"U",TYPE="V;I":"V",1:"")
 . ;--- Check if this kind of orders should be processed
 . Q:$S(TYPE="R":OP,TYPE="U":IP,TYPE="V":IV,1:1)
 . ;--- Check the dates
 . I "UV"[TYPE  S TMP=$P(BUF,U,15)  Q:(TMP<STDT)!(TMP'<ENDT)
 . I TYPE="R"   S TMP=$P(BUF,U,10)  Q:TMP<STDT
 . ;--- Add the order to the list
 . S @RORLST@(II)=TYPE,@RORLST@(II,0)=BUF
 ;=== Process the preselected orders
 S II=0,RC=""
 F  S II=$O(@RORLST@(II))  Q:'II  D  Q:OP&IP&IV
 . S TYPE=@RORLST@(II),ORD=$P(@RORLST@(II,0),U)
 . ;--- Outpatient
 . I TYPE="R"  Q:OP  D  S:'SKIP OP=1,RC=RC_U_"OP"  Q
 . . ;--- Double-check the Rx date(s)
 . . K ^TMP("PS",$J)
 . . D OEL^PSOORRL(RORDFN,ORD)
 . . I $D(^TMP("PS",$J))<10  S SKIP=1  Q
 . . S SKIP=$$DTCHECK^RORUTL15(STDT,ENDT)
 . ;--- Inpatient
 . I TYPE="U"  Q:IP  S IP=1,RC=RC_U_"IP"  Q
 . ;--- IV
 . I TYPE="V"  Q:IV  S IV=1,RC=RC_U_"IV"  Q
 ;===
 D FREE^RORTMP(RORLST)
 K ^TMP("PS",$J)
 S $P(RC,U)=(RC'="")
 Q RC
 ;
 ;***** CHECKS RADIOLOGY DATA
RAD(STDT,ENDT,RORDFN) ;
 N RC
 K ^TMP($J,"RAE1")
 D EN1^RAO7PC1(RORDFN,STDT,ENDT,999999999)
 S RC=$S($D(^TMP($J,"RAE1",RORDFN))>1:"1^R",1:0)
 K ^TMP($J,"RAE1")
 Q RC
 ;
 ;*****
SCAN() ;
 S RORECNT=1
 Q
 ;
 ;***** CHECKS SURGICAL PATHOLOGY DATA
SURGP(STDT,ENDT,LRDFN) ;
 N IDT
 S IDT=$O(^LR(LRDFN,"SP",9999999-STDT))
 S IDT=$O(^LR(LRDFN,"SP",IDT),-1)
 Q $S(IDT&(IDT>(9999999-ENDT)):"1^SP",1:0)
