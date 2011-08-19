SDCOUR ;ALB/RMO - Reader Utilities - Check Out;18 FEB 1993 11:30 am
 ;;5.3;Scheduling;;Aug 13, 1993
 ;
EN(SDNOD0,SDSUB,SDPAR,SDSELDF,SDSELY) ;Select Entities from Secondary List
 ; Input  -- SDNOD0   Selection in XQORNOD0 format
 ;           SDSUB    Secondary List Subscript
 ;           SDPAR    Selection Parameters (A=Add)
 ;           SDSELDF  Selection Default  [Optional]
 ; Output -- SDSELY   Selection Array
 N SDCNT
 S SDCNT=+$G(^TMP("SDCOIDX",$J,SDSUB,0))
 I 'SDCNT D  G ENQ
 .I $P(SDNOD0,"^",4)["=" W !,*7,">>> There are no items to select." S SDSELY("ERR")="" D PAUSE^VALM1
 D SEL(SDNOD0,SDSUB,.SDSELY) G ENQ:$D(SDSELY)
 S SDSELY($$ASK(SDCNT,SDPAR,$G(SDSELDF)))=""
ENQ Q
 ;
SEL(SDNOD0,SDSUB,SDSELY) ;Process Secondary List Selection
 ; Input  -- SDNOD0   Selection in XQORNOD0 format
 ;           SDSUB    Secondary List Subscript
 ; Output -- SDSELY   Selection Array
 N I,SDBEG,SDEND,SDERR,X,Y
 S SDBEG=1,SDEND=+$G(^TMP("SDCOIDX",$J,SDSUB,0)) G SELQ:'SDEND
 S Y=$$PARSE^VALM2(SDNOD0,SDBEG,SDEND)
 ; -- check was valid entries
 S SDERR=0
 F I=1:1 S X=$P(Y,",",I) Q:'X  D
 .I '$O(^TMP("SDCOIDX",$J,SDSUB,X,0))!(X<SDBEG)!(X>SDEND) D
 ..W !,*7,">>> Selection '",X,"' is not a valid choice."
 ..S SDERR=1
 I SDERR S SDSELY("ERR")="" D PAUSE^VALM1 G SELQ
 ;
 F I=1:1 S X=$P(Y,",",I) Q:'X  S SDSELY(X)=""
SELQ Q
 ;
ASK(SDCNT,SDPAR,SDSELDF) ;Ask user to select from list
 ; Input  -- SDCNT    Number of Entities
 ;           SDPAR    Selection Parameters (A=Add)
 ;           SDSELDF  Selection Default  [Optional]
 ; Output -- Selection
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
REASK S DIR("?")="Enter "_$S($G(SDSELDF)]"":"<RETURN> for '"_SDSELDF_"', ",1:"")_$S(SDCNT=1:"1",1:"1-"_SDCNT)_" to Edit"_$S(SDPAR["A":", or 'A' to Add",1:"")
 S DIR("A")="Enter "_$S(SDCNT=1:"1",1:"1-"_SDCNT)_" to Edit"_$S(SDPAR["A":", or 'A' to Add",1:"")_": "_$S($G(SDSELDF)]"":SDSELDF_"// ",1:"")
 S DIR(0)="FAO^1:30"
 D ^DIR I $D(DTOUT)!($D(DUOUT)) S Y="^" G ASKQ
 S Y=$$UPPER^VALM1(Y)
 I Y?.N,Y,Y'>SDCNT G ASKQ
 I SDPAR["A",$E(Y)="A" S Y="Add" G ASKQ
 I Y="" S Y=$S($G(SDSELDF)]"":SDSELDF,1:"Return") G ASKQ
 W !!?5,DIR("?"),".",! G REASK
ASKQ Q $G(Y)
