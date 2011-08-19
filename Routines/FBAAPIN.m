FBAAPIN ;AISC/GRR-INVOICE DISPLAY ;7/17/2003
 ;;3.5;FEE BASIS;**4,61**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 D DT^DICRW
RD1 W ! S (FBHDONE,FBAAOUT,FBINTOT)=0,FBSW=0 K FBHED S DIR(0)="NO",DIR("A")="Select Invoice Number",DIR("?")="^D HELP^FBAAPIN1" D ^DIR K DIR G Q:$D(DIRUT)!'Y
 I '$D(^FBAAC("C",X)) W !,*7,"Invalid selection.",! G RD1
 S HX=X,FBAAIN=X D LIST S X=HX G RD1
LIST S Q="",$P(Q,"=",80)="="
 S IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS K IOP
 F J=0:0 S J=$O(^FBAAC("C",FBAAIN,J)) Q:J'>0!(FBAAOUT)  D MMORE
 Q
SET S FBFILE="^FBAAC("_J_",1,"_K_",1,"_L_",1,"_M_",1,",D=$P($G(^FBAAC(J,1,K,1,L,0)),"^",1),FBYY=$G(^FBAAC(J,1,K,1,L,1,M,0)),FBYY("REJ")=$S($D(^FBAAC(J,1,K,1,L,1,M,"FBREJ")):^("FBREJ"),1:""),FBY=$G(^FBAAC(J,1,K,1,L,1,M,2))
 S FBY3=$G(^FBAAC(J,1,K,1,L,1,M,3))
 S FBAARCE=$$GET1^DIQ(162.03,M_","_L_","_K_","_J_",",48)
 D SET2
 Q
SET2 ;
 N FBX
 S N=$S($D(^DPT(J,0)):$P(^(0),"^",1),1:""),S=$S(N]"":$P(^DPT(J,0),"^",9),1:""),V=$S($D(^FBAAV(K,0)):$P(^FBAAV(K,0),"^",1),1:"")
 S T=$P(FBYY,"^",5),D2=$P(FBYY,"^",6),ZS=$P(FBYY,"^",20),VP=$P(FBYY,"^",21)
 S T=$P($G(^FBAA(161.27,+T,0)),U)
 S TAMT=$FN($P(FBYY,U,4),"",2)
 S FBAACPT=$P(FBYY,"^",1) I FBAACPT]"" S FBAACPT=$$CPT^FBAAUTL4(FBAACPT)
 S FBMODLE=$$MODL^FBAAUTL4("^FBAAC("_J_",1,"_K_",1,"_L_",1,"_M_",""M"")","E")
 S FBUNITS=$P(FBY,U,14)
 S FBFPPSL=$P(FBY3,U,2)
 S FBX=$$ADJLRA^FBAAFA(M_","_L_","_K_","_J_",")
 S FBADJLR=$P(FBX,U)
 S FBADJLA=$P(FBX,U,2)
 S FBRRMKL=$$RRL^FBAAFR(M_","_L_","_K_","_J_",")
 S A1=$P(FBYY,"^",2)+.0001,A2=$P(FBYY,"^",3)+.0001,A3=$P(FBYY,"^",12)+.0001,A1=$P(A1,".",1)_"."_$E($P(A1,".",2),1,2),A2=$P(A2,".",1)_"."_$E($P(A2,".",2),1,2),A3=$P(A3,".",1)_"."_$E($P(A3,".",2),1,2),FBINTOT=FBINTOT+A2+.0001
 S FBINTOT=$P(FBINTOT,".")_"."_$E($P(FBINTOT,".",2),1,2)
 S FBBN=$S($P(FBYY,"^",8)]"":$S($D(^FBAA(161.7,$P(FBYY,"^",8),0)):$P(^(0),"^",1),1:""),$P(FBYY("REJ"),"^",3)]"":$S($D(^FBAA(161.7,$P(FBYY("REJ"),"^",3),0)):$P(^(0),"^",1),1:""),1:"")
 D FBCKO^FBAACCB2(J,K,L,M)
 I '$D(FBHED) D HED
 D WRT S FBHED=1
 Q
