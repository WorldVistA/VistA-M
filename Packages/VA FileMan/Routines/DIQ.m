DIQ ;SFISC/GFT-CAPTIONED TEMPLATE ;6DEC2009
 ;;22.0;VA FileMan;**19,64,74,81,99,133,163**;Mar 30, 1999;Build 1
 ;Per VHA Directive 2004-038, this routine should not be modified.
 G INQ^DII
 ;
GET1(DIQGR,DA,DR,DIQGPARM,DIQGETA,DIQGERRA,DIQGIPAR) ;Extrinsic Function
 ; file,record,field,parm,targetarray,errortargetarray,internal
 I '$D(DIQUIET) N DIQUIET S DIQUIET=1
 I '$D(DIFM) N DIFM S DIFM=1 D INIZE^DIEFU
 G DDENTRY^DIQG
 ;
GETS(DIQGR,DA,DR,DIQGPARM,DIQGTA,DIQGERRA,DIQGIPAR) ;Procedure Call
 ; file,record,field,parm,targetarray,errortargetarray,internal
 I '$D(DIQUIET) N DIQUIET S DIQUIET=1
 I '$D(DIFM) N DIFM S DIFM=1 D INIZE^DIEFU
 N DIQGQERR
 D DDENTRY^DIQGQ
 I $G(DIQGQERR)]"" S DIERR=DIQGQERR
 D:$G(DIQGERRA)]"" CALLOUT^DIEFU(DIQGERRA)
 Q
 ;
 ;
CAPTION(DD,DA,A,N,E) ;
 ; Newing of Line Counter 'S' needs to be before call
 N D0,DIQ,DIC,DIQS
 S DIQ(0)=$G(A),DIC=^DIC(DD,0,"GL") I $G(DIA),DD=.6!(DD=1.1) S DIC=DIC_DIA_"," ;In DIQ(0), 'A' means AUDIT, 'R' means SHOW RECORD NUMBER
 S E=$S($G(E)="":"N<0",1:"N]]"""_E_"""")
 S N=$S($G(N)="":-1,1:$O(@(DIC_"DA,N)"),-1))
 D R
 S X=""
 Q
 ;
GUY ;from DII
 N N S N=-1
R S:'$G(IOM) IOM=80 S:'$G(IOSL) IOSL=24,IOST="C-OTHER"
 S:'$D(DTIME) DTIME=300 K DTOUT,DUOUT,DIRUT,DIR
 N DIQDD,DIQAUDE,DIQAUDD,DIQZ,D,DL,D1,D2,D3,D4,D5,D6,D7,D8,D9,DIQE
 S D0=DA,D=DIC_DA_",",DL=1,DIQDD=DD S:'$G(S) S=3
 I '$D(DIQS) W !
 E  D
 .S DIQZ=0,A=0 F  S @("DIQZ=$O("_DIQS_"DIQZ))") Q:DIQZ=""  S @(DIQS_"DIQZ)=""""")
 D 1(DA)
 G Q
 ;
1(DA) ;recursive, for 1 entry or subentry
 N DIQAUD
 I $D(DIQS) D  ;old parameter -- undocumented
 .S DIQZ=0,A=0 F  S @("DIQZ=$O("_DIQS_"DIQZ))") Q:DIQZ=""  D
 ..S A=$O(^DD(DD,"B",DIQZ,0)) Q:'A
 ..I $D(^DD(DD,A,0)) S C=$P(^(0),U,2) I C["C" D COM S @(DIQS_"DIQZ)=X")
 I N<0,$D(^DD(DD,.001,0)) S W=.001,A=-1,Y=@("D"_(DL\2)) D W Q:'S  G A
 I $G(DIQ(0))["R",DL=1 S W=.001,A=-1,O="NUMBER",Y=D0 D W2 Q:'S
A I DIQ(0)["A" D  ;Get AUDIT TRAIL data
 .N Z,D,SUB
 .I DL=1 S DIQAUDD="",(DIQAUDE(0),DIQAUDE)=D0 F Z=2:2 Q:'$D(^DD(DIQDD,0,"UP"))  D
 ..S A=DIQDD,DIQDD=^("UP"),(DIQAUDE,DIQAUDE(0))=$P(DIC,",",$L(DIC,",")-Z)_","_DIQAUDE,(DIQAUDD(0),DIQAUDD)=$O(^DD(DIQDD,"SB",A,0))_","_DIQAUDD
 .E  S DIQAUDD=$G(DIQAUDD(0)),DIQAUDE=DIQAUDE(0) F A=3:2:DL S DIQAUDE=DIQAUDE_","_(@("D"_(A\2))),DIQAUDD=DIQAUDD_DIQAUDD(A-1)_","
 .F Z=0:0 S Z=$O(^DIA(DIQDD,"B",DIQAUDE,Z)) Q:'Z  D
 ..S D=$P($G(^DIA(DIQDD,Z,0)),U,3) Q:'D  ;get field number
 ..I DIQAUDD]"" S D=$P(D,DIQAUDD,2,9)
 ..E  I E["]]"!(N]]0) S SUB=$P($P($G(^DD(DIQDD,+D,0)),U,4),";") D
 ...I N]]SUB S D=0 Q
 ...N N S N=SUB I @E S D=0 Q
 ..I D,D'["," S DIQAUD(D,Z)="" Q
