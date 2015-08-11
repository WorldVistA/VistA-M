RCDPEUPO ;ALBANY/KML - Unposted EFT Override ;Jun 06, 2014@19:11:19
 ;;4.5;Accounts Receivable;**298**;Mar 20, 1995;Build 121
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
 S AGEDEFTS=$$GETEFTS^RCDPEWLP("B",1)  ; need to examine both medical and pharmacy EFTs
 D DMSGS(AGEDEFTS)
 Q
 ;
DMSGS(CODES) ; display warning/error messages (if any)
 ;
 ;          Input - CODES = 1P - error condition for aged, unposted pharmacy EFTs
 ;                        = 2P - warning condition for aged,unposted medical EFTs
 ;                        = 3P  - Override exists for aged, unposted pharmacy EFTs
 ;                        = 1M - error condition for aged, unposted medical EFTs
 ;                        = 2M - warning condition for aged, unposted medical EFTs
 ;                        = 3M  - Override exists for aged, unposted medical EFTs
 ;                        = 0  - there exist no error or warning conditions
 ;  possible values for CODES = "1P" or "2P" or "3P" or "1M" or "2M" or "3M" or "1P^1M" or "1P^2M" or"
 ;                               "1P^3M" or "2P^1M" or "2P^2M" or "2P^3M" or "3P^1M" or "3P^2M" or "3P^3M"
 I 'CODES D NONE Q
 N DAYSLIMT,DIR,ERROR,I,LN,MSGTXT,OVERRIDE,STATE,TYPE,X,Y
 S LN=3
 S (OVERRIDE,ERROR)=0
 S DIR("A",1)="Current Warning and/or Error messages for Unposted EFTs:"
 S DIR("A",2)=" "
 F I=1:1 S STATE=$P(CODES,U,I) Q:STATE=""  D
 . I $E(STATE,1)=1 D  ; 1 = ERROR condition
 . . S ERROR=1,TYPE=$G(TYPE)_$E(STATE,2)
 . . S DAYSLIMT=$$GET1^DIQ(344.61,1,$S($E(STATE,2)="M":.06,1:.07))   ; number of days an EFT can age before post prevention rules apply
 . . S DIR("A",LN)="ERROR: Unposted "_$S($E(STATE,2)="P":"pharmacy ",1:"medical ")_"EFTs exist that are more than "_DAYSLIMT_" days old." S LN=LN+1
 . . S DIR("A",LN)="Scratchpad creation is not allowed for newer payments." S LN=LN+1
 . . S DIR("A",LN)=" " S LN=LN+1
 . I $E(STATE,1)=2 D  ; 2 = warning condition
 . . S DIR("A",LN)="WARNING: Unposted "_$S($E(STATE,2)="P":"pharmacy ",1:"medical ")_"EFTs exist that are more than "_$S($E(STATE,2)="P":21,1:14)_" days old." S LN=LN+1
 . . S DIR("A",LN)=" " S LN=LN+1
 . I $E(STATE,1)=3 D  ;OVERRIDE condition
 . . S OVERRIDE=OVERRIDE+1
 . . S DIR("A",LN)="An Override for "_$S($E(STATE,2)="P":"pharmacy ",1:"medical ")_"is already in place." S LN=LN+1
 . . S DIR("A",LN)=" "
 I OVERRIDE=2 S DIR(0)="EA",DIR("A")="Press ENTER to continue: " D ^DIR Q
 I ERROR D
 . M MSGTXT=DIR("A")
 . S DIR(0)="YA",DIR("A",LN)="An override will allow unrestricted scratchpad creation for one day."
 . S DIR("A")="Do you want to continue (Y/N)? " D ^DIR
 . Q:'Y
 . S OVERRIDE=$$OVERRIDE(TYPE,.MSGTXT)
 . I OVERRIDE D MAIL(.MSGTXT)
 I 'ERROR D
 . S DIR(0)="EA",DIR("A",LN)="There are no error conditions to override.",LN=LN+1
 . S DIR("A",LN)=" ",DIR("A")="Press ENTER to continue: "
 . D ^DIR
 Q
 ;
