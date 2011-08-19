DIP ;SFISC/XAK,TKW-GET SORT SPECS ;11:10 AM  17 May 2002
 ;;22.0;VA FileMan;**2,64,97**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 K %ZIS,BY,FLDS,DX,DIS,DISV,DHIT,DTOUT,DIFF D ^DICRW G Q:$D(DTOUT),EN:$D(DIC)
Q K DIJ,DIOEND,DIOBEG,DISTOP,DISTXT,DI,DICS,DJ,BY,A,DICSS,ZTSK,FR,TO,FLDS,DHD,DHIT,DIS,PG,DCOPIES,L,DISUPNO,DIPCRIT,DCC,DNP
 K %,%H,%I,%X,%Y,%DT,B,D0,DD,DIAC,DIFILE,DM,DP,DQ S I=$G(X) K X S:I]"" X=I
 D CLEAN^DIEFU
QQ K DIPR,DIBT,DIBT1,DIBT2,DIBTOLD,DIEDT,DIQ,DIWF,DIPZ,DIL,DXS,DALL,DSC,DCL,DPP,DPQ,DIC,DU,DQI,DY,DITYP,DINS,DIPT,DISX
 K S,DC,DL,DV,DE,DA,DK,DIFF,Y,R,C,D,I,J,Q,M,P,N,Q S:$D(DID) M=U Q
 ;
