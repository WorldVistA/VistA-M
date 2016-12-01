PSOREJU4 ;BIRM/LE - Pharmacy Reject Overrides ;06/26/08
 ;;7.0;OUTPATIENT PHARMACY;**289,290,358,359,385,421,448**;DEC 1997;Build 25
 ;Reference to DUR1^BPSNCPD3 supported by IA 4560
 ;Reference to 9002313.93 supported by IA 4720
 ;Reference to ELIG^BPSBUTL supported by IA 4719
 ;
AUTOREJ(CODES,PSODIV) ;API to evaluate an array of reject codes to see if they are allowed to be passed to OP reject Worklist 
 ;Input:      CODES - required; array of codes to be validated for overrides.  
 ;           PSODIV - optional; Division for the Rx and Fill to be evaluated
 ;        
 ;Output:     CODES(0)=0 always - ALLOW ALL REJECTS flag was inactivated with patch 421
 ;      
 ;            CODES(SEQ,REJECT)= 0 (zero) if the fill is not allowed to be passed to the Pharmacy
 ;                                Reject Worklist or 1 (one) for the reject code is allowed.
 ;                                
 N SEQ,COD,AUTO,ALLOW,SPDIV
 ;if no division passed, first division in file 59 is assumed.
 I '$G(PSODIV) S PSODIV=0,PSODIV=$O(^PS(59,PSODIV))
 I '$G(PSODIV) S CODES(0)="0^Division undefined in file 59" Q 
 S SPDIV="",SPDIV=$O(^PS(52.86,"B",PSODIV,SPDIV))
 I SPDIV="" S CODES(0)="0^Division is not defined under ePharmacy Site Parameters option." Q
 ;
 ; - all rejects allowed flag obsolete, set to 0 for parameter integrity 
 S CODES(0)=0
 ;
 ; - check individual reject codes.  If defined, can be passed to Pharmacy Reject Worklist
 S (COD,SEQ)="" F  S SEQ=$O(CODES(SEQ)) Q:SEQ=""  F  S COD=$O(CODES(SEQ,COD)) Q:COD=""  D
 . I $D(^PS(52.86,+SPDIV,1,"B",COD)) S CODES(SEQ,COD)=1
 . E  S CODES(SEQ,COD)=0
 Q
 ;
