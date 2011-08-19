IBCICME1 ;DSI/ESG - IBCI CLAIMSMANAGER ERROR REPORT <CONT> ;6-APR-2001
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
BUILD ; Build the scratch global based on the selection and sort criteria
 ;
 NEW REF,MNEMONIC,RDT,IBIFN,CMDATA,IBDATA,CMSTATUS,BILLID,PATDATA
 NEW NAME,SSN,BILLER,CODER,OIFLG,ASSIGNED,CHARGES,ERR,ERRCODES
 NEW SORT1,SORT2,SORT3,SORT4,SORT5,RPTDATA,ERRIEN,LINENO
 NEW COUNT,BILCOUNT,ERRCOUNT,INSNAME
 ;
 KILL ^TMP($J,IBCIRTN),^TMP($J,IBCIRTN_"-LIST-OF-BILLS")
 KILL ^TMP($J,IBCIRTN_"-TOTALS")
 ;
 ; which array are we looping through?  Find out here.
 S REF="RPTSPECS(""SELECTED ERRCODES"")"
 I RPTSPECS("ALL ERRCODES") S REF="^IBA(351.9,""AEC"")"
 ;
 S MNEMONIC="",(COUNT,BILCOUNT,ERRCOUNT)=0
 F  S MNEMONIC=$O(@REF@(MNEMONIC)) Q:MNEMONIC=""!$G(ZTSTOP)  D
 . S IBIFN=0
 . F  S IBIFN=$O(^IBA(351.9,"AEC",MNEMONIC,IBIFN)) Q:'IBIFN!$G(ZTSTOP)  D
 .. S COUNT=COUNT+1
 .. I $D(ZTQUEUED),COUNT#100=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 .. S CMDATA=$G(^IBA(351.9,IBIFN,0))
 .. I CMDATA="" Q
 .. S IBDATA=$G(^DGCR(399,IBIFN,0))
 .. I IBDATA="" Q
 .. ;
 .. ; Get the date that the user selected and check it
 .. S RDT=9999999
 .. I RPTSPECS("DATYP")=1 S RDT=$P($P(IBDATA,U,3),".",1)
 .. I RPTSPECS("DATYP")=2 S RDT=$P($P($G(^DGCR(399,IBIFN,"S")),U,1),".",1)
 .. I RDT<RPTSPECS("BEGDATE") Q   ; date too early
 .. I RDT>RPTSPECS("ENDDATE") Q   ; date too late
 .. ;
 .. ; If the user chose a specific ClaimsManager status to report
 .. ; on, then make sure this bill has the status they want.
 .. S CMSTATUS=$P(CMDATA,U,2)
 .. I RPTSPECS("STATYP")=2,CMSTATUS'=RPTSPECS("IBCISTAT") Q
 .. ;
 .. ; If the user wants to see bills that are still open for editing
 .. I RPTSPECS("STATYP")=3,'$F(".1.","."_$P(IBDATA,U,13)_".") Q  ;DSI/DJW 3/21/02
 .. ;
 .. ; If the user wants to include a specific assigned to person,
 .. ; then make sure the assigned to person is the one they want.
 .. I RPTSPECS("ASNDUZ"),RPTSPECS("ASNDUZ")'=$P(CMDATA,U,12) Q
 .. ;
 .. ; At this point, we know we want to include this bill.
 .. D GETDATA
 .. I '$D(^TMP($J,IBCIRTN_"-LIST-OF-BILLS",IBIFN)) S ^TMP($J,IBCIRTN_"-LIST-OF-BILLS",IBIFN)="",BILCOUNT=BILCOUNT+1
 .. ;
 .. ; esg - 6/12/01
 .. ; Determine what the value of SORT2 should be based on the user's
 .. ; response to the Error Display Type question.
 .. ;
 .. I RPTSPECS("ERROR DISPLAY TYPE")=2 S SORT2=" "_MNEMONIC
 .. S ^TMP($J,IBCIRTN,SORT1,SORT2,SORT3,SORT4,SORT5,NAME,IBIFN)=RPTDATA
 .. ;
 .. ; continue looping to get the error level data and the totals
 .. S ERRIEN=0
 .. F  S ERRIEN=$O(^IBA(351.9,"AEC",MNEMONIC,IBIFN,ERRIEN)) Q:'ERRIEN  D
 ... S ERRCOUNT=ERRCOUNT+1
 ... S LINENO=$G(^IBA(351.9,IBIFN,1,ERRIEN,0))
 ... S LINENO=$P($P(LINENO,U,2),"~",1)
 ... S ^TMP($J,IBCIRTN,SORT1,SORT2,SORT3,SORT4,SORT5,NAME,IBIFN,ERRIEN)=LINENO_U_MNEMONIC
 ... S ^TMP($J,IBCIRTN_"-TOTALS",MNEMONIC)=$G(^TMP($J,IBCIRTN_"-TOTALS",MNEMONIC))+1
 ... Q
 .. Q
 . Q
 S ^TMP($J,IBCIRTN_"-TOTALS")=BILCOUNT_U_ERRCOUNT
 KILL ^TMP($J,IBCIRTN_"-LIST-OF-BILLS")
 ;
