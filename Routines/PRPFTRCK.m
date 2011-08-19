PRPFTRCK ;ALTOONA/CTB MODIFIED INPUT TRANS FOR PATIENT FUNDS SYSTEM  ;11/22/96  4:47 PM
V ;;3.0;PATIENT FUNDS;**6**;JUNE 1, 1989
 ; USED TO CHECK THE TRANSACTION AMOUNT
 I X=""!(X["^") K X Q
 S:X["$" X=$P(X,"$",2) I X'?."-".N.1".".2N K X Q
 W "   $ ",$J(X,0,2)
 I X>100000!(X<-100000) S %=1,%A="Are you sure about this amount",%B="" D ^PRPFYN G:%<0 DELETE I %=2 K X Q
 I '$D(DEP) K X Q
 S:DEP="W" X=-X S X1=X D ^PRPFDEF S D0(1)=D0,D0=+DFN X $P(^DD(470,30.5,0),"^",5,99) S D0=D0(1) K D0(1) S PRBAL("DEF")=X,PRBAL("SB")=$P(DFN(1),"^",4)
 I -X1'<0,PRBAL("SB")<-X1 W !,"The balance of $ ",$J(PRBAL("SB"),0,2)," is not sufficient to complete this transaction. " G OVRDRW
 I -X1'<0,(PRBAL("SB")-PRBAL("DEF"))<-X1 W *7,!,"Because of a deferred item in this account, the available balance is",!,"insufficient to fund this withdrawal.",! D OVRDEF I X="K",$D(PRPF("KILL")) Q
 S DFN(1)=^PRPF(470,DFN,1) I DEP="W",$P(DFN(1),"^",7)>0,$P(DFN(1),"^",7)-$P(DFN(1),"^",11)<-X1 S PRPFW="MONTHLY" D WARN K PRPFW I %'=1 G DELETE
 I DEP="W",$P(DFN(1),"^",8)>0,$P(DFN(1),"^",8)-$P(DFN(1),"^",12)<-X1 S PRPFW="WEEKLY" D WARN K PRPFW I %'=1 G DELETE
A1 S X=X1 Q
DELETE S X="K",PRPF("KILL")="" Q
OVRDRW ;CHECK FOR AUTHORIZATION TO OVERDRAW
 G:'$D(^XUSEC("PRPF OVERDRAW",DUZ)) DELETE
 S %A="Processing of this transaction will cause this patient's account",%A(1)="to be overdrawn.  You will be assuming PERSONAL responsibility",%A(2)="for this action."
 S %A(3)="DO YOU WISH TO OVERDRAW THIS ACCOUNT",%B="",%=2 D ^PRPFYN I %'=1 G DELETE
 W !,*7 K % S %A="Are you sure you wish to OVERDRAW this account",%B="" D ^PRPFYN G:%'=1 DELETE
 W *7,!,"* * * ACCOUNT OVERDRAWN * * *"
 S PRPFBUL("OVERDRAW")=""
 G A1
WARN S %A="** WARNING, Posting this amount will exceed the "_PRPFW_" withdrawal limitation **",%A(1)="Is is OK to exceed the "_PRPFW_" limitation",%B="",%=2 D ^PRPFYN
 S:%=1 PRPFBUL("RESTRICTION")=""
 Q
OVRDEF ;OVERRIDE DEFERRAL
 I $D(^XUSEC("PRPF DEFERRAL OVERRIDE")),'$D(^XUSEC("PRPF DEFERRAL OVERRIDE",DUZ)) G DELETE
 S %A="When overriding a deferral date, you are assuming PERSONAL responsibility for a",%A(1)="loss of funds, should one occur as a result of this action."
 S %A(2)="DO YOU WISH TO OVERRIDE",%B="" S %=2 D ^PRPFYN G:%'=1 DELETE
 I -X1'<0,(PRBAL("SB")-PRBAL("DEF"))<-X1 W ! S %A="ARE YOU SURE THAT YOU WANT TO OVERRIDE",%B="",%=2 D ^PRPFYN G:%'=1 DELETE
 S PRPFBUL("DEFERRAL")=""
 Q
