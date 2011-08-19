FBAAPH ;AISC/DMK,GRR-LIST PAYMENT HISTORY ;8/10/2003
 ;;3.5;FEE BASIS;**2,4,32,61**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 D DT^DICRW
RD K FBAANQ,FB,FBTRX W !! S FBAAOUT=0,DIC="^FBAAC(",DIC(0)="AEQMNZ",DIC("A")="Select Fee Patient: " D ^DIC K DIC("A") G Q:X="^"!(X=""),RD:Y<0 S DFN=+Y,FBNAME=Y(0,0)
 I '$D(^FBAAC(DFN,"AB")) W !!,"No payments for this patient!",! G RD
 S FBSSN=$$SSN^FBAAUTL(DFN)
 D HOME^%ZIS ;S VAR="FBNAME^DFN",VAL=FBNAME_"^"_DFN,PGM="LIST^FBAAPH" D ZIS^FBAAUTL G:FBPOP Q S:IO=IO(0) FBAANQ=1
LIST S:'$D(FBNAME) FBNAME=$P($G(^DPT(+DFN,0)),"^")
 S FBPHOUT=1
 U IO S FBAAOUT=0 D ^FBAADEM I FBAAOUT'=1,$E(IOST,1,2)="C-" S DIR(0)="E" D ^DIR K DIR G Q:$D(DIRUT)
 K Q S $P(Q,"=",80)="="
 S FBAAOUT=0 W:$E(IOST,1,2)["C-" @IOF D HED S J=DFN
 F I=0:0 S I=$O(^FBAAC(J,"AB",I)) Q:I=""!(FBAAOUT)  F K=0:0 S K=$O(^FBAAC(J,"AB",I,K)) Q:K=""!(FBAAOUT)  F L=0:0 S L=$O(^FBAAC(J,"AB",I,K,L)) Q:L=""!(FBAAOUT)  D SETTR F M=0:0 S M=$O(^FBAAC(J,1,K,1,L,1,M)) Q:'M  D SET Q:FBAAOUT
 G RD:FBAAOUT!('$D(FB)) S FBTRCK=1,D=0 F  S D=$O(FB(D)) Q:'D  S FBTRX=0 F  S FBTRX=$O(FB(D,FBTRX)) Q:'FBTRX  D WRTCK Q:FBAAOUT  W:$G(FBTRCK) !!,?5,"TRAVEL PAYMENTS: " D  K FBTRCK
 .W ?22,$$DATX^FBAAUTL(D),?35,$P(FB(D,FBTRX),"^") I $P(FB(D,FBTRX),"^",3)]"" W ?44,"Check #: ",$P(FB(D,FBTRX),"^",2),?63,"Paid: ",$$DATX^FBAAUTL($P(FB(D,FBTRX),"^",3))
 G RD
 W !! D CLOSE^FBAAUTL K FBNAME,DFN,J,FBAANQ,FBAAOUT,DIC,VAL,VAR,PGM Q
SET ;
 N FBAARCE,FBADJLA,FBADJLR,FBCSID,FBFPPSC,FBFPPSL,FBRRMKL,FBUNITS
 N FBX,FBY2,FBY3,TAMT
 S V=$P($G(^FBAAV(K,0)),"^"),FBVID=$S(V]"":$P(^(0),"^",2),1:"")
 S Y=^FBAAC(J,1,K,1,L,1,M,0),T=$P(Y,"^",5),D2=$P(Y,"^",6),FBDOS=D2,D2=$S(D2="":"",1:$E(D2,4,5)_"/"_$E(D2,6,7)_"/"_$E(D2,2,3)),FBCP=$P(Y,"^",18),FBCP=$S(FBCP=1:"(C&P)",1:"")
 S FBAACPTC=$$CPT^FBAAUTL4(+Y)
 S FBOB=$P(Y,"^",10)
 I T]"" S T=$P($G(^FBAA(161.27,+T,0)),"^")
 S A1=$P(Y,"^",2)+.0001,A2=$P(Y,"^",3)+.0001,A1=$P(A1,".",1)_"."_$E($P(A1,".",2),1,2),A2=$P(A2,".",1)_"."_$E($P(A2,".",2),1,2)
 S FBAPS=$$APS^FBAAUTL4(J,K,L,M)
 S FBTYPE=$P(Y,"^",20),FBVP=$P(Y,"^",21),FBIN=$P(Y,"^",16),FBBN=$P(Y,"^",8),FBBN=$S(FBBN']"":"",$D(^FBAA(161.7,FBBN,0)):$P(^(0),"^"),1:""),FBBN=$S(FBBN="":"",1:$E("00000",$L(FBBN)+1,5)_FBBN)
 S FBY3=$G(^FBAAC(J,1,K,1,L,1,M,3))
 S FBFPPSC=$P(FBY3,U)
 S FBFPPSL=$P(FBY3,U,2)
 S FBX=$$ADJLRA^FBAAFA(M_","_L_","_K_","_J_",")
 S FBADJLR=$P(FBX,U)
 S FBADJLA=$P(FBX,U,2)
 S TAMT=$FN($P(Y,"^",4),"",2)
 S FBAARCE=$$GET1^DIQ(162.03,M_","_L_","_K_","_J_",",48)
 S FBY2=$G(^FBAAC(J,1,K,1,L,1,M,2))
 S FBUNITS=$P(FBY2,U,14)
 S FBCSID=$P(FBY2,U,16)
 S FBRRMKL=$$RRL^FBAAFR(M_","_L_","_K_","_J_",")
 D FBCKO^FBAACCB2(J,K,L,M)
 S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_J_",1,"_K_",1,"_L_",1,"_M_",""M"")","E")
 D WRT
 Q
