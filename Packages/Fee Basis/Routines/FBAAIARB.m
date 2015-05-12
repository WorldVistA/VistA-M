FBAAIARB ;ALB/ESG - FEE IPAC Vendor Payment Report (Detail) ;2/4/2014
 ;;3.5;FEE BASIS;**123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ; main report entry point
 ;
 N FBIAVEN,FBIABEG,FBIAEND,FBIATYPE,FBIAEXCEL,FBIAADJ,FBIAIGNORE
P1 I '$$VENDSEL(.FBIAVEN) G EX                         ; vendor
P2 I '$$DATES(.FBIABEG,.FBIAEND) G EX:$$STOP,P1        ; begin and end dates
P3 I '$$TYPESEL(.FBIATYPE) G EX:$$STOP,P2              ; type of invoice
P4 I '$$SUSPADJ(.FBIAADJ) G EX:$$STOP,P3               ; only include suspended/adjusted payments?
P5 I '$$IGNCV(.FBIAIGNORE) G EX:$$STOP,P4              ; ignore cancelled/voided payment lines?
P6 I '$$FORMAT(.FBIAEXCEL) G EX:$$STOP,P5              ; format (standard or CSV)
P7 I '$$DEVICE() G EX:$$STOP,P6                        ; device
 ;
EX ; main report exit point
 Q
 ;
STOP() ; Determine if user wants to exit out of the option entirely
 ; 1=yes, get out entirely
 ; 0=no, just go back to the previous question
 ;
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 ;
 S DIR(0)="Y"
 S DIR("A")="Do you want to exit out of this option entirely"
 S DIR("B")="YES"
 S DIR("?",1)="  Enter YES to immediately exit out of this option."
 S DIR("?")="  Enter NO to return to the previous question."
 W ! D ^DIR K DIR
 I $D(DIRUT) S Y=1
 Q Y
 ;
VENDSEL(FBIAVEN) ; user selection function for IPAC vendors
 ; FBIAVEN is an output array, pass by reference
 ; FBIAVEN(vendor ien) = vendor name selected
 ; Function value is 1 if at least 1 vendor was selected, 0 otherwise
 ;
 N DIC,RET,VAUTSTR,VAUTNI,VAUTVB,V,X,Y
 K FBIAVEN
 S RET=1    ; default to 1 indicating all OK
 ;
 W @IOF,!,"IPAC Vendor Payment Report"
 W !!,"This report will display detail information on paid line items by the"
 W !,"invoice type, DoD invoice number, and date of service."
 W !
 ;
 S DIC="^FBAAV("
 S DIC("S")="I +$O(^FBAA(161.95,""V"",Y,0))"
 S VAUTSTR="IPAC Vendor",VAUTNI=2,VAUTVB="FBIAVEN"
 D FIRST^VAUTOMA     ; DBIA# 4398
 I FBIAVEN S V=0 F  S V=$O(^FBAA(161.95,"V",V)) Q:'V  S FBIAVEN(V)=$P($G(^FBAAV(V,0)),U,1)   ; all IPAC vendors selected
 I '$O(FBIAVEN(0)) S RET=0 W $C(7)        ; no vendors found/selected
 Q RET
 ;
DATES(FBIABEG,FBIAEND) ; capture the start date and end date from the user
 ; both are output parameters, pass by reference
 ; function value is 0/1 indicating if valid dates were selected
 ;
 N RET,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S RET=1
 S (FBIABEG,FBIAEND)=""
 ;
 S DIR(0)="D^:DT:EX"
 S DIR("A")="Enter the Start Date"
 S DIR("B")=$$FMTE^XLFDT($$FMADD^XLFDT(DT,-30),"5DZ")   ; default date is T-30
 S DIR("?",1)="The start and end dates for this report refer to the date that the"
 S DIR("?",2)="associated batch and payment line items are finalized (certified)"
 S DIR("?")="in VistA Fee through the ""Finalize a Batch"" menu option."
 W ! D ^DIR K DIR
 I $D(DIRUT)!'Y S RET=0 W $C(7) G DATEX
 S FBIABEG=Y
 ;
 S DIR(0)="D^"_FBIABEG_":DT:EX"
 S DIR("A")="Enter the End Date"
 S DIR("B")=$$FMTE^XLFDT(DT,"5DZ")   ; default date is Today
 S DIR("?",1)="The start and end dates for this report refer to the date that the"
 S DIR("?",2)="associated batch and payment line items are finalized (certified)"
 S DIR("?")="in VistA Fee through the ""Finalize a Batch"" menu option."
 W ! D ^DIR K DIR
 I $D(DIRUT)!'Y S RET=0 W $C(7) G DATEX
 S FBIAEND=Y
DATEX ;
 Q RET
 ;
