DICN ;SFISC/GFT,XAK,TKW,SEA/TOAD-ADD NEW ENTRY ;16NOV2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**4,31,169,999,1022,1044**
 ;
 N DIENTRY,DIFILE,DIAC D:'$D(DO(2)) GETFA^DIC1(.DIC,.DO) S DO(1)=1
 I '$D(DINDEX) N DINDEX S DINDEX("#")=1,DINDEX("START")="B"
 N DISUBVAL,V
 I DINDEX("#")>1 M V=X N X D  I X="",DIC(0)'["E"!('$D(DISUBVAL)) D BAD^DIC1 Q
 . D VALIX(+DO(2),.DINDEX,.V,.DISUBVAL,.X,.DS) K V Q
 I $S($D(DLAYGO):DO(2)\1-(DLAYGO\1),1:1) S %=1 D B1 I '% D BAD^DIC1 Q
USR D DS S DIX=X
 I X'?16.N,X?.NP,X,DIC(0)["E",'$G(DICR),DS'["DINUM",$P(DS,U,2)'["N",DIC(0)["N"!$D(^DD(+DO(2),.001,0)) D N^DICN1 I $D(X) S DIENTRY=X G I
 S X=DIX D:DINDEX("#")'>1 VAL G I:$D(X)
 S X=DIX
B D BAD^DIC1 S Y=-1 Q
 ;
B1 Q:'DO(2)  Q:$D(^DD(+DO(2),0,"UP"))!(DO(2)=".12P")
 S DIFILE=+DO(2),DIAC="LAYGO" D ^DIAC K DIAC,DIFILE
 Q
 ;
1 I '$D(DIC("S")) D  ;**CCO/NI 'ARE YOU ADDING'? THRU NEXT 4 LINES
 .N M
 .S M=$$EZBLD^DIALOG(8058,$$OUT^DIALOGU(Y,"ORD"))
 .S:$D(^DD(+DO(2),0,"UP")) M=M_$$EZBLD^DIALOG(8059,$$FILENAME^DIALOGZ(^("UP"))) S M=M_")"
 .I $L(M)+$L(DST)'>$S($G(IOM):IOM,1:80) S DST=DST_M
Y I $D(DDS) S A1="Q",DST=%_U_DST D H^DDSU Q
 W !,DST K DST
YN ;
 N %1 S %1=$$EZBLD^DIALOG(7001) S:'$D(%) %=0 W "? " W:(%>0) $P(%1,U,%),"// "
RX R %Y:$S($D(DTIME):DTIME,1:300) E  S DTOUT=1,%Y=U W $C(7)
 I %Y]""!'% S %=+$$PRS^DIALOGU(7001,%Y) S:(%<0&($A(%Y)'=94)) %=0
 I '%,%Y'?."?" W $C(7),"??",!?4,$$EZBLD^DIALOG(8040),": " G RX
 W:$X>73 ! W:% $S(%>0:"  ("_$P(%1,U,%)_")",1:"") Q
 ;
DS S DS=^DD(+DO(2),.01,0) Q
 ;
VAL I X'?.ANP K X Q
 I X[""""!(X["^") K X Q
 I $P(DS,U,2)'["N",$A(X)=45 K X Q
 I $P(DS,U,2)["*" S:DS["DINUM" DINUM=X Q
 N %T,%DT,C,DIG,DIH,DIU,DIV,DICR ;PRESERVE VARIABLES WHILE WE XECUTE INPUT TRANSFORM ON THE .01 FIELD
 S %=$F(DS,"%DT=""E"),DS=$E(DS,1,%-2)_$E(DS,%,999) N DICTST S DICTST=DS["+X=X"&(X?16.N) K:DICTST X X:'DICTST $P(DS,U,5,99)
UNIQ I $P(DS,U,2)["U",$D(X),$D(@(DIC_"""B"",X)")) K X
 Q
 ;
I1 S DST=$C(7)_$$EZBLD^DIALOG(8060)
 I '$D(DIENTRY),Y]"" S DST=DST_$$EZBLD^DIALOG(8061,Y)
 S %=$$FILENAME^DIALOGZ(+DO(2)) I $L(DST)+$L(%)'>55 S DST=DST_$$EZBLD^DIALOG(8062,%) Q  ;**CCO/NI FILE NAME
 W:'$D(DDS) !,DST K A1 D:$D(DDS) H^DIC2 S DST="    "_$$EZBLD^DIALOG(8062,%) Q
 ;
