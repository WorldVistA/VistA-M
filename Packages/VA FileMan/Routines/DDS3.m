DDS3 ;SFISC/MLH-COMMAND UTILS ;16FEB2005
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999,1004,1006**
 ;
 I $G(Y(0))]"","ECNRSPQ"[$E(Y(0)) D @$E(Y(0)) ;'Y' is carried over from the ^DIR read in DDSCOM
 Q
 ;
S ;Save the form
 D ^DDS4,R^DDSR
 D:$D(DDSBR)#2 BR^DDS2
 Q
 ;
R ;Repaint all pages on current screen
 ;Called after wp, mults, and deletions
 G R^DDSR
 ;
E ;Exit
 I DDSSC>1!'DDSCHG!$P(DDSSC(DDSSC),U,4) S DDACT="Q" Q
 S DDM=1
 S Y=1 G EX ;S Y=0 I $G(^XTV(8989.5,0))?1"PARAM".E S Y=$$GET^XPAR("ALL","DI SCREENMAN DON'T ASK SAVE") I Y=1 G EX ;**AVOID THE Y/N QUESTION
 K DIR S DIR(0)="YO"
 S DIR("A")=$$EZBLD^DIALOG(8075)
 D BLD^DIALOG(9037,"","","DIR(""?"")")
 S DIR0=IOSL-1_U_($L(DIR("A"))+1)_"^3^"_(IOSL-1)_"^0"
 D ^DIR
 K DIR,DIROUT,DIRUT
 I Y=0!$D(DTOUT)!$D(DUOUT) D QT Q
 I Y="" S DDACT="N" Q
 I Y=1 D EX
 Q
 ;
C ;Close
 S DDACT="Q"
 Q
 ;
N ;Next page
 S:DDSNP]"" DDSPG=DDSNP,DDACT="NP"
 Q
 ;
P ;Previous
 D PP^DDS01 Q
 ;
Q ;
QT ;Exit, don't save
 I $G(DDSDN)=1,DDO G ERR3
 S DDACT="Q"
 I DDSSC>1!$P(DDSSC(DDSSC),U,4) D MSG1 Q  ;IT ALSO QUIT HERE IF $G(DDSSEL)
 Q:'DDSCHG
 D DEL^DDS6
 S DX=0,DY=IOSL-1 X IOXY
 W $P(DDGLCLR,DDGLDEL),$S($D(DTOUT):$$EZBLD^DIALOG(8076),1:"")_$$EZBLD^DIALOG(8077) H 1
 Q
 ;
EX ;Exit, save
 I $G(DDSDN)=1,DDO G ERR3
 S DDACT="Q"
 I DDSSC>1!$P(DDSSC(DDSSC),U,4) D MSG1 Q  ;IT ALSO QUIT HERE IF $G(DDSSEL)
 D ^DDS4 I 'Y S DDACT="N" D R D:$D(DDSBR)#2 BR^DDS2
 Q
 ;
CL ;Close
 I $G(DDSDN)=1,DDO G ERR3
 G E
 ;
TO ;Time-out
 I DDO,$G(DDSDN) S DDACT="N" G CURSOR^DDS01
 I DDO S DDSOSV=DDO,DDO=0
 E  D E
 Q
 ;
MSG1 ;Print closing page message
 S DX=0,DY=IOSL-1 X IOXY
 W $P(DDGLCLR,DDGLDEL)_"..." H 1
 Q
 ;
ERR3 ;
 D MSG^DDSMSG("Since navigation for the block is disabled, that key sequence is disabled.",1)
 S DDACT="N"
 Q
 ;
 ;#8075  Save changes before leaving form (Y/N)?
 ;#8076  Time out.
 ;#8077  Changes not saved!
 ;#9037  Enter 'Y' to save before exiting...(3 lines)
