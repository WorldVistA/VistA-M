PRCH1A1 ;WISC/PLT - PRCH1A continued ;6/28/96 09:09
V ;;5.1;IFCAP;**215**;Oct 20, 2000;Build 3
 ;Per VA Directive 6402, this routine should not be modified.
 QUIT  ;invalid entry
 ;
RECON(PRCA,PRCRG) ;PRCA= ri of file 440.6, PRCR = %RANGE for matching amt.
 N PRCRI,PRCB,PRCC,PRCD,PRCDI,PRCPDT,PRCBOC,PRCCNT,PRCAMT,PRCCOA,PRCVAL,PRCCP,PRCR,PRCSTC,PRCPO,PRCAMTL,PRCAMTH,PRCCR,PRCCL,PRCCTMP
 N A,B,C,D
 S PRCRI(440.6)=PRCA,PRCCTMP=""
REC D DD S PRCB=^PRCH(440.6,PRCRI(440.6),0),PRCC=$P(PRCB,U,4),PRCPDT=$P(PRCB,U,9),PRCAMT=$P(PRCB,U,14),PRCPO=$P(PRCB,U,21),PRCCR="",PRCCL=PRCC
 S PRCRG=+PRCRG,PRCAMTL=PRCAMT-(PRCAMT*PRCRG/100),PRCAMTH=PRCAMT*PRCRG/100+PRCAMT
Q11 ;lookup
 D EN^DDIOL("The system is attempting to locate purchase card order...")
