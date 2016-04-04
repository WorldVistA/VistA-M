DINIT3 ;SFISC/GFT-INITIALIZE VA FILEMAN ;28AUG2008
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1008,1033**
 ;
 S ^DIC(.2,0)="DESTINATION^.21^",^(0,"GL")="^DIC(.2,"  S ^DIC(.5,0)="FUNCTION^.5I",^(0,"GL")="^DD(""FUNC"",",(^("LAYGO"),^("WR"))="@",^("DD")=U
 S ^DIC(.2,"%D",0)="^^2^2^2940908^"
 S ^DIC(.2,"%D",1,0)="This file stores destinations of data (e.g., a specific form or"
 S ^DIC(.2,"%D",2,0)="system).  A field can be associated with a destination of its data."
 S $P(^DIC(1.1,0),U,1,2)="AUDIT^1.1",^(0,"GL")="^DIA(" D A1
 S ^DIC(1.1,"%D",0)="^^1^1^2940908^"
 S ^DIC(1.1,"%D",1,0)="This file stores an audit trail of changes made to data fields."
 S $P(^DIAR(1.11,0),U,1,2)="ARCHIVAL ACTIVITY^1.11I",$P(^DIC(1.11,0),U,1,2)="ARCHIVAL ACTIVITY^1.11I",^(0,"GL")="^DIAR(1.11," D A1
 S $P(^DIAR(1.12,0),U,1,2)="FILEGRAM HISTORY^1.12DI",$P(^DIC(1.12,0),U,1,2)="FILEGRAM HISTORY^1.12DI",^(0,"GL")="^DIAR(1.12," D A1
 S $P(^DIAR(1.13,0),U,1,2)="FILEGRAM ERROR LOG^1.13",$P(^DIC(1.13,0),U,1,2)="FILEGRAM ERROR LOG^1.13",^(0,"GL")="^DIAR(1.13," D A1
 S $P(^DDA(0),U,1,2)="DD AUDIT^.6I",^DIC(.6,0,"GL")="^DDA(" D A1
 D A2("FORM",.403,"I")
 D A2("BLOCK",.404)
 S $P(^DIST(1.2,0),U,1,2)="ALTERNATE EDITOR^1.2",^DIC(1.2,0)="ALTERNATE EDITOR^1.2",^(0,"GL")="^DIST(1.2," D A1
 S $P(^DI(.81,0),U,1,2)="DATA TYPE^.81",^DIC(.81,0)="DATA TYPE^.81",^(0,"GL")="^DI(.81," D A1
 S $P(^DIST(.44,0),U,1,2)="FOREIGN FORMAT^.44I",^DIC(.44,0)="FOREIGN FORMAT^.44",^(0,"GL")="^DIST(.44," D A1
 S $P(^DI(.83,0),U,1,2)="COMPILED ROUTINE^.83",$P(^DIC(.83,0),U,1,2)="COMPILED ROUTINE^.83",^(0,"GL")="^DI(.83," D A1
 D A2("INDEX",.11,"I")
 D A2("KEY",.31)
 D A2("IMPORT TEMPLATE",.46,"IA")
 D A2("SQLI_SCHEMA",1.521,"A")
 D A2("SQLI_KEY_WORD",1.52101,"O")
 D A2("SQLI_DATA_TYPE",1.5211,"A")
 D A2("SQLI_DOMAIN",1.5212,"AO")
 D A2("SQLI_KEY_FORMAT",1.5213,"AO")
 D A2("SQLI_OUTPUT_FORMAT",1.5214,"AO")
 D A2("SQLI_TABLE",1.5215,"A")
 D A2("SQLI_TABLE_ELEMENT",1.5216,"A")
 D A2("SQLI_COLUMN",1.5217,"PO")
 D A2("SQLI_PRIMARY_KEY",1.5218,"PA")
 D A2("SQLI_FOREIGN_KEY",1.5219,"PO")
 D A2("SQLI_ERROR_TEXT",1.52191)
 D A2("SQLI_ERROR_LOG",1.52192)
 S D=0 F I="^DIPT(","^DIBT(","^DIE(" S X=$P("PRINT^SORT^INPUT",U,D+1)_" TEMPLATE",Y=D/1000+.4,^DD(Y,0,"NM",X)="",^DD(Y,.01,1,1,0)=Y_"^B",@("$P("_I_"0),U,1,2)=X_U_Y_""I"""),^DIC(Y,0)=X_"^"_Y,^(0,"GL")=I,D=D+1,^("WR")=U,^("DD")=U,^DIC("B",X,Y)=""
 ;
DIK F I=.2,.4,.5,.6,.7,.601,.602,.401,.4001,.4011,.4012,.402,.4021,.4011624,.41,.411,.21,1,1.005,1.01,1.1,1.11,1.113,1.1132,1.12,1.13,1.1321,1.14,.403,.4031,.403115,.40315,.4032,.404,.40415,.4044,1.2,1.207,.44,.441,.4411,.447,.448,.42,.81 D XX
 F I=.4014,.40141,.401418,.401419,.83,.404421 D XX
 F I=.11,.111,.112,.114,.31,.312 D XX
 F I=.46,.461,.463 D XX
 F I=1.521,1.52101,1.5211,1.5212,1.5213,1.5214,1.5215,1.5216,1.5217,1.5218,1.5219,1.52191,1.52192 D XX
 F DIK="^DIC(.2,","^DIPT(","^DIST(1.2,","^DIST(.44,","^DI(.81,","^DIST(.403,","^DIST(.404,","^DIST(.46,","^DI(.85,","^DD(""IX"",","^DD(""KEY""," D X
 I $D(^DD("VERSION"))#2 K ^DIC("B") S DIK="^DIC(",DIK(1)=".01^B" D ENALL^DIK
 I '$D(^DD("VERSION"))#2 F DIK="^DIC(","^DIBT(","^DIE(" D X
 S ^DD("FUNC",0)="FUNCTION^.5^"
 I $D(^DD("FUNC",7,1)),$D(^DD("VERSION")),^("VERSION")>15.4
 E  S ^DD("FUNC",7,1)="C X S X="""""
 G ^DINIT4
 ;
XX S DA(1)=I,DIK="^DD("_I_","
X W ".." G IXALL^DIK
 ;
A S (^("RD"),^("LAYGO"),^("WR"),^("DD"))=U Q
A1 S (^("DEL"),^("LAYGO"),^("WR"),^("DD"))=U Q
A2(NAM,NUM,SP) ;
 S $P(@(^DIC(NUM,0,"GL")_"0)"),U,1,2)=NAM_U_NUM_$G(SP)
 S ^DIC(NUM,0)=NAM_U_NUM,(^(0,"DEL"),^("LAYGO"),^("WR"),^("DD"))=U
 Q
 ;
