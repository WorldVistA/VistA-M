FBAAETA ;AISC/GRR,DMK/CMR - ENTER TRAVEL PAYMENT ONLY ;9/25/2014
 ;;3.5;FEE BASIS;**154**;JAN 30, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
RD ;set site parameters
 S:$G(FBAAPTC)']"" FBAAPTC="R"
 D SITE^FBAACO G END:$G(FBPOP)
 ;get veteran
 D GETVET^FBAAUTL1 I '$G(DFN) D END Q
 ;get authorization
 D GETAUTH^FBAAUTL1 G RD:'$G(FTP)
 ;
 I '$$UOKPAY^FBUTL9(DFN,FTP) D  G RD
 . W !!,"You cannot process a payment associated with authorization ",DFN,"-",FTP
 . W !,"due to separation of duties."
 ;
 ;call to verify veteran address data
 D ^FBAACO0
 ;check for travel multiple dd reference
 S DA(1)=+$G(DFN)
 I '$D(^FBAAC(DA(1),3,0)) S ^(0)="^162.04DA^^"
RD1 W !! S DIC="^FBAAC(DA(1),3,",DIC(0)="AEQLM",DLAYGO=162 D ^DIC K DLAYGO
 G END:X="^"!(X=""),RD1:Y<0 S DA=+Y,FBNEW=$P(Y,"^",3)
 S FBTRVDT=$P(Y,U,2)
 ;check if travel date within selected authorization if 'kill and reask
 I $G(FBAABDT),$G(FBAAEDT),(FBTRVDT<FBAABDT!(FBTRVDT>FBAAEDT)) D  D KILL G RD1
 . W !!,*7,"Date of Travel is ",$S(FBTRVDT<FBAABDT:"prior to",1:"after")," authorization date.",!
 ;set travel payment
 S DIE=DIC,DR=".01;1;2;3.5///^S X=FBAAPTC;15///^S X=FTP" D ^DIE I $G(FBNEW)&($D(Y)'=0) D KILL,END
 G RD
 ;
END K DIC,DIE,DR,X,Y,DA,C,D0,D1,DI,DIYS,Z,FBNEW,DLAYGO,FB1,FB2,FBTRVDT
 D Q^FBAACO
 Q
KILL ;KILLS ENTRY IF USER UP-ARROWED DURING ENTRY
 W !!,*7,"Travel Payment entry not complete.   Deleting entry..."
 S DIK="^FBAAC("_DA(1)_",3," D ^DIK Q
