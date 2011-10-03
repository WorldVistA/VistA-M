PRSAPT1 ; HISC/REL-Enter/Edit/Display Tables ;11/20/92  11:25
 ;;4.0;PAID;;Sep 21, 1995
STID ; List Special Tour Indicator Table
 W ! S L=0,DIC="^PRST(457.2,",FLDS=".01,1,2",BY=.01
 S (FR,TO)="",DHD="SPECIAL TOUR INDICATOR" D EN1^DIP K %ZIS S IOP="" D ^%ZIS G EX
TTD ; Display Type of Time
 W ! S L=0,DIC="^PRST(457.3,",FLDS=".01,1,2",BY="CODE"
 S (FR,TO)="",DHD="TYPE OF TIME" D EN1^DIP K %ZIS S IOP="" D ^%ZIS G EX
TRMD ; Display Time Remarks
 W ! S L=0,DIC="^PRST(457.4,",FLDS="1,.01,5",BY="CODE"
 S (FR,TO)="",DHD="REMARKS TABLE" D EN1^DIP K %ZIS S IOP="" D ^%ZIS G EX
EX G KILL^XUSCLEAN
