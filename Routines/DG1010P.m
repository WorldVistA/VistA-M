DG1010P ;ALB/JDS;REW - 1010 PRINT--INQUIRY PATIENT ; 1/3/05 6:18pm
 ;;5.3;Registration;**86,108,113,161,642,624**;Aug 13, 1993
 ;
FIND W !! S DIC="^DPT(",DIC(0)="AEQZM" D ^DIC G Q:+Y'>0 S (DA,DFN)=+Y
 S DFN1=0
 I $O(^DPT(DFN,"DIS",0))>0 S DFN1=$O(^DPT(DFN,"DIS",0))
W1 D NOREG^DG1010PA(DFN)
QU ;
 S DGHDFN=DFN
 I DGOPT]"" D
 . N EAPP,EAIP
 . S (EAPP,EAIP)=0 F  S EAPP=$O(^EAS(712,"AC",DFN,EAPP)) Q:'EAPP!EAIP  D
 . . I $$GET1^DIQ(712,EAPP,7.1)="" D
 . . . N EAIX,EADT F EAIX="REV","PRT","SIG" Q:EAIP  D
 . . . . S EADT=0 F  S EADT=$O(^EAS(712,EAIX,EADT)) Q:'EADT!EAIP  I $D(^EAS(712,EAIX,EADT,EAPP)) S EAIP=1
 . I EAIP D  Q
 . . N DIR
 . . W !!,"No data have been found for the selected patient, or"
 . . W !,"the patient may have an on-line 10-10EZ application"
 . . W !,"in progress.  The 10-10EZ form shall not be printed."
 . . S DIR(0)="E" D ^DIR
 . . S DGOPT=""
 I DGOPT]"" D  S DGPGM="DQ^DG1010P",DGVAR="DGOPT^PRF^DFN^DFN1^DUZ^DGPMDA^PSOINST^PSONOPG^PSOPAR^PSTYPE^GMTSTYP^EASMTIEN" D ZIS^DGUTQ G:POP EMB U IO D DQ G EMB
 .W:DGOPT'=5 !!?5,*7,"This output requires 132 column output to a PRINTER.",!?5,*7,"Output to SCREEN will be unreadable."
 G EMB
EN ;
 Q
