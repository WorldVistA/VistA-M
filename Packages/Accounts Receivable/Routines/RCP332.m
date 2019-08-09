RCP332 ;AITC/CJE,hrubovcak - ePayment Lockbox Post-Installation Processing ;4 Oct 2018 10:29:18
 ;;4.5;Accounts Receivable;**332**;Oct 4, 2018;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST ;
 N RCMSG,X,Y
 D BMES^XPDUTL("PRCA*4.5*332 post-installation work "_$$HTE^XLFDT($H)) ; add date/time to log
 ;
 ;(#.13) TRICARE EFT POST PREVENT DAYS [13N] update is idempotent if value is in-bounds
 S RCMSG="TRICARE EFT POST PREVENT DAYS" D  ; RCMSG holds action performed
 . S X(344.61,0)=$G(^RCY(344.61,1,0)),Y=$P(X(344.61,0),U,13),RCMSG("prev")=Y
 . ; minimum is 14 days, maximum is 60
 . I (Y>13)&(Y<61) S RCMSG=RCMSG_" value is "_Y_" days. No action taken." K RCMSG("prev") Q  ; minimum is 14 days, maximum is 60
 . L +^RCY(344.61,1):DILOCKTM E  D  Q  ; exclusive access
 ..  S RCMSG="Error, unable to update "_RCMSG_"  Cannot LOCK entry."
 . ; set default to 30
 . N RCFDA,RCFMERR
 . S RCFDA(344.61,"1,",.13)=30  ; only 1 entry in 344.61
 . D FILE^DIE("","RCFDA","RCFMERR")
 . I $D(RCFMERR) D  Q  ; handle FileMan error
 ..  S RCMSG=RCMSG_" not updated due to error."
 ..  S X="RCFMERR" F  S X=$Q(@X) Q:X=""  S Y=@X D BMES^XPDUTL(Y)  ; put error text into log
 . S X(344.61,0)=$G(^RCY(344.61,1,0)),Y=+$P(X(344.61,0),U,13)
 . L -^RCY(344.61,1) S RCMSG=RCMSG_" set to "_Y_" days."
 ;
 K X,Y D BMES^XPDUTL(RCMSG)
 D:$D(RCMSG("prev")) MES^XPDUTL("The previous value was "_$C(34)_RCMSG("prev")_$C(34)_".")
 ; end TRICARE EFT POST PREVENT DAYS update
 ;
 ; (#.07) PHARMACY EFT POST PREVENT DAYS [7N] update is idempotent if value null or in-bounds
 K RCMSG
 S RCMSG="PHARMACY EFT POST PREVENT DAYS" D  ; RCMSG holds action performed
 . S X(344.61,0)=$G(^RCY(344.61,1,0)),Y=$P(X(344.61,0),U,7),RCMSG("prev")=Y
 . I Y="" S RCMSG=RCMSG_" value has not been entered. No action taken." Q  ; field is null, nothing to do
 . I (Y>20)&(Y<100) S RCMSG=RCMSG_" value is "_Y_" days. No action taken." K RCMSG("prev") Q   ; minimum is 21 days, maximum is 99
 . L +^RCY(344.61,1):DILOCKTM E  D  Q  ; exclusive access
 ..  S RCMSG="Error, unable to update "_RCMSG_"  Cannot LOCK entry."
 . ; value is out-of-bounds, fix it
 . N RCFDA,RCFMERR
 . S RCFDA(344.61,"1,",.07)=$S(Y<21:21,1:99)  ; only 1 entry in 344.61
 . D FILE^DIE("","RCFDA","RCFMERR")
 . I $D(RCFMERR) D  Q  ; handle FileMan error
 ..  S RCMSG=RCMSG_" not updated due to error."
 ..  S X="RCFMERR" F  S X=$Q(@X) Q:X=""  S Y=@X D BMES^XPDUTL(Y)  ; put error text into log
 . S X(344.61,0)=$G(^RCY(344.61,1,0)),Y=+$P(X(344.61,0),U,7)
 . L -^RCY(344.61,1) S RCMSG=RCMSG_" set to "_Y_" days."
 ;
 K X,Y D:$L(RCMSG) BMES^XPDUTL(RCMSG)  ; if RCMSG null nothing was updated
 D:$D(RCMSG("prev")) MES^XPDUTL("The previous value was "_$C(34)_RCMSG("prev")_$C(34)_".")
 ; end PHARMACY EFT POST PREVENT DAYS update
 ;
 D BMES^XPDUTL("Fixing ERA numbers...")
 D FIX3444
 ;
 D BMES^XPDUTL("PRCA*4.5*332 post-installation finished "_$$HTE^XLFDT($H))
 Q
 ;
 ;
FIX3444 ; Repair Internal Entry Numbers in 344.4 where IEN is not equal to .01
 N IEN,ENTRY
 S IEN=0
 F  S IEN=$O(^RCY(344.4,IEN)) Q:'IEN  D  ;
 . S ENTRY=$P($G(^RCY(344.4,IEN,0)),"^",1)
 . I 'ENTRY Q
 . I ENTRY'=IEN D  ;
 . . N FDA
 . . S FDA(344.4,IEN_",",.01)=IEN
 . . D FILE^DIE("","FDA")
 Q
