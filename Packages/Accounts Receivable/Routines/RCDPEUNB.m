RCDPEUNB ;AITC/CJE - ePayments - Flag/Unflag Unbalanced EDI Lockbox Deposit
 ;;4.5;Accounts Receivable;**446**;Mar 20, 1995;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Entry Point from menu
 N DA,DIE,DIC,DIR,DR,X,Y
 W #
LOOP ;
 W !,"Select EDI LOCKBOX DEPOSIT NUMBER: "
 R X:DTIME I '$T Q
 I $E(X)="^"!(X="") Q
 I X="?" S Y=$$LIST("AU",1,1) G:'Y LOOP G NEXT
 I X="??" S Y=$$LIST^RCDPEUNB("AU",1,0) G:'Y LOOP G NEXT
 I '$D(^RCY(344.3,"C",X)) D  G LOOP
 . W !!,"** Invalid Deposit Number **"
 S Y=$$LIST("C",X,0) I 'Y G LOOP
NEXT ;
 S DIE=344.3,DIC(0)="AEMV"
 S DA=+Y I 'DA Q
 S DR=".15"
 D ^DIE
 I $D(DTOUT) Q
 W !
 G LOOP
 Q
ULIST ; Write out a list of unbalanced deposits to the screen
 N IEN
 I $O(^RCY(344.3,"AU",1,""))="" D  Q  ;
 . W !,"** No EDI Lockbox Deposits currently flagged as unbalanced **"
 ;
 W !
 W !,"Deposit Number",?20,"Depsosit Date",?40,"Amount"
 S IEN=""
 F  S IEN=$O(^RCY(344.3,"AU",1,IEN)) Q:IEN=""  D  ;
 . W !
 . W $$GET1^DIQ(344.3,IEN_",",.06,"E"),?20
 . W $$GET1^DIQ(344.3,IEN_",",.07,"E"),?34
 . W $J($$GET1^DIQ(344.3,IEN_",",.08,"E"),12,2)
 W !
 Q
LIST(IX,VALUE,PROMPT) ; List unbalance EDI Lockbox deposits
 ; Inputs : IX - Index to use for look-up
 ;          VALUE - Lookup Value on index to display
 ;          PROMPT - Prompt for display
 ; Return : Internal entry number for 344.3 (or 0 if nothing selected, or '^', or timeout)
 N COUNT,DIR,IEN,QUIT,RETURN,X,Y
 K ^TMP("RCDPEUNB",$J)
 S (QUIT,RETURN)=0
 I PROMPT D  G:QUIT LISTQ
 . W !,"Answer with EDI LOCKBOX DEPOSIT NUMBER, or DEPOSIT NUMBER",!
 . S DIR(0)="YA"
 . S DIR("A")="Do you want the entire Unbalanced EDI LOCKBOX DEPOSIT List? "
 . D ^DIR
 . I Y'=1 S QUIT=1
 ;
 ; List Entries from index IX that match VALUE
 W !,"  Choose from:"
 S IEN="",COUNT=0
 F  S IEN=$O(^RCY(344.3,IX,VALUE,IEN)) Q:IEN=""  D  ;
 . S COUNT=COUNT+1
 . D DISPLAY(IEN,COUNT)
 . S ^TMP("RCDPEUNB",$J,COUNT)=IEN
 I COUNT=0 D  G LISTQ
 . W !!,"No entries matching the search value. Hit <RETURN> to continue:"
 . R X:DTIME
 . W !
 K DIR
 S DIR(0)="NAO^1:"_COUNT_":0"
 S DIR("A")="Select from list 1-"_COUNT_": "
 D ^DIR
 I Y=""!($E(Y)="^") G LISTQ
 S RETURN=+$G(^TMP("RCDPEUNB",$J,Y))
 W ! D DISPLAY(RETURN,"") W !
 ;
LISTQ ;
 K ^TMP("RCDPEUNB",$J)
 Q RETURN
 ;
DISPLAY(IEN,C) ; Display an EDI Lockbox deposit
 ; Input - IEN - Internal entry number from 344.3
 ;         C - Order number to display
 ;
 N XX
 W !,C,?3,$$GET1^DIQ(344.3,IEN_",",.06,"E")
 S XX=$$GET1^DIQ(344.3,IEN_",",.07,"I")
 S XX=$$FMTE^XLFDT(XX,"2DZ")
 S XX=$TR(XX,"/","-")
 W ?13,XX
 W ?25,$J("$"_$FN($$GET1^DIQ(344.3,IEN_",",.08,"E"),"",2),12)
 W ?45,$$GET1^DIQ(344.3,IEN_",",.15,"E")
 Q
