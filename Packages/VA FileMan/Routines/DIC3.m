DIC3 ;SFISC/XAK,TKW,SEA/TOAD-VA FileMan: Lookup, Part 1 (called from DIC) ;28SEP2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1,16,4,17,20,28,40,86,70,159,164,165**
 ;
SEARCH ; Begin search through x-refs.
 I DIC(0)["T",'$G(DICR) N:'$D(DICR(1)) DICR S DICR=0 D:DIC(0)["O"
 . I DIC(0)'["X" S DIC(0)=DIC(0)_"X" Q
 . S DIC(0)=$TR(DIC(0),"X") Q
 I X?1"`".NP D ^DICM Q
 I $L(X)>DINDEX(1,"LENGTH"),'$G(DILONGX) D ^DICM Q
 N DIOK,DIEXACTN K % I $G(DISKIPIX)=D K DISKIPIX G M
EXACT ; Find all exact matches to the lookup values
 S DISAVDS=DS,DIEXACTN=0
 I $G(DILONGX) D  ;G:$L(DICR(DICR,"ORG"))'>DINDEX(1,"LENGTH") M D  ;JUMPED AWAY FROM USING THIS INDEX, EVEN THOUGH IT MIGHT NEVER HAVE BEEN TRIED BEFORE
 . S (X,X(1),DIVAL,DIVAL(1))=$E(DICR(DILONGX,"ORG"),1,DINDEX(1,"LENGTH")) ;TRIM LOOKUP VALUE DOWN TO SIZE!
 I DINDEX("#")>1,($G(DIALLVAL)!($G(DICR))),(DIC(0)["X"!(DIC(0)["O")) D EXACT^DIC4,SET^DIC4
 I DINDEX("#")'>1 S Y=0,DIX=X F  D MOREX Q:Y=-1!(DS(0))
 I DS(0) Q:DIC(0)'["T"  Q:$P(DS(0),U,2)'="U"!($G(DIROUT))  S DS(0)=0
 I DIC(0)["T",DIC(0)["E",$G(DUOUT) D  ;22*70
 . ; Set up variables for next index lookup
 . K DS,DUOUT
 . S (DS,DS(0),DS("DD"))=0
 . S X=DIVAL(1)
 . Q
 I DISAVDS=0,DS=1,DIC(0)["O"!(DIC(0)'["E"),DIC(0)'["T" D  Q:Y>0!($D(DIROUT))  ;Good IEN returned or user bailed out
 . I DINDEX("#")'>1,DIEXACTN>1,DINDEX'="B" S Y=-1 Q
 . S Y=+DS(1),DS("DD")=1
 . I DINDEX("#")'>1,DIEXACTN'>1 S DIY=1 D C^DIC2 Q
 . D G^DIC2 Q
 ;
PARTIAL ; Find all partial matches to the lookup values
 I DIC(0)'["X",DINDEX("#")>1 D PARTIAL^DIC4,SET^DIC4
 I DIC(0)'["X",DINDEX("#")'>1 F  D  Q:$G(DIX)=""!(DS(0))
 . N DITYP S DITYP=$G(DINDEX(1,"TYPE"))
 . D
 . . I DIC(0)["E",(DITYP["F"!(DITYP["S")) Q:DIC(0)["n"
 . . I $TR(X,"-.")?.N,DO(2)'["D",'$D(DIDA) S DIX=$O(@(DIC_"D,DIX_"" "")"),-1)
 . . Q
 . S DIX=$O(@(DIC_"D,DIX)"))
 . Q:DIX=""
 . I $P(DIX,X)'="" D  Q:DIX=""
 . . I +$P(X,"E")'=X!(DIC(0)'["E") S DIX="" Q
 . . I DIC(0)'["n"!(DITYP'["F"&(DITYP'["S")) S DIX="" Q
 . . D FINDMORE^DICLIX0(1,.DIX,X,.DINDEX) ;DIC(0)["n" SO WE KEEP LOOKING FOR PARTIAL NUMERIC MATCHES
 . . S:$P(DIX,X)'="" DIX="" Q
 . S Y=0 F  D MOREX Q:Y=-1!(DS(0))
 . Q
 I DS(0) Q:DIC(0)'["T"  Q:$P(DS(0),U,2)'="U"!($G(DIROUT))  S DS(0)=0
 I DIC(0)["T",DIC(0)["E",$G(DUOUT) D  ;22*70
 . ; Set up variables for next index lookup
 . K DS,DUOUT
 . S (DS,DS(0),DS("DD"))=0
 . S X=DIVAL(1)
 . Q
 ;
M ; Find the next index.  At end, display the rest
 I DIC(0)["T" D KEEPON^DIC5 I DS(0) Q:$P(DS(0),U,2)'="U"!($G(DIROUT))
 I DIC(0)["M" S DIOK=0 F  D  Q:DIOK
 . N Y S Y=DINDEX("START") K DINDEX S DINDEX("WAY")=1,DINDEX("START")=Y,DINDEX("#")=1
 . S (D,DINDEX)=$S($D(DID):$P(DID,U,DID(1)),1:$O(@(DIC_"D)"))) ;GRAB THE NEXT EXISTING CROSS-REF
 . S:$D(DID) DID(1)=DID(1)+1
 . I D=""!(D=-1) S D="",DIOK=1 Q
 . I $D(@(DIC_"D)"))-10 Q
 . ; Check Index, build index info
 . D IXCHK^DIC4(.DIFILEI,.DINDEX,.DIOK,.DIALLVAL,.DIVAL,$G(DID)) ;DINDEX=D.  Check that it's OK
 I DIC(0)["M",D]"" G EXACT
 D:DIC(0)["M" D^DIC0
 I DS=1 S DS("DD")=1 D G^DIC2 Q
 I DS D Y^DIC1 Q:DS(0)  I DINDEX("#")'>1 D:DO(2)["O"&(DO(2)'["A") L^DICM Q
 I $G(DILONGX) S X=$E(DICR(DILONGX,"ORG"),1,30)
 I DIC(0)["T",'$G(DICR),DIC(0)["O",DIC(0)["X" G SEARCH
 I DINDEX("#")>1,'$G(DICR) D:DIC(0)["L"  D:Y=-1 BAD^DIC1 Q
 . S Y=-1 I $G(DICR)="" N DICR S DICR=0
 . I $A(X)=34,X?.E1"""" D N^DICM Q
 . K DD D L^DICM Q
 D ^DICM Q
 ;
 ;
MOREX ; Find more exact matches to lookup value DIX
 S Y=$O(@(DIC_"D,DIX,Y)")) I 'Y S Y=-1 Q
 I $D(DIEXACTN)#2 S DIEXACTN=DIEXACTN+1
 D MN Q:'$T  D K  Q:$G(DS(0))
 I DS>1,DIC(0)'["E",DIC(0)'["Y" K DS S DS=0,DS(0)=1,Y=-1
 Q
 ;
MN N DZ S DZ=$S((DIC(0)["D"&(DINDEX="B")):1,$G(DINDEX("#"))>1:0,$G(@(DIC_"D,DIX,Y)")):1,1:0) S DIYX=0
 D:'$D(DO) GETFA^DIC1(.DIC,.DO)
 I D="B",'DZ,'($D(@(DIC_"D,DIX,Y)"))#2) D
 . N I S I=Y F  S DZ=$G(^(I)),I=$O(^(I,0)) Q:I=""
 . Q
 S DIY="" I '$D(@(DIC_"Y,0)")) X "I 0" Q
 I D="B",'DZ,'$D(DO("SCR")),$L(DIX)<30,'$D(DIC("S")),'$D(@(DIC_"Y,-9)")),'$G(DINDEX("OLDSUB")) D ADDKEY I 1 Q
 D S I  D
 . I DINDEX("FLISTD")["^.01^",DINDEX("#")=1,'DZ,$P(DIY,DIX)="",'$G(DINDEX("OLDSUB")) D  Q
 . . N I S I=$S($G(DILONGX):DICR(DILONGX,"ORG"),1:DIX)
 . . S DIY=$P(DIY,I,2,9),DIYX=1 D ADDKEY Q
 . Q:DIC(0)["Y"
 . I ($G(DINDEX("#"))>1)!($G(DINDEX("OLDSUB"))) D  Q
 . . D ADDIX^DIC4(.DIFILEI,Y,.DINDEX,.DIX,.DISCREEN)
 . . D ADDKEY Q
 . D ADDKEY
 . I DINDEX("FLISTD")["^.01^",'DZ S DIY=""
 . Q
 Q
 ;
S D:'$D(DO) GETFA^DIC1(.DIC,.DO)
 I $D(@(DIC_"Y,0)")),'$D(^(-9)) S DIY=$P(^(0),U)
 E  S DIY="" Q
 I '$D(DIC("S")),'$D(DO("SCR")) Q
 I $G(DINDEX("#"))>1!($G(DINDEX("OLDSUB"))) Q
 I $G(DILONGX) N DI0NODE,DIVAL D
 . N % S %=DINDEX(1,"GET")
 . I %="DIVAL=DINDEX(DISUB)" S DIVAL=X Q
 . I %["DI0NODE" S DI0NODE=@(DIC_"Y,0)")
 . N DIFILE S DIFILE=DIFILEI,DIFILE(DIFILE)=DIFILEI(DIFILEI)
 . N DIEN S DIEN=Y_DIENS
 . S @% Q
 N DIAC,DIFILE,DISAVEX,DISAVEY,DISAVED
 M DISAVEX=X,DISAVEY=Y S DISAVED=D I $D(@(DIC_"Y,0)"))
 I $D(DIVAL(1)),$D(DIVAL)=10 S DIVAL=DIVAL(1) ;*159
 I 1 X:$D(DIC("S")) DIC("S") K DIAC,DIFILE D:$D(DIC("S")) SX Q:'$T
 I $D(DO("SCR")),$D(@(DIC_"Y,0)")) X DO("SCR") D SX Q:'$T
 I 1 Q
 ;
SX M X=DISAVEX,Y=DISAVEY S D=DISAVED Q
 ;
ADDKEY ; Put KEY values into output array for display
 S DIX("F")="" I DIC(0)'["U" S DIX("F")=$G(DINDEX("FLISTD"))
 Q:'$D(DIFILEI(DIFILEI,"KEY"))  Q:DIC(0)["S"
 N DIKX,DII,DIFLD,DIERR,I
 M DIKX=DIFILEI(DIFILEI,"KEY",DIFILEI) Q:'$D(DIKX)
 K DIX("K")
 F I=0:0 S I=$O(DIKX(I)) Q:'I  F DIFLD=0:0 S DIFLD=$O(DIKX(I,DIFLD)) Q:'DIFLD  D
 . I DIFLD=.01,$G(DZ)=0 S DIY=""
 . S DIX("K",I,DIFLD)=$$GET1^DIQ(DIFILEI,Y_DIFILEI(DIFILEI,"KEY","IEN"),DIFLD,"","","DIERR") Q
 Q
 ;
K ; Put an IEN into the DS array for display
 N DZ,I S DZ=$O(DS(0)) F I=DZ:1:DS I +$G(DS(I))=Y,DIC(0)'["C" S I=-1 Q
 I I'=-1,DIC(0)["T" D
 . Q:'$D(^TMP($J,"DICSEEN",DIFILEI))
 . I $D(^TMP($J,"DICSEEN",DIFILEI,Y)) S I=-1 Q
 . S ^TMP($J,"DICSEEN",DIFILEI,Y)="" Q
 I I=-1 S I=DIX K DIX S DIX=I,I=-1 Q
 I DS-DZ>100 D
 . N D1,D2 S D2=DZ+19 F D1=DZ:1:D2 K DS(D1),DIY(D1),DIYX(D1)
 . Q
 S DS=DS+1 D
 . S I=DS M DS(DS)=DIX S DS=I,I=DIX K DIX S DIX=I
 . S DS(DS)=Y_"^"_$P(DIX,X,2,99) Q
 S DIY(DS)=DIY S:DIY]""&$G(DIYX) DIYX(DS)=1
 I DS#5-1!(DS=1)!(DIC(0)["Y") Q
 D Y^DIC1 Q