WRT D WRTCK Q:FBAAOUT
 W !!,"Vendor: ",$E(V,1,33),"     Vendor ID: ",FBVID,?66," Obl.#: "_FBOB
 W !,$S(FBTYPE="R":"*",1:" "),$S(FBVP="VP":"#",1:""),$S($G(FBCAN)]"":"+",1:""),?2,$$DATX^FBAAUTL(D),?12,FBAACPTC,FBCP_$S($G(FBMODLE)]"":"-"_$P(FBMODLE,","),1:""),?22,FBAARCE,?31,FBUNITS,?38,FBCSID,?60,$J(FBIN,7),?71,FBBN
 I $P($G(FBMODLE),",",2)]"" D  Q:FBAAOUT
 . N FBI
 . F FBI=2:1 S FBMOD=$P(FBMODLE,",",FBI) Q:FBMOD=""  D  Q:FBAAOUT
 . . I $Y+5>IOSL D WRTCK Q:FBAAOUT  W !,"(continued)"
 . . W !,?17,"-",FBMOD
 W !?5,$J(A1,6),?18,$J(A2,6),FBAPS
 ; write adjustment reasons, if null then write suspend code
 W ?32,$S(FBADJLR]"":FBADJLR,1:T)
 ; write adjustment amounts, if null then write amount suspended
 W ?42,$S(FBADJLA]"":FBADJLA,1:TAMT)
 W ?58,FBRRMKL,?71,D2
 I FBFPPSC]"" W !,?5,"FPPS Claim ID: ",FBFPPSC,?32,"FPPS Line Item: ",FBFPPSL
 D PMNT^FBAACCB2
 Q
WRTCK I ($Y+5)>IOSL,$E(IOST,1,2)["C-" S DIR(0)="E" D ^DIR K DIR  S:'Y FBAAOUT=1 Q:FBAAOUT
 I ($Y+5)>IOSL W @IOF D HED
 Q
HED I $E(IOST,1,2)'="C-" W !?24,"MEDICAL PAYMENT HISTORY",!?23,$E(Q,1,25)
 W !,"Patient: ",FBNAME,?40,"SSN: ",$$SSN^FBAAUTL(DFN),!,?10,"('*' Reimb. to Patient  '+' Cancel. Activity  '#' Voided Payment)"
 W !,?4,"(paid symbol: 'R' RBRVS  'F' 75th percentile  'C' contract  'M' Mill Bill"
 W !,?4,"              'U' U&C)"
 W !,?2,"Svc Date",?12,"CPT-MOD",?22,"Rev.Code",?31,"Units",?38,"Patient Account No.",?60,"Invoice #",?71,"Batch #"
 W !?5,"Amt Claimed",?18,"Amt Paid",?32,"Adj Code",?42,"Adj Amount",?58,"Remit Remark",?71,"VoucherDt"
 W !,Q,!
 Q
Q K D,D2,J,K,L,M,DIC,T,Y,Q,I,A1,A2,A3,C,DAT,DIYS,F,FBAACPTC,FBAANQ,FBAAOUT,FBBN,FBCOUNTY,FBCP,FBOB,FBDOS,FBDX,FBIN,FBTA,FBTYPE,FBVID,FBNAME,PGM,PI,V,VAL,VAR,Z,ZZ,A,A1,A2,BE,CPTDESC,FBVP,PSA,FBPHOUT,FBAUT
 K B1AUT,B2,DFN,FBAADOD,PTYPE,FBI,FBRR,FBPROG,FBXX,FBSSN,X1,FBAACPT,FBAADT,FBAAPD,FBIN,I,K,L,Q,Y,Z,ZS,FB,FBTRX,FBMOD,FBMODLE,FBAPS
 D CLOSE^FBAAUTL Q
SETTR S D=$S($D(^FBAAC(J,1,K,1,L,0)):$P(^(0),"^",1),1:""),A3=""
 I D]"",$D(^FBAAC(J,3,"AB",D)) S (FBTA,FBCTR)=0 F  S FBTA=$O(^FBAAC(J,3,"AB",D,FBTA)) Q:'FBTA  S B3=$G(^FBAAC(J,3,FBTA,0)),A3=$P(B3,"^",3) I A3>0 S FBCTR=FBCTR+1,FB(D,FBCTR)=$J(A3,6,2)_"^"_$P(B3,"^",7)_"^"_$P(B3,"^",6)
 K A3,B3,FBTA,FBCTR Q
