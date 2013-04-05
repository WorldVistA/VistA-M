FBAAVR6 ;WOIFO/SAB - RESEND VOUCHER BATCH MSG ;4/19/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; ICRs
 ;  #10004 EN^DIQ
 ;  #10006 ^DIC
 ;  #10026 ^DIR
 Q
 ;
RESEND ; called by the FBAA RESEND VOUCHER MSG option
 ;
 W !,"This option is used to resend a Voucher Batch message to Central"
 W !,"Fee when the acknowledgement message reported an error or is"
 W !,"overdue.  An acknowledgement is considered overdue if it has not"
 W !,"been received by the 3rd weekday after the Voucher Batch message"
 W !,"was transmitted to Central Fee."
 W !
 W !,"The National Service Desk Austin should be contacted to determine"
 W !,"the status of the voucher batch message before using this option"
 W !,"for an overdue acknowledgement.  If Central Fee already has the"
 W !,"voucher batch message, you should request that Central Fee resend"
 W !,"the acknowledgement message.  If Central Fee does not have the"
 W !,"voucher batch message then use this option to reprocess it.",!
 ;
 N DA,DIC,DIR,DIRUT,DR,DTOUT,DUOUT,FBDT,FBN,FBVMAS,FBX,X,Y
 ;
 ; determine date that is 3 weekdays prior to the current date
 S FBDT=$$CALCDT^FBAADD1(3,DT)
 ;
BT ; select batch
 S DIC="^FBAA(161.7,",DIC(0)="AEQ"
 D  ; set screen
 . N FBX1,FBX2,FBX3
 . ; logic
 . ; STATUS = VOUCHERED and
 . ; VOUCHER MSG ACK STATUS=ERROR or
 . ; VOUCHER MSG ACK STATUS=PENDING and VOUCHER MSG DATE not after FBDT 
 . S FBX1="I ($G(^(""ST""))=""V"")"
 . S FBX2="$P($G(^(1)),""^"",3)=""E"""
 . S FBX3="$P($G(^(1)),""^"",3)=""P""&($P($G(^(1)),""^"",2)'>"_FBDT_")"
 . S DIC("S")=FBX1_"&("_FBX2_"!("_FBX3_"))"
 D ^DIC K DIC G END:Y<0
 L +^FBAA(161.7,+Y):$G(DILOCKTM,3)
 I '$T W !,"Another user is editing this batch.  Try again later." G BT
 S FBN=+Y
 S FBVMAS=$P($G(^FBAA(161.7,FBN,1)),U,3) ; voucher message ack status
 ;
 ; display batch
 S DIC="^FBAA(161.7,",DA=FBN,DR="0:1;ST" W !! D EN^DIQ
 ;
 ; confirm help desk was contacted
 I FBVMAS="P" D  G:$D(DIRUT)!'Y END
 . S DIR(0)="Y"
 . S DIR("A")="Have you confirmed that Central Fee did not receive the voucher msg."
 . W !
 . D ^DIR K DIR
 . I 'Y W !,"Please contact the National Service Desk Austin to determine",!,"if Central Fee received the voucher message."
 ;
 ; confirm
 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Are you sure you want to resend the voucher batch message"
 D ^DIR K DIR G:$D(DIRUT)!'Y END
 ;
 ; generate voucher batch message
 S FBX=$$VBMSG^FBAAVR5(FBN)
 I FBX W !,"Voucher Batch message # "_FBX_" sent to Central Fee."
 I 'FBX D  G END
 . W !,"Error occurred during creation of voucher batch message."
 . W !,"  ",$P(FBX,U,2)
 ;
 ; display batch
 S DIC="^FBAA(161.7,",DA=FBN,DR="0:1;ST" W !! D EN^DIQ
 ;
END ;
 I $G(FBN) L -^FBAA(161.7,FBN)
 Q
 ;
 ;FBAAVR6
