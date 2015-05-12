FBAAIARC ;ALB/ESG - FEE IPAC Vendor Payment Report (Detail) Compile continued ;2/4/2014
 ;;3.5;FEE BASIS;**123**;JAN 30, 1995;Build 51
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
COMPILE ; entry point for the compile to build the scratch global
 ; may be background task if job queued
 ;
 K ^TMP("FBAAIARB",$J)
 I '$D(ZTQUEUED) W !!,"Compiling IPAC Vendor Payment Report.  Please wait ... "
 I $D(FBIATYPE("OUT"))!$D(FBIATYPE("ANC")) D COMPOUT   ; outpatient/ancillary
 I $D(FBIATYPE("INP")) D COMPIN                        ; inpatient
 I $D(FBIATYPE("RX")) D COMPRX                         ; prescription
 ;
 D PRINT^FBAAIARD                 ; print report
 D ^%ZISC                         ; close the device
 K ^TMP("FBAAIARB",$J)            ; kill scratch
 I $D(ZTQUEUED) S ZTREQ="@"       ; purge the task
COMPILX ;
 Q
 ;
COMPOUT ; compile Outpatient and Ancillary data
 ;
 N DATA,FBDODINV,FBDT,FBJ,FBK,FBL,FBM,FBPTSSN,FBVENAME,FBVENID
 N FBY0,FBY2,FBY3,FBYREJ,FBZADJ,FBZDOS,FBZIENS,FBZPTNM,FBZTYPE,FEEPROG
 S FBDT=$O(^FBAAC("AK",FBIABEG),-1)
 F  S FBDT=$O(^FBAAC("AK",FBDT)) Q:'FBDT!(FBDT>FBIAEND)  D
 . S FBJ=0 F  S FBJ=$O(^FBAAC("AK",FBDT,FBJ)) Q:'FBJ  D    ; FBJ=patient DFN
 .. S FBZPTNM=$P($G(^DPT(FBJ,0)),U,1) Q:FBZPTNM=""         ; patient name for scratch global
 .. S FBPTSSN=$P($G(^DPT(FBJ,0)),U,9)                      ; full patient SSN
 .. S FBK=0 F  S FBK=$O(^FBAAC("AK",FBDT,FBJ,FBK)) Q:'FBK  D       ; FBK=vendor ien
 ... I '$D(FBIAVEN(FBK)) Q                  ; make sure vendor is among the selected vendors for the report
 ... S FBVENAME=$P($G(^FBAAV(FBK,0)),U,1)   ; vendor name
 ... I FBVENAME="" S FBVENAME="~unk"
 ... S FBVENID=$P($G(^FBAAV(FBK,0)),U,2)    ; vendor external ID
 ... S FBL=0 F  S FBL=$O(^FBAAC("AK",FBDT,FBJ,FBK,FBL)) Q:'FBL  D
 .... S FBZDOS=+$P($G(^FBAAC(FBJ,1,FBK,1,FBL,0)),U,1) Q:'FBZDOS     ; initial treatment date (DOS) for scratch global
 .... S FBM=0 F  S FBM=$O(^FBAAC("AK",FBDT,FBJ,FBK,FBL,FBM)) Q:'FBM  D
 ..... S FBY0=$G(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,0))
 ..... S FEEPROG=+$P(FBY0,U,9)   ; Fee Program ptr
 ..... I FEEPROG=2,'$D(FBIATYPE("OUT")) Q               ; Outpatient not a chosen type for report
 ..... I FEEPROG'=2,'$D(FBIATYPE("ANC")) Q              ; Civil Hosp Ancillary not a chosen type for report
 ..... S FBZTYPE=$S(FEEPROG=2:"1-OUTPAT",1:"4-ANCIL")   ; type subscript for scratch global
 ..... S FBY2=$G(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,2))
 ..... S FBY3=$G(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,3))
 ..... S FBYREJ=$G(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,"FBREJ"))
 ..... S FBDODINV=$P(FBY3,U,7) I FBDODINV="" Q        ; DoD invoice# must be present
 ..... I FBIAIGNORE,$P(FBY2,U,4) Q                    ; cancellation date exists
 ..... I FBIAIGNORE,$P(FBY0,U,21)'="" Q               ; line has been voided
 ..... I FBIAIGNORE,$P(FBYREJ,U,1)'="" Q              ; line has been rejected
 ..... I FBIAADJ,$P(FBY0,U,3)'<$P(FBY0,U,2) Q         ; skip paid in full line items
 ..... ;
 ..... S FBZIENS=FBM_","_FBL_","_FBK_","_FBJ_","      ; iens
 ..... S FBZADJ=$$ADJ(1)
 ..... S DATA=FBK
 ..... S $P(DATA,U,2)=FBVENID
 ..... S $P(DATA,U,3)=FBDT
 ..... S $P(DATA,U,4)=FBPTSSN
 ..... S $P(DATA,U,5)=$P($$CPT^ICPTCOD(+$P(FBY0,U,1),FBZDOS),U,2)    ; CPT procedure code
 ..... S $P(DATA,U,6)=$$MODS                                         ; comma-delimited list of CPT modifiers
 ..... S $P(DATA,U,7)=$$GET1^DIQ(162.03,FBZIENS,48)                  ; external 3 digit revenue code
 ..... S $P(DATA,U,8)=""
 ..... S $P(DATA,U,9)=""
 ..... S $P(DATA,U,10)=""               ; these are Inpatient or Pharmacy fields
 ..... S $P(DATA,U,11)=""
 ..... S $P(DATA,U,12)=""
 ..... S $P(DATA,U,13)=""
 ..... S $P(DATA,U,14)=$P(FBY0,U,2)     ; amount claimed
 ..... S $P(DATA,U,15)=$P(FBY0,U,3)     ; amount paid
 ..... S $P(DATA,U,16)=$P(FBZADJ,U,1)   ; adjustment amount #1
 ..... S $P(DATA,U,17)=$P(FBZADJ,U,2)   ; adjustment group code-reason code #1
 ..... S $P(DATA,U,18)=$P(FBZADJ,U,3)   ; adjustment amount #2
 ..... S $P(DATA,U,19)=$P(FBZADJ,U,4)   ; adjustment group code-reason code #2
 ..... S $P(DATA,U,20)=$P(FBY0,U,16)    ; fee invoice#
 ..... S $P(DATA,U,21)=$P($G(^FBAA(161.7,+$P(FBY0,U,8),0)),U,1)    ; external batch#
 ..... S $P(DATA,U,22)=$P($G(^FBAA(161.7,+$P(FBY0,U,8),0)),U,2)    ; obligation# from the batch file
 ..... S $P(DATA,U,23)=$P(FBY0,U,14)    ; date paid
 ..... S $P(DATA,U,24)=$P(FBY2,U,3)     ; check number
 ..... S $P(DATA,U,25)=$P(FBY2,U,8)     ; disbursed amount
 ..... S $P(DATA,U,26)=$P(FBY2,U,4)     ; cancellation date
 ..... S $P(DATA,U,27)=$S($P(FBY0,U,21)'="":1,1:0)     ; voided payment flag
 ..... S $P(DATA,U,28)=$$GET1^DIQ(162.03,FBZIENS,19)   ; reject status external value
 ..... ;
 ..... S ^TMP("FBAAIARB",$J,FBVENAME,FBZTYPE,FBDODINV,FBZDOS,FBZPTNM,FBZIENS)=DATA        ; store data outpat/ancil
 ..... S ^TMP("FBAAIARB",$J,FBVENAME)=FBVENID
 ..... Q
 .... Q
 ... Q
 .. Q
 . Q
COMPOUTX ;
 Q
 ;
MODS() ; Build a list of CPT modifiers for subfile 162.03
 ; Assumes all variables are set from above
 N RET,FBN,MODIEN,MOD
 S RET=""
 S FBN=0 F  S FBN=$O(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,"M",FBN)) Q:'FBN  D
 . S MODIEN=+$P($G(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,"M",FBN,0)),U,1) Q:'MODIEN
 . S MOD=$P($$MOD^ICPTMOD(MODIEN,"I",FBZDOS),U,2) Q:MOD=""
 . S RET=$S(RET="":MOD,1:RET_","_MOD)
 . Q