I I DIC(0)["E",DO(2)'["A",DIC(0)'["W" K DTOUT,DUOUT D  G OUT^DICN0:$G(DTOUT)!($G(DUOUT)) I %'=1 S Y=-1 D BAD^DIC1 Q
 . S (Y,DIX)=X I Y]"" N C S C=$P(^DD(+DO(2),.01,0),U,2) D Y^DIQ
 . D I1 S %=2,Y=$P(DO,U,4)+1,X=DIX D 1
I2 . Q:%>0!($G(DTOUT))  I %=-1 S DUOUT=1 Q
 . W:'$D(DDS) $C(7)_"??",!?4,$$EZBLD^DIALOG(8040) D YN G I2
 G NEW:'$D(DIENTRY)
R D DS S DST="   "_$P(DS,U,1)_": "
 I '$D(DDS) W !,DST K DST R X:DTIME S:$E(X)=U DUOUT=1,Y=-1 S:'$T X=U,DTOUT=1,Y=-1
 I $D(DDS) S A1="Q",DST="3^"_DST D H^DDSU S X=% I $D(DTOUT) S X=U,Y=-1
 I X[U D BAD^DIC1 Q
 I X="" G R
 D VAL
HELP I '$D(X) D  G R ;**CCO/NI  PLUS NEXT 2 LINES HELP MESSAGE FOR .01 FIELD, WHEN TELLING USER HOW TO LAYGO A NEW ONE
 .W $C(7) W:'$D(DDS) "??" S DST=$$HELP^DIALOGZ(+DO(2),.01) Q:DST=""
 .S DST="    "_DST W:'$D(DDS) !,DST D:$D(DDS) H^DDSU
 ;
NEW ; try to add a new record to the file
 G NEW^DICN0
 ;
FILE ; DOCUMENTED ENTRY POINT: add a new record to a file
 ;
 N DIENTRY,DS,DIAC,DIFILE D NEW^DICN0,Q^DIC2 Q
 ;
FIRE ; fire the SET logic of a bulletin or trigger xref (in DZ)
 ; STORLIST^%RCR (called by NEW^DICN0)
 ;
 X DZ
 Q
 ;
VALIX(DIFILEI,DINDEX,V,DISUBVAL,X,DS) ;
 ; Save lookup values in array by field no. so we can update the fields on the new record.
 N VI,DISUB,DIERR,DIFILE,DIFIELD,DO,DIOK
 S X="" I $G(V)]"",$G(V(1))="" S V(1)=V
 F DISUB=1:1:DINDEX("#") I $G(V(DISUB))]"" D
 . S DIFILE=$G(DINDEX(DISUB,"FILE")),DIFIELD=$G(DINDEX(DISUB,"FIELD"))
 . S DIOK=0 I 'DIFILE!('DIFIELD) Q
 . S V=V(DISUB)
 . I DISUB=1 D  I DIOK S:DIOK'=2 DISUBVAL(DIFILE,DIFIELD)=V Q
 . . I $A(V)=34,V?.E1"""" S V=$E(V,2,($L(V))-1)
 . . I $G(DS("INT"))="",'$G(DICRS) S:"VP"[$G(DINDEX(1,"TYPE")) DIOK=2 Q
 . . S DIOK=1
 . . I DIFILE=DIFILEI,DIFIELD=.01 S X=$S($G(DICRS):V,1:DS("INT")) Q
 . . S DISUBVAL(DIFILE,DIFIELD,"INT")=$S($G(DICRS):V,1:DS("INT"))
 . . Q
 . S DISUBVAL(DIFILE,DIFIELD)=V
 . D CHK^DIE(DIFILE,DIFIELD,"",V,.VI,"DIERR") Q:VI="^"
 . I DIFILE=DIFILEI,DIFIELD=.01 S X=VI K DISUBVAL(DIFILE,.01) Q
 . S DISUBVAL(DIFILE,DIFIELD,"INT")=VI
 . Q
 Q
 ;
 ;#7001   Yes/No question
 ;#8040   Answer with 'Yes' or 'No'
 ;#8058   (the |entry number|
 ;#8059   for this |filename|
 ;#8060   Are you adding
 ;#8061   '|.01 field value|' as
 ;#8062   a new |filename|
