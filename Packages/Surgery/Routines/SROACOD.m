SROACOD ;BIR/SJA - ALERT CODERS OF POTENTIAL CODING ISSUES ;04/18/06
 ;;3.0; Surgery ;**146,152**;24 Jun 93
 I '$D(SRTN) K SRNEWOP D ^SROPS G:'$D(SRTN) END S SRTN("KILL")=1
 N I,J,SRCPTP,SRLN,SRNODE0,SRPOST,SRTXT,SRSOUT,SRSUPCPT,X,XX,Y
 S SRSOUT=0,SRSUPCPT=1 D ^SROAUTL
START G:SRSOUT END K SRAOTH
 D HDR^SROAUTL
 W !,"The following ""final"" codes have been entered for the case.",!!
 S X=$P($G(^SRO(136,SRTN,0)),"^",2) I X S Y=$P($$CPT^ICPTCOD(X),"^",2) D SSPRIN^SROCPT0 S X=Y
 W "Principal CPT Code: ",$S($L(X):X,1:"NOT ENTERED") S SRCPTP=X
 N SRPROC,K,SRL
 S SRPROC(1)="",SRL=60,K=1 D OTH^SROUTLN W !,"Other CPT Codes: "_$S(SRPROC(1)="":"   NOT ENTERED",1:"")
 F I=1:1 Q:'$D(SRPROC(I))  W:I=1 ?20,$P(SRPROC(I),", ",2,99),! W:I'=1 ?20,SRPROC(I),!
 S X=$P($G(^SRO(136,SRTN,0)),"^",3) S:X X=$$ICDDX^ICDCODE(X,$P($G(^SRF(SRTN,0)),"^",9)),X=$P(X,"^",2)_"   "_$P(X,"^",4)
 W "Postop Diagnosis Code (ICD9): ",$S(X'="":X,1:"NOT ENTERED"),! S SRPOST=X
 W !!,"If you believe that the information coded is not correct and would like to",!,"alert the coders of the potential issue, enter a brief description of your",!,"concern below.",!
 D ASK G:SRSOUT END
 K ^TMP($J,"SRC")
ED W ! S DIC="^TMP($J,""SRC"",",DIWESUB="Coding Discrepancy Comments" D EN^DIWE
 I '$D(^TMP($J,"SRC")) W !,"NOTE:   You have exited the field without entering comments. ",!
 W ! K DIR S DIR("A",1)="1. Transmit Message",DIR("A",2)="2. Edit Text",DIR("A",3)="",DIR("A")="Select Number: "
 S DIR(0)="NA^1:2",DIR("B")=1,DIR("?",1)="Enter <RET> or '1' to Transmit Message,"
 S DIR("?")="enter '2' to Edit the text or enter '^' to exit." D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) G END
 I Y=2 G ED
MSG I '$P($G(^SRO(136,SRTN,10)),"^")&('$P($G(^SRO(133,SRSITE,7)),"^",2)) D ERR G END
 K SR,XMY S SRNODE0=$G(^SRF(SRTN,0))
 S SR(1)="Patient: "_$E(VADM(1),1,20)_$J("",30-$L(VADM(1)))_" Case #: "_SRTN
 S Y=$P(SRNODE0,"^",9) D DD^%DT S SR(2)="Operation Date: "_Y
 S SR(3)=""
 S SR(4)="The following ""final"" codes have been entered for the case."
 S DFN=$P(SRNODE0,"^") D DEM^VADPT
 S SR(5)=""
 S SR(6)="  Principal CPT Code: "_SRCPTP
 S SRLN=6 F I=1:1 Q:'$D(SRPROC(I))  S SRLN=SRLN+1 S:I=1 SR(SRLN)="  Other CPT Codes: "_$P(SRPROC(I),", ",2,99) S:I>1 SR(SRLN)=$J(SRPROC(I),$L(SRPROC(I))+19)
 S SRLN=SRLN+1,SR(SRLN)="  Postop Diagnosis Code (ICD9): "_SRPOST
 S SRLN=SRLN+1,SR(SRLN)="",SRLN=SRLN+1
 S I=0 F  S I=$O(^TMP($J,"SRC",I)) Q:'I  S SR(SRLN)=$G(^(I,0)),SRLN=SRLN+1
 S I=0 F  S I=$O(^SRO(136,SRTN,11,I)) Q:'I  S XX=$G(^(I,0)) I $P(XX,"^") S XMY($P(XX,"^"))=""
 S XMY(DUZ)=""
 S X=$P($G(^SRO(133,SRSITE,7)),"^",2) I X S X=$$GET1^DIQ(3.8,X,.01) S:X]"" XMY("G."_X)=""
 S XMSUB="Surgery Coding Issues" D NOW^%DTC S Y=% X ^DD("DD")
 S XMTEXT="SR(" D ^XMD K XMTEXT,XMY,XMSUB,^TMP($J,"SRC")
 W !!,"Transmitting message..."
END W @IOF D ^SRSKILL I $D(SRTN("KILL")) K SRTN
 Q
ASK K DIR S DIR(0)="Y",DIR("A")="Do you want to alert the coders (Y/N)",DIR("B")="YES" D ^DIR S:'Y SRSOUT=1
 Q
ERR ;The Coding Issue Alert cannot be created at this time
 D EN^DDIOL("The information needed to send a code issue mail message is",,"!!")
 D EN^DDIOL("not entered.  Because the coding is not completed, no coder",,"!")
 D EN^DDIOL("is identified. Also, there is no mail group identified in the",,"!")
 D EN^DDIOL("CODE ISSUE MAIL GROUP site parameter.",,"!")
 D EN^DDIOL("To send a coding issue message the case must have either the",,"!!")
 D EN^DDIOL("coder or mail group identified.",,"!")
 W ! K DIR S DIR(0)="FOA",DIR("A")="Press RETURN to continue  " D ^DIR K DIR
 Q
