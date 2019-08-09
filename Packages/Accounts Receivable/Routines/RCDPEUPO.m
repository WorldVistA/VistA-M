RCDPEUPO ;ALBANY/KML - Unposted EFT Override ;3 Oct 2018 10:46:35
 ;;4.5;Accounts Receivable;**298,332**;Mar 20, 1995;Build 40
 ;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
 ; prca*4.5*298 - procedures built to implement the Unposted EFT Override option
 ;
EN ;  Display warning message when aged, unposted EFTs exist
 N MSG
 D OWNSKEY^XUSRB(.MSG,"RCDPE AGED PMT",DUZ)
 I 'MSG(0) D NOENTRY Q
 N AGEDEFTS
 S AGEDEFTS=$$GETEFTS^RCDPEWLP("A",1)  ; need to examine both medical and pharmacy EFTs
 D DMSGS(AGEDEFTS)
 Q
 ;
DMSGS(CODES) ; display warning/error messages (if any)
 ; Input:   CODES   
 ; 1P - error condition for aged, unposted Pharmacy EFTs
 ; 2P - warning condition for aged,unposted Pharmacy EFTs
 ; 3P - Override exists for aged, unposted pharmacy EFTs
 ; 1M - error condition for aged, unposted Medical EFTs
 ; 2M - warning condition for aged, unposted Medical EFTs
 ; 3M - Override exists for aged, unposted Medical EFTs
 ; 1T - error condition for aged, unposted Tricare EFTs
 ; 2T - warning condition for aged, unposted Tricare EFTs
 ; 3T - Override exists for aged, unposted Tricare EFTs
 ;  0 - no error or warning conditions
 ;  possible values:
 ; "1P" or "2P" or "3P" or "1M" or "2M" or "3M" or "1P^1M" or "1P^2M" or
 ; "1P^3M" or "2P^1M" or "2P^2M" or "2P^3M" or "3P^1M" or "3P^2M" or "3P^3M"
 I 'CODES D NONE Q
 N DAYSLIMT,DIR,ERROR,I,LN,MSGTXT,OVERRIDE,S1,S2,STATE,TYPE,X,Y
 S (OVERRIDE,ERROR)=0
 S DIR("A",1)="Current Warning and/or Error messages for Unposted EFTs:"
 S DIR("A",2)=" ",LN=2
 F I=1:1 S STATE=$P(CODES,U,I) Q:STATE=""  D
 . S S1=$E(STATE,1),S2=$E(STATE,2)
 . I S1=1 D  ; 1 = ERROR
 ..  S ERROR=1,TYPE=$G(TYPE)_S2
 ..  ; Number of days an EFT can age before post prevention rules apply
 ..  S DAYSLIMT=$$GET1^DIQ(344.61,1,$S(S2="M":.06,S2="P":.07,1:.13))
 ..  S LN=LN+1
 ..  S DIR("A",LN)="ERROR: Unposted "_$S(S2="P":"pharmacy ",S2="M":"medical ",1:"TRICARE ")
 ..  S DIR("A",LN)=DIR("A",LN)_"EFTs exist that are more than "_DAYSLIMT_" days old."
 ..  S LN=LN+1,DIR("A",LN)="Scratchpad creation is not allowed for newer payments."
 ..  S LN=LN+1,DIR("A",LN)=" "
 . I S1=2 D  ; 2 = warning
 ..  S LN=LN+1
 ..  S DIR("A",LN)="WARNING: Unposted "_$S(S2="P":"pharmacy ",S2="M":"medical ",1:"TRICARE ")
 ..  S DIR("A",LN)=DIR("A",LN)_"EFTs exist that are more than "
 ..  S DIR("A",LN)=DIR("A",LN)_$S(S2="P":21,1:14)_" days old."
 ..  S LN=LN+1,DIR("A",LN)=" "
 . I S1=3 D  ; OVERRIDE
 ..  S OVERRIDE=OVERRIDE+1
 ..  S LN=LN+1,DIR("A",LN)="An Override for "_$S(S2="P":"pharmacy ",S2="M":"medical ",1:"TRICARE ")
 ..  S DIR("A",LN)=DIR("A",LN)_"is already in place."
 ..  S LN=LN+1,DIR("A",LN)=" "
 I OVERRIDE=3 D  Q
 . S DIR(0)="EA",DIR("A")="Press ENTER to continue: "
 . D ^DIR
 I ERROR D
 . M MSGTXT=DIR("A")
 . S DIR(0)="YA"
 . S LN=LN+1,DIR("A",LN)="An override will allow unrestricted scratchpad creation for one day."
 . S DIR("A")="Do you want to continue (Y/N)? "
 . D ^DIR
 . Q:'Y
 . S OVERRIDE=$$OVERRIDE(TYPE,.MSGTXT)
 . I OVERRIDE D MAIL(.MSGTXT)
 I 'ERROR D
 . S LN=LN+1,DIR("A",LN)="There are no error conditions to override."
 . S LN=LN+1,DIR("A",LN)=" ",DIR("A")="Press ENTER to continue: "
 . S DIR(0)="EA" D ^DIR
 Q
 ;
