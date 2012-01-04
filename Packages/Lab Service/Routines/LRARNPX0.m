LRARNPX0 ;SLC/MRH/FHS/J0 - NEW PERSON CONVERSION FOR ^LAR("Z" ; 1/23/93
 ;;5.2;LAB SERVICE;**59**;Sep 27, 1994
 ;
 Q
EXCEPT(LRFILE,LRD0) ;- LOGS EXCEPTIONS FROM CONVERSION OF DATA FROM 6 AND 16
 ; exceptions are put into a SORT template so the the site can
 ; then use fileman enter edit to correct problems found.
 ;
 N DIC,LRSORT,X,Y
 I '$D(^DIBT("B",LRFILE_"-EXCEPTIONS")) D ADD
 I '$D(LRSORT) S LRSORT=$O(^DIBT("B",LRFILE_"-EXCEPTIONS",0))
 S ^DIBT(LRSORT,1,LRD0)=""
 Q
 ;
ADD ; add a new sort template to be used for exception logging and editing
 N X,Y
 S DIC="^DIBT(",DIC(0)="L",DLAYGO=0,DIC("DR")="2///^S X=""T"";4///^S X=$P(LRFILE,""-"",2);5///^S X=0;"
 S X=LRFILE_"-EXCEPTIONS" D FILE^DICN K DLAYGO S LRSORT=+Y
 Q
 ;
DEVICE ; device selection for exception report for file conversions
 K %ZIS N POP
 S %ZIS="N",%ZIS("A")="PRINTER for EXCEPTION REPORT: ",%ZIS("B")="" D ^%ZIS
 I 'POP&($E(IOST,1,2)="P-") S LRIO=ION Q
 I POP S LRIO="POP" Q
 W !!,"A DEVICE must be chosen for the EXCEPTION report to print on",!,"That is defined as a """"P-"""" something.",!! G DEVICE
 Q
 ;
HEAD(X) ; writes header for all exception reports
 N LRTIT
 S LRTIT=$P($G(^DIC($P(X,"-",2),0)),U),LRTIT="Exception report for file "_$P(X,"-",2)_":  "_LRTIT_"."
 W !,?(IOM-$L(LRTIT))\2,LRTIT
 S LRTIT=$G(LRTSK) I LRTIT S LRTIT="Task # "_LRTIT W !,?(IOM-$L(LRTIT))\2,LRTIT
 Q