N S @("N=$O("_D_"N))") I N="" S N=-1 G END:DL#2,MISSAUD
 I DL=1,@E G END
 S DIQZ=$G(^(N)) I DIQZ]"" S A="" F  S A=$O(^DD(DD,"GL",N,A)) G N:A="" D  G Q:'S ;write out what's on one data node
 .S W=$O(^(A,0)) Q:'W  I A S Y=$P(DIQZ,U,A) Q:Y=""
 .E  S Y=$E(DIQZ,+$E(A,2,9),$P(A,",",2)) Q:Y?." "
 .D W
 I DL#2 S DIQZ=$O(^DD(DD,"GL",N,0,0)) G N:DIQZ="" S O=0,X=+$P(^DD(DD,DIQZ,0),U,2) X:$D(DICS) DICS E  G N
 E  G MISSAUD:N'>0 S X=DD,O=-1,@("D"_(DL\2)_"=N") Q:$$STOP  I $D(DSC(X)) X DSC(X) E  G N ;we've found a new sub-entry
 S DD(DL)=DD,D(DL)=D,N(DL)=N,DL=DL+1,DIQAUDD(DL)=DIQZ S:+N'=N N=""""_N_"""" S D=D_N_",",N=O,DD=X ;down a level
FIND1 I DL#2=0 S N=0 N DIQAUDR K:$G(DIQAUDE) @("DIQE("_DIQAUDE_")") G N ;let's look for the 1st multiple
WP I '$D(DIQS),$P(^DD(DD,.01,0),U,2)["W" S O=$P(^(0),U),C=$P(^(0),U,2) D  S DL=DL-1 G UP:S Q
 .N DIWF,DIWL,DIWR,DN,N,DD ;Word-processing field
 .D DIQ^DIWW I $D(DN),'DN S S=0
 S N=-1 D 1(DA) Q:'S
UP S DL=DL-1,D=D(DL),DD=DD(DL),N=N(DL) Q:$$STOP  G N ;go back UP a level
 ;
MISSAUD I $G(DIQAUDE) S DIQE=DIQAUDE(0)_"," F  S DIQE=$O(^DIA(DIQDD,"B",DIQE)) Q:'DIQE  Q:DIQE-DIQAUDE  Q:$$STOP  I '$D(@("DIQE("_DIQE_")")) D  ;SHOW MISSING ENTRIES THAT WERE CAPTURED BY AUDIT TRAIL
 .N E,DIQEMISS
 .S E="" F  S E=$O(^DIA(DIQDD,"B",DIQE,E),-1) Q:'E  Q:$$STOP  I $P($G(^DIA(DIQDD,E,0)),U,3)=(DIQAUDD(DL)_",.01") D:'$G(DIQEMISS)  D WRITEAUD
 ..D WRITE($P(^DD(DD,.01,0),U)_":") W ! S DIQEMISS=1 ;Write the label of the missing multiple
 G UP
 ;
 ;
