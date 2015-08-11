VPSMRAR9 ;WOIFO/BT - Get the last MRAR data for a patient;01/29/15 15:30
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**3**;Jan 29, 2015;Build 64
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;IA #10103 - supported use of XLFDT functions
 ;IA #10104 - supported use of XLFSTR function
 ;
GET(VPSMRAR,VPSNUM,VPSTYP) ; RPC: VPS GET LAST MRAR
 ; INPUT
 ;   VPSNUM : Parameter Value - patient SSN OR DFN OR ICN OR VIC/CAC (REQUIRED)
 ;   VPSTYP : Parameter TYPE - SSN or DFN OR ICN OR VIC/CAC (REQUIRED)
 ; OUTPUT
 ;   VPSMRAR: local array contains all field names/values for the last mrar
 ;   WITH ERROR -> VPSMRAR(0) = -1 ^ error message
 ;   SUCCESS    -> VPSMRAR(0) = 1
 ;              -> VPSMRAR(1..n) = FIELD NAME^SUBS^DATA
 ;
 ; -- validate input parameters
 S VPSNUM=$G(VPSNUM)
 S VPSTYP=$G(VPSTYP)
 N VPSDFN S VPSDFN=$$VALIDATE^VPSRPC1(VPSTYP,VPSNUM)
 I VPSDFN<1 S VPSMRAR(0)=-1_U_$P(VPSDFN,U,2) QUIT
 ;
 ; -- get last mrar ien for the patient
 N LASTMRAR S LASTMRAR=$O(^VPS(853.5,VPSDFN,"MRAR","B",""),-1)
 I 'LASTMRAR S VPSMRAR(0)=-1_U_"This patient has no MRAR transaction." QUIT
 ;
 ; -- retrieve transaction level fields and store them in VPSMRAR
 D TRANS^VPSMR51(.VPSMRAR,VPSDFN,LASTMRAR)
 ;
 ; -- retrieve conducted with level fields and store them in VPSMRAR
 D CNDWTH^VPSMR51(.VPSMRAR,VPSDFN,LASTMRAR)
 ;
 ; -- retrieve Allergy level fields and store them in VPSMRAR
 D ALLERGY^VPSMR52(.VPSMRAR,VPSDFN,LASTMRAR)
 ;
 ; -- retrieve Additional Allergy level fields and store them in VPSMRAR
 D ADDALLER^VPSMR52(.VPSMRAR,VPSDFN,LASTMRAR)
 ;
 ; -- retrieve Medication level fields and store them in VPSMRAR
 D MEDS^VPSMR54(.VPSMRAR,VPSDFN,LASTMRAR)
 ;
 ; -- retrieve Additional Medication level fields and store them in VPSMRAR
 D ADDMEDS^VPSMR54(.VPSMRAR,VPSDFN,LASTMRAR)
 ;
 S VPSMRAR(0)=1
 QUIT
 ;
ADD(VPSMRAR,FLDNAM,SUBS,INVAL,EXVAL) ;Add the record to VPSMRAR
 ; INPUT
 ;   FLDNAM : Field name to store
 ;   SUBS   : Subscript (unique identifier for multiple values)
 ;   INVAL  : Fileman Internal Value
 ;   EXVAL  : Fileman Externall Value
 ; OUTPUT
 ;   VPSMRAR: local array contains all field names/values for the last mrar
 ;
 QUIT:INVAL=""&(EXVAL="")
 N LAST S LAST=$O(VPSMRAR(""),-1)+1
 I (EXVAL=INVAL) S INVAL=""
 S VPSMRAR(LAST)=FLDNAM_U_SUBS_U_EXVAL_$S(INVAL="":"",1:U_INVAL)
 QUIT
 ;
WP(REC,FIL,SUBS,FLD) ;return word-processing value
 QUIT:$G(REC(FIL,SUBS,FLD,"E"))="" ""
 ;
 N WP S WP=""
 N LF S LF=$C(13,10)
 N IDX S IDX=0
 ;
 F  S IDX=$O(REC(FIL,SUBS,FLD,IDX)) Q:'IDX  D
 . S WP=WP_REC(FIL,SUBS,FLD,IDX)_LF
 ;
 QUIT $P(WP,LF,1,$L(WP,LF)-1)
