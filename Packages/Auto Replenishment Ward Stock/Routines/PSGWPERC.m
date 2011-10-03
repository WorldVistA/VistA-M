PSGWPERC ;BHAM ISC/KKA - Print Percentage Stock On Hand ; 29 Dec 93 / 11:46 AM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 I '$D(PGWSITE) D ^PSGWSET Q:'$D(PSGWSITE)
 I $P(PSGWSITE,"^",5) D  K CONT Q
 .W *7,!!,"You may not use this option because the ""Merge Inventory Sheet and",!,"Pick List"" site parameter is set to ""YES"". If on hand amounts are not"
 .W !,"being entered, this report will not have the necessary data to produce",!,"accurate results."
 .W !!,"Press RETURN to continue: " R CONT:DTIME
 K DIC S DIC=58.1,L=0,FLDS="[PSGW PERCENTAGE]",BY="[PSGW PERCENTAGE]" D EN1^DIP K DIC
 Q
