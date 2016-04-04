DIFROM2 ;SFISC/XAK-CREATES RTN ENDING IN 'INIT1' ;31OCT2012
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 S ^UTILITY($J,2.5,0)=" Q:'$D(DIFQ)  S %=2 W !!,""ARE YOU SURE EVERYTHING'S OK"" D YN^DICN I %-1 K DIFQ Q"
 I $D(^DIC(9.4,DPK,"INI")),$P(^("INI"),U)]"" S ^UTILITY($J,2.6,0)=" D ^"_$P(^("INI"),U)_" D NOW^%DTC S DIFROM(""INI"")=%"
 S ^UTILITY($J,2.7,0)=" I $D(DIFKEP) F DIDIU=0:0 S DIDIU=$O(DIFKEP(DIDIU)) Q:DIDIU'>0  S DIU=DIDIU,DIU(0)=DIFKEP(DIDIU) D EN^DIU2"
 S ^UTILITY($J,3,0)=" D DT^DICRW K ^UTILITY(U,$J),^UTILITY(""DIK"",$J) D WAIT^DICD" K Q
 S ^UTILITY($J,3.1,0)=" S DN=""^"_DN_""" F R=1:1:"_Y_" D @(DN_$$B36(R)) W ""."""
 S X=4,Q=" ;",^UTILITY($J,X,0)=" F  S D=$O(^UTILITY(U,$J,""SBF"","""")) Q:D'>0  K:'DIFQ(D) ^(D) S D=$O(^(D,"""")) I D>0  K ^(D) D IX"
 S DIRS=" K:%<0 DIFQ"
 S E=$E(DTL_"INIT",1,7),DNAME=E_1,D=-9999 F DD=1:1 S X=$E($T(TEXT+DD),4,999) Q:X=""  S ^UTILITY($J,DD+4,0)=X S:DD=19 ^UTILITY($J,DD+4,0)=X_DIRS
 S ^UTILITY($J,1.5,0)="ASK I %=1,$D(DIFQ(0)) W !,""SHALL I WRITE OVER FILE SECURITY CODES"" S %=2 D YN^DICN S DSEC=%=1"_DIRS(1)
 D ZI^DIFROM3 G ^DIFROM3
 Q
TEXT ;
 ;;KEYSNIX ; Keys and new style indexes installer ; new in FM V22.2
 ;; N DIFRSA S DIFRSA=$NA(^UTILITY("KX",$J)) ; Tran global for Keys and Indexes
 ;; N DIFRFILE S DIFRFILE=0 ; Loop through files
 ;; F  S DIFRFILE=$O(@DIFRSA@("IX",DIFRFILE)) Q:'DIFRFILE  D
 ;; . K ^TMP("DIFROMS2",$J,"TRIG")
 ;; . N DIFRD S DIFRD=0
 ;; . F  S DIFRD=$O(@DIFRSA@("IX",DIFRFILE,DIFRD)) Q:'DIFRD  D DDIXIN^DIFROMSX(DIFRFILE,DIFRD,DIFRSA) ; install New Style Indexes
 ;; . K ^TMP("DIFROMS2",$J,"TRIG")
 ;; . S DIFRD=0
 ;; . F  S DIFRD=$O(@DIFRSA@("KEY",DIFRFILE,DIFRD)) Q:'DIFRD  D DDKEYIN^DIFROMSY(DIFRFILE,DIFRD,DIFRSA) ; install keys
 ;; K @DIFRSA ; kill off tran global
 ;; ; VEN/SMH v22.2: Below I added a K D1 because it leaks from the call causing the key matching algo to fail.
 ;;DATA W "." S (D,DDF(1),DDT(0))=$O(^UTILITY(U,$J,0)) Q:D'>0
 ;; I DIFQR(D) S DTO=0,DMRG=1,DTO(0)=^(D),Z=^(D)_"0)",D0=^(D,0),@Z=D0,DFR(1)="^UTILITY(U,$J,DDF(1),D0,",DKP=DIFQR(D)'=2 F D0=0:0 S D0=$O(^UTILITY(U,$J,DDF(1),D0)) S:D0="" D0=-1 K D1 Q:'$D(^(D0,0))  S Z=^(0) D I^DITR
 ;; K ^UTILITY(U,$J,DDF(1)),DDF,DDT,DTO,DFR,DFN,DTN G DATA
 ;; ;
 ;;W S Y=$P($T(@X),";",2) W !,"NOTE: This package also contains "_Y_"S",! Q:'$D(DIFQ(0))
 ;; S %=1 W ?6,"SHALL I WRITE OVER EXISTING "_Y_"S OF THE SAME NAME" D YN^DICN I '% W !?6,"Answer YES to replace the current "_Y_"S with the incoming ones." G W
 ;; S:%=2 DIFQ(X)=0
 ;; Q
 ;; ;
 ;;OPT ;OPTION
 ;;RTN ;ROUTINE DOCUMENTATION NOTE
 ;;FUN ;FUNCTION
 ;;BUL ;BULLETIN
 ;;KEY ;SECURITY KEY
 ;;HEL ;HELP FRAME
 ;;DIP ;PRINT TEMPLATE
 ;;DIE ;INPUT TEMPLATE
 ;;DIB ;SORT TEMPLATE
 ;;DIS ;FORM
 ;;REM ;REMOTE PROCEDURE
 ;; ;
 ;;SBF ;FILE AND SUB FILE NUMBERS
 ;;IX W "." S DIK="A" F %=0:0 S DIK=$O(^DD(D,DIK)) Q:DIK=""  K ^(DIK)
 ;; S DA(1)=D,DIK="^DD("_D_"," D IXALL^DIK
 ;; I $D(^DIC(D,"%",0)) S DIK="^DIC(D,""%""," G IXALL^DIK
 ;; Q
 ;;B36(X) Q $$N(X\(36*36)#36+1)_$$N(X\36#36+1)_$$N(X#36+1)
 ;;N(%) Q $E("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ",%)
