PRCFFUC ;WISC/SJG-UTILITY ROUTINE FOR HOLD FUNCTIONALITY ;7/24/00  23:13
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine handles Hold Functionality processing
 QUIT
CURRENT ; Determine current and user-entered accounting periods
 N DATE
 S PARTDT=PRCFA("OBLDATE") D PARTS(PARTDT,.DATE) S (PRCFA("ACCPDCK"),PRCFA("ACCPD"))=DATE
 S DEFDT=DATEZ D PARTS(DEFDT,.DATE) S PRCFA("CURRENT")=DATE
 D NOW^%DTC S CURDT=$$DATE^PRC0C(X,"I"),PARTDT=$$DATE^PRC0C(PARTDT,"I"),DEFDT=$$DATE^PRC0C(DEFDT,"I")
 Q
ACCPD ; Prompt for default accounting period
 N CHKDT,RESP,S1,S2,S3 D K1
 S S1=$P(CURDT,U,8),S2=$P(PARTDT,U,8),S3=$S(S1>S2:CURDT,1:PARTDT)
 S YY=$$TRANS(S3),RESP="YES",DIR(0)="Y"
 S DIR("A",1)="This FMS document will be transmitted on "_YY_" and will"
 S DIR("A",2)="affect the accounting period of "_$P(PRCFA("ACCPD"),U,2)_".  The Accounting"
 S DIR("A",3)="Period affected in FMS will be "_$P(PRCFA("ACCPD"),U)_"."
 S DIR("A",4)="  "
 I $D(PRCFA("MOD")),$P(PRCFA("MOD"),U)="E" S CHKDT=CURDT
 I $D(PRCFA("MOD")),$P(PRCFA("MOD"),U)="M" S CHKDT=DEFDT
 S S1=$E(PRCFA("OBLDATE"),1,5)_"00",S2=$E($P(CHKDT,U,7),1,5)_"00"
 I S1<S2 D
 .N STAR S $P(STAR,"*",80)="",RESP="NO",DIR("A",4.9)=STAR
 .S DIR("A",5)="WARNING:  The Obligation Processing Date entered is not in the"
 .S DIR("A",6)="current accounting period!  Sending this document to FMS with this date may"
 .S DIR("A",7)="cause the document to reject with a Closed Accounting Period error!"
 .S DIR("A",7.1)=STAR,DIR("A",7.2)=" "
 .Q
 S DIR("A")="Is this OK"
 S DIR("?")="Enter '^' to exit this option."
 S DIR("?",1)="Enter 'YES' or 'Y' or 'RETURN' to continue processing."
 S DIR("?",2)="Enter 'NO' or 'N' to change the accounting period."
 S DIR("B")=RESP W ! D ^DIR K DIR,S1,S2 W !
 I $D(DIRUT) S EXIT=1 Q
 I 'Y S EXIT1=0 D CHGOBL D:'EXIT1 NACCPD,CHECK G ACCPD
 Q
CHECK ; Edit checking accounting period, obligation processing date, etc.
 D CHK1^PRCFFUC2 ;,CHK2^PRCFFUC2
 Q
NACCPD ; Prompt for new accounting period
 S HELP=0 D SETUP,K1
 W ! S DIR("0")="SOM^1:January;2:February;3:March;4:April;5:May;6:June;7:July;8:August;9:September;10:October;11:November;12:December"
 S DIR("A")="that this document should affect"
 S DIR("A",1)="Enter the calendar month for the accounting period in the year"
 S DIR("B")=$P($P(PRCFA("ACCPD"),U,2)," ")
 S DIR("?")="^D H1^PRCFFUC1",DIR("??")="^D H2^PRCFFUC1"
 D ^DIR K DIR
 I $D(DTOUT)!($D(DUOUT)) S EXIT=1 Q
 I HELP G NACCPD
 S URESP=Y S URESPX=Y(0) S:URESPX'[" " URESPX=URESPX_$J(" ",URESPX-$L(URESPX))
 S $P(URESP,U,2)=URESPX K Y,URESPX
N1 W ! S %DT="A",%DT("A")="Enter the calendar year for this accounting month: " D ^%DT K %DT I Y<0 W ! D EN^DDIOL("Exit by '^' is not allowed.") G N1
 S NFYR=$E(Y,1,3),NFYR=NFYR+1700,$P(URESP,U,3)=NFYR
 S $P(PRCFA("ACCPD"),U,2)=$P(URESP,U,2)_$P(URESP,U,3)
 S X=$P(PRCFA("ACCPD"),U,2) D ^%DT S $P(PRCFA("ACCPD"),U,3)=Y
 N AP S AP=$$ACCPDMO($P(PRCFA("ACCPD"),U,3)) S $P(PRCFA("ACCPD"),U)=AP
 Q
SETUP ; Backs up one accounting period
 N X,X1,X2,X3,Z
 S X1=$P(PRCFA("ACCPD"),U,3),X3=+$E(X1,4,5)
 S X2=$S(X3=3:28,X3=5!(X3=7)!(X3=10)!(X3=12):30,1:31),X2=-X2
 D C^%DTC
 S X=$E(X,1,5)_"00" D PARTS(X,.Z) S PRCFA("ACCPD")=Z
 Q
CHGOBL ; Change Obligation Processing Date
 N DIR,Y D K1
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")="Do you wish to change the Obligation Processing Date"
 D ^DIR K DIR I 'Y!($D(DIRUT)) D M1 G CHG1
 S Y=PRCFA("OBLDATE")
 D D^PRCFQ S %DT="AEX",%DT("A")="Select Obligation Processing Date: ",%DT("B")=Y
 W ! D ^%DT K %DT I Y<0 D M1
 S (APCKDT,PRCFA("OBLDATE"))=Y,PARTDT=$$DATE^PRC0C(PRCFA("OBLDATE"),"I")
 D PARTS(APCKDT,.DATE) S PRCFA("ACCPDCK")=DATE
CHG1 W ! S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")="Do you wish to change the Accounting Period"
 D ^DIR K DIR I 'Y!($D(DIRUT)) D M2 Q
 W ! D EN^DDIOL("Now enter the appropriate accounting Period.")
 Q
ACCPDMO(A) ; Determine accounting period (calendar -> fiscal)
 N DATE S DATE=$$DATE^PRC0C(A,"I")
 Q $P(DATE,U,9)_$E($P(DATE,U),3,4)
MONTH(X,Y) ; Determine external form of month 
 S Y=$P("January^February^March^April^May^June^July^August^September^October^November^December",U,+X)
 Q Y
TRANS(X) ; Returns date in xx/xx/xx format
 Q $P(X,U,4)_"/"_$P(X,U,5)_"/"_$E($P(X,U,3),3,4)
PARTS(AA,BB) ; Breaks out date into components
 N DATE,CYR,FYR,MO,EXTMO
 S DATE=$$DATE^PRC0C(AA,"I")
 S FYR=$P(DATE,U),CYR=$P(DATE,U,3),MO=$P(DATE,U,4),EXTMO=$$MONTH(MO,"")
 S $P(BB,U)=$P(DATE,U,9)_$E(FYR,3,4),$P(BB,U,2)=EXTMO_" "_CYR
 S X=$P(BB,U,2) D ^%DT S $P(BB,U,3)=Y
 Q
M1 W ! D EN^DDIOL("No change made to Obligation Processing Date.") Q
M2 S EXIT1=1 W ! D EN^DDIOL("No change made to Accounting Period.") Q
K1 K DTOUT,DIRUT,DUOUT Q
