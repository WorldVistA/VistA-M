BPSVRX ;ALB/ESG - View ECME Prescription ;5/23/2011
 ;;1.0;E CLAIMS MGMT ENGINE;**11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference to $$RXBILL^IBNCPUT3 supported by IA #5355
 ; Reference to RX^PSO52API supported by IA #4820
 ; Reference to $$RXNUM^PSOBPSU2 supported by IA #4970
 ; Reference to DIC^PSODI supported by IA #4858
 ; Reference to DIQ^PSODI supported by IA #4858
 ; Reference to $$CTRL^XMXUTIL1 supported by IA #2735
 ; Reference to $$TRIM^XLFSTR supported by IA #10104
 ;
 N VALMCNT,VALMQUIT,VALMBG,BPSVRXCLM,DFN,RXIEN,FILL,VIEWTYPE
 D EN^VALM("BPS VIEW ECME RX")
 K BPSVRX
 Q
 ;
HDR ; -- header code
 N V1,V2,VADM,DFN,VA,VAERR
 S RXIEN=$G(RXIEN),FILL=$G(FILL)
 S V1=$$LJ^XLFSTR("Rx#: "_$$RXNUM^BPSSCRU2(RXIEN)_"/"_FILL,19)
 S V1=V1_$$LJ^XLFSTR("ECME#: "_$P($$CLAIM^BPSBUTL(RXIEN,FILL),U,6),21)
 S V1=V1_"Drug: "_$E($$RXAPI1^BPSUTIL1(RXIEN,6),1,34)
 S VALMHDR(1)=V1
 ;
 S DFN=+$$RXAPI1^BPSUTIL1(RXIEN,2,"I")
 D DEM^VADPT
 S V2=$$LJ^XLFSTR("Patient: "_$E($G(VADM(1)),1,30)_" ("_$G(VA("BID"))_")",48)
 S V2=V2_$$LJ^XLFSTR("Sex: "_$P($G(VADM(5)),U,1),8)
 S V2=V2_$$LJ^XLFSTR("DOB: "_$$FMTE^XLFDT($P($G(VADM(3)),U,1),"2Z")_" ("_$G(VADM(4))_")",22)
 S VALMHDR(2)=V2
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- ListManager exit code
 K ^TMP("BPSVRX",$J)
 Q
 ;
INIT(BPSVRX) ; ListManager entry point
 N BPSVRXQ,BPSFL
 ;
 ; Array entries may or may not be set-up by external calling applications.
 ;
 ; BPSVRX("RXIEN") - Rx ien
 ; BPSVRX("FILL#") - fill#
 ;
 ; All array entries are optional.  If not defined, then the system will prompt the user.  First thing to do
 ; is figure out what data is defined upon entry to this routine.
 ;
 ; check Rx
 S RXIEN=+$G(BPSVRX("RXIEN"))
 I 'RXIEN K BPSVRX G INIT1   ; no Rx
 I $$RXAPI1^BPSUTIL1(RXIEN,.01,"E")="" K BPSVRX G INIT1   ; invalid Rx
 S DFN=+$$RXAPI1^BPSUTIL1(RXIEN,2,"I")
 I 'DFN K BPSVRX,DFN G INIT1   ; invalid patient ien
 ;
 ; RXIEN is good, check fill#
 S FILL=$G(BPSVRX("FILL#"))
 I FILL="" G INIT2   ; rx is OK, fill# is not known
 I FILL=0 G INIT3    ; rx is OK, original fill OK
 I $$RXSUBF1^BPSUTIL1(RXIEN,52,52.1,FILL,.01,"I") G INIT3   ; fill OK - fill date found in 52.1
 D RFL(RXIEN,.BPSFL) I $D(BPSFL(FILL)) G INIT3   ; fill OK - found in BPS Transaction
 ;
 ; fill# is not valid so prompt for it
 G INIT2
 ;
 ;-------------------------------------------------
 ;
