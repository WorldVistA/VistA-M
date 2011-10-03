PSOREJU4 ;BIRM/LE - Pharmacy Reject Overrides ;06/26/08
 ;;7.0;OUTPATIENT PHARMACY;**289,290,358**;DEC 1997;Build 35
 ;Reference to DUR1^BPSNCPD3 supported by IA 4560
 ;
AUTOREJ(CODES,PSODIV) ;API to evaluate an array of reject codes to see if they are allowed to be passed to OP reject Worklist 
 ;Input:      CODES - required; array of codes to be validated for overrides.  
 ;           PSODIV - optional; Division for the Rx and Fill to be evaluated
 ;        
 ;Output:     CODES(0)=   1 for all reject codes are allowed to be passed to Pharmacy
 ;                         Reject Worklist or 0 (zero) means only default of 79/88/Tricare and
 ;                         any individually override rejects can be passed to the worklist. 
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
 ; - all rejects allowed to pass to Pharmacy Reject Worklist?
 S CODES(0)=$$GET1^DIQ(52.86,SPDIV,1,"I")
 ;
 ; - check individual reject codes.  If defined, can be passed to Pharmacy Reject Worklist
 S (COD,SEQ)="" F  S SEQ=$O(CODES(SEQ)) Q:SEQ=""  F  S COD=$O(CODES(SEQ,COD)) Q:COD=""  D
 . I $D(^PS(52.86,+SPDIV,1,"B",COD)) S CODES(SEQ,COD)=1
 . E  S CODES(SEQ,COD)=0
 Q
 ;
