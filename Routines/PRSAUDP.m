PRSAUDP ; WOIFO/DWA - Display Employee Pay Period Audit Data ;12/3/07
 ;;4.0;PAID;**116**;Sep 21, 1995;Build 23
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;called by PRSADP2
 D RET Q:QT
 S STATYPE=$P(^DD(458.1101,4,0),"^",3)
 S PG=PG+1,X=$G(^PRSPC(DFN,0)) W @IOF,!,?3,$P(X,U,1) S X=$P(X,U,9)
 I '$G(PRSTLV)!($G(PRSTLV)=1) W ?68,"XXX-XX-",$E(X,6,9)
 I $G(PRSTLV)=2!($G(PRSTLV)=3) W ?68,$E(X),"XX-XX-",$E(X,6,9)
 I $G(PRSTLV)=7 W ?68,$E(X,1,3),"-",$E(X,4,5),"-",$E(X,6,9)
 W !,?26,"Corrected  T&A  History",!!
AUN S AUN=0 F  S AUN=$O(^PRST(458,PPI,"E",DFN,"X",AUN)) Q:AUN=""!(QT=1)  D B
 W @IOF
EX K AUN,AX0,B,CA,CB,CC,CD,DAY,DB,DISP,DTE,IFN,J,TYP,X,STATYPE,STATUS,LNE,DFN,AUR
 Q
B S B=-1 S B=$O(^PRST(458,PPI,"E",DFN,"X",AUN,B)) Q:B=""!(QT=1)  S AX0=$G(^(B))
 F CA=1:1:11 S AX0(CA)=$P(AX0,U,CA)
 S STDT="" F CB=2,11,9,7 S Y=AX0(CB) D DTP S AX0(CB)=Y S:Y'="" STDT=Y K Y ;date/time(s)
 F CC=3,6,8,10 I AX0(CC)]"" I $D(^VA(200,AX0(CC),0)) S AX0(CC)=$P(^VA(200,AX0(CC),0),U,1) ;names
 S TYP=AX0(4),LNE="" S $P(LNE,"-",80)="" S STATUS=$P($P(STATYPE,AX0(5)_":",2),";",1)
 Q:TYP'?1U  Q:"TVH"'[TYP  D @TYP
 I $D(^PRST(458,PPI,"E",DFN,"X",AUN,7)) W !!,"Change Remarks: ",^(7)
 D RET Q
RET I $E(IOST,1,2)="C-" R !!,"Press RETURN to Continue.",X:DTIME S:'$T!(X[U) QT=1 W @IOF
 Q
T ;Time/Tour Change
 W !,"Status: ",STATUS,?29,"* * * Prior Data * * *",?58,STDT S IFN=AUN S DAY=$P($G(^PRST(458,PPI,"E",DFN,"X",IFN,1)),"^",1),DTE=$P($G(^PRST(458,PPI,2)),"^",+DAY) D GET^PRSAPPP,DIS^PRSAPPQ
 W !!?27,"* * * Corrected Data * * *" S IFN=AUN+1 D GET^PRSAPPP,DIS^PRSAPPQ W !,LNE,!
 Q
V ;VCS Sales Change
 W !,"Status: ",STATUS,?29,"* * * Prior Data * * *",?58,STDT S IFN=AUN D GET^PRSAPPP S Z=AUR(1) D VCS^PRSAPPQ
 W !!?27,"* * * Corrected Data * * *" S IFN=AUN+1 D GET^PRSAPPP S Z=AUR(1) D VCS^PRSAPPQ W !,LNE,!
 Q
H ;Hazard Change
 W !,"Status: ",STATUS,?29,"* * * Prior Data * * *",?58,STDT S IFN=AUN D GET^PRSAPPP S Z=AUR(1) D ED^PRSAPPQ
 W !!?27,"* * * Corrected Data * * *" S IFN=AUN+1 D GET^PRSAPPP S Z=AUR(1) D ED^PRSAPPQ W !,LNE,!
 Q
DTP ; Printable Date/Time
 Q:'Y  S %=Y,Y=$J(+$E(Y,6,7),2)_"-"_$P("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec"," ",+$E(Y,4,5))_"-"_$E(Y,2,3)
 S:%#1 %=+$E(%_"0",9,10)_"^"_$E(%_"000",11,12),Y=Y_$J($S(%>12:%-12,1:+%),3)_":"_$P(%,"^",2)_$S(%<12:"am",%<24:"pm",1:"m") K % Q
