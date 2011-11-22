PRPFDSI1 ;ALTOONA/CTB  CONTINUATION OF INFORMATION DISPLAY ;11/22/96  4:37 PM
V ;;3.0;PATIENT FUNDS;**6**;JUNE 1, 1989
S2 ;SCREEN 2
 I IOSL<40 W @IOF W @PFLO,"Name: ",@PFHI,$P(DFN(0),"^"),?44 S SSN=$P(DFN(0),"^",9) W @PFLO,"SSN: ",@PFHI,$E(SSN,1,3),@PFLO,"-",@PFHI,$E(SSN,4,5),@PFLO,"-",@PFHI,$E(SSN,6,9),@PFLO,"  Claim #: ",@PFHI,$P(DFN(.31),"^",3) K SSN
 D DEAD^PRPFED
 W !,@PFLO,"Nearest Relative:",?31,"VA Guardian",?56,"Civil Guardian"
 W @PFHI F I=1:1:9 I $P(DFN(.29),U,I)]""!($P(DFN(.21),U,I)]"")!($P(DFN(.291),U,I)]"") W !,$E($P(DFN(.21),U,I),1,29),?31,$E($P(DFN(.29),U,I),1,24),?56,$E($P(DFN(.291),U,I),1,24)
 W !!,@PFLO,"General Information/Remarks: ",!
 I $D(^PRPF(470,DFN,7)),$O(^(7,0))>0 D GI
 I $D(^XUSEC("PRPF CLERK",DUZ)) W !,@PFLO,"Special Information: ",! I $D(^PRPF(470,DFN,8)),$O(^(8,0))>0 D SI
 W !,@PFLO,"Sources of Income: ",@PFHI S I=$S('$D(^PRPF(470,DFN,6,0)):0,$O(^(0))="":0,1:1) I 'I W "NONE LISTED" G A
 W !!,@PFLO,"Source:",?24,"Payee:",?46,"Amount:",?60,"Frequency:"
 W @PFHI S N1=0 F J=1:1 S N1=$O(^PRPF(470,DFN,6,N1)) Q:'N1  I $D(^(N1,0)) S Z=^(0) W !,$P(Z,U),?24,$P(Z,U,2),?46 S X=$P(Z,U,3) D C W X,?60 S DD=470.05,F=3,X=$P(Z,U,4) D ^PRPFU1 W Y
A I IOST["C-" W @PFNORM,!!,"Press RETURN to continue or 'B' to BACKUP to previous screen: " R X:DTIME G END:X="",A:X["?",B^PRPFDSI:"Bb"[X
END W @IOF,@PFNORM K %I,%W,%Y,C,DIYS,DFN,DG1,DGT,DGX,DIC,DIW,DIWT,DN,DOA,N,PDFN,Z,TMP Q
GI ;PRINT GENERAL INFORMATION REMARKS
 W @PFHI S N=0,DIWF="W",DIWL=5,DIWR=IOM-10 F I=1:1 S N=$O(^PRPF(470,DFN,7,N)) Q:N=""  S X=^(N,0) D ^DIWP
 D ^DIWW K DIWF,DIWL,DIWR,X W @PFNORM Q
SI ;PRINT SPECIAL INFORMATION
 W @PFHI S N=0,DIWF="W",DIWL=5,DIWR=IOM-10 F I=1:1 S N=$O(^PRPF(470,DFN,8,N)) Q:N=""  S X=^(N,0) D ^DIWP
 D ^DIWW K DIWF,DIWL,DIWR,X W @PFNORM Q
C S X2="2$"
 S %D=X<0 S:%D X=-X S %=$S($D(X2):+X2,1:2),X=$J(X,1,%),%=$L(X)-3-$E(23456789,%)
 F %=%:-3 Q:$E(X,%)=""  S X=$E(X,1,%)_","_$E(X,%+1,99)
 S:$D(X2) X=$E("$",X2["$")_X S X=$J($E("(",%D)_X_$E(" )",%D+1),0) K %,%D Q