Q12 ;PRC*5.1*215 Add DIR to continue in list and compile list of cards
 I PRCCTMP'="" S DIR(0)="E" D ^DIR K DIR
 S PRCCTMP=PRCCTMP_"^"_PRCCL
 S PRCRI(440.5)=$O(^PRC(440.5,"B",PRCCL,0)) S:PRCRI(440.5)<1 PRCRI(440.5)="00" S PRCRI(442)="" G:PRCPO="" MCA
 W !,"Matching Card XXXX"_$E(PRCCL,13,16)_", Vendor's Purchase Order #:",!
 S X=PRCRI(440.5),X("S")="I PRC(""SITE"")-^(0)=0,$P($G(^(23)),U,8)="_PRCRI(440.5)_","",1,4,5,6,45,40,41,50,51,""'[("",""_$P($G(^(7)),U,2)_"",""),$P(^(0),U)[PRCPO S:PRCCNT="""" PRCCNT=+Y S:PRCCNT-Y PRCCNT=0"
 ;
 ; Change below for NOIS CLA-0199-22457.
 S X("W")="N A,B,C,D,PRCBK S $P(PRCBK,$C(8),$L(X)+5)="""",A=$G(^(0)),B=$G(^(1)),C=$G(^(7)) D DISP^PRCH1A1"
 S PRCCNT="" D LOOKUP^PRC0B(.X,.Y,"442;^PRC(442,;","EMXS~~AM","Select Purchase Card Order: ")
 I Y>0 S PRCRI(442)=+Y D:PRCCNT  G START:Y>0,EXIT:X["^"
 . D YN^PRC0A(.X,.Y,"      ...Ok for "_$P(^PRC(442,PRCRI(442),0),"^"),"O","YES") S:X["^"!(X="") Y=-1
 . QUIT
 W "     Not Found"
MCA W !,"Matching Card XXXX"_$E(PRCCL,13,16)_", $Amount within Range "_PRCRG_"%:",!
 S X=PRCRI(440.5),X("S")="I PRC(""SITE"")-^(0)=0,$P($G(^(23)),U,8)="_PRCRI(440.5)_","",1,4,5,6,45,40,41,50,51,""'[("",""_$P($G(^(7)),U,2)_"",""),$P(^(0),U,16)'<PRCAMTL&($P(^(0),U,16)'>PRCAMTH) S:PRCCNT="""" PRCCNT=+Y S:PRCCNT-Y PRCCNT=0"
 S X("W")="N A,B,C,D,PRCBK S $P(PRCBK,$C(8),$L(X)+5)="""",A=$G(^(0)),B=$G(^(1)),C=$G(^(7)) D DISP^PRCH1A1"
 S PRCCNT="" D LOOKUP^PRC0B(.X,.Y,"442;^PRC(442,;","EMXS~~AM","Select Purchase Card Order: ")
 I Y>0 S PRCRI(442)=+Y D:PRCCNT  G START:Y>0,EXIT:X["^"
 . D YN^PRC0A(.X,.Y,"      ...Ok for "_$P(^PRC(442,PRCRI(442),0),"^"),"O","YES") S:X["^"!(X="") Y=-1
 . QUIT
 W "     Not Found"
W W !,"Listing All Purchase Card Orders with Matched Card XXXX"_$E(PRCCL,13,16)_":",!
 S X=PRCDUZ_"~",X("S")="I PRC(""SITE"")-^(0)=0,$P($G(^(23)),U,8)="_PRCRI(440.5)_","",1,4,5,6,45,40,41,50,51,""'[("",""_$P($G(^(7)),U,2)_"","") S:PRCCNT="""" PRCCNT=+Y S:PRCCNT-Y PRCCNT=0"
 S X("W")="N A,B,C,D,PRCBK S $P(PRCBK,$C(8),$L(X)+5)="""",A=$G(^(0)),B=$G(^(1)),C=$G(^(7)) D DISP^PRCH1A1"
 S PRCCNT="" D LOOKUP^PRC0B(.X,.Y,"442;^PRC(442,;","EMXS~~MCH","Select Purchase Card Order: ")
 I Y>0 S PRCRI(442)=+Y D:PRCCNT  G START:Y>0,EXIT:X["^"
 . D YN^PRC0A(.X,.Y,"      ...Ok for "_$P(^PRC(442,PRCRI(442),0),"^"),"O","YES") S:X["^"!(X="") Y=-1
 . QUIT
 W "     Not Found"
 I PRCCR="" S PRCCR=1,PRCCL=PRCC
 ;PRC*5.1*215 Check for duplicate matching cards
 I PRCCR=1 S PRCRI(440.599)=$O(^PRC(440.5,"B",PRCCL,0)) I PRCRI(440.599)>0 S PRCCL=$TR($P($G(^PRC(440.5,PRCRI(440.599),50)),U),"*#") I PRCCTMP'[PRCCL G:PRCCL]"" Q12
 I PRCCR=1 S PRCCR=2,PRCCL=PRCC
 I PRCCR=2 S PRCRI(440.599)=$O(^PRC(440.5,"ARPC",PRCCL,0)) I PRCRI(440.599) S PRCCL=$P($G(^PRC(440.5,PRCRI(440.599),0)),U) I PRCCTMP'[PRCCL G:PRCCL]"" Q12
 D EN^DDIOL("No Purchase Card Order Selected!")
ACT0 S X(1)=$TR($J("",79)," ","_")
 S X(2)="   Action Code: SV: Search P.O. by Vendor   SP: Search P.O. by P.O. #",X(3)="                ND: Next Document   RS: Reselect    RD: Redisplay Data"
 S Y(1)="Enter an action code"
 D FT^PRC0A(.X,.Y,"Action","","") G:X["^"!(X="") EXIT
 S Y=$$LU
 I Y="ND" G EXIT
 I Y="RS" G REC
 I Y="RD" D DD G ACT0
 I Y'="SV",Y'="SP"  D EN^DDIOL("Invalid Action code, try again") G ACT0
 S X("S")="I PRC(""SITE"")-^(0)=0,$P(^(0),U,2)=25,$P($G(^(23)),U,22),"",1,4,5,6,45,40,41,50,51,""'[("",""_$P($G(^(7)),U,2)_"","")"
 S A="AEFIMQ~~"_$S(Y="SV":"D",1:"B^C")
 D LOOKUP^PRC0B(.X,.Y,"442;^PRC(442,;",A,"Select Purchase Card Order by "_$S(Y="SV":"VENDOR",1:"PURCHASE ORDER #")_": ") QUIT:X["^"
 I Y<0 G ACT0
 S PRCE=$G(^PRC(442,+Y,23)) I $P(PRCE,"^",22)'=PRCDUZ D EN^DDIOL("This order can only be reconciled by "_$P($G(^VA(200,$P(PRCE,"^",22),0)),"^")_" or their approving official.") G ACT0
 S PRCRI(442)=+Y
START D DPO S PRCE=^PRC(442,PRCRI(442),0),PRCCP=$P($G(^(23)),"^",16),PRCR=$P($G(^(23)),"^",15) S:PRCR="" PRCR="N"
 I $P($G(^PRC(442,PRCRI(442),23)),U,16)]"",$P($G(^(23)),U,16)'=PRCC D EN^DDIOL("The CC-credit card # and purchase card order card # are different.")
 I +$P(PRCE,U,16)'=+PRCAMT D EN^DDIOL("WARNING: The CC-charge amount and purchase card order amount are different.")
ACT1 S X(1)=$TR($J("",79)," ","_")
 S X(2)="   Action Code: RC: Reconcile   DO: Display Order    ND: Next Document",X(3)="                RS: Reselect    RD: Redisplay Data   DC: Display Charges"
 S Y(1)="Enter an action code"
 D FT^PRC0A(.X,.Y,"Action","","")
 G:X["^"!(X="") EXIT
 S Y=$$LU
 I Y="ND" G EXIT
 I Y="RS" G REC
 I Y="DO" D  G ACT1
 . N D0 S D0=PRCRI(442) D SS(1,24),CS,^PRCHDP1,DPO
 . QUIT
 I Y="RD" D DPO G ACT1
 I Y="DC" D DC^PRCH1A(PRCRI(442)),DPO G ACT1
 I Y'="RC" D EN^DDIOL("Invalid Action code, try again") G ACT1
RC ;entry point from prch1d, prch1a2
 G RC^PRCH1A3
 ;
EXIT D:$D(IOSTBM) SS(1,24),CS QUIT
 ;
SS(IOTM,IOBM) ;screen size a-top, b=bottom margin
 W @IOSTBM QUIT
 ;
MC(DX,DY) ;move cursor dx=column #, dy=row number
 S DX=DX-1,DY=DY-1 X IOXY QUIT
 ;
CS W @IOF QUIT
DISP ;
 W "  "_PRCBK S D=$P(B,U,15) W "      ",$P(A,U),"   ",$E(D,4,5),"-",$E(D,6,7),"-",$E(D,2,3),"   " W:$P(A,U,2) $P(^PRCD(442.5,$P(A,U,2),0),U,2),"   "
 W:$P(C,U) $E($P(^PRCD(442.3,$P(C,U),0),U),1,34) W !,?13,"FCP: ",$P($P(A,U,3)," "),"    ",$J($P(A,U,16),0,2) W:$P(B,U) ?35,$P($G(^PRC(440,$P(B,U),0)),U)
 QUIT
 ;
DD ;display document
 N A
 D CS W ?20,"You are reconciling this credit card CHARGE:"
 D PIECE^PRC0B("440.6;^PRCH(440.6,;"_PRCRI(440.6),".01;8;9;13;20;31","E","A")
 W !,"Reconcile Doc: ",$G(A(440.6,PRCRI(440.6),.01,"E")),?50,"Purchase Date: ",$G(A(440.6,PRCRI(440.6),8,"E"))
 W !,"Vendor Name: ",$G(A(440.6,PRCRI(440.6),31,"E")),?50,"P.O.#: ",$G(A(440.6,PRCRI(440.6),20,"E"))
 W !,"TXN REF: ",$G(A(440.6,PRCRI(440.6),9,"E")),?60,"$Amount: ",$J($G(A(440.6,PRCRI(440.6),13,"E")),0,2)
 W !,$TR($J("",78)," ","-")
 D SS(6,24),MC(1,5) QUIT
 ;
DPO N A D DD,SS(12,24),MC(1,5)
 W !,?20,"to this IFCAP purchase card order:"
 D PIECE^PRC0B("442;^PRC(442,;"_PRCRI(442),".01;.1;.5;1;5;92","E","A")
 W !,"IFCAP Order FCP: ",$G(A(442,PRCRI(442),1,"E")),?50,"Purchase Date: ",$G(A(442,PRCRI(442),.1,"E"))
 W !,"Vendor Name: ",$G(A(442,PRCRI(442),5,"E")),?50,"P.O.#: ",$G(A(442,PRCRI(442),.01,"E"))
 W !,"STATUS: ",$G(A(442,PRCRI(442),.5,"E")),?60,"$Amount: ",$J($G(A(442,PRCRI(442),92,"E")),0,2)
 W !,"Total Reconciled Charges: ",$J($P($$FP^PRCH0A(PRCRI(442)),U,2),0,2)
 W !,$TR($J("",78)," ","-")
 D MC(1,11) QUIT
 ;
LU() ;low to upper
 QUIT $TR(Y,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
