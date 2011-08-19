QACI0 ; OAKOIFO/TKW - DATA MIGRATION - PRE-MIGRATION ERROR CHECKING AND REPORT ;11/30/06  12:22
 ;;2.0;Patient Representative;**19**;07/25/1995;Build 55
EN ; Build report of errors found in both Reference Tables and ROCs.
 ; Make sure list of valid sites has been downloaded from the EMC
 W !!,"This option is meant to be run prior to migrating data from the old",!,"Patient Representative System in VistA to the new PATS system."
 W !!,"The option reports data problems that would prevent the data from",!,"being migrated.",!
 I '$D(^XTMP("QACMIGR","STDINSTITUTION")) D STAERR^QACI2 Q
 Q:$$ASK'=1
 W !
 N QACI0 S QACI0=1
 D EN0^QACI2
 F TYPE="ROC","HL","USER","PT","CC","EMPINV","FSOS" D
 . K ^XTMP("QACMIGR",TYPE,"U") Q
 Q
 ;
 ;
ASK() ; Ask user whether they're sure they want to run the option.
 N DIR,X,Y
 S DIR(0)="YO",DIR("A")="Are you sure",DIR("B")="YES"
 D ^DIR
 Q Y
 ;
 ;
