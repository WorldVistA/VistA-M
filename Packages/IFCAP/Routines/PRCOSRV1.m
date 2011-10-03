PRCOSRV1 ;WISC/RMP-Server interface to IFCAP from ISMS ;12/9/96  11:11 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
PERROR ; Process Errors
 N X,XMDUN,XMSUB,XMTEXT,XMB,XMY,XMZ
 S PRCEND=""
 S XMRG=PRCOXMRG
 I $D(PRCMG),PRCMG]"" D
 . S:PRCMG'["G." PRCMG="G."_PRCMG
 . S X=PRCMG
 . S XMDUZ="IFCAP ISMS MESSAGE SERVER"
 . D WHO^XMA21
 . ;
 . ; If the mail group found in file 423.5 for this transaction
 . ; failed the lookup send the bulletin to G.ISM.  If G.ISM
 . ; also failed its lookup then send the bulletin to POSTMASTER.
 . ;
 . I Y=-1 D
 . . S PRCXM(2)=$P($T(ERROR+1),";;",2),PRETRY=""
 . . I PRCMG="G.ISM" S XMY(.5)="" Q
 . . S X="G.ISM"
 . . S XMDUZ="IFCAP ISMS MESSAGE SERVER"
 . . D WHO^XMA21
 . . I Y=-1 S XMY(.5)=""
 . . Q
 . Q
 ;
 ; If there is no mail group defined when this ERROR routine is called
 ; send the bulletin to G.ISM.  If G.ISM failed the lookup then send
 ; the bulletin to POSTMASTER.
 ;
 I $G(PRCMG)="" D
 . S PRCXM(2)=$P($T(ERROR+2),";;",2)_" "_$P(XMRG,U)_"-"_$P(XMRG,U,4)_"."
 . S X="G.ISM"
 . S XMDUZ="IFCAP ISMS MESSAGE SERVER"
 . D WHO^XMA21
 . I Y=-1 S XMY(.5)=""
 . Q
 ;
 D EMFORM
 S XMDUN="IFCAP SERVER ERROR"
 S XMSUB="IFCAP message router error"
 S XMTEXT="PRCXM("
 D ^XMD
 K PRCXM
 Q
 ;
ERROR ;
 ;;Mailgroup designated in file 423.5 could not list its members.
 ;;There is no mail group listed for transaction
 ;
EMFORM ; FIRST DISPLAY INFORMATION ABOUT THE INCOMMING MAIL MESSAGE
 ;
 N I,J
 F I=1:1 S J=$O(PRCXM(I)) Q:J=""
 S I=I+1
 S PRCXM(I)=" "
 S I=I+1
 S PRCXM(I)="  Sent to Server: "_PRCOSOP
 S I=I+1
 S PRCXM(I)=" "
 S I=I+1
 S PRCXM(I)="  MailMan Message #: "_PRCOMSG
 S I=I+1
 S PRCXM(I)=" "
 S I=I+1
 S PRCXM(I)="  Sent From: "_PRCOSND
 S I=I+1
 S PRCXM(I)=" "
 S I=I+1
 S PRCXM(I)="  Message Subject: "_PRCOSUB
 S I=I+1
 S PRCXM(I)=" "
 S I=I+1
 S PRCXM(I)="  What this server thinks is the CONTROL segment of the transaction:"
 S I=I+1
 S PRCXM(I)="  "_XMRG
 ;
 ; HERE IS THE DATA FROM THE CONTROL SEGMENT SAVED IN FILE 423.6
 ;
 I $D(PRCDA),$D(^PRCF(423.6,PRCDA,1,10000,0)) D
 . N THDR,TDATE,X1,X2,Y
 . S THDR=^PRCF(423.6,PRCDA,1,10000,0)
 . S X1=($E($P(THDR,U,5),1,4)-1700)_"0101"
 . S X2=$E($P(THDR,U,5),5,7)
 . D C^%DTC
 . D YX^%DTC
 . S TDATE=Y
 . S I=I+1
 . S PRCXM(I)=" "
 . S I=I+1
 . S PRCXM(I)="  This is the CONTROL segment from the saved transaction in file 423.6:"
 . S I=I+1
 . S PRCXM(I)="  "_THDR
 . S I=I+1
 . S PRCXM(I)=" "
 . S I=I+1
 . S PRCXM(I)="  System ID: "_$P(THDR,U)_"                          "_"Sending Station #: "_$P(THDR,U,2)
 . S I=I+1
 . S PRCXM(I)=" "
 . S I=I+1
 . S PRCXM(I)="  Receiving Station #: "_$P(THDR,U,3)_"                "_"Transaction Code : "_$P(THDR,U,4)
 . S I=I+1
 . S PRCXM(I)=" "
 . S I=I+1
 . S PRCXM(I)="  Transaction Date : "_TDATE_"         "_"Transaction Time : "_$E($P(THDR,U,6),1,2)_":"_$E($P(THDR,U,6),3,4)_":"_$E($P(THDR,U,6),5,6)
 . S I=I+1
 . I $L($P(THDR,U,7))>0 D
 . . S PRCXM(I)=" "
 . . S I=I+1
 . . S PRCXM(I)="  Sales or Order #: "_$P(THDR,U,7)
 . . S I=I+1
 . . Q
 . S PRCXM(I)=" "
 . S I=I+1
 . S PRCXM(I)="  Interface Version #: "_$P(THDR,U,10)_"                Message File (423.6) #: "_PRCDA
 Q
 ;
