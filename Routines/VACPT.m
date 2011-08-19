VACPT ;ALB/GRR - DISPLAY CPT COPYRIGHT INF ; 12 APR 1989@1400
 ;;5.3;Registration;**123,124,138**;Aug 13, 1993
 ;
 ;  This routine now calls the CPT api for displaying the
 ; CPT COPYRIGHT information
 ;
 D COPY^ICPTAPIU
 Q:$G(IOST)["P-"  ;if printer, quit
 ;
 N DIR,DIRUT,DIROUT,DTOUT,DUOUT,X,Y
 S DIR(0)="FAO",DIR("A")="Press any key to continue",DIR("?")=""
 D ^DIR
 Q
