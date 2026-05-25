PSOERHL0 ;BIRM/MFR - eRx History Log View - Listman Driver ;04/12/23
 ;;7.0;OUTPATIENT PHARMACY;**700,746,770,803**;DEC 1997;Build 1
 ;
EN(PSOERXID) ;Menu option entry point
 N PSOSRTBY,PSORDER,UNDLN,HIGHLN,REVLN,LASTLINE,VALMCNT
 ;
 S PSOSRTBY="DT",PSORDER="A"
 W !,"Please wait..."
 D EN^VALM("PSO ERX HISTORY LOG")
 D FULL^VALM1
 G EXIT
 ;
HDR      ;Header
 N LINE,POS,LINE1,LINE2,LINE3,LINE4,WT,WTDT,HT,HTDT,VADM,DFN,PNAME,DOB,SEX,X,GMRAL,ADVREA
 K VALMHDR S VALMHDR(1)="eRx Patient: "_$$GET1^DIQ(52.49,PSOERXID,.04,"E")
 S VALMHDR(2)="eRx Reference #: "_$$GET1^DIQ(52.49,PSOERXID,.01)
 Q
 ;
INIT ;Populates the Body section for ListMan
 K ^TMP("PSOERXHL",$J)
 D SETSORT(PSOSRTBY),SETLINE
 Q
 ;
SETLINE ;Sets the line to be displayed in ListMan
 ;
 I '$D(^TMP("PSOERXHL",$J)) D  Q
 . F I=1:1:6 S ^TMP("PSOERXHL",$J,I,0)=""
 . S ^TMP("PSOERXHL",$J,7,0)="                    No History Log for this eRx"
 . S VALMCNT=1
 ;
 ;Saving NORMAL video attributes to be reset later
 I LINE>$G(LASTLINE) D
 . F I=($G(LASTLINE)+1):1:LINE D SAVE^VALM10(I)
 . S LASTLINE=LINE
 S VALMCNT=+$G(LINE)
 D VIDEO
 ;
 Q
 ;
VIDEO ; - Changes the Video Attributes for the list
 ; - Highlighting the group lines (order type and status)
 N LN
 F LN=1:1:LASTLINE D
 . I $G(UNDLN(LN)) D CNTRL^VALM10(LN,+UNDLN(LN),$P(UNDLN(LN),"^",2),IOUON,IOINORM)
 . I $G(HIGHLN(LN)) D CNTRL^VALM10(LN,+HIGHLN(LN),$P(HIGHLN(LN),"^",2),IOINHI,IOINORM)
 . I $G(REVLN(LN)) D CNTRL^VALM10(LN,+REVLN(LN),$P(REVLN(LN),"^",2),IORVON,IORVOFF)
 Q
 ;
