DIDU1 ;SEA/TOAD-VA FileMan: DD Tools, IENS Check ;10:39 AM  8 Jul 1998
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
IEN(DIENS,DIFLAGS) ;
 ;ENTRY POINT--return whether the IEN String is valid
 ;extrinsic function, all passed by value
 I $G(DIENS)="" Q 0
 I $G(DIFLAGS,"N")'="N" Q 0
 S DIFLAGS=$G(DIFLAGS)
 N DICHAR,DICRSR,DIPIECE,DISEQ,DIOUT,DIVALID
 S DIPIECE="",DISEQ="",DIOUT=0,DIVALID=1
 F DICRSR=1:1 D  I DIOUT Q
 .S DIPIECE=$P(DIENS,",",DICRSR)
 .I DIPIECE="" D  Q
 ..I $P(DIENS,",",DICRSR,999)="" S DIOUT=1 Q
I1 ..I DICRSR=1 Q
 ..S DIOUT=1,DIVALID=0
 ..Q
 .I +DIPIECE=DIPIECE S DIVALID=DIPIECE>0,DIOUT='DIVALID Q
 .I DIFLAGS["N" S DIVALID=0,DIOUT=1 Q
 .S DICHAR=$E(DIPIECE,1,2) I DICHAR'="?+" S DICHAR=$E(DICHAR)
 .I DICHAR'="+",DICHAR'="?",DICHAR'="?+" S DIOUT=1,DIVALID=0 Q
 .I $P(DIPIECE,DICHAR,2,9999)?1N.N D  Q
 ..S DISEQ=$P(DIPIECE,DICHAR,2,999)
 ..S DIOUT=+DISEQ'=DISEQ!$D(DISEQ(DISEQ)),DIVALID='DIOUT Q
I2 .S DIOUT=1,DIVALID=0
 .Q
 Q $E(DIENS,$L(DIENS))=","&DIVALID
 ;
PROOT(DIFILE,DIENS) ;
 ;ENTRY POINT--return the global root of a subfile's parent
 ;extrinsic function, all passed by value
 Q $$ROOT^DILFD($$PARENT(DIFILE),$P(DIENS,",",2,999),1)
 ;
PARENT(DIFILE) ;
 ;ENTRY POINT--return the file number of a subfile's parent
 ;extrinsic function, all passed by value
 Q $G(^DD(DIFILE,0,"UP"))
 ;
PARENTS(DIFILE,DIRULE) ;
 ;IEN--return the file's parents
 ;procedure, passed by ref
 N DIBACK,DIOUT,DIMOM,DITEMP
 S DIOUT=0,DIMOM=DIFILE
 S DITEMP=DIFILE K DIFILE S (DIFILE,DIFILE("C"))=DITEMP
 S DIFILE("L")=$$LEVEL(DIFILE)
 S DIFILE(1)=DIFILE
 I '$D(DIRULE("L",DIFILE)) S DIRULE("L",DIFILE)=DIFILE("L")
 F DIBACK=2:1 D  I DIOUT Q
 .S DITEMP=DIMOM
 .S DIMOM=$G(DIRULE("UP",DITEMP))
PA1 .I DIMOM="" D  I DIOUT Q
 ..S DIMOM=$G(^DD(DITEMP,0,"UP"))
 ..I DIMOM="" S DIOUT=1 Q
 ..S DIRULE("UP",DITEMP)=DIMOM
 ..I '$D(DIRULE("L",DIMOM)) S DIRULE("L",DIMOM)=DIFILE("L")-DIBACK+1
 ..Q
 .S DIFILE(DIBACK)=DIMOM
 .Q
 Q
 ;
LEVEL(DIFILE) ;
 ;IEN--return the file's level (# parents +1)
 ;function, pass by value
 N DIMOM
 I '$G(DIFILE) Q 0
 S DIMOM=$G(^DD(DIFILE,0,"UP"))
 I DIMOM="" Q 1
 Q $$LEVEL(DIMOM)+1
 ;
