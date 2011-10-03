PRSPUT2 ;WOIFO/MGD - PART TIME PHYSICIAN UTILITIES #2 ;07/08/2005
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;The following routine contains various utilities for the  Part Time
 ;Physician functionality that was added as part of patch PRS*4.0*93.
 ;
 ;-----------------------------------------------------------------------
 ; Display information on the hours worked by the PT Physician per PP
 ; Input: PRSIEN - IEN of the PT Physician
 ;          MIEN - IEN of the PT Phy's memorandum in #458.7
 ;         ARRAY - The array where the message to be printed will be
 ;                 stored. (Optional) If not specified, no array will
 ;                 be created.
 ;         INDEX - The index where the array will start. (optional) This
 ;                 will be set to 1 if no index is passed.
 ;
 ; Output: 6 line summary of the Pay Periods covered by the PT Phy's
 ;         memorandum and the hours worked during each of them.
 ;         Array with the same data if the ARRAY parameter is passed.
 ;-----------------------------------------------------------------------
PPSUM(PRSIEN,MIEN,ARRAY,INDEX) ;
 ;
 Q:'PRSIEN&('MIEN)
 I $G(INDEX)="",($G(ARRAY)'="") D INDEX^PRSPUT1
 N I,J,PPHRS,PPNUM,TEXT
 S TEXT=""
 D A1^PRSPUT1 ; Blank Line
 F I=1:1:6 D
 . S TEXT=" "
 . F J=I:6:26 D
 . . S PPNUM=$$GET1^DIQ(458.701,J_","_MIEN_",",.01)_": "
 . . S TEXT=TEXT_PPNUM
 . . S PPHRS=$$GET1^DIQ(458.701,J_","_MIEN_",",1)
 . . S TEXT=TEXT_$S(PPHRS'="":$J(PPHRS,6,2),1:"      ")
 . . S TEXT=TEXT_$S(J'<25:"",1:"   ")
 . D A1^PRSPUT1
 D A1^PRSPUT1,A1^PRSPUT1 ; 2 Blank lines
 Q
 ;
 ;----------------------------------------------------------------------
 ; Retrieve and display the current status of each daily ESR within
 ; the specified PP
 ; Input: PRSIEN - IEN of the PT Physician
 ;           PPI - IEN of the Pay Period
 ;
 ; Output: 8 lines with the summary of the daily ESRs within the PP
 ;-----------------------------------------------------------------------
ESRSTAT(PRSIEN,PPI) ;
 Q:'PRSIEN&('PPI)
 N ATOT,DATA,DAY,DAY2CHK,DAYE,DTEXT,ESRHRS,HRS,I,INDX,J,MEAL,SEG,START
 N STATEX,STATUS,STOP,TEXT,TOT
 S DAYE=$G(^PRST(458,PPI,2)),(ESRHRS(1),ESRHRS(2))=0
 F DAY=1:1:14 D
 . S INDX=$S(DAY<8:1,1:2)
 . S DATA=$G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,5))
 . F SEG=1:5:31 D
 . . S START=$P(DATA,U,SEG),STOP=$P(DATA,U,SEG+1),TOT=$P(DATA,U,SEG+2)
 . . Q:START=""
 . . Q:TOT="WP"  ; Don't count Without Pay
 . . S MEAL=$P(DATA,U,SEG+4)
 . . S HRS=$$AMT^PRSPSAPU(START,STOP,MEAL)
 . . S ESRHRS(INDX)=ESRHRS(INDX)+HRS
 S TEXT="          ESR Hours Week 1: "_$J(ESRHRS(1),6,2)
 S TEXT=TEXT_"     Week 2: "_$J(ESRHRS(2),6,2)
 S TEXT=TEXT_"     Total: "_$J(ESRHRS(1)+ESRHRS(2),6,2)
 W !,TEXT
 W !,"Day Week 1 - ",$P(DAYE,U,1),?41,"Day Week 2 - ",$P(DAYE,U,8)
 ; Loop through each daily ESR record
 F DAY=1:1:7 D
 . S DAY2CHK=DAY D ATOT
 . S $E(DTEXT,42)=""
 . S TEXT=DTEXT
 . S DAY2CHK=DAY2CHK+7 D ATOT
 . S TEXT=TEXT_DTEXT
 . W !,TEXT
 Q
 ;
ATOT ; Convert STATUS to external and determine Types of Time posted
 S ATOT="" ; All Types Of Time posted on the day
 S STATUS=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",DAY2CHK,7)),U,1)
 S STATEX=$$EXTERNAL^DILFD(458.02,146,"",STATUS)
 S DATA=$G(^PRST(458,PPI,"E",PRSIEN,"D",DAY2CHK,5))
 S DTEXT=$S(DAY2CHK<10:" "_DAY2CHK,1:DAY2CHK)
 S DTEXT=DTEXT_"  "_$E($P(DAYE,U,DAY),1,3)_"  "_STATEX
 I DATA'="" D
 . F SEG=0:1:6 Q:$P(DATA,U,5*SEG+1)=""  D
 . . S TOT=$P(DATA,U,5*SEG+3)
 . . I TOT'=""&(ATOT'[TOT) S ATOT=$S(ATOT="":TOT,1:ATOT_", "_TOT)
 ; If status is RESUBMIT check for Supervisor text
 N SUPCOM
 S SUPCOM=""
 I STATUS=3 D
 . S SUPCOM=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",DAY2CHK,6)),U,2)
 . I SUPCOM'="" S ATOT=" "_SUPCOM
 I "^2^4^5^"[("^"_STATUS_"^") S $E(DTEXT,19,20)="- "
 I STATUS=3,SUPCOM="" S $E(DTEXT,19,20)="- "
 S DTEXT=DTEXT_ATOT
 Q
 ;
PRSIEN(MSGF) ; Employee IEN Extrinsic Function
 ; input
 ;   MSGF - (optional) message flag, true (=1) to write error message
 ;   DUZ  - must be defined in symbol table
 ; returns IEN in file 450 or null
 N PRSIEN,SSN
 S PRSIEN=""
 S SSN=$P($G(^VA(200,DUZ,1)),"^",9)
 S:SSN'="" PRSIEN=$O(^PRSPC("SSN",SSN,0))
 I 'PRSIEN,$G(MSGF) W $C(7),!!,"Your SSN was not found in both the New Person & Employee File!"
 Q PRSIEN
 ;
ESIGC(MSGF) ; Electronic Signature Code Extrinsic Function
 ; input
 ;   MSGF - (optional) message flag, true (=1) to write error message
 ;   DUZ  - must be defined in symbol table
 ; returns true  (=1) if the user has an electronic signature code
 ;         false (=0) if the user does not
 N PRSRET
 S PRSRET=($$GET1^DIQ(200,DUZ_",",20.4)'="")
 I 'PRSRET,$G(MSGF) W $C(7),!!,"You must establish an electronic signature code before using this option!",!,"This can be done with the 'Electronic Signature code Edit' option."
 Q PRSRET
