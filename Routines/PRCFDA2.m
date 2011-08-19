PRCFDA2 ;WISC@ALTOONA/CTB/BGJ-PROCESS PAYMENT TO FMS ; 9/28/99 4:12pm
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN S PRCTXD=$P($G(^PRCF(421.5,PRCF("CIDA"),1)),U,19)
 S DIE=421.5,DA=PRCF("CIDA")
 S DR="71R//^S X=$$DATE^PRCFDA2(PRCF(""PODA""),PRC10DA);S PRCTXD=$E(X,1,5)*100;72////^S X=PRCTXD;S Y=""@1"";@1;72R//^S X=$$MONYR^PRCFDA2(PRCTXD)"
 D ^DIE K DIE,DR,DA I $D(DTOUT)!$D(Y) G OT^PRCFDA
 S PRCF("MOP")=$P($G(^PRC(442,PRCF("PODA"),0)),U,2)
 S X=$P($P($G(^PRC(442,PRCF("PODA"),10,1,0)),U),".",1,2)
 S PRCF("TC")=$P(X,".",1)
 S PRCF("TC")=$S(PRCF("TC")?2U:PRCF("TC"),PRCF("MOP")=2:"SO",PRCF("MOP")=21:"SO",1:"MO")
 I PRCF("TC")="SO" D
 . N PRCFATT
 . S PRCFATT=PRCF("TC")
 . D SOAR^PRC0E(PRCF("PODA"),.PRCFATT,2) ; ask post against SO OR AR?
 . S PRCF("TC")=PRCFATT
 I "^AR^SO^MO"'[("^"_PRCF("TC")) G OT^PRCFDA
 S X=$P($G(^PRCF(421.5,PRCF("CIDA"),1)),U,19,20),Y=$P(X,U,2),X=$P(X,U)
 S:$G(DT)>X X=DT S DIR(0)="YA",DIR("B")="YES"
 S DIR("A",1)="Your FMS document will be transmitted on "_$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)_" and will affect the"
 S DIR("A")="accounting period "_$$MONYR(Y)_".  Is this okay? "
 D ^DIR K DIR G OT^PRCFDA:$D(DIRUT),EN:Y<1
SIG D SIG^PRCFACX0 I $D(PRCFA("SIGFAIL")) K PRCFA("SIGFAIL") G OT^PRCFDA
 S DA=PRCF("CIDA"),MESSAGE=""
 D REMOVE^PRCFDES2(DA),ENCODE^PRCFDES2(DA,DUZ,.MESSAGE)
 K MESSAGE,DA
 S ACTION="E" K ^TMP($J,"PRCPV")
 ;I $D(PRCFA("ERROR PROCESSING")) S ACTION="M"
 S N1=$G(^PRCF(421.5,PRCF("CIDA"),1))
 S PRCF("PO")=$P(N1,U,3),PRCF("PA")=$P(N1,U,6)
 I PRCF("PA")="" D  G:PRCF("PA")="" EX
