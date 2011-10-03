PRCUDCT1 ;WISC/LEM-Index FMS Document Transaction Rejects ;5/24/94  9:05 AM
V ;;5.0;IFCAP;;4/21/95
 ; This is a utility routine not accessible through IFCAP menus.
 Q
PERROR ; Process Errors
 N XMDUN,XMSUB,XMTEXT,XMB,XMY,XMZ S PRCEND=""
 ;I $D(PRCMG) S:PRCMG'["G." PRCMG="G."_PRCMG S X=PRCMG,XMDUZ="IFCAP FMS MESSAGE SERVER" D WHO^XMA21 D
 ;.I Y=-1 S PRCXM(2)=$P($T(ERROR+1),";;",2)_" "_PRCMG,(PRETRY,XMY(.5))=""
 ;I '$D(PRCMG) S PRCXM(2)=$P($T(ERROR+2),";;",2),XMY(.5)=""
 D EMFORM ;S XMDUN="IFCAP SERVER ERROR"
 ;S XMSUB="Document Confirmation Transaction"
 ;S XMTEXT="PRCXM("
 ;D ^XMD
 K PRCXM Q
ERROR ;
 ;;Mailgroup members designated in file 423.5:
 ;;Transaction control segment is messed up.
EMFORM ;
 I $D(PRCDA),$D(^PRCF(423.6,PRCDA,1,10000,0)) N I,J D
 .N THDR,TDATE,Y S THDR=^PRCF(423.6,PRCDA,1,10000,0)
 .S Y=$P(THDR,U,10),Y=($E(Y,1,4)-1700)_$E(Y,5,8) D DD^%DT S TDATE=Y
 .F I=1:1 S J=$O(PRCXM(I)) Q:J=""
 .S I=I+1,PRCXM(I)=" ",I=I+1,PRCXM(I)="  System ID: "_$P(THDR,U,2),I=I+1
 .S PRCXM(I)=" ",I=I+1,PRCXM(I)="  Receiving Station #: "_$P(THDR,U,4)_"                "_"Transaction Code : "_$P(THDR,U,5),I=I+1
 .S PRCXM(I)=" ",I=I+1,PRCXM(I)="  Transaction Date : "_TDATE_"         "_"Transaction Time : "_$E($P(THDR,U,11),1,2)_":"_$E($P(THDR,U,11),3,4)_":"_$E($P(THDR,U,11),5,6),I=I+1
 .I $L($P(THDR,U,9))>0 S PRCXM(I)=" ",I=I+1,PRCXM(I)="  Sales or Order #: "_$P(THDR,U,9),I=I+1
 .S PRCXM(I)=" ",I=I+1,PRCXM(I)="  Interface Version #: "_$P(THDR,U,14)_"                Message File #: "_PRCDA
 .Q
A N LN S DA=0 F  S DA=$O(^PRCF(423.6,DA)) Q:+DA'=DA  D ST
 Q
