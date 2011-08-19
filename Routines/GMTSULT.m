GMTSULT ; SLC/KER - HS Type Lookup                      ; 01/06/2003
 ;;2.7;Health Summary;**30,35,29,47,58**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA 10060  ^VA(200
 ;   DBIA  2056  $$GET1^DIQ (file 200)
 ;   DBIA  2055  RECALL^DILFD
 ;   DBIA 10103  $$NOW^XLFDT
 ;   DBIA 10011  ^DIWP
 ;   DBIA 10029  ^DIWW
 ;   DBIA 10026  ^DIR
 ;   DBIA 10016  ^DIM
 ;   DBIA 10076  ^XUSEC(
 ;   DBIA  1131  ^XMB("NETNAME")
 ;   DBIA  2198  $$BROKER^XWBLIB
 ;   DBIA 10006  ^DIC (file #142)
 ;   DBIA 10096  ^%ZOSF("TEST")
 ;            
 N DIC,DTOUT,DUOUT,DIRUT D DICHK S DIC(0)="AEMQZ" S Y=$$TYPE^GMTSULT Q
EN ; Lookup (general)
 Q:$G(DIC(0))["I"
 K DTOUT,DUOUT N GMTSDICW,GMTSDICS,GMTSDIC,GMTSLGO,GMTSDIC0,GMTSDICB,GMTSDEF,GMTSWY,GMTSDISV,GMTSDICA,GMTSLERR,GMTSE,GMTSQ,GMTSX,DIR,DIRUT,DIROUT,GMTS
 S GMTSE=$$ECHO D LD S U="^"
 S (GMTSDEF,GMTSQ)=0,GMTSX=$G(X) S:$L(GMTSDIC0)&(GMTSDIC0'["A") GMTSQ=1 K Y
 ;   Get X
 ;     Ask the entry          DIC(0)["A" (INPUT^GMTSULT5)
 S:GMTSDIC0'["A"&($L(GMTSX)) X=GMTSX
 K GMTSLERR S:GMTSDIC0["A"!('$L(GMTSX)) X=$$INPUT^GMTSULT5
 I $D(DTOUT)!($D(DUOUT)) S Y=-1 S:$D(DTOUT) DTOUT=1 S:$D(DUOUT) DUOUT=1 Q
 ;     Is X an IEN            From Spacebar-Return
 I +($$XIEN(X))>0 D  Q
 . K Y S Y=+($$XIEN(X))
 . D Y^GMTSULT6(+Y),RD,CLR
 . I ($G(GMTSDIC0)["Q"!($G(DIC(0))["Q")),+($G(Y))<0 W " ??"
 ;     No Input or Error      X="" or X["^" or '$D(X)
 I $D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT))!($G(X)="")!($G(X)["^") D  Q
 . K Y W !!,?5 W:'$L($G(GMTSLERR)) "No Health Summary Type selected"
 . W:$L($G(GMTSLERR)) GMTSLERR W ! S Y=-1 D RD,CLR
 ;     Exact Match Required   DIC(0)["X"
 I GMTSDIC0["X",$L(X) D  Q
 . K Y S Y=-1,GMTSX=$$EM^GMTSULT2(X) D:+GMTSX>0 Y^GMTSULT6(+GMTSX) D RD,CLR
 ;   Select
 ;     Get Selection List
 D LIST^GMTSULT2(X)
 ;     Select from multiple entries
 D:+($G(^TMP("GMTSULT",$J,0)))>1 MULTI^GMTSULT6
 ;     Select from one entry
 D:+($G(^TMP("GMTSULT",$J,0)))=1 ONE^GMTSULT6
 S:'$D(Y)!(+($G(Y))'>0) Y=-1
 ;          
 ; DLAYGO allowed
 ;   Add entry
 I $L(X),Y=-1,$G(GMTSDIC0)["L",+($G(GMTSLGO))=142 D
 . Q:$L(X)<3!($L(X)>30)  K Y(0) N DLAYGO,GMTSOD0,GMTSOX S GMTSOD0=DIC(0),GMTSOX=X
 . N X,DA,DIC,DIK S DIC(0)="LM",(DIK,DIC)="^GMT(142,",DLAYGO=142,X=GMTSOX
 . L +^GMT(142):2 W:'$T !,"  Can not add Health Summary Type, the file is in ",!,"  use by another user.  Please try again later."
 . D:$T ADD L -^GMT(142) S (GMTSDIC0,DIC(0))=GMTSOD0
 D RD,CLR
 Q
ADD ;   Add Health Summary Type
 N GMTSOK,GMTSU,GMTSD,GMTSM S GMTSM=$$MSG
 S GMTSU=$$GET1^DIQ(200,+($G(DUZ)),.01) I '$L(GMTSU) D  S Y=-1 Q
 . W !!,"  Undefined/Invalid User",!
 S GMTSU=+($$GET1^DIQ(200,+($G(DUZ)),9.2,"I")),GMTSD=$$NOW^XLFDT
 I GMTSU>0&(GMTSU<GMTSD) D  S Y=-1 Q
 . W !!,"  Terminated Users may not add a Health Summary",!
 S GMTSOK=+($$ASKA(X)) Q:'GMTSOK
 S DA=$$DA I DA'>0!($D(^GMT(142,DA))) S Y=-1 Q
 S $P(^GMT(142,DA,0),"^",1)=X,$P(^GMT(142,DA,0),"^",3)=+($G(DUZ))
 D SI I '$D(^GMT(142,"B",$E(X,1,30),DA)) D KI K ^GMT(142,DA) S Y=-1 Q
 S Y=DA_"^"_X_"^1"
 Q
 ;          
DA(X) ; Get IEN
 S X=$O(^GMT(142,"4999999"),-1) F  Q:'$D(^GMT(142,X))  S X=X+1
 Q:X<5000000 X  Q:X>5000999 X
 S X=$O(^GMT(142,"!"),-1) F  Q:'$D(^GMT(142,X))  S X=X+1
 S:X>4999999&(X<6000000) X=6000000 Q X
ET(T) ; Error Text
 I $D(DIEV0) D  Q:+($G(DIQUIET))>0
 . N I,E,A S I=+($G(DIERR)) S:I=0 I=1 S A=$G(GMTSM) S:A="" A="GMTSE" S E=$O(@(A_"(""GMTSERR"","_I_","" "")"),-1)+1,@(A_"(""GMTSERR"","_I_","_+E_")")=$G(T),@(A_"(""GMTSENV"")")=1
 Q:$D(GMTSETQ)  N %,X,Y,Z,I,DIW,DIWF,DIWL,DIWR,DIWT,DN S X=T,DIWL=6,DIWR=78,DIWF="W" D ^DIWP D:$D(^UTILITY($J)) ^DIWW W ?5 Q
BL ; Blank Line
 Q:+($G(DIQUIET))>0  Q:$D(GMTSETQ)  W !,?5 Q
MSG() ; Message
 Q:$L($G(DIMSG)) $G(DIMSG) Q:$L($G(DIMSGA)) $G(DIMSGA) Q:$L($G(DIOUTAR)) $G(DIOUTAR) Q:$L($G(DIEFOUT)) $G(DIEFOUT) Q:$L($G(GMTSMS)) $G(GMTSMS)
 Q "TMP"
ASKA(X) ; Ask if adding
 N GMTSN,GMTSN,GMTSX S GMTSN=$G(X) Q:'$L(X) 0  Q:+($$DUP^GMTSULT7(X))>0 0
 N DIR,DTOUT,DIROUT,DIRUT,DUOUT S GMTSX=+($$N)+1,GMTSX=$S(GMTSX=0:"",GMTSX=1:(GMTSX_"st"),GMTSX=2:(GMTSX_"nd"),GMTSX=3:(GMTSX_"rd"),1:(GMTSX_"th"))
 S DIR(0)="YAO",DIR("A",1)="Are you adding '"_GMTSN_"' as ",DIR("A")="    a new HEALTH SUMMARY TYPE"_$S($L(GMTSX):(" (the "_GMTSX_")"),1:"")_"?   ",DIR("B")="No"
 W ! D ^DIR S:$D(DTOUT)!($D(DUOUT))!($D(DIRUT))!($D(DIROUT)) X="^" S:X["^" X="^" Q:X="^" 0
 S X=+($G(Y)) S:+X'>0 X=0 Q X
N(X) ; Number of Types
 N I S (I,X)=0 F  S I=$O(^GMT(142,I)) Q:+I=0  S X=X+1
 Q X
SI ; Set Indexes
 D MS N GMTS,GMTSX,GMTSO,GMTSC S GMTS=+($G(DA)),GMTSO=$G(X) Q:GMTS'>0  Q:'$D(^GMT(142,GMTS,0))  Q:'$L(X)  N X,DA
 S DA=GMTS,GMTSX=0 F  S GMTSX=$O(^TMP($J,142,.01,1,GMTSX)) Q:+GMTSX=0  D
 . S X=$G(^TMP($J,142,.01,1,GMTSX,1)) D ^DIM Q:'$D(X)  S GMTSC=X,X=GMTSO,DA=GMTS X GMTSC
 D MK Q
KI ; Kill Indexes
 D MS N GMTS,GMTSX,GMTSO,GMTSC S GMTS=+($G(DA)),GMTSO=$G(X) N X,DA
 S DA=GMTS,GMTSX=0 F  S GMTSX=$O(^TMP($J,142,.01,1,GMTSX)) Q:+GMTSX=0  D
 . S X=$G(^TMP($J,142,.01,1,GMTSX,2)) D ^DIM Q:'$D(X)
 . S GMTSC=X,X=GMTSO W !,GMTSC,?60,X,?70,DA
 D MK Q
MS ; Merge Set
 M ^TMP($J,142,.01,1)=@("^DD("_142_",.01,1)") Q
MK ; Merge Kill
 K ^TMP($J,142,.01,1) Q
TYPE(GMTSI) ; Get Health Summary Type
 ;   Needs DIC(0)
 K Y S:$L($G(X)) X=$G(X)
 D EN^GMTSULT S GMTSI=-1 S:+($G(Y))>0&($D(^GMT(142,+($G(Y)),0))) GMTSI=$G(Y) Q GMTSI
XIEN(X) ; Is X in a Y or `IEN format  Quit +IEN
 N GMTSX,GMTSL,GMTSI,GMTSN,GMTSY,GMTSOK
 S GMTSX=$G(X),GMTSL=$E(GMTSX,1),GMTSI=$E(GMTSX,2,$L(GMTSX))
 S GMTSOK=$$DICS^GMTSULT2($G(GMTSDICS),$P($G(^GMT(142,+GMTSI,0)),"^",1),+GMTSI) Q:'GMTSOK -1
 I GMTSL="`",+GMTSI>0,+GMTSI=GMTSI,$D(^GMT(142,+GMTSI,0)),$L($P($G(^GMT(142,+GMTSI,0)),"^",1)) S X=GMTSI Q X
 S GMTSI=$S($D(^GMT(142,+GMTSX,0)):+X,1:-1)
 S GMTSN=$P($G(^GMT(142,+GMTSX,0)),"^",1)
 I GMTSI=+GMTSX&(GMTSN=$P(GMTSX,"^",2)) S X=GMTSI Q X
 Q 0
LD ; Load DIC Variables
 D DICHK S (DIC,GMTSDIC)="^GMT(142,",GMTSDIC0="AEM" S:$L($G(DLAYGO)) GMTSLGO=$G(DLAYGO) S GMTSDICA="Select HEALTH SUMMARY TYPE:  " K Y
 S:$L($G(DIC("W"))) GMTSDICW=DIC("W") S:$L($G(DIC("S"))) GMTSDICS=DIC("S") S:$L($G(DIC("A"))) GMTSDICA=DIC("A") S:$L($G(DIC("B"))) GMTSDICB=DIC("B") S:$L($G(DIC(0))) GMTSDIC0=DIC(0)
 Q
 ;          
 ; Lookup Screens - DIC("S")="I +$$..
EOK(X) ;   Edit OK
 N OK,GMTS S X=+($G(X)),OK=1 S:'$D(^GMT(142,+X,0)) OK=0 S:$P($G(^GMT(142,+X,"VA")),U)=2 OK=0 S X=OK Q X
EST(X) ;   Edit Health Summary Type (other than Adhoc)
 N GMTSI,GMTSO,GMTS S X=+($G(X))
 Q:'$L($P($G(^VA(200,+($G(DUZ)),0)),U)) 0 Q:+($G(DUZ(2)))=0 0
 S GMTSI=$P($G(^GMT(142,+X,0)),U) Q:GMTSI="GMTS HS ADHOC OPTION"!(GMTSI="GMTS HS REMOTE ADHOC OPTION") 0
 S GMTSI=+($P($G(^GMT(142,+X,"VA")),U)),GMTSO=$G(^XMB("NETNAME")) Q:GMTSI=2&'(GMTSO["ISC-SLC"&(+($G(DUZ(2)))=5000)) 0 Q:GMTSI=2&(GMTSO["ISC-SLC"&(+($G(DUZ(2)))=5000)) 1
 S GMTSI=+($P($G(^GMT(142,+X,0)),U,3)) Q:GMTSI>0&(GMTSI=+($G(DUZ))) 1
 S GMTSI=$P($G(^GMT(142,+X,0)),U,2),GMTSO=0 S:$L(GMTSI) GMTSO=$S(((+($G(DUZ))>0)&('$D(^XUSEC(GMTSI,+($G(DUZ)))))):1,1:0) Q:GMTSO=1 0
 S GMTSI=+($P($G(^GMT(142,+X,0)),U,3)),GMTSO=$D(^GMT(142,+X,2,"B",+($G(DUZ)))) Q:GMTSI>0&(+($G(DUZ))>0)&(GMTSI'=+($G(DUZ)))&(+GMTSO>0) 1
 S GMTSI=+($P($G(^GMT(142,+X,0)),U,3)) Q:GMTSI>0&(GMTSI'=+($G(DUZ))) 0
 S GMTSI=$P($G(^GMT(142,+X,0)),U,2),GMTSO=0 S:$L(GMTSI) GMTSO=$S(((+($G(DUZ))>0)&($D(^XUSEC(GMTSI,+($G(DUZ)))))):1,1:0) Q:GMTSO=1 1
 Q 1
HST(X) ;   Health Summary Type
 N GMTS S X=+($G(X)),GMTS=1 S:$P($G(^GMT(142,+X,0)),U)="GMTS HS ADHOC OPTION" GMTS=0 S:$P($G(^GMT(142,+X,0)),U)="GMTS HS REMOTE ADHOC OPTION" GMTS=0 S:+($G(^GMT(142,+X,"VA")))>0 GMTS=0
 S X=GMTS Q X
DHST(X) ;   Delete Health Summary Type
 N GMTS S X=+($G(X)),GMTS=1
 S:$P($G(^GMT(142,+X,0)),U)="GMTS HS ADHOC OPTION" GMTS=0 S:$P($G(^GMT(142,+X,0)),U)="GMTS HS REMOTE ADHOC OPTION" GMTS=0
 S:+($G(^GMT(142,+X,"VA")))>0 GMTS=0 S:$D(^GMT(142.5,"AC",+X)) GMTS=0
 S X=GMTS Q X
AHST(X) ;   Add Health Summary Type
 N GMTS S X=+($G(X)),GMTS=1 S:$P($G(^GMT(142,+X,0)),U)="GMTS HS ADHOC OPTION" GMTS=0 S:$P($G(^GMT(142,+X,0)),U)="GMTS HS REMOTE ADHOC OPTION" GMTS=0
 S:((+X>4999999)&(+X<6000000)) GMTS=0 S:+($G(^GMT(142,+X,"VA")))>0 GMTS=0
 S X=GMTS Q X
ADH(X) ;   Adhoc
 N GMTS S X=+($G(X)),GMTS=1 S:$P($G(^GMT(142,+X,0)),U)'="GMTS HS ADHOC OPTION" GMTS=0 S X=GMTS Q X
REM(X) ;   Remote Adhoc
 N GMTS S X=+($G(X)),GMTS=1 S:$P($G(^GMT(142,+X,0)),U)'="GMTS HS REMOTE ADHOC OPTION" GMTS=0 S X=GMTS Q X
 Q
 ;          
DICHK ; Check DIC variables
 K DIC("DR"),DIC("P"),DIC("V"),DINUM,DTOUT,DUOUT
 S:'$L($G(DIC(0))) DIC(0)="AEMZB" S:'$L($G(DIC)) DIC="^GMT(142,"
 I +($G(GMTSE))=0 F  Q:DIC(0)'["E"  S DIC(0)=$P(DIC(0),"E",1)_$P(DIC(0),"E",2)
 S:'$L($G(DIC("A"))) DIC("A")="Select HEALTH SUMMARY TYPE:  "
 Q
RD ; Restore DIC Variables
 S:$L($G(GMTSDIC)) DIC=GMTSDIC S:$L($G(GMTSDICS)) DIC("S")=GMTSDICS
 S:$L($G(GMTSDICW)) DIC("W")=GMTSDICW S:$L($G(GMTSDICA)) DIC("A")=GMTSDICA
 S:$L($G(GMTSDICB)) DIC("B")=GMTSDICB S:$L($G(GMTSDIC0)) DIC(0)=GMTSDIC0
 I $L($G(X)),X["`" D
 . N GMTSI,GMTSL S GMTSL=$E(X,1),GMTSI=$E(X,2,$L(X))
 . I GMTSL="`",+GMTSI>0,$D(^GMT(142,+GMTSI,0)),$L($P($G(^GMT(142,+GMTSI,0)),"^",1)) S X=$P($G(^GMT(142,+GMTSI,0)),"^",1)
 K GMTSDICS,GMTSDIC,GMTSDIC0,GMTSDICB,GMTS,GMTSDISV,GMTSDICA Q
ECHO(X) ; Echo Results (writes/reads)
 S X=$$ROK("XWBLIB") Q:'X 1 S X=$$BROKER^XWBLIB Q:X 0 Q 1
SDISV(Y) ; Set DISV (IEN)
 Q:+($G(DUZ))=0!(+($G(Y))=0)
 D RECALL^DILFD(142,+($G(Y))_",",+($G(DUZ))) Q
RDISV(X) ; Read DISV
 Q:+($G(DUZ))=0 ""
 N DIC,Y S DIC=142,DIC(0)="Z",X=" " D ^DIC S X=$S(+Y>0:Y,1:"") Q X
ROK(X) ; Routine OK
 S X=$G(X) Q:'$L(X) 0 Q:$L(X)>8 0 X ^%ZOSF("TEST") Q:$T 1 Q 0
CLR ;   Kill ^TMP("GMTS*
 K ^TMP("GMTSULT",$J),^TMP("GMTSULT2",$J) Q
CLEAN ;   Kill ^TMP("GMTSULT2")
 K ^TMP("GMTSULT2",$J) Q
