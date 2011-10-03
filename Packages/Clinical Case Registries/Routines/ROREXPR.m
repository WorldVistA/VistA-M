ROREXPR ;HCIOFO/SG - PREPARATION FOR DATA EXTRACTION  ; 11/2/05 8:56am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** PREPARES VARIABLES FOR DATA EXTRACTION
 ;
 ; .REGLST       Reference to a local array containing registry
 ;               names as subscripts and registry IENs as values
 ;
 ; [DXBEG]       Data extraction start date (individual start
 ;               date for each patient by default).
 ;               Time part of the parameter value is ignored.
 ;
 ; [DXEND]       Data extraction end date (TODAY by default)
 ;               Time part of the parameter value is ignored.
 ;
 ; DXBEG and DXEND parameters may be used only for historical data
 ; extraction. Use of these parameters for regular data extraction
 ; process will negatively affect the package!
 ;
 ; This function does not kill the ROREXT("DTAR") node! It just adds
 ; missing data areas to those that are already present in the list.
 ;
 ; Data extraction parameters are aggregated from individual
 ; registry parameters as follow:
 ;
 ;   EXTRACT PERIOD FOR NEW PATIENT  Maximum
 ;   LAG DAYS                        Maximum
 ;   EXTRACTED RESULT                Union
 ;   MAXIMUM MESSAGE SIZE            Minimum
 ;
 ; Return Values:
 ;        0  Ok
 ;       <0  Error code
 ;
