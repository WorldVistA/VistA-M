PSOERSE1 ;ALB/RM - Single eRx View/Display ;Jan 30, 2024@12:43:34
 ;;7.0;OUTPATIENT PHARMACY;**746,769,770**;DEC 16, 1997;Build 145
 ;
 ;
EN(PSOIEN) ; -- main entry point for PSO ERX SINGLE ERX DISPLAY
 N ERXIEN,MBMSITE,ERXSTATSD,ERXMTYPE,SDERXFLG,HGHLIGHT
 Q:'$G(PSOIEN)
 S ERXIEN=PSOIEN
 ; Saving VistA Patient for Fileman Recall (via space bar)
 I $$GET1^DIQ(52.49,ERXIEN,.05,"I") D RECALL^DILFD(2,$$GET1^DIQ(52.49,ERXIEN,.05,"I")_",",DUZ)
 S ERXSTATSD="" ;this variable is used to hold the eRx status
 S SDERXFLG=1
 S MBMSITE=$S($$GET1^DIQ(59.7,1,102,"I")="MBM":1,1:0)
 D EN^VALM("PSO ERX SINGLE ERX DISPLAY")
 Q
 ;
HDR ; -- header code
 N HDR K VALMHDR
 S VALMHDR(1)="eRx Patient: "_IOINHI_$E($$GET1^DIQ(52.49,ERXIEN,.04,"E"),1,30)_IOINORM
 D INSTR^VALM1("eRx Reference #: "_IOINHI_$$GET1^DIQ(52.49,ERXIEN,.01)_IOINORM,50,2)
 S VALMHDR(2)="eRx Msg Type: "_IOINHI_$$GETMTYPE(ERXIEN)_IOINORM
 I $$GET1^DIQ(52.49,ERXIEN,10.5,"I")=2 D
 . D INSTR^VALM1(IORVON_"ERX HAS DO NOT FILL INDICATOR PER PROVIDER"_IORVOFF,39,3)
 E  I $$GET1^DIQ(52.49,ERXIEN,95.1,"I") D
 . D INSTR^VALM1(IORVON_"EPCS DEA VALIDATED"_IORVOFF,63,3) ;controlled substance indicator
 E  D INSTR^VALM1("Written: "_IOINHI_$$FMTE^XLFDT($$GET1^DIQ(52.49,ERXIEN,5.9,"I")\1,"2Z"),64,3)
 S VALMHDR(3)=IORVOFF_"eRx Status: "_IOINHI_$$GET1^DIQ(52.49,ERXIEN,1)_" - "_$$GET1^DIQ(52.45,$$GET1^DIQ(52.49,ERXIEN,1,"I"),.02)
 S VALMHDR(3)=VALMHDR(3)_$S($$GET1^DIQ(52.49,ERXIEN,1)="HFF":" ("_$$GET1^DIQ(52.49,ERXIEN,6.7)_")",1:"")_IOINORM
 I ",RR,RE,IE,OE,CA,CN,CX,CR,"'[(","_$$GET1^DIQ(52.49,ERXIEN,.08,"I")_",") D
 . S HDR="",$E(HDR,20)="ERX",$E(HDR,40)="|",$E(HDR,58)="VISTA"
 S $E(HDR,81)="" D INSTR^VALM1(IORVON_IOUON_HDR_IORVOFF_IOINORM,1,5)
 ;
 I $$GET1^DIQ(59.7,1,102,"I")="MBM",$$MISSINGPI^PSOERSE3(ERXIEN) D
 . N POS S POS=21 I $G(VALM("LINES")) S POS=VALM("LINES")+6
 . D INSTR^VALM1(IOBON_IORVON_"Type VSR to view Suggested Rx PATIENT INSTRUCTIONS field"_IOBOFF,10,POS) W $C(7)
 . S NPALERT=0
 ;
 Q
 ;
