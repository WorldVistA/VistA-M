IBCNBLL1 ;AITC/CKB - Ins Buffer: LM main screen, list buffer entries continued ;19-MAY-2025
 ;;2.0;INTEGRATED BILLING;**822**;21-MAR-94;Build 21
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
HDR ;  header code for list manager display  - IB*822/CKB - called from HDR^IBCNBLL
 S VALMHDR(1)="Sorted by: "_$P(IBCNSORT,U,2)
 I $P(IBCNSORT,U,3)'="" S VALMHDR(1)=VALMHDR(1)_", """_$P(IBCNSORT,U,3)_""" first"
 ; IB*2.0*737/DTG remove '* verified' reference from VALMSG,
 ;   impacts views 1-3 and 5
 I VIEW=1 S VALM("TITLE")="Positive Insurance Buffer",VALMSG="+Active" ;IB*2*506/taz & IB*737 Active policies only
 I VIEW=2 S VALM("TITLE")="Negative Insurance Buffer",VALMSG="-N/Active"  ;IB*2*506/taz & IB*737 Inactive policies only
 I VIEW=3 S VALM("TITLE")="Medicare(WNR) Insurance Buffer",VALMSG="+Act -N/Act ?Await/R #Unclr !Unable/Send"  ; IB737 removed *Verified
 I VIEW=4 S VALM("TITLE")="Failure Buffer",VALMSG="!Unable/Send"  ;IB*2*506/taz changed
 ;IB*2*822/CKB - removed '-' and added VALMSG
 I VIEW=5 S VALM("TITLE")="ePharmacy Buffer",VALMSG="a Approved  r Rejected  !Unable/Send"  ; IB*2*435 & IB*737 dropped "*Verified"
 I VIEW=6 S VALM("TITLE")="Complete Buffer",VALMSG=""     ; IB*2*506/taz added
 I VIEW=7 S VALM("TITLE")="TRICARE/CHAMPVA",VALMSG=""   ;528/baa added
 Q
 ;
HELP ;  list manager help - IB*822/CKB - called from HELP^IBCNBLL
 D FULL^VALM1
 S VALMBCK="R"
 W @IOF
 W !,"Flags displayed on screen if they apply to the Buffer entry:"
 W !,"   i - Patient has other currently effective Insurance"
 W !,"   I - Patient is currently admitted as an Inpatient"
 W !,"   E - Patient has Expired"
 W !,"   Y - Means Test Copay Patient"
 W !,"   H - Patient has Bills On Hold"
 W !,"   P - Patient has potential new policy"  ; IB*806/DTG new flag
 ; W !,"   * - Buffer entry Verified by User"  ; IB*2.0*737 removed
 W !
 D PAUSE^VALM1 I 'Y Q
 W !,"Sources displayed on the screen if they apply to the Buffer entry:"
 W !,"   I - Interview"
 W !,"   D - Data Match"
 W !,"   V - IVM"
 W !,"   P - Pre-Registration"
 W !,"   E - eIV"
 W !,"   H - HMS"
 W !,"   M - Medicare"
 W !,"   R - ICB Card Reader"
 W !,"   C - Contract Services"
 W !,"   X - ePharmacy"                      ;IB*2*822/CKB - removed '-' ; IB*2*435
 ; IB*2*595/DM K,T,U,B,O,N,S,A,J added
 W !,"   K - Kiosk"
 W !,"   F - Interfacility Insurance Update" ; IB*2*528
 W !,"   T - Insurance Import"
 ; IB*2.0*631/VD - Changed U from Purchased Care Choice to Community Care Network
 W !,"   U - Community Care Network"
 W !,"   B - Purchased Care Fee-Basis"
 W !,"   O - Purchased Care Other"
 W !,"   N - Insurance Intake"
 W !,"   S - Insurance Verification"
 W !,"   A - Veteran Appt Request"
 W !,"   J - MYVA Health Journal"
 ;/vd - IB*2*664 - Added "W" for Electronic Health Record
 W !,"   W - Electronic Health Record"
 W !,"   G - Adv Med Cost Mgmt Solution" ;IB*668/DW Added
 D PAUSE^VALM1 I 'Y Q
 ;
 I VIEW'=5 D     ; IB*2*435
 . W !,"eIV Electronic Insurance Verification Status"
 . W !!,"The following eIV Status indicators may appear to the left of the patient name:",!
 . Q
 ;
 I VIEW=1 D
 . W !,"      + - eIV payer response indicates this is an active policy."
 . W !,"      $ - Escalated active policy."
 . ; W !,"      * - Previously an active policy."  ; IB*2.0*737 removed
 . Q
 I VIEW=2 D
 . W !,"      - - eIV payer response indicates this is NOT an active policy."
 . ; W !,"      * - Previously an not active policy."  ; IB*2.0*737 removed
 . Q
 I $F(",3,6,7,",VIEW) D   ;528/baa
 . W !,"      + - eIV payer response indicates this is an active policy."
 . W !,"      ? - Awaiting electronic reply from eIV Payer."
 . W !,"      $ - Escalated Active policy."
 . ; W !,"      * - Previously either an active or not active policy."  ; IB*2.0*737 removed
 . W !,"      # - Can not determine from eIV response if coverage is Active."
 . W !,"          Review Response Report. Manual verification required."
 . W !,"      ! - eIV was unable to send an inquiry for this entry."
 . W !,"          Corrections required OR payer not Active."            ;IB*2*822/CKB - capitalized 'or'
 . W !,"      - - eIV payer response indicates this is NOT an active policy."
 . W !,"      % - CMS responded with the patient's new MBI value."
 . ;IB*2*822/CKB - added 'a' and 'r'
 . W !,"      a - ePharmacy E1 transaction status is Approved."
 . W !,"      r - ePharmacy E1 transaction status is Rejected."
 . W !,"<Blank> - Entry added through manual process."
 . Q
 I VIEW=4 D
 . W !,"      ! - eIV was unable to send an inquiry for this entry."
 . W !,"          Corrections required OR payer not Active."           ;IB*2*822/CKB - capitalized 'or'
 . Q
 ;
 I VIEW=5 D      ;IB*822/CKB - modified the ePharmacy Buffer help text for E1 transactions
 . ; IB*2*435 ;W !,"      e-Pharmacy buffer entries are not applicable for e-IV processing."
 . W !,"eIV Electronic Insurance Verification Status",!
 . W !,"The following eIV Status indicators may appear to the left of the patient name:"
 . W !,"      ! - eIV was unable to send an inquiry for this entry."
 . W !,"          Corrections required OR payer not Active."
 . W !,"      a - ePharmacy E1 transaction status is Approved."
 . W !,"      r - ePharmacy E1 transaction status is Rejected."
 . W !,"<Blank> - Entry added through manual process."
 . Q
 ;
 D PAUSE^VALM1 I 'Y Q
 W !,"When an entry is Processed it is either:"
 W !,"   Accepted - the Buffer entry's data is stored in the main Insurance files."
 W !,"            - the modified Insurance entry is flagged as Verified."
 W !
 W !,"   Rejected - the Buffer entry's data is not stored in the main Insurance files."
 W !!
 W !,"Once an entry is processed (either accepted or rejected) most of the data in"
 W !,"the Buffer File entry is deleted leaving only a stub entry for tracking"
 W !,"and reporting purposes."
 W !!
 W !,"The IB INSURANCE SUPERVISOR key is required to either Accept or Reject an entry."
 D PAUSE^VALM1
 Q
