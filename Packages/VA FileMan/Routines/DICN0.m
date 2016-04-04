DICN0 ;SFISC/GFT,XAK,SEA/TOAD/TKW-ADD NEW ENTRY ;22MAR2006
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**31,48,56,1022,147**
 ;
NEW ; try to add a new record to the file
 ; called from FILE, ^DICN
 ;
 N %,I,DDH,DI,DIE,DIK,DQ,DR,%H,%T,%DT,C,DIG,DIH,DIU,DIV,DISYS
 K % M %=X N X M X=% S %=+$G(D0) N D0 S:% D0=% K %
 I '$G(DIFILEI)!($G(DINDEX("#"))="") N DINDEX,DIFILEI,DIENS D
 . S DINDEX("#")=1,(DINDEX,DINDEX("START"))="B"
 . D GETFILE^DIC0(.DIC,.DIFILEI,.DIENS) Q
 G:DIFILEI="" OUT
 I '$D(@(DIC_"0)")),'$D(DIC("P")),$E(DIC,1,6)'="^DOPT(" S DIC("P")=$$GETP^DIC0(DIFILEI)
 D:'$D(DO(2)) GETFA^DIC1(.DIC,.DO) I DO="0^-1" G OUT
 S X=$G(X) I X="",DINDEX("#")>1 S X=$G(X(1))
 I X="",(DIC(0)'["E"!(DINDEX("#")'>1)) G OUT
 N DINO01 S DINO01=$S(X="":1,1:0) N DIX,DIY
 ;
N1 ; if LAYGO nodes are present, XECUTE them and verify they don't object
 ;
 S Y=1 F DIX=0:0 D  Q:DIX'>0  Q:'Y
 . S DIX=$O(^DD(+DO(2),.01,"LAYGO",DIX)) Q:DIX'>0
 . I $D(^DD(+DO(2),.01,"LAYGO",DIX,0)) X ^(0) S Y=$T
 I 'Y G OUT
 ;
 ; if the file is in the middle of archiving, keep out
 ;
 I $P($G(^DD($$FNO^DILIBF(+DO(2)),0,"DI")),U,2)["Y" D  I Y G OUT
 . S Y='$D(DIOVRD)&'$G(DIFROM)
 ;
N2 ; process DINUM
 ;
 S DIX=X
 I $D(DINUM) D
 . S X=DINUM D  I '$D(X) S Y=0,X=DIX Q
 . . N DIX D N^DICN1 Q
 . D LOCK(DIC,X,.Y)
 ;
 ; or process DIENTRY (numeric input that might be IEN LAYGO)
 ;
 E  I $D(DIENTRY) D
 . S X=DIENTRY D  I 'Y S X=DIX Q
 . . N DIX D ASKP001^DICN1 Q
 . D LOCK(DIC,X,.Y)
 ;
 ; or get a record number the usual way
 ;
 E  S X=$P(DO,U,3) D INCR N DIFAUD S %=+$P(DO,U,2),DIFAUD=$S($D(^DIA(%,"B")):%,1:0) F  D  Q:Y'="TRY NEXT"
 . F  S X=X\DIY*DIY+DIY Q:'$D(@(DIC_"X)"))&$S('DIFAUD:1,1:+$O(^DIA(DIFAUD,"B",X_","))-X&'$D(^(X)))
 . I $G(DUZ(0))="@"!$P(DO,U,2) N DIX D ASKP001^DICN1 Q:'Y
 . D LOCK(DIC,X,.Y) Q:Y  S Y="TRY NEXT"
 ;
 I 'Y S Y=-1 D BAD^DIC1 Q
 ;
N3 ; add the new record at the IEN selected
 ;
 S @(DIC_"X,0)")=DIX
 L @("-"_DIC_"X)")
 ;
 ; update the file header node
 ;
 K D S:$D(DA)#2 D=DA S DA=X,X=DIX
 I $D(@(DIC_"0)")) S ^(0)=$P(^(0),U,1,2)_U_DA_U_($P(^(0),U,4)+1)
N4 ; if compound index and we don't know internal value of .01, we'll prompt for it in ^DIE.
 I DINO01 D  G:Y>0 D Q
 . D ^DICN1 I Y'>0 S:$G(DO(1)) DS(0)="1^" S (X,DIX)="" Q
 . S (X,DIX)=$P($G(@(DIC_DA_",0)")),U)
 . Q
N5 ; If .01 is marked for auditing, update audit file
 D
 . I DO(2)'["a" Q:$P(^DD(+DO(2),.01,0),U,2)'["a"  Q:^("AUDIT")["e"
 . D AUD^DIET
 ;
 ; index the .01 field of the new entry
 ;
 N DD S DD=0 D
 . N DIFILEI,DINDEX,DIVAL,DIENS,DISUBVAL
 . F  S DD=$O(^DD(+DO(2),.01,1,DD)) Q:'DD  D
 . . K % M %=X N X M X=% K %
 . . I ^DD(+DO(2),.01,1,DD,0)["TRIGGER"!(^(0)["BULL") D  Q
 . . . N %RCR,DZ S %RCR="FIRE^DICN",DZ=^DD(+DO(2),.01,1,DD,1)
 . . . F %="D0","Y","DIC","DIU","DIV","DO","D","DD","DICR","X" S %RCR(%)=""
 . . . D STORLIST^%RCR Q
 . . M %=DIC N DIC M DIC=% K % M %=DA N DA M DA=% K % S %=DD N DD,D
 . . X ^DD(+DO(2),.01,1,%,1) Q
 . Q
 I $O(^DD("IX","F",+DO(2),.01,0)) D
 . K % M %=X N X M X=% K % M %=DIC N DIC M DIC=%
 . K % M %=DA N DA M DA=% K % M %=DO N DO M DO=% K % N DD,D
 . D INDEX^DIKC(+DO(2),DA_DIENS,.01,"","SC") Q
 ;
N6 ; if we have lookup values to stuff, or DIC("DR"), or if the file has
 ; IDs or KEYS, go do DIE.
 ; Code will return at D if successful. We set output and go exit
 ;
 S Y=DA D
 . I $D(DIC("DR"))!($O(DISUBVAL(+DO(2),0)))!($O(^DD("KEY","B",+DO(2),0))) D ^DICN1 Q
 . Q:DIC(0)'["E"
 . I '$O(^DD(+DO(2),0,"ID",0)) Q
 . D ^DICN1 Q
 I Y'>0 S:$G(DO(1)) DS(0)="1^" Q
 ;
 ; Finish adding the new record.
D S Y=DA_U_X_"^1" I $D(D)#2 S DA=D
 D R^DIC2 Q
 ;
INCR S DIY=1 I $P(DO,U,2)>1 F %=1:1:$L($P(X,".",2)) S DIY=DIY/10
 Q
 ;
 ;
OUT I DIC(0)["Q" W $C(7)_$S('$D(DDS):" ??",1:"")
 S Y=-1 I $D(DO(1)),'$D(DTOUT) D A^DIC S DS(0)="1^" Q
 D Q^DIC2 Q
 ;
LOCK(DIROOT,DIEN,DIRESULT) ;
 ;
 ; try to lock the record, and see if it's already there
 ; NEW
 ;
 D LOCK^DILF(DIROOT_"DIEN)") ;L @("+"_DIROOT_"DIEN):1") ;**147
 S DIRESULT='$D(@(DIROOT_"DIEN)"))&$T
 I 'DIRESULT L @("-"_DIROOT_"DIEN)")
 Q
 ;
