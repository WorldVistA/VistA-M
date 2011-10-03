GMPLDIS1 ; SLC/MKB -- Displays current/default values for saving ;5/26/94  15:22
 ;;2.0;Problem List;;Aug 25, 1994
ACCEPT(GMPFLD) ; accept current values of problem to save?
 N DIR,X,Y D DISPLAY W !
 S DIR(0)="SAOM^S:SAVE;E:EDIT;Q:QUIT;",DIR("B")="SAVE"
 S DIR("A")="(S)ave this data, (E)dit it, or (Q)uit w/o saving? "
 S DIR("?")="^D HELP^GMPLDIS1"
 D ^DIR I $D(DUOUT)!($D(DTOUT))!(Y="Q") Q "^"
 Q $S(Y="S":1,1:0)
HELP ; help msg for $$ACCEPT, redisplay values
 N X
 W !!?11,"Select SAVE to save this problem as listed and"
 W !?11,"continue; enter E to change any of these values,"
 W !?11,"or Q to exit to the problem list without saving."
 W !!,"Press <return> to redisplay the problem values ..."
 R X:DTIME D DISPLAY
 Q
DISPLAY ; display current values for problem in GMPFLD array
 N SP,I,NTS,CMMT,TEXT,PROB S NTS=0,(SP,CMMT)="" Q:$D(GMPFLD)'>9
 F I=1.11,1.12,1.13 S:$P(GMPFLD(I),U) SP=SP_$P(GMPFLD(I),U,2)_U
 S:$L(SP) SP=$E(SP,1,$L(SP)-1) ; strip final "^"
 F I=0:0 S I=$O(GMPFLD(10,"NEW",I)) Q:I'>0  S:$L(GMPFLD(10,"NEW",I)) NTS=NTS+1
 I NTS S CMMT="<"_NTS_" Comment"_$S(NTS=1:"",1:"s")_" appended>"
 S PROB=$P(GMPFLD(.05),U,2)
 I $L(PROB)'>68 S TEXT(1)=PROB,TEXT(2)=CMMT,TEXT=2
 I $L(PROB)>68 S:NTS PROB=PROB_" "_CMMT D WRAP^GMPLX(PROB,65,.TEXT)
DIS1 W !! W:'VALMCC $$REPEAT^XLFSTR("-",79)
 W !,"  Problem: "_TEXT(1)
 F I=2:1:TEXT W !,"           "_TEXT(I)
 W !,"    Onset: "_$P(GMPFLD(.13),U,2)
 W:GMPVA ?51,"SC Condition: "_$P(GMPFLD(1.1),U,2)
 W !,"   Status: "_$P(GMPFLD(.12),U,2)
 I $P(GMPFLD(.12),U)="A",$L(GMPFLD(1.14)) W "/"_$P(GMPFLD(1.14),U,2)
 I $P(GMPFLD(.12),U)="I",$L(GMPFLD(1.07)) W ", Resolved "_$$EXTDT^GMPLX($P(GMPFLD(1.07),U))
 W:GMPVA ?55,"Exposure: "_$S('$L(SP):"<none>",1:$P(SP,U))
 W !," Provider: "_$P(GMPFLD(1.05),U,2)
 W:$L(SP,U)>1 ?65,$P(SP,U,2)
 I $E(GMPLVIEW("VIEW"))="S" W !,"  Service: "_$P(GMPFLD(1.06),U,2)
 E  W !,"   Clinic: "_$P(GMPFLD(1.08),U,2)
 W:$L(SP,U)>2 ?65,$P(SP,U,3)
 W !," Recorded: "_$P(GMPFLD(1.09),U,2)_" by "_$P(GMPFLD(1.04),U,2)
 I $D(^XUSEC("GMPL ICD CODE",DUZ)) W ?55,"ICD Code: "_$P(GMPFLD(.01),U,2)
 W:'VALMCC !,$$REPEAT^XLFSTR("-",79)
 Q
