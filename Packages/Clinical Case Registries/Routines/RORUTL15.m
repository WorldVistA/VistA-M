RORUTL15 ;HCIOFO/BH,SG - PHARMACY DATA SEARCH (TOOLS) ;12/21/05 11:11am
 ;;1.5;CLINICAL CASE REGISTRIES;**13,26**;Feb 17, 2006;Build 53
 ;
 ; This routine uses the following IAs:
 ;
 ; #2400         OCL^PSOORRL and OEL^PSOORRL (controlled)
 ; #4533         ARWS^PSS50 (supported)
 ; #4543         IEN^PSN50P65 (supported)
 ; #4549         ZERO^PSS52P6 (supported)
 ; #4826         PSS436^PSS55 (supported)
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*13   DEC  2010   A SAUNDERS   Patient Med History Report: retrieve 
 ;                                      #refills remaining and add to the 
 ;                                      'callback' function call
 ;                                      NOTE: Patch 11 became patch 13.
 ;                                      Any references to patch 11 in the code
 ;                                      below is referring to path 13.
 ;
 ;ROR*1.5*26   JUN 2015    T KOPP       Callback function for SVR screening
 ;                                      does not require the # of refills as a
 ;                                      parameter for the Patient Med History
 ;                                      Report, so a check is made for callback
 ;                                      entry point RXOCB to prevent adding it.
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;
 ;***** DOUBLE-CHECKS THE OUTPATIENT RX (ORDER, REFILLS AND PARTIALS)
 ;
 ; STDT          Start Date (FileMan)
 ; ENDT          End Date   (FileMan)
 ;
 ; [.NREF]       Number of refills is returned via this parameter
 ;
 ; [.NPAR]       Nubmer of partials is returned via this parameter
 ;
 ; The ^TMP("PS",$J) node must be populated by the OEL^PSOORRL
 ; before calling this function.
 ;
 ; Return Values:
 ;        0  Ok
 ;        1  Skip the order
 ;