OVERRIDE(TYPE,TEXT) ; when ERROR state exists, perform the Override
 ;
 ;   Input - TYPE = "M" (medical); "P" (phamacy); "PM" or "MP"(aged, unposted EFTs exist for both medical and pharmacy claims)
 ;           TEXT = warning and/or error statements; passed by reference
 ;   Output - DONE = 1 - OVERRIDE was performed;  0 - Override was not performed
 ;            TEXT = additional text to be displayed with warning and/or error statements; contents of TEXT array will be in the body of the mail message ( refer to MAIL tag)
 ;
 N DIR,DONE,DTTM,RCDFDA,REASON,X1,Y,DUOUT,DIRUT
 L +^RCY(344.61,1,0):DILOCKTM E  D NOLOCK S DONE=0 G OVERQ
 S DONE=1
 I TYPE="P"!(TYPE="M") D
 . S DIR(0)="EA",DIR("A",1)="An Override now exists for posting "_$S(TYPE="P":"pharmacy ",1:"medical ")_"payments."
 . S DIR("A",2)=" "
 . S DIR("A")="Press ENTER to continue: "
 . D ^DIR
 I TYPE="PM"!(TYPE="MP") D  I 'DONE G OVERQ
 . S DIR(0)="SA^M:Medical;P:Pharmacy",DIR("A")="Override for (M)edical or (P)harmacy? "
 . D ^DIR
 . I $D(DUOUT)!($D(DIRUT)) S DONE=0 Q
 . S TYPE=Y
 W ! K DIR
 S DIR("A")="Reason for Override: ",DIR(0)="FA^1:50"
 D ^DIR
 I $D(DUOUT)!($D(DIRUT)) S DONE=0 W !!,"   Need to enter a reason for Override.",!,"   Override not performed.",! G OVERQ
 S REASON=Y,DTTM=$$NOW^XLFDT
 S RCDFDA(344.61,"1,",$S(TYPE="M":20,1:21))=DTTM
 S RCDFDA(344.61,"1,",$S(TYPE="M":22,1:23))=DUZ
 S RCDFDA(344.61,"1,",$S(TYPE="M":24,1:25))=REASON
 D FILE^DIE("","RCDFDA")
 S X1="" S X1=$O(TEXT(X1),-1)
 S X1=X1+1
 S TEXT(X1)=$S(TYPE="M":"Medical ",1:"Pharmacy ")_"Override Details",X1=X1+1
 S TEXT(X1)="User: "_$P($G(^VA(200,DUZ,0)),"^") S X1=X1+1
 S TEXT(X1)="Date/Time: "_DTTM
 S TEXT(X1)="Reason for Override: "_REASON
OVERQ ;
 L -^RCY(344.61,1,0)
 Q DONE
 ;
MAIL(TEXT) ;generate mail message when OVERRIDE is implemented
 ;  
 ;  input - TEXT = lines of text that represent the body of the mail message
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
CHECK(TYPE,OVERRIDE) ; determine if override exists for today's date
 ; 
 ;    input - TYPE = "M" for medical; "P" for Pharmacy
 ;             OVERRIDE = passed by reference; array to hold the OVERRIDE data
 ;    output - OVERRIDE = returned array holding existing OVERRIDE data
 K OVERRIDE
 S OVERRIDE(TYPE)=+$$GET1^DIQ(344.61,1,$S(TYPE="M":20,1:21),"I")  ; get MEDICAL EFT OVERRIDE (344.61, 20) or PHARMACY EFT OVERRIDE (344.61, 21) dependent on type of EFTs
 I 'OVERRIDE(TYPE) K OVERRIDE(TYPE) S OVERRIDE=0 Q
 I $P(OVERRIDE(TYPE),".")'=DT K OVERRIDE(TYPE)  S OVERRIDE=0 Q  ; override does not exist for 'TODAYS' date,  post prevention rules will apply
 S OVERRIDE=1 Q
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
 N DIR
 S DIR(0)="EA"
 S DIR("A",1)="An Override for "_$S(TYPE="P":"pharmacy ",1:"medical ")_"is already in place."
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
