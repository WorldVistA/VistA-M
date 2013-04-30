PRCHJS01 ;OI&T/KCL - IFCAP/ECMS INTERFACE TRANSMIT 2237 TO ECMS;6/12/12
 ;;5.1;IFCAP;**167**;Oct 20, 2000;Build 17
 ;Per VHA Directive 2004-38, this routine should not be modified.
 ;
SEND2237(PRC410R,PRCERR) ;Send 2237 to eCMS via HL7 messaging
 ;This function is the primary driver for retrieving and sending
 ;a 2237 transaction to eCMS in single HL7 message (OMN^O07). 
 ;
 ;This function will:
 ; - Retrieve 2237 data elements and place them into a work global
 ; - Perform 2237 pre-validation checks on 2237 data elements
 ; - Build and transmit 2237 data via OMN^O07 message
 ;
 ;  Input:
 ;    PRC410R - (required) IEN of record in CONTROL POINT ACTIVITY (#410) file
 ;
 ;  Output:
 ;   Function value - ien of msg in HLO MESSAGES (#778) file on success, 0 on failure
 ;           PRCERR - (optional) on failure, an error message is returned,
 ;                    pass by ref
 ;
 N PRCWORK ;name of work global containing the 2237 data elements
 N PRCRSLT ;function result
 ;
 ;init temp work global
 S PRCWORK=$NA(^TMP("PRCHJ2237",$J))
 K @PRCWORK
 ;
 S PRCRSLT=0
 ;
 D  ;drops out of DO block on failure
 . ;
 . ;get 2237 data elements and place into work global
 . I '$$GET2237(PRC410R,PRCWORK,.PRCERR) Q
 . ;
 . ;perform 2237 pre-validation checks on 2237 data elements
 . I '$$PRE2237(PRCWORK,.PRCERR) Q
 . ;
 . ;build and transmit 2237 data via OMN^O07 message
 . S PRCRSLT=$$OMNO07^PRCHJS04(PRCWORK,.PRCERR)
 ;
 ;cleanup work global
 K @PRCWORK
 ;
 Q PRCRSLT
 ;
 ;
GET2237(PRC410R,PRCWRK,PRCERR) ;Retrieve 2237 data elements
 ;This function is responsible for retrieving the 2237 data
 ;elements from the IFCAP database that will be transmitted
 ;to eCMS. The 2237 data elements will be placed into a temp
 ;work global.
 ;
 ;  Input:
 ;    PRC410R - (required) IEN of record in CONTROL POINT ACTIVITY (#410) file
 ;     PRCWRK - (required) name of work global used to hold 2237 data elements
 ;                         Ex) S PRCWORK=$NA(^TMP("PRCHJ2237",$J))
 ;
 ;  Output:
 ;   Function value - 1 on success, 0 on failure
 ;           PRCERR - (optional) on failure, an error message is returned,
 ;                    pass by ref
 ;
 N PRCRSLT ;function result
 ;
 S PRCRSLT=0
 ;
 D  ;drops out of DO block on failure
 . ;
 . ;get CONTROL POINT ACTIVITY (#410) data
 . I '$$GET410^PRCHJS02(PRC410R,PRCWRK,.PRCERR) Q
 . ;
 . ;get 2237 line item data
 . I '$$GETITEMS^PRCHJS02(PRC410R,PRCWRK,.PRCERR) Q
 . ;
 . ;get REQUEST WORKSHEET (#443) data
 . I '$$GET443^PRCHJS03($P($G(@PRCWRK@("TRANUM")),U),PRCWRK,.PRCERR) Q
 . ;
 . ;if INVENTORY DISTRIBUTION POINT, then get GENERIC INVENTORY (#445) data
 . I +$G(@PRCWRK@("INVDIS"))>0 D  Q:$G(PRCERR)
 . . I '$$GET445^PRCHJS03(+$G(@PRCWRK@("INVDIS")),PRCWRK,.PRCERR) Q
 . ;
 . ;if VENDOR POINTER, then get VENDOR (#440) data 
 . I +$G(@PRCWRK@("VENDPT"))>0 D  Q:$G(PRCERR)
 . . I '$$GET440^PRCHJS03(+$G(@PRCWRK@("VENDPT")),PRCWRK,.PRCERR) Q
 . ;
 . ;success
 . S PRCRSLT=1
 ;
 Q PRCRSLT
 ;
 ;
PRE2237(PRCWRK,PRCER) ;Pre-validate 2237 data elements
 ;This function performs pre-validation checks on specified
 ;2237 data elements being transmitted to eCMS.
 ;
 ;  Input:
 ;    PRCWRK - (required) name of work global containing 2237 data elements
 ;
 ; Output:
 ;   Function value - returns 1 if all validation checks passed, 0 otherwise
 ;            PRCER - (optional) on failure, an error message is returned,
 ;                    pass by ref
 ;
 N PRCSUB   ;array subscript
 N PRCLINE  ;array subscript for items
 N PRCITEML ;Line Item #
 N PRCNUM   ;array subscript for item description
 N PRCRSLT  ;function result
 ;
 S PRCRSLT=0
 S PRCER=""
 ;
 D  ;drops out of block if invalid condition found
 . ;
 . ;make sure this is a 2237
 . I ($P($G(@PRCWRK@("FRMTYP")),U)<2)!($P($G(@PRCWRK@("FRMTYP")),U)>4) D
 . . S PRCER="This is not a 2237 transaction"
 . Q:$G(PRCER)'=""
 . ;
 . ;check for null field values (eCMS required fields)
 . F PRCSUB="TRANUM","STANUM","RQSTDT","REQ","DTREQ","APOF","RQSRV","CTRLPT","COMMIT","ACTDATA" D  Q:PRCER'=""
 . . I $P($G(@PRCWRK@(PRCSUB)),U)="" S PRCER="Field "_$$GET1^DID(410,$$FIELD(PRCSUB),"","LABEL")_" is missing"
 . Q:$G(PRCER)'=""
 . ;
 . ;loop thru Line Items and check for null field values (eCMS required fields)
 . S PRCLINE=0
 . F  S PRCLINE=$O(@PRCWRK@(PRCLINE)) Q:'PRCLINE  D  Q:PRCER'=""
 . . ;
 . . S PRCITEML=+$G(@PRCWRK@(PRCLINE,"ITLINE")) ;line item #
 . . ;
 . . F PRCSUB="ITLINE","ITQTY","ITUOP","ITBOC","ITCOST" D  Q:PRCER'=""
 . . . I $P($G(@PRCWRK@(PRCLINE,PRCSUB)),U)="" S PRCER="Line Item #"_PRCITEML_" field "_$$GET1^DID(410.02,$$FIELD(PRCSUB),"","LABEL")_" is missing"
 . . Q:$G(PRCER)'=""
 . . ;
 . . S PRCNUM=$O(@PRCWRK@(PRCLINE,"ITDESC",0))
 . . I $G(@PRCWRK@(PRCLINE,"ITDESC",PRCNUM,0))="" S PRCER="Line Item #"_PRCITEML_" field "_$$GET1^DID(410.02,$$FIELD("ITDESC"),"","LABEL")_" is missing"
 . Q:$G(PRCER)'=""
 . ;
 . ;success
 . S PRCRSLT=1
 ;
 Q PRCRSLT
 ;
 ;
FIELD(PRCSUB) ;Return field number for subscript
 ;This function takes a given subscript in the 2237 work
 ;global and returns the corresponding field number.
 ;
 ;  Input:
 ;   PRCSUB - (required) subscript of 2237 work global
 ;
 ; Output:
 ;   Function value - returns corresponding field number for subscript,
 ;                    null otherwise
 ;
 N PRCFLD ;function result
 S PRCFLD=""
 ;
 D  ;drops out of DO block once field # is determined
 . ;
 . ;CONTROL POINT ACTIVITY (#410) fields
 . I PRCSUB="TRANUM" S PRCFLD=.01 Q
 . I PRCSUB="STANUM" S PRCFLD=.5 Q
 . I PRCSUB="RQSTDT" S PRCFLD=5 Q
 . I PRCSUB="REQ" S PRCFLD=40 Q
 . I PRCSUB="DTREQ" S PRCFLD=7 Q
 . I PRCSUB="APOF" S PRCFLD=42 Q
 . I PRCSUB="RQSRV" S PRCFLD=6.3 Q
 . I PRCSUB="CTRLPT" S PRCFLD=15 Q
 . I PRCSUB="COMMIT" S PRCFLD=20 Q
 . I PRCSUB="ACTDATA" S PRCFLD=28 Q
 . ;
 . ;ITEM (#410.02) multiple fields
 . I PRCSUB="ITLINE" S PRCFLD=.01 Q
 . I PRCSUB="ITDESC" S PRCFLD=1 Q
 . I PRCSUB="ITQTY" S PRCFLD=2 Q
 . I PRCSUB="ITUOP" S PRCFLD=3 Q
 . I PRCSUB="ITBOC" S PRCFLD=4 Q
 . I PRCSUB="ITCOST" S PRCFLD=7 Q
 ;
 Q PRCFLD
