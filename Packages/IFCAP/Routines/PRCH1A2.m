PRCH1A2 ;WISC/PLT-PRCH1A continued ;6/10/97  15:22
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
RECON(PRCA,PRCB,PRCRG) ;PRCA= ri of file 442, PRCB =ri of file 200,PRCRG=reconcile range %
 ;X=return variable =1 if reconciled with final charge, =0 not final charge
 N PRCRI,PRCC,PRCD,PRCDI,PRCPDT,PRCBOC,PRCCNT,PRCAMT,PRCCOA,PRCVAL,PRCCP,PRCR,PRCSTC,PRCPO,PRCAMTL,PRCAMTH,PRCER,PRCCR,PRCCL
 N A,B,C,D
 S PRCRI(442)=PRCA,PRCRI(200)=PRCB,PRCRI(440.5)=$P($G(^PRC(442,PRCRI(442),23)),"^",8)
 D DPO
 I 'PRCRI(440.5) D EN^DDIOL("This is not a purchase card order.") S PRCER=1 G EXIT
 S A="^"_$P(^PRC(440.5,PRCRI(440.5),0),"^",8,10)_"^"
 I A'[("^"_PRCB_"^") D EN^DDIOL("This order can only be reconciled by its card holder or (alt) approving officials.") S PRCER=2 G EXIT
 S PRCB=$G(^PRC(442,PRCRI(442),7))
 I ",1,4,5,6,45,40,41,50,51,"[(","_$P(PRCB,U,2)_",") D EN^DDIOL("The purchase card order has a wrong status to reconcile.") S PRCER=3 G EXIT
 S X="~"
REC D:X'="~" DPO S PRCB=^PRC(442,PRCRI(442),23),PRCC=$P(PRCB,U,8),PRCAMT=$P(^(0),U,16),PRCPO=$P(^(0),U),PRCDUZ=$P(PRCB,"^",22),PRCCR=""
 I 'PRCDUZ D EN^DDIOL("The purchase card holder in the purchase card order file (#442) is missing!") S PRCER=4 G EXIT
 I 'PRCC D EN^DDIOL("The purchase card # in the purchase card order file (#442) is missing!") S PRCER=4.1 G EXIT
 S PRCRG=+PRCRG,PRCAMTL=PRCAMT-(PRCAMT*PRCRG/100),PRCAMTH=PRCAMT*PRCRG/100+PRCAMT
 S PRCC=$P($G(^PRC(440.5,PRCC,0)),U),PRCCL=PRCC
Q11 ;lookup
 D EN^DDIOL("The system is attempting to locate credit card charge...")
Q12 S PRCRI(440.6)="" G:PRCPO="" MCA
 W !,"Matching Card XXXX"_$E(PRCCL,13,16)_", Vendor's Purchase Order #:",!
 S X="N"_PRCDUZ_"~",X("S")="I $P(^(0),U,21)]"""",PRCPO-$P(^(0),U,8)=0,$P(^(0),U,4)="_PRCCL_",PRCPO[$P(^(0),U,21) S:PRCCNT="""" PRCCNT=+Y S:PRCCNT-Y PRCCNT=0"
 ;
 ; Change below for NOIS CLA-0199-22457
 S X("W")="N PRCBK S $P(PRCBK,$C(8),$L(X)+4)="""" W PRCBK,""   "",$E($P(^(0),U,9),4,5)_""-""_$E($P(^(0),U,9),6,7)_""-""_$E($P(^(0),U,9),2,3),""  $"",$J($P(^(0),U,14),0,2),""   "",$P(^(0),U,21) W:$D(^(6)) ""   "",$P(^(6),U,1)"
 S PRCCNT="" D LOOKUP^PRC0B(.X,.Y,"440.6;^PRCH(440.6,;","EMS~~ST","Selec Credit Card Charge: ")
 I Y>0 S PRCRI(440.6)=+Y D:PRCCNT  G START:Y>0,EXIT:X["^"
 . D YN^PRC0A(.X,.Y,"      ...Ok for "_$P(^PRCH(440.6,PRCRI(440.6),0),U,21)_"  "_$P($G(^(6)),U),"O","YES") S:X["^"!(X="") Y=-1
 . QUIT
 W "     Not Found"
MCA W !,"Matching Card XXXX"_$E(PRCCL,13,16)_", $Amount within Range "_PRCRG_"%:",!
 S X="N"_PRCDUZ_"~",X("S")="I PRCPO-$P(^(0),U,8)=0,$P(^(0),U,4)="_PRCCL_",$P(^(0),U,14)'<PRCAMTL&($P(^(0),U,14)'>PRCAMTH) S:PRCCNT="""" PRCCNT=+Y S:PRCCNT-Y PRCCNT=0"
 S X("W")="N PRCBK S $P(PRCBK,$C(8),$L(X)+4)="""" W PRCBK,""   "",$E($P(^(0),U,9),4,5)_""-""_$E($P(^(0),U,9),6,7)_""-""_$E($P(^(0),U,9),2,3),""  $"",$J($P(^(0),U,14),0,2),""   "",$P(^(0),U,21) W:$D(^(6)) ""   "",$P(^(6),U,1)"
 S PRCCNT="" D LOOKUP^PRC0B(.X,.Y,"440.6;^PRCH(440.6,;","EMS~~ST","Select Purchase Card Charge: ")
 I Y>0 S PRCRI(440.6)=+Y D:PRCCNT  G START:Y>0,EXIT:X["^"
 . D YN^PRC0A(.X,.Y,"      ...Ok for "_$P(^PRCH(440.6,PRCRI(440.6),0),U,21)_"  "_$P($G(^(6)),U),"O","YES") S:X["^"!(X="") Y=-1
 . QUIT
 W "     Not Found"
W W !,"Listing All Credit Card Charges with Matched Card XXXX"_$E(PRCCL,13,16)_":",!
 S X="N"_PRCDUZ_"~",X("S")="I PRCPO-$P(^(0),U,8)=0,$P(^(0),U,4)="_PRCCL_" S:PRCCNT="""" PRCCNT=+Y S:PRCCNT-Y PRCCNT=0"
 S X("W")="N PRCBK S $P(PRCBK,$C(8),$L(X)+4)="""" W PRCBK,""   "",$E($P(^(0),U,9),4,5)_""-""_$E($P(^(0),U,9),6,7)_""-""_$E($P(^(0),U,9),2,3),""  $"",$J($P(^(0),U,14),0,2),""   "",$P(^(0),U,21) W:$D(^(6)) ""   "",$P(^(6),U,1)"
 S PRCCNT="" D LOOKUP^PRC0B(.X,.Y,"440.6;^PRCH(440.6,;","EMS~~ST","Select Purchase Card Charge: ")
 I Y>0 S PRCRI(440.6)=+Y D:PRCCNT  G START:Y>0,EXIT:X["^"
 . D YN^PRC0A(.X,.Y,"      ...Ok for "_$P(^PRCH(440.6,PRCRI(440.6),0),U,21)_"  "_$P($G(^(6)),U),"O","YES") S:X["^"!(X="") Y=-1
 . QUIT
 W "     Not Found"
 I PRCCR="" S PRCCR=1,PRCCL=PRCC
 I PRCCR=1 S PRCRI(440.599)=$O(^PRC(440.5,"B",PRCCL,0)) I PRCRI(440.599)>0 S PRCCL=$TR($P($G(^PRC(440.5,PRCRI(440.599),50)),U),"*#") G:PRCCL]"" Q12
 I PRCCR=1 S PRCCR=2,PRCCL=PRCC
 I PRCCR=2 S PRCRI(440.599)=$O(^PRC(440.5,"ARPC",PRCCL,0)) I PRCRI(440.599) S PRCCL=$P($G(^PRC(440.5,PRCRI(440.599),0)),U) G:PRCCL]"" Q12
 D EN^DDIOL("No Credit Card Charges Selected!")
ACT0 S X(1)=$TR($J("",79)," ","_")
 S X(2)="   Action Code: RS: Reselect Charges          RD: Redisplay Data",X(3)="                NP: Next Purchase Order       DC: Display Charges"
 S Y(1)="Enter an action code"
 D FT^PRC0A(.X,.Y,"Action","","") G:X["^"!(X="") EXIT
 S Y=$$LU
 I Y="NP" G EXIT
 I Y="RS" G REC
 I Y="RD" D DPO G ACT0
 I Y="DC" D DC^PRCH1A(PRCRI(442)),DPO G ACT0
 D EN^DDIOL("Invalid Action code, try again") G ACT0
 ;
START D DD S PRCE=^PRCH(440.6,PRCRI(440.6),0),PRCCP=$P(PRCE,"^",4),PRCR=$P($G(^(23)),"^",15) S:PRCR="" PRCR="N"
 D DD S PRCE=^PRCH(440.6,PRCRI(440.6),0),PRCCP=$P(PRCE,U,4)
 I PRCCP]"",PRCCP'=PRCC D EN^DDIOL("The CC-credit card # and purchase card order card # are different.")
 I +$P(PRCE,U,14)'=+PRCAMT D EN^DDIOL("WARNING: The CC-charge amount and purchase card order amount are different.")
 S PRCE=^PRC(442,PRCRI(442),0),PRCCP=$P($G(^(23)),"^",16),PRCR=$P($G(^(23)),"^",15) S:PRCR="" PRCR="N"
ACT1 S X(1)=$TR($J("",79)," ","_")
 S X(2)="   Action Code: RC: Reconcile   DO: Display Order    RS: Reselect Charges",X(3)="                RD: Redisplay Data   DC: Display Charges"
 S Y(1)="Enter an action code"
 D FT^PRC0A(.X,.Y,"Action","","")
 G:X["^"!(X="") EXIT
 S Y=$$LU
 I Y="RS" G REC
 I Y="DO" D  G ACT1
 . N D0 S D0=PRCRI(442) D SS(1,24),CS,^PRCHDP1,DD
 . QUIT
 I Y="RD" D DD G ACT1
 I Y="DC" D DC^PRCH1A(PRCRI(442)),DD G ACT1
 I Y'="RC" D EN^DDIOL("Invalid Action code, try again") G ACT1
RC ;call reconcile routine PRCH1A1
 D RC^PRCH1A1
 I $P($G(^PRCH(440.6,PRCRI(440.6),1)),"^",4)="Y" S PRCER=-1 G EXIT
 D DPO
 D YN^PRC0A(.X,.Y,"Reconcile More Credit Card Charges to This Purchase Order","O","NO")
 I Y G REC
EXIT I $G(PRCER)>0 D FT^PRC0A(.X,.Y,"Enter 'RETURN' to Continue","O")
 D:$D(IOSTBM) SS(1,24),CS
 S X=$S($G(PRCER)=-1:1,1:0)
 QUIT
 ;
SS(IOTM,IOBM) ;screen size a-top, b=bottom margin
 W @IOSTBM QUIT
 ;
MC(DX,DY) ;move cursor dx=column #, dy=row number
 S DX=DX-1,DY=DY-1 X IOXY QUIT
 ;
CS W @IOF QUIT
DISP ;
 QUIT
 W PRCBK S D=$P(B,U,15) W "     ",$P(A,U),"   ",$E(D,4,5),"-",$E(D,6,7),"-",$E(D,2,3),"   " W:$P(A,U,2) $P(^PRCD(442.5,$P(A,U,2),0),U,2),"   "
 W:$P(C,U) $E($P(^PRCD(442.3,$P(C,U),0),U),1,34) W !,?13,"FCP: ",$P($P(A,U,3)," "),"    ",$J($P(A,U,16),0,2) W:$P(B,U) ?35,$P($G(^PRC(440,$P(B,U),0)),U)
 QUIT
 ;
DPO ;display purchase order
 N A
 D CS W ?18,"You are reconciling this PURCHASE CARD ORDER:"
 D PIECE^PRC0B("442;^PRC(442,;"_PRCRI(442),".01;.1;.5;1;5;92","E","A")
 W !,"IFCAP Order FCP: ",$G(A(442,PRCRI(442),1,"E")),?50,"Purchase Date: ",$G(A(442,PRCRI(442),.1,"E"))
 W !,"Vendor Name: ",$G(A(442,PRCRI(442),5,"E")),?50,"P.O.#: ",$G(A(442,PRCRI(442),.01,"E"))
 W !,"STATUS: ",$G(A(442,PRCRI(442),.5,"E")),?60,"$Amount: ",$J($G(A(442,PRCRI(442),92,"E")),0,2)
 W !,"Total Reconciled Charges: ",$J($P($$FP^PRCH0A(PRCRI(442)),U,2),0,2)
 W !,$TR($J("",78)," ","-")
 D SS(7,24),MC(1,6) QUIT
 ;
DD N A D DPO,SS(12,24),MC(1,6)
 W !,?20,"to this credit card CHARGE:"
 D PIECE^PRC0B("440.6;^PRCH(440.6,;"_PRCRI(440.6),".01;8;9;13;20;31","E","A")
 W !,"Reconcile Doc: ",$G(A(440.6,PRCRI(440.6),.01,"E")),?50,"Purchase Date: ",$G(A(440.6,PRCRI(440.6),8,"E"))
 W !,"Vendor Name: ",$G(A(440.6,PRCRI(440.6),31,"E")),?50,"P.O.#: ",$G(A(440.6,PRCRI(440.6),20,"E"))
 W !,"TXN REF: ",$G(A(440.6,PRCRI(440.6),9,"E")),?60,"$Amount: ",$J($G(A(440.6,PRCRI(440.6),13,"E")),0,2)
 W !,$TR($J("",78)," ","-")
 D MC(1,11) QUIT
 ;
LU() ;low to upper
 QUIT $TR(Y,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
