FBAA79 ;AISC/GRR-PRINT FORM 7079 REQUEST FOR OUTPATIENT MEDICAL SERVICES ;7/NOV/2006
 ;;3.5;FEE BASIS;**12,23,101,103**;JAN 30, 1995;Build 19
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 W !,"Print 7079's for: " D DT^DICRW,DATE^FBAAUTL G:FBPOP END D SITEP^FBAAUTL G:FBPOP END
 I '$D(^FBAAA("AF",2)) W !!,*7,"There are no 7079's to be printed!",! G END
 S FBAASCR=""
RDHOW W ! S DIR("A")="Want only those that have not yet been printed",DIR("B")="Yes",DIR(0)="Y" D ^DIR K DIR G END:$D(DIRUT) S:Y FBAASCR="Y"
 D OUTPUT^FBAAS79
 S VAR="BEGDATE^ENDDATE^FBAASCR",VAL=BEGDATE_"^"_ENDDATE_"^"_FBAASCR,PGM="START^FBAA79",IOP="Q" D ZIS^FBAAUTL G:FBPOP END
START D SITEP^FBAAUTL G END:FBPOP
 S UL="",ULL="----------",FBPG=0 F Z=1:1:12 S UL=UL_ULL
 U IO S FBAASCR=$S(FBAASCR="":"I 1",FBAASCR="Y":"I $S('$D(^FBAAA(DFN,1,FBK,1)):1,$P(^FBAAA(DFN,1,FBK,1),""^"",2)']"""":1,1:0)",1:"I 1")
 S FBJ=BEGDATE-.001,(DFN,FBK)=0 F ZZ=0:0 S FBJ=$O(^FBAAA("AF",2,FBJ)) Q:FBJ'>0!(FBJ>ENDDATE)  F  S DFN=$O(^FBAAA("AF",2,FBJ,DFN)) Q:DFN'>0  F  S FBK=$O(^FBAAA("AF",2,FBJ,DFN,FBK)) Q:FBK'>0  X FBAASCR I  D GOT
END K FBJ,FBK,DFN,Z,FBS,V,FBI,FBPATT,FBPG,FBSITE,UL,ULL,POV,NOV,POS,CC,PSTCD,SSTCD,VSTCD,BEGDATE,ENDDATE,PIDC,REF,VDX,CODE,STATCD,D,FBAASCR,FBDX,FBIDC,FBOUT,FBPDX,FBREM,FBRR,NAME,PGM,POW,VAL,VAR,VFN,VFROM,VTO,YOB,ZZ
 K FB7078,FBAABDT,FBAAEDT,FBASSOC,FBLOC,FBPOV,FBPSA,FBPT,FBTT,FBTYPE,FBVEN,FTP,CNT,FBAAOUT,FBAUT,FBPROG,I,J,M,PI,Q,SEX,SSN,TA,DATE,S,Y,DA,DIC
 D CLOSE^FBAAUTL Q
 Q
 ;
 ; Utilize new API for Name Standardization
 ;
GOT Q:'$D(^DPT(DFN,0))
 S Y(0)=^DPT(DFN,0)
 D
 .N FBNAMES
 .S FBNAMES("FILE")=2,FBNAMES("IENS")=DFN_",",FBNAMES("FIELD")=.01
 .S NAME=$$NAMEFMT^XLFNAME(.FBNAMES)
 S SEX=$P(Y(0),U,2)
 S SSN=$TR($$SSNL4^FBAAUTL($$SSN^FBAAUTL(DFN)),"-",""),YOB=$S($P(Y(0),U,3)]"":$E($P(Y(0),U,3),1,3)+1700,1:""),POS=$S($D(^DPT(DFN,.32)):$P(^(.32),"^",3),1:""),POS=$S(POS]"":$P(^DIC(21,POS,0),"^",3),1:"")
 F I=1:1:7 S FBI(I)=""
 I $D(^DPT(DFN,.11)) F I=1:1:7 S FBI(I)=$P(^(.11),"^",I)
 S POW=$P($G(^DPT(DFN,.52)),"^",5)
 Q:'$D(^FBAAA(DFN,1,FBK))  S Y(0)=^(FBK,0),VFROM=$P(Y(0),"^",1),VTO=$P(Y(0),"^",2),VFN=$P(Y(0),"^",4) I $S($P(Y(0),"^",3)=6:1,$P(Y(0),"^",3)=7:1,1:"") Q
 S VDX=$P(Y(0),"^",8),FBPATT=$P(Y(0),"^",18),POV=$$EXTPV^FBAAUTL5($P(Y(0),"^",7)),CODE=$P(Y(0),"^",13),PIDC=$P(Y(0),"^",12),REF=$P(Y(0),"^",21)
 S NOV=$P($G(^FBAAA(DFN,1,FBK,1)),"^")
 S FBDX=$G(^FBAAA(DFN,1,FBK,3))
 S FBIDC=$P($G(^FBAAA(DFN,4)),"^")
 S STATCD=FBI(5),CC=FBI(7) F V=1:1:14 S V(V)=""
 S CC=$S(CC']"":"",$D(^DIC(5,+STATCD,1,CC,0)):$P(^(0),"^",3),1:"")
 S Y(0)=$S(VFN']"":"",'$D(^FBAAV(VFN,0)):"",$D(^FBAAV(VFN,0)):^(0),1:"") G:$S(VFN']"":1,'$D(^FBAAV(VFN,0)):1,1:0) OVR
 F V=2,1,3,14,4,5,6,10 S V(V)=$P(Y(0),"^",V)
OVR F S=1:1:9 S FBS(S)=$P(FBSITE(0),"^",S)
 S VSTCD=$S(V(5)']"":"  ",$D(^DIC(5,V(5),0)):$P(^(0),"^",2),1:"  "),SSTCD=$S(FBS(5)']"":"  ",$D(^DIC(5,+FBS(5),0)):$P(^(0),"^",2),1:"  "),PSTCD=$S(FBI(5)']"":"  ",$D(^DIC(5,+FBI(5),0)):$P(^(0),"^",2),1:"  ")
 W:FBPG @IOF W UL,!,?46,"Department of Veterans Affairs",?100,"ID Card Number: ",FBIDC,!,?35,"R E Q U E S T   F O R   O U T P A T I E N T   S E R V I C E S",!,UL S FBREM=0,FBOUT=0
 ;
 W !,"(1) Veterans Name",?31,"|(2) ID Number | Period of Validity",!,?31,"|",?46,"|"
 W !,NAME,?31,"|",?32,SSN,?46,"|"," FROM: ",$$FMTE^XLFDT(VFROM),"   TO: ",$$FMTE^XLFDT(VTO),!,UL
 W !,"(3) ADDRESS",?31,"|DATE OF ISSUE",?46,"| CONDITIONS FOR WHICH SERVICES ARE REQUESTED (DESCRIPTION OF DISABILITY)",!,?31,"|",?46,"|"
 W !,FBI(1),?31,"|",?33,$$FMTE^XLFDT(FBJ),?46,"|","  ",VDX S FBPDX=0
 I FBI(2)]"" W !,FBI(2),?31,"|",?46,"|","  " S FBPDX=FBPDX+1 W ?48,$P(FBDX,"^",FBPDX)
 I FBI(3)]"" W !,FBI(3),?31,"|",?46,"|","  " S FBPDX=FBPDX+1 W ?48,$P(FBDX,"^",FBPDX)
 W !,FBI(4)," ",PSTCD," ",FBI(6),?31,"|",?46,"|" S FBPDX=FBPDX+1 W ?48,$P(FBDX,"^",FBPDX),!,$E(UL,1,45),?46,"|" S FBPDX=FBPDX+1 W ?48,$P(FBDX,"^",FBPDX)
 W !,"Name and Address of Fee Participant",?46,"|" S FBPDX=FBPDX+1 W ?48,$P(FBDX,"^",FBPDX)
 W !,?46,"|",!,V(1),?46,"|",!,V(3),?46,"|" W:V(14)]"" !,V(14),?46,"|"
 ; PRXM/KJH - Patch 103. Add Referring Provider and NPI to the display.
 W !,V(4)," ",VSTCD," ",V(6),?46,"|","REFERRING PROVIDER: "
 I REF'="" W $$GET1^DIQ(200,REF,.01)
 W !,V(2),?46,"|","NPI: ",$$REFNPI^FBCH78(REF,"",1)
 W !,?46,"|","AUTHORIZATION #: ",DFN,"-",FBK,!,UL,!
 W ?49,"AUTHORIZATION REMARKS",!,?49,$E(UL,1,21)
 D ^FBAA79A S $P(^FBAAA(DFN,1,FBK,1),"^",2)=DT,FBPG=1 Q
