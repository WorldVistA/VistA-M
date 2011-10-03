PRCHLCS ;SF-ISC/TKW-LOG CODE SHEET UTILITY ROUTINES ;9-13-89/2:37 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN1 ;SOURCE DEVIATION/SERIAL NO. FIELD, PRCHL500
 Q:'$D(PRCHCS("CANC"))
 I PRCHCS("CANC")="" D CHK Q
 I (X'?4N)!(X'>2000) W !!,"Must be a number greater than 2000!",! K X
 Q
 ;
SD D DSPS W !!,"Select SOURCE DEVIATION CODE: " R X:DTIME I '$T!(X["^")!(X="") S X="    " Q
 ;
CHK F Z=0:0 S Z=$O(^PRCD(441.4,"B",X,Z)) Q:'Z  I $D(^PRCD(441.4,+Z,0)),$P(^(0),U,2)="S" Q
 I 'Z D W1 G SD
 W "  "_$P(^PRCD(441.4,Z,0),U,3)
 S %=1 W !,"RIGHT OPTION " D YN^DICN D:%=0 DSPS G:%'=1 SD S X="   "_X Q
 ;
DSPS W !! F I=0:0 S I=$O(^PRCD(441.4,I)) Q:'I  I $D(^(I,0)),$P(^(0),U,2)="S" W $P(^(0),U,1)_"  "_$P(^(0),U,3),!
 Q
 ;
W1 W $C(7),!,"??   INVALID SELECTION",!! K X
 Q
 ;
EN2 ;ONLINE HELP FOR SOURCE DEVIATION/SERIAL NO.
 Q:'$D(PRCHCS("CANC"))  I PRCHCS("CANC")="" D DSPS Q
 W $C(7),!!,"Enter 4 digit Serial Number",!
 Q
