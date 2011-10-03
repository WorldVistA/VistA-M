FBPRICE ;AISC/DMK-GENERIC PRICER INTERFACE ;25JUN92
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;build a transaction to send to the Austin Pricer system
 ;this data will NOT be stored anywhere. It serves only
 ;as a tool to determine reimbursement rates.
 S PAD="                              "
 S FB("ERROR")="" D STATION^FBAAUTL G END:FB("ERROR") K FB("ERROR")
 S FBSTAN=FBAASN_$E(PAD,$L(FBAASN)+1,6)
PAT ;ask patient name [this is not a look-up on file 2]
 W ! S DIR("A")="Want to select patient from DHCP Patient File",DIR(0)="Y",DIR("B")="Yes" D ^DIR K DIR Q:$D(DIRUT)  I Y D  G END:'$D(FBSSN),VEND
 .W ! S DIC="^DPT(",DIC(0)="AEQMZ" D ^DIC K DIC Q:X="^"!(X="")!(Y<0)
 .D PAT^FBAAUTL2 S FBLNAM=$E(FBFLNAM,1,12),FBSSN=$E(FBSSN,10)_$E(FBSSN,1,9)_" "
 ;
 W ! S DIR("A")="Enter LAST NAME",DIR(0)="F^3:20^K:X'?.A X",DIR("?")="Enter last name of patient.  Answer must be 3 to 20 characters in length" D ^DIR K DIR Q:$D(DIRUT)  S FBLNAM=$E(Y,1,12)_$E(PAD,$L(Y)+1,12)
 ;
 S DIR("A")="Enter FIRST INITIAL",DIR(0)="F^1:1^K:X'?1A X" D ^DIR K DIR Q:$D(DIRUT)  S FBFI=Y
 ;
 S DIR("A")="Enter MIDDLE INITIAL",DIR(0)="FO^1:1^K:X'?1A X" D ^DIR K DIR Q:$D(DUOUT)!($D(DTOUT))  S FBMI=$S(Y]"":Y,1:" ")
 ;
 S FBNAME=FBLNAM_FBFI_FBMI
SSN ;ASK SSN
 S DIR("A")="Patient ID Number",DIR("?")="Answer must contain 9 numbers.  Pseudo-SSN not allowed",DIR(0)="F^9:9^K:X'?9N X" D ^DIR K DIR Q:$D(DIRUT)  S FBSSN=" "_Y_" "
 ;
DOB S DIR(0)="2,.03",DIR("A")="Date of Birth" D ^DIR K DIR Q:$D(DIRUT)  S FBDOB=$E(Y,4,7)_($E(Y,1,3)+1700)
 ;
SEX ;ask sex of patient
 S DIR("A")="Sex of Patient",DIR(0)="2,.02" D ^DIR K DIR G END:$D(DIRUT) S FBSEX=Y
VEND ;ask vendor
 S DIR("A")="Want to select a vendor from DHCP Fee Basis Vendor file",DIR(0)="Y",DIR("B")="Yes" D ^DIR K DIR Q:$D(DIRUT)  I Y D  G END:+$G(FBOUT),VEND:'$D(FBVID),CONT
 .W ! S DIC="^FBAAV(",DIC(0)="AEQMZ" D ^DIC K DIC S:X=""!(X="^") FBOUT=1 Q:Y<0  S FBSTABR=+$P(Y(0),"^",5),FBSTABR=$P($G(^DIC(5,FBSTABR,0)),"^",2),FBSTABR=$S('$L(FBSTABR):"  ",1:FBSTABR)
 .S FBVID=$P(Y(0),"^",17) I FBVID="" K FBVID W !!,*7,"Vendor must have a Medicare ID number to send to the pricer.",! Q
 W ! S DIR("A")="Select Vendor Name",DIR(0)="F^2:46" D ^DIR K DIR G END:$D(DIRUT) S FBVEN=Y
 S DIR("A")="Enter Medicare ID Number",DIR(0)="161.2,22" D ^DIR K DIR G END:$D(DIRUT) S FBVID=Y
 S DIR("A")="State of Vendor",DIR(0)="P^5:EQMZ" D ^DIR K DIR G END:$D(DIRUT) S FBSTABR=$S($L($P(Y(0),"^",2)):$P(Y(0),"^",2),1:"  ")
 ;
CONT ;ask admission and treatment type information
 W ! S DIR("A")="Admission Date: ",DIR(0)="DA^::EX",DIR("?")="^D HELP^%DTC" D ^DIR K DIR G END:$D(DIRUT) S FBFDT=Y
 S DIR("A")="Discharge Date: ",DIR(0)="DA^"_FBFDT_"::EX",DIR("?")="^D HELP^%DTC" D ^DIR K DIR G END:$D(DIRUT) S FBTDT=Y
 S X1=FBTDT,X2=FBFDT D ^%DTC S FBLOS=$S(X<1:1,1:X),FBLOS=$E("000",$L(FBLOS)+1,3)_FBLOS
 F I="FBFDT","FBTDT" S @I=$E(@I,4,7)_($E(@I,1,3)+1700)
 ;
 S DIR(0)="P^43.4:EQM",DIR("A")="Admitting Authority" D ^DIR K DIR G END:$D(DIRUT) S Z=+Y
 S FBAUTH=$$AUTH^FBAAV6(Z) K Z
 ;
 S DIR("A")="Disposition Code",DIR(0)="P^162.6:QEMZ" D ^DIR K DIR G END:$D(DIRUT) S FBDISP=$E("00",$L($P(Y(0),"^",2))+1,2)_$P(Y(0),"^",2)
 ;
 S DIR("A")="Is this a Patient Reimbursement",DIR(0)="Y",DIR("B")="No" D ^DIR K DIR G END:$D(DIRUT) S FBPAYT=$S(Y:"P",1:"V")
 ;
 S DIR("A")="Payment by Medicare or Other Federal Agency",DIR(0)="Y",DIR("B")="No" D ^DIR K DIR G END:$D(DIRUT) S FBMED=$S(Y:"Y",1:"N")
 ;
 D ^FBPRICE1
 ;
END K FBSTAN,FBAUTH,FBBILL,FBCLAIM,FBDISP,FBDOB,FBDX,FBFDT,FBFI,FBFLNAM,FBLNAM,FBLOS,FBMED,FBMI,FBNAME,FBOBL,FBPAYT,FBPRC,FBSEX,FBSITE,FB,FBAASN,FBFEE,FBI,FBJ,FBLN,FBNVP,FBOKTX,FBSN,FBXMZ
 K FBSSN,FBSTR,FBSTABR,FBTDT,FBVID,PAD,POP,PRC,DUOUT,DTOUT,DIRUT,DIR,FBPART1,FBVEN,FBSDI,VAT,VATERR,VATNAME,Y,FBPOP,FBVAR,FBXMFEE,FBXMNVP,FBPOP
 Q