BUILDX ;
 Q
 ;
 ;
GETDATA ; Retrieve the data for this bill
 S BILLID=$P(IBDATA,U,1)                              ; bill number
 S PATDATA=$G(^DPT(+$P(IBDATA,U,2),0))
 I PATDATA="" Q
 S NAME=$P(PATDATA,U,1)                               ; patient name
 I NAME="" S NAME="UNKNOWN"
 S NAMESUB=$E(NAME,1,15)_+$P(IBDATA,U,2)              ; name subscript
 S SSN=$P(PATDATA,U,9)                                ; patient ssn
 S BILLER=$P($$BILLER^IBCIUT5(IBIFN),U,2)
 I BILLER="" S BILLER="UNKNOWN"
 S CODER=$$CODER^IBCIUT5(IBIFN)
 S OIFLG=$P(CODER,U,1)               ; inpatient/outpatient flag
 S CODER=$P(CODER,U,3)
 I CODER="" S CODER="UNKNOWN"
 S ASSIGNED=$P($G(^VA(200,+$P(CMDATA,U,12),0)),U,1)   ; assigned to
 I ASSIGNED="" S ASSIGNED="UNASSIGNED"
 S ASNSUB=$E(ASSIGNED,1,12)_+$P(CMDATA,U,12)     ; assigned to subscript
 S CHARGES=+$P($G(^DGCR(399,IBIFN,"U1")),U,1)         ; total charges
 S (ERR,ERRCODES)=""
 F  S ERR=$O(^IBA(351.9,IBIFN,1,"B",ERR)) Q:ERR=""  D
 . I ERRCODES="" S ERRCODES=ERR
 . E  S ERRCODES=ERRCODES_","_ERR    ; build the list of error codes
 . Q
 ;
 ; set the sort variables and build the scratch global
 S (SORT1,SORT2,SORT3,SORT4,SORT5)=1
 I RPTSPECS("ASNSORT") S SORT3=" "_ASNSUB
 I RPTSPECS("SORTBY")=1 S SORT4=" "_$P($$TD^IBCIUT5(IBIFN),U,1)
 I RPTSPECS("SORTBY")=2 D
 . S INSNAME=$P($G(^DIC(36,+$$FINDINS^IBCEF1(IBIFN),0)),U,1)
 . I INSNAME="" S INSNAME="~~~ NO INSURANCE ~~~"
 . S SORT4=" "_$E(INSNAME,1,25)
 . Q
 I RPTSPECS("SORTBY")=3 S SORT4=" "_NAMESUB
 I RPTSPECS("SORTBY")=4 S SORT4=-CHARGES
 I RPTSPECS("SORTBY")=5 S SORT4=" "_BILLID
 ;
 S RPTDATA=BILLID_U_SSN_U_$P(RDT,".",1)_U_BILLER_U_CODER_U_ASSIGNED_U_OIFLG_U_CHARGES_U_CMSTATUS_U_ERRCODES
 ;
 ; Build an array with the total number of bills in each status
 ; This array will be used in the report print routines and it is
 ; available in both the status report and the error report.
 ; esg - 5/22/01
 ;
 ; bill count by status
 S IBCISCNT(1,CMSTATUS)=$G(IBCISCNT(1,CMSTATUS))+1
 S IBCISCNT(1)=$G(IBCISCNT(1))+1
 ;
 ; charges by status
 S IBCISCNT(2,CMSTATUS)=$G(IBCISCNT(2,CMSTATUS))+CHARGES
 S IBCISCNT(2)=$G(IBCISCNT(2))+CHARGES
 ;
GETDATX ;
 Q
 ;
