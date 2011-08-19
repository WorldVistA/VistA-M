BPSSCRU1 ;BHAM ISC/SS - ECME SCREEN UTILITIES ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 ;USER SCREEN
 Q
 ;
 ;get date/time range
 ;input:
 ; BPROF - to store usre profile info
 ;output:
 ; BPROF("BDT") - start datetime in FM format
 ; BPROF("EDT") - end datetime in FM format
GETDT(BPROF) ;
 N BPNOW,X,BPHORL,%
 D NOW^%DTC S BPNOW=%
 I ($G(BPROF(1.04))'="D")&($G(BPROF(1.04))'="H") S BPROF(1.04)="D"
 I +$G(BPROF(1.05))=0 S BPROF(1.05)=1
 I $G(BPROF(1.04))="D" D
 . S BPROF("BDT")=$$FMADD^XLFDT(BPNOW\1,-$G(BPROF(1.05)))-0.000001
 . S BPROF("EDT")=(BPNOW\1)+0.9
 I $G(BPROF(1.04))="H" D
 . S BPROF("BDT")=$$FMADD^XLFDT(BPNOW,0,-$G(BPROF(1.05)))
 . S BPROF("EDT")=BPNOW
 Q 1
 ;
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
 ;get claim ptr to #9002313.02
 S BPCLAIM=+$P($G(^BPST(BP59,0)),U,3)  ;$$GET1^DIQ(9002313.59,BP59,3,"I") I 'CLAIM Q 0
 ; get closed status
 Q +$P($G(^BPSC(BPCLAIM,900)),U)=1  ;Q $$GET1^DIQ(9002313.02,CLAIM,901,"I")
 ;
