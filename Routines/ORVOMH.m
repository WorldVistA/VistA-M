ORVOMH ; slc/dcm - Help for ORVOM ;12/11/90  14:30 ;
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
R ; HELP FOR PREFIX
 W !?5,"Enter a unique 2 to 4 character prefix beginning with an uppercase",!?5,"letter and followed only by uppercase letters or numbers." Q:X'?1"??".E
 W !?5,"If this is an established package, you may enter one of the prefixes",!?5,"listed in the right column below."
 S DIC=9.4,DIC(0)="QE",DIC("W")="W ?35,$P(^(0),U,2)",DIZ=15 D ^DIC K DIC,DIZ Q
 ;
R1 ; HELP FOR RTN NAME
 W !?5,"Answer YES if you want to create a program called "_X W:$D(Q) !?5,"even though there already is one on file.  (It will be overwritten.)" W !?5,"Answer NO if you don't want to do this." S X=$P(X,"ONIT",1) Q
 ;
M ; HELP FOR MAX RTN SIZE
 W !?5,"Enter the maximum number of characters you would like each routine",!?5,"contain.  This number must be between 2000 and 10000." Q
 ;
VER ;Version # help
 W !!?3,"Package Version Number must be entered to put onto the second"
 W !?3,"line of the ONIT routines."
 W !!?3,"Format can be either the old type of version no. nnn.nn",!,?3,"or the new type, nnnXnn where X is either T for test phase",!?3,"or V for verification phase." Q
PNM ;Package name help
 W !!?3,"Enter the Package Name to go on the second line of the ONIT routines." Q
VDT ;Version Date help
 W !!?3,"Enter the Distribution Date for this Package, to go on the second",!?3,"line of the ONIT routines.  It should match the version date",!?3,"on the other routines being sent with this package." Q