WRT I ($Y+5)>IOSL S DIR(0)="E" D ^DIR K DIR S:'Y FBAAOUT=1 Q:FBAAOUT  D HED
 W !!,N,?33,$$DATX^FBAAUTL(D),?43,FBAACPT_$S($G(FBMODLE)]"":"-"_$P(FBMODLE,","),1:"")
 I FBAARCE]"" W ?51,"/",FBAARCE
 W ?57,FBBN,?67,$S(FBYY("REJ")]"":"Rejected",1:$$DATX^FBAAUTL(D2))
 I $P($G(FBMODLE),",",2)]"" D  Q:FBAAOUT
 . N FBI
 . F FBI=2:1 S FBMOD=$P(FBMODLE,",",FBI) Q:FBMOD=""  D  Q:FBAAOUT
 . . I $Y+5>IOSL D  Q:FBAAOUT  W !,"(continued)"
 . . . S DIR(0)="E" D ^DIR K DIR S:'Y FBAAOUT=1 Q:FBAAOUT  D HED
 . . W !,?48,"-",FBMOD
 W !,$S(ZS="R":"*",1:""),$S(VP="VP":"#",1:""),$S($G(FBCAN)]"":"+",1:"")
 W ?3,FBFPPSL,?14,"$",$J(A1,8),?26,"$",$J(A2,8),?37,FBUNITS
 ; write adjustment reasons, if null then write suspend code
 W ?43,$S(FBADJLR]"":FBADJLR,1:T)
 ; write adjustment amounts, if null then write amount suspended
 W ?53,"$",$S(FBADJLA]"":FBADJLA,1:TAMT)
 W ?69,FBRRMKL
 ; if adjustment reasons null and suspend code = other then write desc.
 I FBADJLR="",T=4 D ^FBAAPIN1
 D PMNT^FBAACCB2
 Q
HED W @IOF,!,"Invoice Number: ",FBAAIN,?30,"Vendor Name: ",V,!,?2,"Date Received: ",FBINDAT
 I +$G(FBY) W ?33,"Invoice Date: ",$$DATX^FBAAUTL(+FBY)
 W !?2,"FPPS Claim ID: ",$S(FBFPPSC]"":FBFPPSC,1:"N/A")
 W ?33,"Patient Account #: ",FBCSID
 W !?10,"('*' Reimb. to Patient  '+' Cancel. Activity  '#' Voided Payment)"
 ;W !,"SVC DATE"," CPT-MOD ","   AMT CLAIMED",?35,"AMT PAID",?47,"CODE",?57,"BATCH NO.",?67,"VOUCHER DATE",!,?5,"Other Suspension Description",!,$$REPEAT^XLFSTR("=",79),!
 W !,"PATIENT",?33,"SVC DATE",?43,"CPT-MOD",?51,"/REV",?57,"BATCH NO.",?67,"VOUCHER DATE"
 W !,?3,"FPPS LINE",?14,"AMT CLAIMED",?26,"AMT PAID",?36,"UNITS",?43,"ADJ CODE",?53,"ADJ AMT",?69,"REMIT RMK"
 W !,$$REPEAT^XLFSTR("=",79)
 Q
Q K D,N,V,D2,J,K,L,M,DIC,T,FBYY,Q,I,A1,A2,A3,C,DIYS,FBAACPT,FBAAIN,FBAAOUT,FBBN,FBINTOT,FBINDAT,FBSW,FBHDONE,HX,S,VP,Z,ZS,FBHED,FBFILE,DIRUT,FBY,FBMOD
 K FBMODLE
 K FBAARCE,FBADJLA,FBADJLR,FBCSID,FBFPPSC,FBFPPSL,FBRRMKL,FBUNITS,TAMT
 Q
ERR W !,*7,"Please enter a whole number! Alpha characters and puctuation are invalid" G RD1
SETHD S V=$S($D(^FBAAV(K,0)):$P(^(0),"^",1),1:"") D INDAT:FBSW S FBHDONE=1 Q
MMORE S FBSW=1 F K=0:0 S K=$O(^FBAAC("C",FBAAIN,J,K)) Q:K=""!(FBAAOUT)  D SETHD F L=0:0 S L=$O(^FBAAC("C",FBAAIN,J,K,L)) Q:L=""!(FBAAOUT)  F M=0:0 S M=$O(^FBAAC("C",FBAAIN,J,K,L,M)) Q:M'>0  D SET Q:FBAAOUT
 Q
INDAT S L=$O(^FBAAC("C",FBAAIN,J,K,"")),M=$O(^FBAAC("C",FBAAIN,J,K,L,""))
 S FBINDAT=$P($G(^FBAAC(J,1,K,1,L,1,M,0)),"^",15)
 S FBINDAT=$S(FBINDAT="":"Unknown",1:$E(FBINDAT,4,5)_"/"_$E(FBINDAT,6,7)_"/"_$E(FBINDAT,2,3))
 S FBFPPSC=$P($G(^FBAAC(J,1,K,1,L,1,M,3)),U,1)
 S FBCSID=$P($G(^FBAAC(J,1,K,1,L,1,M,2)),U,16)
 S FBSW=0 K L,M Q
 Q
