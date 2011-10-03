PRC5PKG ;WISC/PLT-IFCAP V5 INSTALLATION/UPDATE OPTION ; 04/10/95  3:14 PM
V ;;5.0;IFCAP;;4/21/95
 ;QUIT  ; invalid entry
 ;
EN ;start installation/update
 N PRCIVER,PRCRI,PRCFIXV,PRCOPT,PRC5INST,PRCQ21
Q1 D EN^DDIOL(" ") S PRCFIXV="IFCAP"_$P($T(+2^PRCINIT),";",3)
 S PRCIVER=$$IVER("IFCAP",PRCFIXV),A="NO VERSION" S:PRCIVER A="V."_PRCIVER
 S B="this RELEASE of "_$E(PRCFIXV,6,999) I $O(^PRCU(420.92,"B",PRCFIXV,0)) S B="you ran OPTION 1"
 D YN^PRC0A(.X,.Y,"Did you have "_A_" of IFCAP INSTALLED before "_B,"O","")
 G:X["^"!(X="") EXIT
 I 'Y D EN^DDIOL("Please contact your ISC SUPPORT. According to the system your site has IFCAP "_$S(PRCIVER<1:"NOT",1:"VERSION "_PRCIVER)_" installed.") G EXIT
 I 'PRCIVER,$O(^PRC(420,0)) D EN^DDIOL("Please call IRM/ISC SUPPORT to check your response because you said 'IFCAP' is not installed, but there is an entry in FUND CONTOL POINT FILE.") G EXIT
Q2 D EN^DDIOL(" "),EN^DDIOL("If IFCAP 5.0 has already been installed prior to this release, run option")
 D EN^DDIOL("1 only.  If IFCAP 4.0 is installed on your system, run options")
 D EN^DDIOL("1, 2, 3, and 4.  If no version of IFCAP is installed on your system, run")
 D EN^DDIOL("options 1 and 2.")
 D EN^DDIOL(" ")
 D EN^DDIOL("If you have to rerun an option, you also have to rerun the options")
 D EN^DDIOL("following it, i.e., if you ran option 1, 2, 3, and 4, and you have to rerun")
 D EN^DDIOL("option 2, you also have to rerun option 3 and 4."),EN^DDIOL(" ")
 D SC^PRC0A(.X,.Y,"Select IFCAP V5 install/update option","OM^1:Install IFCAP Files,Options,Templates (2 parts);2:Convert FMS PCL/PAC/FND/CPF;3:Recalc Control Point Balances;4:File 442 Conversion & Generating FMS Documents","")
 G:X["^"!(X="") EXIT
 S PRCOPT=X
 I PRCOPT'=1,PRCIVER'<5 D EN^DDIOL("This option is not available to your site with IFCAP VERSION "_PRCIVER_" installed.") G Q1
 I PRCOPT>2,'PRCIVER D EN^DDIOL("This option is not available to your site with IFCAP VIRGIN installation.") G Q1
 ;validate selected option order
 I PRCOPT>1 D  I 'PRCOPT D EN^DDIOL("You need to select '1' first") G Q1
 . S A="" S PRCRI(9.4)=$O(^DIC(9.4,"B","IFCAP",0)) I PRCRI(9.4) S A=+$P(^DIC(9.4,PRCRI(9.4),"VERSION"),"^",1)
 . S:A<5 PRCOPT=""
 I PRCOPT>2 D  I 'PRCOPT D EN^DDIOL("You need to select '2' first") G Q1
 . S PRCRI(420.92)=$O(^PRCU(420.92,"B",PRCFIXV,"")) S:'PRCRI(420.92) PRCOPT=""
 . I PRCRI(420.92) S:$P($G(^PRCU(420.92,PRCRI(420.92),0)),"^",6)="" PRCOPT=""
 . QUIT
 I PRCOPT>3 D  I 'PRCOPT D EN^DDIOL("You need to select '3' first") G Q1
 . S PRCRI(420.92)=$O(^PRCU(420.92,"B",PRCFIXV,"")) S:'PRCRI(420.92) PRCOPT=""
 . I PRCRI(420.92) S:$P($G(^PRCU(420.92,PRCRI(420.92),0)),"^",4)="" PRCOPT=""
 . QUIT
 I PRCOPT=4 D EN^DDIOL("Please make sure no other file 442 conversion task is scheduled or running. If there is one you can delete the other one and start this one") D  G:X["^"!(X="") Q1 S PRCQ21=Y
 . D YN^PRC0A(.X,.Y,"Submit the File 442 Conversion & Generating FMS Doc. to the TASK MANAGER","O","")
 . QUIT
Q3 D YN^PRC0A(.X,.Y,"Ready to run the selected option '"_PRCOPT_"'","O","NO")
 G:X["^"!(X="")!(Y<1) EXIT
 I PRCOPT=1 D ^PRC5INST G Q1:$G(PRC5INST),EXIT
 I PRCOPT=2 D EN2^PRC5B G EXIT
 I PRCOPT=3 D EN3^PRC5B G EXIT
 I PRCOPT=4 D EN4^PRC5B
EXIT ;
 QUIT
 ;
 ;prca=package name .01 in file 9.4, prcb=fix value .01 in file 420.92
IVER(PRCA,PRCB) ;get initial version #
 N A
 S A="",PRCRI(420.92)=$O(^PRCU(420.92,"B",PRCB,0)) I PRCRI(420.92) D
 . S A=$P(^PRCU(420.92,PRCRI(420.92),0),"^",2)
 . QUIT
 I A="" S PRCRI(9.4)=$O(^DIC(9.4,"B",PRCA,0)) I PRCRI(9.4) D
 . S A=$P(^DIC(9.4,PRCRI(9.4),"VERSION"),"^",1)
 . QUIT
 QUIT +A