TYPESEL(FBIATYPE) ; function for user selection of the types of invoices to search
 ; FBIATYPE is an output array, pass by reference
 ; FBIATYPE(type)="" where type can be OUT,RX,INP,ANC
 ; Function value is 1 if at least 1 invoice type was selected, 0 otherwise
 ;
 N RET,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,FD,G
 K FBIATYPE
 S RET=1    ; default to 1 indicating all OK
 ;
 F  D  Q:Y="ALL"!$D(DIRUT)!(Y="")
 . S DIR(0)="SO"
 . S FD="OUT:"_$$LJ^XLFSTR("Outpatient",27)_$S($D(FBIATYPE("OUT")):"SELECTED",1:"")
 . S FD=FD_";RX:"_$$LJ^XLFSTR("Pharmacy",27)_$S($D(FBIATYPE("RX")):"SELECTED",1:"")
 . S FD=FD_";INP:"_$$LJ^XLFSTR("Civil Hospital",27)_$S($D(FBIATYPE("INP")):"SELECTED",1:"")
 . S FD=FD_";ANC:"_$$LJ^XLFSTR("Civil Hospital Ancillary",27)_$S($D(FBIATYPE("ANC")):"SELECTED",1:"")
 . S FD=FD_";ALL:All"
 . S $P(DIR(0),U,2)=FD
 . ;
 . I '$D(FBIATYPE) S DIR("A")="Select an Invoice Type",DIR("B")="ALL"
 . E  S DIR("A")="Select Another Invoice Type" K DIR("B")
 . W ! D ^DIR K DIR
 . ;
 . I Y="ALL" D  Q     ; user selected all types, so set them and get out
 .. F G="OUT","RX","INP","ANC" S FBIATYPE(G)=""
 . ;
 . I $D(DIRUT)!(Y="") Q
 . I $D(FBIATYPE(Y)) K FBIATYPE(Y) Q     ; if already selected, toggle the selection off then quit
 . S FBIATYPE(Y)=""                      ; toggle selection on
 . Q
 ;
 I $D(DUOUT)!$D(DTOUT) S RET=0           ; exit via up-arrow or time-out should get out
 I '$D(FBIATYPE) S RET=0 W $C(7)
 Q RET
 ;
SUSPADJ(FBIAADJ) ; capture only suspended payments?
 ; FBIAADJ=0 meaning NO user wants to include all payment lines
 ; FBIAADJ=1 meaning YES only include payments where Amount Paid is less than Amount Claimed
 ; pass parameter by reference
 ;
 N RET,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S FBIAADJ=0,RET=1
 S DIR(0)="Y"
 S DIR("A")="Only Include Suspended Payments (not paid in full)"
 S DIR("B")="NO"
 S DIR("?",1)="Enter NO if you want to include all payment lines regardless of amount"
 S DIR("?",2)="claimed, paid, or suspended/adjusted."
 S DIR("?",3)=" "
 S DIR("?",4)="Enter YES if you only want to include payments that are not paid in full."
 S DIR("?",5)="This means that the amount the VA paid is less than the vendor's claimed"
 S DIR("?")="amount. The remaining balance has been suspended or adjusted."
 W ! D ^DIR K DIR
 I $D(DIRUT) S RET=0 W $C(7)
 S FBIAADJ=Y
 Q RET
 ;
FORMAT(FBIAEXCEL) ; capture the report format from the user (normal or CSV output)
 ; FBIAEXCEL=0 for normal output
 ; FBIAEXCEL=1 for CSV (comma separated values) for Excel output
 ; pass parameter by reference
 ;
 N RET,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S FBIAEXCEL=0,RET=1
 S DIR(0)="Y"
 S DIR("A")="Do you want to capture the output in a CSV format"
 S DIR("B")="NO"
 S DIR("?",1)="If you want to capture the output from this report in a comma-separated"
 S DIR("?",2)="values (CSV) format, then answer YES here.  A CSV format is something that"
 S DIR("?",3)="could be easily imported into a spreadsheet program like Excel."
 S DIR("?",4)=" "
 S DIR("?")="If you just want a normal report output, then answer NO here."
 W ! D ^DIR K DIR
 I $D(DIRUT) S RET=0 W $C(7)
 S FBIAEXCEL=Y
 Q RET
 ;
IGNCV(FBIAIGNORE) ; should we ignore cancelled, voided, or rejected line items?
 ; FBIAIGNORE=0 means don't ignore, include everything
 ; FBIAIGNORE=1 means yes ignore cancelled/voided/rejected line items
 ; pass parameter by reference
 ;
 N RET,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S FBIAIGNORE=1,RET=1
 S DIR(0)="Y"
 S DIR("A")="Ignore Cancelled or Voided Payments"
 S DIR("B")="YES"
 S DIR("?",1)="Enter YES if you want to ignore any payment line items that have been"
 S DIR("?",2)="cancelled, voided, or rejected so these items will not show up on the report."
 S DIR("?",3)=" "
 S DIR("?",4)="Enter NO if you would like to include cancelled, voided, or rejected line"
 S DIR("?",5)="items so they will show up on the report. For such payment line items, an"
 S DIR("?")="indicator will be displayed on the report."
 W ! D ^DIR K DIR
 I $D(DIRUT) S RET=0 W $C(7)
 S FBIAIGNORE=Y
 Q RET
 ;
DEVICE() ; Device Selection
 N ZTRTN,ZTDESC,ZTSAVE,POP,RET,ZTSK,DIR,X,Y
 S RET=1
 I 'FBIAEXCEL W !!,"This report is 132 characters wide.  Please choose an appropriate device.",!
 I FBIAEXCEL D
 . W !!,"For CSV output, turn logging or capture on now."
 . W !,"To avoid undesired wrapping of the data saved to the file,"
 . W !,"please enter ""0;256;99999"" at the ""DEVICE:"" prompt.",!
 ;
 S ZTRTN="COMPILE^FBAAIARC"
 S ZTDESC="Fee Basis IPAC Vendor Payment Report"
 S ZTSAVE("FBIAVEN(")=""
 S ZTSAVE("FBIABEG")=""
 S ZTSAVE("FBIAEND")=""
 S ZTSAVE("FBIATYPE(")=""
 S ZTSAVE("FBIAADJ")=""
 S ZTSAVE("FBIAEXCEL")=""
 S ZTSAVE("FBIAIGNORE")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1)
 I POP S RET=0
 I $G(ZTSK) W !!,"Report compilation has started with task# ",ZTSK,".",! S DIR(0)="E" D ^DIR
 Q RET
 ;