NEXT . ; Obtain next available Partial# for the PO
 . N K,DA S K=0,Y=$O(^PRCF(421.9,"B",PRCF("PO"),0))
 . I Y="" S X=PRCF("PO"),DIC="^PRCF(421.9,",DLAYGO=421.9,DIC(0)="XL"
 . I Y="" K DO,DINUM,DIC("DR") D FILE^DICN S %=0 K DIC,DLAYGO Q:Y<0
 . S DA=Y
 . S Y1=$P(^PRCF(421.9,+DA,0),"^",2)+1
 . I Y1>949,Y1<974 S X="WARNING:  This partial, number "_Y1_", is approaching the limit of 974 permitted by the system." W !! D MSG^PRCFQ W $C(7),$C(7),$C(7),$C(7)
 . I Y1=974 S X="WARNING:  This partial, number "_Y1_", is the last permitted by the system." W !! D MSG^PRCFQ W $C(7),$C(7),$C(7),$C(7)
 . I Y1=974 S DIR(0)="Y",DIR("A")="Do you wish to continue",DIR("B")="NO" D ^DIR I $D(DIRUT)!(Y=0) K DIR,Y1,DA Q
 . I Y1>974 S X="WARNING:  THIS PARTIAL, NUMBER "_Y1_", HAS EXCEEDED THE SYSTEM LIMIT OF 974.  UNABLE TO PROCESS THIS TRANSACTION." D  Q
 . . S X=X_"  IF NECESSARY, A PV DOCUMENT WILL HAVE TO BE CREATED ON-LINE IN FMS." W !! D MSG^PRCFQ W $C(7),$C(7),$C(7),$C(7) K Y1,DA
 . L +^PRCF(421.9):5 I '$T S X="Partial Number file unavailable - File lock timeout.*" D MSG^PRCFQ K Y1,DA,DIR Q
 . S Y(0)=^PRCF(421.9,+DA,0),Y1=$P(Y(0),"^",2)+1
 . S $P(^PRCF(421.9,+DA,0),"^",2)=Y1
 . L -^PRCF(421.9) D ALPHA^PRCFPAR(Y1,.X) S PRCF("PA")=X
 . K Y(0),Y1,X,DA,DIR
 . S $P(^PRCF(421.5,PRCF("CIDA"),1),U,6)=PRCF("PA")
 . Q
 ;
 S:PRCF("PA")?1N PRCF("PA")="0"_PRCF("PA")
 S XPO=$P(PRCF("PO"),"-",1)_$P(PRCF("PO"),"-",2)_PRCF("PA")
 S PRCF("TN")=$E(XPO,1,9)_$S(PRCF("TC")="AR":12,1:"  ")
 S X="Transferring invoice data to PV document for transmission to FMS.*"
 W ! D MSG^PRCFQ,NEW^PRCFD8(PRCF("CIDA"),ACTION)
 I '$D(PRCFA("ERROR PROCESSING")) D  G:'$D(GECSFMS("DA")) EX
 . I $G(^%ZOSF("TEST")) S X="GECSUFMS" X ^%ZOSF("TEST") I '$T S X="Generic Code Sheet routine GECSUFMS missing - cannot continue.*" D MSG^PRCFQ Q
 . D CONTROL^GECSUFMS("I",+PRC("SITE"),XPO,"PV",$$SEC1^PRC0C(PRC("SITE")),0,"","Payment Voucher")
 . I '$D(GECSFMS("DA")) S X="No new FMS Payment Voucher created - Files inaccessible at this time.*" D MSG^PRCFQ
 . Q
 I $D(PRCFA("ERROR PROCESSING")) S CODESHET=0 D  G:'$D(GECSDATA) EX
 . I $G(^%ZOSF("TEST")) S X="GECSSGET" X ^%ZOSF("TEST") I '$T S X="Generic Code Sheet routine GECSSGET missing - cannot continue.*" D MSG^PRCFQ Q
 . S DOCID="PV-"_XPO D DATA^GECSSGET(DOCID,CODESHET)
 . I '$D(GECSDATA) S X="FMS Payment Voucher not rebuilt or transmitted - could not locate original PV in local stack file.*" D MSG^PRCFQ Q
 . S PRCFD("STACK")=GECSDATA
 . I $G(^%ZOSF("TEST")) S X="GECSUFM1" X ^%ZOSF("TEST") I '$T S X="Generic Code Sheet routine GECSUFM1 missing - cannot continue.*" D MSG^PRCFQ K GECSDATA Q
 . D REBUILD^GECSUFM1(GECSDATA,"I",$$SEC1^PRC0C(PRC("SITE")),"","Payment Voucher Retransmission")
 . Q
 I $D(GECSFMS("DA"))=0,+$G(PRCFD("STACK")) S GECSFMS("DA")=PRCFD("STACK")
 I $G(^%ZOSF("TEST")) S X="GECSSTAA" X ^%ZOSF("TEST") I '$T S X="Generic Code Sheet routine GECSSTAA missing - cannot continue.*" D MSG^PRCFQ G EX
 S IX=0 F  S IX=$O(^TMP($J,"PRCPV",IX)) Q:'IX  D SETCS^GECSSTAA(GECSFMS("DA"),^(IX))
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 S X="PV document is complete and is queued for transmission to FMS.*"
 ; Save GECS Stack File PV # in Invoice record:
 S DIE=421.5,DA=PRCF("CIDA"),DR="27///^S X=XPO" D ^DIE K DA,DIE,DR
 D MSG^PRCFQ S X=20 D STATUS^PRCFDE1
 ; Post FMS Document Information to Purchase Order:
 S PRCFA("SYS")="FMS",PRCFA("PODA")=PRCF("PODA"),POESIG=1
 S XA="PV",XB=0 S:ACTION="M" XB=1
 S XC=$P($G(^PRCF(421.5,PRCF("CIDA"),1)),U,19) S:XC="" XC=$P(^PRCF(421.5,PRCF("CIDA"),0),U,5)
 S XD=$P(PRCF("PO"),"-",2)
 D EN7^PRCFFU41(XA,XB,XC,XD)
