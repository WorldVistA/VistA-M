PRS8CV ;HISC/MRL-DECOMPOSITION, CLEAN VARIABLES ;2/25/93  11:10
 ;;4.0;PAID;**63**;Sep 21, 1995
 ;
 ;This routine is called for two different purposes.  The tag ALL
 ;is used to clean up all variables once the entire process is
 ;completed.  The tag ONE is called at the point where a single
 ;employee is processed and we're ready to proceed with the next.
 ;
 ;Called by Routines:  PRS8, PRS8CR
 ;
ALL ; --- Entry point for removing all variables used in decomposition
 D ^%ZISC N PRSTLV G KILL^XUSCLEAN
 ;
ONE ; --- Entry point for removing variables after each employee
 K %,%DT,%IS,%ZIS,A,A1,AC,ACC,AV,B
 K C,C0,CBCK,CHK,CNT,CRSMID,CT,CY,CYA,CYA2806
 K D,DAY,DAYNO,DAYZ,DB,DD,DDQ,DH,DH1,DIC,DIF,DIF1,DIK,DN,DWK,DX,DY,E
 K ENT,ER,ES,F,FLX,GO,H,HDR,I,II,J,K,K1,L,LAST,LP,LU,LVGP,M,M1,MDY
 K MEAL,MID,MILV,MIN,MT,MTM,MULT,N,N1,N2,NCODE,ND,NDC,NEW,NH,NODE,NY
 K OC,OFF,OLD,P,P1,P2,PB,PC,PM,PMP,POP,PP,PRS8,PRS8D,PRS8L
 K PRSSD,PTH,PYPL,PYPR,Q,S,SB,SH,SL,SLP,SLT,SO,SSN,SSP,ST,STA,T,TH,TLB
 K TOUR,TR,TT,TYP,USE,USED,V,VALOLD,VAR,VAR1,VT,W,WCL,WCMP,WG,WK,WKL
 K WRITE,X,X1,X2,X3,X4,Y,Y1,Z,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K DAYH,DOUB,FLAG,HI,HD,HT,HTFFOT,HW,ML,NP,NPL,NOOT,PEROT
 K ROSS,TWO,WP,Z0,Z1,ZZ
 ; I $S('($D(KILL)):1,'KILL:0,1:1) K VAL ;decomp no longer saves 8B in
 ; the 5 node, so don't kill it, pass back to Bob
 K ^TMP($J,"PRS8") Q
