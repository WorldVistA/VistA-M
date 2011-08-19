FBAAUTL1 ;AISC/GRR-Fee Basis Utility Routine ;1/13/98
 ;;3.5;FEE BASIS;**3,12,13**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
PLUSOB ;ENTRY POINT TO INCREASE OBLIGATION ADJUSTMENT
 S FBAAMT="-"_FBAARA
 D ADD Q
 ;D NOW^%DTC S X=FBAAOB_"^"_%_"^^"_FBAAMT_"^"_FBAAB_"^"_FBCOMM,PRCS("TYPE")="FB" D EN2^PRCS58 I +Y=0 W !!,*7,Y,! S FBERR=1 Q
 Q
VALCK ;DETERMINE VALIDITY OF RESPONSE
 S VAL=0 I $E(X)="?"!("YyNn"'[$E(X,1)) D HELPYN Q
 S VAL=1
 Q
HELPYN ;DISPLAY HELP TEXT FOR YES OR NO
 W !!,"Please enter 'Yes' or 'No'."
 Q
GETVET D DT^DICRW S DFN="",U="^" W !! S DIC="^FBAAA(",DIC(0)="AEMQZ",DIC("A")="Select Patient: " D ^DIC K DIC("A"),DIC("S") Q:Y<0  S (D0,DFN)=+Y
 Q
GETAUTH S CNT=0,FTP="" N FB,FBFDT
 I '$D(^FBAAA(DFN,1)) W !!,"PATIENT HAS NO AUTHORIZATIONS " Q
 S FBPROG=$S($D(FBPROG):FBPROG,1:"I 1")
 S FBFDT=9999999 F  S FBFDT=$O(^FBAAA(DFN,1,"B",FBFDT),-1) Q:'FBFDT  D
 . S I=0 F  S I=$O(^FBAAA(DFN,1,"B",FBFDT,I)) Q:'I  I $D(^FBAAA(DFN,1,I,0)) X FBPROG I  S CNT=CNT+1,CNT(CNT)=I
 S PI="" D HOME^%ZIS D ^FBAADEM
 I CNT<1 W !!,"Veteran does NOT have an Authorization for the Fee Program being used !!" G Q
RD I CNT=1 S DIR(0)="Y",DIR("A")="Is this the correct Authorization period (Y/N)",DIR("B")="Yes" D ^DIR K DIR G:Y=0!($D(DIRUT)) NOAUTH S X=1 G 2
CHOOS W !! S DIR(0)="N^1:"_CNT D ^DIR K DIR S X=+Y Q:$D(DUOUT)  G H^XUS:$D(DTOUT)
2 S (FTP,X)=CNT(X),FB=$G(^FBAAA(DFN,1,X,0)),FBAABDT=$P(FB,"^"),FBAAEDT=$P(FB,"^",2),FBTYPE=$P(FB,"^",3),TA=$P(FB,"^",11),FBTT=$P(FB,"^",13),FBPOV=$P(FB,"^",7),FBPT=$P(FB,"^",18),FBPSA=$P(FB,"^",5),FBVEN=$P(FB,"^",4),FB7078=""
 I $P(FB,"^",9)[";FB7078(" S FB7078=+$P(FB,"^",9)
 I $P(FB,"^",9)[";FB583(" S FB583=+$P(FB,"^",9)
 S FBDMRA=$G(^FBAAA(DFN,1,X,"ADEL")) I FBDMRA']"" K FBDMRA
 S FBASSOC=X
 I FB7078]"" S FBVEN=+$P($G(^FB7078(+FB7078,0)),U,2)
Q Q
DAYS ;CALCULATES THE NUMBER OF DAYS IN MONTH
 S X1=X,X=+$E(X,4,5),X=$S("^1^3^5^7^8^10^12^"[("^"_X_"^"):31,X=2:28,1:30)
 I X=28 D
 . N YEAR
 . S YEAR=$E(X1,1,3)+1700
 . I $S(YEAR#400=0:1,YEAR#4=0&'(YEAR#100=0):1,1:0) S X=29
 Q
DATCK2 I $D(FBAABDT),$D(FBAAEDT),Y<FBAABDT!(Y\1>FBAAEDT) W !!,*7,"Date ",$S(Y<FBAABDT:"prior to ",1:"later than "),"Authorization period",! K X Q
 I $D(FBTRT),$D(FBLTD),(9999999.999999-Y)'<FBLTD W !,*7,"There is already an existing admission for this authorization!",! K X
 Q
DATCK3 I $D(FBLTTYP),FBLTTYP]"",FBLTTYP<4,(X-3)'=FBLTTYP W !!,*7,"That transfer type NOT consistent with last transfer type!",! K X
 I $D(FBLTT),FBLTT="A",X>3 W !!,*7,"A 'Transfer From' type transaction can only follow a 'Transfer To' type!",! K X
 Q
WRONGT ;WRONG TYPE OF AUTHORIZATION SELECTED
 W !!,"Authorization type selected inconsistent with option being used" Q
GETVEN ;LOOKUP VENDOR
 W ! S DIC=161.2,DIC(0)="AEQM",IFN="" D ^DIC Q:Y<0  S IFN=+Y Q
HANG ;IF $E(IOST,1,2)["C-" ASK TO CONTINUE
 S DIR(0)="E" D ^DIR K DIR S:'Y FBAAOUT=1 Q
CKOB D STATION^FBAAUTL I $D(FB("ERROR")) K FB("ERROR"),X Q
 S PRC("SITE")=$S($D(PRC("SITE")):PRC("SITE"),1:FBSN) K FBSN,FBAASN
 I '$D(^PRC(442,"B",PRC("SITE")_"-"_X)) W !,"This Obligation number does not exist in the IFCAP file!",! K PRC,X
 Q
CK1358 ;CHECK TO SEE IF 1358 AVAILABLE
 ;FBAAOB=FULL OBLIGATION NUMBER (STA-CXXXXX)
 ;RETURNS Y=1 IF OK
 S PRCS("X")=FBAAOB,PRCS("TYPE")="FB" D EN3^PRCS58 I Y=-1 W !!,*7,"1358 not available for posting!",! S FBERR=1 Q
 Q
NOAUTH S (FTP,X)="" Q
LOCK W !!,*7,"Queueing has been initiated by another user and is now in progress!",!! Q
 ;
XSET ;SET X-REF IN FILE 161.27 FOR LOOK-UP BY SHORT DESCRIPTION
 S ZZ=^FBAA(161.27,DA,2) D TRANS S ^FBAA(161.27,"C",$E(ZZ,1,30),DA)=""
 K ZZ Q
XKILL ;
 S ZZ=^FBAA(161.27,DA,2) D TRANS K ^FBAA(161.27,"C",$E(ZZ,1,30),DA)
 K ZZ Q
 ;
TRANS ;
 S ZZ=$TR(ZZ,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q
 ;
VER() ;no parameters passed
 ;returns 1 if site is running version 4 of IFCAP
 ;S X=$G(^DIC(9.4,+$O(^DIC(9.4,"C","PRC",0)),"VERSION"))
 N X
 S X=$$VERSION^XPDUTL("PRC")
 Q $S(+X=4:1,1:0)
 ;
ADD ;call to add money back into 1358 when version of IFCAP>3.6
 ;uses interface ID look-up to get internal entry number
 ;interface ID = IEN of batch from 161.7
 ;find ien to 424 by $O(^PRC(424,"E",FBN,0))
 ;call NOT used for civil hospital/cnh
 S PRCS("X")=FBAAOB,PRCS("TYPE")="FB" D EN3^PRCS58 I Y=-1 W !!,*7,"1358 not available for posting!",! S FBERR=1 Q
 N FBADDX S FBADDX=$O(^PRC(424,"E",+$G(FBN),0)) I 'FBADDX S FBERR=1 Q
 D NOW^%DTC
 S PRCSX=FBADDX_"^"_%_"^"_FBAAMT_"^"_FBCOMM_"^"_1
 D ^PRCS58CC I Y'=1 W !!,*7,$P(Y,U,2),! S FBERR=1
 Q
