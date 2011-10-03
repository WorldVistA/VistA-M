TIUPS235 ; ISL/JER - Post-install for TIU*1*235 ; 08/16/2007
 ;;1.0;TEXT INTEGRATION UTILITIES;**235**;Jun 20, 1997;Build 2
 ;
MAIN ; control subroutine
 D SETID
 Q
SETID ; Create "Write identifier" for file 8925.1
 N TIUID
 D BMES^XPDUTL("CORRECTING ""WRITE"" IDENTIFIER ON FIELD 1501 OF FILE 8925.1")
 S TIUID="S %I=Y,Y=$S('$D(^(15)):"""",$D(^TIU(8926.1,+$P(^(15),U,1),0))#2:$P(^(0),U,1),1:"""") N DIERR S:$L(Y) Y=$$EXTERNAL^DILFD(8926.1,.01,"""",Y,""DIERR"") D:$L(Y) EN^DDIOL(""Std Title: ""_Y,"""",""!?6"") S Y=%I K %I"
 S ^DD(8925.1,0,"ID","W.1501")=TIUID
 Q
