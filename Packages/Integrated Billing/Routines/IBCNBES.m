IBCNBES ;ALB/ARH-Ins Buffer: stuff new entries/data into buffer ;1 Jun 97
 ;;2.0;INTEGRATED BILLING;**82,184,345**;21-MAR-94;Build 28
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
ADDSTF(IBSOURCE,DFN,IBDATA) ;  add new entry to Insurance Buffer file (355.33) and stuff the data passed in, no user interaction
 ;  IBSOURCE = source of information             (required)
 ;             1 = interview           2 = data match
 ;             3 = ivm                 4 = pre-registration
 ;             5 = eIV
 ;  DFN      = patient's ifn in file 2           (required)
 ;  IBDATA   = data to file in Buffer in an array subscripted by field number of the data field in 355.33
 ;             ex:  IBDATA(20.01)="Insurance Company Name", etc,
 ;  returns ien of new entry or 0 followed by error if entry not added
 ;
 ;  example of call: $$ADDBUF^IBCNBES(2,DFN,.IBDATA)   where IBDATA(field #) = value
 ;
 N X,Y,IBBUFDA,IBERROR
 ;
 ;  verify source of information and data exists to store
 I $G(IBSOURCE)="" S IBERROR="SOURCE OF INFORMATION INCORRECT" G EXIT
 I $G(^DPT(+$G(DFN),0))="" S IBERROR="NO PATIENT DEFINED" G EXIT
 I $D(IBDATA)<10 S IBERROR="NO DATA TO STORE" G EXIT
 ;
 ;  add new entry to Buffer file (355.33)
 S IBBUFDA=+$$ADD^IBCNBEE(IBSOURCE) I 'IBBUFDA S IBERROR="COULD NOT CREATE A NEW BUFFER ENTRY" G EXIT
 ;
 S IBDATA(60.01)=+DFN
 ;
 ; Set up DUZ (interface user) so 60.01 field check can find 'valid reason' for sensitive
 ; patients and not set 60.01 to '0' with an error in tag FLDCHK
 I '$G(DUZ) D DUZ^XUP(.5)
 ;
 D EDITSTF(+IBBUFDA,.IBDATA)
 ;
 ; delete leftover ESGHP data if ESGHP? is not Yes
 I +$G(IBBUFDA),$D(^IBA(355.33,$G(IBBUFDA),61)),'$G(^IBA(355.33,$G(IBBUFDA),61)) D DELEMP^IBCNBEE($G(IBBUFDA))
 ;
EXIT Q +$G(IBBUFDA)_"^"_$G(IBERROR)
 ;
EDITSTF(IBBUFDA,IBDATA) ;  loop though data array and stuff each buffer field, no user interaction
 ;
 N IBFIELD,IBVALUE,IBARR,IBERR Q:'$G(^IBA(355.33,$G(IBBUFDA),0))
 ;
 S IBFIELD=0 F  S IBFIELD=$O(IBDATA(IBFIELD)) Q:'IBFIELD  D
 . S IBVALUE=$$FLDCHK(355.33,IBFIELD,IBDATA(IBFIELD)) Q:'IBVALUE
 . S IBARR(355.33,IBBUFDA_",",IBFIELD)=$P(IBVALUE,U,2)
 I $D(IBARR)>9 D FILE^DIE("E","IBARR","IBERR")
 Q
 ;
FLDCHK(FILE,FIELD,VALUE) ; minor checks on data: truncate if length too long, if pointer add ' so can be processed as external format
 N IBATTR,IBERR,IBX S IBX="1^"_VALUE
 I VALUE="" S IBX="0^No data value." G FLDCHKQ
 D FIELD^DID(FILE,FIELD,"N","FIELD LENGTH;SPECIFIER","IBATTR","IBERR")
 I $D(IBERR) S IBX="0^"_$G(IBERR("DIERR",1,"TEXT",1)) G FLDCHKQ
 I $G(IBATTR("SPECIFIER"))["P" S IBX="1^`"_VALUE G FLDCHKQ
 I $D(IBATTR("FIELD LENGTH")) S IBX="1^"_$E(VALUE,1,+IBATTR("FIELD LENGTH"))
FLDCHKQ Q IBX
