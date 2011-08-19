DGMSTL2 ;ALB/SCK - MST LISTMANAGER UTILITIES CONT. ; 12/17/98
 ;;5.3;Registration;**195**;Aug 13, 1993
 Q
 ;
ASKDATE(MSTDT,MSTOLDDT) ;  Return status change date
 ;  Future dates will not be allowed
 ;
 ;  Input
 ;     MSTDT    - Date to be used as default [optional] Default is NOW
 ;     MSTOLDDT - Date to be used as the minimum allowed entry date
 ;                [optional]  Default is null
 ;                Both dates must be in FM date format is passed in.
 ;
 ;  Output
 ;     DGRSLT has the following values:
 ;         0 - if user up-arrows, times out, or enters null
 ;         Y - date in FM date format
 ;
 N DGRSLT,Y
 ;
 K DIRUT
 S MSTDT=$G(MSTDT)
 S MSTOLDDT=$G(MSTOLDDT)
 S DIR(0)="DAO^"_$S(MSTOLDDT>0:MSTOLDDT,1:"")_":NOW:ERXP"
 S DIR("B")=$S(MSTDT>0:$$FMTE^XLFDT(MSTDT),1:"NOW")
 S DIR("A")="Enter date of status change: "
 D ^DIR K DIR
 I $D(DIRUT) S DGRSLT=0
 E  S DGRSLT=Y
 ;
 Q $G(DGRSLT)
 ;
ASKPROV(MSTPV) ;  Ask for Provider
 ; Input
 ;      MSTPV  -  IEN of default provider [optional]
 ;
 ; Returns
 ;      DGRSLT
 ;          0  - if user up-arrows, times out, or enters null
 ;         +Y  - IEN of selected provider
 ;
 N DGRSLT
 ;
 K DIRUT
 S MSTPV=$G(MSTPV)
 S DIR(0)="29.11,4AO"
 S DIR("B")=$S(MSTPV>0:$$NAME^DGMSTAPI(MSTPV),1:"")
 S DIR("A")="Provider determining  status: "
 D ^DIR K DIR
 I $D(DIRUT) S DGRSLT=0
 E  S DGRSLT=+Y
 ;
 Q $G(DGRSLT)
 ;
ADDSTR(DFN,MSTST,MSTDT,MSTPR,MSTIEN) ;  Build the formatted display string for the List Manager display
 ;   Input
 ;       DFN   -  IEN of patient in the PATIENT File (#2)
 ;       MSTST -  Status code for the MST status
 ;       MSTDT -  Date of the status change in FM internal format
 ;       MSTPR -  IEN of provider in the NEW USER File (#200)
 ;       MSTIEN-  IEN of new entry in the MST HISTORY File (#29.11)
 ;
 ;; Check for empty list.  If list is empty, clear message and reset LM variables.
 N DGX
 I $D(^TMP("DGMST",$J,"INIT"))>0 D
 . K ^TMP("DGMST",$J)
 . D CLEAN^VALM10
 . S (VALMCNT,MSTCNT)=0
 ;
 N VADM,VA
 D DEM^VADPT,PID^VADPT
 S MSTCNT=$G(MSTCNT)+1
 S DGX=$$SETFLD^VALM1(MSTCNT,"","MST#")
 S DGX=$$SETFLD^VALM1(VA("BID"),DGX,"SSN")
 S DGX=$$SETFLD^VALM1(VADM(1),DGX,"PATIENT")
 S DGX=$$SETFLD^VALM1(MSTST,DGX,"STATUS")
 S DGX=$$SETFLD^VALM1($$FMTE^XLFDT(MSTDT),DGX,"DATE")
 S DGX=$$SETFLD^VALM1($S(MSTPR>0:$$NAME^DGMSTAPI(MSTPR),1:""),DGX,"PROVIDER")
 D SET(DGX,MSTCNT,DFN,MSTIEN)
 S ^TMP("DGMST",$J,0)=MSTCNT
 D KVA^VADPT
 Q
 ;
SET(X,IDX,DFN,MSTIEN) ;  Set the formatted display string into the List Manager global
 ; Build the DFN and IDX indexes
 ;  Input
 ;    X   - formated display string
 ;    IDX - Index number
 ;    DFN - IEN of patient in the PATIENT File (#2)
 ;
 S VALMCNT=$G(VALMCNT)+1,^TMP("DGMST",$J,VALMCNT,0)=X
 S ^TMP("DGMST",$J,"IDX",VALMCNT,IDX)=""
 S ^TMP("DGMST",$J,"DFN",VALMCNT,DFN)=""
 S ^TMP("DGMST",$J,"IEN",VALMCNT,MSTIEN)=""
 Q
 ;
EXTMST(MSTST) ; convert MST status code to external dislay format
 Q $S(MSTST["Y":"Yes, Screened reports MST",MSTST["N":"No, Screened does not report MST",MSTST["D":"Screened Declines to answer",1:"Unknown, not screened")
 ;
NUL ; Check for empty list.  If empty display message and force page number
 I '$O(^TMP("DGMST",$J,0)) D SET^DGMSTL("    No Entries")
 Q
 ;
CHKNUL() ; Checks of an "empty" list to lock out protocols.
 N DGRSLT
 S DGRSLT=0
 I VALMCNT>0,^TMP("DGMST",$J,1,0)["No Entries" D
 . S DIR(0)="FAO"
 . S DIR("A",1)="Action not allowed at this point."
 . S (DIR("A"),DIR("?"),DIR("??"))="Press any key to continue..."
 . D ^DIR K DIR
 . S DGRSLT=1
 Q $G(DGRSLT)
