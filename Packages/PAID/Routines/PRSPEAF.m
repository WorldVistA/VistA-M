PRSPEAF ;WOIFO/SAB - Ext. Absence Form ;10/27/2004
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ; This routine is called by the PRSP EXT ABSENCE form (file 458.4)
 ; within both the enter option and edit option for extended absences.
 ;
FRMDOC ; Form PRSP EXT ABSENCE documentation
 ; input
 ;   PRSEANEW  - (optional) true (=1) when extended absence entry is new
 ;   PRSIEN    - Employee IEN (file 450)
 ;   DA        - Extended Absence IEN (file 458.4)
 ;   DDSPARM   - (optional) used by enter option to ask for output
 ; output
 ;   DDSCHANGE - (optional) used by enter option to determine if signed 
 ;
FRMPRE ; Form Pre-Action
 ; input
 ;   PRSEANEW
 ; output
 ;   PRSFDT(0) - last E-sig From Date
 ;   PRSTDT(0) - last E-sig To Date
 ;   PRSRMK(0) - last E-sig Remarks
 ;
 ; load field values that were last E-signed
 I $G(PRSEANEW) S (PRSFDT(0),PRSTDT(0),PRSRMK(0))=""
 E  D
 . S PRSFDT(0)=$$GET^DDSVAL(458.4,DA,.01)
 . S PRSTDT(0)=$$GET^DDSVAL(458.4,DA,1)
 . S PRSRMK(0)=$$GET^DDSVAL(458.4,DA,6)
 ;
 ; if From Date prior to Today, disable edit of From Date
 I '$G(PRSEANEW),PRSFDT(0)<DT D
 . D UNED^DDSUTL("FROM DATE",1,1,1,DA_",")
 . D HLP^DDSUTL("From Date can't be edited because it's prior to Today.")
 Q
 ;
