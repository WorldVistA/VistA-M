BPSVRX1 ;ALB/ESG - View ECME Prescription continued ;5/23/2011
 ;;1.0;E CLAIMS MGMT ENGINE;**11**;JUN 2004;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference to ^IBCNR(366.14, supported by DBIA #5711
 ; Reference to PRINT^IBNCPEV supported by DBIA #5712
 ; Reference to IBDSP^IBJTU6 supported by DBIA #5713
 ; Reference to RXINS^IBNCPDPU supported by DBIA #5714
 ; Reference to $$RXBILL^IBNCPUT3 supported by DBIA #5355
 ; Reference to RX^PSO52API supported by DBIA #4820
 ; Reference to DP^PSORXVW supported by DBIA #4711
 ;
 Q
 ;
VIEWRX(RXIEN,FILL,VIEWTYPE,BPSSNUM) ; View Prescriptions [PSO VIEW]
 I '$D(ZTQUEUED) W !,"Compiling data for View Prescriptions ... "
 N DA,PSOVDA,PS,VALMHDR,VALM
 N %,%H,%I,DAT,DFN,DIC,DIR,DIRUT,DUOUT,DTOUT,DN,DTT,EXDT,FFX,GMRA,GMRAL,HDR
 N I,II,IFN,J,L1,LBL,LENGTH,MED,M1,N,OUT,P0,P1,PHYS,PL,POERR,PSDIV,PSEXDT
 N PSOAL,PSOBCK,PSODFN,PSOHD,PSOELSE,PSONOAL,PTST,R3,REA,REFL,RF,RFDATE,RFL
 N RFL1,RFLL,RFT,RLD,RN,RTN,RX0,RX2,RX3,RXN,RXOR,SG,SIG,SIGOK,ST,STA,VA,VACNTRY
 N VADM,VAERR,VAPA,X,Y,Z,Z0,Z1,ZD
 ;
 S (DA,PSOVDA)=RXIEN,PS="VIEW"
 K ^TMP("PSOHDR",$J),^TMP("PSOAL",$J)
 D
 . N BPSSNUM,VALMEVL S VALMEVL=999
 . D DP^PSORXVW   ; DBIA #4711
 . Q
 D UPDATE^BPSVRX($NA(^TMP("PSOAL",$J)),.VALMHDR,$G(VALM("TITLE")),"View Prescription Data",BPSSNUM)
 K ^TMP("PSOHDR",$J),^TMP("PSOAL",$J)
 ;
VIEWX ;
 Q
 ;
LOG(RXIEN,FILL,VIEWTYPE,BPSSNUM) ; ECME Print Claim Log
 I '$D(ZTQUEUED) W !,"Compiling data for the ECME Claim Log ... "
 N BPSVRXCOB,BPSINSCT
 ;
 ; initially count up how many insurances we're dealing with
 S BPSINSCT=0
 F BPSVRXCOB=1:1:3 D
 . N IEN59
 . S IEN59=$$IEN59^BPSOSRX(RXIEN,FILL,BPSVRXCOB) Q:'$D(^BPST(IEN59,0))
 . S BPSINSCT=BPSINSCT+1
 . Q
 ;
 I 'BPSINSCT D UPDATE^BPSVRX("","","","ECME Claim Log Data",BPSSNUM) G LOGX   ; no data found
 ;
 F BPSVRXCOB=1:1:3 D
 . N IEN59,DFN,INS,VRXHDR,LINE,VALMHDR,VALMAR,INSSEQ
 . S IEN59=$$IEN59^BPSOSRX(RXIEN,FILL,BPSVRXCOB) Q:'$D(^BPST(IEN59,0))
 . S DFN=+$P($G(^BPST(IEN59,0)),U,6) Q:'DFN
 . S INS=+$P($G(^BPST(IEN59,10,+$G(^BPST(IEN59,9)),3)),U,5)   ; ins co ien
 . I 'INS S INS=+$$INSNAM^BPSRPT6(IEN59)  ; ins co ien alternative
 . Q:'INS
 . S INSSEQ=$S(BPSVRXCOB=1:"Primary",BPSVRXCOB=2:"Secondary",1:"Tertiary")
 . S VRXHDR="ECME Claim Log Data"
 . I BPSINSCT>1 S VRXHDR=VRXHDR_" - "_INSSEQ_" Insurance"   ; only if multiple payers
 . S VALMAR=$NA(^TMP("BPSLOG",$J,"VALM"))
 . K @VALMAR
 . S LINE=1
 . D
 .. N BPLNCNT,BPSVRXCOB,BPADDMSG,RXIEN,FILL,BPSSNUM,VRXHDR,BPL,D0,VA,VAERR,X,Y    ; protect variables
 .. N VALMEVL S VALMEVL=999
 .. S BPLNCNT=$$PREPINFO^BPSSCRLG(.LINE,DFN,INS,IEN59)           ; build ECME claim log listman array
 .. Q
 . D HDR^BPSSCRLG   ; listman header array for this list
 . D UPDATE^BPSVRX(VALMAR,.VALMHDR,"",VRXHDR,BPSSNUM)
 . K @VALMAR
 . Q
 ;
LOGX ;
 Q
 ;
BILL(RXIEN,FILL,VIEWTYPE,BPSSNUM) ; IB ECME Billing Events Report (DBIA# 5711 for global reference to file 366.14)
 I '$D(ZTQUEUED) W !,"Compiling data for the ECME Billing Events Report ... "
 ;
 N REF,IBDTIEN,IBEVNT,VRXHDR,IB1ST,IBFN,IBI,IBN,IBNUM,IBRX1,SCR,D0,PSSDIY,X,Y
 N IBSCR,IBQ,IBPAGE,IBBDT,IBEDT,IBDTL,IBDIVS,IBM1,IBM2,IBM3,IBRX,IBSC,IBNB
 S REF=$NA(^TMP($J,"IBNCPDPE"))
 K @REF   ; init scratch global for compiling
 S VRXHDR="ECME Billing Events Report Data"
 ;
 S IBDTIEN=0 F  S IBDTIEN=$O(^IBCNR(366.14,"I",RXIEN,IBDTIEN)) Q:'IBDTIEN  D
 . S IBEVNT=0 F  S IBEVNT=$O(^IBCNR(366.14,"I",RXIEN,IBDTIEN,IBEVNT)) Q:'IBEVNT  D
 .. I FILL'=$P($G(^IBCNR(366.14,IBDTIEN,1,IBEVNT,2)),U,3) Q   ; fill# check
 .. S @REF@(RXIEN,FILL,IBDTIEN,IBEVNT)=""   ; save into scratch global
 .. Q
 . Q
 ;
 I '$D(@REF) D UPDATE^BPSVRX("","","",VRXHDR,BPSSNUM) G BILLX
 ;
 ; init variables necessary for printing the report
 S (IBSCR,IBQ,IBPAGE)=0
 S IBBDT=+$O(^IBCNR(366.14,"B",0))        ; begin date
 S IBEDT=+$O(^IBCNR(366.14,"B",""),-1)    ; end date
 S IBDTL=1
 S IBDIVS=0
 S IBDIVS(0)="0^ALL"
 S IBM1="R"
 S IBM2="B"
 S IBM3="A"
 S IBRX=RXIEN
 S IBSC="STATUS CHECK"
 S IBNB="Not ECME billable: "
 ;
 D HFS^BPSVRX("BER","PRINT^IBNCPEV",VRXHDR,"",BPSSNUM)    ; save report output  DBIA #5712
 K ^TMP($J,"IBNCPDPE")   ; clean-up scratch global
 ;
BILLX ;
 Q
 ;
CRI(RXIEN,FILL,VIEWTYPE,BPSSNUM) ; ECME Claims-Response Inquiry [BPS RPT Claims Response]
 I '$D(ZTQUEUED) W !,"Compiling data for the ECME Claims-Response Inquiry (CRI) Report ... "
 ;
 N LIST,LISTX,BPSVRXCOB,BPSVRXG,BPSVRXGT,BPSINSCT
 N A,BP03,D0,ERROR,I,S,X,Y,%
 ;
 ; initially count up how many insurances we're dealing with
 S BPSINSCT=0
 F BPSVRXCOB=1:1:3 D
 . N IEN59
 . S IEN59=$$IEN59^BPSOSRX(RXIEN,FILL,BPSVRXCOB) Q:'$D(^BPST(IEN59,0))
 . S BPSINSCT=BPSINSCT+1
 . Q
 ;
 K LIST,LISTX S LIST=0
 F BPSVRXCOB=1:1:3 D
 . N IEN59
 . S IEN59=$$IEN59^BPSOSRX(RXIEN,FILL,BPSVRXCOB) Q:'$D(^BPST(IEN59,0))
 . ;
 . ; if VIEWTYPE=ALL then look at all transactions in file 9002313.57
 . I VIEWTYPE="A" D
 .. N IEN57,BP02
 .. S IEN57=0 F  S IEN57=$O(^BPSTL("B",IEN59,IEN57)) Q:'IEN57  D
 ... S BP02=+$P($G(^BPSTL(IEN57,0)),U,4)  ; claim
 ... I BP02,'$D(LISTX(BP02)) S LIST=$G(LIST)+1,LIST(LIST)=BP02_U_0_U_BPSVRXCOB,LISTX(BP02)=""
 ... ;
 ... S BP02=+$P($G(^BPSTL(IEN57,4)),U,1)  ; reversal claim
 ... I BP02,'$D(LISTX(BP02)) S LIST=$G(LIST)+1,LIST(LIST)=BP02_U_1_U_BPSVRXCOB,LISTX(BP02)=""
 ... Q
 .. Q
 . ;
 . ; otherwise just look at the most recent transactions in file 9002313.59
 . I VIEWTYPE'="A" D
 .. N BP02
 .. S BP02=+$P($G(^BPST(IEN59,0)),U,4)  ; claim
 .. I BP02,'$D(LISTX(BP02)) S LIST=$G(LIST)+1,LIST(LIST)=BP02_U_0_U_BPSVRXCOB,LISTX(BP02)=""
 .. ;
 .. S BP02=+$P($G(^BPST(IEN59,4)),U,1)  ; reversal claim
 .. I BP02,'$D(LISTX(BP02)) S LIST=$G(LIST)+1,LIST(LIST)=BP02_U_1_U_BPSVRXCOB,LISTX(BP02)=""
 .. Q
 . Q
 ;
 ; now go through the list in reverse order and generate and save the CRI reports
 S BPSVRXGT=LIST   ; total number of CRI reports
 ;
 I 'BPSVRXGT D UPDATE^BPSVRX("","","","ECME Claims-Response Inquiry Report Data",BPSSNUM)   ; no data found
 ;
 S BPSVRXG=99999 F  S BPSVRXG=$O(LIST(BPSVRXG),-1) Q:'BPSVRXG  D
 . N BPX,BP02,BPREV,COB,BPVAX,BPSCR,BPCFILE,VRXHDR,CRIHDR,HC
 . S BPX=LIST(BPSVRXG)
 . S BP02=$P(BPX,U,1)
 . S BPREV=$P(BPX,U,2)
 . S COB=$P(BPX,U,3)
 . S BPVAX=$P($G(^BPSC(BP02,0)),U,1)
 . S BPSCR=0,BPCFILE=9002313.02
 . S VRXHDR="ECME Claims-Response Inquiry Report Data  ("_(BPSVRXGT-BPSVRXG+1)_" of "_BPSVRXGT_")"
 . S HC=0
 . I BPSINSCT>1 S HC=HC+1,CRIHDR(HC)="Payer Sequence: "_$S(COB=1:"Primary",COB=2:"Secondary",1:"Tertiary")
 . I BPREV S HC=HC+1,CRIHDR(HC)="This is the Reversal Claim"
 . D
 .. N BPSVRXG,LIST,LISTX,BPSVRXGT,BPSINSCT    ; protect variables
 .. D HFS^BPSVRX("CRI","RUNRPT^BPSRCRI",VRXHDR,.CRIHDR,BPSSNUM)
 .. Q
 . Q
CRIX ;
 Q
 ;
INS(RXIEN,FILL,VIEWTYPE,BPSSNUM) ; View Pharmacy Insurance policies
 I '$D(ZTQUEUED) W !,"Compiling data for View Insurance Policies ... "
 N BPSDOS,DFN,BPSPINS,BPSINSCT,VRXHDR,BPINSCG,BPVXCOB,BPVXIEN,VALMHDR,BPSSCRG,BPSCDFN,BPSGDAN
 ;
 S BPSDOS=$$DOSDATE^BPSSCRRS(RXIEN,FILL)   ; date of service
 S DFN=+$$RXAPI1^BPSUTIL1(RXIEN,2,"I")     ; patient ien
 ;
 D RXINS^IBNCPDPU(DFN,BPSDOS,.BPSPINS)     ; DBIA #5714
 S BPSINSCT=+$G(BPSPINS)                   ; ins count of Rx policies
 ;
 S VRXHDR="Prescription Insurance Policy Data"
 I 'BPSINSCT D UPDATE^BPSVRX("","","",VRXHDR,BPSSNUM) G INSX     ; get out of here if no data found
 ;
 ; loop through Rx policies found and display policy data
 S BPINSCG=0
 S BPVXCOB="" F  S BPVXCOB=$O(BPSPINS("S",BPVXCOB)) Q:BPVXCOB=""  D
 . S BPVXIEN=0 F  S BPVXIEN=$O(BPSPINS("S",BPVXCOB,BPVXIEN)) Q:'BPVXIEN  D
 .. S BPINSCG=BPINSCG+1
 .. S BPSSCRG=$NA(^TMP("BPSVRX-INS",$J))   ; scratch global array name
 .. S BPSCDFN=BPVXIEN  ; need to protect BPVXIEN below (2.312 subfile ien)
 .. S BPSGDAN=BPSSCRG  ; need to protect BPSSCRG below (scratch global array name)
 .. ;
 .. D
 ... ; protect/clean up variables
 ... N BPINSCG,BPVXCOB,BPSINSCT,BPSSNUM,BPSPINS,BPVXIEN,BPSSCRG
 ... N VALMEVL S VALMEVL=999
 ... D IBDSP^IBJTU6(5,"",DFN,BPSCDFN,BPSGDAN,.VALMHDR)       ; DBIA #5713
 ... Q
 .. ;
 .. S VRXHDR="Prescription Insurance Policy Data"
 .. ;
 .. ; add the payer sequence indicator to the header if more than 1 ins policy is being displayed
 .. I BPSINSCT>1 D
 ... S VALMHDR($O(VALMHDR(""),-1)+1)="Payer Sequence: "_$S(BPVXCOB=1:"Primary",BPVXCOB=2:"Secondary",1:"Tertiary")
 ... S VRXHDR=VRXHDR_" ("_BPINSCG_" of "_BPSINSCT_")"
 ... Q
 .. ;
 .. D UPDATE^BPSVRX(BPSSCRG,.VALMHDR,"",VRXHDR,BPSSNUM)
 .. K @BPSSCRG,VALMHDR
 .. Q
 . Q
 ;
INSX ;
 Q
 ;
TPJILST(RXIEN,FILL,VIEWTYPE,BPSSNUM) ; List of TPJI bills - all fills
 I '$D(ZTQUEUED) W !,"Compiling the list of TPJI bills ... "
 N DFN,TPJI,RF,BPG,BPSVRXIB,IBIFN,IB,VRXHDR,LN,TPJDISP,NUM,L,FNG,FDG
 ;
 S DFN=+$$RXAPI1^BPSUTIL1(RXIEN,2,"I")
 K TPJI
 K ^TMP($J,"BPSP")
 D RX^PSO52API(DFN,"BPSP",RXIEN,,"2,R")    ; DBIA# 4820
 S RF=0 F  S RF=$O(^TMP($J,"BPSP",DFN,RXIEN,"RF",RF)) Q:'RF  D
 . ; check all refills
 . K BPG,BPSVRXIB
 . S BPG=$$RXBILL^IBNCPUT3(RXIEN,RF,"","",.BPSVRXIB)        ; DBIA #5355
 . S IBIFN=0 F  S IBIFN=$O(BPSVRXIB(IBIFN)) Q:'IBIFN  D
 .. S IB=$G(BPSVRXIB(IBIFN))
 .. I $P(IB,U,8)=7 Q                           ; cancelled bill in IB
 .. I $P(IB,U,2)="CB"!($P(IB,U,2)="CN") Q      ; cancelled bill in AR
 .. S TPJI(+$P(IB,U,7),+$P(IB,U,3),IBIFN)=IB   ; save it: fill#, date of svc, ibifn
 .. Q
 . Q
 K ^TMP($J,"BPSP")
 ;
 ; add any bills from original fill
 K BPG,BPSVRXIB
 S BPG=$$RXBILL^IBNCPUT3(RXIEN,0,"","",.BPSVRXIB)        ; DBIA #5355
 S IBIFN=0 F  S IBIFN=$O(BPSVRXIB(IBIFN)) Q:'IBIFN  D
 . S IB=$G(BPSVRXIB(IBIFN))
 . I $P(IB,U,8)=7 Q                           ; cancelled bill in IB
 . I $P(IB,U,2)="CB"!($P(IB,U,2)="CN") Q      ; cancelled bill in AR
 . S TPJI(+$P(IB,U,7),+$P(IB,U,3),IBIFN)=IB   ; save it: fill#, date of svc, ibifn
 . Q
 ;
 S VRXHDR="Non-Cancelled Bills for this Rx (all fills)"
 I '$D(TPJI) D UPDATE^BPSVRX("","","",VRXHDR,BPSSNUM) G TPJILSTX    ; no data found
 ;
 ; display array
 S LN=0 K TPJDISP
 S LN=LN+1,TPJDISP(LN,0)="  "
 S LN=LN+1,TPJDISP(LN,0)="     BILL     RX            DATE       INSURANCE         COB  PATIENT"
 S LN=LN+1,TPJDISP(LN,0)=" -------------------------------------------------------------------------------"
 S NUM=0
 S FNG="" F  S FNG=$O(TPJI(FNG)) Q:FNG=""  S FDG="" F  S FDG=$O(TPJI(FNG,FDG)) Q:FDG=""  S IBIFN=0 F  S IBIFN=$O(TPJI(FNG,FDG,IBIFN)) Q:'IBIFN  D
 . S NUM=NUM+1
 . S IB=$G(TPJI(FNG,FDG,IBIFN))
 . S L=$J(NUM,3)_"  "_$$LJ^XLFSTR($P(IB,U,1),9)_$$LJ^XLFSTR($$RXAPI1^BPSUTIL1(RXIEN,.01)_"-"_+$P(IB,U,7),14)
 . S L=L_$$LJ^XLFSTR($$FMTE^XLFDT($P(IB,U,3),"2DZ"),11)_$$LJ^XLFSTR($P(IB,U,4),19)_$P(IB,U,5)_"   "
 . S L=L_$$LJ^XLFSTR($$RXAPI1^BPSUTIL1(RXIEN,2,"E"),"18T")
 . S LN=LN+1,TPJDISP(LN,0)=L
 . Q
 S LN=LN+1,TPJDISP(LN,0)="  "
 D UPDATE^BPSVRX("TPJDISP","","",VRXHDR,BPSSNUM)
 ;
TPJILSTX ;
 Q
 ;
TPJICI(RXIEN,FILL,VIEWTYPE,BPSSNUM) ; TPJI - Claim Information
 I '$D(ZTQUEUED) W !,"Compiling data for TPJI Claim Information ... "
 N IBIFN,VALMHDR,BPSIBG,VRXHDR,BPSSCRG,BPSGDAN
 ;
 ; If no claims found
 I '$G(BPSVRXCLM) D UPDATE^BPSVRX("","","","TPJI - Claim Information",BPSSNUM) G TPJICIX
 ;
 S BPSIBG=0
 S IBIFN=0 F  S IBIFN=$O(BPSVRXCLM(IBIFN)) Q:'IBIFN  D
 . S BPSIBG=BPSIBG+1
 . S (BPSSCRG,BPSGDAN)=$NA(^TMP("BPSVRX-CI",$J))
 . ;
 . D
 .. ; protect/clean up variables
 .. N BPSIBG,BPSVRXCLM,BPSSNUM,BPSSCRG
 .. N VALMEVL S VALMEVL=999
 .. D IBDSP^IBJTU6(1,IBIFN,,,BPSGDAN,.VALMHDR)   ; DBIA #5713
 .. Q
 . ;
 . S VRXHDR="TPJI - Claim Information"
 . I BPSVRXCLM>1 S VRXHDR=VRXHDR_" ("_BPSIBG_" of "_BPSVRXCLM_")"
 . ;
 . D UPDATE^BPSVRX(BPSSCRG,.VALMHDR,"",VRXHDR,BPSSNUM)
 . K @BPSSCRG,VALMHDR
 . Q
 ;
TPJICIX ;
 Q
 ;
TPJIARP(RXIEN,FILL,VIEWTYPE,BPSSNUM) ; TPJI - AR Account Profile
 I '$D(ZTQUEUED) W !,"Compiling data for TPJI AR Account Profile ... "
 N IBIFN,VALMHDR,BPSIBG,VRXHDR,BPSSCRG,BPSGDAN
 ;
 ; If no claims found
 I '$G(BPSVRXCLM) D UPDATE^BPSVRX("","","","TPJI - AR Account Profile",BPSSNUM) G TPJIARPX
 ;
 S BPSIBG=0
 S IBIFN=0 F  S IBIFN=$O(BPSVRXCLM(IBIFN)) Q:'IBIFN  D
 . S BPSIBG=BPSIBG+1
 . S (BPSSCRG,BPSGDAN)=$NA(^TMP("BPSVRX-AR ACCT PRO",$J))
 . ;
 . D
 .. ; protect/clean up variables
 .. N BPSIBG,BPSVRXCLM,BPSSNUM,BPSSCRG
 .. N VALMEVL S VALMEVL=999
 .. D IBDSP^IBJTU6(2,IBIFN,,,BPSGDAN,.VALMHDR)   ; DBIA #5713
 .. Q
 . ;
 . S VRXHDR="TPJI - AR Account Profile"
 . I BPSVRXCLM>1 S VRXHDR=VRXHDR_" ("_BPSIBG_" of "_BPSVRXCLM_")"
 . ;
 . D UPDATE^BPSVRX(BPSSCRG,.VALMHDR,"",VRXHDR,BPSSNUM)
 . K @BPSSCRG,VALMHDR
 . Q
 ;
TPJIARPX ;
 Q
 ;
TPJIARCH(RXIEN,FILL,VIEWTYPE,BPSSNUM) ; TPJI - AR Comment History
 I '$D(ZTQUEUED) W !,"Compiling data for TPJI AR Comment History ... "
 N IBIFN,VALMHDR,BPSIBG,VRXHDR,BPSSCRG,BPSGDAN
 ;
 ; If no claims found
 I '$G(BPSVRXCLM) D UPDATE^BPSVRX("","","","TPJI - AR Comment History",BPSSNUM) G TPJIARCX
 ;
 S BPSIBG=0
 S IBIFN=0 F  S IBIFN=$O(BPSVRXCLM(IBIFN)) Q:'IBIFN  D
 . S BPSIBG=BPSIBG+1
 . S (BPSSCRG,BPSGDAN)=$NA(^TMP("BPSVRX-AR COMM",$J))
 . ;
 . D
 .. ; protect/clean up variables
 .. N BPSIBG,BPSVRXCLM,BPSSNUM,BPSSCRG
 .. N VALMEVL S VALMEVL=999
 .. D IBDSP^IBJTU6(3,IBIFN,,,BPSGDAN,.VALMHDR)   ; DBIA #5713
 .. Q
 . ;
 . S VRXHDR="TPJI - AR Comment History"
 . I BPSVRXCLM>1 S VRXHDR=VRXHDR_" ("_BPSIBG_" of "_BPSVRXCLM_")"
 . ;
 . D UPDATE^BPSVRX(BPSSCRG,.VALMHDR,"",VRXHDR,BPSSNUM)
 . K @BPSSCRG,VALMHDR
 . Q
 ;
TPJIARCX ;
 Q
 ;
TPJIECME(RXIEN,FILL,VIEWTYPE,BPSSNUM) ; TPJI - ECME Rx Response Information
 I '$D(ZTQUEUED) W !,"Compiling data for TPJI ECME Rx Response ... "
 N IBIFN,VALMHDR,BPSIBG,VRXHDR,BPSSCRG,BPSGDAN
 ;
 ; If no claims found
 I '$G(BPSVRXCLM) D UPDATE^BPSVRX("","","","TPJI - ECME Rx Response Information",BPSSNUM) G TPJIECMX
 ;
 S BPSIBG=0
 S IBIFN=0 F  S IBIFN=$O(BPSVRXCLM(IBIFN)) Q:'IBIFN  D
 . S BPSIBG=BPSIBG+1
 . S (BPSSCRG,BPSGDAN)=$NA(^TMP("BPSVRX-ECME RX",$J))
 . ;
 . D
 .. ; protect/clean up variables
 .. N BPSIBG,BPSVRXCLM,BPSSNUM,BPSSCRG
 .. N VALMEVL S VALMEVL=999
 .. D IBDSP^IBJTU6(4,IBIFN,,,BPSGDAN,.VALMHDR)   ; DBIA #5713
 .. Q
 . ;
 . S VRXHDR="TPJI - ECME Rx Response Information"
 . I BPSVRXCLM>1 S VRXHDR=VRXHDR_" ("_BPSIBG_" of "_BPSVRXCLM_")"
 . ;
 . D UPDATE^BPSVRX(BPSSCRG,.VALMHDR,"",VRXHDR,BPSSNUM)
 . K @BPSSCRG,VALMHDR
 . Q
 ;
TPJIECMX ;
 Q
 ;
