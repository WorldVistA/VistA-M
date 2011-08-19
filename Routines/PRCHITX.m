PRCHITX ;WOIFO/LKG-SELECTING ITEMS USED IN LAST 12 MONTHS ;1/27/05  10:56
 ;;5.1;IFCAP;**75**;OCT 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 D EN^DDIOL("^PRCHITX is not a valid entry point.")
 Q
 ;Output
 ;^TMP($J,"I",Item#,0)=PO_Date^PO#^FCP^FSC^NSN^Mf_Part#^Station#^Stakeholder
 ;^TMP($J,"I",Item#,1)=Vendor_ID^UOP^Pkg_Mult^Stock#^NDC^Contract#
 ;^TMP($J,"V",Vendor#)=Vendor_Name^TIN^POC^Phone#^Accnt#
IN ;Entry point
 N PRCA,PRCB,PRCDT,PRCFILE,PRCI,PRCJ,PRCPODT,PRCSTAT,PRCITM,PRCDATE,PRCCNT,PRCTRANS,PRCX,PRCY,PRCV,X,X1,X2 K ^TMP($J)
 S PRCA=0,PRCCNT=0,PRCDT=$$ONEYRAGO,X1=PRCDT,X2=-1 D C^%DTC S PRCDT=X
 ;Purchase Orders
 S PRCX=PRCDT
 F  S PRCX=$O(^PRC(442,"AB",PRCX)) Q:PRCX=""  D
 . S PRCA=""
 . F  S PRCA=$O(^PRC(442,"AB",PRCX,PRCA)) Q:+PRCA'=PRCA  D
 . . S PRCPODT=$$GETPODT(PRCA) I '$$DATEGTR(PRCPODT,PRCDT) Q
 . . Q:'$$MOPOK(PRCA)
 . . S PRCSTAT=$$GETSTAT(PRCA) Q:'$$STATUSOK(PRCSTAT)
 . . S PRCB=0
 . . F  S PRCB=$O(^PRC(442,PRCA,2,PRCB)) Q:+PRCB'=PRCB  D
 . . . S PRCITM=$$GETITMID(PRCA,PRCB) Q:PRCITM=""
 . . . Q:'$$ITEMACT(PRCITM)  Q:$$NIFITEM(PRCITM)
 . . . S PRCDATE=$P($G(^TMP($J,"I",PRCITM,0)),"^") Q:'$$DATEGTR(PRCPODT,PRCDATE)
 . . . S:'$D(^TMP($J,"I",PRCITM)) PRCCNT=PRCCNT+1
 . . . S ^TMP($J,"I",PRCITM,0)=PRCPODT_"^"_$$GETPONUM(PRCA)_"^"_$$GETFCP(PRCA)_"^"_$$GETFSC(PRCA,PRCB)_"^"_$$GETNSN(PRCA,PRCB)_"^"_$$GETMPNUM(PRCITM)
 . . . S ^TMP($J,"I",PRCITM,1)=$$GETVENDR(PRCA)_"^"_$$GETUOP(PRCA,PRCB)_"^"_$$GETPKGM(PRCA,PRCB)_"^"_$$GETSTKNO(PRCA,PRCB)_"^"_$$GETNDC(PRCA,PRCB)_"^"_$$GETCONTR(PRCA,PRCB)
 S ^TMP($J,"I")=PRCCNT
 ;Reusable Items
 S PRCITM=0
 F  S PRCITM=$O(^PRC(441,PRCITM)) Q:+PRCITM'=PRCITM  D
 . Q:$D(^TMP($J,"I",PRCITM))  Q:'$$ITEMACT(PRCITM)  Q:'$$REUSABLE(PRCITM)  Q:$$NIFITEM(PRCITM)
 . S PRCCNT=PRCCNT+1,^TMP($J,"I",PRCITM,0)="^^"_$$FCP(PRCITM)_"^"_$$FSC(PRCITM)_"^"_$$NSN(PRCITM)_"^"_$$GETMPNUM(PRCITM)
 . S PRCI=$$LASTVDR(PRCITM) S:PRCI="" PRCI=$$VDRLSTD(PRCITM)
 . I PRCI>0 D
 . . I $P($G(^PRC(440,PRCI,10)),"^",5),$P($G(^PRC(440,PRCI,9)),"^")>0 S PRCV=$P(^(9),"^") I $P($G(^PRC(440,PRCV,10)),"^",5)'=1,$D(^PRC(441,PRCITM,2,PRCV)) S PRCI=PRCV
 . . S ^TMP($J,"I",PRCITM,1)=PRCI_"^"_$$UOP(PRCITM,PRCI)_"^"_$$PKGMULT(PRCITM,PRCI)_"^"_$$STKNO(PRCITM,PRCI)_"^"_$$NDC(PRCITM,PRCI)_"^"_$$CONTRACT(PRCITM,PRCI)
 S ^TMP($J,"I")=PRCCNT
 ;Inventory Transactions
 S PRCX="",PRCITM="",PRCA="",PRCTRANS=";A;RC;R;U;C;S;E;"_$S(PRCPHYS="Y":"P;",1:"")
 F  S PRCX=$O(^PRCP(445.2,"AD",PRCX)) Q:PRCX=""  D
 . F  S PRCITM=$O(^PRCP(445.2,"AD",PRCX,PRCITM)) Q:PRCITM=""  D
 . . Q:$D(^TMP($J,"I",PRCITM))  Q:'$$ITEMACT(PRCITM)  Q:$$NIFITEM(PRCITM)
 . . S PRCA=""
 . . F  S PRCA=$O(^PRCP(445.2,"AD",PRCX,PRCITM,PRCA)) Q:PRCA=""  D  Q:$D(^TMP($J,"I",PRCITM))
 . . . S PRCY=$G(^PRCP(445.2,PRCA,0)) Q:PRCY=""
 . . . Q:PRCTRANS'[(";"_$P(PRCY,"^",4)_";")
 . . . Q:'$$DATEGTR($P(PRCY,"^",17),PRCDT)
 . . . S PRCCNT=PRCCNT+1,^TMP($J,"I",PRCITM,0)="^^"_$$FCPINV(PRCA)_"^"_$$FSC(PRCITM)_"^"_$$NSN(PRCITM)_"^"_$$GETMPNUM(PRCITM)
 . . . S PRCI=$$LASTVDR(PRCITM) S:PRCI="" PRCI=$$INVVNDR(PRCA) S:PRCI="" PRCI=$$VDRLSTD(PRCITM)
 . . . I PRCI>0 D
 . . . . I $P($G(^PRC(440,PRCI,10)),"^",5),$P($G(^PRC(440,PRCI,9)),"^")>0 S PRCV=$P(^(9),"^") I $P($G(^PRC(440,PRCV,10)),"^",5)'=1,$D(^PRC(441,PRCITM,2,PRCV)) S PRCI=PRCV
 . . . . S ^TMP($J,"I",PRCITM,1)=PRCI_"^"_$$UOP(PRCITM,PRCI)_"^"_$$PKGMULT(PRCITM,PRCI)_"^"_$$STKNO(PRCITM,PRCI)_"^"_$$NDC(PRCITM,PRCI)_"^"_$$CONTRACT(PRCITM,PRCI)
 S ^TMP($J,"I")=PRCCNT
 ;Case carts and instrument kits - processing items
 F PRCFILE=445.7,445.8 S PRCJ=0 F  S PRCJ=$O(^PRCP(PRCFILE,"B",PRCJ)) Q:PRCJ=""  D
 . Q:'$$ITEMACT(PRCJ)  Q:$$NIFITEM(PRCJ)
 . S PRCITM=0 F  S PRCITM=$O(^PRCP(PRCFILE,PRCJ,1,PRCITM)) Q:+PRCITM'=PRCITM  D
 . . Q:$D(^TMP($J,"I",PRCITM))  Q:'$$ITEMACT(PRCITM)  Q:$$NIFITEM(PRCITM)
 . . S PRCCNT=PRCCNT+1,^TMP($J,"I",PRCITM,0)="^^"_$$FCP(PRCITM)_"^"_$$FSC(PRCITM)_"^"_$$NSN(PRCITM)_"^"_$$GETMPNUM(PRCITM)
 . . S PRCI=$$LASTVDR(PRCITM) S:PRCI="" PRCI=$$VDRLSTD(PRCITM) S:PRCI>0 ^TMP($J,"I",PRCITM,1)=PRCI_"^"_$$UOP(PRCITM,PRCI)_"^"_$$PKGMULT(PRCITM,PRCI)_"^"_$$STKNO(PRCITM,PRCI)_"^"_$$NDC(PRCITM,PRCI)_"^"_$$CONTRACT(PRCITM,PRCI)
 S ^TMP($J,"I")=PRCCNT
 ;Compiling vendor info
 S PRCI="",PRCCNT=0
 F  S PRCI=$O(^TMP($J,"I",PRCI)) Q:PRCI=""  D
 . S X=$P($G(^TMP($J,"I",PRCI,1)),"^") Q:X=""
 . S:'$D(^TMP($J,"V",X)) ^TMP($J,"V",X)=$$GETVNAME(X)_"^"_$$GETTIN(X)_"^"_$$GETPOC(X)_"^"_$$GETPHONE(X)_"^"_$$ACCNT(X),PRCCNT=PRCCNT+1
 S ^TMP($J,"V")=PRCCNT
 Q
ONEYRAGO() ;Returns FileMan date of one year ago
 N X S:'$D(DT) DT=$$DT^XLFDT S X=$E(DT,1,3)-1_$E(DT,4,7)
 Q X
DATEGTR(X,Y) ;Tests if first date is greater than second
 I X>Y Q 1
 Q 0
GETPONUM(PRCDA) ;Returns PO Number
 N X S X=$P($G(^PRC(442,PRCDA,0)),"^")
 Q X
GETSTAT(PRCDA) ;Returns Supply Status Order
 N X S X=$P($G(^PRC(442,PRCDA,7)),"^") I X="" Q X
 S X=$P($G(^PRCD(442.3,X,0)),"^",2)
 Q X
STATUSOK(X) ;Checks if Supply Status Order value okay for selection
 I ";;1;5;6;45;"[(";"_X_";") Q 0
 Q 1
GETPODT(PRCDA) ;Returns P.O. Date in FileMan date format
 Q $P($G(^PRC(442,PRCDA,1)),"^",15)
GETFCP(PRCDA) ;Returns Fund Control Point
 Q $P($G(^PRC(442,PRCDA,0)),"^",3)
MOPOK(PRCDA) ;Checks Method of Processing
 N X S X=$P($G(^PRC(442,PRCDA,0)),"^",2) I X="" Q 0
 S X=$P($G(^PRCD(442.5,X,0)),"^",2) I X="" Q 0
 I ";IS;1358;TA;OTA;AR;"[(";"_X_";") Q 0
 Q 1
GETVENDR(PRCDA) ;Returns Vendor ID
 N X S X=$P($G(^PRC(442,PRCDA,1)),"^")
 Q X
GETITMID(PRCDA,PRCDA1) ;Returns Item Master File Ien
 N X S X=$P($G(^PRC(442,PRCDA,2,PRCDA1,0)),"^",5)
 Q X
GETUOP(PRCDA,PRCDA1) ;Returns Unit of Purchase
 N X S X=$P($G(^PRC(442,PRCDA,2,PRCDA1,0)),"^",3) I X="" Q X
 S X=$P($G(^PRCD(420.5,X,0)),"^")
 Q X
GETPKGM(PRCDA,PRCDA1) ;Returns Packaging Multiple
 N X S X=$P($G(^PRC(442,PRCDA,2,PRCDA1,0)),"^",12)
 Q X
GETFSC(PRCDA,PRCDA1) ;Returns Federal Supply Classification
 N X S X=$P($G(^PRC(442,PRCDA,2,PRCDA1,2)),"^",3)
 I X="" S X=$E($P($G(^PRC(442,PRCDA,2,PRCDA1,0)),"^",13),1,4)
 Q X
GETNSN(PRCDA,PRCDA1) ;Returns National Stock Number
 N X S X=$P($G(^PRC(442,PRCDA,2,PRCDA1,0)),"^",13)
 Q X
GETSTKNO(PRCDA,PRCDA1) ;Returns Vendor Stock Number
 N X S X=$P($G(^PRC(442,PRCDA,2,PRCDA1,0)),"^",6)
 Q X
GETNDC(PRCDA,PRCDA1) ;Returns National Drug Code
 N X S X=$P($G(^PRC(442,PRCDA,2,PRCDA1,0)),"^",15)
 Q X
GETCONTR(PRCDA,PRCDA1) ;Returns Contract/BOA #
 N X S X=$P($G(^PRC(442,PRCDA,2,PRCDA1,2)),"^",2)
 Q X
ITEMACT(X) ;Checks if item is active
 I '$D(^PRC(441,X)) Q 0
 I $P($G(^PRC(441,X,3)),"^")=1 Q 0
 Q 1
GETMPNUM(X) ;Returns Manufacturer Part Number
 S X=$P($G(^PRC(441,X,3)),"^",5)
 Q X
GETSDESC(X) ;Returns Item Short Description
 S X=$P($G(^PRC(441,X,0)),"^",2)
 Q X
GETVNAME(X) ;Returns Vendor Name
 S X=$P($G(^PRC(440,X,0)),"^")
 Q X
GETTIN(X) ;Returns Tax ID Number or Social Security Number
 S X=$P($G(^PRC(440,X,3)),"^",8)
 Q X
GETPOC(X) ;Returns Vendor Point of Contact
 S X=$P($G(^PRC(440,X,0)),"^",9)
 Q X
GETPHONE(X) ;Returns Vendor's Phone Number
 S X=$P($G(^PRC(440,X,0)),"^",10)
 Q X
REUSABLE(PRCDA) ;Returns 1 if item is reusable or 0 if not
 N X S X=$P($G(^PRC(441,PRCDA,0)),"^",13) S X=$S(X="y":1,1:0)
 Q X
LASTVDR(PRCDA) ;Returns vendor ID
 N X S X=$P($G(^PRC(441,PRCDA,0)),"^",4)
 Q X
CONTRACT(PRCDA,PRCDA1) ;Returns Contract #
 N X S X=$P($G(^PRC(441,PRCDA,2,PRCDA1,0)),"^",3)
 S X=$S(X>0:$P($G(^PRC(440,PRCDA1,4,X,0)),"^"),1:"")
 Q X
STKNO(PRCDA,PRCDA1) ;Returns vendor stock #
 N X S X=$P($G(^PRC(441,PRCDA,2,PRCDA1,0)),"^",4)
 Q X
UOP(PRCDA,PRCDA1) ;Returns Unit of Purchase
 N X S X=$P($G(^PRC(441,PRCDA,2,PRCDA1,0)),"^",7)
 I X'="" S X=$P($G(^PRCD(420.5,X,0)),"^")
 Q X
PKGMULT(PRCDA,PRCDA1) ;Returns Packaging Multiple
 N X S X=$P($G(^PRC(441,PRCDA,2,PRCDA1,0)),"^",8)
 Q X
NDC(PRCDA,PRCDA1) ;Returns NDC
 N X S X=$P($G(^PRC(441,PRCDA,2,PRCDA1,0)),"^",5)
 Q X
FSC(PRCDA) ;Returns Federal Supply Classification
 N X S X=$P($G(^PRC(441,PRCDA,0)),"^",3)
 I X="" S X=$E($P($G(^PRC(441,PRCDA,0)),"^",5),1,4)
 Q X
NSN(PRCDA) ;Returns National Stock Number
 N X S X=$P($G(^PRC(441,PRCDA,0)),"^",5)
 Q X
FCP(PRCDA) ;Returns FCP
 N X,PRCA,PRCB,PRCX,PRCI S PRCI=0,PRCX=""
 F  S PRCI=$O(^PRC(441,PRCDA,4,PRCI)) Q:+PRCI'=PRCI  D  Q:PRCX'=""
 . S X=$P($G(^PRC(441,PRCDA,4,PRCI,0)),"^") Q:X=""
 . S PRCA=+$E(X,1,3),PRCB=+$E(X,4,99)
 . Q:$P($G(^PRC(420,PRCA,1,PRCB,0)),"^",19)
 . S PRCX=$P($G(^PRC(420,PRCA,1,PRCB,0)),"^")
 Q PRCX
DATE(X) ;Processes date in VA FileMan format and returns date as 'DD-MON-YYYY'
 Q:$P(X,".")'?7N ""
 N Y,Z
 S Y=X#100,Y=$S(Y>0:$E(100+Y,2,3)_"-",1:"")
 S Z=$P("JAN;FEB;MAR;APR;MAY;JUN;JUL;AUG;SEP;OCT;NOV;DEC",";",X#10000\100) S:Z'="" Z=Z_"-"
 S X=Y_Z_(X\10000+1700)
 Q X
GETSTATN() ;Returns station number of VistA installation
 N X
 S X=$$GET1^DIQ(4,$$KSP^XUPARAM("INST")_",",99)
 Q X
NIFITEM(X) ;Checks if item already has NIF Item #
 N Y S Y=0
 I X>0 S:+$P($G(^PRC(441,X,0)),"^",15)>0 Y=1
 Q Y
ACCNT(X) ;Returns vendor account number
 N Y S Y=""
 S:X>0 Y=$P($G(^PRC(440,X,2)),"^")
 Q Y
VDRLSTD(X) ;Returns vendor with highest ID from item's VENDOR multiple
 N Y S Y=""
 S:X>0 Y=$O(^PRC(441,X,2,"B",""),-1)
 Q Y
INVVNDR(PRCX) ;Returns inv's mandatory/requested source of item on trxn
 N Y,PRCINV,PRCY,PRCZ S Y="" Q:PRCX'>0 Y
 S PRCZ=$G(^PRCP(445.2,PRCX,0)),PRCY=$P(PRCZ,"^",5) Q:PRCY'>0 Y
 S PRCINV=$P(PRCZ,"^"),PRCZ="" S:PRCINV>0 PRCZ=$P($G(^PRCP(445,PRCINV,1,PRCY,0)),"^",12)
 I $P(PRCZ,";",2)="PRC(440," S PRCZ=$P(PRCZ,";") S:PRCZ>0 Y=$S($P($G(^PRC(440,PRCZ,0)),"^",11)'="S":PRCZ,1:"")
 Q Y
FCPINV(PRCX) ;Get FCP for Inv Transaction
 N Y S Y="" Q:PRCX'>0 Y
 N PRCINV S PRCINV=$P($G(^PRCP(445.2,PRCX,0)),"^")
 I PRCINV>0 D
 . N PRCSTA,PRCDA S PRCDA="",PRCSTA=$P($G(^PRCP(445,PRCINV,0)),"-")
 . S:PRCSTA'="" PRCDA=$O(^PRC(420,"AE",PRCSTA,PRCINV,""))
 . S:PRCDA>0 Y=$P($G(^PRC(420,PRCSTA,1,PRCDA,0)),"^")
 Q Y
