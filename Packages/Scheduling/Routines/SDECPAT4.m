SDECPAT4 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
 ; This routine is passed a patient ien and returns an encrypted patient
 ; identifier 12 bytes long.  The entry point DEC reverses the process
 ; and returns the decoded output in a 27 byte long string.
 ;
ENC(DFN) ;EP - RETURN ENCRYPTED PATIENT IDENTIFIER
 NEW AUPNV,AUPNX,AUPNY,I,X,X1,Y
 S AUPNV=""
 G:'$G(DFN) ENCX ;                       exit if no patient ien passed
 G:'$D(^DPT(DFN,0)) ENCX ;               exit if patient doesn't exist
 ;----------
 ; take 1st 3 chars of name, replace punctuation with numbers, pad out
 ;   to 3 chars
 S AUPNX=$E($P($P(^DPT(DFN,0),U),","),1,3)
 S AUPNX=$TR(AUPNX," '-.,","01234")
 F I=1:1:(3-$L(AUPNX)) S AUPNX=AUPNX_"5"
 S AUPNV=AUPNX
 ;----------
 ; take 1st initial, 0 if null
 S AUPNX=$E($P($P(^DPT(DFN,0),U),",",2)) S:AUPNX="" AUPNX=0
 ;----------
 ; concatenate in reverse order
 S AUPNV=$E(AUPNV,3)_$E(AUPNV,2)_$E(AUPNV)_AUPNX
 ;----------
 ; concatenate fileman date of birth (converted to $H/hex format)
 S AUPNX=$$DOB^SDECPAT(DFN) S:$L(AUPNX)'=7 AUPNX=3991231
 S AUPNX=$$FMTH^XLFDT(AUPNX,1)
 S X=AUPNX,X1=16 D CNV^XTBASE S Y=$E(Y,1,4)
 F I=1:1:(4-$L(Y)) S Y=Y_"-"
 S AUPNV=AUPNV_Y
 ;----------
 ; concatenate last 4 digits of SSN
 S AUPNX=$E($$SSN^SDECPAT(DFN),6,9) S:$L(AUPNX)'=4 AUPNX="9999"
 F I=1:1:4 D
 . S X=$E(AUPNX,I)
 . I X<5 S X=X+5,$E(AUPNX,I)=X I 1
 . E  S X=X-5,$E(AUPNX,I)=X
 . Q
 S AUPNV=AUPNV_AUPNX
 ;----------
 ; shuffle
 S AUPNV=$E(AUPNV,4,6)_$E(AUPNV,10,12)_$E(AUPNV,1,3)_$E(AUPNV,7,9)
 ;----------
 ; encrypt
 D ENCRYPT
 ;----------
ENCX ;
 Q AUPNV
 ;
 ;
ENCRYPT ;
 S AUPNV=$TR(AUPNV,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","UVWXJKLMYZABQRSTCDGHIEFNOP")
 S AUPNV=$TR(AUPNV,"1234567890","8967320415")
 Q
 ;
 ;
 ;
DEC(PID) ;EP - RETURN DECRYPTED PATIENT IDENTIFIER
 NEW AUPNV,AUPNX,AUPNY,I,X,X1,Y
 S AUPNV=""
 G:$G(PID)="" DECX ;                     exit if no string
 G:$L(PID)'=12 DECX ;                    exit if string not 12 chars
 S AUPNV="["
 ;----------
 ; decrypt
 D DECRYPT
 ;----------
 ; unshuffle
 S PID=$E(PID,7,9)_$E(PID,1,3)_$E(PID,10,12)_$E(PID,4,6)
 ;----------
 ; take 1st 3 chars of name, replace numbers with punctuation
 S AUPNX=""
 F I=3,2,1 S AUPNX=AUPNX_$E(PID,I)
 S AUPNX=$TR(AUPNX,"01234"," '-.,")
 S AUPNY=""
 F I=1:1:3 S:$E(AUPNX,I)'="5" AUPNY=AUPNY_$E(AUPNX,I)
 S AUPNX=AUPNY_","_$S($E(PID,4)'="0":$E(PID,4),1:"")
 S AUPNV=AUPNV_AUPNX
 ;----------
 ; fileman date of birth (converted to external format)
 S AUPNX=""
 S X=$E(PID,5,8)
 F I=1:1:4 S:$E(X,I)'="-" AUPNX=AUPNX_$E(X,I)
 S X=AUPNX,X1=16 D DEC^XTBASE S AUPNX=Y
 S AUPNX=$$HTE^XLFDT(AUPNX,1)
 S AUPNV=AUPNV_"__"_AUPNX
 ;----------
 ; last 4 digits of SSN
 S AUPNX=$E(PID,9,12)
 F I=1:1:4 D
 . S X=$E(AUPNX,I)
 . I X<5 S X=X+5,$E(AUPNX,I)=X I 1
 . E  S X=X-5,$E(AUPNX,I)=X
 . Q
 S:AUPNX="9999" AUPNX="    "
 S AUPNV=AUPNV_"__"_AUPNX
 ;----------
 S AUPNV=AUPNV_"]"
DECX ;
 Q AUPNV
 ;
DECRYPT ;
 S PID=$TR(PID,"UVWXJKLMYZABQRSTCDGHIEFNOP","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 S PID=$TR(PID,"8967320415","1234567890")
 Q
