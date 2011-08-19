PRCODCT1 ;WISC/DJM-Server interface to IFCAP from FMS ;5/30/95  1:22 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
PERROR ; Process Errors
 N XMDUN,XMSUB,XMTEXT,XMB,XMY,XMZ,PRCEND,E,EC,LIN,S,SEG,STOP,XMCHAN,XMDUZ
 S PRCEND=""
 I $D(PRCMG) S:PRCMG'["G." PRCMG="G."_PRCMG ; S X=PRCMG
 S XMDUZ="IFCAP FMS MESSAGE SERVER",XMCHAN=1
 ;D WHO^XMA21 D
 ;.I Y=-1 S PRCXM(2)=$P($T(ERROR+1),";;",2)_" "_PRCMG,(PRETRY,XMY(.5))=""
 I '$D(PRCMG) S PRCXM(2)=$P($T(ERROR+2),";;",2),XMY(.5)=""
 D EMFORM S XMDUN="IFCAP SERVER ERROR"
 S XMSUB="Document Confirmation Transaction (DCT)"
 S XMTEXT="PRCXM(",XMY(PRCMG)=""
 D ^XMD
 K PRCXM
 Q
ERROR ;
 ;;No mailgroup members designated in
 ;;There is no mailgroup listed for CTL-DCT in file 423.5.
EMFORM ;
 I $D(PRCDA),$D(^PRCF(423.6,PRCDA,1,10000,0)) N I,J D
 .N THDR,TDATE,Y S THDR=^PRCF(423.6,PRCDA,1,10000,0)
 .S Y=$P(THDR,U,10),Y=($E(Y,1,4)-1700)_$E(Y,5,8) D DD^%DT S TDATE=Y
 .F I=1:1 S J=$O(PRCXM(I)) Q:J=""
 .S I=I+1,PRCXM(I)=" ",I=I+1,PRCXM(I)="  System ID: "_$P(THDR,U,2),I=I+1
 .S PRCXM(I)=" ",I=I+1,PRCXM(I)="  Receiving Station #: "_$P(THDR,U,4)_"                "_"Transaction Code : "_$P(THDR,U,5),I=I+1
 .S PRCXM(I)=" ",I=I+1,PRCXM(I)="  Transaction Date : "_TDATE_"         "_"Transaction Time : "_$E($P(THDR,U,11),1,2)_":"_$E($P(THDR,U,11),3,4)_":"_$E($P(THDR,U,11),5,6),I=I+1
 .S PRCXM(I)=" ",I=I+1,PRCXM(I)="  Interface Version #: "_$P(THDR,U,14),I=I+1
 .Q
 S LN=DOCLN,STOP=0
DO F  S LN=$O(^PRCF(423.6,PRCDA,1,LN)) Q:LN=""  Q:LN=LINE  S LIN=$G(^(LN,0)) D  Q:STOP=1
 . S SEG=$P(LIN,U,1)
 . I LN>DOCLN,(SEG="DOC") S STOP=1 Q
 . Q:"~"[$P(LIN,U,2)
 . I SEG="ER1"!(SEG="ER2") D  Q
 . . N E,EC,EM F E=1:1:5 S EC=$P(LIN,U,E*2) Q:"~"[EC  D
 . . . S EM=$P(LIN,U,E*2+1),PRCXM(I)="     "_EC_"   "_EM,I=I+1
 . . . Q
 . . Q
 . I SEG="DCL" D  Q
 . . N S,STATUS S S=$P(LIN,U,3)
 . . S STATUS=$S(S="A":"Accepted.",S="R":"Rejected:",1:"unknown.")
 . . S PRCXM(I)=" ",PRCXM(I+1)="  Line "_$P(LIN,U,5)_" "_STATUS
 . . S I=I+2
 . . Q
 . I SEG="DCD" D  Q
 . . N S,STATUS S S=$P(LIN,U,3)
 . . S STATUS=$S(S="A":"Accepted.",S="R":"Rejected:",1:"unknown.")
 . . S PRCXM(I)=" ",PRCXM(I+1)="  FMS Document "_DOCID_" "_STATUS
 . . S I=I+2
 . Q
 Q
