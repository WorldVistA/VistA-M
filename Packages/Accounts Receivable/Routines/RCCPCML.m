RCCPCML ;WASH-ISC@ALTOONA,PA/LDB-Send CCPC transmission ;12/19/96  4:16 PM
V ;;4.5;Accounts Receivable;**34,80,93,118,133,140,160,165,187,195,206,223**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
TRAN ;called from RCCPC TRANSMIT option to interactively allow transmission of CCPC mesages
 N %DT,DTOUT,SDT,X,Y,ZTRTN,ZTSAVE,ZTDESC,ZTIO
 I '$D(^XUSEC("RCCPC TRANSMIT",DUZ)) W *7,*7,!,"You do not have access to do this." Q
 S %DT="AEXP"
 S %DT("A")="Enter statement date as it will appear on these statements: "
 S SDT=$O(^RCPS(349.2,0)) I 'SDT W !,"You need to build the CCPC file." Q
 S SDT=$P($P($G(^RCPS(349.2,SDT,0)),"^",10),".") I 'SDT W !,"Your CCPC statement file (349.2) is corrupted. Please rebuild it." Q
 S SDT=$E(SDT,1,5)_$$STDY^RCCPCFN
 S %DT("B")=$$FMTE^XLFDT(SDT)
 D ^%DT Q:(X="^")!($D(DTOUT))!(Y=-1)
 S SDT=$E(Y,1,5)_$$STDY^RCCPCFN,SDT=$$STDT^RCCPCFN(SDT)
 S ZTSAVE("SDT")="",ZTRTN="RETRAN^RCCPCML",ZTIO="",ZTDESC="Re-transmit CCPC patient statements -user activated"
 D ^%ZTLOAD
 Q
 ;
EN ;called from background job
 N DA,DIK,LPRINT
 S SDT=$$STDT^RCCPCFN("")
RETRAN N DA,DIK,ERROR,RCT,X
 S (ERROR,X)=0 F  S X=$O(^RCPS(349.2,X)) Q:'X  I $G(^(X,6)) S ERROR=1,NM=0 D ERROR Q
 I $G(ERROR) D EXIT Q
 K ^TMP($J)
 S X=0 F  S X=$O(^RCT(349,"B",X)) Q:X=""  I $P(X,".")="PS" S DA=$O(^RCT(349,"B",X,0)),DIK="^RCT(349," D ^DIK
 F X="PA","IS","IT" S RCT=$O(^RCT(349.1,"B",X,0)) I RCT K ^RCT(349.1,+RCT,4)
 N %,ADD,AMT,ERROR,L,LN,M,MSG,MCT,MPT1,MTOT,NM,P,PD,PD0,PSN,PT,PT0,PHCT,RCM,RTY,TAMT,TMSG,SZ
 D DT^DICRW
 S (ERROR,RTY)=0
 S X=$O(^RCT(349.1,"B","PS",0))
 I X,$P($G(^RCT(349.1,+X,0)),"^",3) S X=$P($G(^RCT(349.1,+X,3)),"^",3)
 I X']"" S ERROR=6,NM=0 D ERROR,EXIT Q
 D PHCT I 'PHCT S ERROR=1,NM=0 D ERROR,EXIT Q
 S MTOT=$O(^TMP($J,"MCT",""),-1)
 S MCT=0 F  S MCT=$O(^TMP($J,"MCT",MCT)) Q:'MCT  D PS
EXIT D ERRML^RCCPCML1
 K SDT,^TMP($J)
 Q
 ;
F349 ;Get PS segment entry
 N DA,D0,DIC,DLAYGO,X
 S ERROR=0 K DD,DO S DIC="^RCT(349,",DIC(0)="L",DLAYGO=349,X="PS."_$TR($$FMTE^XLFDT(DT,"2D"),"/",".")_"."_RCM D FILE^DICN
 I Y<0 S RTY=RTY+1 G F349:RTY<4 S ERROR=2,NM=0 D ERROR Q
 S PSN=+Y
 Q
 ;
