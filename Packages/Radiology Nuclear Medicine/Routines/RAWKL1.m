RAWKL1 ;HISC/FPT-Workload Reports (cont.) ;12/27/00  11:28
 ;;5.0;Radiology/Nuclear Medicine;**26,31**;Mar 16, 1998
RADFN ; count & store in tmp global
 S RADFN=0 F  K RAOR,RAPORT S RADFN=$O(^RADPT("AR",RADTE,RADFN)) Q:RADFN'>0!($D(RAEOS))  I $D(^RADPT(RADFN,"DT",RADTI,0)) S RAD0=^(0) D RACNI
 Q
RACNI ;
 S RADIV=$P($G(^RA(79,+$P(RAD0,U,3),0)),U),RADIV=$S($D(^DIC(4,+RADIV,0)):+RADIV,1:99)
 Q:'$D(^TMP($J,"RA",RADIV))  S RACNI=0
 ;RAPRIM=0 means want both primary and secondary staff/resid
 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:RACNI'>0!($D(RAEOS))  I $D(^(RACNI,0)) S RAP0=^(0),RAPIFN=+$P(RAP0,"^",2) I $D(RACRT(+$P(RAP0,U,3))) D ITNAME I RAITYPE?3AP1"-".N D
 . D CHK:RAPCE,TC:'RAPCE
 . D:RAPCE=12&($G(RAPRIM)=0) SECRES
 . D:RAPCE=15&($G(RAPRIM)=0) SECSTF
 . Q
 Q
CHK ;
 Q:'$D(^TMP($J,"RA",RADIV,RAITYPE))
 K RAFLD("DESC")
 S:RAPCE RAFLD=$S($D(@("^"_RAFILE_"+$P(RAP0,""^"",RAPCE),0)")):$P(^(0),"^"),1:"UNKNOWN") I RAPCE=18,$D(^(0)) S RAFLD("DESC")=" - "_$P(^(0),"^",2)
 I RAINPUT=0,'$D(^TMP($J,"RAFLD",RAFLD)) Q
 I $D(RAFLD("DESC")) S RAFLD=RAFLD_RAFLD("DESC") K RAFLD("DESC")
 S RAFLD=$E(RAFLD,1,30)
 S C=$S($D(^DIC(42,+$P(RAP0,"^",6),0)):"IN",1:"OUT")
 ; for each proc mod, check for Amis Credit Indicator, file 71.2:
 ; where "b"=bilateral, "o"=operating room, "p"=portable
 S I=0 F  S I=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"M",I)) Q:I'>0  I $D(^(I,0)) S RAQI=+^(0) D EXTRA^RAUTL12(RAQI)
 Q:'$D(^RAMIS(71,RAPIFN,0))  S RAPRI=^(0)
 ;raz=^ramis(71,rapifn,2,i,0)
 ;ramj=^ramis(71.1,+raz,0)
 S RAPRC=$$LJ^XLFSTR($E($P(RAPRI,"^"),1,27),29," ") D CPT^RAFLM D CMLIST(.RAPRC) Q:'$D(^RAMIS(71,RAPIFN,2))  S I=0 F  S I=$O(^RAMIS(71,RAPIFN,2,I)) Q:I'>0  I $D(^(I,0)) S RAZ=^(0),RAMJ=$S($D(^RAMIS(71.1,+RAZ,0)):^(0),1:"") D PRC
 Q:'$D(RAMIS(1))
 I J=1 S RAMIS=RAMIS(1),RAWT=RAWT(1),RAMUL=RAMUL(1),RAWT=RAWT*RAMUL,RANUM=RAMUL
 I J>1 S RANUM=1,RAWT=0,RAMIS=RAMIS(1) F J=1:1 Q:'$D(RAMIS(J))  S I=RAWT(J),RAMUL=RAMUL(J),RAWT=RAWT+(RAMUL*I)
 D STORE K RAMIS,RAWT,RAMUL,RAZ,RAMJ,RAMULP,RAMULPFL,RAOR,RAPORT
 Q
 ;
