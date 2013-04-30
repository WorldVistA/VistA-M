XINDX5 ;SF-ISC/RWF - CROSS REFERENCE ALL ROUTINES ;03/26/2002  09:57
 ;;7.3;TOOLKIT;**20,27,61,121,133**;Apr 25, 1995;Build 15
 ; Per VHA Directive 2004-038, this routine should not be modified.
 G END:$D(IND("QUIT")) I INP(8) W !,"Called Routines",! D ^XINDX52 ;Get called routines
 K ARG,CCN,CH,COM,ERR,GK,GRB,I,INDDA,INDDS,L,LAB,LAB0,LC,LIN,LOC,PC,PRV,R,RTN,S,STR,TXT,V,X,Y
 D ^XINDX53:INP(7) ;Load routine file
 ;Check called tags and routines
 S RN="$",TXT="" W !!,"--- CROSS REFERENCING ---",!
A S RN=$O(^UTILITY($J,RN)),L="",LABO=0 I RN="" G B
 F  S L=$O(^UTILITY($J,1,RN,"X",L)) Q:L=""  S XX2=^(L,0),XX1=$P(L," ",2),T=$P(XX1,"+",1),P=$P(L," ",1) D AA
 G A
AA Q:P=""  I '$D(^UTILITY($J,1,P)) D  Q  ;We can now check % routines
 . I (P["&")!(P["@") Q  ;External subroutine
 . S:T["$" T=$E(T,3,99) S:P["(" P=$P(P,"(")
 . I '$$VTAG(P) S ERR=52,ERR(1)=P D AAER(.ERR,RN,"",0) Q
 . S X=$T(^@P) I X="" S ERR=52,ERR(1)=P D AAER(.ERR,RN,$P(XX2,","),0) Q
 . Q:T=""
 . I '$$VTAG(T) D AAER(37,RN,$P(XX2,","),0) Q
 . I $$VTAG(T),$T(@T^@P)="" S E=38,E(1)="MISSING LABEL "_XX1_"^"_P D AAER(.E,RN,"",0)
 . Q
 I T]"",$D(^UTILITY($J,1,P)) D
 . S:T["$$" T=$E(T,3,99) S:T["@" T=""
 . I T]"",'$D(^UTILITY($J,1,P,"T",T)) S E=38,E(1)="MISSING LABEL (see INVOKED BY list)." D AAER(.E,P,XX1,0)
 Q
AAER(ERR,RTN,LAB,LABO) ;Report error. error code, routine, label, label offset
 D ^XINDX1
 Q
VTAG(K) ;Check for a valid tag. works for routine name.
 Q (K?1(1"%",1A).7NA)!(K?1.8N)
 ;
B D ^XINDX51
END W:$D(IND("QUIT")) !!,"--- ",$S($D(ZTSTOP):"TASK ",1:""),"STOPPED ---" W !!,"--- END ---"
 I IO'=IO(0) U IO(0) W !,"--- D O N E ---" U IO
 D ^%ZISC
 S:$D(ZTQUEUED) ZTREQ="@"
CLEAN ;Come here from XINDX6 if queued output.
 K %,%1,%2,%I1,%IN1,%UCN,A,ARG,C,C9,CCN,CH,COM,DA,DIC,DUOUT,ERR,ERTX,F,F1,G,GK,GRB,H,HED,HS
 K ^UTILITY($J),I,IND,INDB,INDC,INDDA,INDDS,INDF,INDFN,INDLC,INDPM,INDX,INDXDT,INDXJ,INP,IP,J,K,K1,K3,L,LAB,LABO,LBL,LC,LIN,LINE,LOC,NRO,OFF,P,PC,PGM,POP,POST,Q,R,RDTIME,RHS,ROU,RTN,S,S1,STR,SYM,TAB,TAG,TXT,TY,V,VZ,X,X1,X2,X3,Y
 Q
CRX S RTN="$" F I=0:0 S RTN=$O(^UTILITY($J,RTN)) Q:RTN=""  F LOC="L","G","O","MK","N","X" D CR0 ;patch 121
 K VZ Q
 ;
CR0 N VZ S S=-1 I LOC="X",'$D(^UTILITY($J,1,"***","X",RTN_" ")) S ^UTILITY($J,1,"***","X",RTN_" ")=""
CR1 S S=$O(^UTILITY($J,1,RTN,LOC,S)) Q:S=""  ;Loop
 S X=$G(^UTILITY($J,1,RTN,LOC,S))
 F J=1:1:$L(X) S:$G(^UTILITY($J,1,"***",LOC,S))'[$E(X,J) ^(S)=$G(^(S))_$E(X,J) ;Pass on flags
 F J=0:1 Q:'$D(^UTILITY($J,1,RTN,LOC,S,J))  D CR2
 G CR1
 ;
CR2 S PC="" I LOC'="X" S:^UTILITY($J,1,RTN,LOC,S,J)["*" PC=PC_"*" S:^(J)["!" PC=PC_"!" S:^(J)["~" PC=PC_"~" D CR3(RTN,S,LOC) Q
 Q:$D(VZ(S))  S S1=$S($P(S," ",2)]"":$P(S," ",2)_"^",1:"")_$P(S," ",1),VZ(S)=""
 ;S X1=LOC,X2=S,X3=RTN,LOC="Z",S=RTN,RTN=S1 D CR3 S LOC=X1,S=X2,RTN=X3 K X1,X2,X3
 D CR3(S1,RTN,"Z"),CR3(RTN,S,LOC)
 Q
CR3(X1,X2,X3) ;(RTN,REF,LOC)
 S K=0
CR4 S ARG="" I $D(^UTILITY($J,1,"***",X3,X2,K)) S ARG=^(K) I $L(ARG)>230 S K=K+1 G CR4
 S ^UTILITY($J,1,"***",X3,X2,K)=ARG_X1_PC_"," Q