EX L:$D(PRCF("CIDA")) -^PRCF(421.5,PRCF("CIDA"))
 K ACTION,N1,XPO,IX,XA,XB,XC,XD,DOCID,GECSDATA,GECSFMS,POESIG
 K BOC,CNT,LAMT,D0,LD,FMSTYPE,GO,LABEL,LOOP
 K RECORD,RECORD1,RESP,RETRAN,STATUS,TXT,VAR,PRCFX,MOP,PO,PONUM,PRC
 K PRCF,PRCFD,PRC10DA,PRCTXD,X,Y,FMSLN,IEN,DIC
 K PRCTMP,PATDA,CODESHET
 K ^TMP($J,"PRCPV")
 I $D(PRCFA("ERROR PROCESSING")),PRCFA("ERROR PROCESSING")'=2 K PRCFA Q
 K PRCFA
 I $D(DUOUT)!$D(DTOUT)!$D(DIRUT)!$D(DIROUT) K DUOUT,DTOUT,DIRUT,DIROUT Q
 G ^PRCFDA
 ;
DATE(A,B) ;Returns in external format, the greater of Today and the
 ;original obligation date
 N X,Y S X=$P($P($G(^PRC(442,A,10,B,0)),U),".",3)
 S:X'="" X=$S(+$E(X,5,6)<80:3,1:2)_$E(X,5,6)_$E(X,1,2)_$E(X,3,4)
 S:$P($G(DT),".")>X X=$P(DT,".")
 S Y=$P("JAN~FEB~MAR~APR~MAY~JUN~JUL~AUG~SEP~OCT~NOV~DEC","~",+$E(X,4,5))
 S Y=Y_" "_+$E(X,6,7)_", "_(1700+$E(X,1,3))
 Q Y
MONYR(X) ;Returns External Month and Day from FileMan Date
 N Y
 I X'?7N.E S Y="" Q Y
 S Y=$P("JAN~FEB~MAR~APR~MAY~JUN~JUL~AUG~SEP~OCT~NOV~DEC","~",+$E(X,4,5))
 S Y=Y_" "_(1700+$E(X,1,3))
 Q Y
ASK ; If there are more than one BOC on the obligation ask the user for 
 ; the BOC to be processed.
 S DIR(0)="NO"
 N PRCFBOC S PRCFBOC=""
 S DIR("A")="Select FMS LINE BOC: "
 S DIR("B")=$O(PRCFX("SA",PRCFBOC))
 S DIR("?")="^D HELP^PRCFDA2"
 S DIR("??")="^W !!?15,""You may only enter a BOC from Obligation ""_PRCF(""CIDA"")"
 D ^DIR I $D(DIRUT) S PRCFEX=1 Q
 I '$D(DIRUT) S PRCFFLG=1
 I '$D(PRCFX("SA",X)) K X W "??" G BOC^PRCFDA
 S BOC=Y
ASK2 ;checks to see if there are >1 FMS lines on a particular BOC
 ;also an entry pointfor when there is only 1 BOC to check to
 ;if there are >1 FMS line on that BOC
 N CNT2,PRCFEE,PRCNOBOC S CNT2=""
 S PRCFNUM="" F  S PRCFNUM=$O(PRCFX("SA",BOC,PRCFNUM)) Q:'PRCFNUM  S CNT2=CNT2+1
 I CNT2>1 D  I $G(PRCNOBOC)=1 G BOC^PRCFDA
 . W !!,"Choose from: "
 . S PRCFEE="" F  S PRCFEE=$O(PRCFX("SA",BOC,PRCFEE)) Q:'PRCFEE  W !?5,PRCFEE_"   "_BOC_"   "_$S($P($G(PRCFX("SA",BOC,PRCFEE)),U,2)=991:"Shipping",1:"Goods/Services")
 . S DIR(0)="NOA"
 . S DIR("A")="Enter the number of your choice: "
 . S DIR("T")=30
 . D ^DIR I $D(DIRUT) S PRCFEXIT=1 Q
 . I '$D(DIRUT) S PRCFFLG=1
 . I '$D(PRCFX("SA",BOC,X)) K X W "??" S PRCNOBOC=1
 . S PRCFNUM=Y
 . Q
 I CNT2=1 S PRCFNUM=0 S PRCFNUM=$O(PRCFX("SA",BOC,PRCFNUM)) I $G(CNT1)=1 S PRCFFLG=2
 Q
HELP ;Help for BOC look-up
 N NUM,NUM2
 W ?5,"Answer with a BOC from this Obligation.",!
 S NUM=""
 S NUM=$O(PRCFX("SA",NUM)) Q:'NUM  D
 . I $O(PRCFX("SA",NUM))]"" W !?10,"Choose from: " Q
 S (NUM,NUM2)=""
 F  S NUM=$O(PRCFX("SA",NUM)) Q:'NUM  D
 . F  S NUM2=$O(PRCFX("SA",NUM,NUM2)) Q:'NUM2  D
 . . W !?15,NUM,"    ",$S($P(PRCFX("SA",NUM,NUM2),U,2)=991:"Shipping",1:"Goods/Services")
 Q
