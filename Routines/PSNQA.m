PSNQA ;BIR/WRT-checks pointers to match on "ND" node and unmatches possible erroneous matches. ;01/12/98   5:18 PM
 ;;4.0; NATIONAL DRUG FILE;; 30 Oct 98
SETUP S PSNDZ=0 D CKDUZ,CKDT I PSNDZ=0 D SETUP1 K PSNDZ
 Q
CKDUZ I '$D(DUZ) W !!,"DUZ MUST BE DEFINED",! S PSNDZ=1
 I $D(DUZ(0)),DUZ(0)'="@" W "DUZ(0) MUST BE SET TO THE ""@"" SIGN",!! S PSNDZ=1
 Q
CKDT I '$D(DT) S %DT="",X="T" D ^%DT S DT=Y
 Q
SETUP1 K ^TMP($J) W !,"Let me put you on hold for a second " D START,REDEX S:'$D(^TMP($J,"PSNQA",9,0)) ^TMP($J,"PSNQA",9,0)="NO ENTRIES FOUND" D MESS,KILL W !,"OK, I'm Done. PSN*3.15*3 has been installed and completed.",!
 Q
START F PSNDA=0:0 S PSNDA=$O(^PSDRUG(PSNDA)) Q:'PSNDA  U IO W:'(PSNDA#100) "." I $D(^PSDRUG(PSNDA,"ND")) S NODE=^PSDRUG(PSNDA,"ND") I $P(NODE,"^",2)]"" S VAPN=$P(NODE,"^",2) D GRAB
 Q
GRAB S IEN=$P(NODE,"^",1) I IEN>3032&(IEN<3175) D TOP S ^TMP($J,"PSN",$P(^PSDRUG(PSNDA,0),"^"),PSNDA)=$P(^PSDRUG(PSNDA,0),"^") D UNMTCH
 Q
UNMTCH S PSNID=$P(^PSDRUG(PSNDA,"ND"),"^",10),Y=PSNDA D SETNULL^PSNHELP1 S:$D(^PSDRUG(PSNDA,3)) $P(^PSDRUG(PSNDA,3),"^",1)=0 K:$D(^PSDRUG("AQ",PSNDA)) ^PSDRUG("AQ",PSNDA) K:PSNID]"" ^PSDRUG("AQ1",PSNID,PSNDA) K PSNID
 S DA=PSNDA S X="PSXREF" X ^%ZOSF("TEST") D:$T ^PSXREF K DA
 Q
KILL K PSNDA,IEN,ZXZX,NODE,VAPN,KK,NDA,NME
 Q
REDEX S NME="" F KK=0:0 S NME=$O(^TMP($J,"PSN",NME)) Q:NME=""  S NDA=$O(^TMP($J,"PSN",NME,0)) S NUM=$S('$D(NUM):9,1:NUM+1),^TMP($J,"PSNQA",NUM,0)=$P(^TMP($J,"PSN",NME,NDA),"^")
 Q
MESS S XMDUZ="NATIONAL DRUG FILE PACKAGE",XMSUB="ENTRIES IN ""DRUG"" FILE THAT NEED TO BE REMATCHED TO NDF",XMTEXT="^TMP($J,""PSNQA"",",XMY(DUZ)=""
 I $D(^XUSEC("PSNMGR")) F PSNDUZ=0:0 S PSNDUZ=$O(^XUSEC("PSNMGR",PSNDUZ)) Q:'PSNDUZ  S XMY(PSNDUZ)=""
 D ^XMD K ^TMP($J,"PSNQA"),^TMP($J,"PSN"),XMY,NUM,XMDUZ,XMTEXT,PSNDUZ,XMSUB
 Q
TOP S ^TMP($J,"PSN","*1",1)="Patch PSN*3.15*3 was installed and the following",^TMP($J,"PSN","*2",2)="entries in your local drug file need to be rematched"
 S ^TMP($J,"PSN","*3",3)="using the ""Rematch / Match Single Drugs"" option.",^TMP($J,"PSN","*4",4)="They have been unmatched to NDF for you.",^TMP($J,"PSN","*5",5)="  "
 Q
