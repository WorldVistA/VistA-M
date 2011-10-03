BPSSCRDS ;BHAM ISC/SS - ECME USER SCREEN DIVISION SELECT ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 ;USER SCREEN
 Q
 ;/*----------------------
 ;Division select for the user screen.
 ;Input:
 ;  BPARR - array to return division(s) : IEN of #9002313.56
 ;  BPDUZ7 - DUZ
 ;Return value:
 ;  0 nothing selected/
 ; -1 ALL
 ; -2 timeout or uparrow
 ; n  number of IENs of #9002313.56 selected by the user and stored in BPARR
 ;Returned by reference:
 ; BPARR - array with user profile info to store in IENs to #9002313.56
DS(BPARR,BPDUZ7) ;
 N DIR,DTOUT,BPINP
 N DR,DIE,DA
 N DIR
 S BPINP=$$EDITFLD^BPSSCRCV(1.13,+BPDUZ7,"S^D:DIVISION;A:ALL","Select Certain Pharmacy (D)ivisions or (A)LL","ALL",.BPARR)
 I BPINP=-1 Q -2  ;quit
 I $P(BPINP,U,2)="A" Q -1  ;ALL
 Q $$SELDIVS(BPDUZ7,.BPARR)
 ;
 ;/**
 ;returns back the name of the ECME pharmacy division
DIVNAME(BPDIV) ;
 Q $P($G(^BPS(9002313.56,BPDIV,0)),U)
 ;
 ;/*----------------------
 ;Reads division selection from the USER PROFILE file
 ;Input:
 ;  BPSDIVS by reference - array to return division(s) : BPSDIVS(IEN of #9002313.56)
 ;  BPDUZ7 - DUZ
 ;Return value:
 ;  0 nothing selected
 ; -1 ALL
 ; n  number of IENs of #9002313.56 selected by the user and stored in BPSDIVS
 ;Returned by reference:
 ; BPSDIVS - array with IENs to #9002313.56
GETDIVIS(BPDUZ7,BPSDIVS) ;*/
 N BPDIV,BPCNT
 S BPARRAY("DIVS")=$$GETPARAM^BPSSCRSL(2,BPDUZ7)
 F BPCNT=1:1:20 S BPDIV=$P($G(BPARRAY("DIVS")),";",BPCNT+1) Q:+BPDIV=0  D
 . S BPSDIVS(BPDIV)=""
 Q BPCNT-1  ;number of items
 ;
 ;/** 
 ;to select divisions (the user cannot select more then 20 divisions)
 ;Input:
 ;  BPARRAY - array to return division(s) in BPARRAY("DIVS")
 ;  BPDUZ7 -DUZ
 ;Return value:
 ;  -2 timeout or up arrow
 ;  n - number of divisions selected  
 ;by reference - BPARRAY("DIVS") - the string with 
 ;     divisions ien (#9002313.56) divided by "^"
SELDIVS(BPDUZ7,BPARRAY) ;
 N BPSDIVS,BPDIV1
 N BP1,BPDIV,BPCNT
 S BPDIV=0,BPCNT=0
 ;reads from file- NOT from BPARRAY !
 I $$GETDIVIS(BPDUZ7,.BPSDIVS)
 W !,?2,"Selected:"
 F  S BPDIV=$O(BPSDIVS(BPDIV)) Q:+BPDIV=0  S BPCNT=BPCNT+1 D
 . W !,?10,$$DIVNAME(BPDIV)
 F  S BPDIV=$$DIV() Q:BPDIV=-2  Q:+BPDIV=0  D
 . I $D(BPSDIVS(BPDIV)) I $$DELDIV(BPDIV)="Y" K BPSDIVS(BPDIV)
 . E  S BPSDIVS(BPDIV)=""
 . S BPCNT=0,BPDIV1=0
 . F  S BPDIV1=$O(BPSDIVS(BPDIV1)) Q:+BPDIV1=0  S BPCNT=BPCNT+1 D
 . . I BPCNT>20 D  Q
 . . . W !,"Number of selected divisions cannot exceed 20!"
 . . . K BPSDIVS(BPDIV)
 . S BPCNT=0,BPDIV1=0
 . F  S BPDIV1=$O(BPSDIVS(BPDIV1)) Q:+BPDIV1=0  S BPCNT=BPCNT+1 D
 . . W !,?10,$$DIVNAME(BPDIV1)
 ;
 I BPDIV=-2 D  Q -2  ;exit
 . W !,"Exit without changes..."
 . N BPSDIVS
 . I $$GETDIVIS(BPDUZ7,.BPSDIVS)
 . S BPCNT=0,BPDIV1=0
 . F  S BPDIV1=$O(BPSDIVS(BPDIV1)) Q:+BPDIV1=0  S BPCNT=BPCNT+1 D
 . . W !,?10,$$DIVNAME(BPDIV1)
 ;
 ;convert selection into "^div1;div2...divN;" string
 S BPARRAY("DIVS")=""
 F BPCNT=1:1:20 S BPDIV=$O(BPSDIVS(BPDIV)) Q:+BPDIV=0  D
 . S BPARRAY("DIVS")=$G(BPARRAY("DIVS"))_";"_BPDIV
 S BPARRAY("DIVS")=$G(BPARRAY("DIVS"))_";"
 Q BPCNT-1
 ;--------
 ;
DIV() ;
 N DIC,DIRUT,DUOUT,DTOUT
 S DIC("A")="Select ECME Pharmacy Division(s): ",DIC=9002313.56,DIC(0)="AEQM" D ^DIC
 I $D(DIRUT) Q -2
 I ($D(DUOUT))!($D(DTOUT)) Q -2
 I Y<1 Q 0
 Q +Y
 ;
 ;
DELDIV(BPDIV) ;
 N DIR
 S DIR(0)="S^Y:YES;N:NO",DIR("A")="Delete "_$$DIVNAME(BPDIV)_" from your list?",DIR("B")="N" D ^DIR
 Q Y
 ;
