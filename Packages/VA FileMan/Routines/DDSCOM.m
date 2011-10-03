DDSCOM ;SFISC/MLH-COMMAND UTILS ;10:09 AM  29 Jun 1994
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
COM ;Command line prompt
 D:$G(@DDSREFT@("HLP"))>0 HLP^DDSMSG()
 K DTOUT
 I DDSSC>1!$G(DDSSEL)!$P(DDSSC(DDSSC),U,4) D
 . S DIR(0)="SO^c:CLOSE;r:REFRESH;"
 . S DIR("?",1)="Close     Refresh"
 . S DIR("B")="Close"
 E  D
 . S DIR(0)="SO^e:EXIT"_$S($D(DDSFDO)[0:";s:SAVE",1:"")_$S(DDSNP]"":";n:NEXT PAGE",1:"")_";r:REFRESH;"
 . S DIR("?",1)="Exit     "_$S($D(DDSFDO)[0:"Save     ",1:"")_$S(DDSNP]"":"Next Page     ",1:"")_"Refresh"
 S DIR("A")="COMMAND:",DIR("?",2)=" ",DIR("?")="Enter a command or '^' followed by a caption to jump to a specific field."
 S DIR("??")="^D CHLP^DDSCOM"
 D:'$G(DDSKM)
 . K DDH,DDQ
 . S DDH=3
 . S DDH(1,"T")=DIR("?",1),DDH(2,"T")=DIR("?",2),DDH(3,"T")=DIR("?")
 . D SC^DDSU
 S DDM=1 K DDSKM
 S DIR0=IOSL-1_U_($L(DIR("A"))+1)_"^30^"_(IOSL-1)_"^0"
 D ^DIR K DIR,DUOUT,DIROUT,DIRUT
 D:X="Close"
 . S:DDACT="N" Y="c"
 . S Y(0)="CLOSE"
 . S:DDACT'="N" (X,Y,Y(0))=""
 Q
CHLP ;
 K DDH,DDQ
 S DDH=0,DDS3CD=$P(DIR(0),U,2)
 F DDS3PC=1:1:$L(DDS3CD,";") D
 . S DDS3C=$C($A($P($P(DDS3CD,";",DDS3PC),":"))-32)
 . I "^E^C^S^N^R^"[(U_DDS3C_U) D
 .. S DDH=DDH+1
 .. S DDH(DDH,"T")=$P($T(@("H"_DDS3C)),";",3,999)
 D:DDH>0 SC^DDSU
 K DDS3C,DDS3CD,DDS3PC
 Q
HE ;;Exit       - Exit the form.
HC ;;Close      - Close the window and return to the previous level.
HS ;;Save       - Save all changes made during the edit session.
HN ;;Next Page  - Go to the next page.
HR ;;Refresh    - Repaint the screen.
