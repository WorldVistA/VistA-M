FBUCUTL9 ;WOIFO/SAB - UTILITY ;7/3/2001
 ;;3.5;FEE BASIS;**32**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
ASKMB() ; Ask user what kind of claims should be included/excluded. Normally
 ; called by report options.
 ;INPUT: none
 ;OUTPUT:
 ;RETURNS a value (M,N,A)
 N DIR,DTOUT,DUOUT,DIROUT,DIRUT,X,Y
 S DIR(0)="SM^M:MILL BILL (38 U.S.C. 1725);N:NON-MILL BILL;A:ALL"
 S DIR("B")="ALL"
 S DIR("?",1)="Enter M to include only 38 U.S.C. 1725 claims."
 S DIR("?",2)="Enter N to exclude 38 U.S.C. 1725 claims."
 S DIR("?",3)="Enter A for all."
 S DIR("?",4)=" "
 S DIR("?")="Enter a code from the list"
 D ^DIR K DIR
 Q $S($D(DIRUT):"",1:Y)
 ;FBUCUTL9
