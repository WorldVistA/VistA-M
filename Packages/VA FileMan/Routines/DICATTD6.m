DICATTD6 ;GFT/GFT - Computed Field;12:54 PM  21 Mar 2001
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**42,76**
 ;
 ;78 = COMPUTED EXPRESSION
 ;79 = TYPE OF RESULT
 ;80 = NUMBER OF FRACTIONAL DIGITS
 ;81 = ROUNDED?
 ;82 = TOTALLING SUMS
 ;83 = LENGTH
 ;83.1 = POINT TO FILE
 ;
VAL6 ;validate COMPUTED EXPRESSION (78)
 Q:X=""
 N A,DA,I,J,DQI,DICMX,DICM,DICOMP,DICOMPX,XSAVE
 S DQI="Y("_DICATTA_","_DICATTF_",",XSAVE=X
 D DICOMP I '$D(X) S DDSBR=78 D PUT^DDSVALF(78,,,DDSOLD) Q
 I DUZ(0)="@" K DQI S DQI(1)="TRANSLATES TO THE FOLLOWING CODE:",DQI(2)=X D HLP^DDSUTL(.DQI)
 S DICATT5=X,DICM=Y["m"
 F I=80:1:83 D UNED^DDSUTL(I,"DICATT6",2.6,DICM) ;If multiple, don't ask other questions
 D UNED^DDSUTL(83.1,"DICATT6",2.6,Y'["p")
 K DICATT5N M DICATT5N=X S DICATT5N(9)="^",DICATT5N(9.1)=XSAVE,DICATT5N(9.01)=DICOMPX ;remember all the stuff in DICATT5N array
TYPE S DICATT2N=$S(Y["D":"D",Y["B":"B",1:"")_"C"_$S('DICM:$S(Y["B":"J1",1:"J"),1:"m"_$E("w",Y["w"))_$S(Y["p":"p"_$S($P(Y,"p",2):+$P(Y,"p",2),1:""),1:"")
 I DICATT2N="CJ" D  ;may be numeric for TOTALLING
 .K DICOMPX
 .F Y=1:1 S %=$P(DICATT5N(9.01),";",Y) Q:'%  S DICOMPX(1,+%,+$P(%,U,2))="S("""_%_""")"
 .Q:Y<2  I DICATT5'["/",DICATT5'["\" Q:DICATT5'["*"!(Y<3)
 .S DQI="Y(",X=XSAVE D DICOMP
 .I $D(X)=1 S DICATT5N(9.02)=X_" S Y=X"
 D CUNED(DICATT2N) ;Re-prompt TYPE
 D UNED^DDSUTL(82,"DICATT6",2.6,'$D(DICATT5N(9.02))) ;If no components, don't ask 'SUMS' question
 Q
 ;
CUNED(S) ;also called by DICATTD
 D PUT^DDSVALF(79,"DICATT6",2.6,$$TYPE^DICATT3(S))
 N DICUNED F DICUNED=18,3,4,6,7,8,98,99 D UNED^DDSUTL(DICUNED,"DICATT",1,1) ;Make 'MANDATORY?',etc. uneditable
 Q
 ;
DICOMP S A=DICATTA,DA=DICATTF,DICOMPX="",DICOMP="I",DICMX="X DICMX"
 D IJ^DIUTL(A)
 D ^DICOMP Q
 ;
 ;
BR79 ;branch from TYPE
 N A,S
 D UNED^DDSUTL(83.1,"DICATT6",2.6,X'["p")
 S A="" I X["p" S A=$P($G(DICATT2N),"p",2) S:'A A=$P(DICATT2,"p",2) S:A A=$P($G(^DIC(+A,0)),U)
 D PUT^DDSVALF(83.1,,,A)
 S S=X["D"!(X["B")!(X["m")!(X["p")
 F A=80:1:83 D UNED^DDSUTL(A,"DICATT6",2.6,S) I S D PUT^DDSVALF(A,,,"") ;for DATE, BOOLEAN POINTER, & MULTIPLE, don't ask other questions
 I $$G(79)="" D PUT^DDSVALF(83,,,8) ;default length of field=8
 Q:X="N"
 F A=80,81,82 D PUT^DDSVALF(A,,,""),UNED^DDSUTL(A,"DICATT6",2.6,1)
 Q
 ;
 ;
POST6 ;POST ACTION of Page 2.6
 N T,I
 I $$G(82)=0 K DICATT5N(9.02)
 S T=$$G(79)
 F I="D","B","m","mp","p" I T=I S:T["p" T=T_$$G(83.1) S DICATT2N="C"_T G CHNGD
 S I="" I T="N" S I=$$G(80) ;if numeric, get fractional digits
 S DICATT2N="CJ"_$$G(83) ;length of field
 S T=" S X=$J(X,0,"
 S DICATT5N=$S($D(DICATT5N)#2:DICATT5N,1:$P(DICATT5,T))
 I I D
 .S DICATT2N=DICATT2N_","_I
 .I $$G(81) S DICATT5N=DICATT5N_T_I_")"
CHNGD S DICATTMN=""
 D UNED^DDSUTL(20.5,"DICATT",1,1) ;don't ask multiple
 S DICATT4N=" ; " ;Computed Field is stored nowhere!
 Q
 ;
G(I) Q $$GET^DDSVALF(I,"DICATT6",2.6,"I","")