PS ;Build PS,PH,PD segments and messages
 S PSN=$O(^TMP($J,"MCT",MCT,0))
 S $P(^RCT(349,+PSN,0),"^",3,10)=MCT_"^"_MTOT_"^"_$$SITE^RCMSITE()_"^"_$$FP^RCCPCFN_"^"_+^TMP($J,"MCT",MCT)_"^"_$P(^TMP($J,"MCT",MCT),"^",2)_"^"_SDT_"^"_$$STM^RCCPCFN
 S LN=+PSN,^TMP($J,"MSG",LN)=$P($G(^RCT(349,+PSN,0)),"^",2,10)_"^|"
 S MPT1=$P(^TMP($J,"MCT",MCT),"^",3)
 S PT=$S(MCT=1:0,1:$P(^TMP($J,"MCT",MCT-1),"^",3))
 F  S PT=$O(^RCPS(349.2,PT)) Q:PT=$O(^RCPS(349.2,+($P(^TMP($J,"MCT",MCT),"^",3))))  D
 .Q:$D(^TMP($J,"ERRPT",+PT))
 .S PT0=^RCPS(349.2,+PT,0)
 .S LN=LN+1 S ^TMP($J,"MSG",LN)="PH^"_$$SITE^RCMSITE_$$KEY^RCCPCFN(+PT)_"^"_$$NM^RCCPCFN(+PT)_"^"
 .S ADD=$G(^RCPS(349.2,+PT,1))
 .;
 .;Remove special characters causing problems (WIM-0402-20728)
 .I ADD["~" S ADD=$TR(ADD,"~","") ;Remove tilde
 .I ADD["|" S ADD=$TR(ADD,"|","") ;Remove the pipe symbol
 .;
 .;Debtor needs large print (font) IF LPRINT=1
 .S LPRINT=$G(^RCPS(349.2,+PT,7)) S:LPRINT="" LPRINT=0
 .;
 .F P=1:1:7 S $P(^TMP($J,"MSG",LN),"^",P+5)=$S($P(ADD,"^",P)]"":$P(ADD,"^",P),1:"")
 .S ^TMP($J,"MSG",LN)=^TMP($J,"MSG",LN)_"^"
 .S LN=LN+1
 .F X=4:1:8 S $P(AMT,"^",X-3)=$$HEX^RCCPCFN($P(PT0,"^",X))
 .;S ^TMP($J,"MSG",LN)=AMT_"^"_$G(^RCPS(349.2,+PT,3))_"^"_$G(^RCPS(349.2,+PT,4))_"^"_$P(^RCPS(349.2,+PT,2,0),"^",4)_"^|"
 .S ^TMP($J,"MSG",LN)=AMT_"^"_$G(^RCPS(349.2,+PT,3))_"^"_$G(^RCPS(349.2,+PT,4))_"^"_$O(^RCPS(349.2,+PT,2,""),-1)
 .S LN=LN+1 I $P($G(^RCD(340,+PT,0)),";") S ^TMP($J,"MSG",LN)="^"_$$SITE^RCMSITE_$$RJ^XLFSTR($TR($P(^RCD(340,+PT,0),";"),".",""),13,0)
 .S ^TMP($J,"MSG",LN)=$G(^TMP($J,"MSG",LN))_"^"_LPRINT_"^|"
 .S $P(^RCPS(349.2,+PT,0),"^",11)=+PSN
 .S PD=0 F  S PD=$O(^RCPS(349.2,+PT,2,PD)) Q:'PD  I $D(^(PD,0)) S PD0=^(0) D
 ..S AMT(0)=$$HEX^RCCPCFN($P(PD0,"^",3))
 ..S LN=LN+1,^TMP($J,"MSG",LN)="PD^"_$$DAT^RCCPCFN(+PD0)_"^"_$P(PD0,"^",2)_"^"_AMT(0)_"^"_$P(PD0,"^",4)_"^|"
 S LN=LN+1,^TMP($J,"MSG",LN)="~"
 ;
MAIL ;set up mail message
 N L,XMDUZ,XMSUB,XMY,XMZ,Z
 S XMSUB=$$SITE^RCMSITE()_" CCPC TRANSMISSION "_SDT
 S XMDUZ="AR PACKAGE"
 I $O(^XMB(3.8,"B","RCCPC STATEMENTS","")),$P($G(^RC(342,1,0)),"^",12) S XMY("G.RCCPC STATEMENTS")=""
 S X=$O(^RCT(349.1,"B","PS",0))
 I X,$P($G(^RCT(349.1,+X,0)),"^",3) S X=$P($G(^RCT(349.1,+X,3)),"^")_"@"_$P($G(^RCT(349.1,+X,3)),"^",3) S:$P(X,"@",2)]"" XMY(X)=""
 I $P(X,"@",2)']"" D  Q
 .S ERROR=6,NM=0 D ERROR
 S XMDUZ="AR PACKAGE"
 D XMZ^XMA2
 I XMZ<1 S RTY=RTY+1 G MAIL:RTY<4 S ERROR=5,NM=0 D ERROR Q
 S $P(^RCT(349,+PSN,0),"^",11,12)=DT_"^"_XMZ
 S (L,L(1))=0 F  S L(1)=$O(^TMP($J,"MSG",L(1))) Q:'L(1)  S L=L+1,^XMB(3.9,+XMZ,2,L,0)=^TMP($J,"MSG",L(1))
 ;S L=$O(^TMP($J,"MSG",""),-1)
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_L_"^"_L_"^"_DT
 D ENT1^XMD
 D NOW^%DTC
 S $P(^RCT(349,+PSN,0),"^",11,12)=%_"^"_XMZ
 K ^TMP($J,"MSG")
 ;D KILL^XM
 Q
 ;
