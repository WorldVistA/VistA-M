PRS8TL ;HISC/MRL-DECOMPOSITION, SELECTIVE T&L ;2/19/93  13:12
 ;;4.0;PAID;;Sep 21, 1995
 ;
 ;This routine is used to decompose, or re-decompose, all entries
 ;for a specific T&L for a selective Pay Period.  Entries which
 ;have already been transmitted will not be affected by this process.
 ;
 ;Called by Routines:  PRS8
 ;
 S QUIT=0
PP ; --- get Pay Period
 S SEE=1 D PY^PRS8 ;get pay period
 Q:QUIT  G END:'OK S PY(0)=$P(^PRST(458,+PY,0),"^",1)
 ;
SHOW ; --- show only
 W !!,"Want to just SEE what's stored already and not decompose"
 S %=2 D YN^DICN I %<0 G END
 I %,%>0 S SHOW=$S(%=2:0,1:1),SHOW(1)=$S(SHOW:"SEE",1:"DECOMPOSE") G DECOM:'SHOW S DECOM=0 G ASK
 W !?4,"Answer YES if you wish to display what's been previously decomposed."
 W !?4,"Respond NO if you actually want to decompose records."
 D OUT G SHOW
 ;
DECOM ; --- decompose even if done
 W !!,"Should I decompose only those records which have not been decomposed" S %=2 D YN^DICN
 S DECOM=0 I % G END:%<0 S DECOM=%-1 G ASK
 W !?4,"Answer YES if you wish to decompose only records not previously decomposed."
 W !?4,"Respond NO to decompose all records which have been released to payroll but",!?4,"have not yet been transmitted." D OUT G DECOM
ASK ; --- loop thru all T&L's
 W !!,"Want to ",SHOW(1)," all T&L's for Pay Period ",PY(0) S %=2 D YN^DICN
 I %,QUIT Q
 I %=1 S PRS8("DES")="Decomposition of all T&L's for PP ",PRS8("PGM")="TLA^PRS8TL" G DEV
 I % G END:%=-1,TL
 W !?4,"Answer YES if you wish to ",SHOW(1)," all records for PP ",PY(0),"."
 W !?4,"Respond NO if you wish to ",SHOW(1)," records for specific T&L's."
 D OUT G ASK
 ;
TL ; --- Specific T&L Selection
 W ! S CT=0 K TLU
 F PRS8=1:1 D  Q:+Y'>0
 .S DIC="^PRST(455.5,",DIC(0)="AEQMZ",DIC("A")="Select T&L Unit:  "
 .I CT S DIC("A")="Select  ANOTHER:  "
 .D ^DIC
 .I Y>0,$D(TLU(Y(0,0))) W !?4,"T&L has already been selected!!",*7 Q
 .I $D(^PRST(455.5,+Y,0)) S CT=CT+1,TLU(Y(0,0))=""
 I $O(TLU(0))="" W !?4,"No T&L's have been selected!",*7 Q:QUIT  G END
 W !! S (CT,CT1)=0,J="" F I=0:0 S J=$O(TLU(J)) Q:J=""  D
 .S CT=CT+1,CT1=CT1+1 I CT1=7 S CT1=1 W !
 .S X=(CT1*10-CT1) W ?X,J
 ;
OK ; --- are the selections ok
 W !!,$S(CT=1:"Is this the T&L",1:"Are these the T&L's")
 W " to be processed" S %=2 D YN^DICN
 I %,QUIT Q
 I % G TL1:%=1,TL:%=2,END
 W !?4,"Answer YES if these are the T&L's you want to ",SHOW(1),"."
 W !?4,"Answer NO if you wish to select another T&L (or set of T&L's)."
 D OUT G OK
 ;
TL1 ; --- T&L's are ok, let's go on
 S PRS8("DES")="Decomposition of Specific T&L's",PRS8("PGM")="TL2^PRS8TL" G DEV
 ;
TL2 ; --- entry point from QUEUE for running specific T&L's
 D COVER^PRS8TL1
 S TLU="" F TLU1=0:0 S TLU=$O(TLU(TLU)),NAME="" Q:TLU=""!(PRS8("QUIT"))  D ^PRS8TL1
 I 'PRS8("QUIT") S PRS8("QUIT")=1 D TOP^PRS8TL1
 G END
 ;
TLA ; --- entry point from QUEUE for running all T&L's
 D COVER^PRS8TL1
 S TLU1="ATL00" F  S TLU1=$O(^PRSPC(TLU1)),NAME="" Q:TLU1'?1"ATL".E!(PRS8("QUIT"))  S TLU=$E(TLU1,4,6) D ^PRS8TL1
 I 'PRS8("QUIT") S PRS8("QUIT")=1 D TOP^PRS8TL1
 G END
 ;
OUT ; --- write exit comment
 W !?4,"You may enter an up-arrow [""^""] if you wish to QUIT now!",*7 Q
 ;
DEV ; --- select output device
 W !!,"WARNING:  This report is designed to run with a 132-column Right Margin!"
 S PRS8("DES")=PRS8("DES")_" "_PY(0),PRS8("VAR")="PY^PY(^SHOW^DECOM^TLU(" D ^PRS8UT
 ;
END ; --- all done here
 G ALL^PRS8CV