SETSORT(SORTBY) ;Building the list (line by line)
 ;Resetting list to NORMAL video attributes
 D RESET^PSOERUT0()
 S LINE=0
 N PAAM,PRAM,DRAM,PAME,PRME,DRME,DISP,X1,X2,X3
 K ^TMP("PSOERXHL",$J)
 S PAAM=$$GET1^DIQ(52.49,PSOERXID,1.6,"E") S PAME=$$GET1^DIQ(52.49,PSOERXID,1.7,"E")
 S PRAM=$$GET1^DIQ(52.49,PSOERXID,1.2,"E") S PRME=$$GET1^DIQ(52.49,PSOERXID,1.3,"E")
 S DRAM=$$GET1^DIQ(52.49,PSOERXID,1.4,"E") S DRME=$$GET1^DIQ(52.49,PSOERXID,1.5,"E")
 S X1="Pat  Auto-Match: "_PAAM,$E(X1,39)="Pat  Manual Edit: "_PRAM
 S X2="Prov Auto-Match: "_PRAM,$E(X2,39)="Prov Manual Edit: "_PRME
 S X3="Drug Auto-Match: "_DRAM,$E(X3,39)="Drug Manual Edit: "_DRME
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=X1
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=X2
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=X3
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=""
 ;
 N AUD,ZAUD,IENS,DATETIME,EDITEDBY,STADE,X1,X2,I,VAL1,RET,II,HFFDT
 S AUD=0    ;STATUS HISTORY LOOP
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="Status History:",REVLN(LINE)="1^15"
 S X1="Date/Time",$E(X1,19)="Status",$E(X1,60)="Entered By"
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=X1,UNDLN(LINE)="1^80"
 I '$D(^PS(52.49,PSOERXID,19)) S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="No Status History Available"
 F  S AUD=$O(^PS(52.49,PSOERXID,19,AUD)) Q:'AUD  D
 . S ZAUD=$G(^PS(52.49,PSOERXID,19,AUD,0))
 . S IENS=AUD_","_PSOERXID_","
 . S DATETIME=$P(ZAUD,"^",1)
 . S EDITEDBY=$P(ZAUD,"^",3)
 . S EDITEDBY=$E(EDITEDBY,1,16)
 . S STADE=$$GET1^DIQ(52.45,$P(ZAUD,"^",2),.02)
 . S STADE=$E(STADE,1,36)
 . S X2=$$FMTE^XLFDT(DATETIME,"2Z"),$E(X2,19)=$$GET1^DIQ(52.45,$P(ZAUD,"^",2),.01)_"-"_$E(STADE,1,34)
 . ; Un-Accept Flag
 . I $P(ZAUD,"^",4) S X2=X2_" (Un-Accept)"
 . ; Hold for Future Fill Date
 . I $$GET1^DIQ(52.45,$P(ZAUD,"^",2),.01)="HFF" S X2=X2_" ("_$$FMTE^XLFDT($P(ZAUD,"^",5))_")"
 . S $E(X2,60)=$E($$GET1^DIQ(200,EDITEDBY,.01),1,19)  ;eRx Status
 . S LINE=LINE+1 S ^TMP("PSOERXHL",$J,LINE,0)=X2
 . S VAL1=$$GET1^DIQ(52.4919,IENS,1,"E")
 . I $G(VAL1)'="" D
 . . K RET D TXT2ARY^PSOERXD1(.RET,VAL1,,60)
 . . F II=1:1:+$O(RET(""),-1) S LINE=LINE+1 S ^TMP("PSOERXHL",$J,LINE,0)=$S(II=1:"Status Comments: ",1:"")_RET(II),HIGHLN(LINE)="1^80"
 ;
 N OERR,ORSTAT,IEN,DATETM,FLGDT,FLGBY,FLGREA,UNFLGDT,UNFLGBY,UNFLGRE,X1,X2,FLG
 S OERR=$$GET1^DIQ(52.49,PSOERXID,.12)
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=""
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="Order:",REVLN(LINE)="1^6"
 S X1="Date/Time",$E(X1,24)="Order#",$E(X1,43)="Status"
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=X1,UNDLN(LINE)="1^80"
 I 'OERR S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="No Order History Available"
 I OERR D
 . S ORSTAT=$$GET1^DIQ(100,OERR,5,"E")     ;Order Status  ;p803 moved current and next 3 lines outside FLG loop
 . S DATETM=$$GET1^DIQ(100,OERR,31,"I")    ;Date/Time
 . S X2=$$FMTE^XLFDT(DATETM,"2Z"),$E(X2,24)=OERR,$E(X2,43)=ORSTAT
 . S LINE=LINE+1 S ^TMP("PSOERXHL",$J,LINE,0)=X2
 . S FLG=0 F  S FLG=$O(^OR(100,OERR,8,FLG)) Q:'FLG  D
 . . I '$D(^OR(100,OERR,8,FLG,3)) Q
 . . S FLGDT=$$GET1^DIQ(100.008,FLG_","_OERR,33)             ;Date/Time Flagged
 . . S FLGBY=$E($$GET1^DIQ(100.008,FLG_","_OERR,34),1,26)    ;Flagged By
 . . S FLGREA=$$GET1^DIQ(100.008,FLG_","_OERR,35)            ;Flagged Reason
 . . S UNFLGDT=$$GET1^DIQ(100.008,FLG_","_OERR,36)           ;Date/Time Un-flagged
 . . S UNFLGBY=$E($$GET1^DIQ(100.008,FLG_","_OERR,37),1,26)  ;Un-flagged By
 . . S UNFLGRE=$$GET1^DIQ(100.008,FLG_","_OERR,38)           ;Un-flagged Reason
 . . I $G(FLGDT)'="" S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="Date/Time Flagged:"_" "_$$FMTE^XLFDT(FLGDT,"2Z"),HIGHLN(LINE)="20^18"
 . . I $G(FLGBY)'="" S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="Flagged By:"_" "_FLGBY,HIGHLN(LINE)="13^50"
 . . I $G(FLGREA)'="" S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="Reason for Flag:"_" "_$G(FLGREA),HIGHLN(LINE)="18^62"
 . . I $G(UNFLGDT)'="" S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="",LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="Date/Time Unflagged:"_" "_$$FMTE^XLFDT(UNFLGDT,"2Z"),HIGHLN(LINE)="22^18"
 . . I $G(UNFLGBY)'="" S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="Unflagged By:"_" "_UNFLGBY,HIGHLN(LINE)="15^50"
 . . I $G(UNFLGRE)'="" S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="Reason for Unflag:"_" "_$G(UNFLGRE),HIGHLN(LINE)="20^60"
 ;
 N ERXHUB,PSRX,AUD,ZAUD,IENS,PRESE,PRESI,DATETIME,FLDNAME,EDITEDBY,FILL,COMMENT,X,X1,X2
 S ERXHUB=$P(^PS(52.49,PSOERXID,0),"^",1)
 S (PSRX,AUD,IEN)=0 ;RX ACTIVITY LOG
 S PRESE=$$GET1^DIQ(52.49,PSOERXID,.13,"E")
 S PRESI=$$GET1^DIQ(52.49,PSOERXID,.13,"I")
 I PRESE'="" D
 . S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=""
 . S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="Prescription:",REVLN(LINE)="1^13",UNDLN(LINE)="14^80"
 . S X="Prescription#: ",$E(X,16)=PRESE,$E(X,38)="Status: ",$E(X,47)=$$GET1^DIQ(52,PRESI,100,"E")
 . S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=X
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=""
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="Activity Log:",REVLN(LINE)="1^13"
 S X1="Date/Time",$E(X1,19)="Reason",$E(X1,41)="Rx Ref",$E(X1,57)="Initiator Of Activity"
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=X1
 S LINE=LINE+1,$P(^TMP("PSOERXHL",$J,LINE,0),"=",79)="="
 I '$D(^PSRX("D",ERXHUB,"PHARMACY")) S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="No Activity Log Available"
 F  S PSRX=$O(^PSRX("D",ERXHUB,"PHARMACY",PSRX)) Q:'PSRX  D
 . I '$D(^PSRX(PSRX,"A")) Q
 . F  S AUD=$O(^PSRX(PSRX,"A",AUD)) Q:'AUD  D
 . . S ZAUD=$G(^PSRX(PSRX,"A",AUD,0))
 . . S IENS=AUD_","_PSRX_","
 . . I $$GET1^DIQ(52.3,IENS,.02,"I")="M" Q
 . . S DATETIME=$P(ZAUD,"^",1)
 . . S EDITEDBY=$P(ZAUD,"^",3)
 . . S FILL=$P(ZAUD,"^",4)
 . . S COMMENT=$P(ZAUD,"^",5)
 . . S FILL=$S(FILL>0&(FILL<6):"REFILL "_FILL,FILL=6:"PARTIAL",FILL>6:"REFILL "_(FILL-1),1:"ORIGINAL")
 . . S X2=$$FMTE^XLFDT(DATETIME,"2Z"),$E(X2,19)=$$GET1^DIQ(52.3,IENS,.02,"E"),$E(X2,41)=FILL,$E(X2,57)=$E($$GET1^DIQ(200,EDITEDBY,.01),1,24)
 . . S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=X2
 . . I $G(COMMENT)'="" S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="Comments: "_$P(ZAUD,"^",5),HIGHLN(LINE)="1^80"
 ;
 N PSRX,AUD,ZAUD,ZAUD1,TRANS,SEQNO,FILL,FILLD,STAT,STATD,BREF,DATE,NDC,COMMENTS,CARR,PKGID,FLDNAME,X1,X2,X3
 S PSRX=$$GET1^DIQ(52.49,PSOERXID,.13,"I")
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=""
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="CMOP Event Log:",REVLN(LINE)="1^15"
 S X1="Date/Time",$E(X1,19)="Rx Ref",$E(X1,28)="TRN-Order",$E(X1,42)="Stat",$E(X1,62)="NDC"
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=X1
 S LINE=LINE+1,$P(^TMP("PSOERXHL",$J,LINE,0),"=",79)="="
 I '$G(PSRX) S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="No CMOP Log Available"
 I $G(PSRX),'$D(^PSRX(PSRX,4)) S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="No CMOP Log Available"
 I $G(PSRX),$D(^PSRX(PSRX,4)) D
 . S AUD=0    ;CMOP LOOP
 . F  S AUD=$O(^PSRX(PSRX,4,AUD)) Q:'AUD  D
 . . S ZAUD=$G(^PSRX(PSRX,4,AUD,0))
 . . S ZAUD1=$G(^PSRX(PSRX,4,AUD,1))
 . . S TRANS=$P(ZAUD,U)      ;Transmission #
 . . S SEQNO=$P(ZAUD,U,2)    ;Sequence #
 . . S FILL=$P(ZAUD,U,3)     ;Rx Indicator
 . . S FILLD=$S(FILL>0&(FILL<6):"REFILL "_FILL,FILL=6:"PARTIAL",FILL>6:"REFILL "_(FILL-1),1:"ORIGINAL")
 . . S STAT=$P(ZAUD,U,4)     ;Status
 . . S STATD=$$STATDSP(STAT)
 . . S BREF=$G(TRANS)_"-"_$G(SEQNO)
 . . S DATE=$$CMOPDT(PSRX,FILL)   ;Date
 . . S NDC=$P(ZAUD,U,8)      ;NDC Received
 . . S COMMENTS=$S($G(STAT)=3:$E($P($G(ZAUD1),"^"),1,35),$G(NDC)'="":"NDC: "_NDC,1:"")   ;They only want to see comments if STATUS=3/Not Dispensed
 . . S CARR=$P(ZAUD1,U,3)    ;Carrier 
 . . S PKGID=$P(ZAUD1,U,4)   ;Package ID
 . . S X2=$$FMTE^XLFDT(DATE,"2Z"),$E(X2,19)=FILLD,$E(X2,28)=BREF,$E(X2,42)=STATD,$E(X2,62)=NDC
 . . S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=X2
 . . S X3="Carrier: "_CARR,$E(X3,28)="Package ID: "_PKGID
 . . S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=X3
 . . I $G(COMMENTS)'="" S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="Comments: "_COMMENTS,HIGHLN(LINE)="1^80"
 ;
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=""
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)="Change, Cancel, Renewal Log:",REVLN(LINE)="1^28"
 S X1="Date/Time",$E(X1,19)="MessageType",$E(X1,37)="eRx ID",$E(X1,63)="eRx Order Status"
 S LINE=LINE+1,^TMP("PSOERXHL",$J,LINE,0)=X1,UNDLN(LINE)="1^80"
 N FLAG,MTYPE,REQIEN,REQID,RESIEN,RESID,RELERX,RELMES,RELTYPE,RESTYPE,REQTYPE
 S (FLAG,RELMES)=0
 S MTYPE=$$GET1^DIQ(52.49,PSOERXID,.08,"I")
 I ",RR,CA,CR,"[(","_MTYPE_",") D
 . S FLAG=1,REQIEN=PSOERXID,RESIEN=$$GETRESP^PSOERXU2(PSOERXID)  ;If the message is a Request
 . S RESTYPE=$$GET1^DIQ(52.49,RESIEN,.08,"I")
 . I ",N,RR,CA,CR,"[(","_RESTYPE_",") S RESIEN=""
 I ",RE,CN,CX,"[(","_MTYPE_",") D
 . S FLAG=1,RESIEN=PSOERXID,REQIEN=$$RESOLV^PSOERXU2(PSOERXID)   ;If the message is a Response
 . S REQTYPE=$$GET1^DIQ(52.49,REQIEN,.08,"I")
 . I ",N,RE,CN,CX,"[(","_REQTYPE_",") S REQIEN=""
 I ",N,RE,"[(","_MTYPE_",") D                                       ;If the message is a New eRx
 . D GETDATA^PSOERHL1(PSOERXID)
 . F  S RELMES=$O(^PS(52.49,PSOERXID,201,"B",RELMES)) Q:'RELMES  D
 . . S RELTYPE=$$GET1^DIQ(52.49,RELMES,.08,"I")
 . . I ",RR,CA,CR,RE,CN,CX,"[(","_RELTYPE_",") D
 . . . D GETDATA^PSOERHL1(RELMES)
 I MTYPE="IE" S FLAG=1,RESIEN=PSOERXID,REQIEN=$$RESOLV^PSOERXU2(PSOERXID)     ;If the message is an Inbound Error
 ;Inbound Error, Request and Response below
 I $G(FLAG) D
 . I $G(REQIEN)'="" S REQID=$$GET1^DIQ(52.49,REQIEN,.01,"E"),RELERX=$$GET1^DIQ(52.49,REQIEN,.14)
 . I $G(RESIEN)'="" S RESID=$$GET1^DIQ(52.49,RESIEN,.01,"E")
 . I $G(RELERX)'="" D    ;New eRX
 . . N ERXIEN S ERXIEN=$O(^PS(52.49,"B",RELERX,0))
 . . D GETDATA^PSOERHL1(ERXIEN)
 . I $G(REQID)'="" D     ;Request
 . . N ERXIEN S ERXIEN=$O(^PS(52.49,"B",REQID,0))
 . . D GETDATA^PSOERHL1(ERXIEN)
 . I $G(RESID)'="" D     ;Response
 . . N ERXIEN S ERXIEN=$O(^PS(52.49,"B",RESID,0))
 . . D GETDATA^PSOERHL1(ERXIEN)
 Q
 ;
STATDSP(STAT) ;Determine Status to display
 ;0:TRANSMITTED
 ;1:DISPENSED
 ;2:RETRANSMITTED
 ;3:NOT DISPENSED
 N STATD
 S:STAT=0 STATD="TRAN"
 S:STAT=1 STATD="DISP"
 I $G(STATD)="DISP" D
 . I FILL>0,('$D(^PSRX(PSRX,1,FILL,0))) S STATD="DISP Refill Deleted" Q
 S:STAT=2 STATD="RTRN"
 S:STAT=3 STATD="NDISP"
 Q STATD
 ;
CMOPDT(PSRX,FILL) ;Determine date to display
 ;Use Cancelled DT/TM first if available
 ;If Cancelled DT/TM is not populated, use Release DT/TM
 ;If Release DT/TM is not populated, use Transmission Create DT/TM
 ;
 N CANDT,CDATE
 I $G(STAT)=3 S CANDT=$P(ZAUD,U,5) I CANDT'="" Q CANDT   ;Cancelled DT/TM
 ;If status = 3 (not dispensed) and there is a cancelled date/time then quit with the cancelled date/time
 I $G(STAT)=1 D
 . S CDATE=$S(FILL=0:$P(^PSRX(PSRX,2),"^",13),1:$P(^PSRX(PSRX,1,FILL,0),"^",18))
 . ;If Original Fill set to Released Date/Time (node 2 piece 13)
 . ;If Fill greater than 0 (not Original) set to Released Date in the Refill Node (node 1 piece 18) 
 I $G(STAT)=3,'FILL,$$GET1^DIQ(52,PSRX,32.1,"I") Q $$FMTE^XLFDT($$GET1^DIQ(52,PSRX,32.1,"I"),2)  ;If original fill and RTS
 I $G(STAT)=3,FILL,$$GET1^DIQ(52.1,FILL_","_PSRX,5,"I") Q $$FMTE^XLFDT($$GET1^DIQ(52.1,FILL_","_PSRX,32.1,"I"),2)  ;If refill and there is a lot#
 I '$G(CDATE) D
 . S CDATE=$P(^PSX(550.2,TRANS,0),"^",6)    ;Transmission DT/TM
 Q $G(CDATE)
 ;
REFRESH ;Screen Refresh
 W ?52,"Please wait..." D INIT,HDR S VALMBCK="R"
 Q
 ;
EXIT ;
 K ^TMP("PSOERXHL",$J)
 Q
 ;
HELP Q
