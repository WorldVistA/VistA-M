RCTCSJS0 ;ALBANY/RGB - CROSS-SERVICING REJECTS SERVER;02/19/14 3:21 PM
V ;;4.5;Accounts Receivable;**343**;Mar 20, 1995;Build 59
 ;;Per VA Directive 6402, this routine should not be modified.
 ;Program to process CS REJECT server messages from AITC
 ;
 ;===================================================================
 ; 
SERVER ; entry from outside
 D INIT1
 S:'$L(XMZ1) XMZ1=$S($L(XMZ2):XMZ2,1:" ")
 S:'$L(XMZ2) XMZ2=$S($L(XMZ1):XMZ1,1:" ")
 I '$G(XMZ1)!'$G(XMZ2) D  G END
 . D RECERR(.ERRCNT,"Inv MM MSG","Invalid MM Msg# '"_$G(XMZ1)_"'"_$S(XMZ2'=XMZ1:" to '"_XMZ2_"'",1:""),0,.RECERR)
 I '$D(^XMB(3.9,XMZ1))!'$D(^XMB(3.9,XMZ2)) D  G END
 . D RECERR(.ERRCNT,"Inv MM MSG","Invalid MM Msg# '"_$G(XMZ1)_"'"_$S(XMZ2'=XMZ1:" to '"_XMZ2_"'",1:""),0,.RECERR)
 ;
 K LIST F XMZ=XMZ1:1:XMZ2 S LIST(XMZ)=""
 I '$D(LIST) D RECERR(.ERRCNT,"BAD QUEUE","No Valid MM Msgs are for REJECTS Queues for MM Msg: "_XMZ,0,.RECERR) G END
 F XMZ=XMZ1:1:XMZ2 I $D(LIST(XMZ)) D  ;
 . K ^XTMP(NMSPC,$J,"BILL")
 . K ^XTMP(NMSPC,$J,"REC")
 . S QNAM=$G(^XMB(3.9,XMZ,2,1,0)) ; Queue Name
 . I $D(^XMB(3.9,XMZ)) D  ;
 .. S BATFDT=$G(^XMB(3.9,XMZ,.6))
 .. S LSTREC=$P($G(^XMB(3.9,XMZ,2,0)),U,3) ; last record# of data
 .. S XNRECS=$P($G(^XMB(3.9,XMZ,2,0)),U,4) ; #records expected from file
 .. S HDR=$G(^XMB(3.9,XMZ,2,2,0)) ; AITC Header record
 .. S BCIDA=$E(HDR,2,9) ; AITC Batch Control ID
 .. I 'XNRECS!'$L(HDR) D  Q  ;
 ... D RECERR(.ERRCNT,"NO RECS/HDR","No Records Found: '"_XNRECS_"'",0,.RECERR)
 .. D START
END ;
 I '$D(^XTMP(NMSPC,$J,"BULTN")) D  ;
 . S BLTNCNT=$G(BLTNCNT)+1
 . S ^XTMP(NMSPC,$J,"BULTN",BLTNCNT)=" "
 . S BLTNCNT=$G(BLTNCNT)+1
 . S BLTNREC="NOTE: NO UNPROCESSABLE/REJECT RECORDS FOUND NEEDING TO BE PROCESSED"
 . S ^XTMP(NMSPC,$J,"BULTN",BLTNCNT)=BLTNREC
 D SENDBUL^RCTCSJS1
 I $D(^XTMP(NMSPC,$J,"ERR")) D SENDERR^RCTCSJS1
 D CLEANUP^RCTCSJS1
 Q  ; ENTER
 ;
INIT1 ;     initialize first time
 S NMSPC="RCTCSJS"
 S CSRCS=""
 S XMZ1=$P($G(XMZ),"-")
 S XMZ2=$P($G(XMZ),"-",2)
 K ^XTMP(NMSPC,$J)
 K TOTAMT,ARTXNID
 S U="^"
 S STATCNT=0 ; STATUS logging count
 D NOW^%DTC
 S (X1,RUNDT)=X,RUNDTTM=%
 S X2=30 D C^%DTC
 S ^XTMP(NMSPC,$J,0)=X_U_RUNDT_U_"CS REJECT FILE PROCESSING/"_DUZ
 S ERRCNT=0 ; ERROR logging count
 S NULLERR="",$P(NULLERR," ",19)="" ; for no error codes
 S BLNKS="",$P(BLNKS," ",25)=""
 S BLTNCNT=0
 S SITE=$$SITE^RCMSITE()
 Q  ; INIT1
 ;
INIT2 ;     subsequent inits
 S CRCNT=0 ; "C" records count
 S TOTAMT=0 ; Total Amount of Referred Balance
 N I ; new variables
 ;
 S LSTREC=$P($G(^XMB(3.9,XMZ,2,0)),U,3) ; last record# of data
 S XNRECS=$P($G(^XMB(3.9,XMZ,2,0)),U,4) ; #records expected from file
 S HDR=$G(^XMB(3.9,XMZ,2,2,0)) ; AITC Header record
 S BCIDA=$E(HDR,2,9) ; AITC Batch Control ID
 I 'XNRECS!'$L(HDR) D  Q  ;
 . D RECERR(.ERRCNT,"NO RECS/HDR","No Records Found: '"_XNRECS_"'",0,.RECERR)
 Q  ; INIT2
 ;
START ; start of process
 D INIT2
 D XMB2XTMP   ; moves MM data from ^XMB(3.9,... to ^XTMP
 D SRTXTMP    ; sorts recs from ^XTMP into by Debtor, by BILL
 S STOPSET="" ; flag to determine if data is error free (or not)
 I RECNS'=XNRECS D  ; logs MailMan record COUNT error
 . S ZMSG="Expected MM RECS: '"_XNRECS_"' not same as # RECS FOUND: '"_RECNS_"'"
 . D RECERR(.ERRCNT,"RECNUMS",ZMSG,RECNS,.RECERR)
 . S STOPSET=1
TOT ;
 I $TR(TOTAMT,"-+","")'=(+ZTOTA*.01) D  ; logs record Total Amt error
 . S X=TOTAMT,X2="2$",X3=4 D COMMA^%DTC S TOTAMOUT=$TR(X," ","")
 . S X=ZTOTA*.01,X2="2$",X3=4 D COMMA^%DTC S ZTOTAOUT=$TR(X," ","")
 . S ZMSG="Expected $Amt: '"_ZTOTAOUT_"' = ACCUMULATED AMT found: '"_TOTAMOUT_"'"
 . D RECERR(.ERRCNT,"TOTAL $ AMT",ZMSG,RECNS,.RECERR)
 . S STOPSET=STOPSET_2
 I CRCNT'=+$G(ZRCNT) D  ; logs record COUNT error
 . S ZMSG="Z record RECS: '"_$G(ZRCNT)_"' not same as # RECS FOUND: '"_CRCNT_"'"
 . D RECERR(.ERRCNT,"Z-REC-CNTS",ZMSG,RECNS,.RECERR)
 . S STOPSET=STOPSET_3
 I STOPSET S STOPMSG="" D  Q  ; whole file error detected, DO NOT PROCESS REJECTS
 . F I=1:1:3 I STOPSET[I D  ;
 .. I I[1 S STOPMSG="(#MM RECS("_XNRECS_") not same as #Recs found("_RECNS_")"
 .. I I[2 S STOPMSG="(ZTOTAMT("_(+$G(ZTOTA)*.01)_") = Amt found("_TOTAMT*100_")"
 .. I I[3 S STOPMSG="(#Z RECCNT("_$G(ZRCNT)_") not = #C Recs found("_CRCNT_")"
 .. S ZMSG="BILL Records NOT Updated: "_STOPMSG
 .. D RECERR(.ERRCNT,"FILE ERR",ZMSG,RECNS,.RECERR)
 I '$D(^XTMP(NMSPC,$J,"BILL")) D  Q  ; logs NO VALID BILLS found error
 . S ZMSG="Found NO REJECT Bill Errors"
 . D RECERR(.ERRCNT,"NO BILLS",ZMSG,0,.RECERR)
 D SETREJS^RCTCSJS
 Q  ; START
 ;
XMB2XTMP ;copies ^XMB(3.9,XMZ) to ^XTMP
 M ^XTMP(NMSPC,$J,"READ",BCIDA)=^XMB(3.9,XMZ,2)
 Q  ; XMB2XTMP
 ;
SRTXTMP ;sorts ^XTMP(...,"READ" recs into ^XTMP(..."BILL" which is sorted by Debtor ID, by BILL
 F RECN=2:2 Q:'$D(^XTMP(NMSPC,$J,"READ",BCIDA,RECN))  D  ;
 . S NOTPROC=""
 . K CERRS
 . S RECERR=0
 . S REC1=^XTMP(NMSPC,$J,"READ",BCIDA,RECN,0)
 . S REC2=^XTMP(NMSPC,$J,"READ",BCIDA,RECN+1,0)
 . S REC=$P(REC1,"^")_$P(REC2,"~") ; eliminate record delimiters
 . Q:$E(REC,1,4)="NNNN"
 . S RID=$E(REC) ; (H,C,Z)
 . S RTYP=$TR($E(REC,2,3)," ","") ; eliminate spaces
 . I RID="C",",1,2,2A,2B,2C,2D,2E,3,4,5A,5B,6,"'[(","_RTYP_",") D  Q  ; logs RTYP error
 .. S CBILL=$E(REC,20,29)
 .. S ZMSG="Invalid Record TYPE Received: '"_RTYP_"' from Record: "_CBILL_", record# "_RECN
 .. D RECERR(.ERRCNT,"INV REC TYPE",ZMSG,RECN,.RECERR)
 . S RACTN=$E(REC,4) ; (A,B,D,L,U,V)
 . I $L(REC)'=471 D  Q  ; logs record LEN error
 .. D RECERR(.ERRCNT,"RECLEN","Record Length Error: "_$L(REC),RECN,.RECERR)
 . D @RID
 . Q:RECERR  ; quit, process err detected and logged via RECERR
 . Q:$G(CERRS(RTYP))=NULLERR!'$D(CERRS(RTYP))  ; ignore, no errors in this record
 . I CERRS(RTYP)["9A" S REFBATCH=$E(CERRS(RTYP),11,18) D  ;
 .. S ZMSG="Invalid Referral Batch: '"_REFBATCH_"'  from Message: '"_XMZ_"'"
 .. D RECERR(.ERRCNT,"INV REF BATCH",ZMSG,RECN,.RECERR)
 .. S ERRSFND("9A",REFBATCH,XMZ)=""
 . I '$G(SAMESITE) D  ;
 .. S ZMSG="Expecting: '"_SITE_"', Found: '"_SITENUM_"'/"_CBILL_"/"_RID_RTYP
 .. D RECERR(.ERRCNT,"WRONG REC SITE",ZMSG,RECN,.RECERR)
 . Q:'$G(SAMESITE)  ; ignore, this record belongs to a different site
 . ;  Q:$G(NOTPROC)  ; last Z record shows first THRU last batches were not all completely satisfied
 . ;
 . I RID="C" D LOGREJS
 S RECNS=RECN-1
 Q  ; SRTXTMP
 ;
C S CRCNT=CRCNT+1
 S CERRS(RTYP)=$E(REC,452,469)
 F PC=1:2 S CHKEC=$E(CERRS(RTYP),PC,PC+1) Q:CHKEC=""  Q:CHKEC="  "  I '$D(^RC(348.5,"B",CHKEC)) D  ;
 . S ZMSG="Invalid Error Code: '"_CHKEC_"' in Batch: "_BCIDA_"/"_RID_RTYP
 . S ERR=1 D RECERR(.ERRCNT,"INV ERR CODE",ZMSG,RECN,.RECERR)
 S CSRC=$E(REC,470),CSRC=$S(CSRC=" ":"T",1:CSRC)
 I CSRCS'[CSRC S CSRCS=CSRCS_CSRC
 S LBL="L"_RTYP
 D @LBL ; perform record type parsing of data
 Q  ; C
H ; Header record
 S BCIDA=$E(REC,2,9)
 S HREC=REC
 S HFAST=$E(REC,24,25),HALC=$E(REC,26,33),HERRS=$E(REC,452,469),HSRC=$E(REC,470,471)
 S H4DATE=$E(BCIDA,1,4),HSEQ=$E(BCIDA,5,9) ; (note: H4DATE is Y_DOY)
 D DOY2EXT(H4DATE,.HDATE)
 I HDATE'?7N S ERR=1 D RECERR(.ERRCNT,"INV DATE","Invalid Date: '"_HDATE_"' /"_RID_RTYP,RECN,.RECERR) Q  ;
 I HERRS'=NULLERR S FILERR=$E(HERRS,1,10),BCIDV=$E(HERRS,11,18)
 Q  ; H
Z ; Trailer record
 S ZREC=REC
 S ZRCNT=$E(REC,2,9),ZTOTA=$E(REC,10,23)
 S Z4DOY=$E(REC,24,27)
 S ZSEQ=$E(REC,28,31)
 S ZFAST=$E(REC,46,47),ZALC=$E(REC,48,55)
 S ZERRS=$S($E(REC,452)'=" ":$E(REC,452,469),1:NULLERR)
 S ZBAT1=$E(REC,459,462),ZBAT2=$E(REC,463,466)
 S ZSRC=$E(REC,470,471)
 D DOY2EXT(Z4DOY,.ZDATE)
 Q  ; Z
DOY2EXT(YDOY,ZDATE) ; gets Date from DOY;
 N X
 S ZLYR=$E(YDOY),ZDOY=$E(YDOY,2,4)
 S %H=$H D YX^%DTC
 S X1=$S($E(X,3)=ZLYR:$E(X,1,3)-1,$E(X,3)<ZLYR:$E(X,1,2)_ZLYR-11,$E(X,3)>ZLYR:$E(X,1,2)_ZLYR-1)_"1231"
 S X2=ZDOY D C^%DTC
 S NX=X
 S ZDATE=$S(ZDOY>365&($E(X,4,7)'="1231"):-1,1:NX) ; error if DOY >365 and not a Leap Year 
 Q  ; DOY2EXT
 ;
L1 ; Debt Record
 S CORIGD=$E(REC,77,90)*.01,CREFBAL=$TR($E(REC,91,104),"-","0")*.01
 S TOTAMT=$G(TOTAMT)+CREFBAL
 D GETPCS1
 Q  ; L1
L2 ;; Debtor Record
 S CDEBTIN=$E(REC,65,73),CDEBNAML=$E(REC,77,111),CDEBNAMF=$E(REC,112,146)
 S CDEBNAMM=$E(REC,147,181)
 D GETPCS1
 Q  ;L2
L2A ;; Individual Debtor Record
 S CDEBSEX=$E(REC,68),CDOB=$E(REC,69,76)
 D GETPCS1
 Q  ;L2A
L2B ; Business Debtor Record
 D GETPCS1
 Q  ; L2B
L2C ; Debtor Contact Information
 S CDEBTIN=$E(REC,65,73)
 D GETPCS1
 Q  ; L2C
L2D ; Debtor Record (Property Information)
 D GETPCS1
 Q  ; L2D
L2E ; Debtor Record (Employment Information for Individual Debtor)
 D GETPCS1
 Q  ; L2E
L3 ; Case Record
 D GETPCS1
 Q  ; L3
L4 ; Alias Name
 S CDEBTIN=$E(REC,65,73)
 D GETPCS1
 Q  ; L4
L5A ; Creditor Agency Financial Transactions (Collections)
 S CTRAMT=$E(REC,117,130)*.01,CORIGPMT=$E(REC,117,130)*.01
 S TOTAMT=+$G(TOTAMT)+($TR($E(REC,117,130),"-","0")*.01)
 D GETPCS2
 Q  ; L5A
L5B ; Creditor Agency Financial Transactions (Adjustments)
 S CSPAMT=$E(REC,117,130)*.01,CSTAMT=$E(REC,173,186)*.01
 S CSTADJ=$E(REC,211,224)*.01
 S TOTAMT=+$G(TOTAMT)+($TR($E(REC,173,186),"-","0")*.01)
 D GETPCS2
 S ARTXNID=$E(REC,93,107),ARTXNID(CDEBTIEN)=+ARTXNID_U_CBILL_U_RECN
 Q  ; L5B
L6 ; Payment Bypass/Offset
 S CDEBTIN=$E(REC,65,73)
 D GETPCS1
 Q  ; L6
 ;
LOGREJS ; compiles the varied reject errors by BILL
 K Z
 S CERRS=$P($G(^XTMP(NMSPC,$J,"BILL",CDEBTIEN,CBILL,HDATE,CSRC,RTYP,RACTN)),U)
 F I=2:2:18 S ERR=$E(CERRS(RTYP),I-1,I) Q:ERR="  "  D  ;
 . I '$D(^RC(348.5,"B",ERR)) D  Q  ;
 .. S ZMSG="Unknown Error Code: '"_ERR_"', FOUND IN: "_CBILL_"/"_RID_RTYP
 .. D RECERR(.ERRCNT,"UNK ERR CD",ZMSG,RECN,.RECERR)
 . S:CERRS'[ERR CERRS=CERRS_ERR_"," ; captures new errs
 I $L(CERRS) S ^XTMP(NMSPC,$J,"BILL",CDEBTIEN,CBILL,HDATE,CSRC,RTYP,RACTN)=CERRS_U_$G(ARTXNID(CDEBTIEN,CBILL))
 Q  ; LOGREJS
 ;
GETPCS1 ; 
 Q:CERRS(RTYP)=NULLERR
 S CDEBTID=$E(REC,20,49)
 S SITENUM=$E(CDEBTID,1,3)
 S SAMESITE=$S(SITENUM=SITE:1,1:0)
 I 'SAMESITE D  Q  ;
 . S ZMSG="Wrong Rec Site ('"_SITENUM_"' vs. '"_SITE_"') /"_CDEBTID_"/"_CBILL_"/"_RID_RTYP
 . D RECERR(.ERRCNT,"WRONG REC SITE",ZMSG,RECN,.RECERR)
 S CACT=$E(REC,4),CFAST=$E(REC,5,6),CALC=$E(REC,7,14),CSTATN=$E(REC,15,19)
 S CDEBTOR=$E(REC,50,64)
 D CHKBD ; check for valid Bill/Debtor
 S (CORIDG,CREFBAL)=""
 Q  ;GETPC1
 ;
GETPCS2 Q:CERRS(RTYP)=NULLERR
 S CDEBTID=$E(REC,21,50)
 S SITENUM=$E(CDEBTID,1,3)
 S SAMESITE=$S(SITENUM=SITE:1,1:0)
 I 'SAMESITE D  Q  ;
 . S ZMSG="Wrong RecSite ('"_SITENUM_"' vs. '"_SITE_"') /"_CDEBTID_"/"_CBILL_"/"_RID_RTYP
 . D RECERR(.ERRCNT,"WRONG REC SITE",ZMSG,RECN,.RECERR)
 S CACT=$E(REC,4),CFAST=$E(REC,5,6),CALC=$E(REC,7,14),CSTATN=$E(REC,15,19)
 S CDEBTOR=$E(REC,51,65)
 D CHKBD ; check for valid Bill/Debtor
 S (CORIDG,CREFBAL)=""
 Q  ;GETPC2
 ;
CHKBD ; checks for valid Bill/Debtor
 S RECERR=""
 S CBILL=$E(CDEBTID,1,3)_"-"_$E(CDEBTID,4,10),CDEBTIEN=+$E(CDEBTID,11,30)
 I '$D(^PRCA(430,"B",CBILL,CDEBTIEN)) D  ;
 . S ZMSG="Bill IEN: "_CDEBTIEN_"/"_CBILL_"/"_RID_RTYP
 . D RECERR(.ERRCNT,"NO BILL/DEBTOR ",ZMSG,RECN,.RECERR)
 Q
 ;
RECERR(ERRCNT,ETYP,ERRDATA,RECN,RECERR) ; log TRANSMITTED FORMAT err
 S (ERRCNT,^XTMP(NMSPC,$J,"ERR",0))=$G(^XTMP(NMSPC,$J,"ERR",0))+1
 S ^XTMP(NMSPC,$J,"ERR",ERRCNT)=RECN_U_ERRDATA
 S RECERR=1
 Q  ;
