BPSSCRU1 ;BHAM ISC/SS - ECME SCREEN UTILITIES ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,11,23**;JUN 2004;Build 44
 ;;Per VA Directive 6402, this routine should not be modified.
 ;USER SCREEN
 Q
 ;
 ;get date/time range
 ;input:
 ; BPROF - to store user profile info
 ;output:
 ; BPROF("BDT") - start datetime in FM format
 ; BPROF("EDT") - end datetime in FM format
GETDT(BPROF) ;
 N BPNOW,X,BPHORL,%
 ; If the user selected Display Activity Date Range. 
 I $G(BPROF(1.031))="D" D  Q 1
 . ; Adds seconds to the beginning date (BPROF(1.032)-1) in order
 . ; to pick up everything for that beginning date.
 . ;  Example: BPROF(1.032)=3170901, BPROF("BDT")=3170900.999999
 . ;
 . S BPROF("BDT")=$G(BPROF(1.032))-0.000001
 . ; 
 . ; Adds seconds to the ending date (BPROF(1.033)) in order
 . ; to pick up everything for the ending date.
 . ;  Example: BPROF(1.033)=3170906, BPROF("BDT")=3170906.9
 . ;
 . S BPROF("EDT")=$G(BPROF(1.033))+0.9
 ;
 ; If the user selected Display Timeframe.
 ; Timeframe is the default if no selection was made.
 E  D
 . D NOW^%DTC S BPNOW=%
 . I ($G(BPROF(1.04))'="D")&($G(BPROF(1.04))'="H") S BPROF(1.04)="D"
 . I +$G(BPROF(1.05))=0 S BPROF(1.05)=1
 . I $G(BPROF(1.04))="D" D
 . . S BPROF("BDT")=$$FMADD^XLFDT(BPNOW\1,-$G(BPROF(1.05)))-0.000001
 . . S BPROF("EDT")=(BPNOW\1)+0.9
 . I $G(BPROF(1.04))="H" D
 . . S BPROF("BDT")=$$FMADD^XLFDT(BPNOW,0,-$G(BPROF(1.05)))
 . . S BPROF("EDT")=BPNOW
 Q 1
 ;
ISCOPAY ;stub
 Q "COPAY"
 ;
CLPRCNTG ;stub
 Q "%%"
 ;
PTCLMINF ;stub
 Q "X claims payable"
 ;
 ;/**
 ;get user name from file #200
 ;input: BPDUZ ien in file 200
 ;output name as string
GETUSRNM(BPDUZ) ;
 Q $E($$GET1^DIQ(200,+BPDUZ,.01,"E"),1,20)
 ;
 ;/**
 ;Checks if the CLAIM for specific Transaction is CLOSED?
 ;BP59 - 9002313.59
CLOSED(BP59) ;*/
 N BPCLAIM
 I $G(BP59)="" Q 0
 ;get claim ptr to #9002313.02
 S BPCLAIM=+$P($G(^BPST(BP59,0)),U,4)
 I 'BPCLAIM Q 0
 ; get closed status
 Q +$P($G(^BPSC(BPCLAIM,900)),U)=1
