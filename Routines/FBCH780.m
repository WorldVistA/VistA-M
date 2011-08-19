FBCH780 ;AISC/DMK-7078/AUTHORIZATION CON'T ;8/18/2004
 ;;3.5;FEE BASIS;**82**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
DISP D HOME^%ZIS W @IOF
 W !! S DA=FBAA78,DR="0;1",DIC="^FB7078(" D EN^DIQ
ASK S DIR(0)="Y",DIR("A")="Is this Correct",DIR("B")="NO" D ^DIR K DIR S:$D(DIRUT) FBOUT=1 Q:$G(FBOUT)  G EDIT:'Y
 S DFN=+$P($G(^FB7078(+FBAA78,0)),"^",3)
 W !,?2,"....Posting to 1358",! D WAIT^DICD,POST Q
END W ! Q
EDIT W ! S (DIC,DIE)="^FB7078(",DA=FBAA78,DR="[FBCH EDIT 7078]" D ^DIE
 G DISP
HELP W !!,"Select one of the following: ",!,?18,"'00' FOR SURGICAL",!,?18,"'10' FOR MEDICAL",!,?18,"'86' FOR PSYCHIATRY",! Q
POST S PRCS("X")=FBCHOB,PRCS("TYPE")="FB" D EN3^PRCS58 I Y=-1 W !!,*7,"1358 not available for posting!",! Q
 S FBCOMM=$S($D(FBNAME):FBNAME_" - "_FBSSN,1:"Estimated amount")
 D NOW^%DTC S X=FBCHOB_"^"_%_"^"_FBEST_"^"_""_"^"_FBSEQ_"^"_FBCOMM_"^"_DFN_";"_+FBAA78_";"_$P(FBCHOB,"-",2),PRCS("TYPE")="FB"
 D EN2^PRCS58 Q
NULL W !,*7,"Enter the reason for pending disposition or an '^' to exit",! G FBPDIS^FBCH78
NULL1 W !,*7,"This is a required response. Enter an '^' to exit.",! Q
 ;
DISCH(X) ;X = Pointer for 7078
 ;output = patient's Type of Discharge
 N Y
 S Y=$O(^FBAAI("E",X_";FB7078(",0))
 I 'Y Q Y
 S Y=+$P($G(^FBAAI(Y,0)),U,21)
 Q $S($P($G(^FBAA(162.6,Y,0)),U)]"":$P(^(0),U),1:"")
 ;
PTF ;called to create a non-va ptf record at admission time for an
 ;authorized claim.  Called from FBCH78.
 ;
 ; input
 ;   DFN    - ien of patient in file #2
 ;   FBAA78 - ien of 7078 authorization in file #162.4
 ;
 N FBDT
 ;
 ; obtain Authorization From Date from 7078 authorization to use
 ; as the admission date on the PTF record
 S:$G(FBAA78) FBDT=$P($G(^FB7078(+FBAA78,0)),U,4)
 ;
 ; call utility to attempt creation of a Non-VA PTF record
 D PTFC^FBUTL6($G(DFN),$G(FBDT))
 Q
