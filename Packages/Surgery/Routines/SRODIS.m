SRODIS ;BIR/ADM - LIST OF OPERATIONS BY DISPOSITION ; [ 09/22/98  11:33 AM ]
 ;;3.0; Surgery ;**48,77,50**;24 Jun 93
BEG S (SRSP,SRQ)=0,SRORD=1 W @IOF,!,"List of Operations by Postoperative Disposition:",!!
DATE D DATE^SROUTL(.SRSD,.SRED,.SRQ) G:SRQ END
DISP W @IOF,!,"Print the List of Operations for which of the following ?",!!,?10,"1. All Dispositions",!,?10,"2. A Specific Disposition",!,?10,"3. No Disposition Entered",!
 K DIR S DIR("A")="Enter selection: ",DIR("B")="1",DIR(0)="SA^1:All Dispositions;2:A Specific Disposition;3:No Disposition Entered"
 S DIR("?",1)="Enter 1 to print the report for all postoperative dispositions.  Enter 2 to",DIR("?",2)="print the report for a specific postoperative disposition.  Enter 3 to print"
 S DIR("?")="the report for operations with no postoperative disposition entered."
 D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRQ=1 G END
 I Y'=2 S SRDISP=$S(Y=3:"ZZ",1:"ALL") G SORT
TYPE W ! K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=131.6,DIC(0)="QEAMZ",DIC("A")="Print the report for which Disposition ?  " D ^DIC I Y<0 S SRQ=1 G END
 S SRDISP=+Y
SORT W !!,"Do you want the report sorted by surgical specialty ?  Y// " R SRYN:DTIME I '$T!(SRYN["^") S SRQ=1 G END
 S:SRYN="" SRYN="Y" S SRYN=$E(SRYN)
 I "YyNn"'[SRYN W !!,"Enter RETURN to sort the report by surgical specialty, or 'N' to not sort",!,"by surgical specialty." G SORT
 I "Nn"[SRYN S SRORD=0 G DEVICE
SER W !!,"Print for all surgical specialties ?  Y// " R SRYN:DTIME I '$T!(SRYN["^") S SRQ=1 G END
 S:SRYN="" SRYN="Y" S SRYN=$E(SRYN)
 I "YyNn"'[SRYN W !!,"Enter RETURN to print the report for all surgical specialties, or 'N' to print",!,"the report for a specific specialty." G SER
 I "Nn"[SRYN D SP I SRQ G END
DEVICE K IOP,%ZIS,POP,IO("Q") S %ZIS("A")="Print the Report on which Device: ",%ZIS="QM" W !!,"This report is designed to use a 132 column format.",! D ^%ZIS G:POP END
 I $D(IO("Q")) K IO("Q") S ZTDESC="LIST OF OPERATIONS",ZTRTN="^SRODIS0",(ZTSAVE("SRORD"),ZTSAVE("SRSP*"),ZTSAVE("SRED"),ZTSAVE("SRDISP"),ZTSAVE("SRSD"),ZTSAVE("SRSITE*"))="",%ZIS="QM" D ^%ZTLOAD G END
 D ^SRODIS0
 Q
SP W ! S SRSP=1 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Print the report for which Specialty ?  " D ^DIC I Y<0 S SRQ=1 Q
 S SRSP(+Y)=+Y
MORE ; more specialties?
 K DIC S DIC("S")="I '$P(^(0),""^"",3)",DIC=137.45,DIC(0)="QEAMZ",DIC("A")="Select An Additional Specialty:  " D ^DIC I Y>0 S SRSP(+Y)=+Y G MORE
 Q
END I 'SRQ,($E(IOST,1)'="P") W !!,"Press RETURN to continue  " R X:DTIME
 W ! D ^SRSKILL K SRTN D ^%ZISC W @IOF
 Q
RET W !!,"  Press RETURN to continue, or '^' to quit: " R X:DTIME I '$T!(X["^") S SRQ=1 Q
 I X["?" W !!,"Press RETURN to continue with the List of Surgical Cases sorted by Postop",!,"Disposition, or '^' if you do not want to review any additional information." G RET
 Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRQ=1 Q
 I SRHDR,$E(IOST)'="P" D RET Q:SRQ
 W:$Y @IOF W !,?(132-$L(SRINST)\2),SRINST,?126,"PAGE",!,?58,"SURGICAL SERVICE",?127,$J(PAGE,3)
 W !,?46,"LIST OF OPERATIONS BY POSTOP DISPOSITION",?100,SRPRINT
 W !,?(132-$L(SRFRTO)\2),SRFRTO,?100,"REVIEWED BY:"
 S SRDISP1=$S(SRP:$P(^SRO(131.6,SRP,0),"^"),SRP="ZZ":"DISPOSITION NOT ENTERED",1:"")
 I SRP'="" S SRTP="POSTOP DISPOSITION: "_SRDISP1 W !,?(132-$L(SRTP)\2),SRTP,?100,"DATE REVIEWED:"
 I SRP="" W !,?100,"DATE REVIEWED:"
 W !!,"DATE",?13,"PATIENT",?38,"OPERATION(S)",?90,"SURGEON",?114,"ANESTHESIA TECH",!,"CASE #",?15,"ID#",?90,"1ST ASST",?114,"IN/OUT-PAT STATUS",!,?90,"2ND ASST",?114,"OP TIME" W ! F I=1:1:132 W "-"
 I $D(SRSPEC) W !,?(132-$L(">> "_SRSPEC_" <<")\2),">> "_SRSPEC_" <<",!
 S SRHDR=1,PAGE=PAGE+1
 Q