WRKLST(RX,RFL,COMMTXT,USERID,DTTIME,OPECC,RXCOB,RESP) ;External API to store reject codes other that 79/88/TRICARE/CHAMPVA on the OP Reject Worklist
 ; 
 N REJ,REJS,REJLST,I,IDX,CODE,DATA,TXT,PSOTRIC,SPDVI,PSODIV,REJCD,CLOSECHK
 S PSODIV=$$RXSITE^PSOBPSUT(RX,RFL)
 L +^PSRX("REJ",RX):15 Q:'$T "0^Rx locked by another user."
 I $G(RFL)="" S RFL=$$LSTRFL^PSOBPSU1(RX)
 D DUR1^BPSNCPD3(RX,RFL,.REJ,"",RXCOB)
 ;cnf, PSO*7*358, add TRICARE logic
 S REJCD="",CLOSECHK=0
 I $L($G(RESP)) D
 .I $P(RESP,"^",3)'="T",$P(RESP,"^",3)'="C" Q       ;ignore if not TRICARE or CHAMPVA
 .I 'RESP Q   ;Piece 1 will be 0 if claim was submitted thru ECME
 .S REJCD="e"_$P(RESP,"^",3) ; either eT for TRICARE or eC for CHAMPVA
 .S REJ(1,"REJ CODE LST")=REJCD
 .S REJ(1,"PAYER MESSAGE",1)="Not ECME Billable: "_$P(RESP,U,2)
 .S REJ(1,"ELIGBLT")=$P(RESP,"^",3)
 .S CLOSECHK=1
 S PSOTRIC="",PSOTRIC=$$TRIC^PSOREJP1(RX,RFL,PSOTRIC)
 K REJS S (AUTO,IDX)=""
 F  S IDX=$O(REJ(IDX)) Q:IDX=""  D  Q:AUTO'=""
 . S TXT=REJ(IDX,"REJ CODE LST")
 . F I=1:1:$L(TXT,",") D
 . . S CODE=$P(TXT,",",I)
 . . I CODE="" Q   ;BNT-2/15/11 Rare, but could happen that a code is null.
 . . I CODE'="79"&(CODE'="88")&('$G(PSOTRIC)) S AUTO=$$EVAL(PSODIV,CODE,OPECC) Q:'+AUTO
 . . I PSOTRIC S AUTO=1  ;cnf, send all billable and non-billable rejects to worklist if TRICARE or CHAMPVA
 . . I $$DUP^PSOREJU1(RX,+$$CLEAN^PSOREJU1($G(REJ(IDX,"RESPONSE IEN"))),CLOSECHK) S AUTO="0^Rx is already on Pharmacy Reject Worklist."
 . . S REJS(IDX,CODE)=""
 I '$D(REJS) L -^PSRX("REJ",RX) S AUTO="0^No action taken" Q AUTO
 G EXIT:'+AUTO
 ;
 D SYNC2^PSOREJUT
 S AUTO=1
EXIT ;
 L -^PSRX("REJ",RX)
 Q AUTO
 ;
EVAL(PSODIV,CODE,OPECC,RX,RFNBR,COB,RRRDATA) ;Evaluates whether the reject codes other than 79/88/TRICARE/CHAMPVA is allowed to be passed to OP Reject Worklist
 ;Input:      PSODIV - required; Division for the Rx and Fill to be evaluated
 ;              CODE - required; external reject code
 ;             OPECC - optional, 1 means manually passed by OPECC 0 or null means not passed
 ;                RX - optional; IEN from prescription file
 ;             RFNBR - optional; refill number
 ;               COB - optional; coordination of benefits
 ;Output:     $$EVAL - Return value - 1 means reject is allowed to be passed to Pharmacy Reject Worklist and 
 ;                                    0 means not allowed.
 ;           When doing a RRR check, RX, RFNBR & COB are required.
 ;           RRRDATA - passed by reference.   
 ;                     RRRDATA [1] 1/0 is this an RRR reject?
 ;                             [2] gross amount due for the Rx/fill/cob
 ;                             [3] $ dollar threshold amount from PSO site parameters
 ;
 N ALLOWA,CIEN,ALLOW,ICOD,SPDIV
 I '$D(CODE)!(CODE="") Q 0
 I '$G(OPECC) S OPECC=0
 I '$G(PSODIV) Q 0
 S SPDIV="",SPDIV=$O(^PS(52.86,"B",PSODIV,SPDIV))
 Q:SPDIV="" "0^Division is not defined under ePharmacy Site Parameters option."
 S:'$G(AUTO) AUTO=""
 S ICOD="",ICOD=$O(^BPSF(9002313.93,"B",CODE,ICOD))
 Q:ICOD="" 0
 ;
 ; Check for Resolution Required Reject code if so, return a 1
 I $G(RX),$D(RFNBR),$D(COB) S RRRDATA=$$RRRCHK(SPDIV,ICOD,RX,RFNBR,COB) I +RRRDATA Q 1
 ;
 ; Transfer reject processing
 Q:'$D(^PS(52.86,SPDIV,1,"B",ICOD)) "0^Reject Code is not allowed to be passed to Pharmacy Reject Worklist."
 S CIEN="",CIEN=$O(^PS(52.86,SPDIV,1,"B",ICOD,CIEN))
 I CIEN="" S AUTO="0^Code not defined."
 S (AUTO,ALLOW)="",ALLOW=$$GET1^DIQ(52.8651,CIEN_","_SPDIV,1,"I")
 I ALLOW Q 1
 I 'ALLOW D
 . I OPECC S AUTO=1
 . I 'OPECC S AUTO="0^Reject code "_CODE_" cannot be placed on the Pharmacy Reject Worklist"
 Q AUTO
 ;
INLIST(RX,RFL,RXCOB) ;Returns whether a prescription/fill contains UNRESOLVED rejects
 ;Input:
 ;RX - Prescription IEN. 
 ;FILL - Fill number being processed. 
 ;Output:
 ;0 - the fill is not on the Pharmacy Reject Worklist
 ;1 - the fill is already on the Pharmacy Reject Worklist
 N PSOX,PSOX1,PSOX2,REJDATA1
 S PSOX=$$FIND^PSOREJUT(RX,RFL,.REJDATA1,"") I PSOX=0  Q 0
 S RXCOB=$S(RXCOB=1:"PRIMARY",RXCOB=2:"SECONDARY")
 S PSOX1="" F  S PSOX1=$O(REJDATA1(PSOX1))  Q:PSOX1=""  I REJDATA1(PSOX1,"COB")=RXCOB  S PSOX2=1  Q
 I '$G(PSOX2) Q 0
 Q 1
 ;
MULTI(RX,RFL,REJDATA,CODE,REJS,RRRFLG) ;due to routine size, called from FIND^PSOREJUT
 ;returns REJS = 1 means reject code found on Rx, 0 (zero) means not found
 N RCODE,I
 I $G(RFL)'="" D
 . F I=1:1 S RCODE=$P(CODE,",",I) Q:RCODE=""!($G(REJS))  D GET^PSOREJU2(RX,RFL,.REJDATA,,,$G(RCODE),+$G(RRRFLG)) I $D(REJDATA) S REJS=1
 E  S RFL=0 D  I '$D(REJDATA) F  S RFL=$O(^PSRX(RX,1,RFL)) Q:'RFL  D  Q:$G(REJS)
 . F I=1:1 S RCODE=$P(CODE,",",I) Q:RCODE=""!($G(REJS))  D GET^PSOREJU2(RX,RFL,.REJDATA,,,$G(RCODE),+$G(RRRFLG)) I $D(REJDATA) S REJS=1
 Q REJS
 ;
SINGLE(RX,RFL,REJDATA,CODE,REJS,RRRFLG) ;due to routine size, called from FIND^PSOREJUT
 ;Returns REJS = 1 means reject code found on Rx, 0 (zero) means not found
 I $G(RFL)'="" D
 . D GET^PSOREJU2(RX,RFL,.REJDATA,,,$G(CODE),+$G(RRRFLG))
 E  S RFL=0 D  I '$D(REJDATA) F  S RFL=$O(^PSRX(RX,1,RFL)) Q:'RFL  D
 . D GET^PSOREJU2(RX,RFL,.REJDATA,,,$G(CODE),+$G(RRRFLG))
 S REJS=$S($D(REJDATA):1,1:0)
 Q REJS
 ;
RRRCHK(SPDIV,REJ,RX,RFNBR,COB) ; Test a reject for valid Resolution Required Reject code
 ; INPUT
 ; SPDIV  = required - IEN in site parameter file for the selected division
 ; REJ    = required - IEN of the Reject code to test
 ; RX     = required - IEN from prescription file
 ; RFNBR  = required - prescription refill number
 ; COB    = optional - coordination of benefits
 ;
 ; OUTPUT
 ;  Function Value - Returns an "^" delimited string
 ;                 [1] 1/0 is this an RRR reject?
 ;                     1 = Valid resolution required reject code.
 ;                     0 = Invalid resolution required reject code.
 ;                 [2] If valid RRR then gross amount due for the Rx/fill/cob else null
 ;                 [3] If valid RRR then dollar threshold amount from PSO site parameters else null
 ;
 ; For a reject code to be valid each of the following needs to be true:
 ;    1 - Eligibility must be a veteran type
 ;    2 - Must be the first fill on a prescription
 ;    3 - Reject code must be defined in the pharmacy division's site parameters
 ;        as a resolution required reject code.
 ;    4 - Gross amount must be >= DOLLAR THRESHOLD in the pharmacy division's site
 ;        parameters for the given resolution required reject code.
 ;
 ; Verify parameters
 I '$G(SPDIV) Q 0
 I '$D(^PS(52.86,SPDIV)) Q 0
 I '$G(REJ) Q 0
 I '$D(^BPSF(9002313.93,REJ,0)) Q 0                     ; DBIA 4720
 I '$G(RX) Q 0
 I '$D(^PSRX(RX)) Q 0
 I '$D(RFNBR) Q 0
 ;
 N RRRC,AMT,THRSHLD
 ; SPDIV   = IEN in site parameter file for the selected division
 ; RRRC    = indicates the RESOLUTION REQUIRED REJECT CODE exists for the selected division
 ;           it will be a null or an IEN in the 52.865 sub-file
 ; AMT     = RX gross amount due
 ; THRSHLD = DOLLAR THRESHOLD for RRR code
 ;
 ; Test for released status
 I $$GET1^DIQ(52,RX_",",31,"I") Q 0
 ;
 ; Test Eligibility - IA 4719
 I $$ELIG^BPSBUTL(RX,0,$G(COB))'="V" Q 0
 ;
 ; is this a Resolution Required Reject code?
 S RRRC=0,RRRC=$O(^PS(52.86,SPDIV,5,"B",REJ,RRRC))
 I RRRC="" Q 0
 ;
 ; Test gross amount against DOLLAR THRESHOLD
 S AMT=$$AMT^BPSBUTL(RX,0,$G(COB))
 S THRSHLD=$$GET1^DIQ(52.865,RRRC_","_SPDIV_",",.02)
 I AMT<THRSHLD Q 0
 Q 1_U_AMT_U_THRSHLD
 ;
REJCOM(RX,FIL,COB,RET) ; Gather PSO reject comments and return
 ; Input
 ;    RX - prescription IEN required
 ;   FIL - fill# required - will match with the 52.25,5 field
 ;   COB - coordination of benefits# (optional).  If present, will match with the 52.25,27 field
 ; Output
 ;   RET - return array, pass by reference
 ;         RET(external reject code,date/time of comment,incremental counter) =
 ;                 [1] date/time of comment
 ;                 [2] user pointer 200
 ;                 [3] comment text 1-150 characters
 ;
 N REJ,G0,G2,REJCODE,CMT,H0,PSORJCNT
 K RET
 I '$G(RX) G REJCOMX
 I $G(FIL)="" G REJCOMX
 S COB=$G(COB)
 S PSORJCNT=0
 ;
 S REJ=0 F  S REJ=$O(^PSRX(RX,"REJ",REJ)) Q:'REJ  D
 . S G0=$G(^PSRX(RX,"REJ",REJ,0)),G2=$G(^PSRX(RX,"REJ",REJ,2))
 . I FIL'=$P(G0,U,4) Q         ; fill# must match
 . I COB,COB'=$P(G2,U,7) Q     ; cob# must match if COB is passed in
 . S REJCODE=$P(G0,U,1)        ; save external reject code
 . I REJCODE="" Q
 . ;
 . S CMT=0 F  S CMT=$O(^PSRX(RX,"REJ",REJ,"COM",CMT)) Q:'CMT  D
 .. S H0=$G(^PSRX(RX,"REJ",REJ,"COM",CMT,0)) I 'H0 Q      ; make sure the date/time is there
 .. S PSORJCNT=PSORJCNT+1                                 ; increment the counter for unique subscript
 .. S RET(REJCODE,$P(H0,U,1),PSORJCNT)=H0                 ; save the data in sort order
 .. Q
 . Q
REJCOMX ;
 Q
 ;
MP(RX,FIL) ; Entry point for PSO API to display Medication Profile List Manager screen given an Rx and Fill
 ;
 N PSOSITE,DFN,PSODFN,PATIENT,SITE,PSOPAR,PSOPAR7,PSOSYS,PSOPINST
 N CTRLCOL,COL,D,GMRAL,HDR,HIGHLN,LASTLINE,LENGTH,PSOEXDCE,PSOEXPDC,PSOHD,PSOPI,PSORDCNT,PSORDER,PSORDSEQ,PSOSIGDP,PSOSRTBY
 N PSOSTSEQ,PSOSTSGP,PSOTEL,PSOTMP,RSLT,SORT,VA,VACNTRY,VADM,VAPA,VAEL,VAERR
 N DAT,DDER,DIW,DIWF,DIWI,DIWT,DIWTC,DIWX,DN,LIST,OUT,POP,POS,PSNDIY,PSOCHNG,PSOQUIT,PSOBM,PSOQFLG
 I '$G(RX) G MPX
 I $G(FIL)="" G MPX
 ;
 K ^TMP("PSOPI",$J)
 S (SITE,PSOSITE)=+$$RXSITE^PSOBPSUT(RX,FIL)       ; division ien (ptr to file 59)
 S PSOPAR=$G(^PS(59,PSOSITE,1)),PSOPAR7=$G(^PS(59,PSOSITE,"IB")),PSOSYS=$G(^PS(59.7,1,40.1)),PSOPINST=$P($G(^PS(59,PSOSITE,"INI")),U,1)
 S (DFN,PSODFN,PATIENT)=+$$GET1^DIQ(52,RX,2,"I")   ; patient ien
 D LOAD^PSOPMPPF(SITE,DUZ)                         ; load division/user preferences
 D EN^VALM("PSO BPS PMP MAIN")                     ; call list
 K ^TMP("PSOPI",$J),^TMP("PSOPMP0",$J),^TMP("PSOPMPSR",$J)     ; clean-up
MPX ;
 Q
 ;
PI(RX,FIL) ; Entry point for PSO API to display Patient Information List Manager screen given an Rx and Fill
 N PSOSITE,DFN,PSODFN,PATIENT,SITE,PSOPAR,PSOPAR7,PSOSYS,PSOPINST
 N CTRLCOL,COL,D,GMRAL,HDR,HIGHLN,LASTLINE,LENGTH,PSOEXDCE,PSOEXPDC,PSOHD,PSOPI,PSORDCNT,PSORDER,PSORDSEQ,PSOSIGDP,PSOSRTBY
 N PSOSTSEQ,PSOSTSGP,PSOTEL,PSOTMP,RSLT,SORT,VA,VACNTRY,VADM,VAPA,VAEL,VAERR
 N DAT,DDER,DIW,DIWF,DIWI,DIWT,DIWTC,DIWX,DN,LIST,OUT,POP,POS,PSNDIY,PSOCHNG,PSOQUIT,PSOBM,PSOQFLG
 I '$G(RX) G PIX
 I $G(FIL)="" G PIX
 ;
 K ^TMP("PSOPI",$J)
 S (SITE,PSOSITE)=+$$RXSITE^PSOBPSUT(RX,FIL)       ; division ien (ptr to file 59)
 S PSOPAR=$G(^PS(59,PSOSITE,1)),PSOPAR7=$G(^PS(59,PSOSITE,"IB")),PSOSYS=$G(^PS(59.7,1,40.1)),PSOPINST=$P($G(^PS(59,PSOSITE,"INI")),U,1)
 S (DFN,PSODFN,PATIENT)=+$$GET1^DIQ(52,RX,2,"I")   ; patient ien
 D ^PSOORUT2                                       ; build Listman content and header
 D EN^VALM("PSO BPS PATIENT INFORMATION")          ; call list
 K ^TMP("PSOPI",$J)                                ; clean-up
PIX ;
 Q
 ;