GETMTYPE(ERXIEN) ;Retrieve the eRx Message Type
 ; Input : ERXIEN - Pointer to ERX HOLDING QUEUE file (#52.49)
 ; Output: MTYPEE - eRx Message Type
 N MTYPE,MTYPEE,RESPVAL,CHGMESRQ,CHGMESRI
 S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 S MTYPEE=$$GET1^DIQ(52.49,ERXIEN,.08,"E")
 S RESPVAL=$$GET1^DIQ(52.49,ERXIEN,52.1,"E")
 S CHGMESRQ=$$GET1^DIQ(52.49,ERXIEN,315.1,"I")
 S CHGMESRI=$$GET1^DIQ(52.45,CHGMESRQ,.01,"I")
 I (",RE,CN,"[(","_MTYPE_","))!((MTYPE="CX")&$$CHGMTYPE^PSOERX1D(ERXIEN,MTYPE,RESPVAL,CHGMESRI)) S MTYPEE=$G(MTYPEE)_"-"_$$GET1^DIQ(52.49,ERXIEN,52.1,"E")
 Q $G(MTYPEE)
 ;
INIT ;
 N DDASH,MODE,NMSPC,ERXDATA,EPRVIEN,ERXDRGID,S2017,ERXRDT,XE,ERXHLDARY,ERXHLD,ERXHLDRSN,HIGHLN,HIGUNDLN,REVLN,BLINKLN
 ;determine the message type of this transaction to decide whether to display the side-by-side format or retain it as is.
 S ERXMTYPE=$P($$ERXMTYPE(ERXIEN),"^")
 S NMSPC="PSOERSE1",MODE="LM"
 K ^TMP("PSOERSE1",$J)
 S LINE=0
 D RESET^PSOERUT0()  ; - Resetting list to NORMAL video attributes
 S ^TMP("PSOERSE1",$J,1,0)=""
 S VALMBG=1
 ;
 ;display and set the hold reason if the eRx has a hold status and if it contains data, otherwise, do not display
 S ERXHLD=$$GETHLDSTA(.ERXHLDARY,ERXIEN)
 I +$G(ERXHLD)>1,$G(ERXHLDARY($J,3))'="" D
 . S ERXHLDRSN=$G(ERXHLDARY($J,3))
 . I $L(ERXHLDARY($J,3))>62 S ERXHLDRSN=$E(ERXHLDARY($J,3),1,60)_"..." ;truncate if it is longer than 60
 . S LINE=LINE+1 D ADDLINE^PSOERUT0(MODE,NMSPC,"eRx Hold Reason: "_ERXHLDRSN) ;this API automatically add a line, so no need to increment the line number
 . D CNTRL^VALM10(LINE-1,18,$L(ERXHLDRSN),IOINHI,IOINORM)
 ;
 I ",RR,RE,IE,OE,CA,CN,CX,CR,"[(","_ERXMTYPE_",") D  Q  ;if the message type contain one these types, the display will remain as is (NOT side by side format)
 . S SDERXFLG=0 D INIT^PSOERSE2(ERXIEN,SDERXFLG)
 . I $D(@VALMAR) D
 . . I $D(@VALMAR@(LINE)) S LINE=LINE+1
 . . S $P(DDASH,"_",81)="" D SET^VALM10(LINE,DDASH)
 . . S LINE=LINE+1 D ERXRCVDT(ERXIEN)
 . . I '$D(@VALMAR@(LINE)) S LINE=LINE-1 D CNTRL^VALM10(LINE,1,80,IOINHI,IOINORM)
 . . S VALMCNT=LINE
 ;
 ;side by side format begins here
 D SETPAT^PSOERUT0(MODE,ERXIEN,,NMSPC,0,1) ;Display Patient data
 S EPRVIEN=$$GET1^DIQ(52.49,ERXIEN,2.1,"I")
 I 'EPRVIEN S EPRVIEN=$$GETPROV^PSOERXU5(ERXIEN)
 D SETPROV^PSOERUT1(MODE,ERXIEN,,NMSPC,0,1) ;Display Provider data
 ;
 D ERXDATA^PSOERXU9(.ERXDATA,ERXIEN)
 S ERXDRGID=""
 I $D(ERXDATA) S ERXDRGID=$P(ERXDATA(1),"^",4)
 D SETDRUG^PSOERUT2(MODE,NMSPC,ERXIEN,0,0,"SE") ;Display Drug Data
 ;
 S S2017=$$GET1^DIQ(52.49,PSOIEN,312.1,"I") ;display erx written and issue/effective date
 D S2017(MODE,NMSPC,ERXIEN,S2017)
 D SETDIAGS^PSOERUT3(MODE,NMSPC,ERXIEN,"SE") ;display diagnosis and indications for use
 D ALLERGY^PSOERUT3(MODE,NMSPC,ERXIEN,+$$GET1^DIQ(52.49,ERXIEN,.05,"I"))
 D BLANKLN^PSOERUT0(MODE)
 ;
 D ERXRCVDT(ERXIEN) ;display the eRx Received Date time stamp
 ; DEA Note for CS Digitally Signed eRx records
 I $$GET1^DIQ(52.49,PSOIEN,95.1,"I") S LINE=LINE-1 D DEANOTE(.LINE)
 S VALMCNT=LINE-1
 ;
 ; - Saving NORMAL video attributes to be reset later
 I LINE>$G(LASTLINE) D
 . F I=($G(LASTLINE)+1):1:LINE D SAVE^VALM10(I)
 . S LASTLINE=LINE
 D VIDEO^PSOERUT0() ; Changes the Video Attributes for the list
 ;
HELP ; -- help code
 ;S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ERXSTATSD
 D CLEAN^VALM10
 D CLEAR^VALM1
 S VALMBCK="R",PSOREFSH=1
 Q
 ;
EXPND ; -- expand code
 Q
 ;
ERXMTYPE(ERXIEN) ;Retrieve the message type in File 52.49
 ; Input: ERXIEN - Pointer to ERX HOLDING QUEUE file (#52.49)
 ;Output: Message Type Internal Value^Message Type External Value
 I +$G(ERXIEN)<1 Q ""
 N ERXMTYPE,ERTYPEX,STATIEN,ERXSTAT
 S ERXMTYPE=""
 S ERXMTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 S ERTYPEX=$$GET1^DIQ(52.49,ERXIEN,.08,"E")
 S STATIEN=$$GET1^DIQ(52.49,ERXIEN,1,"I")
 S ERXSTAT=$$GET1^DIQ(52.45,STATIEN,.02,"E")
 Q $G(ERXMTYPE)_"^"_$G(ERTYPEX)
 ;
ERXRCVDT(ERXIEN) ;
 N ERXRDT
 S ERXRDT=$$GETERXRDT(ERXIEN)  ;display the eRx Received Date time stamp
 I $G(ERXRDT)'="" D
 . S XE=" eRx Received on "_$P(ERXRDT,"^")
 . I $P(ERXRDT,"^",2)'="" S XE=XE_" - Accepted by "_$P(ERXRDT,"^",2)_" on "_$P(ERXRDT,"^",3)
 . E  S XE="                       "_XE
 . D ADDLINE^PSOERUT0(MODE,NMSPC,$$COMPARE^PSOERUT0("LM",XE,XE,2))
 Q
 ;
S2017(MODE,NAMESPACE,ERXIEN,S2017) ;Retrieve erx written and effective/issue date
 N ERXWDATE,ERXEFFDT,WDATE,ERXDT,XE,XV,MIEN,X
 I 'S2017 D
 . S WDATE=$$GET1^DIQ(52.49,ERXIEN,5.9,"I")\1
 . S ERXDT=$$GET1^DIQ(52.49,ERXIEN,.03,"I")
 . S XE="Written: "_$$COMPARE^PSOERUT0(MODE,$$FMTE^XLFDT(WDATE,"2Z"),$$FMTE^XLFDT(WDATE,"2Z"),10)
 . S XE=XE_"  Effective: "_$$COMPARE^PSOERUT0(MODE,$$FMTE^XLFDT($P(ERXDT,"."),"2Z"),$$FMTE^XLFDT($P(ERXDT,"."),"2Z"),31)
 . D ADDLINE^PSOERUT0(MODE,NMSPC,XE,"|")
 I S2017 D
 . S MIEN=$O(^PS(52.49,ERXIEN,311,0))
 . S ERXEFFDT="",X=$$EFFDATE^PSOERXU5(ERXIEN,MIEN) I X'="" D ^%DT S ERXEFFDT=Y
 . S ERXWDATE=$$GET1^DIQ(52.49,ERXIEN,5.9,"I")\1
 . S XE="Written: "_$$COMPARE^PSOERUT0(MODE,$$FMTE^XLFDT($P(ERXWDATE,"."),"2Z"),$$FMTE^XLFDT($P(ERXWDATE,"."),"2Z"),10)
 . S XE=XE_"  Effective: "_$$COMPARE^PSOERUT0(MODE,$$FMTE^XLFDT(ERXEFFDT,"2Z"),$$FMTE^XLFDT(ERXEFFDT,"2Z"),31)
 . D ADDLINE^PSOERUT0(MODE,NMSPC,XE,"|")
 Q
 ;
GETHLDSTA(ERXHLDARY,ERXIEN) ;Retrieve the Erx Hold Status, Reason, and Hold By
 ; Input : ERXIEN    - Pointer to ERX HOLDING QUEUE file (#52.49)
 ; Output: ERXHLDARY - An array which must be passed in by reference; returned with the following:
 ;                     ERXHLDARY(#)=value or if no hold status ERXHLDARY(0)=""
 ;                     Where: 
 ;                       #     - is a sequential number greater than zero
 ;                       value - is a line of text
 ;                               1-Hold Status
 ;                               2-Hold Reason
 ;                               3-Hold Entered By
 N CURSTATE,CURSTATI,CNTR,HARY,HL,LHMATCH,LHFOUND,LHSTATI
 K ERXHLDARY
 ; only set the hold reason if the eRx has a hold status and hold reason contains data
 S CURSTATE=$$GET1^DIQ(52.49,ERXIEN,1,"E")
 S (VAHSTA,VAHREA,VAHPER)=""
 S CNTR=0
 I $E(CURSTATE,1)="H" D
 . S CURSTATI=$$GET1^DIQ(52.49,ERXIEN,1,"I")
 . S LHMATCH=999999,LHFOUND=0 F  S LHMATCH=$O(^PS(52.49,ERXIEN,19,LHMATCH),-1) Q:'LHMATCH!(LHFOUND)  D
 . . S LHSTATI=$$GET1^DIQ(52.4919,LHMATCH_","_ERXIEN_",",.02,"I") I LHSTATI=CURSTATI D  S LHFOUND=LHMATCH Q
 . . . S VAHSTA=$$GET1^DIQ(52.45,LHSTATI,.01,"E")_" - "_$$GET1^DIQ(52.45,LHSTATI,.02,"E"),CNTR=CNTR+1,ERXHLDARY($J,CNTR)=VAHSTA
 . . . S VAHPER=$$GET1^DIQ(52.4919,LHMATCH_","_ERXIEN_",",.03,"E"),CNTR=CNTR+1,ERXHLDARY($J,CNTR)=VAHPER
 . . . S VAHREA=$$GET1^DIQ(52.4919,LHMATCH_","_ERXIEN_",",1),CNTR=CNTR+1,ERXHLDARY($J,CNTR)=VAHREA
 I CNTR<1 S ERXHLDARY($J,0)=""
 Q $G(CNTR)
 ;
GETERXRDT(ERXIEN) ;Retrieve the eRx Received Date time stamp
 ; Input : ERXIEN  - Pointer to ERX HOLDING QUEUE file (#52.49)
 ; Output: ERXRADT - eRx Recieved Date time stamp^accepted by^date accepted
 ;                   Example: 1/19/24@14:05^LASTNAME,FIRSTNAME^9/26/24@10:30
 N ACCDTBY,ERXRADT
 Q:'$G(ERXIEN) ""
 S ACCDTBY=$$ACCDTBY^PSOERUT4(ERXIEN)
 S ERXRADT=$P($$FMTE^XLFDT($$GET1^DIQ(52.49,ERXIEN,.03,"I"),"2Y"),":",1,2)
 S ERXRADT=ERXRADT_"^"_$E($P(ACCDTBY,"^",2),1,17)_"^"_$P($P(ACCDTBY,"^",1),":",1,2)
 Q $G(ERXRADT)
 ;
REF ;Screen Refresh
 I $D(VALMEVL) F I=1:1:99 D RESTORE^VALM10(I)
 D HDR,INIT S VALMBCK="R"
 Q
 ;
VO ; View Original eRx Action
 N ORERXIEN,ERX
 S ORERXIEN=$$RELERX(ERXIEN,"N")
 I ORERXIEN S (ERXIEN,PSOIEN)=ORERXIEN
 E  I ORERXIEN=0 S VALMSG="No Original eRx Found" S VALMBCK="R" W $C(7) Q
 D REF
 Q
 ;
VRR ; View Request
 N RRERXIEN,ERX
 S RRERXIEN=$$RELERX(ERXIEN,"RR,CR,CA")
 I RRERXIEN S (ERXIEN,PSOIEN)=RRERXIEN
 E  I RRERXIEN=0 S VALMSG="No Request eRx Found" S VALMBCK="R" W $C(7) Q
 D REF
 Q
 ;
VRE ; View Request Response
 N REERXIEN,ERX
 S REERXIEN=$$RELERX(ERXIEN,"RE,CN,CX")
 I REERXIEN S (ERXIEN,PSOIEN)=REERXIEN
 E  I REERXIEN=0 S VALMSG="No Response eRx Found" S VALMBCK="R" W $C(7) Q
 D REF
 Q
 ;
RELERX(ERXIEN,MSGTYPE) ; Returns the Selected Related eRx IEN
 ; Input: ERXIEN  - Pointer to ERX HOLDING QUEUE (#52.49)
 ;        MSGTYPE - Relation types ("N":NewRx;"RR,CR,CA":Request;"RE,CN,CX":Response)
 ;Output: RELERX  - Selected Related eRx (Original, Response, Request) - Pointer to #52.49 (0 if not found)
 N ERX,ERXARR,TMPARR,X,Y,DTOUT,DIROUT,SEQ,DIR,XX,RERX,REQIEN,RESIEN,ORIGIEN,MTYPE
 S (SEQ,ERX)=0
 F  S ERX=$O(^PS(52.49,ERXIEN,201,"B",ERX)) Q:'ERX  D
 . I ERX'=ERXIEN,'$D(TMPARR(ERX)),","_MSGTYPE_","[(","_$$GET1^DIQ(52.49,ERX,.08,"I")_",") D
 . . S SEQ=SEQ+1,ERXARR(SEQ)=ERX,TMPARR(ERX)=""
 . E  S RERX=0 F  S RERX=$O(^PS(52.49,ERX,201,"B",RERX)) Q:'RERX  D
 . . I RERX'=ERXIEN,'$D(TMPARR(RERX)),","_MSGTYPE_","[(","_$$GET1^DIQ(52.49,RERX,.08,"I")_",") D
 . . . S SEQ=SEQ+1,ERXARR(SEQ)=RERX,TMPARR(RERX)=""
 ;
 I '$D(ERXARR) D
 . S MTYPE=$$GET1^DIQ(52.49,ERXIEN,.08,"I")
 . S (ORIGIEN,REQIEN,RESIEN)=0
 . I ",RR,CR,"[(","_MTYPE_",") D
 . . S REQIEN=ERXIEN,RESIEN=$$GETRESP^PSOERXU2(ERXIEN)
 . I ",RE,CN,CX,"[(","_MTYPE_",") D
 . . S RESIEN=ERXIEN,REQIEN=$$RESOLV^PSOERXU2(ERXIEN)
 . I MTYPE="CA",MSGTYPE="N" D
 . . S ORIGIEN=$$RESOLV^PSOERXU2(ERXIEN)
 . I MTYPE="IE" D
 . . S RESIEN=ERXIEN,REQIEN=$$RESOLV^PSOERXU2(ERXIEN)
 . I $G(REQIEN),$$GET1^DIQ(52.49,REQIEN,.14) D
 . . S ORIGIEN=+$O(^PS(52.49,"B",+$$GET1^DIQ(52.49,REQIEN,.14),0))
 . I MSGTYPE="N",$G(ORIGIEN),ORIGIEN'=ERXIEN S SEQ=SEQ+1,ERXARR(SEQ)=ORIGIEN
 . I MSGTYPE="RR,CR,CA",$G(REQIEN) S SEQ=SEQ+1,ERXARR(SEQ)=REQIEN
 . I MSGTYPE="RE,CN,CX",$G(RESIEN) S SEQ=SEQ+1,ERXARR(SEQ)=RESIEN
 ;
 I '$D(ERXARR) Q 0
 I '$D(ERXARR(2)) Q $G(ERXARR(1))
 D FULL^VALM1
 W !!,"#  ERX ID",?22,"ERX TYPE",?42,"STATUS",?50,"DATE/TIME"
 S XX="",$P(XX,"-",72)="" W !,XX
 S SEQ=0 F  S SEQ=$O(ERXARR(SEQ)) Q:'SEQ  D
 . S ERX=ERXARR(SEQ) W !,SEQ,?3,$$GET1^DIQ(52.49,ERX,.01),?22,$$GET1^DIQ(52.49,ERX,.08),?42,$$GET1^DIQ(52.49,ERX,1),?50,$$GET1^DIQ(52.49,ERX,.03)
 W ! S DIR(0)="L^1:"_$O(ERXARR(999),-1),DIR("A")="SELECT"
 D ^DIR I $D(DIRUT)!$D(DIROUT) Q "^"
 Q ERXARR(+Y)
 Q
 ;
DEANOTE(LINE) ;DEA Note for CS Digitally Signed eRx records
 N LINETXT
 S LINE=LINE+1 D SET^VALM10(LINE,"")
 S LINE=LINE+1,LINETXT=" This prescription meets the requirements of the Drug Enforcement Administration"
 D SET^VALM10(LINE,LINETXT),CNTRL^VALM10(LINE,1,$L(LINETXT)+1,IOINHI,IOINORM)
 S LINE=LINE+1,LINETXT=" (DEA) electronic prescribing for controlled substances rules (21 CFR Parts 1300,"
 D SET^VALM10(LINE,LINETXT),CNTRL^VALM10(LINE,1,$L(LINETXT)+1,IOINHI,IOINORM)
 S LINE=LINE+1,LINETXT=" 1304, 1306, & 1311)."
 D SET^VALM10(LINE,LINETXT),CNTRL^VALM10(LINE,2,$L(LINETXT),IOINHI,IOINORM)
 S LINE=LINE+1
 Q
 ;
VSR ; View Suggested eRx
 N SUGRX,RXIEN,DIR,DIRUT,DIROUT,Y,X,XX,PSODFN,DFN
 S VALMBCK="R"
 I '$D(^PS(52.49,+$G(ERXIEN),0)) S VALMSG="There are no suggested VistA Rx for this eRx" Q
 S SUGRX=$$GET1^DIQ(52.49,ERXIEN,.15,"I") I 'SUGRX S VALMSG="There are no suggested VistA Rx for this eRx" Q
 D FULL^VALM1 W !
 S $P(XX,$S($D(IOUON):" ",1:"-"),81)="",$E(XX,37,42)="NOTICE" W !,$G(IOUON),XX,$G(IOUOFF)
 W !,"You will be taken to the VistA prescription that was used to pre-populate the"
 W !,"Drug fields (Product/SIG/Qty/Days Supply/# of Refills/Substitution) for this"
 W !,"eRx (aka,'Suggested VistA Rx'). This VistA Rx may or may not be for the same"
 W !,"patient in this eRx being processed."
 S XX="",$P(XX,$S($D(IOUON):" ",1:"-"),81)="" W !,$G(IOUON),XX,$G(IOUOFF)
 K DIR S DIR(0)="E" D ^DIR I $D(DIRUT)!$D(DIROUT) Q
 S RXIEN=SUGRX,XQORNOD(0)="" D VIEW^PSOSPML4 D FULL^VALM1
 Q