OVERRIDE(TYPE,TEXT) ; when ERROR state exists, perform the Override
 ; Input:   TYPE    - "M" Medical
 ;                    "P" Phamacy
 ;                    "T" - Tricare
 ;                    Any combination of above flags
 ;          TEXT    - Warning and/or error statements; passed by reference
 ; Output:  TEXT    - Additional text to be displayed with warning and/or error statements
 ;                    contents of TEXT array will be in the body of the mail message
 ;                    (refer to MAIL tag)
 ; Returns: DONE    - 1 - OVERRIDE was performed;  0 - Override was not performed
 ;
 N DIR,DIRUT,DONE,DTTM,DUOUT,RCDFDA,REASON,X1,Y
 L +^RCY(344.61,1,0):DILOCKTM E  D NOLOCK S DONE=0 G OVERQ
 S DONE=1
 I TYPE="P"!(TYPE="M")!(TYPE="T") D
 . S DIR(0)="EA",DIR("A",1)="An Override now exists for posting "
 . S DIR("A",1)=DIR("A",1)_$S(TYPE="P":"pharmacy ",TYPE="M":"medical ",1:"TRICARE ")_"payments."
 . S DIR("A",2)=" "
 . S DIR("A")="Press ENTER to continue: "
 . D ^DIR
 I $L(TYPE)>1 D  I 'DONE G OVERQ
 . S DIR(0)="SA^"
 . S:TYPE["M" DIR(0)=DIR(0)_"M:Medical;"
 . S:TYPE["P" DIR(0)=DIR(0)_"P:Pharmacy;"
 . S:TYPE["T" DIR(0)=DIR(0)_"T:TRICARE;"
 . I $L(TYPE)=3 S DIR("A")="Override for (M)edical, (P)harmacy or (T)RICARE? "
 . E  D
 . . S DIR("A")="Override for "
 . . I (TYPE="PM")!(TYPE="MP") S DIR("A")=DIR("A")_"(M)edical or (P)harmacy? "
 . . E  I (TYPE="PT")!(TYPE="TP") S DIR("A")=DIR("A")_"(P)harmacy or (T)RICARE? "
 . . E  S DIR("A")=DIR("A")_"(M)edical or (T)RICARE? "
 . D ^DIR
 . I $D(DUOUT)!($D(DIRUT)) S DONE=0 Q
 . S TYPE=Y
 W !
 K DIR
 S DIR("A")="Reason for Override: ",DIR(0)="FA^1:50"
 D ^DIR
 I $D(DUOUT)!($D(DIRUT)) D  G OVERQ
 . S DONE=0
 . W !!,"   Need to enter a reason for Override.",!,"   Override not performed.",!
 S REASON=Y,DTTM=$$NOW^XLFDT
 S RCDFDA(344.61,"1,",$S(TYPE="M":20,TYPE="P":21,1:26))=DTTM
 S RCDFDA(344.61,"1,",$S(TYPE="M":22,TYPE="P":23,1:27))=DUZ
 S RCDFDA(344.61,"1,",$S(TYPE="M":24,TYPE="P":25,1:28))=REASON
 D FILE^DIE("","RCDFDA")
 S X1="" S X1=$O(TEXT(X1),-1)
 S X1=X1+1
 S TEXT(X1)=$S(TYPE="M":"Medical ",TYPE="P":"Pharmacy ",1:"TRICARE ")_"Override Details"
 S X1=X1+1
 S TEXT(X1)="User: "_$P($G(^VA(200,DUZ,0)),"^") S X1=X1+1
 S TEXT(X1)="Date/Time: "_DTTM
 S TEXT(X1)="Reason for Override: "_REASON
OVERQ ;
 L -^RCY(344.61,1,0)
 Q DONE
 ;
MAIL(TEXT) ;generate mail message when OVERRIDE is implemented
 ; Input:   TEXT    - Lines of text that represent the body of the mail message
 ;
 N ARRAY,CNT,CNT1,GLB,RCPROG1,SBJ,SUB
 S RCPROG1="RCDUPEO",GLB=$NA(^TMP(RCPROG1,$J,"XMTEXT"))
 ;
 ;Build header
 S SUB="EFT" K @GLB
 S SBJ="EDI LBOX-STA# "_$P($$SITE^VASITE,"^",3)_"-Unposted EFTs Override "_$$FMTE^XLFDT($$NOW^XLFDT)
 M @GLB=TEXT
 N XMDUZ,XMINSTR,XMSUB,XMTEXT,XMY
 S XMDUZ=DUZ,XMTEXT=GLB,XMSUB=SBJ,XMY("I:G.RCDPE AUDIT")=""
 S XMINSTR("FROM")="POSTMASTER"
 S XMINSTR("FLAGS")="P"
 D SENDMSG^XMXAPI(XMDUZ,XMSUB,XMTEXT,.XMY,.XMINSTR)
 Q
 ;
CHECK(TYPE,OVERRIDE) ; Determine if override exists for today's date
 ; Input:   TYPE        - "M" for medical, "P" for Pharmacy or "T" for Tricare
 ;          OVERRIDE    - Passed by reference; array to hold the OVERRIDE data
 ; Output:  OVERRIDE    - Returned array holding existing OVERRIDE data
 K OVERRIDE
 ;
 ; Get MEDICAL EFT OVERRIDE (344.61, 20), PHARMACY EFT OVERRIDE (344.61, 21) or
 ; TRICARE EFT OVERRIDE (344.61, 20) date dependent on type of EFTs
 S OVERRIDE(TYPE)=+$$GET1^DIQ(344.61,1,$S(TYPE="M":20,TYPE="P":21,1:26),"I")
 I 'OVERRIDE(TYPE) K OVERRIDE(TYPE) S OVERRIDE=0 Q
 ;
 ; Override does not exist for 'TODAYS' date,  post prevention rules will apply
 I $P(OVERRIDE(TYPE),".")'=DT K OVERRIDE(TYPE)  S OVERRIDE=0 Q
 S OVERRIDE=1
 Q
 ;
NONE ; the system does not have any aged, unposted EFTs
 N DIR
 S DIR(0)="EA"
 S DIR("A",1)="The sytem does not have any aged, unposted EFTs."
 S DIR("A",2)="Therefore, no error conditions to override."
 S DIR("A",3)=" "
 S DIR("A")="Press ENTER to continue: "
 D ^DIR
 Q
 ;
NOACTION ; OVERRIDE already exists
 ; Input:   TYPE    - "M" for medical, "P" for Pharmacy or "T" for Tricare
 N DIR
 S DIR(0)="EA"
 S DIR("A",1)="An Override for "_$S(TYPE="P":"pharmacy ",TYPE="M":"medical ",1:"TRICARE ")
 S DIR("A",1)=DIR("A",1)_"is already in place."
 S DIR("A",2)="No action needed"
 S DIR("A",3)=" "
 S DIR("A")="Press ENTER to continue: "
 D ^DIR
 Q
 ;
NOENTRY ;  user is not authorized to use the option
 N DIR
 S DIR(0)="EA"
 S DIR("A",1)="You are not authorized to use this option."
 S DIR("A",2)="This option is locked with RCDPE AGED PMT key."
 S DIR("A",3)=" "
 S DIR("A")="Press ENTER to continue: "
 D ^DIR
 Q
 ;
NOLOCK ; entry at 344.61 cannot be locked
 N DIR
 S DIR(0)="EA"
 S DIR("A",1)="Another user is editing the Override Parameters."
 S DIR("A",2)="Try again later."
 S DIR("A",3)=" "
 S DIR("A")="Press ENTER to continue: "
 D ^DIR
 Q
 ;
