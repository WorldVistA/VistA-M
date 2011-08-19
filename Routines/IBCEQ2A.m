IBCEQ2A ;ALB/TMK - PROVIDER/BILLING ID WORKSHEET SOLUTIONS ;18-AUG-04
 ;;2.0;INTEGRATED BILLING;**282**;21-MAR-94
 ;
WRTS(IBTYPE,IBOTYPE,IBTEXT,IBSTOP) ; Write the line
 ; IBTYPE = type of current line
 ; IBOTYPE = last type processed
 ; IBTEXT(n) = array containing previously extracted text for output
 ; IBTEXT = current line's text
 ; IBSTOP = returned as 1 if passed by ref and user chooses to abort
 N Q,Q1,Q2,Z,IBHOLD,IBP
 I IBTYPE=IBOTYPE S IBTEXT(+$O(IBTEXT(" "),-1)+1)=IBTEXT,IBTEXT="" Q
 S IBHOLD=IBTEXT
 I IBOTYPE="Q"!(IBOTYPE="A") D  Q
 . S Z="",IBTEXT(0)="",IBP=$S(IBOTYPE="A":">>>>",1:"")
 . F Q=1:1:$O(IBTEXT(" "),-1) D  Q:IBSTOP
 .. I $L(IBTEXT(Q-1)) D  Q:IBSTOP
 ... S Q1=$L(IBTEXT(Q-1))+$L(IBP)
 ... S Z=IBP_IBTEXT(Q-1)_$E(IBTEXT(Q),1,IOM-Q1)
 ... I $E(Z,$L(Z))=" "!($E(Z,$L(Z))?1P) D WRT(Z,.IBSTOP) Q:IBSTOP  S IBP=$J("",4),IBTEXT(Q)=$E(IBTEXT(Q),IOM-Q1+1,$L(IBTEXT(Q))) S:$E(IBTEXT(Q))=" " $E(IBTEXT(Q))="" Q
 ... F Q2=$L(Z):-1:0 I $E(Z,Q2)=" "!($E(Z,Q2)?1P) D WRT($E(Z,1,Q2),.IBSTOP) Q:IBSTOP  S IBTEXT(Q)=$E(Z,Q2+1,$L(Z))_$E(IBTEXT(Q),IOM-Q1+1,$L(IBTEXT(Q))),IBP=$J("",4) S:$E(IBTEXT(Q))=" " $E(IBTEXT(Q))="" Q
 ... I Q2=0 D WRT($E(Z,1,IOM),.IBSTOP) Q:IBSTOP  S IBTEXT(Q)=$E(IBTEXT(Q),IOM+1,$L(IBTEXT(Q)))
 .. Q:'$L(IBTEXT(Q))
 .. F  D  Q:($L(IBTEXT(Q))+$L(IBP))<IOM!(IBSTOP)
 ... I ($L(IBTEXT(Q))+$L(IBP))'<IOM D  Q
 .... S Z=IBP_$E(IBTEXT(Q),1,IOM-$L(IBP))
 .... I $E(Z,$L(Z))=" "!($E(Z,$L(Z))?1P)!($E(IBTEXT(Q),IOM-$L(IBP)+1)=" ") W !,Z S IBTEXT(Q)=$E(IBTEXT(Q),IOM-$L(IBP)+1,$L(IBTEXT(Q))) S IBP=$J("",4) S:$E(IBTEXT(Q))=" " $E(IBTEXT(Q))="" Q
 .... F Q2=$L(Z):-1:0 I $E(Z,Q2)=" "!($E(Z,Q2)?1P) W !,$E(Z,1,Q2) S IBTEXT(Q)=$E(IBTEXT(Q),Q2-$L(IBP),$L(IBTEXT(Q))),IBP=$J("",4) S:$E(IBTEXT(Q))=" " $E(IBTEXT(Q))="" Q
 . Q:IBSTOP
 . I $L(IBTEXT(Q)) D WRT(IBP_IBTEXT(Q),.IBSTOP) Q:IBSTOP
 . K IBTEXT S (IBTEXT,IBTEXT(1))=IBHOLD
 ;
 S IBTEXT(1)=IBHOLD
 Q
 ;
HDR1(IBPG,IBSTOP) ; output solutions header
 N X
 I IBPG D ASK^IBCEQ2(.IBSTOP) Q:IBSTOP  W @IOF
 S IBPG=IBPG+1
 W !,?(IOM-48\2),"INSURANCE COMPANY PROVIDER ID WORKSHEET SOLUTIONS" W ?(70+$S(IOM<132:0,1:52)),"PAGE: ",IBPG
 S X="",$P(X,"-",IOM+1)=""
 W !,X,!
 Q
 ;
WRT(DATA,IBSTOP) ; Write data, new header if needed
 ; DATA = text to print
 ; IBSTOP = returned as 1 if passed by ref for user print abort
 I ($Y+5)>IOSL D HDR1(.IBPG,.IBSTOP)
 I 'IBSTOP W !,DATA
 Q
 ;
