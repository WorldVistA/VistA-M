SCRPIUT1 ; ALB/SCK - Incomplete Encounter Mgmt Report Utilities ; 20 Nov 98 12:36 AM
 ;;5.3;Scheduling;**66,147,154**;AUG 13, 1993
 ;
 Q
DIV() ;  Returns either list of selected divisions for multi-divisional site, or primary
 ;  division for single division site.
 ;
 N Y
 I $P($G(^DG(43,1,"GL")),U,2) D
 . W !
 . D DIVISION^VAUTOMA
 E  D
 . S VAUTD=0
 . S Y=$$PRIM^VASITE
 . S VAUTD(Y)=$P($G(^DG(40.8,Y,0)),U)
 ;
 Q Y
 ;
CLN() ; Select One/Many/All Clinics for selected Division
 N Y
 S VAUTNI=2
 W !
 D CLINIC^VAUTOMA
 Q Y
 ;
CTR(X,SDLW) ;  Center string x in display line
 N SDL
 I '$G(SDLW) S SDLW=80
 S SDL=(SDLW-$L(X))/2
 S X=$$SPACE(SDL)_X
 Q
 ;
SPACE(SCWDTH) ;  Build string of 'SCWDTH' spaces
 ;  Variable Input
 ;      SCWDTH - returns with formatted string
 ;
 ;  Return
 ;      TAB - "spaces" to tab over
 ;
 N TAB S TAB=""
 S $P(TAB," ",SCWDTH)=""
 Q TAB
 ;
PARSE(ER,ER1,ER2,PB,PE) ; Parse error description into two lines for report
 N SCX
 F SCX=PB:1:PE I $E(ER,SCX)=" " D  Q
 . S ER1=$E(ER,1,SCX),ER2=$E(ER,SCX+1,$L(ER))
 ;
 S ER1=$E(ER,1,PE),ER2=$E(ER,PE+1,$L(ER))
 Q
 ;
ERRLST ;
 N SDIV,SDERR,DIR,DIRUT,DTOUT,DUOUT
 I $P($G(^DG(43,1,"GL")),U,2) D  Q:Y<0
 . S DIR(0)="YA",DIR("B")="YES",DIR("A")="Select All Divisions? "
 . D ^DIR  K DIR Q:$D(DIRUT)
 . I Y S SDIV="" Q
 . S DIC=40.8,DIC(0)="AEQMZ"
 . S DIC("A")="Enter Division for Errors: "
 . S DIC("B")=$P($G(^DG(40.8,$$PRIM^VASITE($$NOW^XLFDT),0)),U)
 . D ^DIC K DIC I +Y>0 S SDIV=+Y
 E  D
 . S SDIV=""
 ;
 Q:$D(DIRUT)
 ;
 S DIR(0)="YA",DIR("B")="YES",DIR("A")="Select all Errors? "
 D ^DIR K DIR Q:$D(DIRUT)
 ;
 I Y S SDERR=""
 E  D  Q:$D(DTOUT)!($D(DUOUT))!(Y'>0)
 . S DIC=409.76,DIC(0)="AEQMZ",DIC("A")="Select Error Code: "
 . D ^DIC K DIC Q:$D(DTOUT)!($D(DUOUT))!(Y'>0)
 . S SDERR=Y(0,0)
 ;
 S L=0
 S DIC=409.75
 S FLDS="[SCENI ERROR LIST]"
 S BY="[SCENI ERROR SORT]"
 S FR=SDIV_",,"_SDERR_","
 S TO=SDIV_",,"_SDERR_","
 S DISUPNO=0
 D EN1^DIP
 Q
