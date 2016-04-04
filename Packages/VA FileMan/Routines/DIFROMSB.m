DIFROMSB ;SCISC/DCL-SILENT DIFROM/INSTALL BLOCKS ;08:35 AM  22 Nov 1994
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 Q
BLKSIN(DIFRNAME,DIFRFLG,DIFRSA,DIFRMSGR) ;
 ;PACKAGE_NAME,FLAGS,SOURCE_ROOT,MSG_ROOT
 ;*
 ;PACKAGE_NAME=Package Name
 ;    (Required if Source Root is not passed) - Identifies the
 ;                 unique key subscript in the transport structure.
 ;*
 ;FLAGS=O
 ;    (Optional) - "O"=use Old calls (DIC)
 ;*
 ;SOURCE_ROOT=Source Array Root
 ;    (Optional) - Closed array reference which contain all the
 ;                 Blocks that are to be installed.
 ;    (Note) - Required if Package_Name is not passed.
 ;*
 ;MSG_ROOT=Closed Root for Error Messages
 ;    (Optional) - Array where messages such as errors will be
 ;                 returned.  If not passed, decendents of the ^TMP
 ;                 will be used.
 ;*
 I $G(DIFRNAME)=""&($G(DIFRSA))="" D ERR("PACKAGE NAME/SOUCE ROOT") Q
 N DIFRFILE,DIFRDA,DIFROLD,DIFRX,DIFRY,DIC,DA,DLAYGO,X,Y
 S DIFRFILE=.404,DIFRDA=0
 I $G(DIFRSA)="" S DIFRSA=$NA(^XTMP("XPDI",DIFRNAME,"KRN"))
 S DIFROLD=$G(DIFRFLG)["O"
 I DIFROLD S DLAYGO=DIFRFILE,DIC="^DIST(.404,",DIC(0)="LX" D  Q
 .F  S DIFRDA=$O(@DIFRSA@(.404,DIFRDA)) Q:DIFRDA'>0  S DIFRX=^(DIFRDA,0) D
 ..S X=$P(DIFRX,"^"),DIFRFL=$P(DIFRX,"^",2)
 ..K DA
 ..D ^DIC
 ..I Y>0 S DIFRY=Y D DELADD Q
 ..N DIFRERR S DIFRERR(1)=$P(DIFRX,"^")
 ..D BLD^DIALOG(9517,.DIFRERR)
 ..Q
 ; CODE FOR NEW CALLS                                           <<<***
 G EXIT
 Q
DELADD ;
 K ^DIST(.404,+DIFRY),DA,DIK
 M ^DIST(.404,+DIFRY)=@DIFRSA@(.404,DIFRDA)
 S DIK="^DIST(.404,",DA=+DIFRY
 D IX1^DIK
 I '$D(DD(+DIFRFL)) D
 .N DIFRERR S DIFRERR(1)=$P(DIFRX,"^"),DIFRERR(2)=DIFRFL
 .D BLD^DIALOG(9518,.DIFRERR)
 .Q
 Q
 ;
ERR(X) S X(1)=X D BLD^DIALOG(202,.X)
 Q
EXIT I $G(DIFRMSGR)]"" D CALLOUT^DIEFU(DIFRMSGR)
 Q
