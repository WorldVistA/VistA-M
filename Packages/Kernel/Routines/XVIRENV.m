XVIRENV ;SFISC/RSD - enviroment check for Virgin Install; 16 Feb 95 09:45
 ;;8.0;KERNEL - VIRGIN INSTALL;;Jul 10, 1995
 ;if file 200 doesn't exist, quit.
 Q:'$D(^DD(200,0))
 ;don't install
 S XPDQUIT=1
 Q
