PSXBLD ;BIR/BAB-Build HL7 Data for CMOP Rx Queue ;24 Jun 2002  5:19 PM
 ;;2.0;CMOP;**3,23,29,28,43,41,50,54**;11 Apr 97;Build 6
 ;
 ;Reference to  ^PSRX(       supported by DBIA #1977
 ;Reference to  ^PSDRUG(     supported by DBIA #1983
 ;Reference to  ^PS(51,      supported by DBIA #1980
 ;Reference to  ^PS(52.5     supported by DBIA #1978
 ;Reference to  ^PS(53,      supported by DBIA #1975
 ;Reference to  ^PS(55,      supported by DBIA #2228
 ;Reference to  ^PS(59,      supported by DBIA #1976
 ;Reference to  ^PS(59.7,    supported by DBIA #694
 ;Reference to  ^DPT(        supported by DBIA #3097
 ;Reference to IBCP^PSOLBL   supported by DBIA #2477
 ;Reference to OTHL1^PSOLBL3 supported by DBIA #4071
 ;Reference to EN^PSOHLSN1   supported by DBIA #2385
 ;Reference to PROD2^PSNAPIS supported by DBIA #2531
 ;Reference to DRUG^PSSWRNA supported by DBIA #4449
EN ; build entries into 550.1 by alpha patient
 D SET^PSXSYS
 ;Clear 550.1
 ; of entries
 K DIK,DA S DIK="^PSX(550.1,",DA=0 F  S DA=$O(^PSX(550.1,DA)) Q:DA'>0  D ^DIK
 ; walk down the PTNM,DFN,RX,FILL 'C' index of PSX(550.2,PSXBAT,15,'C' - RX multiple
 ; Alpha order by patient name
 S PSXNM="",ZCNT=0,PSXMSG=0 ;PSXMSG now starts at 1 every batch incremented in NEWMSG^PSXRXQU
 S PSSWSITE=+$O(^PS(59.7,0))
 F  S PSXNM=$O(^PSX(550.2,PSXBAT,15,"C",PSXNM)) Q:PSXNM']""  D
 . S DFN="" F  S DFN=$O(^PSX(550.2,PSXBAT,15,"C",PSXNM,DFN)) Q:DFN'>0  D
 .. S MSG=0 K PSX,PSXORD
 .. D NEWMSG^PSXRXQU,ORD,MRX^PSXBLD1,LOADMSG^PSXRXQU
 D DIV^PSXBLD1 ;build NTE1
 K MSG,PSXNM,DFN,RX,RXF,REG,PSCAP,X,Y,PSXPTR,PSSWSITE
 Q
ORD ; PSXMSG was returned by call to NEWMSG^PSXRXQU
 ; Loop RXs, RXFs in Transmission PSXBAT
 S REG=$S($P($G(^PS(55,DFN,0)),"^",3)=1:1,1:""),PSCAP=+$P($G(^PS(55,DFN,0)),"^",2),RX=0 K RXY,RXY1
 S RX=0 F  S RX=$O(^PSX(550.2,PSXBAT,15,"C",PSXNM,DFN,RX)) Q:RX'>0  D
 . S REC=$O(^PS(52.5,"B",RX,0))
 . I 'REC D DEL5502 Q  ;RX was removed from 52.5 during transmission
 . S RXY=^PSRX(RX,0),RXF=$O(^PSX(550.2,PSXBAT,15,"C",PSXNM,DFN,RX,0))
 . S PTR=RX S:RXF>0 RXY1=$G(^PSRX(RX,1,RXF,0)) D ORC ;builds RX HL7 segments into PSXORD(
 . I PSXFLAG=1 S ^PS(52.5,REC,"P")=1,^PS(52.5,"ADL",DT,REC)="" ;update print node
 . D RXMSG^PSXRXQU ;put RX,RXF  into PSXMSG 550.1 RX multiple ; returns PSXRXMDA
 . ;D FILE^PSXRXU ;update 52 & 52.5
 . I PSXFLAG=1 D EN^PSOHLSN1(RX,"SC","ZU","Transmitted to CMOP","")
 K PSCLN,ZDU,FDT,DRUG,RXN,WARN,TECH,QTY,PHYS,DAYS,LSTFIL,COPAY,DEA,P,PTST,REF,VRPH,RXY,RXY1
 Q
ORC ;builds RX HL7 segments into PSXORD(
 Q:($G(RXF)>0&($G(RXY1)=""))
 N PSOLBLCP
 S PSX(RX)=RXF,MSG=MSG+1,FDT=$P(^PSRX(RX,2),"^",2),PSXORD(MSG)="ORC|NW|"
 S X=+$G(^PSRX(RX,"IB")),COPAY=$S(X=1:1,X=2:1,1:"") K X S RXN=$P(RXY,"^"),VRPH=$P($G(^PSRX(RX,2)),"^",10)
 D COPAYCK ; DO ADDITIONAL CHECKS TO DETERMINE CURRENT COPAY STATUS
 S (DRUG,WARN,DEA)="" I $D(^PSDRUG(+$P(RXY,"^",6),0)) S DRUG=$P(^(0),"^"),WARN=$P(^(0),"^",8),DEA=$P(^(0),"^",3) S Y=DRUG D STRIP S DRUG=Y K Y
 I '$D(PSSWSITE) S PSSWSITE=+$O(^PS(59.7,0))
 I $P($G(^PS(59.7,PSSWSITE,10)),"^",10)="N" D
 .S WARN=$$DRUG^PSSWRNA(+$P(RXY,"^",6),DFN)
 I $G(DRUG) S ZDU=$P($G(^PSDRUG(DRUG,660)),"^",8)
 S ISD=$P(RXY,"^",13),ISD=ISD+17000000
 G:RXF>0 REF
 S TECH=+$P(RXY,"^",16),QTY=$P(RXY,"^",7),PHYS=$S($D(^VA(200,+$P(RXY,"^",4),0)):$P(^(0),"^"),1:"UNKNOWN"),DAYS=$P(RXY,"^",8)
 S ZFIL=$G(^PSRX(RX,3))
 S LSTFIL=$S(+$P(ZFIL,"^",4):$P(ZFIL,"^",4),1:+$P(ZFIL,"^"))
 S LSTFIL=LSTFIL+17000000
 S EXPDT=$P(^PSRX(RX,2),U,6) S:+EXPDT EXPDT=EXPDT+17000000
 G RX1
REF ;
 S TECH=+$P(RXY1,"^",7),QTY=$P(RXY1,"^",4),PHYS=$S($D(^VA(200,+$P(RXY1,"^",17),0)):$P(^(0),"^"),1:"UNKNOWN"),DAYS=$P(RXY1,"^",10)
 S FDT=$P(RXY1,"^")
 S ZFIL=$G(^PSRX(RX,3))
 S LSTFIL=$S(+$P(ZFIL,"^",4):$P(ZFIL,"^",4),1:+$P(ZFIL,"^"))
 S LSTFIL=LSTFIL+17000000
 S EXPDT=$P(^PSRX(RX,2),"^",6),EXPDT=EXPDT+17000000
RX1 ;
 S X="RX1|",$P(X,"|",13)=QTY,$P(X,"|",21)=ISD,$P(X,"|",25)=EXPDT
 S $P(X,"|",2)=+$P(PSXSYS,"^",2)_"-"_$P(RXY,"^")_"-"_(RXF+1)
 S Y1=$P($G(^PSDRUG($P(RXY,"^",6),"ND")),U,3)
 D DGST
 S $P(X,"|",15)=$S($L($G(PSXDGST)):PSXDGST_"^L",1:"^^L")
 S $P(X,"|",20)=$P(RXY,"^",9),$P(X,"|",22)=+$P(RXY,"^",9)-RXF
 S $P(X,"|",26)=LSTFIL,$P(X,"|",27)=$P(RXY,"^")
 K ZFIL S MSG=MSG+1,PSXORD(MSG)=X_"||||",FLG=0 D SIG K MAX,FLG,X
ZX1 ;
 S REFDIV=$S($P($G(^PS(59.7,1,40.1)),"^",4):$P(^(40.1),"^",4),1:PSOSITE)
 S X="ZX1|"_$P(RXY,"^")_"|"_$P($G(^PS(59,REFDIV,0)),"^",6)_"^"_$P($G(^(0)),"^")_"|M|"
 K REFDIV
 ; Count number of CMOP rxs for this patient order
 S Y=1,Y1=RX F  S Y1=$O(^TMP($J,"PSX",PSXNM,DFN,Y1)) Q:'Y1  S Y=Y+1
 S $P(X,"|",5)=Y,$P(X,"|",6)="("_(RXF+1)_"of"_(1+$P(RXY,"^",9))_")",$P(X,"|",8)=REG K Y,Y1 S $P(X,"|",7)=$S($D(^VA(200,+$P(^PSRX(RX,0),"^",4),0)):$E($P(^(0),"^",1),1,20),1:"UNKNOWN"),$P(X,"|",8)=REG K Y,Y1
 S VRPH=$P(^PSRX(RX,2),"^",10),$P(X,"|",9)="("_$G(TECH)_"/"_$S($D(VRPH):VRPH,1:" ")_")" S:$L($P(X,"|",9))>12 $P(X,"|",9)="(***/***)"
 I '+$G(PSOINST) D:'+$G(PSXSYS) SET^PSXSYS S PSOINST=+$P(PSXSYS,"^",2)
 S $P(X,"|",10)=1700+$E(FDT,1,3)_$E(FDT,4,7),$P(X,"|",11)=COPAY,$P(X,"|",13)=PSCAP,$P(X,"|",14)=DAYS,$P(X,"|",16)=PSOINST_"-"_RX
 ;Addition for CS transmissions...1 if CS, "" if not...
 S PSXCSB=$P(^PSRX(RX,0),"^",6),PSXCSC=$P($G(^PSDRUG(PSXCSB,0)),"^",3)
 F PSXCSD=3:1:5 I PSXCSC[PSXCSD S PSXCSRX=1
 S $P(X,"|",15)=$G(PSXCSRX) K PSXCSRX,PSXCSC,PSXCSB,PSXCSD
 D WARN
 S PTST=$G(^PS(53,$P(RXY,"^",3),0)),RNEW=1,REF=+$P(^PSRX(RX,0),"^",9)-RXF S:REF<0 REF=0 I REF=0 S:('$P(PTST,"^",5))!(DEA["A"&(DEA'["B"))!(DEA["W") RNEW=0
 S $P(X,"|",12)=RNEW,PTST=$P(PTST,"^",2),PSCLN=+$P(RXY,"^",5),PSCLN=$S($D(^SC(PSCLN,0)):$P(^(0),"^",1),1:"UNKNOWN") S $P(X,"|",18)=$E((PTST),1,20),$P(X,"|",19)=$E(PSCLN,1,20)
 ;
 K RNEW,SIG,SGY,ISD,EXPDT
 S MSG=MSG+1,PSXORD(MSG)=X
 S PSSWSITE=+$O(^PS(59.7,0))
 I $P($G(^PS(59.7,PSSWSITE,10)),"^",10)="N" D NEWWARN^PSXBLD2
 Q
A I $D(^PS(51,"A",X)) S %=^(X),X=$P(%,"^",1) I $P(%,"^",2)'="" S Y=$P(SIG," ",P-1),Y=$E(Y,$L(Y)) S:Y>1 X=$P(%,"^",2)
 I (+$G(FLG)=0)&(($L(SGY)+$L(X))'>70) S SGY=SGY_X_" " Q
 I (+$G(FLG)=1)&(($L(SGY)+$L(X))'>100) S SGY=SGY_X_" " Q
 I $G(FLG)=1 S MSG=MSG+1,PSXORD(MSG)=$TR("NTE|7||"_SGY,"\","/"),SGY=X_" " Q
 S PSXORD(MSG)=$TR(PSXORD(MSG)_SGY,"\","/"),SGY=X_" ",FLG=1
 Q
SIG ;
 G:($P(^PSRX(RX,"SIG"),"^",2)=1) EXPAND
 S SIG=$P(^PSRX(RX,"SIG"),"^")
 S SGY="" F P=1:1:$L(SIG," ") S X=$P(SIG," ",P) D A:X]""
 I SGY]"",FLG=0 S PSXORD(MSG)=$TR(PSXORD(MSG)_SGY,"\","/")
 I SGY]"",FLG=1 S MSG=MSG+1,PSXORD(MSG)=$TR("NTE|7||"_SGY,"\","/")
 I $D(^DPT(DFN,"NHC")),^("NHC")="Y" S MSG=MSG+1,PSXORD(MSG)=$TR("NTE|7||Exp:______ Mfg:______","\","/")
 K SIG,%,J,Z,SGY,X
 Q
STRIP ;strip out any HL7 delimiters
 F %="|","~","^","\" F  Q:Y'[%  S Y=$P(Y,%,1)_" "_$P(Y,%,2,999)
 ;replace "&" in sig with escape sequence "\T\"
 ;S:Y["&" Y=$P(Y,"&",1)_"\T\"_$P(Y,"&",2,999)
 Q
EXPAND ;expands the sig
 N NTESEQ
 K ^UTILITY($J,"W") S DIWL=1,DIWR=80,DIWF="C80"
 S XX=0 F  S XX=$O(^PSRX(RX,"SIG1",XX)) Q:XX'>0  S X=^(XX,0) S Y=X D STRIP S X=Y D ^DIWP
 S YY=0 F  S YY=$O(^UTILITY($J,"W",1,YY)) Q:YY'>0  D
 .I YY=1 S NTESEQ=1,PSXORD(MSG)=$TR($G(PSXORD(MSG))_$G(^(YY,0)),"\","/") Q
 .S MSG=$G(MSG)+1,PSXORD(MSG)=$TR("NTE|7||"_$G(^(YY,0)),"\","/") D
 ..I $P($G(^PS(59.7,PSSWSITE,10)),"^",10)="N" S PSXORD(MSG)=$P(PSXORD(MSG),"|",1,2)_"|"_$P(RXY,"^")_"|ENG|"_NTESEQ_"|"_$P(PSXORD(MSG),"|",4,99),NTESEQ=NTESEQ+1
 .Q
 K XX,YY,DIWL,DIWR,DIWF,X,Y,^UTILITY($J,"W"),Z
 I $$PATCH^XPDUTL("PSO*7.0*117"),$P($G(^PS(55,DFN,"LAN")),"^",1),$P($G(^PS(55,DFN,"LAN")),"^",2)=2 D OTHL1^PSOLBL3(RX) D  Q:'$O(SIG2(0))  ;ONLY SEND SPANISH SIG IF PMI PREF (ON PID SEGMENT) IS ALSO SPANISH
 .S XX=0 F  S XX=$O(SIG2(XX)) Q:'XX  I $O(SIG2(XX))="",SIG2(XX)="" K SIG2(XX) Q  ; IF LAST ENTRY IS NULL, REMOVE IT
 S NTESEQ=1
 S DIWL=1,DIWR=80,DIWF="C80",(XX,YY)=0
 F  S XX=$O(SIG2(XX)) Q:'XX  S X=SIG2(XX) S Y=X D STRIP S X=Y D ^DIWP
 S PSSWSITE=+$O(^PS(59.7,0))
 F  S YY=$O(^UTILITY($J,"W",1,YY)) Q:YY'>0  S MSG=$G(MSG)+1,PSXORD(MSG)=$TR("NTE|7||"_$G(^(YY,0)),"\","/") I $P($G(^PS(59.7,PSSWSITE,10)),"^",10)="N" D
 .S PSXORD(MSG)=$P(PSXORD(MSG),"|",1,2)_"|"_$P(RXY,"^")_"|SPA|"_NTESEQ_"|"_$P(PSXORD(MSG),"|",4,99),NTESEQ=NTESEQ+1
 K XX,YY,DIWL,DIWR,DIWF,X,Y,^UTILITY($J,"W"),SIG2,PSSWSITE
 Q
DGST ; returns PSXDGST
 N RXNUM,RXEX,PTRA,PTRB,ZX,PSXPTR
 S PSXPTR=RX K PSXDGST
 S RXNUM=$P($G(^PSRX(PSXPTR,0)),"^",6),RXEX=$P($G(^PSRX(PSXPTR,0)),"^",1)
 I $G(^PSDRUG(RXNUM,"ND"))'="" D
 .S PTRA=$P($G(^PSDRUG(RXNUM,"ND")),U,1),PTRB=$P($G(^PSDRUG(RXNUM,"ND")),U,3)
 .I $G(PTRA)'="" S ZX=$$PROD2^PSNAPIS(PTRA,PTRB),DRUGCHK=$P($G(ZX),"^",3)
 S:$G(DRUGCHK)'="" PSXDGST=$P(ZX,"^",2)_"^"_$P(ZX,"^")
 Q
COPAYCK ; RECHECK COPAY STATUS FOR EACH FILL
 N PSOLBLPS,PSOLBLDR,PSODBQ,PSOQI
 S PSOLBLPS=+$P(RXY,"^",3),PSOLBLDR=+$P(RXY,"^",6)
 I $P($G(^PS(53,+$G(PSOLBLPS),0)),"^",7) S COPAY="" Q
 I $P($G(^PSDRUG(+$G(PSOLBLDR),0)),"^",3)["I"!($P($G(^(0)),"^",3)["S") S COPAY="" Q
 S PSOQI=$G(^PSRX(RX,"IBQ"))
 I PSOQI["1" S COPAY="" Q
 I $G(PSOLBLCP)="" D IBCP^PSOLBL ; CHECK WHETHER EXEMPT (SC OR INCOME EXEMPT - OR IF SERVICE-CONNECTED QUESTION NEEDS TO BE ASKED KEEP COPAY AS IT WAS)
 I $G(PSOLBLCP)=0 S COPAY="" Q
 I $G(PSOLBLCP)=2,'$P($G(^PSRX(RX,"IB")),"^") S COPAY="" Q
 S COPAY=1
 Q
 ;
DEL5502 ; RX was removed from 52.5 during transmission
 N DA,DIK
 S DA=$O(^PSX(550.2,PSXBAT,15,"B",RX,0))
 S DA(1)=PSXBAT,DIK="^PSX(550.2,"_DA(1)_",15," D ^DIK
 Q
WARN ;
 I '$D(PSSWSITE) S PSSWSITE=+$O(^PS(59.7,0))
 I $P($G(^PS(59.7,PSSWSITE,10)),"^",10)="N" Q
 S L=+$L(WARN,",") S W1="" F J=1:1:L S W=$P(WARN,",",J) I +W>0,(+W'>20) S:+W1>0 W1=W1_"~"_W S:+W1=0 W1=W1_W
 S:+W1>0 $P(X,"|",17)=W1 K WARN,J,W,L,W1
 Q