TFILER ;Transaction Filer
 ;
 N OK,REM,REM1,YY
 I PRCDA=0 D
 . F  L +^PRCF(423.6,0):1 Q:$T
 . S YY=+$O(^PRCF(423.6,"B",PRCKEY,0))
 . I YY>0 S PRCDA=YY L -^PRCF(423.6,0) Q
 . S CNT=$P($G(^PRCF(423.6,0)),U,3)
 . F  S CNT=CNT+1 Q:$G(^PRCF(423.6,CNT,0))=""
 . S $P(^PRCF(423.6,0),U,3)=CNT
 . S PRCDA=CNT
 . S $P(^PRCF(423.6,0),U,4)=$P(^PRCF(423.6,0),U,4)+1
 . F  L +^PRCF(423.6,PRCDA):1 Q:$T
 . S ^PRCF(423.6,PRCDA,0)=PRCKEY
 . S ^PRCF(423.6,"B",PRCKEY,PRCDA)=""
 . S $P(^PRCF(423.6,PRCDA,1,0),U,2)=$P(^DD(423.6,1,0),U,2)
 . K CNT
 . L -^PRCF(423.6,0)
 . L -^PRCF(423.6,PRCDA)
 F  L +^PRCF(423.6,PRCDA):1 Q:$T
 N II,LEN,OCNT,SCNT
 S (OCNT,SCNT)=10000*(+$P(XMRG,U,8))
 I +$P(XMRG,U,8)=1 D
 . S ^PRCF(423.6,PRCDA,1,SCNT,0)=XMRG
 . S SCNT=SCNT+1
 S (OK,REM,REM1,S1)=""
 F  D  Q:XMER'=0  I S1>0 Q
 . S:REM["~" S1=2
 . Q:REM["~"
 . S:XMRG["$" S1=1,XMRG=""
 . X:S1="" XMREC
 . Q:XMER<0
 . S:$L(REM)+$L(REM1)<241 REM=REM_REM1,REM1=""
 . S:$L(REM)+$L(XMRG)<241 XMRG=REM_XMRG,REM=""
 . I $L(REM)+$L(XMRG)>240 D
 . . S REM1=$E(XMRG,241-$L(REM),$L(XMRG))
 . . S XMRG=REM_$E(XMRG,1,240-$L(REM))
 . . Q
 . S LEN=$F(XMRG,"|")
 . I LEN>1,LEN<241 D  Q
 . . S ^PRCF(423.6,PRCDA,1,SCNT,0)=$E(XMRG,1,LEN-1)
 . . S SCNT=SCNT+1
 . . S REM=$E(XMRG,LEN,$L(XMRG))
 . . Q
 . I $L(XMRG)>0,$L(XMRG)<241 D  Q
 . . S ^PRCF(423.6,PRCDA,1,SCNT,0)=XMRG
 . . S SCNT=SCNT+1
 . . S REM=""
 . . Q
 . I $E(XMRG,1,240)["^" F II=240:-1:1 I $E(XMRG,II)="^" D  Q
 . . S ^PRCF(423.6,PRCDA,1,SCNT,0)=$E(XMRG,1,II)
 . . S SCNT=SCNT+1
 . . S REM=$E(XMRG,II+1,$L(XMRG))
 . . S OK=1
 . . Q
 . Q:OK=1
 . F II=240:-1:1 I $E(XMRG,II)=" " D  Q
 . . S ^PRCF(423.6,PRCDA,1,SCNT,0)=$E(XMRG,1,II)
 . . S REM=$E(XMRG,II+1,$L(XMRG))
 . . Q
 . Q
 S $P(^PRCF(423.6,PRCDA,1,0),U,3)=SCNT-1
 S $P(^PRCF(423.6,PRCDA,1,0),U,4)=(SCNT-OCNT)+$P(^PRCF(423.6,PRCDA,1,0),U,4)
 L -^PRCF(423.6,PRCDA)
 Q
