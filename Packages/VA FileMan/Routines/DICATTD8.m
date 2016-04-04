DICATTD8 ;SFISC/GFT;12:19 PM  13 Dec 2001;VARIABLE POINTER FIELDS
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**44,42,83**
 ;
GET ;
 K DICATTVP
 F DA=0:0 S DA=$O(^DD(DICATTA,DICATTF,"V",DA)) Q:'DA  I $D(^(DA,0)) D
 .F DR=1:1:6 S DICATTVP(DA,DR)=$P(^(0),U,DR)
 .I $G(^(1))]"" S DICATTVP(DA,7)=^(1)
 .I $G(^(2))]"" S DICATTVP(DA,8)=^(2)
 Q
 ;
Y(I,J) ;defaults for Page 2.8
 S Y=$G(DICATTVP(I,J)) Q
 ;
PRE8 ;PRE-ACTION for Page 8
 F I=1:1:5 D P(I)
 I $P($G(^DD(+$$GET^DDSVALF(DICATTVP+90,"DICATT8",2.8,""),0,"DI")),U,2)["Y" D PUT(3,"n"),UNED^DDSUTL(3,,,1,"") ;ARCHIVE File can't be LAYGO'd
 Q
 ;
P(FLD) ;
 D PUT(FLD,$G(DICATTVP(DICATTVP,$$V(FLD)))) Q
 ;
V(FLD) Q $E(24678,FLD) ;Field 1 is .02, etc
 ;
DICS ;
 I DUZ(0)'="@" S DIC("S")="I Y-1.1 Q:'$L($G(^(0,""RD""))) I $TR(DUZ(0),^(""RD""))'=DUZ(0)" Q
 S DIC("S")="I Y-1.1"
 Q
 ;
POST8 ;POST-ACTION for Page 8
 N I,Y
 F I=1:1:5 S Y=$$GET^DDSVALF(I,"DICATTVP",8,"",""),DICATTVP(DICATTVP,$$V(I))=Y
 I DICATTVP(DICATTVP,7)="" S DICATTVP(DICATTVP,8)="" ;if no SCREEN, no EXPLANATION
 F I=1:1:5 D PUT(I,"") ;clean out the screen
 S DICATTLN=18 ;so 'IS THIS FIELD MULTIPLE' will be asked  --  a V-P field can be expected to take up 18 bytes of storage
 Q
 ;
G(I) Q $$GET^DDSVALF(I,"DICATT8",2.8,"I","")
 ;
PUT(I,VAL) D PUT^DDSVALF(I,"DICATTVP",8,VAL,"I","") Q
 ;
POSTVP ;
 N I,S,ERR
 D RECALL^DILFD(1,DICATTB_",",DUZ) ;we've looked up other files, so remember this one
 S DICATTMN="",DICATT2N="V",DICATT3N="",DICATT5N=""
 F I=91:1:97 S DICATTVP(I-90,1)=$$G(I)
 F I=91.1:1:97.1 S S=$$G(I) I S]""!$D(DICATTVP(I-90.1,3)) S DICATTVP(I-90.1,3)=S ;ORDER
 F I=0:0 S I=$O(DICATTVP(I)) Q:'I  D  I $D(ERR) Q
 .I '$G(DICATTVP(I,1)) K DICATTVP(I) Q
 .I $D(I(1,DICATTVP(I,1))) S ERR="DUPLICATE FILE NUMBER" Q
 .S I(1,DICATTVP(I,1))=""
 .I $G(DICATTVP(I,2))="" S ERR="MESSAGE REQUIRED" Q
 .I '$G(DICATTVP(I,3)) S ERR="ORDER NUMBER REQUIRED" Q
 .I $D(I(3,DICATTVP(I,3))) S ERR="DUPLICATE ORDER NUMBER" Q
 .S I(3,DICATTVP(I,3))=""
 .I $G(DICATTVP(I,4))="" S ERR="PREFIX REQUIRED" Q
 .I DICATTVP(I,4)["""" S ERR="BAD PREFIX" Q
 .I $D(I(4,DICATTVP(I,4))) S ERR="DUPLICATE PREFIX" Q
 .S I(4,DICATTVP(I,4))=""
 .S S=$G(DICATTVP(I,7))]"",DICATTVP(I,5)=$E("ny",S+1)
 .I S,$G(DICATTVP(I,8))="" S ERR="SCREEN MUST HAVE EXPLANATION" Q
 I '$D(ERR) Q
 S DDSBR=90+I,S(1)="ERROR IN VARIABLE-POINTER SPECIFICATIONS, FILE "_$G(DICATTVP(I,1)),S(2)=ERR,S(3)="$$EOP"
 D HLP^DDSUTL(.S)
 Q
 ;
FILE ;come here from ^DICATTDE
 N I,DIK,DA
 F I=0:0 S I=$O(^DD(DICATTA,DICATTF,"V","B",I)) Q:'I  K ^DD(+I,0,"PT",DICATTA,DICATTF) ;delete old POINTED-TOs
 K ^DD(DICATTA,DICATTF,"V") ;all other cross_references are with the subfile
 I $G(DICATT2N)'["V" Q  ;stop now if field is no longer V-P!
 S DA=0 F I=1:1 S DA=$O(DICATTVP(DA)) Q:'DA  D
 .S DICATTVP(DA,5)=$E("ny",$G(DICATTVP(DA,7))]""+1)
 .F DIK=1:1:6 S $P(^DD(DICATTA,DICATTF,"V",I,0),U,DIK)=$G(DICATTVP(DA,DIK))
 .F DIK=7,8 I $D(DICATTVP(DA,DIK)) S ^(DIK-6)=DICATTVP(DA,DIK)
 S ^DD(DICATTA,DICATTF,"V",0)="^.12P^",DA(2)=DICATTA,DA(1)=DICATTF
 S DIK="^DD("_DICATTA_","_DICATTF_",""V""," D IXALL^DIK
 Q
