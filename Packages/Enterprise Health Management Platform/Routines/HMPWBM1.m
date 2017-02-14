HMPWBM1 ;ASMR/RRB - Medication Order Writeback ;Jul 02, 2015@10:22:02
 ;;2.0;HEALTH MANAGEMENT PLATFORM;**2**;Oct 10, 2014;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
ORCHECK(HMPOUT,DFN,FID,STRT,ORL,OIL,ORIFN,ORREN) ; Wraps for order checking
 ;             
 ; Input Parameters:
 ;      DFN(R):  Patient IEN
 ;      FID: FILLER ID.  Acquired by passing the selected orderDialogIen from the
 ;           ORWDX WRLST RPC output to the ORWDXC FILLID.
 ;      STRT: Desired Date in Mmm DD,YYYY@HH:SS format
 ;      ORL: Ordering Location (locationIen from the Visit)
 ;      OIL:  An ordered list (array) of orderable Items for Radiology, 
 ;            or orderable items + package info for pharmacy (npatient, outpatient,
 ;            and infusion) and lab as appropriate.
 ;      ORIFN:  orderIen  (This is only available for existing orders that are being copied, changed, or renewed.  New orders do not have an orderIen until they are saved.)
 ;      ORREN: Renewed?  1 = Yes, 0 = No.  Note:  The ORIFN is required if ORREN = 1
 ;
 ;Associated ICRs:
 ;
 ; Wrap for ORWDXC ACCEPT
 ;      Description:  This RPC returns a list of Order Checks on Accept Order.
 ;
 ; Input:  See input parameters for ORCHECK entry point above.
 ;
 ; Output:  Order Checks
 ;          orderIen^orderCheckIen^CDL^message
 ;          orderIen = NEW for new orders.
 ;          CDL = Clinic Danger Level.  If CDL = 1, an override comment will be
 ;                required during processing order checks during the signing process.
 ;
 K ^TMP($T(+0),$J)
 S HMPOUT=$NA(^TMP($T(+0),$J))
 N CNT,OUT,XOUT,XTRA,XTRA1,XTRA2
 ;
 D ACCEPT^ORWDXC(.OUT,.DFN,FID,STRT,ORL,.OIL,ORIFN,ORREN)
 I $G(OUT(1))'="" S OUT(0)="ORCHECK"
 D GETXTRA(.OUT)
 D GETMONO
 ;
 Q
 ;
SESSION ; This is a place holder for future development of session order checks
 ;
 ; I $G(OUT(1))'="" S OUT(0)="SESSION"
 ; D GETXTRA(.OUT)
 ; D GETMONO
 ;
 Q
 ;
GETXTRA(OUT) ; Get extra lines for each order check as required and combine for a single output
 ;
 N CNT
 ; Check each order check for extra lines, and retreive them
 ; using the ORCHECK GETXTRA broker call
 ;
 ; Input Parameters: 
 ;   The inputs for this RPC come from the ORWDXC ACCEPT RPC order check output
 ;   Example:  NEW^25^2^||63679,54957,NEW&These checks could not be completed for this patient:
 ;   Note:  An order check that is returned with the double pipe (||) as noted above is the
 ;   indication that this RPC needs to be run.  Inputs for the RPC are parsed by the ?&?. 
 ;       XTRA1: piece 1
 ;       XTRA2: piece 2
 ;
 ; Output Parameters:  Additional lines of order check text
 ;
 S CNT=""
 F  S CNT=$O(OUT(CNT)) Q:CNT=""  D
 . S XTRA=$P(OUT(CNT),"||",2)
 . I XTRA'="" D
 . . S XTRA1=$P(XTRA,"&",1),XTRA2=$P(XTRA,"&",2)
 . . D GETXTRA^ORCHECK(.XOUT,XTRA1,XTRA2)
 . . M OUT(CNT)=XOUT
 M @HMPOUT@("ORCHK")=OUT
 ;
 Q
 ;
GETMONO ; Get and consolidate monograph data
 ;
 ; This is a place holder for a future story after MOCHA is available for remote checking
 ;
 Q
