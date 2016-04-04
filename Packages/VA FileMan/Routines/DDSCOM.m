DDSCOM ;SFISC/MLH-COMMAND UTILS ;20JULY2013
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999,1003,1004,1007,1045**
 ;
COM ;Command line prompt
 D:$G(@DDSREFT@("HLP"))>0 HLP^DDSMSG()
 N DDSCOM,DIR K DTOUT
 D SETUP(.DDSCOM,.X,.DIR)
 S DIR("?",1)=X
 S DIR("A")=$$EZBLD^DIALOG(8000),DIR("?",2)=" ",DIR("?")=$$EZBLD^DIALOG($S($G(DDSMOUSY):8000.101,1:8000.1)) ;'COMMAND' LINE & 'Enter a COMMAND'
 S DIR("??")="^D CHLP^DDSCOM"
 D:'$G(DDSKM)
 .K DDH,DDQ
 .F DDH=1:1:IOSL-DDSHBX-6 S DDH(DDH,"T")=" " ;ERASE EVERYTHING IN HELP AREA...
 .S DDH=DDH+1,DDH(DDH,"T")=DIR("?",1)
 .S DDH=DDH+1,DDH(DDH,"T")=DIR("?",2)
 .S DDH=DDH+1,DDH(DDH,"T")=DIR("?")
 .D SC^DDSU
 S DDM=1 K DDSKM
 S DIR0=IOSL-1_U_($L(DIR("A"))+1)_"^30^"_(IOSL-1)_"^0"
 D ^DIR K DUOUT,DIROUT,DIRUT
TRANS S:X?1A.E (X,Y,Y(0))=$E("ECSNRPQ",$F(DIR("X"),$E($$UP^DILIBF(X)))-1)
 M DDSMOUSE(IOSL-5)=DDSCOM ;...DOWN TO 'Exit  Save....'  REMEMBER WHERE THESE SHOW FOR MOUSE
 D:X="C"
 . S:DDACT="N" Y="c"
 . S Y(0)="CLOSE"
 . S:DDACT'="N" (X,Y,Y(0))=""
 Q
 ;
BOT ;from DIR0 & DIR02
 I DDS?.N1"^MSCXQSCR" Q  ;!!!!!!
 N X,XVIS,I,DIR,M,DIREPLIN
 S DY=IOSL-1,DX=0,$X=0 X IOXY W $P(DDGLCLR,DDGLDEL) ;Clear the bottom line
 S DIREPLIN=$P($$EZBLD^DIALOG(7002),U,$S($G(DIR0("REP")):2,1:1)) ;INSERT/REPLACE
 I '$G(DDSMOUSY) D
 .I DDO,'$G(DDM) W $$EZBLD^DIALOG(8000) ;**'COMMAND:'
 E  I DDO D
 .D SETUP(.M,.X,.DIR)
 .K DDSMOUSE(DY) M DDSMOUSE(DY)=M S DX=0 W X
 S X=$$EZBLD^DIALOG($G(DDSMOUSY)/10+8074),DX=IOM-$L(DIREPLIN)-3-$L(X) I DX>$X D  ;'F1-H FOR HELP' or 'HELP' if we have room
 . X IOXY
 . W $P(DDGLVID,DDGLDEL,10)_$P(DDGLVID,DDGLDEL,6)_X_$P(DDGLVID,DDGLDEL,10)
 .S DDSMOUSE(DY,DX,DX+$L(X)-1)="H^DIR0H"
 S DX=IOM-$L(DIREPLIN)-1 X IOXY
 W $S('$D(DDGLVAN):$P(DDGLVID,DDGLDEL,6),1:"")_DIREPLIN_$P(DDGLVID,DDGLDEL,10) ;INSERT/REPLACE
 S DDSMOUSE(DY,DX,DX+$L(DIREPLIN)-1)="RPM^DIR01" ;Make 'REPLACE' clickable
 Q
 ;
 ;
 ;
SETUP(DDSM,X,DIR) ;DDSM, DIR, & X are return variables
 ;DDSM shows mouse positions
 ;DIR is array
 ;X is writeable string
 K DDSM,DIR("X") N DDSCH,DDSPP,XVIS
 F X=1:1:7 S DDSCH(X)=$$EZBLD^DIALOG(X/100+8000),$E(DIR("X"),X)=$C($A(DDSCH(X))),DDSCH(X,0)=$C($A(DDSCH(X))+32)_":"_$$UP^DILIBF(DDSCH(X))
 S DDSPP=$$PP^DDS5(.X) I 'X S DDSPP="" ;Previous Page
 S X="" ;This will be the string of COMMANDs, with control sequences to highlight
 S XVIS="" ;just visible chars
 S DIR(0)="SO^"
 I DDSSC>1!$P(DDSSC(DDSSC),U,4)!($G(DDSSEL)&'$$MULSELPG^DDSRUN(+DDS)) D  ;POP-UP PAGE.   DO THIS FOR OLD-STYLE SELECTION PAGE
 .D EXSANEXR(2,"CL"),EXSANEXR(5,"RF")
 .S DIR("B")=DDSCH(2) ;"Close" in Command Line
 E  D
 .D EXSANEXR(1,"EX") D:$D(DDSFDO)[0 EXSANEXR(3,"SV") D:DDSNP]"" EXSANEXR(4,"NP^DDS2") D:DDSPP]"" EXSANEXR(6,"PP") D EXSANEXR(5,"RF") D EXSANEXR(7,"QT")
 S X=$E(X,1,$L(X)-4)
 Q
EXSANEXR(N,JUMP) S DIR(0)=DIR(0)_DDSCH(N,0)_";",N=DDSCH(N),DDSM=$L(XVIS)
 S XVIS=XVIS_N_"    " ;BUILD 'Exit   Save   ...' STRING
 I $G(DDSMOUSY) S X=X_$$HIGH^DDSU(N)_"    "
 E  S X=XVIS
 S DDSM(DDSM,DDSM+$L(N)-1)=JUMP ;Mouse positions for each character of displayed text
 Q
 ;
 ;
 ;
CHLP ;
 K DDH,DDQ
 S DDH=0,DDS3CD=$P(DIR(0),U,2)
 F DDS3PC=1:1:$L(DDS3CD,";") D
 . S DDS3C=$C($A($P($P(DDS3CD,";",DDS3PC),":"))-32)
 . I "^E^C^S^N^R^P^Q^"[(U_DDS3C_U) D
 .. S DDH=DDH+1
 .. S DDH(DDH,"T")=$E($P($T(@("H"_DDS3C)),";",3)_"           ",1,11)_"- "_$$EZBLD^DIALOG($P($T(@("H"_DDS3C)),";",4)) ;**CC0/NI  THE DIFFERENT COMMAND-LINE RESPONSES
 D:DDH>0 SC^DDSU
 K DDS3C,DDS3CD,DDS3PC
 Q
HE ;;Exit;8000.11;**CCO/NI  CHANGED THRU BOTTOM OF ROUTINE
HC ;;Close;8000.12
HS ;;Save;8000.13
HN ;;Next Page;8000.14
HR ;;Refresh;8000.15
HP ;;Previous Page;8000.16
HQ ;;Quit;8000.17
