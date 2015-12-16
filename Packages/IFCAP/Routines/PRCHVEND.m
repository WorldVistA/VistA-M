PRCHVEND ;MNTSS/RGB-VENDOR LOOKUP/DISPLAY ; 12 Dec 2014  10:18 AM
V ;;5.1;IFCAP;**190**;Oct 20, 2000;Build 3
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 ;PRC*5.1*190 Create routine to handle option PRCH DISPLAY VENDOR
 ;to replace DIC/DIQ option control to now allow the correct format
 ;for DUN & BRADSTREET lookup
 ;
EN ;Lookup
 K DA,X,Y,DIR,DIC,DIQ
1 S DIR(0)="PO^440:EMZ",DIR("?")="*** DUN & BRADSTREET # MUST be preceded by 'DUN' ***" D ^DIR G EXIT:Y'>0 S:+Y>0 (X,DA)=+Y
 S DIC="^PRC(440,",DIQ(0)="IE"
 D EN^DIQ W !!
 G 1
EXIT K DA,X,Y,DIR,DIC,DIQ
