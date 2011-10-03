SROR ;B'HAM ISC/MAM - EDIT OPERATING ROOMS ; [ 11/14/01  11:33 AM ]
 ;;3.0; Surgery ;**50,104,105**;24 Jun 93
START W @IOF,! K DIC S DIC="^SRS(",DIC("S")="I $$ORDIV^SROUTL0(+Y,$G(SRSITE(""DIV""))),$P(^SRS(+Y,0),U)",DIC(0)="QEAMZ",DIC("A")="Enter/Edit Information for which Operating Room ?  " D ^DIC I Y<0 G END
 K DR W !! S SRORNM=Y(0,0),(SROR,DA)=+Y,DIE="^SRS(",DR="[SRO-ROOM]",Q3(1)=SRORNM_"   ** Update O.R. **" K Y D ^SRCUSS
END W @IOF D ^SRSKILL
 Q
