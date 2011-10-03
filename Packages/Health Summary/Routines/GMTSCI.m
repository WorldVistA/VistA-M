GMTSCI ; SLC/MKB,KER - Health Summary Component Inquiry ; 02/27/2002
 ;;2.7;Health Summary;**49**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10010  EN1^DIP
 ;                 
EN ; Display a Health Summary Component
 S U="^",DIC="^GMT(142.1,",DIC(0)="AEMQ",DIC("A")="Select Health Summary Component Name: " D ^DIC K DIC("A") G:Y=-1 END S (FR,TO)=$P(Y,U,2),GMTSY=+Y
 S BY=".01",DHD="[GMTS COMP INQ HEADER]",FLDS="[GMTS COMP INQ]",L=0 D EN1^DIP K GMTSY
END ; Quit
 Q