MODSX ;
 Q RET
 ;
ADJ(TYPE) ; Builds a string of Adjustment amounts and group-reason codes
 ; TYPE indicates which payment file to look at to obtain adjustment information
 ; TYPE=1: 162.03  Outpatient/Ancillary
 ; TYPE=2: 162.5   Inpatient
 ; TYPE=3: 162.11  Pharmacy
 ;
 ; Returns a string:
 ;     [1] adjustment amount #1
 ;     [2] adjustment group code-reason code #1
 ;     [3] adjustment amount #2
 ;     [4] adjustment group code-reason code #2
 ;
 N RET,GLO,STOP,Z,G,AMT,GRP,RSN,X
 S RET="",GLO="",STOP=0
 I TYPE=1 S GLO=$NA(^FBAAC(FBJ,1,FBK,1,FBL,1,FBM,7))
 I TYPE=2 S GLO=$NA(^FBAAI(FBJ,8))
 I TYPE=3 S GLO=$NA(^FBAA(162.1,FBJ,"RX",FBK,4))
 I GLO="" G ADJX
 ;
 S Z=0 F  S Z=$O(@GLO@(Z)) Q:'Z!STOP  S G=$G(@GLO@(Z,0)) D
 . S AMT=$P(G,U,3)                               ; adj amount
 . S GRP=$P($G(^FB(161.92,+$P(G,U,2),0)),U,1)    ; adj group code
 . S RSN=$P($G(^FB(161.91,+$P(G,U,1),0)),U,1)    ; adj reason code
 . S X=GRP_"-"_RSN
 . I RET="" S RET=AMT_U_X Q       ; 1st adjustment data pair
 . S $P(RET,U,3)=AMT
 . S $P(RET,U,4)=X
 . S STOP=1
 . Q
