DIU20 ;SFISC/GFT-SCREEN-EDIT FILE ;11JUN2010
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**8,82,1039**
 ;
 ;
 ;from DIU0 -- DA=FILE NUMBER
 N DR
 S DDSFILE=1,DR="[DIEDIT]"
 D ^DDS
 Q
 ;
PRE ;
 I DUZ(0)'="@" D
 .F I=9.5,10,11,12 D UNED ;non-programmer cannot put in SCREEN, ACTION, LOOKUP, or CROSS-REF ROUTINE
 .F I=2:1:7 D
 ..S X=$G(^DIC(DA,0,$P("^DD^RD^WR^DEL^LAYGO^AUDIT",U,I)))
 ..I X]"",$TR(X,DUZ(0))=X D UNED
 D:'$D(DISYS) OS^DII I $G(^DD("OS",DISYS,18))="" F I=11,12 D UNED
 Q
 ;
UNED D UNED^DDSUTL(I,"DIEDIT",1,1)
 Q
 ;
ACCVAL(X) ;
 I DUZ(0)'="@",$TR(X,DUZ(0))]"" S DDSERROR=1 D HLP^DDSUTL("MUST MATCH YOUR OWN ACCESS CODE") Q
 I (X["?") S DDSERROR=1 D HLP^DDSUTL("CANNOT CONTAIN '?'") Q
 Q
 ;
POST ;
 N I,NAMENOW,ROOT,SP
MAYBGONE Q:'$G(DA)
 S NAMENOW=$P(^DIC(DA,0),U) ;has FILE NAME changed?
 S X=$$G(.2) I X="" G KILLFILE
 S ROOT=^DIC(DA,0,"GL")_"0)",SP=$P(@ROOT,U,2)
 I X'=NAMENOW K I D PUT^DDSVAL(1,DA,.01,X,.I) Q:$D(I)>1  D
 .S $P(@ROOT,U)=X
 .K ^DD(DA,0,"NM") S ^("NM",X)=""
 F I=2:1:7 D  ;handle the 6 ACCESS CODEs
 .S X=$$G(I)
 .S ^DIC(DA,0,$P("^DD^RD^WR^DEL^LAYGO^AUDIT",U,I))=X
 ;S X=$$G(8) S ^DD(D0,0,"DDA")=$E("NY",X+1)
 S X=$$G(9),SP=$TR(SP,"O")_$E("O",X) ;'ASK OK'?'
 S X=$$G(9.5),^DD(DA,0,"SCR")=X,SP=$TR(SP,"s") I X="" K ^("SCR")
 E  S SP=SP_"s"
 S $P(@ROOT,U,2)=SP
ACTION S X=$$G(10),^DD(DA,0,"ACT")=X I X="" K ^("ACT")
 S X=$$G(11),^DD(DA,0,"DIC")=X I X="" K ^("DIC")
 D:$G(^DD(DA,0,"DIK"))]"" QA^DIU21
 S X=$$G(12) I X]"" D
 .N DMAX,DIR,DICMP,DIKPGM,Y
 .S Y=DA,DMAX=^DD("ROU") D EN^DIKZ
 Q
 ;
G(I) Q $$GET^DDSVALF(I,"DIEDIT",1)
 ;
DIU S DIU=^DIC(DA,0,"GL"),DIU(0)="EDT" Q
 ;
KILLFILE ;
 N DIK,DIC,DQ,DIER,A,DIU
 S DIC="^DIC("
 D DIU F DIK=0:0 S DIK=$O(^DD(1,.01,"DEL",DIK)) Q:'DIK  I $D(^(DIK,0)) X ^(0) I  S DDSERROR=1,DDSBR=.2 D PUT^DDSVALF(.2,"DIEDIT",1,NAMENOW) H 3 G Q ;DELETE logic
 S A=DA,DIK="^DIC(" D
 .N A,DIU D ^DIK ;kill off the File 1 entry
 D 61^DIU0
Q Q
 ;
TEST ;
 S DIC=1,DIC(0)="AEQM" D ^DIC Q:Y<0  S DA=+Y G DIU20
