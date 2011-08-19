IBCEDS1 ;ALB/ESG - EDI CLAIM STATUS REPORT - SELECTION CONT ;13-DEC-2007
 ;;2.0;INTEGRATED BILLING;**377**;21-MAR-94;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
SORTSEL(LVL) ; sort selection criteria
 ; LVL - sort level 1, 2, or 3
 ;
 NEW DIR,X,Y,LVLD,G,LN,S,SC,SCP,DTOUT,DUOUT,DIRUT,DIROUT,IBZ
 K IBSORT3 I LVL<3 K IBSORT2 I LVL=1 K IBSORT1
 I '$F(".1.2.3.","."_$G(LVL)_".") G SORTSELX
 I STOP G SORTSELX
 ;
 I LVL>1,$G(IBSORT1)="" D SORTSEL(1) I $G(IBSORT1)="" G SORTSELX
 I LVL=3,$G(IBSORT2)="" D SORTSEL(2) I $G(IBSORT2)="" G SORTSELX
 ;
 S LVLD=$S(LVL=2:"Secondary",LVL=3:"Tertiary",1:"Primary")
 ;
 S DIR("A")=LVLD_" Sort"
 I LVL=1 S DIR("B")=$$SD("1")
 I LVL>1 K DIR("B")
 ;
 S DIR("?")="Enter a code from the list to indicate the "_LVLD_" sort order."
 I LVL>1 S DIR("?",1)="  Primary Sort is "_$$SD($G(IBSORT1)),DIR("?",LVL)=""
 I LVL=3 S DIR("?",2)="Secondary Sort is "_$$SD($G(IBSORT2))
 ;
 I LVL=1 S DIR(0)="SB"    ; primary sort required
 I LVL>1 S DIR(0)="SOB"   ; optional sorts
 ;
 S G=""
 F LN=1:1 S S=$P($T(ZZ+LN),";",3) Q:S=""  D
 . S SC=$P(S,":",1)     ; sort code
 . I LVL=2,IBSORT1=SC Q
 . I LVL=3,IBSORT1=SC!(IBSORT2=SC) Q
 . S SCP=$P(S,":",1,2)  ; sort code:desc pair
 . S G=$S(G="":SCP,1:G_";"_SCP)
 . Q
 ;
 S $P(DIR(0),U,2)=G
 ;
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S STOP=1 G SORTSELX     ; timeout or up arrow
 I Y="" G SORTSELX                             ; null response
 S @("IBSORT"_LVL)=Y,IBZ=Y
 ;
 I IBZ="4" D  G SORTSELX    ; current balance question
 . S DIR(0)="Y"
 . S DIR("A")="Display Highest Balances First",DIR("B")="Yes"
 . S DIR("A",1)=""
 . S DIR("?",1)="Enter Yes or No."
 . S DIR("?",2)=""
 . S DIR("?",3)="Yes, I want to see the large balances first at the top of the list and the"
 . S DIR("?",4)="small balances last at the bottom of the list."
 . S DIR("?",5)=""
 . S DIR("?",6)="No, I want to see the small balances first at the top of the list and the"
 . S DIR("?")="large balances last at the bottom of the list."
 . D ^DIR K DIR
 . I $D(DTOUT) S STOP=1 Q    ; timeout
 . I $D(DIRUT) S:LVL=1 STOP=1 K @("IBSORT"_LVL) Q   ; ^ or nil resp
 . I Y S IBSORTOR(IBZ)="D"    ; yes, large first, descending
 . I 'Y S IBSORTOR(IBZ)="A"   ; no, small first, ascending
 . Q
 ;
 I IBZ="1" D  G SORTSELX    ; Last Transmitted Date Question
 . S DIR(0)="Y"
 . S DIR("A")="Display Oldest EDI Claims First",DIR("B")="Yes"
 . S DIR("A",1)=""
 . S DIR("?",1)="Enter Yes to display claims with oldest transmission dates first."
 . S DIR("?")="Enter No to display claims with recent transmission dates first."
 . D ^DIR K DIR
 . I $D(DTOUT) S STOP=1 Q    ; timeout
 . I $D(DIRUT) S:LVL=1 STOP=1 K @("IBSORT"_LVL) Q   ; ^ or nil resp
 . I Y S IBSORTOR(IBZ)="A"    ; yes, old first, ascending sort
 . I 'Y S IBSORTOR(IBZ)="D"   ; no, new first, descending sort
 . Q
 ;
 I IBZ="8" D  G SORTSELX    ; Age Question
 . S DIR(0)="Y"
 . S DIR("A")="Display Oldest EDI Claims First",DIR("B")="Yes"
 . S DIR("A",1)=""
 . S DIR("?",1)="Enter Yes or No."
 . S DIR("?",2)=""
 . S DIR("?",3)="Yes, I want to see old EDI claims first at the top of the list and newer"
 . S DIR("?",4)="EDI claims last at the bottom of the list."
 . S DIR("?",5)=""
 . S DIR("?",6)="No, I want to see new EDI claims first at the top of the list and older"
 . S DIR("?",7)="EDI claims last at the bottom of the list."
 . S DIR("?",8)=""
 . S DIR("?",9)="Note:"
 . S DIR("?",10)="For MRA request claims, AGE is calculated as the number of days from the MRA"
 . S DIR("?",11)="request date through today's date."
 . S DIR("?",12)=""
 . S DIR("?",13)="For all other claims, AGE is calculated as the number of days from the"
 . S DIR("?")="Authorization date through today's date."
 . D ^DIR K DIR
 . I $D(DTOUT) S STOP=1 Q    ; timeout
 . I $D(DIRUT) S:LVL=1 STOP=1 K @("IBSORT"_LVL) Q   ; ^ or nil resp
 . I Y S IBSORTOR(IBZ)="D"    ; yes, old first, high age#'s first, descending
 . I 'Y S IBSORTOR(IBZ)="A"   ; no, new first, low age#'s first, ascending
 . Q
 ;
SORTSELX ;
 Q
 ;
SD(SORT) ; sort description given the sort code
 Q $P($P($T(@("ZZ"_$G(SORT))),";",3),":",2)
 ;
SV(SORT,DEF) ; sort value given the sort code
 ; SORT - sort code
 ;  DEF - default value if the sort code is nil (must be non-nil)
 ;
 NEW S,VAR,VALUE
 I $G(SORT)="" S VALUE=DEF G SVX
 S S=$P($T(@("ZZ"_$G(SORT))),";",3)
 S VAR=$P(S,":",4)   ; variable name
 S VALUE=$G(@VAR)    ; value of variable
 I VALUE="" S VALUE="~" G SVX    ; get out if undefined
 I '$P(S,":",3) G SVX            ; non-numeric
 I $G(IBSORTOR(SORT))="D" S VALUE=-VALUE   ; descending sort
SVX Q VALUE
 ;
 ;
ZZ ; List of allowable sort criteria
ZZ1 ;;1:Last Transmitted Date:1:IBLTRDT;
ZZ2 ;;2:Payer:0:IBPAY;
ZZ3 ;;3:EDI Claim Status:0:IBEDIST;
ZZ4 ;;4:Current Balance:1:IBCURBAL;
ZZ5 ;;5:Division:0:IBDIV;
ZZ6 ;;6:Claim Number:0:IBEXTCLM;
ZZ7 ;;7:AR Status:0:IBARSTAT;
ZZ8 ;;8:Age:1:IBAGE;
 ;