INIT1 ; internal branch point to perform all prompts (Rx, fill#, view type)
 S RXIEN=$$RXP()
 I $G(BPSVRXQ) S VALMQUIT=1 G INITX
 S DFN=+$P(RXIEN,U,2),RXIEN=+$P(RXIEN,U,1)
 I 'RXIEN!'DFN S VALMQUIT=1 G INITX
 ;
INIT2 ; internal branch point for fill# prompt and view type prompt
 S FILL=$$FILLP(RXIEN,DFN)
 I $G(BPSVRXQ) S VALMQUIT=1 G INITX
 I FILL="" S VALMQUIT=1 G INITX
 ;
INIT3 ; internal branch point for view type prompt
 S VIEWTYPE=$$VTP(RXIEN,FILL)
 I $G(BPSVRXQ) S VALMQUIT=1 G INITX
 I VIEWTYPE'="M",VIEWTYPE'="A" S VALMQUIT=1 G INITX
 ;
 ; Build list
 D BUILD(RXIEN,FILL,VIEWTYPE)
 ;
INITX ; finished with the INIT code to initially build the list
 Q
 ;
RXP() ; prompt the user to enter the prescription
 ; output value of function is RXIEN^DFN
 ; return BPSVRXQ=1 to exit option
 ;
 N RXIEN,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,DIC,DR,DA,D0,DIQ,BPSRXD,PSODIY,RXN,DFN,PNM,DRUG,RXST
RXPR ;
 S RXIEN="",DFN=""
 S DIR(0)="FAO"
 S DIR("A")="Select Prescription: "
 S DIR("?",1)=" A prescription number or ECME number may be entered.  To look-up a"
 S DIR("?",2)=" prescription by the ECME number, please enter ""E."" followed by the ECME"
 S DIR("?")=" number with or without any leading zeros."
 W ! D ^DIR K DIR
 I X=""!$D(DIRUT) S BPSVRXQ=1 G RXPX
 S X=$$UP^XLFSTR(X)
 ;
 ; ECME# lookup
 I $E(X,1,2)="E." S RXIEN=+$$RXNUM^PSOBPSU2($E(X,3,$L(X))) G RXP1     ; DBIA #4970
 ;
 ; Rx# lookup
 S DIC=52
 S DIC(0)="E"
 S DIC("S")="I $P($G(^(0)),U,2),$D(^(""STA"")),$P($G(^(""STA"")),U,1)'=13"
 W ! D DIC^PSODI(52,.DIC,X) K DIC    ; DBIA# 4858
 S RXIEN=+Y
 ;
RXP1 ;
 ;
 I RXIEN'>0 W "   Invalid selection. Please try again.",$C(7) G RXPR    ; start over
 ;
 ; Display Rx data and get confirmation to proceed
 S DIC=52,DR=".01;2;6;100",DA=RXIEN,DIQ="BPSRXD",DIQ(0)="IE"
 D DIQ^PSODI(52,DIC,DR,DA,.DIQ)    ; DBIA# 4858
 S RXN=$G(BPSRXD(52,DA,.01,"E"))
 S DFN=+$G(BPSRXD(52,DA,2,"I"))
 S PNM=$G(BPSRXD(52,DA,2,"E"))
 S DRUG=$G(BPSRXD(52,DA,6,"E"))
 S RXST=$G(BPSRXD(52,DA,100,"E"))
 W !!?1,"Patient",?25,"Rx#",?37,"Drug Name",?63,"Rx Status"
 W !?1,$E(PNM,1,23),?25,RXN,?37,$E(DRUG,1,25),?63,$E(RXST,1,16),!
 ;
 I $$YESNO^BPSSCRRS("OK to continue","Yes")<1 G RXPR    ; start over
 ;
RXPX ;
 Q RXIEN_U_DFN
 ;
FILLP(RXIEN,DFN) ; prompt for a fill# given the RXIEN and DFN
 ; return BPSVRXQ=1 to exit option
 ;
 N FILL,BPFLZ,RF,FLDT,RELDT,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,CNT,BSTR,BPSFL
 S FILL=""
 I '$G(RXIEN)!'$G(DFN) G FILLX
 ;
 K ^TMP($J,"BPSP"),BPFLZ
 D RX^PSO52API(DFN,"BPSP",RXIEN,,"2,R")    ; DBIA# 4820
 S RF=0 F  S RF=$O(^TMP($J,"BPSP",DFN,RXIEN,"RF",RF)) Q:'RF  D
 . S FLDT=+$G(^TMP($J,"BPSP",DFN,RXIEN,"RF",RF,.01))\1   ; fill date
 . S RELDT=+$G(^TMP($J,"BPSP",DFN,RXIEN,"RF",RF,17))\1   ; release date
 . S BPFLZ(RF)=FLDT_U_RELDT
 . Q
 ;
 ; add original fill date and original release date to local array
 S FLDT=+$G(^TMP($J,"BPSP",DFN,RXIEN,22))\1    ; original fill date
 S RELDT=+$G(^TMP($J,"BPSP",DFN,RXIEN,31))\1   ; original release date
 S BPFLZ(0)=FLDT_U_RELDT
 ;
 ; check for any deleted fills that have ECME activity
 D RFL(RXIEN,.BPSFL)
 S RF="" F  S RF=$O(BPSFL(RF)) Q:RF=""  I '$D(BPFLZ(RF)) S BPFLZ(RF)=0_U_0
 ;
 S DIR(0)="S"
 S DIR("L",1)="Rx# "_$G(^TMP($J,"BPSP",DFN,RXIEN,.01))_" has the following fills:"
 S DIR("L",2)=""
 S DIR("L",3)="    Fill#   Fill Date     Release Date"
 S DIR("L",4)="    -----   ----------    ------------"
 S CNT=0,BSTR=""
 S RF="" F  S RF=$O(BPFLZ(RF)) Q:RF=""  D
 . S CNT=CNT+1
 . S FLDT=$$FMTE^XLFDT($P(BPFLZ(RF),U,1),"5Z") I 'FLDT S FLDT="    -     "
 . S RELDT=$$FMTE^XLFDT($P(BPFLZ(RF),U,2),"5Z") I 'RELDT S RELDT="    -     "
 . I 'FLDT,'RELDT S (FLDT,RELDT)=" Deleted  "
 . S $P(BSTR,";",CNT)=RF_":"_FLDT_"    "_RELDT
 . S DIR("L",CNT+4)=$J(RF,7)_"     "_FLDT_"    "_RELDT
 . Q
 S DIR("L")=" "
 S $P(DIR(0),U,2)=BSTR
 S DIR("A")="Select Fill Number"
 I CNT=1 D
 . S DIR("B")=$O(BPFLZ(""))     ; default if there is only 1 fill
 . S $P(DIR("L",1)," ",$L(DIR("L",1)," "))="fill:"    ; singular
 . Q
 W ! D ^DIR K DIR
 I Y=""!$D(DIRUT) S BPSVRXQ=1 G FILLX
 S FILL=Y
 ;
FILLX ;
 K ^TMP($J,"BPSP")
 Q FILL
 ;
VTP(RXIEN,FILL) ; prompt for the view type of this report
 ; Most recent ECME transaction or All ECME transactions
 ; Output value of function is "M" or "A".
 ; return BPSVRXQ=1 to exit option
 ;
 N VIEWTYPE,TOT,COB,IEN59,BP57,T1,T2,T3,MTXT,ATXT,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 N BPSVRXIB,IBIFN,IBC,IBA,IB,BPSVRXCAN
 S VIEWTYPE=""
 I '$G(RXIEN) G VTPX
 I $G(FILL)="" G VTPX
 ;
 ; count up the number of ECME transactions on file (total and by COB)
 K TOT
 F COB=1:1:3 S IEN59=$$IEN59^BPSOSRX(RXIEN,FILL,COB) D
 . I IEN59="" Q
 . S BP57=0 F  S BP57=$O(^BPSTL("B",IEN59,BP57)) Q:'BP57  S TOT=$G(TOT)+1,TOT(COB)=$G(TOT(COB))+1
 . Q
 S TOT=+$G(TOT),T1=+$G(TOT(1)),T2=+$G(TOT(2)),T3=+$G(TOT(3))
 ;
 ; if 0 ECME transactions found, then no need to ask this next question
 I TOT=0 S VIEWTYPE="M" G VTPCB
 ;
 S DIR(0)="S"
 I TOT=1 S DIR("A",1)="  There is 1 ECME transaction for this Rx/fill."
 E  S DIR("A",1)="  There are "_TOT_" ECME transactions for this Rx/fill."
 S DIR("A",2)="  "
 I T2!T3 S DIR("A",2)="  "_T1_" for the primary payer"_$S(T2:", "_T2_" for the secondary payer",1:"")_$S(T3:", "_T3_" for the tertiary payer",1:"")_".",DIR("A",3)="  "
 S MTXT="Most recent transaction"_$S(T2!T3:" for each payer",1:"")
 S ATXT="All transactions"
 S DIR("A")="Select "_MTXT_" or "_ATXT
 S DIR("B")="M"
 S $P(DIR(0),U,2)="M:"_MTXT_";A:"_ATXT
 W ! D ^DIR K DIR
 I Y=""!$D(DIRUT) S BPSVRXQ=1 G VTPX
 S VIEWTYPE=Y
 ;
VTPCB ;
 ; check for cancelled bills and ask how they should be handled
 K BPSVRXCLM
 I $$RXBILL^IBNCPUT3(RXIEN,FILL,"","",.BPSVRXIB)   ; build a list of all bills for Rx/fill# (IA #5355)
 S (IBIFN,IBC,IBA)=0 F  S IBIFN=$O(BPSVRXIB(IBIFN)) Q:'IBIFN  D
 . S IB=$G(BPSVRXIB(IBIFN))
 . I $P(IB,U,8)=7!($P(IB,U,2)="CB")!($P(IB,U,2)="CN") S IBC=IBC+1,BPSVRXCLM(IBIFN)=0 Q  ; cancelled bill
 . S IBA=IBA+1  ; non-cancelled bill
 . S BPSVRXCLM(IBIFN)=1
 . Q
 S BPSVRXCLM=IBA+IBC
 ;
 I IBC=0 G VTPX   ; no cancelled bills found so no further questions
 ;
 I IBC,IBA S DIR("A",1)="  "_IBA_" non-cancelled bill"_$S(IBA=1:"",1:"s")_" and "_IBC_" cancelled bill"_$S(IBC=1:"",1:"s")_" exist for this Rx/fill."
 I IBC,'IBA S DIR("A",1)="  "_IBC_" cancelled bill"_$S(IBC=1:"",1:"s")_", but no active bills exist for this Rx/fill."
 I IBA S DIR("A",2)="  The non-cancelled bill"_$S(IBA=1:"",1:"s")_" will automatically be included.",DIR("A",3)="  "
 I 'IBA S DIR("A",2)="  "
 S DIR("A")="Do you want to include the cancelled bill"_$S(IBC=1:"",1:"s")
 S DIR("B")="No"
 S DIR(0)="Y"
 W ! D ^DIR K DIR
 I Y=""!$D(DIRUT) S BPSVRXQ=1 G VTPX
 S BPSVRXCAN=Y
 ;
 ; If the user wants cancelled bills, then no changes to the BPSVRXCLM list are needed so get out
 I BPSVRXCAN G VTPX
 ;
 ; If the user does not want cancelled bills, then remove them from the BPSVRXCLM list
 S IBIFN=0 F  S IBIFN=$O(BPSVRXCLM(IBIFN)) Q:'IBIFN  I 'BPSVRXCLM(IBIFN) K BPSVRXCLM(IBIFN)
 S BPSVRXCLM=IBA
 ;
VTPX ;
 Q VIEWTYPE
 ;
BUILD(RXIEN,FILL,VIEWTYPE) ; build list
 ; This is called in the INIT section to build the ListMan scratch global
 ; all parameters are required and must exist when this is called
 ;
 S BPSVRX=1   ; special variable indicating this is the driver routine
 I '$D(ZTQUEUED) W !
 K ^TMP("BPSVRX",$J)    ; initialize display array
 ;
 D VIEWRX^BPSVRX1(RXIEN,FILL,VIEWTYPE,1)            ; View Prescriptions [PSO VIEW]
 D LOG^BPSVRX1(RXIEN,FILL,VIEWTYPE,2)               ; ECME Print Claim Log
 D BILL^BPSVRX1(RXIEN,FILL,VIEWTYPE,3)              ; IB ECME Billing Events Report
 D CRI^BPSVRX1(RXIEN,FILL,VIEWTYPE,4)               ; ECME Claims-Response Inquiry Report
 D INS^BPSVRX1(RXIEN,FILL,VIEWTYPE,5)               ; View Pharmacy Insurance policies
 D TPJILST^BPSVRX1(RXIEN,FILL,VIEWTYPE,6)           ; List of TPJI-eligible bills
 D TPJICI^BPSVRX1(RXIEN,FILL,VIEWTYPE,7)            ; TPJI - Claim Information
 D TPJIARP^BPSVRX1(RXIEN,FILL,VIEWTYPE,8)           ; TPJI - AR Account Profile
 D TPJIARCH^BPSVRX1(RXIEN,FILL,VIEWTYPE,9)          ; TPJI - AR Comment History
 D TPJIECME^BPSVRX1(RXIEN,FILL,VIEWTYPE,10)         ; TPJI - ECME Rx Response Info
 D DGELST^BPSVRX2(RXIEN,FILL,VIEWTYPE,11)           ; View Registration Elig Status
 D DGELV^BPSVRX2(RXIEN,FILL,VIEWTYPE,12)            ; View Registration Elig Verification
 ;
BUILDX ;
 Q
 ;
NAV(SNUM) ; ListMan nav jumping
 S VALMBG=$G(BPSVRX("LISTNAV",SNUM),1)   ; default to 1 if not defined
NAVX ;
 Q
 ;
UPDATE(DISP,HDR,TITLE,NAME,SNUM) ; update the BPSVRX ListMan display array
 ;  DISP - display array to be merged into ^TMP("BPSVRX",$J)
 ;         Assmues display lines are found in @DISP@(N,0)
 ;   HDR - header data array (i.e. VALMHDR data); HDR(1)=line 1; HDR(2)=line 2; etc.
 ; TITLE - title of section (i.e. VALM("TITLE")
 ;  NAME - name/description of section being added (required)
 ;  SNUM - section number used for ListMan navigational jumps (required)
 ;
 N LN,Z,NODATA,BPSVID
 ;
 S LN=+$O(^TMP("BPSVRX",$J,""),-1)   ; last line# used in display array
 ;
 ; display name of section centered and reverse video
 I $G(NAME)'="" D
 . S LN=LN+1,^TMP("BPSVRX",$J,LN,0)=$$CJ^XLFSTR(NAME,80)
 . D CNTRL^VALM10(LN,1,80,IORVON,IORVOFF)  ; reverse video line
 . I '$D(BPSVRX("LISTNAV",SNUM)) S BPSVRX("LISTNAV",SNUM)=LN   ; store 1st line# of each section
 . Q
 ;
 ; merge in the ListMan title if one exists
 I $G(TITLE)'="" D
 . S LN=LN+1,^TMP("BPSVRX",$J,LN,0)=$$FLN(LN,TITLE)
 . D CNTRL^VALM10(LN,1,80,IOUON,IOUOFF)    ; display a line under the title
 . Q
 ;
 ; merge in header data if this array exists
 I $O(HDR(0)) D
 . S Z=0 F  S Z=$O(HDR(Z)) Q:'Z  S LN=LN+1,^TMP("BPSVRX",$J,LN,0)=$$FLN(LN,$G(HDR(Z)))
 . D CNTRL^VALM10(LN,1,80,IOUON,IOUOFF)    ; display a line under the header data
 . Q
 ;
 ; merge in display array
 S BPSVID="VALM VIDEO"
 I DISP="" S DISP="NODATA"
 S Z=0 F  S Z=$O(@DISP@(Z)) Q:'Z  S LN=LN+1,^TMP("BPSVRX",$J,LN,0)=$G(@DISP@(Z,0)) D
 . ; check for video attributes to be duplicated
 . I '$D(^TMP(BPSVID,$J,999,Z)) Q  ; no video attributes on this line
 . M ^TMP(BPSVID,$J,VALMEVL,LN)=^TMP(BPSVID,$J,999,Z)   ; copy video attributes
 . K ^TMP(BPSVID,$J,999,Z)   ; clean-up
 . Q
 ;
 ; display a message if no data found for this section
 I '$O(@DISP@(0)) D
 . S LN=LN+1,^TMP("BPSVRX",$J,LN,0)="   "
 . S LN=LN+1,^TMP("BPSVRX",$J,LN,0)="       <No data found for this section>"
 . S LN=LN+1,^TMP("BPSVRX",$J,LN,0)="   "
 . Q
 ;
 ; update the number of lines in the list
 S VALMCNT=LN
 ;
UPDX ;
 Q
 ;
FLN(LINE,DATA) ; format line# LINE by reproducing any video attributes found in string DATA
 N VARON,VAROFF,FINDON,FINDOFF,COL,WIDTH
 ;
 F VARON="IOBON","IORVON","IOUON","IOINHI" D   ; on attribute
 . S VAROFF=$S(VARON="IOBON":"IOBOFF",VARON="IORVON":"IORVOFF",VARON="IOUON":"IOUOFF",1:"IOINORM")  ; off attribute
 . F  S FINDON=$F(DATA,@VARON) Q:'FINDON  D
 .. S COL=FINDON-$L(@VARON)      ; starting column for video attribute
 .. S FINDOFF=$F(DATA,@VAROFF)   ; see if off attribute is also found
 .. I FINDOFF S WIDTH=FINDOFF-COL-$L(@VARON)-$L(@VAROFF)    ; width of affected text between on and off attributes
 .. I 'FINDOFF S WIDTH=$L(DATA)-COL-$L(@VARON)              ; width of affected text (thru the end of the string)
 .. D CNTRL^VALM10(LINE,COL,WIDTH,@VARON,@VAROFF)           ; save the video attribute using Listman API
 .. S DATA=$P(DATA,@VARON,1)_$P(DATA,@VARON,2,999)                  ; remove 1st on attribute
 .. I FINDOFF S DATA=$P(DATA,@VAROFF,1)_$P(DATA,@VAROFF,2,999)      ; remove 1st off attribute
 .. Q
 . Q
 I DATA="" S DATA="    "  ; blank lines need to be non-nil so video attributes may exist for them
FLNX ;
 Q DATA
 ;
HFS(SECTION,RTN,VRXHDR,HDRARY,BPSVRXKQ) ; output data to scratch host file and merge into ListMan display array
 ;  SECTION - section code (e.g. "BER" - billing events report, "CRI" - claims-response inquiry)
 ;      RTN - tag^routine to invoke to produce the report
 ;   VRXHDR - name of section to appear at the start of the display
 ;   HDRARY - header array
 ; BPSVRXKQ - section#
 ;
 N BPSHANDLE,BPSVDIR,BPSVFILE,HDR,POP,GLO,BPSARR,BVZ,BV1
 ;
 ; create a host file to write the data
 S SECTION="BPSVRX_"_$G(SECTION)
 S BPSHANDLE=SECTION_"_"_$J
 S BPSVDIR=$$DEFDIR^%ZISH()
 S BPSVFILE=BPSHANDLE_".RPT"
 I BPSVDIR="" D  G HFSX
 . S HDR(1)="Error: Default directory is blank."
 . S HDR(2)="Please define one in the KERNEL SYSTEM PARAMETERS."
 . D UPDATE("",.HDR,"",VRXHDR,BPSVRXKQ)
 . Q
 ;
 D OPEN^%ZISH(BPSHANDLE,BPSVDIR,BPSVFILE,"W")
 I POP D  G HFSX
 . S HDR(1)="Error: Unable to open scratch data file for writing."
 . S HDR(2)="Directory="_BPSVDIR
 . S HDR(3)="Filename="_BPSVFILE
 . D UPDATE("",.HDR,"",VRXHDR,BPSVRXKQ)
 . Q
 ;
 U IO                      ; use the file
 S IOM=80,IOSL=100000      ; 80 char width and long screen
 D @RTN                    ; create the report
 D CLOSE^%ZISH(BPSHANDLE)  ; close the data file
 ;
 ; move contents of scratch data file to scratch global
 S GLO=$NA(^TMP($J,SECTION,1,0))
 K ^TMP($J,SECTION)
 I '$$FTG^%ZISH(BPSVDIR,BPSVFILE,GLO,3) D  G HFSX
 . S HDR(1)="Error: Unable to read in the contents of the scratch data file."
 . S HDR(2)="Directory="_BPSVDIR
 . S HDR(3)="Filename="_BPSVFILE
 . S HDR(4)="Destination="_GLO
 . D UPDATE("",.HDR,"",VRXHDR,BPSVRXKQ)
 . Q
 ;
 ; delete the scratch data file
 S BPSARR(BPSVFILE)=""
 I $$DEL^%ZISH(BPSVDIR,$NA(BPSARR))
 ;
 ; remove "PAGE 1" line from the beginning of the display data
 F BVZ=1:1:10 I $$TRIM^XLFSTR($G(^TMP($J,SECTION,BVZ,0)))="PAGE 1" K ^TMP($J,SECTION,BVZ,0)
 ;
 ; remove all control characters and trailing spaces from all lines
 S BVZ=0 F  S BVZ=$O(^TMP($J,SECTION,BVZ)) Q:'BVZ  S BV1=$G(^TMP($J,SECTION,BVZ,0)),BV1=$$CTRL^XMXUTIL1(BV1),BV1=$$TRIM^XLFSTR(BV1,"R"),^TMP($J,SECTION,BVZ,0)=BV1    ; DBIAs #2735, #10104
 ;
 ; update BPSVRX display array
 S GLO=$NA(^TMP($J,SECTION))
 D UPDATE(GLO,.HDRARY,"",VRXHDR,BPSVRXKQ)
 K ^TMP($J,SECTION)   ; clean up scratch global
 ;
HFSX ;
 Q
 ;
RFL(RXIEN,FILLIST) ; Return a list of all ECME fill#s for the Rx
 N BP59,FL
 K FILLIST
 S RXIEN=+$G(RXIEN) I 'RXIEN G RFLX
 S BP59=RXIEN F  S BP59=$O(^BPST(BP59)) Q:$P(BP59,".",1)'=RXIEN  S FL=$P($G(^BPST(BP59,1)),U,1) I FL'="" S FILLIST(FL)=BP59
RFLX ;
 Q
 ;
VER ; Selection from the ECME User Screen
 N BPSG,RXREF,BPSVRX
 D FULL^VALM1
 W !,"Enter the claim line number for the View ePharmacy Rx report."
 S BPSG=$$ASKLINE^BPSSCRU4("Select item","C","Please select SINGLE Rx Line.")
 I BPSG<1 G VERX
 S RXREF=$$RXREF^BPSSCRU2(+$P(BPSG,U,4))
 S BPSVRX("RXIEN")=$P(RXREF,U,1)
 S BPSVRX("FILL#")=$P(RXREF,U,2)
 D ^BPSVRX
VERX ;
 S VALMBCK="R"
 Q
 ;