PHCT ;PH count
 S (ERROR,PT,PHCT,TAMT,SZ)=0,RCM=1
 F  S PT=$O(^RCPS(349.2,PT)) Q:'PT  S ERROR=0 D  I ERROR,(ERROR<3) Q
 .S SZ(1)=0 D ERRCHK Q:ERROR
 .S PT0=^RCPS(349.2,+PT,0)
 .S PHCT=PHCT+1
 .S SZ=550+SZ,SZ(1)=550
 .S:$G(^RCPS(349.2,+PT,1))]"" SZ=SZ+$L(^(1)),SZ(1)=SZ(1)+$L(^(1))
 .S:$G(^RCPS(349.2,+PT,3))]"" SZ=SZ+$L(^(3))+1,SZ(1)=SZ(1)+$L(^(3))+1
 .S:$G(^RCPS(349.2,+PT,4))]"" SZ=SZ+$L(^(4))+1,SZ(1)=SZ(1)+$L(^(4))+1
 .S X=0 F  S X=$O(^RCPS(349.2,+PT,2,X)) Q:'X  I $D(^(X,0)) S SZ=$L(^(0))+SZ,SZ(1)=SZ(1)+$L(^(0))
 .S TAMT=TAMT+$P(^RCPS(349.2,+PT,0),"^",8)
 .I SZ>27000 D
 ..S RTY=0 D F349 Q:ERROR
 ..S TAMT=TAMT-$P(PT0,"^",8)
 ..S TAMT=$$HEX^RCCPCFN(TAMT)
 ..S ^TMP($J,"MCT",RCM)=(PHCT-1)_"^"_TAMT_"^"_$O(^RCPS(349.2,PT),-1)_"^"_(SZ-SZ(1))
 ..S ^TMP($J,"MCT",RCM,+PSN)=""
 ..S RCM=RCM+1,PHCT=1
 ..S SZ=SZ(1)
 ..S TAMT=$P(PT0,"^",8)
 I 'PT,$O(^RCPS(349.2,0)) D
 .S RTY=0 D F349 Q:ERROR  S ^TMP($J,"MCT",RCM)=PHCT_"^"_$$HEX^RCCPCFN(TAMT)_"^"_$O(^RCPS(349.2,PT),-1)
 .S ^TMP($J,"MCT",RCM,+PSN)=""
 Q
 ;
ERROR ;ERROR FILE
 I NM=0 S ^TMP($J,"ERROR",ERROR,NM)="" Q
 S ^TMP($J,"ERROR",ERROR,NM,$$SSN^RCFN01(+PT))=""
 Q
 ;
ERRCHK ;Error check
 I '$D(^RCPS(349.2,+PT,0)) S ERROR=1,NM=0 D ERROR Q
 S PT(1)=PT,PT=$O(^RCPS(349.2,0)) I '$P(^RCPS(349.2,PT,0),"^",18) S ERROR=1,NM=0 D ERROR S PT=PT(1) Q
 S PT=PT(1)
 I $$KEY^RCCPCFN(+PT)']"" S ERROR=4,NM=$$NAM^RCFN01(+PT) D ERROR S ^TMP($J,"ERRPT",+PT)="" Q
 I '$D(^RCPS(349.2,"AKEY",$$KEY^RCCPCFN(+PT))) S ERROR=4,NM=$$NAM^RCFN01(+PT) D ERROR S ^TMP($J,"ERRPT",+PT)="" Q
 S ADD=$G(^RCPS(349.2,+PT,1))
 F P=1:1:7 S ADD(P)=$S($P(ADD,"^",P)]"":$P(ADD,"^",P),1:"")
 I ADD(1)="",ADD(2)="",ADD(3)="",ADD(4)="",ADD(5)="",ADD(6)="" S ERROR=8,NM=$$NAM^RCFN01(+PT) D ERROR S ^TMP($J,"ERRPT",+PT)="" Q
 I ADD(1)="",(ADD(2)=""),(ADD(3)=""),(ADD(6)="") S ERROR=8,NM=$$NAM^RCFN01(+PT) D ERROR S ^TMP($J,"ERRPT",+PT)="" Q
 I ADD(4)=""!(ADD(5)="")!(ADD(6)="") S ERROR=8,NM=$$NAM^RCFN01(+PT) D ERROR S ^TMP($J,"ERRPT",+PT)=""
 F ADD=1:1:6 I ADD(ADD)'?.ANP S ERROR=10,NM=$$NAM^RCFN01(+PT),^TMP($J,"ERRPT",+PT)="" D ERROR Q
 I $P($G(^RCD(340,+PT,1)),"^",9) S ^TMP($J,"ERRPT",+PT)="",ERROR=9,NM=$$NAM^RCFN01(+PT) D ERROR
 Q
