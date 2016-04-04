DINIT26 ;SFISC/XAK-INITIALIZE VA FILEMAN ;10:47 AM  13 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**999**
 ;
 F I=1:2 S X=$T(Q+I) G ^DINIT260:X="" S Y=$E($T(Q+I+1),5,999),X=$E(X,4,999),@X=Y
Q Q
 ;;^DIC(1.11,0,"GL")
 ;;=^DIAR(1.11,
 ;;^DIC("B","ARCHIVAL ACTIVITY",1.11)
 ;;=
 ;;^DIC(1.11,"%D",0)
 ;;=^^1^1^2930712^
 ;;^DIC(1.11,"%D",1,0)
 ;;=This file stores information and status of data archiving activities.
 ;;^DD(1.11,0)
 ;;=FIELD^^16^23
 ;;^DD(1.11,0,"DT")
 ;;=2920514
 ;;^DD(1.11,0,"ID",1)
 ;;=W "   ",$O(^DD(+$P(^(0),U,2),0,"NM",0)),$E(^DIAR(1.11,Y,0),0)
 ;;^DD(1.11,0,"ID",4)
 ;;=W ?40,$$NAKED^DIUTL("$$DATE^DIUTL($P(^(0),U,5))")
 ;;^DD(1.11,0,"ID",7)
 ;;=W "   ",$P($P($C(59)_$S($D(^DD(1.11,7,0)):$P(^(0),U,3),1:0),$C(59)_$P(^DIAR(1.11,Y,0),U,8)_":",2),$C(59),1)
 ;;^DD(1.11,0,"ID",8)
 ;;=S %I=Y,Y=$S('$D(^(0)):"",$D(^VA(200,+$P(^(0),U,9),0))#2:$P(^(0),U,1),1:""),C=$P($G(^DD(200,.01,0)),U,2) D:C]"" Y^DIQ:Y]"" W "   SELECTOR:",Y,@("$E("_DIC_"%I,0),0)") S Y=%I K %I
 ;;^DD(1.11,0,"ID",16)
 ;;=W "   ",@("$P($P($C(59)_$S($D(^DD(1.11,16,0)):$P(^(0),U,3),1:0)_$E("_DIC_"Y,0),0),$C(59)_$P(^(0),U,17)_"":"",2),$C(59),1)")
 ;;^DD(1.11,0,"NM","ARCHIVAL ACTIVITY")
 ;;=
 ;;^DD(1.11,.01,0)
 ;;=ARCHIVE NUMBER^RNJ7,0^^0;1^K:+X'=X!(X>9999999)!(X<1)!(X?.E1"."1N.N) X
 ;;^DD(1.11,.01,1,0)
 ;;=^.1
 ;;^DD(1.11,.01,1,1,0)
 ;;=1.11^B
 ;;^DD(1.11,.01,1,1,1)
 ;;=S ^DIAR(1.11,"B",$E(X,1,30),DA)=""
 ;;^DD(1.11,.01,1,1,2)
 ;;=K ^DIAR(1.11,"B",$E(X,1,30),DA)
 ;;^DD(1.11,.01,3)
 ;;=Type a Number between 1 and 9999999, 0 Decimal Digits
 ;;^DD(1.11,1,0)
 ;;=FILE^RP1'^DIC(^0;2^Q
 ;;^DD(1.11,1,1,0)
 ;;=^.1
 ;;^DD(1.11,1,1,1,0)
 ;;=1.11^C
 ;;^DD(1.11,1,1,1,1)
 ;;=S ^DIAR(1.11,"C",$E(X,1,30),DA)=""
 ;;^DD(1.11,1,1,1,2)
 ;;=K ^DIAR(1.11,"C",$E(X,1,30),DA)
 ;;^DD(1.11,1,3)
 ;;=Enter the file that this archival activity will effect.
 ;;^DD(1.11,2,0)
 ;;=SEARCH TEMPLATE^RP.401^DIBT(^0;3^Q
 ;;^DD(1.11,2,3)
 ;;=Enter the name of the sort/search template that you wish to use.
 ;;^DD(1.11,3,0)
 ;;=PRINT TEMPLATE^R*P.4'X^DIPT(^0;4^S DIC("S")="I $P(^(0),U,8)="_$S($D(DIAX):2,1:1)_",$P(^(0),U,4)=$P(^DIAR(1.11,DA,0),U,2)",DIC(0)="QE",D="F"_+$P(^DIAR(1.11,DA,0),U,2) D IX^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 ;;^DD(1.11,3,3)
 ;;=Enter the name of the FILEGRAM OR EXTRACT print template that you wish to use.
 ;;^DD(1.11,3,12)
 ;;=Select a print template in Filegram or Extract Format.
 ;;^DD(1.11,3,12.1)
 ;;=S DIC("S")="I $P(^(0),U,8)="_$S($D(DIAX):2,1:1)_",$P(^(0),U,4)=$P(^DIAR(1.11,DA,0),U,2)"
 ;;^DD(1.11,3,"DT")
 ;;=2920514
 ;;^DD(1.11,4,0)
 ;;=SELECT DATE^RD^^0;5^S %DT="ET" D ^%DT S X=Y K:Y<1 X
 ;;^DD(1.11,4,3)
 ;;=Enter the select date of this archival activity.
 ;;^DD(1.11,5,0)
 ;;=ARCHIVER^P200'^VA(200,^0;6^Q
 ;;^DD(1.11,5,3)
 ;;=Enter the name of the user that is doing the archiving.
 ;;^DD(1.11,6,0)
 ;;=NUMBER OF ITEMS TO ARCHIVE^RNJ7,0^^0;7^K:+X'=X!(X>9999999)!(X<0)!(X?.E1"."1N.N) X
 ;;^DD(1.11,6,3)
 ;;=Type a Number between 0 and 9999999, 0 Decimal Digits
 ;;^DD(1.11,7,0)
 ;;=ARCHIVAL STATUS^S^1:SELECTED;2:EDITED;4:ARCHIVED (TEMPORARY);5:ARCHIVED (PERMANENT);6:UPDATED DESTINATION FILE;90:PURGED;^0;8^Q
 ;;^DD(1.11,7,"DT")
 ;;=2920511
 ;;^DD(1.11,8,0)
 ;;=SELECTOR^P200'^VA(200,^0;9^Q
 ;;^DD(1.11,9,0)
 ;;=PURGER^P200'^VA(200,^0;10^Q
 ;;^DD(1.11,10,0)
 ;;=ARCHIVE DATE^D^^0;11^S %DT="E" D ^%DT S X=Y K:Y<1 X
 ;;^DD(1.11,11,0)
 ;;=PURGE DATE^D^^0;12^S %DT="E" D ^%DT S X=Y K:Y<1 X
