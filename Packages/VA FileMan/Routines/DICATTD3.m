DICATTD3 ;GFT/GFT - Set of Codes ;09:06 AM  21 Jan 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
Y(ORDER,CM) ;
 S Y=$P($P(DICATT3,";",ORDER),":",CM) Q
C ;
 N C
 F C=":",";","=","""" I X[C D HLP^DDSUTL("SORRY -- '"_C_"' NOT ALLOWED IN SET VALUES!") K X Q
 Q
 ;
POST3 ;
 N I,X,F
 K DDSBR,DDSERROR
 S F=$$GET^DDSVALF(1,"DICATT",1,"I","") ;we need FIELD LABEL to check total length of "0" node
 S DICATTLN=1,DICATT3N=""
 F X=35:2:59 S I=$$G(X) D  I $D(DDSERROR) G ERROR
 .I I="" Q:$$G(X+1)=""  S DDSERROR=1,DDSBR=X D H("THERE MUST BE A CODE FOR '"_$$G(X+1)_"'!") Q
 .I $D(F(I)) S DDSERROR=1,DDSBR=X D H("CAN'T HAVE TWO IDENTICAL CODES!") Q
 .S X(X)=I,F(I)=""
 .I $L(I)>DICATTLN S DICATTLN=$L(I)
 .S I=$$G(X+1) I I="" S DDSERROR=1,DDSBR=X+1 D H("'"_X(X)_"' MUST MEAN SOMETHING!") Q
 .I $L(DICATT3N)+$L(X(X))+$L(I)+$L(F)>235 S DDSERROR=1,DDSBR=X D H("TOO MUCH!!  TO STORE THAT MUCH, BUILD A NEW FILE AND USE A POINTER!") Q
 .S DICATT3N=DICATT3N_X(X)_":"_I_";"
 S DICATT2N="S",DICATT5N="Q"
 S DICATTMN=$$GET^DDSVALF(98,"DICATT",1,"I","") ;says we have a change
BRANCH I '$D(DICATTSC),DUZ(0)="@" S DICATTSC=3,DDSBR="65^DICATT SCREEN^6" Q
 D SCREEN
 Q
 ;
G(I) N X Q $$GET^DDSVALF(I,"DICATT3",2.3,"I","")
 ;
H(I) N X S X(1)=I,X(2)="$$EOP"
 D HLP^DDSUTL(.X)
 Q
 ;
ERROR S DDSBR=DDSBR_"^DICATT3^2.3" Q
 ;
SCREEN ;
 I DUZ(0)'="@" Q
 I $$S(66)]"" S DICATT5N(12.1)=$$S(66),DICATT5N(12)=$$S(67),DICATT2N="*"_DICATT2N
 Q
 ;
S(I) Q $$GET^DDSVALF(I,"DICATT SCREEN",6,"I","")
