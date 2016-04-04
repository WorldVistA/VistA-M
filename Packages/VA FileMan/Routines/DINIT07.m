DINIT07 ;ISCSF/DPC - PACKAGE AND DATA-DICTIONARY-AUDIT FILE PRINT TEMPLATES;9OCT2005
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**1021**
 ;
 F I=1:2 S X=$T(ENTRY+I) G:X="" ^DINIT08 S Y=$E($T(ENTRY+I+1),5,999),X=$E(X,4,999),@X=Y
 Q
ENTRY ;
 ;;^DIPT(.941,0)
 ;;=DI-PKG-DEFAULT-DEFINITION^2930111.1405^@^9.4^^@^2930111
 ;;^DIPT(.941,"DXS",1,9.2)
 ;;=S DIP(1)=$S($D(^DIC(9.4,D0,4,D1,223)):^(223),1:"") S X=$E(DIP(1),1,245)]"",DIP(2)=X S X="Update screen: "_$E(DIP(1),1,245),DIP(3)=X S X=1,DIP(4)=X S X=""
 ;;^DIPT(.941,"F",1)
 ;;=6,S DIP(1)=$S($D(^DIC(9.4,D0,4,D1,0)):^(0),1:"") S X=$P(DIP(1),U,1),X=X W X K DIP;"FILE #";L10;Z;"INTERNAL(FILE)"~6,.01;L27~6,222.1;"UP DATE THE DD"~
 ;;^DIPT(.941,"F",2)
 ;;=6,222.2;"VER SION #"~6,222.4;"USER OVER RIDE DD"~6,222.7~6,222.8;"MERGE OR OVER WRITE";L4~6,222.9;"USER OVER RIDE DATA"~
 ;;^DIPT(.941,"F",3)
 ;;=6,X DXS(1,9.2) S X=$S(DIP(2):DIP(3),DIP(4):X) K DIP;C13;W66;"";Z;"$S(#223]"":"Update screen: "_#223,1:"")"~
 ;;^DIPT(.941,"F",4)
 ;;="Environment Check Routine          :";S1;C6~913;"";C42~"Pre-Init After User Commit Routine :";C6~916;C42;""~"Post-Initialization Routine        :";C6~
 ;;^DIPT(.941,"F",5)
 ;;=914;"";C42~
 ;;^DIPT(.941,"H")
 ;;=PACKAGE DEFAULT DEFINITION
 ;;^DIPT(.61,0)
 ;;=DIAUTL^3030321.1238^@^.6^1^@^3051008
 ;;^DIPT(.61,"DXS",1,9.2)
 ;;=S DIP(1)=$S($D(^DDA(DIA,D0,1)):^(1),1:"") S X=$E(DIP(1),1,245)]"",DIP(2)=$G(X) S X="FROM: "_$E(DIP(1),1,245),DIP(3)=$G(X) S X=1,DIP(4)=$G(X) S X=""
 ;;^DIPT(.61,"F",1)
 ;;=W $S($G(DIA):$S($D(^DD(DIA,+^DDA(DIA,D0,0),0)):$P(^(0),U),1:"DELETED FIELD "_+^DDA(DIA,D0,0)),1:"XX") S X="";L23;Z;"W $S($G(DIA):$P(^DD(DIA,+^DDA(DIA,D0,0),0),U),1:"XX") S X="""~.05;L20~.03~
 ;;^DIPT(.61,"F",2)
 ;;=S DIP(1)=$S($D(^DDA(DIA,D0,0)):^(0),1:"") S X=$P(DIP(1),U,4),X=X W X K DIP;"";R4;Z;"INTERNAL(USER)"~
 ;;^DIPT(.61,"F",3)
 ;;=X DXS(1,9.2) S X=$S(DIP(2):DIP(3),DIP(4):X) W X K DIP;C2;Z;"$S(#1]"":"FROM: "_#1,1:"")"~
 ;;^DIPT(.61,"F",4)
 ;;=S DIP(1)=$S($D(^DDA(DIA,D0,2)):^(2),1:"") S X="TO: "_$E(DIP(1),1,245) W X K DIP;C4;Z;""TO: "_#2"~