ADJX ;
 Q RET
 ;
COMPIN ; compile Inpatient data
 ;
 N DATA,DFN,FBDODINV,FBDT,FBJ,FBPTSSN,FBV,FBVENAME,FBVENID,FBY0,FBY2,FBY5,FBYREJ,FBZADJ,FBZDOS,FBZIENS,FBZPTNM,FBZTYPE
 S FBDT=$O(^FBAAI("AD",FBIABEG),-1)
 F  S FBDT=$O(^FBAAI("AD",FBDT)) Q:'FBDT!(FBDT>FBIAEND)  S FBJ=0 F  S FBJ=$O(^FBAAI("AD",FBDT,FBJ)) Q:'FBJ  D
 . S FBY0=$G(^FBAAI(FBJ,0))
 . S FBY2=$G(^FBAAI(FBJ,2))
 . S FBY5=$G(^FBAAI(FBJ,5))
 . S FBYREJ=$G(^FBAAI(FBJ,"FBREJ"))
 . S FBDODINV=$P(FBY5,U,7) I FBDODINV="" Q        ; DoD invoice# must be present
 . S FBV=+$P(FBY0,U,3)      ; vendor ien
 . I '$D(FBIAVEN(FBV)) Q    ; vendor is not among the selected vendors for the report
 . S FBVENAME=$P($G(^FBAAV(FBV,0)),U,1)           ; vendor name
 . I FBVENAME="" S FBVENAME="~unk"
 . S FBVENID=$P($G(^FBAAV(FBV,0)),U,2)            ; vendor external ID
 . S DFN=+$P(FBY0,U,4) Q:'DFN
 . S FBZPTNM=$P($G(^DPT(DFN,0)),U,1) Q:FBZPTNM=""   ; patient name
 . S FBPTSSN=$P($G(^DPT(DFN,0)),U,9)              ; full patient SSN
 . S FBZIENS=FBJ_","                              ; iens
 . S FBZDOS=$$B9ADMIT^FBAAV5(FBZIENS)             ; admission date
 . I 'FBZDOS S FBZDOS=+$P(FBY0,U,6)               ; treatment from date
 . I 'FBZDOS Q                                    ; need to have a date of service
 . I FBIAIGNORE,$P(FBY2,U,5) Q                    ; cancelled
 . I FBIAIGNORE,$P(FBY0,U,14)'="" Q               ; voided
 . I FBIAIGNORE,$P(FBYREJ,U,1)'="" Q              ; rejected
 . I FBIAADJ,$P(FBY0,U,9)'<$P(FBY0,U,8) Q         ; skip paid in full line items
 . ;
 . S FBZTYPE="2-INPAT"
 . S FBZADJ=$$ADJ(2)
 . S DATA=FBV
 . S $P(DATA,U,2)=FBVENID
 . S $P(DATA,U,3)=FBDT
 . S $P(DATA,U,4)=FBPTSSN
 . S $P(DATA,U,5)=""
 . S $P(DATA,U,6)=""
 . S $P(DATA,U,7)=""
 . S $P(DATA,U,8)=$P($$B9DISCHG^FBAAV5(FBZIENS),U,1)                  ; discharge date
 . S $P(DATA,U,9)=$$DIAG                                              ; list of up to 25 Dx & POA codes
 . S $P(DATA,U,10)=$$ICD9^FBCSV1(+$P(FBY5,U,9),FBZDOS)                ; admitting dx
 . S $P(DATA,U,11)=$$PROC                                             ; list of up to 25 proc codes
 . S $P(DATA,U,12)=""
 . S $P(DATA,U,13)=""
 . S $P(DATA,U,14)=$P(FBY0,U,8)     ; amount claimed
 . S $P(DATA,U,15)=$P(FBY0,U,9)     ; amount paid
 . S $P(DATA,U,16)=$P(FBZADJ,U,1)   ; adjustment amount #1
 . S $P(DATA,U,17)=$P(FBZADJ,U,2)   ; adjustment group code-reason code #1
 . S $P(DATA,U,18)=""               ; only 1 adj for inpatient
 . S $P(DATA,U,19)=""
 . S $P(DATA,U,20)=$P(FBY0,U,1)                                 ; fee invoice number
 . S $P(DATA,U,21)=$P($G(^FBAA(161.7,+$P(FBY0,U,17),0)),U,1)    ; external batch#
 . S $P(DATA,U,22)=$P($G(^FBAA(161.7,+$P(FBY0,U,17),0)),U,2)    ; obligation# from the batch file
 . S $P(DATA,U,23)=$P(FBY2,U,1)                                 ; Date Paid
 . S $P(DATA,U,24)=$P(FBY2,U,4)                                 ; check number
 . S $P(DATA,U,25)=$P(FBY2,U,8)                                 ; disbursed amount
 . S $P(DATA,U,26)=$P(FBY2,U,5)                                 ; cancellation date
 . S $P(DATA,U,27)=$S($P(FBY0,U,14)'="":1,1:0)                  ; voided payment flag
 . S $P(DATA,U,28)=$$GET1^DIQ(162.5,FBZIENS,13)                 ; reject status external value
 . ;
 . S ^TMP("FBAAIARB",$J,FBVENAME,FBZTYPE,FBDODINV,FBZDOS,FBZPTNM,FBZIENS)=DATA                ; store data inpatient
 . S ^TMP("FBAAIARB",$J,FBVENAME)=FBVENID
 . Q
COMPINX ;
 Q
 ;
DIAG() ; capture and format Dx codes and POA codes in a string
 N RET,P1,P2,PCE,DXN,POAN,DX,POA,Z
 S P1=$G(^FBAAI(FBJ,"DX")),P2=$G(^FBAAI(FBJ,"POA"))
 S RET=""
 F PCE=1:1:25 D
 . S DXN=+$P(P1,U,PCE),POAN=+$P(P2,U,PCE) Q:'DXN
 . S DX=$$ICD9^FBCSV1(DXN,FBZDOS) Q:DX=""    ; external diag code
 . S POA=$P($G(^FB(161.94,POAN,0)),U,1)      ; external POA indicator
 . S Z=DX
 . I POA'="" S Z=Z_"("_POA_")"
 . S RET=$S(RET="":Z,1:RET_", "_Z)
 . Q
 Q RET
 ;
PROC() ; capture and format procedure codes into a string
 N RET,P1,PCE,PROCN,PROC
 S P1=$G(^FBAAI(FBJ,"PROC"))
 S RET=""
 F PCE=1:1:25 D
 . S PROCN=+$P(P1,U,PCE) Q:'PROCN                   ; ptr ien to file 80.1
 . S PROC=$$ICD0^FBCSV1(PROCN,FBZDOS) Q:PROC=""     ; external procedure code
 . S RET=$S(RET="":PROC,1:RET_", "_PROC)
 . Q
 Q RET
 ;
COMPRX ; compile Pharmacy data
 ;
 N BCH,DATA,DFN,FBDODINV,FBDT,FBIA,FBINVN,FBJ,FBK,FBPTSSN,FBRXINV,FBVEN,FBVENAME,FBVENID
 N FBY0,FBY2,FBY6,FBYREJ,FBZADJ,FBZDOS,FBZIENS,FBZPTNM,FBZTYPE
 ; loop thru batch file by date finalized for specified date range
 S FBDT=$O(^FBAA(161.7,"AF",FBIABEG),-1)
 F  S FBDT=$O(^FBAA(161.7,"AF",FBDT)) Q:'FBDT!(FBDT>FBIAEND)  D
 . S BCH=0 F  S BCH=$O(^FBAA(161.7,"AF",FBDT,BCH)) Q:'BCH  D
 .. ;
 .. ; loop thru the pharmacy (B5) payments for a batch
 .. S FBJ=0 F  S FBJ=$O(^FBAA(162.1,"AE",BCH,FBJ)) Q:'FBJ  D
 ... S FBRXINV=$G(^FBAA(162.1,FBJ,0))   ; rx invoice level data
 ... S FBVEN=+$P(FBRXINV,U,4)   ; vendor ien
 ... I '$D(FBIAVEN(FBVEN)) Q    ; vendor is not among the selected vendors for report
 ... S FBIA=+$P(FBRXINV,U,23)   ; ipac ptr
 ... I 'FBIA Q                  ; ipac ptr must exist to be included on this report
 ... S FBINVN=$P(FBRXINV,U,1)   ; Rx invoice#
 ... S FBVENAME=$P($G(^FBAAV(FBVEN,0)),U,1)     ; vendor name
 ... I FBVENAME="" S FBVENAME="~unk"
 ... S FBVENID=$P($G(^FBAAV(FBVEN,0)),U,2)      ; vendor external ID
 ... ;
 ... S FBK=0 F  S FBK=$O(^FBAA(162.1,"AE",BCH,FBJ,FBK)) Q:'FBK  D
 .... S FBY0=$G(^FBAA(162.1,FBJ,"RX",FBK,0))
 .... S FBY2=$G(^FBAA(162.1,FBJ,"RX",FBK,2))
 .... S FBY6=$G(^FBAA(162.1,FBJ,"RX",FBK,6))
 .... S FBYREJ=$G(^FBAA(162.1,FBJ,"RX",FBK,"FBREJ"))
 .... S FBDODINV=$P(FBY6,U,1) I FBDODINV="" Q          ; DoD invoice# must be present
 .... I FBIAIGNORE,$P(FBY2,U,11) Q                     ; cancelled
 .... I FBIAIGNORE,$P(FBY2,U,3)'="" Q                  ; voided
 .... I FBIAIGNORE,$P(FBYREJ,U,1)'="" Q                ; rejected
 .... I FBIAADJ,$P(FBY0,U,16)'<$P(FBY0,U,4) Q          ; skip paid in full line items
 .... S DFN=+$P(FBY0,U,5) Q:'DFN                       ; patient ien
 .... S FBZPTNM=$P($G(^DPT(DFN,0)),U,1) Q:FBZPTNM=""   ; patient name
 .... S FBPTSSN=$P($G(^DPT(DFN,0)),U,9)                ; full patient SSN
 .... S FBZIENS=FBK_","_FBJ_","                        ; iens
 .... S FBZDOS=+$P(FBY0,U,3) Q:'FBZDOS                 ; date prescription filled is DOS
 .... ;
 .... S FBZTYPE="3-RX"
 .... S FBZADJ=$$ADJ(3)
 .... S DATA=FBVEN
 .... S $P(DATA,U,2)=FBVENID
 .... S $P(DATA,U,3)=FBDT
 .... S $P(DATA,U,4)=FBPTSSN
 .... S $P(DATA,U,5)=""
 .... S $P(DATA,U,6)=""
 .... S $P(DATA,U,7)=""
 .... S $P(DATA,U,8)=""
 .... S $P(DATA,U,9)=""
 .... S $P(DATA,U,10)=""
 .... S $P(DATA,U,11)=""
 .... S $P(DATA,U,12)=$P(FBY0,U,1)     ; prescription#
 .... S $P(DATA,U,13)=$P(FBY0,U,2)     ; drug name
 .... S $P(DATA,U,14)=$P(FBY0,U,4)     ; amount claimed
 .... S $P(DATA,U,15)=$P(FBY0,U,16)    ; amount paid
 .... S $P(DATA,U,16)=$P(FBZADJ,U,1)   ; adjustment amount #1
 .... S $P(DATA,U,17)=$P(FBZADJ,U,2)   ; adjustment group code-reason code #1
 .... S $P(DATA,U,18)=$P(FBZADJ,U,3)   ; adjustment amount #2
 .... S $P(DATA,U,19)=$P(FBZADJ,U,4)   ; adjustment group code-reason code #2
 .... S $P(DATA,U,20)=FBINVN                                       ; fee invoice number
 .... S $P(DATA,U,21)=$P($G(^FBAA(161.7,+$P(FBY0,U,17),0)),U,1)    ; external batch#
 .... S $P(DATA,U,22)=$P($G(^FBAA(161.7,+$P(FBY0,U,17),0)),U,2)    ; obligation# from the batch file
 .... S $P(DATA,U,23)=$P(FBY2,U,8)                                 ; Date Paid
 .... S $P(DATA,U,24)=$P(FBY2,U,10)                                ; check number
 .... S $P(DATA,U,25)=$P(FBY2,U,14)                                ; disbursed amount
 .... S $P(DATA,U,26)=$P(FBY2,U,11)                                ; cancellation date
 .... S $P(DATA,U,27)=$S($P(FBY2,U,3)'="":1,1:0)                   ; voided payment flag
 .... S $P(DATA,U,28)=$$GET1^DIQ(162.11,FBZIENS,17)                ; reject status external value
 .... ;
 .... S ^TMP("FBAAIARB",$J,FBVENAME,FBZTYPE,FBDODINV,FBZDOS,FBZPTNM,FBZIENS)=DATA                ; store data pharmacy
 .... S ^TMP("FBAAIARB",$J,FBVENAME)=FBVENID
 .... ;
 .... Q
 ... Q
 .. Q
 . Q
COMPRXX ;
 Q
 ;
