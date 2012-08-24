PRCB1F ;WISC/PLT-IFCAP MONTHLY ACCRUAL ;9/13/96  16:21
V ;;5.1;IFCAP;**64,72,142,159**;Oct 20, 2000;Build 9
 ;Per VHA Directive 2004-038, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;ZTQPARAM=999 if from schedule option
EN ;monthly accrual
 N PRCA,PRCB,PRCQCD,PRCOPT,PRCRI,PRCDI,PRCDUZ,PRC,PRCDES,PTCTD
 N A,B,C
 ; S PRCQCD=1 ;over lapping days
 G Q4:$G(ZTQPARAM)=999!$G(ZTQUEUED)
Q1 ;station
 S PRCF("X")="AS" D ^PRCFSITE G:'% EXIT
 S PRCRI(420)=+PRC("SITE"),PRCOPT=1
Q4 ;accrual for month/year
 S A=$$DATE^PRC0C("T","E")
 S PRCTD=$P(A,"^",4)_"/"_$E($P(A,"^",3),3,4)_"^"_$P(A,"^",7)_"^"_$P(A,"^",8)
 S A=$$DATE^PRC0C($P(A,"^",4)_"/1/"_$P(A,"^",3),"E"),$P(PRCTD,"^",4,6)=$P(A,"^",4)_"/"_$E($P(A,"^",3),3,4)_"^"_$P(A,"^",7)_"^"_$P(A,"^",8)
 S A=$$DATE^PRC0C($P(A,"^",8)-15,"H")
 S A=$$DATE^PRC0C($P(A,"^",4)_"/1/"_$P(A,"^",3),"E"),$P(PRCTD,"^",7,9)=$P(A,"^",4)_"/"_$E($P(A,"^",3),3,4)_"^"_$P(A,"^",7)_"^"_$P(A,"^",8)
 G SCHED:$G(ZTQPARAM)=999!$G(ZTQUEUED)
 S E="O^4:7^K:X'?1.2N1""/""2N&(X'?1.2N1""/""4N)!(X<1!(X>12)) X",Y(1)="Enter an accrual month/year in format: MM/YY or MM/YYYY. For example: 9/96 or 9/1996"
 D FT^PRC0A(.X,.Y,"For Accrual Month/Year",E,$P(PRCTD,"^"))
 G:X["^"!(X="")!(Y'?1.2N1"/"2.4N) EXIT
 S $P(Y,"/",2)=+$$YEAR^PRC0C($P(Y,"/",2)),$P(Y,"/")=$E(100+Y,2,3)
 S PRCA=Y,A=$$DATE^PRC0C(PRCA,"E"),$P(PRCA,"^",2,999)=A W "     Fiscal Month/Year: ",$P(PRCA,"^",10),"/",$P(PRCA,"^",2)
 S $P(PRCA,"^",11)=$P(PRCA,"^",8)_"-"_PRC("SITE")
 I $P(PRCA,"^",9)<$P(PRCTD,"^",9),$O(^PRCH(440.7,"B",$P(PRCA,"^",11),0))<1 D EN^DDIOL("Accrual report for "_$P(PRCA,"^")_" is NOT in file.") G Q4
 I $P(PRCTD,"^",6)<$P(PRCA,"^",9) D EN^DDIOL("Too early to accrue for "_$P(PRCA,"^")) G Q4
 S $P(PRCA,"^",12)=0
Q40 S B="O^1:Compile/Print Monthly Accrual;2:Edit Monthly Accrual;3:Generate/Rebuild FMS SV-Document"
 K X,Y S Y(1)="^W ""Enter an option number 1 to 3."""
 D SC^PRC0A(.X,.Y,"Select Number",B,"")
 S A=Y K X,Y
 G Q4:A=""!(A["^")
 S PRCOPT=+A
 G Q45:PRCOPT=2,Q47:PRCOPT=3
 I $O(^PRCH(440.6,"ST","N~",0)) D EN^DDIOL("Warning: An unregistered card exists in your file. Contact the P.C. Coordinator.")
 I $P(PRCA,"^",9)'=$P(PRCTD,"^",6),$P(PRCA,"^",9)'=$P(PRCTD,"^",9) G Q5
 S PRCRI(440.7)=$O(^PRCH(440.7,"B",$P(PRCA,"^",11),0)) G Q5:'PRCRI(440.7)
 S A=^PRCH(440.7,PRCRI(440.7),0),B=$P(A,"^",2),B=$E(B,4,5)_"/"_$E(B,6,7)_"/"_$E(B,2,3)_"@"_$E(B,9,10)_":"_($E(B,11)\1)_($E(B,12)\1)
 D EN^DDIOL("The last compiling date is "_B)
 D:$P(A,"^",6) EN^DDIOL("Warning: Recompiling will overwrite all edited accrual amounts")
Q41 D YN^PRC0A(.X,.Y,"Recompile Accrual Report:","O","NO")
 I X["^" G Q4
 L +^PRCH(440.7,PRCRI(440.7)):5 E  W !,"Another user has this Accrual File open, please try later" G Q40
 S $P(PRCA,"^",12)=Y G Q5
Q45 ;eidt accrual amount
 I $P(PRCA,"^",9)'=$P(PRCTD,"^",6),$P(PRCA,"^",9)'=$P(PRCTD,"^",9) D EN^DDIOL("It is too late to edit accrual amounts") G Q4
 S PRCRI(440.7)=$O(^PRCH(440.7,"B",$P(PRCA,"^",11),0))
 I 'PRCRI(440.7) D EN^DDIOL("You need to select Compile/Print option first") G Q40
 L +^PRCH(440.7,PRCRI(440.7)):5 E  W !,"Another user has this Accrual File open, please try later" G Q40
 G Q5
 ;
Q47 ;generate sv-document
 I $P(PRCA,"^",9)'=$P(PRCTD,"^",6),$P(PRCA,"^",9)'=$P(PRCTD,"^",9) D EN^DDIOL("It is too late to generate SV-documents") G Q4
 S PRCRI(440.7)=$O(^PRCH(440.7,"B",$P(PRCA,"^",11),0))
 I 'PRCRI(440.7) D EN^DDIOL("You need to select Compile/Print option first") G Q40
 L +^PRCH(440.7,PRCRI(440.7)):5 E  W !,"Another user has this Accrual File open, please try later" G Q40
 S A=^PRCH(440.7,PRCRI(440.7),0) D:$P(A,"^",7)]""
 . N GECSDATA
 . S A=$P($P(A,"^",7),"/",2),X="SV-"_A D DATA^GECSSGET(X,0)
 . I '$G(GECSDATA) D EN^DDIOL(PRCPT_" NOT found!") QUIT
 . S PRCRI(2100.1)=GECSDATA,PRCID=GECSDATA(2100.1,PRCRI(2100.1),.01,"E")
 . D EN^DDIOL(" "),EN^DDIOL($J("FMS Document: ",15)_PRCID)
 . D EN^DDIOL($J("Description: ",15)_GECSDATA(2100.1,PRCRI(2100.1),4,"E"))
 . D EN^DDIOL($J("Status: ",15)_GECSDATA(2100.1,PRCRI(2100.1),3,"E"))
 . D EN^DDIOL($J("Created: ",15)_GECSDATA(2100.1,PRCRI(2100.1),2,"E"))
 . QUIT
 G Q5
Q5 D YN^PRC0A(.X,.Y,"Ready to "_$P("Compile/Print,Edit,Generate/Rebuild Document",",",PRCOPT),"O","NO")
 I X["^"!(X="")!'Y G Q4
 I PRCOPT=1 D ACCR G Q5X
 L +^PRCH(440.7,PRCRI(440.7)):3 E  W !,"Another user has this Accrual file open, please try later" G Q4
 I PRCOPT=2 D EDIT
 I PRCOPT=3 D
 . D EN^DDIOL("Generating the monthly accrual FMS SV-Document")
 . S PRCB=$P(^PRCH(440.7,PRCRI(440.7),0),"^",7)
 . D SV^PRCB8B(.X,PRCRI(440.7)_"^"_PRCA,$TR(PRCB,"/","^"))
 . I X>0 D EDIT^PRC0B(.X,"440.7;^PRCH(440.7,;"_PRCRI(440.7),"2///^S X=""N"";6////"_X)
 . QUIT
Q5X I $G(PRCRI(440.7)) L -^PRCH(440.7,PRCRI(440.7))  ;PRC*5.1*159 insures previously compile file entry is unlocked when recompile is queued
 D EN^DDIOL(" "),EN^DDIOL(" ") G Q4
 ;
EXIT QUIT
 ;
 ;
ACCR ;start accrual
 N PRCDUZ
 S PRCDUZ=DUZ
 S ZTDESC="IFCAP Monthly Accrual for Month/Year: "_$P(PRCA,"^")
 S PRCDES=ZTDESC
 S ZTRTN="TMEN^PRCB1F1" F A="PRCOPT","PRCA","PRCTD","PRCDUZ","PRCDES","DUZ*" S ZTSAVE(A)=""
 D ^PRCFQ
 QUIT
 ;
EDIT ;edit accrual amount
 N PRCDI
 N A,B,X,Y
 D EDIT^PRC0B(.X,"440.7;^PRCH(440.7,;"_PRCRI(440.7),"5///T")
Q21 D EN^DDIOL(" "),EN^DDIOL($TR($J("",78)," ","-")) S PRCDI="440.7;^PRCH(440.7,;"_PRCRI(440.7)_";1~440.701;^PRCH(440.7,"_PRCRI(440.7)_",50,"
 D LOOKUP^PRC0B(.X,.Y,PRCDI,"AEMOQ","Select Fund or FCP/PRJ (ACC) Code: ")
 I Y<0!(X="") K X QUIT
 K X S PRCRI(440.701)=+Y,PRCAED=$P(Y,"^",3)
 S PRCDI=";^PRCH(440.7,;"_PRCRI(440.7)_"~440.701;^PRCH(440.7,"_PRCRI(440.7)_",50,;"_PRCRI(440.701)
 S A=^PRCH(440.7,PRCRI(440.7),50,PRCRI(440.701),0),B=$P(A,"^",2)-$P(A,"^",3)
 D EN^DDIOL("Accrual Account: "_$P(A,"^",1))
 D EN^DDIOL("Unpaid P.C.O Amount: "_$J($P(A,"^",2),0,2)_"         Unreconciled Amount: "_$J($P(A,"^",3),0,2))
 D EN^DDIOL("Calculated Accrual Amount: "_$J(B,0,2))
 D EDIT^PRC0B(.X,PRCDI,"4;5;6")
 G Q21
 ;
SCHED ;compiling for all stations
 S Y=$P(PRCTD,"^",7),$P(Y,"/",2)=+$$YEAR^PRC0C($P(Y,"/",2)),$P(Y,"/")=$E(100+Y,2,3)
 S PRCA=Y,A=$$DATE^PRC0C(PRCA,"E"),$P(PRCA,"^",2,999)=A
 S PRCRI(420)=0
 F  S PRCRI(420)=$O(^PRC(420,PRCRI(420))) QUIT:'PRCRI(420)  S PRC("SITE")=$P($G(^PRC(420,PRCRI(420),0)),"^") I PRC("SITE") S $P(PRCA,"^",11)=$P(PRCA,"^",8)_"-"_PRC("SITE") D
 . N PRCB,PRCD,PRCE,PRCG,PRCDI,PRCRICB,PRCLOCK,PRCRI,PRCID,PRCAMT,PRCBOC,PRAMTP,PRCAMTR,PRCSUBT,PRCAMTA
 . N A,B,C
 . S PRCID=$P(PRCA,"^",11),PRC("SITE")=$P(PRCID,"-",2)
 . D ACCR^PRCB1F1(PRCA,PRCTD)
 . QUIT
 QUIT