STORE ; Store off into ^TMP($J,"RA"
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAEOS="" Q:$D(RAEOS)
 ; presence of:
 ; RAOR = operating room, set from extra^rautl12(-) and/or PRC
 ; RAPORT = portable, set from extra^rautl12(-) and/or PRC
 ; RAMULP = proc has >1 Amis Codes
 I $D(RAOR) S A=25 D AUX
 I $D(RAPORT) S A=26 D AUX
 I $D(RAMULP) S A="MULP" D AUX
 S X=^TMP($J,"RA",RADIV),^(RADIV)=($S(C="IN":$P(X,"^")+RANUM,1:$P(X,"^")))_"^"_($S(C="OUT":$P(X,"^",2)+RANUM,1:$P(X,"^",2)))_"^"_($P(X,"^",3)+RAWT)
 S X=^TMP($J,"RA",RADIV,RAITYPE),^(RAITYPE)=($S(C="IN":$P(X,"^")+RANUM,1:$P(X,"^")))_"^"_($S(C="OUT":$P(X,"^",2)+RANUM,1:$P(X,"^",2)))_"^"_($P(X,"^",3)+RAWT)
 S:'($D(^TMP($J,"RA",RADIV,RAITYPE,RAFLD))#2) ^(RAFLD)="0^0^0" S X=^(RAFLD),^(RAFLD)=($S(C="IN":$P(X,"^")+RANUM,1:$P(X,"^")))_"^"_($S(C="OUT":$P(X,"^",2)+RANUM,1:$P(X,"^",2)))_"^"_($P(X,"^",3)+RAWT)
 S:'$D(^TMP($J,"RA",RADIV,RAITYPE,RAFLD,RAMIS,RAPRC)) ^(RAPRC)="0^0^0" S X=^(RAPRC),^(RAPRC)=($S(C="IN":$P(X,"^")+RANUM,1:$P(X,"^")))_"^"_($S(C="OUT":$P(X,"^",2)+RANUM,1:$P(X,"^",2)))_"^"_($P(X,"^",3)+RAWT)
 Q
 ; this PRC is done for each Proc's Amis Code sub record
 ; 1st sub rec would be RAMIS(1), 2nd would be RAMIS(2), etc.
 ; ramis(j)=ien 71.1
 ; rawt(j)=record 71.1's WEIGHT
 ; ramul(j)=file 71'S Amis code sub rec's Amis Weight Multiplier
 ;
PRC I +RAZ=25 S RAOR="" Q
 I +RAZ=26 S RAPORT="" Q
 S:$P(RAZ,"^",3)="Y" RABILAT="" F J=1:1 I '$D(RAMIS(J)) S RAMIS(J)=$S(RAMJ]"":+RAZ,1:99),RAWT(J)=+$P(RAMJ,"^",2),RAMUL(J)=$S(+$P(RAZ,"^",2)>0:+$P(RAZ,U,2),1:1) S:$D(RABILAT)&(RAMUL(J)<2) RAMUL(J)=RAMUL(J)*2 S:J>1 RAMULP="" Q
 K RABILAT
 Q
 ;
AUX S:'$D(^TMP($J,"RA",RADIV,RAITYPE,RAFLD,A,RAPRC)) ^(RAPRC)="0^0^0" S X=^(RAPRC),^(RAPRC)=($S(C="IN":$P(X,"^")+RANUM,1:$P(X,"^")))_"^"_($S(C="OUT":$P(X,"^",2)+RANUM,1:$P(X,"^",2)))_"^"_($P(X,"^",3)+RAWT)
 Q
 ;
TC S RATCI=0 F  S RATCI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"TC",RATCI)) Q:RATCI'>0  S RAFLD=$S($D(^VA(200,+^(RATCI,0),0)):$P(^(0),"^"),1:"") D:RAFLD]"" CHK
 Q
SECRES ; count secondary residents
 Q:'$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SRR",0))
 S RASRR=0,RAPCE(1)=RAPCE,RAPCE="SRR"
 F  S RASRR=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SRR",RASRR)) Q:RASRR'>0  S RAFLD=$S($D(^VA(200,+^(RASRR,0),0)):$P(^(0),"^",1),1:"") D:RAFLD]"" CHK
 K RASRR S RAPCE=RAPCE(1)
 Q
SECSTF ; count secondary staff
 Q:'$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SSR",0))
 S RASSR=0,RAPCE(1)=RAPCE,RAPCE="SSR"
 F  S RASSR=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"SSR",RASSR)) Q:RASSR'>0  S RAFLD=$S($D(^VA(200,+^(RASSR,0),0)):$P(^(0),"^",1),1:"") D:RAFLD]"" CHK
 K RASSR S RAPCE=RAPCE(1)
 Q
 ;
ITNAME ; get imaging type name from Exam's exam status
 S RAITNUM=$P($G(^RA(72,+$P(RAP0,U,3),0)),U,7)
 S RAITYPE=$E($P($G(^RA(79.2,+RAITNUM,0)),U,1),1,3)_"-"_+RAITNUM
 K RAITNUM
 Q
CMLIST(RASTR) ;append max 3 CPTmods onto string and within any ()
 Q:'$G(RACMLIST)  ;user doesn't want CPT mods as separate line items
 Q:'$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",0))
 N RACMSTR,I,J,X
 S I=0 ;put into array to let M sort external values of CPT Mods
 F  S I=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CMOD",I)) Q:I'>0  S X=$$BASICMOD^RACPTMSC(+$G(^(I,0)),DT),RACMSTR($P(X,U,2))=""
 S I="",J=0
 F  S I=$O(RACMSTR(I)) Q:I=""  S J=J+1 Q:J>3  S RACMSTR=$G(RACMSTR)_$S($G(RACMSTR)="":"",1:",")_I
 S:J>3 RACMSTR=RACMSTR_"*"
 S:RASTR["(" RASTR=$E(RASTR,1,($L(RASTR)-1)) ;remove ")"
 S RASTR=RASTR_"-"_RACMSTR_$S(RASTR["(":")",1:"") ;append CPTmods to str
 Q