PREPARE(REGLST,DXBEG,DXEND) ;
 N I,IL,IR,LOINC,NODE,RC,REGIEN,REGNAME,RORBUF,RORMSG,TMP,VAL
 K RORLRC
 F TMP="DXBEG","HDTIEN","LD","MAXHL7SIZE","PATCH"  K ROREXT(TMP)
 S DXBEG=$G(DXBEG)\1,DXEND=$G(DXEND)\1
 ;
 ;=== Data areas
 S NODE=$$ROOT^DILFD(799.33,,1)
 ;--- Validate the existing list
 S IR=0
 F  S IR=$O(ROREXT("DTAR",IR))  Q:IR'>0  D
 . I '$D(@NODE@(IR))  K ROREXT("DTAR",IR)  Q
 . S TMP=$G(ROREXT("DTAR",IR))
 . S:TMP>0 ROREXT("DTAR",IR)=($P(TMP,U)\1)_U_($P(TMP,U,2)\1)
 ;--- Add remaining data areas
 S IR=0
 F  S IR=$O(@NODE@(IR))  Q:IR'>0  D:'$D(ROREXT("DTAR",IR))
 . S ROREXT("DTAR",IR)=""
 ;
 ;=== Main data extraction time frame
 S ROREXT("DXEND")=$S(DXEND>0:DXEND,1:$$DT^XLFDT)
 I DXBEG>0  S RC=0  D  Q:RC<0 RC
 . S ROREXT("DXBEG")=DXBEG  Q:DXBEG'>ROREXT("DXEND")
 . S RC=$$ERROR^RORERR(-32,,,,DXBEG,ROREXT("DXEND"))
 ;
 ;=== Check if the critical patches are installed
 F TMP="MD*1.0*1","MC*2.3*34","GMPL*2*30"  D
 . S:$$PATCH^XPDUTL(TMP) ROREXT("PATCH",TMP)=""
 ;
 ;=== Get the package version and the latest patch info
 S TMP="CLINICAL CASE REGISTRIES"
 S ROREXT("VERSION")=$$VERSION^XPDUTL(TMP)
 S TMP=$$LAST^XPDUTL(TMP)  D:TMP>0
 . S $P(ROREXT("VERSION"),U,2)=+TMP
 . S $P(ROREXT("VERSION"),U,3)=$P(TMP,U,2)
 ;
 ;=== Aggregate registry parameters
 S REGNAME="",RC=0
 F  S REGNAME=$O(REGLST(REGNAME))  Q:REGNAME=""  D  Q:RC<0
 . ;--- Get the registry IEN and parameters
 . S REGIEN=$$REGIEN^RORUTL02(REGNAME,"7;10;13;13.1;15.1",.RORBUF)
 . I REGIEN<0  S RC=REGIEN  Q
 . ;--- Extract Period for New Patient
 . S VAL=+$G(RORBUF("DILIST","ID",1,7))
 . S:VAL>$G(ROREXT("EXTRDAYS")) ROREXT("EXTRDAYS")=VAL
 . ;--- Setup the message builder call-back entry point
 . S VAL=$$TRIM^XLFSTR($G(RORBUF("DILIST","ID",1,10)))
 . I VAL'=""  D  Q:RC<0
 . . S RC=$$VERIFYEP^RORUTL01(VAL)
 . . I RC<0  D ERROR^RORERR(-44,,REGNAME,,VAL)  Q
 . . S ROREXT("MSGBLD",REGIEN)=VAL
 . ;--- Use the first available HL7 event protocol if it has not
 . ;--- been defined before calling the $$PREPARE^ROREXPR
 . D:$G(ROREXT("HL7PROT"))=""
 . . S ROREXT("HL7PROT")=$G(RORBUF("DILIST","ID",1,13))
 . ;--- Load maximum message size and convert it into bytes
 . ;--- (1 Megabyte = 1024 Kb = 1024 * 1024 = 1048576 bytes)
 . S VAL=($G(RORBUF("DILIST","ID",1,13.1))*1048576)\1
 . I VAL>0  D  S:(TMP'>0)!(VAL<TMP) ROREXT("MAXHL7SIZE")=VAL
 . . S TMP=+$G(ROREXT("MAXHL7SIZE"))
 . ;--- Setup the lag interval (for regular data extraction only)
 . D:'$G(ROREXT("DXBEG"))
 . . S VAL=+$G(RORBUF("DILIST","ID",1,15.1))
 . . S:VAL>$G(ROREXT("LD",1)) ROREXT("LD",1)=VAL
 . ;--- Load list of codes of extracted Lab results
 . I $G(RORLRC)'="*"  D  Q:RC<0
 . . S TMP=","_REGIEN_","
 . . D LIST^DIC(798.112,TMP,"@;.01;.02;.03","U",,,,"B",,,,"RORMSG")
 . . I $G(DIERR)  S RC=$$DBS^RORERR("RORMSG",-9,,,798.112,TMP)  Q
 . . Q:$G(^TMP("DILIST",$J,0))'>0
 . . S (IL,IR,RC)=0
 . . F  S IR=$O(^TMP("DILIST",$J,"ID",IR))  Q:IR=""  D  Q:RC
 . . . S LOINC=$G(^TMP("DILIST",$J,"ID",IR,.01))
 . . . ;--- All results or list of subscripts
 . . . I LOINC="*"  D  S RC=1  Q
 . . . . S VAL=$G(^TMP("DILIST",$J,"ID",IR,.03))
 . . . . I VAL=""         K RORLRC  S RORLRC="*"  Q
 . . . . I $G(RORLRC)=""  K RORLRC  S RORLRC=VAL  Q
 . . . . F I=1:1  S TMP=$P(RORLRC,",",I)  Q:(TMP="")!(TMP=VAL)
 . . . . S:TMP="" RORLRC=RORLRC_","_VAL
 . . . ;--- Ignore individual codes if any subscripts
 . . . ;--- (CH, MI, etc.) have been requested already
 . . . Q:$G(RORLRC)'=""
 . . . ;--- LOINC
 . . . I LOINC>0  D  Q:RC<0  S IL=IL+1,RORLRC(IL)=TMP_"^LN"
 . . . . S TMP=$$LNCODE^RORUTL02(LOINC)  S:TMP<0 RC=TMP
 . . . ;--- NLT
 . . . S TMP=$G(^TMP("DILIST",$J,"ID",IR,.02))
 . . . S:TMP>0 IL=IL+1,RORLRC(IL)=TMP_"^NLT"
 D CLEAN^DILF
 K ^TMP("DILIST",$J)
 Q:RC<0 RC
 ;
 ;=== Validate parameters
 I '$G(ROREXT("DXBEG"))  S:$G(ROREXT("LD",1))'>0 ROREXT("LD",1)=1
 ;
 ;=== Check the HL7 parameters
 I $G(ROREXT("HL7PROT"))'=""  D  Q:RC<0 RC
 . S RC=$$INIT^RORHL7()
 ;
 ;=== Success
 Q 0