DTCHECK(STDT,ENDT,NREF,NPAR) ;
 N IRP,RXDT,SKIP
 S RXDT=+$P($G(^TMP("PS",$J,"RXN",0)),U,6),(NREF,NPAR)=0
 S SKIP=(RXDT<STDT)!(RXDT'<ENDT)
 ;--- Refills
 S IRP=0
 F  S IRP=$O(^TMP("PS",$J,"REF",IRP))  Q:IRP'>0  D
 . S RXDT=+$P($G(^TMP("PS",$J,"REF",IRP,0)),U)
 . I RXDT'<STDT,RXDT<ENDT  S SKIP=0,NREF=NREF+1  Q
 . K ^TMP("PS",$J,"REF",IRP)
 ;--- Partials
 S IRP=0
 F  S IRP=$O(^TMP("PS",$J,"PAR",IRP))  Q:IRP'>0  D
 . S RXDT=+$P($G(^TMP("PS",$J,"PAR",IRP,0)),U)
 . I RXDT'<STDT,RXDT<ENDT  S SKIP=0,NPAR=NPAR+1  Q
 . K ^TMP("PS",$J,"PAR",IRP)
 ;---
 Q SKIP
 ;
 ;***** PROCESSES THE LIST OF PRESELECTED PHARMACY ORDERS
 ;
 ; PTIEN         IEN of the patient (DFN)
 ;
 ; RORFLAGS      Flags to control processing
 ;
 ; ROR8LST       Closed root of the list of preselected orders
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  No orders have been found
 ;       >0  Number of orders
 ;
PROCESS(PTIEN,RORFLAGS,ROR8LST) ;
 N DRUGIEN,IRX,IVM,LOADEXT,ORDDATE,ORDER,ORDIEN,ORDFLG,RC,ROR8SET,RORLST,RORTMP,RORTS,RORXCNT,TMP,NUMREF
 S LOADEXT=(RORFLAGS["E")
 S (RC,RORXCNT)=0
 S RORTMP=$$ALLOC^RORTMP(.RORTS)
 ;
 ;=== Determine the storage method (default or callback)
 I $G(ROR8DST("RORCB"))?2"$"1.8UN1"^"1.8UN  D
 . ;standard callback setup
 . S ROR8SET="S RC="_ROR8DST("RORCB")_"(.ROR8DST,ORDER"
 . S ROR8SET=ROR8SET_",ORDFLG,DRUGIEN_U_DRUGNAME,ORDDATE)"
 . ;Patch 11/13: Variable 'RORX011' is set in routine RORX011 for the
 . ;Patient Medications History report.  If set, add # refills
 . ;remaining (NUMREF) to the callback parameter list.
 . I $G(RORX011),$G(ROR8DST("RORCB"))'["RXOCB" S ROR8SET=$E(ROR8SET,1,$L(ROR8SET)-1)_",$G(NUMREF))"
 . ;---
 . S ROR8DST("RORDFN")=PTIEN
 . S ROR8DST("ROREDT")=ROREDT
 . S ROR8DST("RORFLAGS")=RORFLAGS
 . S ROR8DST("RORSDT")=RORSDT
 E  S ROR8SET=""  K @ROR8DST
 ;
 ;=== Process the list of preselected orders
 S (IRX,RC)=0
 F  S IRX=$O(@ROR8LST@(IRX))  Q:'IRX  D  Q:RC
 . S ORDFLG=$P(@ROR8LST@(IRX),U)
 . S TMP=@ROR8LST@(IRX,0)
 . S ORDER=$P(TMP,U),ORDDATE=$P(TMP,U,15)
 . ;Patch 11/13: get #refills remaining for Patient Medication History report:
 . I $G(RORX011) S NUMREF=$P(TMP,U,5)
 . ;--- Get the order details
 . K ^TMP("PS",$J)
 . D OEL^PSOORRL(PTIEN,ORDER)
 . Q:$D(^TMP("PS",$J))<10
 . ;=== Inpatient and Outpatient Medications
 . I ORDFLG'["V"  D  Q
 . . ;--- Double-check the dates for outpatient orders
 . . I ORDFLG["O"  Q:$$DTCHECK(RORSDT,ROREDT)
 . . ;--- Get the drug IEN in the DRUG file (#50)
 . . S TMP=$G(^TMP("PS",$J,"DD",1,0)),DRUGIEN=+$P(TMP,U,3)
 . . I DRUGIEN'>0  S DRUGIEN=+$P(TMP,U)  Q:DRUGIEN'>0
 . . ;--- Process the order
 . . S RC=$$PROCMED(ORDER,ORDFLG,DRUGIEN,ORDDATE)
 . . S:'RC RORXCNT=RORXCNT+1
 . . S:RC=1 RC=0
 . ;=== IV Medications
 . S RORLST=$$ALLOC^RORTMP(.TMP),ORDIEN=+ORDER
 . D
 . . N IEN,ORDER  ; Workaround for the bug in the API
 . . D PSS436^PSS55(PTIEN,ORDIEN,TMP)
 . I $G(@RORLST@(0))'>0  D FREE^RORTMP(RORLST)  Q
 . ;--- Process the additives
 . S IVM=0
 . F  S IVM=$O(@RORLST@(ORDIEN,"ADD",IVM))  Q:IVM'>0  D  Q:RC
 . . ;--- IEN in the IV ADDITIVES file (#52.6)
 . . S DRUGIEN=+$P($G(@RORLST@(ORDIEN,"ADD",IVM,.01)),U)
 . . Q:DRUGIEN'>0
 . . ;--- IEN in the DRUG file (#50)
 . . D ZERO^PSS52P6(DRUGIEN,,,RORTS)
 . . Q:$G(@RORTMP@(0))'>0
 . . S DRUGIEN=+$P($G(@RORTMP@(DRUGIEN,1)),U)
 . . Q:DRUGIEN'>0
 . . ;--- Process the medication
 . . S RC=$$PROCMED(ORDER,ORDFLG,DRUGIEN,ORDDATE)
 . . S:'RC RORXCNT=RORXCNT+1
 . . S:RC=1 RC=0
 . ;---
 . D FREE^RORTMP(RORLST)
 ;
 ;===
 D FREE^RORTMP(RORTMP)
 Q $S(RC<0:RC,1:RORXCNT)
 ;
 ;***** PROCESS THE MEDICATION (internal)
 ;
 ; DRUGIEN       IEN of the medication in the DRUG file (#50)
 ;
 ; The ROR8DST, ROR8RXS, ROR8SET, RORTMP, and RORTS variables
 ; must be defined before calling this function.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;        1  Skip this medication
 ;        2  Skip this and all remaining medications
 ;
PROCMED(ORDER,ORDFLG,DRUGIEN,ORDDATE) ;
 N DRUGNAME,RC,ROR8BUF,SKIP,TMP
 S RC=0
 ;=== Load some drug data
 D ARWS^PSS50(DRUGIEN,,RORTS)  K ROR8BUF
 F TMP=2,20,25  S ROR8BUF(TMP)=$G(@RORTMP@(DRUGIEN,TMP))
 S DRUGNAME=$G(@RORTMP@(DRUGIEN,.01))
 S:DRUGNAME="" DRUGNAME="Unknown (IEN="_DRUGIEN_")"
 K @RORTMP
 ;--- Generic Drug
 S ROR8DST("RORXGEN")=ROR8BUF(20)
 I $P(ROR8BUF(20),U,2)=""  D  S $P(ROR8DST("RORXGEN"),U,2)=TMP
 . S TMP="Unknown ("_(+ROR8BUF(20))_")"
 ;--- VA Drug Class
 S ROR8DST("RORXVCL")=""
 D:ROR8BUF(2)'=""
 . ;--- If the "national" drug class is the same, use its IEN
 . I $P(ROR8BUF(25),U,2)=ROR8BUF(2)  D  Q
 . . S ROR8DST("RORXVCL")=$P(ROR8BUF(25),U,1,2)
 . ;--- Get the Drug Class IEN
 . D IEN^PSN50P65(,ROR8BUF(2),RORTS)
 . S TMP=+$G(@RORTMP@(0))
 . S:TMP=1 ROR8DST("RORXVCL")=+$O(@RORTMP@(0))_U_ROR8BUF(2)
 . K @RORTMP
 ;
 ;=== Check if the drug should be skipped
 I ROR8RXS'="*"  S SKIP=0  D  Q:SKIP 1
 . Q:$D(@ROR8RXS@(DRUGIEN))
 . I $D(@ROR8RXS@("C"))>1  Q:$D(@ROR8RXS@("C",+ROR8DST("RORXVCL")))
 . I $D(@ROR8RXS@("G"))>1  Q:$D(@ROR8RXS@("G",+ROR8DST("RORXGEN")))
 . S SKIP=1
 ;
 ;--- Load additional drug data
 ;D:LOADEXT
 ;.
 ;
 ;=== Default output
 I ROR8SET=""  D  Q 0
 . S RORXCNT=RORXCNT+1
 . M @ROR8DST@(RORXCNT)=^TMP("PS",$J)
 . S TMP=ORDER_U_ORDFLG_U_ROR8DST("RORXGEN")
 . S $P(TMP,U,5,6)=ROR8DST("RORXVCL")
 . S @ROR8DST@(RORXCNT)=TMP
 ;=== Callback function
 X ROR8SET  ; (.ROR8DST,ORDER,ORDFLG,DRUGIEN_U_DRUGNAME,ORDDATE,special data for specific reports)
 Q RC
 ;
 ;***** LOADS AND PRESELECTS PHARMACY ORDERS
 ;
 ; PTIEN         IEN of the patient (DFN)
 ;
 ; FLAGS         Flags to control processing
 ;
 ; STDT          Start date (FileMan)
 ; ENDT          End date   (FileMan)
 ;
 ; ROR8LST       Closed root for the list of preselected orders
 ;
 ; @ROR8LST@(
 ;   Seq#,               Flags that describe the order (I,O,P, etc.)
 ;     0)                Content of the ^TMP("PS",$J,i,0) node
 ;                       returned by the OCL^PSOORRL (see the DBIA
 ;                       #2400 for details).
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  No orders have been found
 ;       >0  Number of orders
 ;
QUERY(PTIEN,FLAGS,STDT,ENDT,ROR8LST) ;
 N IEN,IRX,ORDER,RXCNT,TMP,TYPE
 K ^TMP("PS",$J),@ROR8LST
 ;
 ;--- Prepare the flags
 I FLAGS["I"  D  S TYPE("U;I")="I"
 . S:FLAGS["P" TYPE("P;I")="IP"
 . S:FLAGS["V" TYPE("V;I")="IV"
 I FLAGS["O"  D  S TYPE("R;O")="O"
 . S:FLAGS["P" TYPE("P;O")="OP"
 ;
 ;--- Load the list of pharmacy orders
 D OCL^PSOORRL(PTIEN,STDT,ENDT)
 Q:$D(^TMP("PS",$J))<10 0
 ;
 ;--- Preselect the orders
 S (IRX,RXCNT)=0
 F  S IRX=$O(^TMP("PS",$J,IRX))  Q:'IRX  D
 . S ORDER=$P($G(^TMP("PS",$J,IRX,0)),U)  Q:ORDER'>0
 . ;--- Check the type of order
 . S TMP=$L(ORDER),TYPE=$E(ORDER,TMP-2,TMP)
 . S TYPE=$G(TYPE(TYPE))  Q:TYPE=""
 . ;--- Double-check the dates
 . I TYPE["I"  D  Q:(TMP<STDT)!(TMP'<ENDT)
 . . S TMP=+$P($G(^TMP("PS",$J,IRX,0)),U,15)
 . I TYPE["O"  D  Q:TMP<STDT
 . . S TMP=+$P($G(^TMP("PS",$J,IRX,0)),U,10)
 . ;--- Select the order
 . S RXCNT=RXCNT+1,@ROR8LST@(RXCNT)=TYPE
 . S @ROR8LST@(RXCNT,0)=^TMP("PS",$J,IRX,0)
 ;
 ;--- Cleanup
 K ^TMP("PS",$J)
 Q RXCNT
