DVBHQST ;ISC-ALBANY/PKE/PHH-Process HINQ response ; 3/23/06 7:59am
 ;;4.0;HINQ;**32,57**;03/25/92 
A S DFN=DVBDFN D:'$D(DT) DT^DICRW I $D(X(1)),$E(X(1),1,4)'="HINQ" G NETERR
 ;
 I $D(X)#2,$E(X,1,4)="HINQ" S DVBREQST=$E(X,24,$L(X)-8) K:'$L(DVBREQST) DVBREQST
 ;
 G Q:'$D(X(1)) I "456789ABCDUVWZ"'[$E(X(1),5) G N:$E(X(1),6)=2,N:$E(X(1),5)=2,AB:$E(X(1),5)="N",AB:$E(X(1),5)="M",Q:$E(X(1),1,4)'="HINQ"
 ;
 S $P(DVBSP," ",35)="",DVBNM=$P(^DPT(DFN,0),U)_DVBSP,DVBNB=" "_DFN_DVBSP,Y=$E(X(1),5),DVBECT=DVBECT+1,DVBSTATS="E" D ERR S DVBTXT(DVBPCT,0)="   "_$E(DVBNM,1,20)_$E(DVBNB,1,11)_Y,DVBPCT=DVBPCT+1 D SET^DVBHQUT Q
 ;
ERR I "BC"[Y D RETRY^DVBHIQR Q
 ;I Y="C" S Y="No Record matches data requested, Retry using CN. or SN. via 'Individual HINQ'." Q
 I Y=6 S Y="Invalid Employee number Not AUTHORIZED" Q
 I Y=9 S Y="PASSWORD missing or invalid" Q
 I Y="X" S Y="Station # does not match Station # of password " Q
 I Y="Y" S Y="Employee Number in New Person file doesn't match the # in VBA security record" Q
 ;
 S Y=$S(Y=4:"File in alert, NOT available",Y=5:"NO C&P record found ",Y=7:"SS # missing or invalid.",Y=8:"NAME missing or invalid.",1:Y) Q:Y'?1U
 ;
 S Y=$S(Y="A":"File NOT available",Y="D":"SENSITIVE File no access authorized",Y="U":"Unsuccessful read of password or sensitive file",Y="V":"Invalid CLAIM NUMBER",Y="W":"Invalid SERVICE NUMBER",1:Y)
 Q
Q K DVBOTM,DVBV,DVBOXMZ,DVBIXMZ,XMORIG QUIT
 ;
NETERR ;
 S:'$D(DVBZ) DVBZ=^DVB(395.5,DFN,"HQ") S DVBSTATS="V",XMORIG=DUZ,XMDUZ=.5,XMSUB="IDCU Response for ",DVBREQUE="",DFN=+$E(DVBZ,10,21),DVBNETER=X(1) D SET^DVBHQUT Q
 G Q
AB S DVBACT=DVBACT+1 D EN^DVBHQR3,EN^DVBHIQM Q
N S DVBSTATS="N" D SET^DVBHQUT Q
 ;
SC ;CHECK SUM need to set DVBCS=0,X(n),DVBSZ
 N DA
 I $D(X)#2 S DVBSX=X
 I DVBSZ=1 S X=$E(X(DVBSZ),1,21)_$E(X(DVBSZ),26,999),DVBXLN=$E(X(DVBSZ),22,25) D O D  Q
 .;compare ien of file #395.5 (i.e., dfn) and $e(x(1),8,21)
 .;quit if entering from hinq processor either foreground or background
 .;only want to do this deletion during print/display of hinq response data
 .Q:+$G(DVBTSK)  Q:+$G(DFN)=0
 .Q:'$D(^DVB(395.5,DFN,"RS",1))
 .S DVBQDFN=+$E(X(1),8,21)  I DVBQDFN'=DFN D
 ..;if not a match, then delete entry from file #395.5 and send error message
 ..S JJ=$O(^DVB(395,1,"HQMG",0)),DVBQMG=$P($G(^DVB(395,1,"HQMG",JJ,0)),U,1),DVBQMG=$P($G(^XMB(3.8,DVBQMG,0)),U,1)
 ..S DA=DFN,DIK="^DVB(395.5," D ^DIK
 ..S JJ=1
 ..S ^TMP($J,"DVBQERR",JJ)="Record #"_DFN_" in the HINQ SUSPENSE file (#395.5)" S JJ=JJ+1
 ..S ^TMP($J,"DVBQERR",JJ)="has been deleted." S JJ=JJ+1
 ..S ^TMP($J,"DVBQERR",JJ)="  " S JJ=JJ+1
 ..S ^TMP($J,"DVBQERR",JJ)="This record should have contained HINQ response data on:" S JJ=JJ+1
 ..S ^TMP($J,"DVBQERR",JJ)="  " S JJ=JJ+1
 ..S DVBQIENS=DFN_"," D GETS^DIQ(2,DVBQIENS,".01;.03;.09","E","DVBQA","DVBQE")
 ..S ^TMP($J,"DVBQERR",JJ)="Name: "_$G(DVBQA(2,DVBQIENS,.01,"E")) S JJ=JJ+1
 ..S ^TMP($J,"DVBQERR",JJ)=" DOB: "_$G(DVBQA(2,DVBQIENS,.03,"E")) S JJ=JJ+1
 ..S ^TMP($J,"DVBQERR",JJ)=" SSN: "_$G(DVBQA(2,DVBQIENS,.09,"E")) S JJ=JJ+1
 ..S ^TMP($J,"DVBQERR",JJ)="  " S JJ=JJ+1
 ..K DVBQA,DVBQE
 ..S ^TMP($J,"DVBQERR",JJ)="Instead it held HINQ response data for:" S JJ=JJ+1
 ..S ^TMP($J,"DVBQERR",JJ)="  " S JJ=JJ+1
 ..S DVBQIENS=DVBQDFN_"," D GETS^DIQ(2,DVBQIENS,".01;.03;.09","E","DVBQA","DVBQE")
 ..S ^TMP($J,"DVBQERR",JJ)="Name: "_$G(DVBQA(2,DVBQIENS,.01,"E")) S JJ=JJ+1
 ..S ^TMP($J,"DVBQERR",JJ)=" DOB: "_$G(DVBQA(2,DVBQIENS,.03,"E")) S JJ=JJ+1
 ..S ^TMP($J,"DVBQERR",JJ)=" SSN: "_$G(DVBQA(2,DVBQIENS,.09,"E")) S JJ=JJ+1
 ..S ^TMP($J,"DVBQERR",JJ)="  " S JJ=JJ+1
 ..S ^TMP($J,"DVBQERR",JJ)="Please request new HINQ data on the appropriate veteran" S JJ=JJ+1
 ..S ^TMP($J,"DVBQERR",JJ)="at your earliest convenience." S JJ=JJ+1
 ..S XMDUZ=DUZ,XMSUB="HINQ Suspense File IEN#"_DFN_" Deleted",XMTEXT="^TMP($J,""DVBQERR"","
 ..S XMY(DUZ)="" S:DVBQMG'="" XMY("G."_DVBQMG)=""
 ..D ^XMD K XMZ
 ..S DVBERCS=1 K DVBQDFN,DVBQIENS,DVBQA,DVBQE,DVBQMG,DIK,JJ
 I DVBSZ>1 S X=$E(X(DVBSZ),1,999) D O Q
 I 'DVBSZ S DVBCS="0000"_DVBCS,DVBCS=$E(DVBCS,($L(DVBCS)-3),$L(DVBCS)) I '$D(DVBECS) S ^(0)=$E(^DVB(395.5,DVBDFN,"RS",1,0),1,21)_DVBCS_$E(^(0),26,999)
 I DVBXLN'=DVBCS,$D(DVBECS) S:'$D(DVBON) (DVBON,DVBOFF)="""""" D W1
 I $D(DVBSX) S X=DVBSX
 D EX
 Q
 ;
EX K DVBXLN,DVBSX Q
 ;
O X ^%ZOSF("LPC") S DVBCS=(DVBCS+Y+$L(X))*DVBSZ
 Q
 ;
W1 U IO W !!!!,*7,?15,"HINQ data does NOT seem right",!,?15,"Re-HINQ and/or Notify system manager. ",!,?15,"HINQ check sum failure for ",DVBON,$S($D(^DPT(DFN,0)):$P(^(0),U),1:DFN),DVBOFF,! H 3 S DVBERCS=1
 Q
