DIPKI007 ;VEN/TOAD-PACKAGE FILE INIT ; 04-JAN-2015
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,"DIBT",914,0)
 ;;=THROW ME AWAY 2^3121120.1446^@^9.4^16^@^3121120
 ;;^UTILITY(U,$J,"DIBT",914,2,0)
 ;;=^.4014^2^2
 ;;^UTILITY(U,$J,"DIBT",914,2,1,0)
 ;;=9.4^.01^NAME^^^^^^^4
 ;;^UTILITY(U,$J,"DIBT",914,2,1,"F")
 ;;=@z^A
 ;;^UTILITY(U,$J,"DIBT",914,2,1,"GET")
 ;;=S DISX(1)=$P($G(^DIC(9.4,D0,0)),U)
 ;;^UTILITY(U,$J,"DIBT",914,2,1,"IX")
 ;;=^DIC(9.4,"B",^DIC(9.4,^2
 ;;^UTILITY(U,$J,"DIBT",914,2,1,"LANG")
 ;;=NAME
 ;;^UTILITY(U,$J,"DIBT",914,2,1,"QCON")
 ;;=I DISX(1)]]"@z"
 ;;^UTILITY(U,$J,"DIBT",914,2,1,"T")
 ;;=z^
 ;;^UTILITY(U,$J,"DIBT",914,2,1,"TXT")
 ;;=NAME from A
 ;;^UTILITY(U,$J,"DIBT",914,2,2,0)
 ;;=9.4^1^PREFIX^^^^^^^4
 ;;^UTILITY(U,$J,"DIBT",914,2,2,"GET")
 ;;=S DISX(2)=$P($G(^DIC(9.4,D0,0)),U,2)
 ;;^UTILITY(U,$J,"DIBT",914,2,2,"IX")
 ;;=^DIC(9.4,"C",^DIC(9.4,^2
 ;;^UTILITY(U,$J,"DIBT",914,2,2,"LANG")
 ;;=PREFIX
 ;;^UTILITY(U,$J,"DIBT",914,2,2,"QCON")
 ;;=I DISX(2)'=""
 ;;^UTILITY(U,$J,"DIBT",914,2,2,"TXT")
 ;;= PREFIX not null
 ;;^UTILITY(U,$J,"DIBT",914,2,"B",9.4,1)
 ;;=
 ;;^UTILITY(U,$J,"DIBT",914,2,"B",9.4,2)
 ;;=
 ;;^UTILITY(U,$J,"DIPT",.941,0)
 ;;=DI-PKG-DEFAULT-DEFINITION^2930111.1405^@^9.4^^@^2930111
 ;;^UTILITY(U,$J,"DIPT",.941,"DXS",1,9.2)
 ;;=S DIP(1)=$S($D(^DIC(9.4,D0,4,D1,223)):^(223),1:"") S X=$E(DIP(1),1,245)]"",DIP(2)=X S X="Update screen: "_$E(DIP(1),1,245),DIP(3)=X S X=1,DIP(4)=X S X=""
 ;;^UTILITY(U,$J,"DIPT",.941,"F",1)
 ;;=6,S DIP(1)=$S($D(^DIC(9.4,D0,4,D1,0)):^(0),1:"") S X=$P(DIP(1),U,1),X=X W X K DIP;"FILE #";L10;Z;"INTERNAL(FILE)"~6,.01;L27~6,222.1;"UP DATE THE DD"~
 ;;^UTILITY(U,$J,"DIPT",.941,"F",2)
 ;;=6,222.2;"VER SION #"~6,222.4;"USER OVER RIDE DD"~6,222.7~6,222.8;"MERGE OR OVER WRITE";L4~6,222.9;"USER OVER RIDE DATA"~
 ;;^UTILITY(U,$J,"DIPT",.941,"F",3)
 ;;=6,X DXS(1,9.2) S X=$S(DIP(2):DIP(3),DIP(4):X) K DIP;C13;W66;"";Z;"$S(#223]"":"Update screen: "_#223,1:"")"~
 ;;^UTILITY(U,$J,"DIPT",.941,"F",4)
 ;;="Environment Check Routine          :";S1;C6~913;"";C42~"Pre-Init After User Commit Routine :";C6~916;C42;""~"Post-Initialization Routine        :";C6~
 ;;^UTILITY(U,$J,"DIPT",.941,"F",5)
 ;;=914;"";C42~
 ;;^UTILITY(U,$J,"DIPT",.941,"H")
 ;;=PACKAGE DEFAULT DEFINITION
 ;;^UTILITY(U,$J,"DIPT",23,0)
 ;;=XU-PKG-DEFAULT-DEFINITION^2890706.1601^^9.4^^^2930423
 ;;^UTILITY(U,$J,"DIPT",23,"DXS",1,9.2)
 ;;=S DIP(1)=$S($D(^DIC(9.4,D0,4,D1,223)):^(223),1:"") S X=$E(DIP(1),1,245)]"",DIP(2)=X S X="Update screen: "_$E(DIP(1),1,245),DIP(3)=X S X=1,DIP(4)=X S X=""
 ;;^UTILITY(U,$J,"DIPT",23,"F",1)
 ;;=6,S DIP(1)=$S($D(^DIC(9.4,D0,4,D1,0)):^(0),1:"") S X=$P(DIP(1),U,1),X=X W X K DIP;"FILE #";L10;Z;"INTERNAL(FILE)"~6,.01;L27~6,222.1;"UP DATE THE DD"~
 ;;^UTILITY(U,$J,"DIPT",23,"F",2)
 ;;=6,222.2;"VER SION #"~6,222.4;"USER OVER RIDE DD"~6,222.7~6,222.8;"MERGE OR OVER WRITE";L4~6,222.9;"USER OVER RIDE DATA"~
 ;;^UTILITY(U,$J,"DIPT",23,"F",3)
 ;;=6,X DXS(1,9.2) S X=$S(DIP(2):DIP(3),DIP(4):X) K DIP;C13;W66;"";Z;"$S(#223]"":"Update screen: "_#223,1:"")"~"Pre-Initialization Routine :";S1;C13~
 ;;^UTILITY(U,$J,"DIPT",23,"F",4)
 ;;=913;"";C42~"Initialization Routine     :";C13~916;C42;""~"Post-Initialization Routine:";C13~914;"";C42~
 ;;^UTILITY(U,$J,"DIPT",23,"H")
 ;;=PACKAGE DEFAULT DEFINITION
 ;;^UTILITY(U,$J,"DIPT",1529,0)
 ;;=THROW ME AWAY^3121120.1459^^9.4^^^3121120
 ;;^UTILITY(U,$J,"DIPT",1529,"F",2)
 ;;=.01~1~
 ;;^UTILITY(U,$J,"DIPT",1529,"H")
 ;;=HOWDY HOWDY HOWDY
 ;;^UTILITY(U,$J,"SBF",9.4,9.4)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.4014)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.402)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.41)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.415007)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.432)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.44)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.45)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.46)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.47)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.48)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.485)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.49)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.4901)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.49011)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.495)
 ;;=
 ;;^UTILITY(U,$J,"SBF",9.4,9.54)
 ;;=