WRKLST(RX,RFL,COMMTXT,USERID,DTTIME,OPECC,RXCOB,RESP) ;External API to store reject codes other that 79/88/Tricare on the OP Reject Worklist
 ; 
 N REJ,REJS,REJLST,I,IDX,CODE,DATA,TXT,PSOTRIC,SPDVI,PSODIV,TRIREJCD,CLOSECHK
 S PSODIV=$$RXSITE^PSOBPSUT(RX,RFL)
 L +^PSRX("REJ",RX):15 Q:'$T "0^Rx locked by another user."
 I $G(RFL)="" S RFL=$$LSTRFL^PSOBPSU1(RX)
 D DUR1^BPSNCPD3(RX,RFL,.REJ,"",RXCOB)
 ;cnf, PSO*7*358, add TRICARE logic
 S TRIREJCD="",CLOSECHK=0
 I $L($G(RESP)) D
 .I $P(RESP,"^",3)'="T" Q       ;ignore if not TRICARE
 .I 'RESP Q   ;Piece 1 will be 0 if claim was submitted thru ECME
 .S TRIREJCD=$T(TRIREJCD+1^PSOREJP3),TRIREJCD=$P(TRIREJCD,";;",2)
 .S REJ("CODE")=TRIREJCD
 .S REJ("REASON")="TRICARE-DRUG NON BILLABLE"
 .S REJ(1,"REJ CODE LST")=TRIREJCD
 .S REJ(1,"ELIGBLT")="T"
 .S CLOSECHK=1
 S PSOTRIC="" S:$G(REJ(1,"ELIGBLT"))="T" PSOTRIC=1
 S:PSOTRIC="" PSOTRIC=$$TRIC^PSOREJP1(RX,RFL,PSOTRIC)
 K REJS S (AUTO,IDX)=""
 F  S IDX=$O(REJ(IDX)) Q:IDX=""  D  Q:AUTO'=""
 . S TXT=REJ(IDX,"REJ CODE LST")
 . F I=1:1:$L(TXT,",") D
 . . S CODE=$P(TXT,",",I)
 . . I CODE'="79"&(CODE'="88")&('$G(PSOTRIC)) S AUTO=$$EVAL(PSODIV,CODE,OPECC,.AUTO) Q:'+AUTO
 . . I PSOTRIC S AUTO=1  ;cnf, send all billable and non-billable rejects to worklist if TRICARE, PSO*7*358
 . . I $$DUP^PSOREJU1(RX,+$$CLEAN^PSOREJU1($G(REJ(IDX,"RESPONSE IEN"))),CLOSECHK) S AUTO="0^Rx is already on Pharmacy Reject Worklist."
 . . S REJS(IDX,CODE)=""
 I '$D(REJS) L -^PSRX("REJ",RX) S AUTO="0^No action taken" Q AUTO
 ;D SAVECOM^PSOREJP3(RX,PSREJIEN,COMMTXT,DTTIME,USER)
 G EXIT:'+AUTO
 ;
 D SYNC2^PSOREJUT
 S AUTO=1
EXIT ;
 L -^PSRX("REJ",RX)
 Q AUTO
 ;
EVAL(PSODIV,CODE,OPECC,AUTO) ;Evaluates whether the reject codes other than 79/88/Tricare is allowed to be passed to OP Reject Worklist
 ;Input:      PSODIV - required; Division for the Rx and Fill to be evaluated
 ;              CODE - required; reject code
 ;             OPECC - optional, 1 means manually passed by OPECC means not passed
 ;              AUTO - passed in value to be returned.
 ;Output:       AUTO - 1 means reject is allowed to be passed to Pharmacy Reject Worklist and zero
 ;                       means not allowed.
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
 S ALLOWA=$$GET1^DIQ(52.86,SPDIV,1,"I") I ALLOWA Q 1
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
OVER ;due to size of PSOREJU1 this subroutine was needed. also used by OVERMSG
 ;The variables RX, RFL, CODE and CODES are expected to remain when exiting this subroutine
 ;
 N DCODE,AUTO,PSODIV,OCODES S (PSODIV,AUTO,DCODE,OCODES,OVRARR)=""
 S OCODES=CODES,CODES=""
 S PSODIV=$$RXSITE^PSOBPSUT(RX,RFL)
 F  S DCODE=$O(^PSRX(RX,"REJ","B",DCODE)) Q:DCODE=""  D
 . I DCODE[79!(DCODE[88) S CODES=CODES_","_DCODE Q
 . S AUTO=$$EVAL(PSODIV,DCODE,0,.AUTO)
 . Q:'+AUTO
 . S CODES=CODES_","_DCODE,OVRARR(DCODE)=""
 S CODES=$E(CODES,2,9999)
 S:CODES="" CODES=OCODES
 Q
 ;
OVRMSG(RX,RFL,OVRMSG,REJDAT) ;
 N CODES,OVRARR,COD
 S CODES=""
 D OVER
 I '$D(REJDAT) D NOW^%DTC S REJDAT=%
 Q:'$D(OVRARR)
 F  S COD=$O(OVRARR(COD)) Q:COD=""  D
 . D SAVECOM^PSOREJP3(RX,COD,OVRMSG,REJDAT,$S($G(DUZ):DUZ,1:.5))
 Q
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
MULTI(RX,RFL,REJDATA,CODE,REJS) ;due to routine size, called from FIND^PSOREJUT
 ;returns REJS = 1 means reject code found on Rx, 0 (zero) means not found
 I $G(RFL) D
 . F I=1:1 S RCODE=$P(CODE,",",I) Q:RCODE=""!($G(REJS))  D GET^PSOREJU2(RX,RFL,.REJDATA,,,$G(RCODE)) I $D(REJDATA) S REJS=1
 E  S RFL=0 D  I '$D(REJDATA) F  S RFL=$O(^PSRX(RX,1,RFL)) Q:'RFL  D  Q:$G(REJS)
 . F I=1:1 S RCODE=$P(CODE,",",I) Q:RCODE=""!($G(REJS))  D GET^PSOREJU2(RX,RFL,.REJDATA,,,$G(RCODE)) I $D(REJDATA) S REJS=1
 Q REJS
 ;
SINGLE(RX,RFL,REJDATA,CODE,REJS) ;due to routine size, called from FIND^PSOREJUT
 ;Returns REJS = 1 means reject code found on Rx, 0 (zero) means not found
 I $G(RFL) D
 . D GET^PSOREJU2(RX,RFL,.REJDATA,,,$G(CODE))
 E  S RFL=0 D  I '$D(REJDATA) F  S RFL=$O(^PSRX(RX,1,RFL)) Q:'RFL  D
 . D GET^PSOREJU2(RX,RFL,.REJDATA,,,$G(CODE))
 S REJS=$S($D(REJDATA):1,1:0)
 Q REJS