FVAL01 ; Field Validation for From Date (#1) field
 ; input
 ;   X      - current internal value of field
 ;   DDSEXT - current external value of field
 ;   DDSOLD - previous internal value of field
 ;   PRSIEN - Employee IEN (file 450)
 ; output
 ;   DDSERROR - (optional) set on error to prevent field change
 ;
 I X<DT D  Q
 . S DDSERROR=1
 . D HLP^DDSUTL("From Date must not be prior to Today!")
 ;
 I X>$$FMADD^XLFDT(DT,365) D  Q
 . S DDSERROR=1
 . D HLP^DDSUTL("From Date must not be more than 365 days in Future!")
 ;
 I X=DT,$$CHKRG^PRSPEAU(PRSIEN) D  Q
 . S DDSERROR=1
 . D HLP^DDSUTL("From Date can't be Today because RG already posted on the ESR!")
 ;
 ; perform date comparison validation
 D DTCV(X,$$GET^DDSVAL(458.4,DA,1)) Q:$G(DDSERROR)
 ;
 ; if date changed and new date not under memo then warn user
 I X'=DDSOLD,$$MIEN^PRSPUT1(PRSIEN,X)'>0 D HLP^DDSUTL("Note: New From Date is not covered by a memo.")
 ;
 Q
 ;
FVAL1 ; Field Validation for To Date (#1) field
 ; input
 ;   X      - current internal value of field
 ;   DDSEXT - current external value of field
 ;   DDSOLD - previous internal value of field
 ; output
 ;   DDSERROR - (optional) set on error to prevent field change
 ;
 ; perform date comparison validation
 D DTCV($$GET^DDSVAL(458.4,DA,.01),X) Q:$G(DDSERROR)
 ;
 I X<DT D  Q
 . S DDSERROR=1
 . D HLP^DDSUTL("To Date must not be prior to Today!")
 ;
 I X=DT,$$CHKRG^PRSPEAU(PRSIEN) D  Q
 . S DDSERROR=1
 . D HLP^DDSUTL("To Date can't be Today because RG already posted on the ESR!")
 ;
 ; if date changed and new date not under memo then warn user
 I X'=DDSOLD,$$MIEN^PRSPUT1(PRSIEN,X)'>0 D HLP^DDSUTL("Note: New To Date is not covered by a memo.")
 ;
 Q
 ;
FRMVAL ; Form Validation
 ; input
 ;   PRSFDT(0) - last E-sig From Date
 ;   PRSTDT(0) - last E-sig To Date
 ;   PRSRMK(0) - last E-sig Remarks
 ; output
 ;   PRSFDT(1) - current From Date
 ;   PRSTDT(1) - current To Date
 ;   PRSRMK(1) - current Remarks
 ;   PRSLCK(   - array of locked pay periods
 ;   DDSERROR  - (optional) set on error to prevent save
 ;
 ; get current values of fields
 S PRSFDT(1)=$$GET^DDSVAL(458.4,DA,.01) ; From Date
 S PRSTDT(1)=$$GET^DDSVAL(458.4,DA,1) ; To Date
 S PRSRMK(1)=$$GET^DDSVAL(458.4,DA,6) ; Remarks
 ;
 ; Skip validation if no changes since last E-Sig
 Q:(PRSFDT(1)=PRSFDT(0))&(PRSTDT(1)=PRSTDT(0))&(PRSRMK(1)=PRSRMK(0))
 ;
 ; ask for electronic signature
 D  Q:$G(DDSERROR)
 . N X1
 . D SIG^XUSESIG
 . S:X1="" DDSERROR=1
 ;
 ; skip remaining step if dates did not change (i.e. only remarks edited)
 Q:(PRSFDT(1)=PRSFDT(0))&(PRSTDT(1)=PRSTDT(0))
 ;
 ; lock timecards for applicable opened pay periods
 D TCLCK^PRSPAPU(PRSIEN,PRSFDT(0),PRSTDT(0),PRSFDT(1),PRSTDT(1),.PRSLCK,.PRSLCKE)
 ;
 ; if some time cards couldn't be locked then don't accept changes
 I $D(PRSLCKE) D
 . N PRSTXT
 . S DDSERROR=1
 . D TCULCK^PRSPAPU(PRSIEN,.PRSLCK) ; remove any locks
 . D RLCKE^PRSPAPU(.PRSLCKE,0,"PRSTXT")
 . D HLP^DDSUTL(.PRSTXT)
 . K PRSLCKE
 ;
 Q
 ;
FRMPSV ; Form Post Save
 ; input
 ;   - previous signed values x(0) and new signed values x(1)
 ;   - array of locked pay periods
 ;
 ; Skip post save if no changes
 Q:(PRSFDT(1)=PRSFDT(0))&(PRSTDT(1)=PRSTDT(0))&(PRSRMK(1)=PRSRMK(0))
 ;
 N PRSFDA
 ;
 ; Update Extended Absence
 I PRSFDT(0)="" D
 . S PRSFDA(458.4,DA_",",3)=$$NOW^XLFDT() ; d/t entered
 . S PRSFDA(458.4,DA_",",5)="A" ; status = active
 E  S PRSFDA(458.4,DA_",",4)=$$NOW^XLFDT() ; d/t updated
 D FILE^DIE("","PRSFDA") D MSG^DIALOG()
 ;
 ; Update signed remark value
 S PRSRMK(0)=PRSRMK(1)
 ;
 ; skip remaining step if dates did not change (i.e. only remarks edited)
 Q:(PRSFDT(1)=PRSFDT(0))&(PRSTDT(1)=PRSTDT(0))
 ;
 ; Update ESRs for new date range
 D:'PRSFDT(0) PEA^PRSPEAA(PRSIEN,PRSFDT(1),PRSTDT(1))
 ; Update ESRs for changed date range
 D:PRSFDT(0) CEA^PRSPEAA(PRSIEN,PRSFDT(0),PRSTDT(0),PRSFDT(1),PRSTDT(1))
 ;
 ; remove time card locks
 D TCULCK^PRSPAPU(PRSIEN,.PRSLCK)
 ;
 ; Update signed date values
 S PRSFDT(0)=PRSFDT(1)
 S PRSTDT(0)=PRSTDT(1)
 Q
 ;
FRMPST ; Form Post-Action
 K PRSFDT(0),PRSFDT(1),PRSRMK(0),PRSRMK(1),PRSTDT(0),PRSTDT(1)
 Q
 ;
DTCV(FDT,TDT) ; Date Compare Validation on FROM DATE and TO DATE fields
 Q:FDT=""!(TDT="")
 ;
 N PRSX
 ;
 I FDT>TDT D  Q
 . S DDSERROR=1
 . D HLP^DDSUTL("From Date must not be later than To Date!")
 ;
 I $$FMDIFF^XLFDT(TDT,FDT)>180 D  Q
 . S DDSERROR=1
 . D HLP^DDSUTL("Difference between From Date and To Date must not exceed 180 days!")
 ;
 ; check period for conflict with other EAs
 S PRSX=$$CONFLICT^PRSPEAU(PRSIEN,FDT,TDT,DA)
 I PRSX'="" D  Q
 . N PRSTXT
 . S DDSERROR=1
 . D RCON^PRSPEAU(PRSX,0,"PRSTXT")
 . D HLP^DDSUTL(.PRSTXT)
 ;
 Q
 ;
 ;PRSPEAF
