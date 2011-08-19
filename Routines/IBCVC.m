IBCVC ;ALB/WCJ - VALUE CODE FUNCTIONALITY ;25-JUN-07
 ;;2.0;INTEGRATED BILLING;**371,400**;21-MAR-94;Build 52
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 G AWAY
AWAY Q
 ;
ALLOWVC(IBIFN,Y)   ; see if the value code is obsolete.
 ; returns 0 = Not Allowed/Obsolete
 ; returns 1 = Allowed
 ;
 N OBSDT,SCF
 S OBSDT=$$GET1^DIQ(399.1,Y,.26,"I")
 D CLEAN^DILF
 Q:'+OBSDT 1  ; If there is no obsolete date, were cool
 ;
 S SCF=$$GET1^DIQ(399,IBIFN,151,"I")  ; get the statement covers from date to compare with
 D CLEAN^DILF
 I 'SCF Q 0  ; if there is none, not sure where to go with this.  It's required so I say fail.
 ;
 I SCF>OBSDT Q 0
 ;
 Q 1
 ;
HELP ;
 Q:'$G(DA)
 Q:'$G(DA(1))
 Q:'$D(^DGCR(399,DA(1),"CV",DA,0))
 N VCPTR
 S VCPTR=$P($G(^DGCR(399,DA(1),"CV",DA,0)),U)
 Q:VCPTR=""
 Q:'$D(^DGCR(399.1,VCPTR,1))
 N LOOP
 S LOOP=0 F  S LOOP=$O(^DGCR(399.1,VCPTR,1,LOOP)) Q:'+LOOP  D
 . W !,$G(^(LOOP,0))
 Q
 ;
FORMCHK(X,DA) ; Check to make sure that the VALUE is in the correct format base on the VALUE CODE.
 ; This tag is the input transform for the VALUE field (Sub-File 399.047, field .02).
 ; 
 ; X = data being verified
 ; DA = subfile entry
 ; DA(1) = IEN to 399
 ; 
 ; returns
 ; 0 = invalid format
 ; 1 = valid format
 ; 
 Q:'$G(DA) 0
 Q:'$G(DA(1)) 0
 Q:'$D(^DGCR(399,DA(1),"CV",DA,0)) 0
 ;
 N VCPTR
 S VCPTR=$P($G(^DGCR(399,DA(1),"CV",DA,0)),U)
 Q:VCPTR="" 0
 ; 
 Q $$CHK(VCPTR,X)
 ;
CHK(VCPTR,X) ; This tag is called from the input transform above and also from the IB edit check routines (IBCBB*) 
 ; This function is passed in:
 ; VCPTR - pointer into file #399.1
 ; X - the VALUE being checked
 ; Returns:
 ; 0 or false - Invalid format or can't figure it out.
 ; 1 or true  - valid format (or in the case of 24, defined at the state level)
 ; 
 N CODE,OK
 S CODE=$$GET1^DIQ(399.1,VCPTR_",",.02,"I")
 D CLEAN^DILF
 Q:CODE="" 0
 ;
 N AMTFLG
 ;
 ; Check to see if it goes out as a monetary amount.
 S AMTFLG=$$GET1^DIQ(399.1,VCPTR_",",.19,"I")
 D CLEAN^DILF
 I AMTFLG Q X?1(1.7N,.7N1"."1.2N)
 ;
 ; Medicaid Rate Code (This is defined at the state level)
 Q:CODE=24 1
 ;
 ; Accident Hour
 I CODE=45 Q ".00.01.02.03.04.05.06.07.08.09.10.11.12.13.14.15.16.17.18.19.20.21.22.23.99."[("."_X_".")
 ;
 ; Whole Numbers
 I ".37.38.39.46.50.51.52.53.56.57.58.59.67.68.80.81.82."[("."_CODE_".") Q X?1.7N
 ;
 ; Zip
 I CODE="A0" Q X?5N
 ;
 I ".48.49."[("."_CODE_".") S OK=1 D  Q OK
 . I $P(X,".")'?.2N S OK=0 Q
 . I $P(X,".",2,999)'?.1N S OK=0 Q
 . I $E(X,$L(X))="." S OK=0 Q
 ;
 ; Alpha Numeric, no punctuation
 I ".60.61."[("."_CODE_".") Q X?1.7AN
 Q 1
 ;
REMOVE(DA) ; Remove the VALUE field since it's in the wrong format.
 ; This is called from a NEW STYLE X-REF "AC" in file 399.047 field .01
 N IENS,FDA
 Q:'$G(DA)!'$G(DA(1))
 S IENS=DA_","_DA(1)_","
 S FDA(399.047,IENS,.02)="@"
 D FILE^DIE(,"FDA")
 D CLEAN^DILF
 Q
 ;
COND(DA,OLDVC,NEWVC) ; Check if the VALUE is in a valid format for the new VALUE CODE.
 ; This is called from a NEW STYLE X-REF "AC" in file 399.047 field .01
 ; This function will return:
 ; 1 - Means that this VALUE should be deleted (It's in the wrong format)
 ; 0 - Means that this VALUE should NOT be deleted
 Q:'$G(OLDVC) 0
 Q:'$G(DA)!'$G(DA(1)) 0
 N OLDVALUE
 S OLDVALUE=$P($G(^DGCR(399,DA(1),"CV",DA,0)),U,2)
 Q:OLDVALUE="" 0
 Q '$$CHK(NEWVC,OLDVALUE)
