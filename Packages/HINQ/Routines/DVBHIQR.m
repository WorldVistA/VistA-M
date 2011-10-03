DVBHIQR ;ISC-ALBANY/PKE/PHH-Process HINQ response ; 3/23/06 7:48am
 ;;4.0;HINQ;**32,49,57**;03/25/92 
TEM ;ENTER FROM PRINT TEMPLATE.
 S DVBCS=0,DVBECS=1 K DVBERCS
 F DVBSZ=0:0 S DVBSZ=$O(^DVB(395.5,DFN,"RS",DVBSZ)) S:DVBSZ X(DVBSZ)=^(DVBSZ,0) D SC^DVBHQST Q:$G(DVBERCS)  Q:'DVBSZ!$D(DVBCSE)
 K M,DVBCS,DVBSZ,DVBECS Q:'$D(X(1))!($D(DVBERCS))
A D:'$D(DT) DT^DICRW I $D(X(1)),$E(X(1),1,4)'="HINQ" G NETERR
 ;
 I $D(X)#2,$E(X,1,4)="HINQ" S DVBREQST=$E(X,24,$L(X)-8) K:'$L(DVBREQST) DVBREQST
 ;
 D CHK ;if 5th char is 2 but no name, claim #, change 5th char to "C"
 ;I $A($E(X(1),26,34))'>$A(" "),($A($E(X(1),44,50))'>$A(" ")) D CHK
 ;
 G Q:'$D(X(1)) I "456789ABCDNUVWZ"'[$E(X(1),5) G ^DVBHQR1:$E(X(1),5)=2,EN^DVBHQR3:$E(X(1),5)="N",EN^DVBHQR3:$E(X(1),5)="M",Q:$E(X(1),1,4)'="HINQ"
 ;
 S Y=$E(X(1),5) D ERR S DVBERR=Y,Y=$F(X(1),"NNNN"),DVBERR1=$S(Y:$E(X(1),1,Y-2),1:X(1))
 ;
HINQ S DFN=+$E(X(1),8,21) I $D(DUZ) S XMDUZ=DUZ
 E  S XMDUZ=0
 G Q
ERR ;
 I Y=" " S Y="No VBA response available - please try again later."
 I "B"[Y S Y="Network/Database Problem" Q
 I "C"[Y D RETRY Q
 I Y=6 S Y="Invalid Employee number Not AUTHORIZED" Q
 I Y=9 S Y="PASSWORD missing or invalid" Q
 I Y="X" S Y="Station # does not match Station # of password " Q
 I Y="Y" S Y="Employee Number in New Person file doesn't match the # in VBA security record" Q
 I Y="Z" S Y="User not assigned to the HINQ application." Q
 ;
 S Y=$S(Y=4:"File in alert, NOT available",Y=5:"NO C&P record found ",Y=7:"SS # missing or invalid.",Y=8:"NAME missing or invalid.",1:Y) Q:Y'?1U
 ;
 S Y=$S(Y="A":"File NOT available",Y="D":"SENSITIVE File no access authorized",Y="U":"Unsuccessful read of password or sensitive file",Y="V":"Invalid CLAIM NUMBER",Y="W":"Invalid SERVICE NUMBER",1:Y)
 Q
Q K DVBOTM,DVBV,DVBOXMZ,DVBIXMZ,XMORIG QUIT
 ;
NETERR ;
 S:'$D(DVBZ) DVBZ=^DVB(395.5,DFN,"HQ") S XMORIG=DUZ,XMDUZ=.5,XMSUB="IDCU Response for ",DVBREQUE="",DFN=+$E(DVBZ,10,21),DVBNETER=X(1) Q
 G Q
RETRY S Y="                                 "
 I $P(X(1),"[TRY]",2) Q
 N DVBZZ
 S DVBZZ=$S($G(DVBZ0)]"":DVBZ0,$G(DVBZ1)]"":DVBZ1,1:"")
 I DVBZZ["SS",(DVBZZ["CN") S Y="No record matches input.  Check data and try again                       via 'Individual HINQ'." Q
 I DVBZZ'["SS" S Y="SSN."
 I DVBZZ'["CN" S Y="CN."
 I DVBZZ["SN" S Y="CN OR SSN."
 S X(1)=$P(X(1),"[TRY]")
 I $E(X(1),5)="C" S Y="No Record matches data requested, Retry using                      "_Y
 E  S Y="Can NOT identify with this data,  Retry using "_Y
 S Y=Y_" via 'Individual HINQ'." Q
 ;
CHK ;if a response has 2 for the 5th char but no name or CN, change
 ;the 5th char to "C"
 I $E(X(1),5)=2,($A($E(X(1),26,34))'>$A(" ")),($A($E(X(1),44,50))'>$A(" ")) S $E(X(1),5)="C"
 Q
