IBCIST ;DSI/SLM - ENTRY POINTS FOR CLAIMSMANAGER INTERFACE ;7-MAR-2001
 ;;2.0;INTEGRATED BILLING;**161**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
ST1 ;add or update in 351.9
 Q:'$D(IBIFN)
 Q:$$CK1^IBCIUT1(IBIFN)     ; Exit if the bill is not a HCFA-1500
 K IBCIREDT     ; remove the re-edit flag upon start of bill edit
 ;
 ; If the bill is not editable, then just quit.
 ; This can happen in the IB PRINT BILL option when the user wants to
 ; review the IB screens on a bill that has already been authorized.
 ; esg - 5/22/01
 ;
 I '$F(".1.","."_$P($G(^DGCR(399,IBIFN,0)),U,13)_".") Q  ;DSI/DJW 3/21/02
 ;
 I '$D(^IBA(351.9,IBIFN)) D ADD^IBCIADD1 Q
 D UPDT1,OVRDN,UPDT^IBCIADD1
ST1Q Q
 ;
ST2 ;send to claimsmanager
 ;  When calling ST2 the following 4 variables will always be returned:
 ;    IBCISNT  - identifies where it was sent from
 ;    IBCIERR  - error code if error condition
 ;    IBCISTAT - claim status in 351.9
 ;    IBCIREDT - re-edit flag
 ;
 I '$D(IBIFN) Q                        ; check for ibifn
 I '$D(IBCISNT) Q                      ; check for this variable
 I IBCISNT'=7 D CKFT^IBCIUT1(IBIFN)    ; check for form type change
 I IBCISNT'=7,$$CK1^IBCIUT1(IBIFN) Q   ; check for hcfa 1500
 I '$D(^IBA(351.9,IBIFN)) Q            ; check for existence in 351.9
 ;
 NEW IBCIMT
 S IBCIERR="",IBCIREDT=0,IBCIMT=$$ENV^IBCIUT5
 ;
 ;if claimsmanager not working okay update status and quit
 I '$$CK2^IBCIUT1() D  G ST2Q
 .I IBCISNT=1 S (IBCIST,IBCISTAT)=7 D ST^IBCIUT1(IBCIST) Q
 .I IBCISNT=2 S (IBCIST,IBCISTAT)=7 D ST^IBCIUT1(IBCIST) Q
 .I IBCISNT=3 Q
 .I IBCISNT=4 S (IBCIST,IBCISTAT)=10 D ST^IBCIUT1(IBCIST) Q
 .I IBCISNT=5 S (IBCIST,IBCISTAT)=11 D ST^IBCIUT1(IBCIST) Q
 .I IBCISNT=6 S (IBCIST,IBCISTAT)=7 D ST^IBCIUT1(IBCIST) Q
 ;
 ;normal send
 I IBCISNT=1 D MSG1,SEND D  G ST2Q
 .D UPDT1,UPDT2
 .I IBCISTAT=6 D MSG3
 .I IBCISTAT=3 D MSG2
 .I IBCISTAT=4 D EN^IBCIWK(1)
 ;
 ;multiple send option - not authorized
 I IBCISNT=2 D  G ST2Q
 .I '$$CKLI^IBCIUT1(IBIFN) Q       ; check for line items
 .D SEND
 .D UPDT1,UPDT2
 .I IBCISTAT=4 D
 ..N IBCIETP
 ..S IBCIETP=""
 ..F  S IBCIETP=$O(^IBA(351.9,IBIFN,1,"B",IBCIETP)) Q:IBCIETP=""  D GENERR^IBCIUT4(IBIFN,IBCIETP)
 ..Q
 ;
 ;test send
 I IBCISNT=3 D  G ST2Q
 .D MSG1,SEND
 .I IBCISTAT=3 D MSG2
 ;
 ;cancelled
 I IBCISNT=4 D  G ST2Q
 .D COMMENT^IBCIUT7(IBIFN,3)
 .; if the bill has never been sent to CM or if there are currently
 .; no line items on the bill, then just change the status and quit
 .I '$P(^IBA(351.9,IBIFN,0),U,15)!('$$CKLI^IBCIUT1(IBIFN)) D  Q
 ..S IBCIST=9 D ST^IBCIUT1(IBCIST)
 ..D DELTI^IBCIUT4   ;delete temp nodes on a cancel even when not sending to claimsmanager
 .D UPDT1,UPDT2,SEND
 ;
 ;overridden
 I IBCISNT=5 D  G ST2Q
 .D UPDT1,UPDT2,OVRDN1,SEND
 ;
 ;multiple send option - authorized
 I IBCISNT=6 D  G ST2Q
 .I '$$CKLI^IBCIUT1(IBIFN) Q       ; check for line items
 .D UPDT1,UPDT2,SEND
 ;
 ;
 ; Notes about IBCISNT=7 - esg - 1/3/2002
 ; User changed the form type from a HCFA into a UB and this bill
 ; has been previously sent to ClaimsManager as a HCFA.  So this
 ; bill is currently a UB bill, but we need to send it to
 ; ClaimsManager in order to delete the line items over there.
 ; Ultimately, this bill will get deleted from 351.9, but we have
 ; to send it over there first.
 ;
 I IBCISNT=7 D  G ST2Q
 . I '$$CKLI^IBCIUT1(IBIFN) Q      ; check for line items
 . D SEND
 . Q
 ;
 ;
