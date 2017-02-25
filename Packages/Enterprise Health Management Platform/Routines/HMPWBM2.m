HMPWBM2 ;ASMR/RRB - Medication Order Writeback ;Jul 02, 2015@10:19:41
 ;;2.0;HEALTH MANAGEMENT PLATFORM;**2**;Oct 10, 2014;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
ORSAVE(HMPOUT,DFN,DUZ,LOCIEN,DLG,ORDG,ORIT,ORIFN,ORDIALOG,ORDEA,ORAPPT,ORSRC,OREVTDF) ; Calls for saving order
 ; Input Parameters:
 ;     DFN:  Patient DFN acquired when the patient is selected and placed in context.
 ;     DUZ:  Provider IEN acquired during login
 ;     LOCIEN: Ordering Location (locationIen from the Visit)
 ;     DLG: (internalDialogName) Acquired from the ORWDXM DLGNAME RPC
 ;     ORDG:(displayGroupPointer) From the ORWDX WRLST RPC
 ;     ORIT: (orderDialogIen) Acquired from the ORWDX WRLST RPC
 ;     ORIFN: (orderIen) This is only available for existing orders that are being 
 ;             changed or renewed.  New orders do not have an orderIen until they are saved.)
 ;     ORDIALOG: (orderDialogArray) An ordered array consisting of the following....
 ;         A map of the input screen to the dialog question subscripts returned from the
 ;         ORWDX DLGDEF RPC.
 ;         Order checks from the ORWDXC ACCEPT RPC.  These included as:
 ;         ("ORCHECK") = number of order checks
 ;         ("ORCHECK",Piece 1, Piece 3,increment)=Piece 2 through Piece 4 of the order 
 ;                    checks delimited by "^".
 ;         ("ORTS") = treating specialty.  Will be set to 0 (zero) if not available. 
 ;                    (Only applies to inpatient locations.)
 ;     ORDEA: digital signature
 ;     ORAPPT:  date.time stamp of visit in VA format
 ;     ORSRC:  order source
 ;     OREVTDF: (eventDefault) only used for delayed orders
 ;
 ;Associated ICRs:
 ;  ICR#
 ;      3371:  ORWU HASKEY
 ;
 N HMFLTR,JOUT,ORDIEN,OUT
 ;
 D LOCK^ORWDX(.OUT,DFN)  ; Lock patient record
 I OUT'=1 D  G ENDSAVE
 . S HMPOUT="ERROR^Patient record locked by another user."
 ;
 ; Wrap for ORWDX SAVE
 ;      Description:  This RPC saves an order
 ;
 ; Input:  Parameters are as noted above for this routine, ORSAVE^HMPWBM2.
 ;
 ; Output:  Order parameters for the SAVE^ORWDX Broker Call
 ;
 ;          ~orderIen^Grp^OrdTm^StrtTm^StopTm^Sts^Sig^Nrs^Clk^PrvID^PrvNam^Act^Flagged[^DCType]^ChartRev^DEA#^^DigSig^LOC^[DCORIGNAL]^IsPendingDCorder^IsDelayOrder
 ;          There may be multiple lines of text entry.  All will begin with a lower case "t".
 ;               tline 1
 ;               tline 2 
 ;               tline 3 And so forth
 ;
 D SAVE^ORWDX(.OUT,DFN,.DUZ,LOCIEN,DLG,ORDG,ORIT,ORIFN,.ORDIALOG,ORDEA,ORAPPT,ORSRC,OREVTDF)
 ;
 S ORDIEN=+($P($E(OUT(1),2,999),"^",1))  ; Extract the orderIen from the broker output
 ;
 ; Setup and call utility to return JSON order data
 ;
 S HMFLTR("domain")="order",HMFLTR("noHead")=1,HMFLTR("patientId")=DFN,HMFLTR("id")=ORDIEN
 ;
 D GET^HMPDJ(.JOUT,.HMFLTR)
 ;
 ; Return JSON order data
 ;
 ;
 N CNT,HMPDMN,HMPFCNT,I,II,JNAME,JSTRNG,JVALPR,JVALUE,STMPTM,UID,WRPOUT
 ;
 M WRPOUT=@JOUT
 ;
 ; Setup HMPDMN, HMPFCNT, STMPTM, and UID variables necessary for calling ADHOC^HMPUTIL2
 ;
 S HMPDMN="order",HMPFCNT=WRPOUT("total")
 ;
 ; Acquire stampTime and uid JSON name value pairs
 ;
 S I=""
 F  S I=$O(WRPOUT(I)) Q:I=""!(I'?1.N)  D
 . S II=""
 . F  S II=$O(WRPOUT(I,II)) Q:II=""  D
 . . S JSTRNG=$TR($G(WRPOUT(I,II)),$CHAR(34),"")
 . . F CNT=1:1:$L(JSTRNG,",") D
 . . . S JVALPR=$P(JSTRNG,",",CNT)
 . . . S JNAME=$TR($P(JVALPR,":"),"{",""),JVALUE=$TR($E($P(JVALPR,JNAME,2),2,999),"}","")
 . . . I JNAME="stampTime"!(JNAME="uid") D
 . . . . S JNAME=$S(JNAME="stampTime":"STMPTM",JNAME="uid":"UID",1:"")
 . . . . S @JNAME=JVALUE  ; Create the variable names STMPTM and UID, and set their respective values
 ;
 ; Call ADHOC^HMPUTIL2 to wrap JSON order data with metastamp
 ;
 D ADHOC^HMPUTIL2(HMPDMN,HMPFCNT,DFN,UID,STMPTM)
 ;
 ; Return complete JSON order package
 ;
 M HMPOUT=^TMP("HMPF",$J)
 ;
 D UNLOCK^ORWDX(.OUT,DFN)  ; Unlock patient record
 ; "Unlocking the patient record is silent and will always be 1"
 ;
ENDSAVE ;
 ;
 Q
 ;
