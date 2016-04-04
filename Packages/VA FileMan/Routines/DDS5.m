DDS5 ;SFISC/MKO-MULTS,NEXT/PREV PAGE,NEXT BLOCK ;9:53 AM  1 Oct 1999
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**8**
 ;
 I X="" D:DDSOLD="" NF^DDS01 D:DDSOLD]"" DM^DDS6 Q
 I DIR0N,$D(DUZ)#2 S ^DISV(DUZ,$E(DDSGL,1,28))=$E(DDSGL,29,999)_X
 I $G(@DDSREFS@("ASUB",DDSPG,DDSBK,DDO))]"" S DDS5PG=^(DDO)
 E  I $P($G(DDSO(7)),U,2)="" D:X=DDSOLD NF^DDS01 Q
 D MULT,R^DDSR
 ;
 K DDSSTACK
 X:$G(^DIST(.404,DDSBK,40,DDO,10))'?."^" ^(10)
 I $D(DDSSTACK) D ^DDSSTK,R^DDS3 K DDSBR
 D:$D(DDSBR)#2 BR^DDS2
 Q
MULT ;
 N DIE,DDO,DDSBK,DDSDN,DDSNP,DDSOPB,DDSPG,DDSPTB,DDSREP,DDSTP
 ;
 I $G(DDS5PG) S DDSPG=DDS5PG K DDS5PG
 E  D
 . S DDSPG(1)=$P($G(DDSO(7)),U,2) Q:DDSPG(1)=""
 . S DDSPG=$O(^DIST(.403,+DDS,40,"B",DDSPG(1),"")) Q:DDSPG=""
 Q:$D(^DIST(.403,+DDS,40,+$G(DDSPG),0))[0
 N:'$P(^(0),U,6) DDSSC
 ;
 D DDA(Y,.DA,.DDSDL)
 I Y'=-1 D
 . N DDP,DDSDA,DDSFLD,DDSDLORG,DDSDAORG,DDSFLORG
 . S DIE=U_$P(DDSU("M"),U,2),DDP=$P(DDSU("M"),U,3)
 . S DDSDLORG=DDSDL,DDSDAORG=DA,DDSDA=DA_","
 . F DDSI=1:1:DDSDL S DDSDAORG(DDSI)=DA(DDSI),DDSDA=DDSDA_DA(DDSI)_","
 . K DDSI
 . S DDSSTK=1
 . D PROC^DDS
 D LST(.DA,.DDSDL,DDP,DDSDA,DDSFLD)
 D UDA(.DA,.DDSDL)
 Q
 ;
LST(DA,DDSDL,DDP,DDSDA,DDSFLD) ;Save last edited subrecord
 ;In:  DA array, DDSDL      at subfile level
 ;     DDP, DDSDA, DDSFLD   at file level
 N DDSDIE,Y
 S DDSDIE=U_$P(@DDSREFT@("F"_DDP,DDSDA,DDSFLD,"M"),U,2)
 I $D(@(DDSDIE_"+$G(DA),0)"))[0 D
 . S DA=$S($D(@(DDSDIE_"0)"))#2:$P(^(0),U,3),1:$O(^(0)))
 . I DA>0 D
 .. N C
 .. S Y=$P(@(DDSDIE_DA_",0)"),U)
 .. S C=$P(^DD(+$P(^DD(DDP,DDSFLD,0),U,2),.01,0),U,2)
 .. D Y^DIQ
 . E  S (DA,Y)=""
 E  S (DA,Y)=""
 I DA>0,$D(DUZ)#2 S ^DISV(DUZ,$E(DDSDIE,1,28))=$E(DDSDIE,29,999)_DA
 ;
 S @DDSREFT@("F"_DDP,DDSDA,DDSFLD,"X")=Y,^("D")=DA,DDACT="N"
 Q
 ;
SEL ;Issue the read at the Select mult prompt
 S DIR(0)="PO"_DDSGL_":QEMZ"_$E("L",'$D(DDSTP)&'$P($G(DDSO(4)),U,5))_$E("V",$P($G(DDSO(4)),U,6))
 I $D(@(DDSGL_"0)"))[0 S ^(0)=U_$P($G(DDSU("DD")),U,2)_U_U
 E  I $P(@(DDSGL_"0)"),U,2)'=$P($G(DDSU("DD")),U,2) S $P(^(0),U,2)=$P($G(DDSU("DD")),U,2)
 D DDA(0,.DA,.DDSDL) S DDSDA="0,"_DDSDA
 D ^DIR K DIR,DUOUT,DIRUT,DIROUT
 D UDA(.DA,.DDSDL) S DDSDA=$P(DDSDA,",",2,999)
 Q:DDACT'="N"
 ;
 I DIR0N S (X,Y)=DDSOLD Q
 I $P(Y,U,3)=1 S ^("ADD")=$G(@DDSREFT@("ADD"))+1,^("ADD",^("ADD"))=+Y_","_DDSDA_DDSGL
 E  S DIR0N=1
 S Y=$P(Y,U)
 S:X="" Y=""
 Q
 ;
DDA(Y,DA,DL) ;Push Y onto DA array
 N I
 F I=DL:-1:1 S DA(I+1)=DA(I)
 S DA(1)=DA,DL=DL+1
 S (DA,@("D"_DL))=$S(+$P($G(Y),"E"):+$P(Y,"E"),1:0)
 Q
 ;
UDA(DA,DL) ;Pop DA array
 N I
 S DA=DA(1)
 F I=2:1:DL S DA(I-1)=DA(I)
 K DA(DL),@("D"_DL)
 S DL=DL-1
 Q
NP(Y) ;Returns: Next page
 ;         (Y=1 if found, 0 if not found)
 N P,P1
 S Y=0,P1=$P($G(^DIST(.403,+DDS,40,DDSPG,0)),U,4)
 I P1]"" D
 . S P=$O(^DIST(.403,+DDS,40,"B",P1,""))
 . I P,P'=DDSPG,$D(^DIST(.403,+DDS,40,P,0))#2 S Y=1
 Q $S(Y=1:P,1:DDSPG)
PP(Y) ;
 N P,P1
 S Y=0,P1=$P($G(^DIST(.403,+DDS,40,DDSPG,0)),U,5)
 I P1]"" D
 . S P=$O(^DIST(.403,+DDS,40,"B",P1,""))
 . I P,P'=DDSPG,$D(^DIST(.403,+DDS,40,P,0))#2 S Y=1
 Q $S(Y=1:P,1:DDSPG)
NB(Y) ;
 N B,BO,X
 S (B,Y)=0,BO=$P($G(^DIST(.403,+DDS,40,DDSPG,40,DDSBK,0)),U,2)
 I BO F  D  Q:B=DDSBK!Y
 . S BO=$O(^DIST(.403,+DDS,40,DDSPG,40,"AC",BO)) S:'BO BO=$O(^("")) S B=$O(^(BO,""))
 . S X=$G(@DDSREFS@(DDSPG,B))
 . I $P(X,U)]"",$P(X,U,5)'="h",$P(X,U,9),B'=DDSBK S Y=1
 Q B
