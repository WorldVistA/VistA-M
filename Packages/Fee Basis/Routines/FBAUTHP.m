FBAUTHP ;AISC/CMR - PRINT AUTH. BY AUTH # ;OCT 5, 1995
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 W !! S DIR(0)="FO^1:50^K:X'?.N1""-"".N X",DIR("A")="Enter Authorization Number",DIR("?")="Enter the Authorization Number that appears on the 7079",DIR("?",1)="Enter numerics followed by a dash followed by numerics."
 D ^DIR K DIR I $D(DIRUT)!(Y']"") G END
 S DFN=+$P(Y,"-"),FBPROG=+$P(Y,"-",2)
 I 'DFN!('FBPROG) G ERR
 I '$D(^FBAAA(DFN,1,FBPROG)) G ERR
 S FBPROG="I FBI="_FBPROG,PI=""
 D ^FBAADEM,END G FBAUTHP
END K FBPROG,DFN,FBAUT,FBAAOUT,PI,POP,X,Y,Z,DTOUT,DUOUT,DIRUT
 Q
ERR W !,*7,"Invalid Authorization Number" D END G FBAUTHP
