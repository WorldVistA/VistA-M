IBDFDE23 ;ALB/DHH - Select CPT Modifiers during Manual Data Entry ; MAY-18-1999
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**38,37**;APR 24, 1997
MOD ;Entry point for selecting or modifying modifiers
 ;
 ;  -- called by IBDFDE21
 ;
 N CODE,I,X,SEL,MOD,Y,CNT,MODLST
 ;
 ;-- result is definition is noted in ^ibdfde2
 ;   result:= pckg interface^code to send^text to send...
 ;
 S CODE=$P(RESULT(IBDX),"^",2)
 ;
 ; --ans = list number, cpt, or cpt-mod,mod (raw data user enters)
 ; if ans contains "-" then seperate and validate each cpt modifier pair
 ; if ans contains "-" ans should = cpt-mod,mod,mod...
 ; else  ask for modifiers 
 ; 
 I ANS["-" D
 .S MODLST=$P(ANS,"-",2)
 .F I=1:1 S X=$P(MODLST,",",I) Q:X']""  D
 ..; --check for appropriate modifiers/cpt matches
 ..;   cpts and modifiers can be input as 
 ..;      -- cpt-mod,mod,mod
 ..;   if multiple modifiers were entered with cpt, each cpt-mod pair
 ..;   will be checked by modp^icptmod to see if valid.  if not, an
 ..;   error message will be displayed for the invalid code pair
 ..;
 .. I $$MODP^ICPTMOD(CODE,X)'>0 D ERR Q
 .. S SEL("MOD",X)=""
 ;
 ;  --no matter what method user uses to input data modifiers should
 ;    should be asked for each cpt code
 ;
 D OTHER,ARRAY
 Q
 ;
OTHER ;--allow for additional modifiers to be selected
 N DIC
 F  S DIC=81.3,DIC("S")="I ($$MODP^ICPTMOD(CODE,+Y,""I""))>0",DIC(0)="AEMQ" D ^DIC Q:+Y<1  D
 . S MOD=$P($G(Y),"^",2)
 . I $D(SEL("MOD",MOD)) D DELMOD Q:Y=1
 . S:MOD'="" SEL("MOD",MOD)=""
 Q
DELMOD ; Delete modifier from list if duplicate entry
 N DIR,DA,DR,DIC
 W !,"Do you want to remove this modifier as being Associated with this CPT Procedure?"
 S DIR(0)="Y",DIR("B")="YES" D ^DIR Q:$D(DIRUT)
 I Y=1 K SEL("MOD",MOD)
 Q
ARRAY ; -- transfer modifier data to result array
 Q:'$D(SEL)
 S MOD="",CNT=0 F  S MOD=$O(SEL("MOD",MOD)) Q:MOD']""  D
 . S CNT=CNT+1
 . S RESULT(IBDX,"MODIFIER",CNT)=MOD
 S RESULT(IBDX,"MODIFIER",0)=CNT
 Q
 ;
ERR ;Error message
 W !,X," is not a valid modifier for ",CODE,!
 Q
GAFSCOR ;Enter GAF Score
 ;GAFCNT is newed in % of IBDFDE,IBDFDE6,IBDFDE7
 S GAFCNT=$G(GAFCNT)+1
 I GAFCNT=2 Q
 I GAFCNT>2 K GAFCNT Q
 S DIR(0)="N^1:100"
 S DIR("A")="Enter GAF Score "
 S DIR("?")="GAF Score is numeric from 1-100."
 D ^DIR
 I Y<1 D  G GAFSCOR
 . W "You must enter a GAF Score (1-100)!"
 . S GAFCNT=$G(GAFCNT)-1
 S IBDSEL(0)=$G(IBDSEL(0))+1
 S IBDSEL(IBDSEL(0))=IBDF("PI")_"^"_+Y_"^ ^^^^^GAF SCORE"
 S $P(PXCA("IBD GAF SCORE",0),"^")=+Y
 Q
 ;
OKPROV(IEN)     ; Screen for provider lookup using person class
 Q ($D(^XUSEC("SD GAF SCORE",IEN)))
 ;
