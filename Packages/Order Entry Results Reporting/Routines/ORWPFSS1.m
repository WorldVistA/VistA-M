ORWPFSS1 ;SLC/GSS - CPRS PFSS; 05/24/05 [05/24/05 11:44am]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**228**;Dec 17, 1997
 ; Sub-routines for phase II of the CPRS PFSS project (CPRS v26=phase I)
 ;
 Q
 ;
ACCTREF(ORIEN,ORACTREF) ;File PFSS Account Reference Number (ARN)
 ; PFSS ARN stored as 1st piece of ^OR(100,ORIEN,5.5), aka Field #97
 ; Call as an extrinsic function,i.e., $$ACCTREF^ORWPFSS1(ORIEN,ORACTREF)
 ;
 ; Input:
 ;   ORIEN     Order internal reference number related to PFSS ARN
 ;   ORACTREF  PFSS ARN to store, which is a pointer to File #375
 ; Output:
 ;   if error, returns #^reason, where #>1
 ;   if valid, returns 1
 ;
 ; Additional variables used:
 ;   ORERCK    error variable (error #^verbiage)
 ;
 ; new variables
 N ARE,ORER,ORERCK,ORFDA,ORNEWER
 ;
 ; check for a valid ORIEN
 S ORERCK=$$ORDERCK^ORWPFSS(ORIEN)
 I +ORERCK>1 Q ORERCK
 ;
 ; check for pre-existing, non-null entry, if there is to be no editing
 I $G(^OR(100,ORIEN,5.5))'="" Q 97_U_"PFSS Acct Ref # exists in Order file"
 ; check that PFSS ARN is in a valid format
 I '+ORACTREF Q 98_U_"PFSS is null or of invalid format"
 ; check that PFSS ARN exists in PFSS Acount file #375 - DBIA #4741
 I '$D(^IBBAA(375,ORACTREF,0)) Q 99_U_"PFSS Acct Ref # doesn't exist"
 ;
 ; store PARN (while checking for errors)
 S ORERCK=$$STRPARN(ORIEN,ORACTREF)
 Q ORERCK
 ;
EDO1 ; Event Delayed Orders called from EN1^ORCSEND for delayed releases
 ;
 ;  EIEN     = Release event IEN
 ;  EPOINTER = Event pointer
 ;  ETYPE    = Event type
 ;  DFN      = Patient IEN
 ;  ORACTREF = PFSS Account Reference Number
 ;  ORERCK   = Order check results (1 = OK)
 ;  ORIFN    = Order IEN (previously defined)
 ;
 ; new variables used
 N EIEN,EPOINTER,ETYPE,DFN,ORACTREF,ORERCK,ORPFSS
 ;
 ; quit if PFSS is not active
 D PFSSACTV^ORWPFSS(.ORPFSS) I ORPFSS=0 G EDO1Q
 ;
 ; check validity/support of order
 S ORERCK=$$ORDERCK^ORWPFSS(ORIFN) I +ORERCK>1 G EDO1Q
 ;
 ; get Event Pointer
 S EPOINTER=$P(^OR(100,ORIFN,0),U,17)
 ; if EPOINTER is null then quit
 I EPOINTER="" G EDO1Q
 ;
 ; get Release Event Record
 S EIEN=$P(^ORE(100.2,EPOINTER,0),U,2)
 ; if EIEN is null then quit
 I EIEN="" G EDO1Q
 ;
 ; get Event Type
 S ETYPE=$P(^ORD(100.5,EIEN,0),U,2)
 ;
 ; if ETYPE is Admission or Transfer get PFSS ARN from VADPT
 I ETYPE="A"!(ETYPE="T") D
 . ; set patient IEN (DFN)
 . S DFN=$P($P(^OR(100,ORIFN,0),";"),U,2)
 . ; call VADPT (hospital adm/txfr) routine to get PFSS ARN (ORACTREF)
 . S ORACTREF=$$HAAR^ORWPFSS4(DFN)
 . ; store PFSS ARN in Order file (#100)
 . S X=$$STRPARN(ORIFN,ORACTREF)
 ;
 ; if ETYPE is Discharge store PFSS ARN as null in Order file (#100)
 I ETYPE="D" S X=$$STRPARN(ORIFN,"")
 ;
 ; ???-course of action if errors or EPOINTER or EIEN null?
EDO1Q Q
 ;
EDO2 ; Event Delayed Orders called from EN2^ORCSEND for manual releases
 ; Get the PARN in effecxt when the event delayed order (EDO) released.
 ;
 ; Variables used:
 ;  EIEN     = Release event IEN
 ;  EPOINTER = Event pointer
 ;  DFN      = Patient IEN
 ;  ORACTREF = PFSS Account Reference Number
 ;  ORERCK   = Order check results (1 = OK)
 ;  ORIFN    = Order IEN (previously defined)
 ;
 ; new variables used
 N EIEN,EPOINTER,ETYPE,DFN,ORACTREF,ORERCK,ORPFSS
 ;
 ; quit if PFSS is not active
 D PFSSACTV^ORWPFSS(.ORPFSS) I ORPFSS=0 G EDO2Q
 ;
 ; check validity/support of order
 S ORERCK=$$ORDERCK^ORWPFSS(ORIFN) I +ORERCK>1 G EDO2Q
 ;
 ; get Event Pointer
 S EPOINTER=$P(^OR(100,ORIFN,0),U,17)
 ; if EPOINTER is null then quit
 I EPOINTER="" G EDO2Q
 ;
 ; get Release Event Record
 S EIEN=$P(^ORE(100.2,EPOINTER,0),U,2)
 ; if EIEN is null then quit
 I EIEN="" G EDO2Q
 ;
 ; set patient IEN (DFN)
 S DFN=$P($P(^OR(100,ORIFN,0),";"),U,2)
 ; call VADPT (hospital adm/txfr) routine to get PFSS ARN (ORACTREF)
 S ORACTREF=$$HAAR^ORWPFSS4(DFN)
 ; store PFSS ARN in Order file (#100)
 S X=$$STRPARN(ORIFN,ORACTREF)
 ;
 ; ???-course of action if errors or EPOINTER or EIEN null?
EDO2Q Q
 ;
STRPARN(ORIEN,ORACTREF) ; store of PFSS ARN
 ; stores PFSS Account Reference Number in the Order file #100, field 97
 ; see ACCTREF for passed in variable descriptions
 ;
 ; Variables used:
 ;   ORER      = Error message
 ;   ORFIELD   = PFSS ARN field (#97)
 ;   ORFILE    = ORDER file (#100)
 ;   ORFLAGS   = null (flags used in controlling use of FDA^DIFL)
 ;
 ; new variables
 N ORER,ORFILE,ORFIELD,ORFLAGS
 ;
 ; set contants
 S ORFILE=100,ORFIELD=97,ORFLAGS=""
 ;
 ; do FDA loader to compose FDA_ROOT
 D FDA^DILF(ORFILE,ORIEN,ORFIELD,ORFLAGS,ORACTREF,"ORFDA","ORER")
 ; check for an error
 D ERRCHK I $D(ORNEWER) Q ORER
 ; file PFSS ARN in Order file
 D UPDATE^DIE("","ORFDA","","ORER")
 ; another error check
 D ERRCHK I $D(ORNEWER) Q ORER
 ; successful data
 Q 1
 ;
ERRCHK ; Compose error message if there's an error from use of DILF or DIE
 I $G(ORER("DIERR",1)) D
 . S ORNEWER=$G(ORER("DIERR",1))_U_$G(ORER("DIERR",1,"TEXT",1))
 Q