ST2Q D CLEAN1^IBCIUT2 K PROBLEM
 Q
 ;
SEND ; send the bill to claimsmanager
 I $$ASND^IBCIUT2(IBIFN) G SENDX    ; no tcp/ip problems
 D COMERR^IBCIUT4                   ; communications error mail message
 I PROBLEM'=99 D CLRCMQ^IBCIUT6(0)  ; clear CM queue (silent mode)
SENDX ;
 Q
 ;
UPDT1 ; update certain fields when editing
 ; update the Date/Time Last Edited field (.08)
 ; update the User Last Edited field (.09)
 ;
 N IENS,FDA
 S IENS=IBIFN_",",FDA(351.9,IENS,.08)=$$NOW^XLFDT,FDA(351.9,IENS,.09)=DUZ
 D FILE^DIE("K","FDA")
 Q
 ;
UPDT2 ; update certain fields when sending
 ; update the Entered By User field if not there (.07)
 ; update the Date/Time Entered field if not there (.06)
 ; update the number of times sent to ClaimsManager (.04)
 ; update the Date/Time last sent to ClaimsManager (.03)
 ; update the Last Sent By User field (.05)
 ;
 N IENS,FDA,IBCIEB,IBCIDE
 S IENS=IBIFN_","
 I $P(^IBA(351.9,IBIFN,0),U,7)="" S FDA(351.9,IENS,.07)=DUZ
 I $P(^IBA(351.9,IBIFN,0),U,6)="" S FDA(351.9,IENS,.06)=$$NOW^XLFDT
 S IBCILSI=$$NOW^XLFDT,CTR=$S($P(^IBA(351.9,IBIFN,0),U,4)]"":$P(^(0),U,4),1:0)
 S IBCITSI=CTR+1,FDA(351.9,IENS,.04)=IBCITSI
 S FDA(351.9,IENS,.03)=IBCILSI,FDA(351.9,IENS,.05)=DUZ
 D FILE^DIE("K","FDA")
 Q
 ;
OVRDN ;clear if overridden
 N IENS,FDA
 I $P(^IBA(351.9,IBIFN,0),U,10)]"" D
 .S IENS=IBIFN_","
 .S FDA(351.9,IENS,.1)="",FDA(351.9,IENS,.11)=""
 .D FILE^DIE("K","FDA")
 Q
OVRDN1 ;set if overridden
 N IENS,FDA
 S IENS=IBIFN_","
 S FDA(351.9,IENS,.1)=1,FDA(351.9,IENS,.11)=DUZ
 D FILE^DIE("K","FDA")
 Q
MSG1 ;display 'sending to ClaimsManager' message
 W !!,"... ",$S(IBCIMT="T":"TEST-",1:""),"Sending ",$P(^DGCR(399,IBIFN,0),U)," to ClaimsManager"
 Q
MSG2 ;display 'no errors found' message
 W !!,"No Errors found by ClaimsManager"
 Q
MSG3 ;display 'comm error' messsage
 W !!,"Communications Error - Not Sent to ClaimsManager"
 W !?3,$P(IBCIERR,U,2)
 I $P(IBCIERR,U,3)'="" D
 . W !?3,$P($P(IBCIERR,U,3)," - ",1)
 . W !?3,$P($P(IBCIERR,U,3,99)," - ",2,99)
 . Q
 Q
MSG4 ;display 'no line items' message
 W !!,"There are no line items associated with this claim."
 W !!,"ClaimsManager cannot process without line items. Please"
 W !,"enter the line item data and resend."
 Q
MSG5 ;display 'cancelled' message
 W !!,"... Claim has been CANCELLED in ClaimsManager."
 Q