DQ ;
 D NOW^%DTC,YX^%DTC S DGNOW=Y
 S X=132 X ^%ZOSF("RM") F I="DFN","DFN1","DGPMDA","PRF","GMTSTYP" S DGHOLD(I)=$S($D(@I):@I,1:"")
 I DGOPT[0&'($G(DGSTOP)) DO
 . S (EASDFN,DA)=DFN,ZUSR=DUZ
 . D EN^EASEZPDG ;1010EZ
 . K EASDFN,ZUSR,EASMTIEN
 I DGOPT[1&'($G(DGSTOP)) DO
 . S (EASDFN,DA)=DFN,EASFLAG="EZR",ZUSR=DUZ
 . D EN^EASEZPDG ;1010EZR
 . K EASFLAG,EASDFN,ZUSR,EASMTIEN
 I DGOPT[3&'($G(DGSTOP)) D RESTORE,RET^DGBLRV ;3rd party review
 I DGOPT[8&'($G(DGSTOP)) D RESTORE,ENXQ^GMTSDVR
 I DGOPT[5&'($G(DGSTOP)) S POP=0 D RESTORE,DFN^PSOSD1 K POP S X=132 X ^%ZOSF("RM") ;DRUG PROFILE NOTE: EXECUTES ^%ZIS("C")
 D ^%ZISC
 D CLOSE^DGUTQ,Q K DGHOLD,DGOPT,DGPMDA Q
Q K %,%DT,DA,DB,DFN,DFN1,DGHSFLG,DGOPT,DGL2,DGLDASH,DGLDOUBL,DGLSUP,DGLSUP1,DGLUND,DGPGM,DGPMDA,DGMTDT,DGMTI,DGMTYPT,DGNOW,DGVAR,DGX,DIC,DIRUT,DTOUT,DUOUT,I,J,L,POP,PRF,X,Y,DGSTOP
 K LMI,PSCNT,PSDIS,PSDT,PSII,PSOPRINT ;FROM DRUG PROFILE
 K GMTSTYP,EASMTIEN
 Q
RESTORE F I="DFN","DFN1","PRF","DGPMDA","GMTSTYP" S @I=DGHOLD(I)
 Q
EMB ;emboss card?
 S DFN=DGHDFN
 ;W !! D EMBOS^DGQEMA
 D EF
 K DGHDFN G FIND
 ;
EF ;encounter form?
 N EFX,WITHDATA,IBDFRION
 I $$PROMPRN^DG1010PA("EF") I DG1'<0 S EFX=1 D
 .S WITHDATA=1
 .D MAIN^IBDFREG(WITHDATA)
 Q
 ;
SEL1010(PROMPT) ;* Prompt user to select the 1010EZ to print
 ;
 ; INPUT:
 ;     PROMPT : Indicate which prompts to present
 ;              : NULL    - Prompt both (EZ prompted 1st)
 ;              : EZ      - Prompt 1010EZ only
 ;              : EZR/EZ  - Prompt both (EZR prompted 1st)
 ;              : EZR     - Prompt 1010EZR only
 ;
 ; OUTPUT
 ;        RPTSEL : NULL  - No report selected
 ;               : "EZ"  - 1010EZ report was selected
 ;               : "EZR" - 1010EZR report was selected
 ;
 N PRT1010,PRT1010R,RPTSEL
 I '$D(PROMPT) S PROMPT=""
 S PRT1010=0
 S PRT1010R=0
 S RPTSEL=""
 ;
 ;* Prompt 1010EZ and then 1010EZR
 I PROMPT="" DO
 . S PRT1010=$$EZPRMPT
 . I PRT1010 S RPTSEL="EZ"
 . S:PRT1010=0 PRT1010R=$$EZRPRMPT
 . I PRT1010R S RPTSEL="EZR"
 . I (PRT1010=-2)!(PRT1010R=-2) S RPTSEL=-1
 ;
 ;* Prompt 1010EZR and then 1010EZ
 I PROMPT="EZR/EZ" DO
 . S PRT1010R=$$EZRPRMPT
 . I PRT1010R S RPTSEL="EZR"
 . S:PRT1010R=0 PRT1010=$$EZPRMPT
 . I PRT1010 S RPTSEL="EZ"
 . I (PRT1010=-2)!(PRT1010R=-2) S RPTSEL=-1
 ;
 ;* Prompt 1010EZ only
 I PROMPT="EZ" DO
 . S PRT1010=$$EZPRMPT
 . I PRT1010 S RPTSEL="EZ"
 . I (PRT1010=-2) S RPTSEL=-1
 ;
 ;* Prompt 1010EZR only
 I PROMPT="EZR" DO
 . S PRT1010R=$$EZRPRMPT
 . I PRT1010R S RPTSEL="EZR"
 . I (PRT1010R=-2) S RPTSEL=-1
 ;
 Q RPTSEL
 ;
EZPRMPT() ;* Prompt for 1010EZ print
 ; OUTPUT - 
 ;     RPTSEL : -1  REPORT NOT SELECTED
 ;     RPTSEL : -2  USER EXITED WITHOUT RESPONSE
 ;     RPTSEL :  0  USER ANSWERED "NO"
 ;     RPTSEL :  1  USER ANSWERED "YES"
 ;
 N RPTSEL,PRT1010
 S RPTSEL=-1
 K DIR,Y,X,DIRUT,DTOUT,DIROUT,DUOUT
 S DIR(0)="Y^A0^"
 S DIR("A")="PRINT 10-10EZ"
 S DIR("?",1)="Enter 'Yes' to print a 10-10EZ Application for Health Benefits form."
 S DIR("?")="Otherwise enter 'No'."
 S DIR("B")="YES"
 D ^DIR
 I $D(DIRUT)!$D(DTOUT)!$D(DIROUT)!$D(DUOUT) S RPTSEL=-2
 S:RPTSEL'=-2 RPTSEL=Y
 ;;S PRT1010=Y
 ;;I PRT1010 S RPTSEL="EZ"
 K DIR,Y,X,DIRUT,DTOUT,DIROUT,DUOUT
 Q RPTSEL
 ;
EZRPRMPT() ;* Prompt for 1010EZR print
 ; OUTPUT - 
 ;     RPTSEL : -1  REPORT NOT SELECTED
 ;     RPTSEL : -2  USER EXITED WITHOUT RESPONSE
 ;     RPTSEL :  0  USER ANSWERED "NO"
 ;     RPTSEL :  1  USER ANSWERED "YES"
 ;
 N RPTSEL,PRT1010R
 S RPTSEL=-1
 K DIR,Y,X,DIRUT,DTOUT,DIROUT,DUOUT
 S DIR(0)="Y^A0^"
 S DIR("A")="PRINT 10-10EZR"
 S DIR("?",1)="Enter 'YES' to print a 10-10EZR Health Benefits Renewal form."
 S DIR("?")="Otherwise enter 'No'."
 S DIR("B")="YES"
 D ^DIR
 I $D(DIRUT)!$D(DTOUT)!$D(DIROUT)!$D(DUOUT) S RPTSEL=-2
 S:RPTSEL'=-2 RPTSEL=Y
 ;;S PRT1010R=Y
 ;;I PRT1010R S RPTSEL="EZR"
 K DIR,Y,X,DIRUT,DTOUT,DIROUT,DUOUT
 Q RPTSEL
 ;
MTPRMPT(DFN,DGMTI) ;* Prompt for Means test included on 1010EZ
 ;input:
 ;  DFN - Patient file (#2) ien (required)
 ;  DGMTI - Means Test file (#408.31) ien (required)
 ;output:
 ;  MTSEL - Means Test IEN selected
 N MTSEL
 S MTSEL=+DGMTI
 I $D(^DGMT(408.31,MTSEL,0)) Q MTSEL
 Q $$ENEZ^EASEZPDG(DFN,0)
 ;
PRT1010(PRT1010,DFN,MTIEN) ;* Print 1010EZ reports
 ;INPUT:
 ;  PRT1010 -
 ;          "EZ": Print 1010EZ report
 ;         "EZR": Print 1010EZR report
 ;  DFN - IEN from Patient entry in Patient file
 ;  MTIEN - IEN from 408.31 Means Test file
 ;
 ;OUTPUT:
 ;  DGTASK : Value of ZTSK passed back from ^%ZTLOAD in EASEZPDG
 ;         : 0 indicates print task was not completed
 ;
 N DGTASK
 S DGTASK=0
 ;* Following calls allowed via IA #4600
 I PRT1010="EZ" S DGTASK=$$ENEZ^EASEZPDG(DFN,MTIEN)
 I PRT1010="EZR" S DGTASK=$$ENEZR^EASEZPDG(DFN,MTIEN)
 Q DGTASK
