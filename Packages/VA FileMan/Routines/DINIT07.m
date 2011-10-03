DINIT07 ;ISCSF/DPC - PACKAGE FILE PRINT TEMPLATE ;6/30/94  13:34
 ;;22.0;VA FileMan;;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
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
