RASIGU ;HISC/CAH,FPT,GJC,CRT - Check E-sig Code ;1/8/97  14:38
 ;;5.0;Radiology/Nuclear Medicine;**26**;Mar 16, 1998
 ;
ES ; Ask Electronic Signature Code
 ;
 S %=1
 I $G(RASIG("PER"))=""!($G(RASIG("NAME"))="") D DUZ^RAUTL Q:'%
 S X1=RASIG("PER")
ES1 D SIG^XUSESIG
 Q:X1]""
 W "   <Signature Failed> ",*7
ESQ S %=0 ; the sig entry failed
 Q
