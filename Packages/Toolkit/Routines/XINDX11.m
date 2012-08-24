XINDX11 ;ISC/GRK - Create phantom routines for functions, options, etc. ;07/08/98  15:06
 ;;7.3;TOOLKIT;**20,27,121,132**;Apr 25, 1995;Build 13
 ; Per VHA Directive 2004-038, this routine should not be modified.
 G:INP(10)=9.7 RTN
 W !,"The option and function files are being processed.",!
 G:INP(10)=9.4 PKG
 N KRN,TYPE ;Build file
 S INDFN="^DD(""FUNC"",",INDRN="|func",INDD="Function",INDSB="FUNC",INDXN="Build file" D HDR
 F KRN=0:0 S KRN=$O(^XPD(9.6,INDDA,"KRN",.5,"NM",KRN)) Q:KRN'>0  S INDXN=$P(^(KRN,0),U) D ENTRY
 I INDLC=2 K ^UTILITY($J,INDRN),^UTILITY($J,1,INDRN) ;patch 121
 S INDFN="^DIC(19,",INDRN="|opt",INDD="Option",INDSB="OPT",INDXN="Build file" D HDR
 F KRN=0:0 S KRN=$O(^XPD(9.6,INDDA,"KRN",19,"NM",KRN)) Q:KRN'>0  S INDXN=$P(^(KRN,0),U) D ENTRY
 I INDLC=2 K ^UTILITY($J,INDRN),^UTILITY($J,1,INDRN)
RTN ;Routines
 ;F KRN=0:0 S KRN=$O(^XPD(9.6,INDDA,"KRN",9.8,"NM",KRN)) Q:KRN'>0  S X=^(KRN,0) I '$P(X,U,3) S ^UTILITY($J,$P(X,U))=""
 I $T(RTN^XTRUTL1)]"" D RTN^XTRUTL1(INDDA,INP(10))
 Q
PKG D NAMSP ;Package file
 S INDFN="^DD(""FUNC"",",INDRN="|func",INDD="Function",INDSB="FUNC" D NAME
 S INDFN="^DIC(19,",INDRN="|opt",INDD="Option",INDSB="OPT" D NAME
 Q
NAME Q:'$D(@(INDFN_"""B"")"))
 D HDR
 S INDL=$E(INDXN,1,$L(INDXN)-1)_$C($A(INDXN,$L(INDXN))-1)_"z"
 F A=0:0 S INDL=$O(@(INDFN_"""B"",INDL)")) Q:$P(INDL,INDXN,1)]""!(INDL="")  F B=0:0 S B=$O(@(INDFN_"""B"",INDL,B)")) Q:B=""  X INDF D:C8 @INDSB
 I INDLC=2 K ^UTILITY($J,INDRN),^UTILITY($J,1,INDRN) Q
 S ^UTILITY($J,1,INDRN,0,0)=INDLC
 Q
NAMSP S INDXN=$P(^DIC(9.4,DA,0),"^",2),C9=0,INDXN(C9)="," F A=0:0 S A=$O(^DIC(9.4,DA,"EX",A)) Q:A'>0  I $D(^(A,0))#2 S C9=C9+1,INDXN(C9)=$P(^(0),"^")
 S INDF="S C8=1 F H=1:1:C9 I $P(INDL,INDXN(H))="""" S C8=0 Q" ; Checks excluded namespaces
 Q
HDR S INDLC=0,INDC=INDRN_" ; '"_INDXN_"' "_INDD_"s.",INDX=";" D ADD S ^UTILITY($J,INDRN)="",^UTILITY($J,1,INDRN,0,0)=0
 Q
ENTRY F B=0:0 S B=$O(@(INDFN_"""B"",INDXN,B)")) Q:B=""  D @INDSB
 ;I INDLC=2 K ^UTILITY($J,INDRN),^UTILITY($J,1,INDRN) Q ;patch 121 moved to top of routine
 S ^UTILITY($J,1,INDRN,0,0)=INDLC
 Q
FUNC ;Process Function file entry
 Q:'($D(^DD("FUNC",B,0))#2)  S INDC=B_" ; "_$P(^(0),"^",1)_" - "_$S($D(^(9))#2:$E(^(9),1,190),1:""),INDX=$S($D(^(1))#2:^(1),1:";") D ADD
 Q
OPT ;Process option file entry for MUMPS code
 Q:'$D(^DIC(19,B,0))  S T=$P(^(0),"^",4),INDC=B_" ; "_$P(^(0),"^",1)_" - "_$P(^(0),"^",2)_" ("_$P($P($P(^DD(19,4,0),"^",3),T_":",2),";",1)_")"_$S($P(^DIC(19,B,0),"^",6)]"":" - Locked by "_$P(^(0),"^",6),1:""),INDX="" D ADD
 S INDN="15,20,26,"_$S(T="E":"34,35,54",T="I":"34,35",T="P":"69,69.1,69.2,69.3,71,72,73",T="R":25,1:"") D OPTC:INDN
 Q
OPTC F J=1:1 S H=$P(INDN,",",J) Q:H=""  I $D(^DIC(19,B,H))#2 D
 . S %=^(H),INDX=$S(H'=25:%,1:"D "_$E("^",%'["^")_$P(%,"[")),INDC=" ; "_$P(^DD(19,H,0),"^",1) D ADD
 Q
ADD ;Put code in UTILITY for processing
 S INDLC=INDLC+1,^UTILITY($J,1,INDRN,0,INDLC,0)=INDC I INDX]"" S INDLC=INDLC+1,^UTILITY($J,1,INDRN,0,INDLC,0)=" "_INDX
 Q