END Q:$$STOP
 F DIQZ=0:0 S DIQZ=$O(DIQAUD(DIQZ)) Q:'DIQZ  I $D(^DD(DD,DIQZ,0)) D  ;write out audited DELETED fields
 .N D W ?2,$P(^(0),U),":" I $P(^(0),U,2) Q
 .D PRINTAUD(DIQZ) Q:$$STOP
 I S,$G(DIQ(0))["C",$D(@(D_"0)")) D ^DIQ1 ;Computed fields at this level -- ONLY IF ENTRY EXISTS
 Q
 ;
W S O=$P(^DD(DD,W,0),U),C=$P(^(0),U,2) I $D(DICS) X DICS E  Q
 D Y
 I $D(DIQS) S:$D(@(DIQS_"O)")) @(DIQS_"O)=Y") S:$D(^(W)) @(DIQS_"W)=Y") Q
W2 ;from DIQ1
 N DIQX
 S O=$E(O,1,253-$L(Y))_": "_Y
 D  I $L(O)+DIQX>IOM!$D(DIQAUD(W)) Q:$$STOP  D
 .S DIQX=$S($X:$X+1\40+1*40,W=.01!(W=.001):0,1:2)
 W ?DIQX
 D WRITE(O) D:$D(DIQAUD(W)) PRINTAUD(W) Q
 ;
PRINTAUD(FLD) N E
 S E="" F  S E=$O(DIQAUD(FLD,E),-1) Q:'E  Q:$$STOP  D WRITEAUD
 K DIQAUD(FLD) S @("DIQE("_DIQAUDE_")")=""
 D LF Q
 ;
WRITEAUD N O,Z,W,N ;WRITE AN ENTRY FROM THE AUDIT TRAIL
 S O=$G(^DIA(DIQDD,E,2)),N=$G(^(3))
 I N="" S W="Deleted """_O_""""
 E  S W=$S(O]"":"Changed from """_O_"""",1:"Created")
 I $D(^DIA(DIQDD,E,0)) S:$P(^(0),U,6)="i" W="Accessed" S Z=$P(^(0),U,4),W=W_" on "_$$FMTE^DILIBF($P(^(0),U,2),"IL") I Z]"" S W=W_" by User #"_Z
 W ?4 D WRITE(W)
 K W S Z=$G(^DIA(DIQDD,E,4.1)),O=$P(Z,U),Z=$P(Z,U,2) I O,$D(^DIC(19,O,0)) S W="  ("_$P(^(0),U)_" Option)"
 I Z S O=+Z,Z=$P(Z,";",2) I Z]"",$D(@(U_Z_O_",0)")) S W="  ("_$P(^(0),U)_" Protocol)"
 I $D(W) D:$X+$L(W)>79 LF Q:'S  W ?(79-$L(W)),W
 Q
 ;
WRITE(DIQW) N DIQWL
 F  S DIQWL=IOM-$X W $E(DIQW,1,DIQWL) S DIQW=$E(DIQW,DIQWL+1,999) Q:DIQW=""  Q:$$STOP
 Q
 ;
Y ;PRINT TEMPLATES CALL HERE    NAKED REFERENCE IS TO ^DD(FILE#,FIELD#,0)
 I $G(Y)="" S Y="" Q
 I C["O",$D(^(2)) X ^(2) Q
S I C["S" S C=";"_$P(^(0),U,3),%=$F(C,";"_Y_":") S:% Y=$P($E(C,%,999),";",1) Q
 I C["P",$D(@("^"_$P(^(0),U,3)_"0)")) S C=$P(^(0),U,2) Q:'$D(^(+Y,0))  S Y=$P(^(0),U) I $D(^DD(+C,.01,0)) S C=$P(^(0),U,2) G S
 I C["V",+Y,Y["(",$D(@("^"_$P(Y,";",2)_"0)")) S C=$P(^(0),U,2) Q:'$D(^(+Y,0))  S Y=$P(^(0),U) I $D(^DD(+C,.01,0)) S C=$P(^(0),U,2) G S
 Q:C'["D"  Q:'Y
D S Y=$$FMTE^DILIBF(Y,"1U") Q
 ;
DT D D:Y W Y Q
H G H^DIO2
 ;
STOP() D LF Q 'S
LF I '$D(DIQS),$X W ! S S=S+1
 I '$D(DIOT(2)),$G(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL D
 .I '$D(DX(0)),$G(IOST)?1"C".E D:S>(IOSL-3)  Q
 ..N X,Y,DIR S DIR(0)="E" D ^DIR W ! S S='$D(DIRUT)
 .I $G(^UTILITY($J,1))?1U1P1E.E D  S:Y=U!($D(DTOUT))!($D(DUOUT)) S=0
 ..N S X ^(1)
 .S $Y=0
 Q
 ;
EN1 S DRX=DR
EN2 S DR=$P(DRX,";",1),DRX=$P(DRX,";",2,999) D EN W ! G EN2:DRX]""&S
 K DRX Q
EN ;
 N C,O,W,N,E,Z,D,DD S S=0 S:$D(DICSS) DICS=DICSS
 I '$D(IOST)!'$D(IOSL)!'$D(IOM) S IOP="HOME" D ^%ZIS Q:POP  S:'$G(IOM) IOM=80
 G Q:'$D(@(DIC_"0)")) S U="^",DD=+$P(^(0),U,2),DK=DD
 I '$D(DR) S N=-1,O=""
 E  S N=$P(DR,":"),N=$S(0[N:-1,+N=N:N-.000001,1:$E(N,1,$L(N)-1)_$C($A(N,$L(N))-1)),O=$P(DR,":",DR[":"+1) G EN1:DR[";"
 S E="N<0" I O]"" S E=E_"!(N]"""_$S(+O=O:"?"")!(N>"_O_")",1:O_""")")
 I '$D(DIQ(0)) N DIQ S DIQ(0)=""
 D R S DA=D0
Q K C,O,W,N,E,Z,D,DD,IOP Q
 ;
COM X $P(^(0),U,5,99) S C=$P($P(C,"J",2),",",2) I C?1N.E,X S X=$J(X,0,C)