ST S LN=10001
 S CTL=$G(^PRCF(423.6,DA,1,10000,0)) Q:CTL=""!($P(CTL,U,5)'="DCT")
 S DOC=$P(CTL,U,6)
DO F  S LN=$O(^PRCF(423.6,DA,1,LN)) Q:LN=""  S LIN=$G(^(LN,0)) D
 . Q:"~"[$P(LIN,U,2)  S SEG=$P(LIN,U,1)
 . I SEG="ER1"!(SEG="ER2") D  Q
 . . N E,EC,EM F E=1:1:5 S EC=$P(LIN,U,E*2) Q:"~"[EC  D
 . . . S EM=$P(LIN,U,E*2+1) S SUB=DOC_"  "_EC,^ZLX(SUB)=EM
 . . . Q
 . . Q
 . I SEG="DCL" D  Q
 . . N S,STATUS S S=$P(LIN,U,3)
 . . S STATUS=$S(S="A":"Accepted.",S="R":"Rejected:",1:"unknown.")
 . . S PRCXM(I)=" ",PRCXM(I+1)="  Line "_$P(LIN,U,5)_" "_STATUS
 . . S PRCXM(I+2)=" ",I=I+3
 . . Q
 . I SEG="DCD" D  Q
 . . N S,STATUS S S=$P(LIN,U,3)
 . . S STATUS=$S(S="A":"Accepted.",S="R":"Rejected:",1:"unknown.")
 . . S PRCXM(I+1)="  FMS Document "_$P(LIN,U,6)_"-"_$P(LIN,U,7)_" "_STATUS
 . . S PRCXM(I)=" ",PRCXM(I+2)=" ",I=I+3
 . . Q
 . Q
 Q
TFILER ; Transaction Filer
 N OK,REM,REM1
 I PRCDA=0 D
 .L +^PRCF(423.6,0):5 I '$T S X="FMS Transaction file unavailable - File Lock Timeout.*" D MSG^PRCFQ Q
 .F CNT=1:1 Q:'$D(^PRCF(423.6,CNT,0))
 .S $P(^PRCF(423.6,0),U,3)=CNT,PRCDA=CNT,$P(^(0),U,4)=$P(^(0),U,4)+1 L +^PRCF(423.6,PRCDA)
 .S ^PRCF(423.6,PRCDA,0)=PRCKEY,^PRCF(423.6,"B",PRCKEY,PRCDA)="",$P(^PRCF(423.6,PRCDA,1,0),U,2)=$P(^DD(423.6,1,0),U,2) K CNT L -^PRCF(423.6,0) L -^PRCF(423.6,PRCDA)
 L +^PRCF(423.6,PRCDA):5 I '$T S X="FMS Transaction record unavailable - File lock timeout.*" D MSG^PRCFQ Q
 N II,LEN,OCNT,SCNT S (OCNT,SCNT)=10000*(+$P(XMRG,U,12)) I +$P(XMRG,U,12)=1 S ^PRCF(423.6,PRCDA,1,SCNT,0)=XMRG,SCNT=SCNT+1
 S (OK,REM,REM1,S1)="" F  D  Q:XMER'=0  I S1>0 Q
 .S:REM["}" S1=2 Q:REM["}"  S:XMRG["{" S1=1,XMRG="" X:S1="" XMREC Q:XMER<0
 .S:$L(REM)+$L(REM1)<241 REM=REM_REM1,REM1="" S:$L(REM)+$L(XMRG)<241 XMRG=REM_XMRG,REM="" I $L(REM)+$L(XMRG)>240 S REM1=$E(XMRG,241-$L(REM),$L(XMRG)),XMRG=REM_$E(XMRG,1,240-$L(REM))
 .S LEN=$F(XMRG,"~")
 .I LEN>1,LEN<241 S ^PRCF(423.6,PRCDA,1,SCNT,0)=$E(XMRG,1,LEN-1),SCNT=SCNT+1,REM=$E(XMRG,LEN,$L(XMRG)) Q
 .I $L(XMRG)>0,$L(XMRG)<241 S ^PRCF(423.6,PRCDA,1,SCNT,0)=XMRG,SCNT=SCNT+1,REM="" Q
 .I $E(XMRG,1,240)["^" F II=240:-1:1 I $E(XMRG,II)="^" S ^PRCF(423.6,PRCDA,1,SCNT,0)=$E(XMRG,1,II),SCNT=SCNT+1,REM=$E(XMRG,II+1,$L(XMRG)),OK=1 Q
 .Q:OK=1  F II=240:-1:1 I $E(XMRG,II)=" " S ^PRCF(423.6,PRCDA,1,SCNT,0)=$E(XMRG,1,II),REM=$E(XMRG,II+1,$L(XMRG)) Q
 .Q
 S $P(^PRCF(423.6,PRCDA,1,0),U,3)=SCNT-1,$P(^(0),U,4)=(SCNT-OCNT)+$P(^(0),U,4) L -^PRCF(423.6,PRCDA) Q