INIT S DIQUIET=1 Q:$D(ZTQUEUED)  I L!('$D(FLDS)#2)!($D(DIASKHD))!($G(IOP)="") K DIQUIET Q
 I $G(BY)="" K:$G(BY(0))="" DIQUIET Q
 N I,X F I=1:1 Q:'$G(DIQUIET)  S X=$P(BY,",",I) Q:X=""  K:X="@" DIQUIET D:$G(DIQUIET)
 . I $D(FR)#2 K:$P(FR,",",I)="?" DIQUIET I '$D(TO)#2 K DIQUIET Q
 . I $D(TO)#2 K:$P(TO,",",I)="?"!('$D(FR)#2) DIQUIET Q
 . I '$D(FR(I))#2!($G(FR(I))="?") K DIQUIET Q
 . I '$D(TO(I))#2!($G(TO(I))="?") K DIQUIET
 . Q
 Q
 ;
EN S L=1 N DIERR
EN1 ;
 S:DIC DIC=$G(^DIC(DIC,0,"GL")) G Q:DIC=""
 I "^DIA(^DDA("[$E(DIC,1,5),'$G(DIA) S DIA=+$P(DIC,"(",2) G Q:'DIA
 S:$D(L)[0 L=0 N DIFM S DIFM=+L N DIFMSTOP D CLEAN^DIEFU I '$D(DIQUIET) N DIQUIET D INIT
 S DJ=1,U="^",(DCC,DI)=DIC,DNP="" D QQ I '$D(DISYS) N DISYS D OS^DII
 I $G(BY)="@" S %=$G(BY(0)),DNP=BY K BY S:%]"" BY(0)=% K %
 S:'$D(DTIME) DTIME=300
I ;
 G Q:'$D(@(DI_"0)")) S S=+$P(^(0),U,2)
 S Q="""",C=",",DC=0,DIJ=0,DE=$S(L=0!L!(L="]"):"SORT",1:L),DIL(S)=U
 I $D(BY(0)) D EN^DIP10 G Q:'$D(BY(0)) I $G(BY)="" S DPP=DPP(0) G N^DIP1
LEVELS F DJ=DJ:1 D DJ Q:$G(X)=""!($D(DTOUT))!($D(DUOUT))!'$D(DJ)  G FTEM^DIP1:X?1"[".E
 I $D(DUOUT)!($D(DTOUT))!('$D(DJ)) G Q
 G DUP^DIP1
DJ K DPP(DJ),DL,DV,I,J S I(0)=DI,(DL,J(0))=S,(N,DU)=0,Y=.01
 ;I DJ>1 S DIPR=$S($D(DIPR):DIPR,$G(DPP(0))]"":"BY(0)",1:$P(DPP(DJ-1),U,3)),DV=$J("",DJ*2-2)_"WITHIN "_DIPR_", "_DE_" BY" D L^DIP0 K DIPR G Q:$D(DTOUT)!($D(DUOUT)) Q:X="@"
 I DJ>1!($G(DPP(0))=0) D  G Q:$D(DTOUT)!($D(DUOUT)) Q:X="@"  G:$D(DIPP) ADD:X?1"^"1.E G D:X]"" Q
 . S DIPR=$S($D(DIPR):DIPR,$G(DPP(0))]"":"BY(0)",1:$P(DPP(DJ-1),U,3))
 . S DV=$J("",DJ*2-2)_"WITHIN "_DIPR_", "_DE_" BY"
 . D L^DIP0 K DIPR Q
 ;I DJ>1 G:$D(DIPP) ADD:X?1"^"1.E G D:X]"" Q
 S P=$P(^DD(DL,.01,0),U,1,2)  D:'$D(DIPP) XR:$P(P,U,2)'["P"&($P(P,U,2)'["V") I 'DU S Y=S,DV(1)=$S($D(^DD(DL,.001,0)):$P(^(0),U),1:"NUMBER")
D1 S DPP(DJ)=$S($D(DIPP(DIJ)):DIPP(DIJ),1:Y_U_DU_U_DV(1)_U)
 S DV=DE_" BY" D L^DIP0 G Q:$D(DTOUT)!($D(DUOUT)) I X="" D DJ^DIP1 Q
 G:$D(DIPP) ADD:X?1"^"1.E Q:X="@"
D K DPP(DJ,"IX"),DPP(DJ,"PTRIX") S R=U,P=DNP I X="]" S DXS=1,DJ=DJ-1 Q
Y I X'="NUMBER" D ^DIC K DUOUT G Q:$D(DTOUT)!(X=U) G G:Y>0,TEM^DIP11:X?1"[".E&'$D(DIPP)&($G(DIEDT)'=1),B:X=""
 I $G(DUZ(0))="@",X="BY(0)",DJ=1,'$D(DIPP),DL=S D  G:$G(DTOUT)!($G(DIROUT)) Q  G:Y=1 DJ S X="",DPP=DPP(0) Q
 . N X D ENBY0^DIP100 I $G(BY(0))="" S Y=1 Q
 . S DIR(0)="Y",DIR("A")="Enter additional sort fields",DIR("B")="NO",DIR("?")="Enter YES if you wish to sort by fields in addition to BY(0)." D ^DIR K DIR
 . W ! Q
STRIP D  G:'$D(D) Y S X=$RE(X) D  S X=$RE(X) G:'$D(D) Y ;from beginning, then end
 .F D="]","-","#","+","!","@","'" I $E(X)=D S P=P_D,X=$E(X,2,999) S:D="]" DXS=1 K D Q
 I X[";" S R=X,X=$P(X,";"),R=U_$P(R,X,2,9) G Y
 S D="NUMBER",Y=0_U_D I $P(D,X)="" W $P(D,X,2) G S
 G ^DIP0
 ;
BB S DPP(DJ,"F")=0,DPP(DJ,"T")=1,P=P_$S(P["@":"B",1:"@B"),R=R_$S(R'[";L1":";L1",1:"") K DATE Q
G S X=$P(Y(0),U,2),D=$P($P(Y(0),U,4),";") G NM:'X
 S N=N+1,DPP(DJ,DL)=D,DIL(+X)=DL,I(N)=$S(+D=D:D,1:Q_D_Q),(DL,J(N))=+X,Y=.01_U_$P(^DD(DL,.01,0),U) I $D(DIPP(DIJ))#2 S %=$P(DIPP(DIJ),U,3),$P(DIPP(DIJ),U,3)=$S($D(DIPP(DIJ,DL)):DIPP(DIJ,DL),1:%)
 I $O(^DD(DL,0))>0!$S($D(BY):BY?1U.E1" ".E,1:0) S DV=$J("",DJ*2-2)_$P(^(0),U) D L^DIP0 G Q:$D(DTOUT)!($D(DUOUT)) Q:X="@"  G Y
NM D BB:X["B" I X["P"!(X["V") S P=P_Q_+Y,I=$P(Y,U,2),DPP(DJ)=DL_U_Y_U_P D DPQ^DIP1 S X="#"_$P(P,Q,$L(P,Q)),DPP=I G C^DIP0
 I +Y=.001 S Y=0_U_$P(Y,U,2),R=R_U_U_X
S ;
 S X=DL_U_+Y,DPP(DJ)=DL_U_Y_U_P_R I P'["-",R'[";TXT",$P(Y,U,3)="" D XR
 D DJ^DIP1 S:X'=U X=1 Q
B W $C(7),"??" Q:$D(DIJS)  G DJ
 ;
XR I $P($G(DPP(DJ)),U,3)="NUMBER",+DPP(DJ)=S,$P(DPP(DJ),U,2)=0 S DPP(DJ,"IX")=DI_DI_U_1 Q
 I 'Y S Y=+$P($P(DPP(DJ),U,4),"""",2) Q:'Y  D
 . N P,X,Z S Z=+$P($P(^DD(+DPP(DJ),Y,0),U,2),"P",2) G:'Z XER
 . D DTYP^DIOU(Z,.01,.P) G:P>4 XER S P=$P($G(^DD(Z,.01,0)),U,2) I P["O",P'[D G XER
 . F P=0:0 S P=$O(^DD(Z,.01,1,P)) Q:'P  I +^(P,0)=Z,$P(^(0),U,2,9)="B" Q
 . I 'P S P=$O(^DD("IX","BB",Z,"B",0)) I P S P=$$IDXOK(P,Z,Z,.01)
 . G:'P XER S P=$G(^DIC(Z,0,"GL")) G:P="" XER
 . S DPP(DJ,"PTRIX")=P_Q_"B"_Q_C Q
XER . S Y="" Q
 S P=$P($G(^DD(DL,+Y,0)),U,2) D
 . I P["O",P'["D" Q
 . I P?.E1"NJ"1.N1",2".E,$P($G(^DD(DL,+Y,0)),U,5,99)["""$""" Q
 . F P=0:0 S P=$O(^DD(DL,+Y,1,P)) Q:P'>0  I +^(P,0)=S S X=$P(^(0),U,2,9) I X?1A.AN S DPP(DJ,"IX")=DI_Q_X_Q_C_DI_U_2,Y=+$O(^DD(S,0,"IX",X,-1)),DU=+$O(^(Y,-1)),DV(1)=$P(^DD(Y,DU,0),U) Q
 . Q:P
 . N DIOUT S DIOUT=0
 . F  S P=$O(^DD("IX","F",DL,+Y,P)) Q:'P  S X=$P($G(^DD("IX",P,0)),U,2) I X]"" D  Q:DIOUT
 . . Q:'$$IDXOK(P,S,DL,+Y)
 . . S DPP(DJ,"IX")=DI_Q_X_Q_C_DI_U_2
 . . S DU=+Y,Y=DL,DV(1)=$P(^DD(DL,DU,0),U),DIOUT=1 Q
 . Q
 I $D(DPP(DJ,"PTRIX")),'$D(DPP(DJ,"IX")) K DPP(DJ,"PTRIX")
 Q
 ;
IDXOK(DIEN,DIFILE,DISUB,DIFIELD) ;
 N X S X=$G(^DD("IX",DIEN,0))
 Q:$P(X,U,14)'["S" 0
 Q:+X'=DIFILE 0
 N J S J=$O(^DD("IX",DIEN,11.1,0)) Q:'J 0
 I $O(^DD("IX",DIEN,11.1,J)) Q 0
 S X=$G(^DD("IX",DIEN,11.1,J,0))
 I ('$P(X,U,6))!($P(X,U,3)'=DISUB)!($P(X,U,4)'=DIFIELD) Q 0
 I $D(^DD("IX",DIEN,11.1,J,1.5))!($D(^(2))) Q 0
 Q 1
 ;
ADD S X=$E(X,2,99),DIJS=DIJ,DIJ=0 D D I $G(X)=U!($D(DTOUT)) K DIJS Q
 S:$D(X) DJ=DJ+1 S DIJ=DIJS K DIJS G DJ
