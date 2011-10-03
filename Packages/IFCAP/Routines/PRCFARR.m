PRCFARR ;ISC-SF/TKW/LKG-BUILD RECEIVING REPORT FOR ELECTRONIC TRANSMISSION TO AUSTIN ;11/22/95  12:15
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
ENRT ;RE-TRANSMIT RR ON DEMAND
 S DIC="^PRC(442,",DIC(0)="AEQM",DIC("S")="I $O(^PRC(442,+Y,11,0))" D ^DIC K DIC G:Y=-1 EX^PRCFARR3 S PRCFPO=+Y
 S DIC="^PRC(442,"_PRCFPO_",11,",DA(1)=PRCFPO,DIC(0)="AEQM",DIC("S")="I $P(^(0),""^"",19)'=""""" D ^DIC K DIC G:Y=-1 EX^PRCFARR3 S PRCFPR=+Y
EN ; ENTRY POINT FOR AUTOMATIC TRANSMISSION
 K ^TMP("PRCFARR",$J) N D0
 Q:'$D(PRCFPO)!('$D(PRCFPR))  Q:'$D(^PRC(442,+PRCFPO,0))
 S PRCF0=^PRC(442,PRCFPO,0),PRCF1=$G(^(1)),PRCF12=$G(^(12)),PRCF17=$G(^(17)),PRCF18=$G(^(18)),PRCF11=^PRC(442,PRCFPO,11,PRCFPR,0),PRCFPRD=+PRCF11
 S PRCF10=$G(^PRC(442,PRCFPO,10,1,0)),PRCFTC=$S(PRCF10]"":$P($P(PRCF10,U),"."),1:"")
 S:PRCFTC'?2U PRCFTC=$S($P(PRCF0,U,2)=2:"SO",1:"MO")
 S PRCFOBNO=$TR($P(PRCF0,U),"-"),PRCFOBNO=PRCFOBNO_$E("   ",1,11-$L(PRCFOBNO))
 N FED,STA,FCP,DFY,BBFY,P2237,REQ,NET S STA=+PRCF0,FCP=+$P(PRCF0,U,3)
 S P2237=$P(PRCF0,U,12),DFY=$S(P2237?1.N:$P($P($G(^PRCS(410,P2237,0)),U),"-",2),1:""),REQ=""
 S BBFY=$P($G(^PRC(442,PRCFPO,23)),U,2) S:BBFY BBFY=1700+$E(BBFY,1,3)
 I STA,DFY,FCP,'BBFY S BBFY=$$BBFY^PRCSUT(STA,DFY,FCP)
 I STA,FCP,DFY,BBFY S REQ=$$ACC^PRC0C(STA,FCP_U_DFY_U_BBFY)
 S NET=1 I $P(REQ,U,12)="G" S NET=0
 N PRCACT,PRCFBNO S PRCACT="E",PRCFBNO="",LCKFLG=0
 I +$P(PRCF11,U,3)<0!(+$P(PRCF11,U,5)<0) D  Q:LCKFLG
 . S PRCACT="M" D GETBN(+PRCF0,.PRCFBNO) Q:LCKFLG
 . S:$P(^PRC(442,PRCFPO,11,PRCFPR,0),U,20)="" $P(^(0),U,20)=PRCFBNO
 . S PRCFBNO=+PRCF0_$E(1000+PRCFBNO,2,4)
 I $P(PRCF0,"^",8),$P(PRCF0,"^",8)<$P(PRCF0,"^",6) S $P(PRCF0,"^",6,9)=$P(PRCF0,"^",8,9)_"^"_$P(PRCF0,"^",6,7)
 I '$D(PRCFJDN) S X=$P(PRCF1,"^",15) D JDN^PRCUTL S PRCFJDN=Y
 ;N PNO S PNO="00"_PRCFPR,PNO=$E(PNO,$L(PNO)-1,$L(PNO)) ; Partial #
 N PNO S PNO="" S X=$S(PRCACT="M"&($P($G(^PRC(442,PRCFPO,11,PRCFPR,1)),U,16)?1.N):$P(^(1),U,16),1:PRCFPR)
 D ALPHA^PRCFPAR(X,.PNO) ; IFCAP ==> FMS Partial #
 I PNO<0 D  G EX^PRCFARR3
 . S X="Partial # is out of limits - FMS will not process.*"
 . D MSG^PRCFQ
 . Q
 S FED=0 I $P(PRCF1,U,7)]"","13578"[$P(PRCF1,U,7) S FED=2
 N SPLIT S SPLIT=$S(FED:"A",1:" ")
 S:FED AGYCD=$P(^PRCD(420.8,$P(PRCF1,U,7),0),U,5)
 N SEC1 S SEC1=$E($$SEC1^PRC0C(PRC("SITE"))_"    ",1,4)
S1 ;#1    SPLIT,STATION,PAT,PARTIAL NO.,PARTIAL DATE,JULIAN DATE,LINE/ITEM COUNT,CASCA PROJECT #,TRANS TYPE,SEC1,BATCH#,REF TRANS CODE & #,DOC ACTION
 S TMP=SPLIT_"^1^"_+PRCF0_"^"_$P($P(PRCF0,"^",1),"-",2)_"^"_PNO_"^"_$E(PRCF11,4,7)_$E(PRCF11,2,3)_"^"_$P(PRCF0,"^",14)_"^"
 S:FED TMP=TMP_AGYCD_U_PRCFJDN_U_$P(PRCF18,U,13)_U_$P(PRCF18,U,14)_U
 S TMP=TMP_SEC1_U_PRCFBNO_U_PRCFTC_U_PRCFOBNO_U_PRCACT_U_"001"_U
 S ^TMP("PRCFARR",$J,1,0)=TMP
S2 ;#2    VENDOR NAME, ADDRESS, PHONE
 S PRCFX="",X=$G(^PRC(440,+PRCF1,0)),$P(PRCFX,"^",1,6)="2^"_$P(X,"^",1,5),$P(PRCFX,"^",7)=$E($P(X,"^",6),1,19)_" "_$S($D(^DIC(5,+$P(X,"^",7),0)):$P(^(0),"^",2),1:"")_" "_$P(X,"^",8),$P(PRCFX,"^",8)=$E($P(X,"^",10),1,18)
 N VN S VN=$P(PRCFX,U,2),$P(PRCFX,U,2)=$E(VN,1,30)
 S ^TMP("PRCFARR",$J,2,0)=PRCFX_"^"
S3 ;#3    SHIP TO ADDRESS
 S D0=PRCFPO,(X,PRCFX)=""
 I +$P(PRCF0,"^",2)'=4 D
 . S PRC("SITE")=+PRCF0 D FTYP^PRCHFPNT
 . S X=$S($P($G(^PRC(442,PRCFPO,23)),U,7)]"":$P(^(23),U,7),1:+PRCF0)
 . S X=$S($D(^PRC(411,X,1,+$P(PRCF1,"^",3),0)):^(0),1:"")
 . S:X]"" $P(X,"^")=$P(X,"^")_"^"_$E(PRCHFTYP,1,24)
 I +$P(PRCF0,"^",2)=4,$P(PRCF1,"^",12)]"" S X=$S($D(^PRC(440.2,$P(PRCF1,"^",12),0)):^(0),1:"") S:X]"" $P(X,"^")=$S($D(^DPT(+X,0)):$E($P(^(0),"^",1),1,21),1:+X),$P(X,"^",4)=$P(X,"^",4)_"^"
 S $P(PRCFX,"^",1,6)="3^"_$E($P(X,"^",1),1,30)_"^"_$P(X,"^",2,5),$P(PRCFX,"^",7)=$P(X,"^",6)_" "_$S($D(^DIC(5,+$P(X,"^",7),0)):$P(^(0),"^",2),1:"")_" "_$P(X,"^",8),^TMP("PRCFARR",$J,3,0)=PRCFX_"^"
S4 ;#4    REQ.SERVICE,GBL#,TYPE OF ORDER,PROPOSAL,CONTRACT(S)
 S Y=$S($D(^PRCD(420.8,+$P(PRCF1,"^",7),0)):$P(^(0),"^"),1:""),Y=$S(Y=2:"P",Y?1"B":Y,1:"D")
 S Z="^^",(X,Z1)="" F I=1:1:3 S X=$O(^PRC(442,PRCFPO,2,"AC",X)) Q:X=""  S:$O(^(X,0)) Z1=^($O(^(0))) S $P(Z,"^",I)=Z1_X,Z1=""
 S X=$S($D(^DIC(49,+$P(PRCF1,"^",2),0)):^(0),1:""),Z1=$S($P(X,"^",8)]"":"("_$P(X,"^",8)_")",1:""),X=$E($P(X,"^"),1,(30-$L(Z1)))_Z1,Z1=""
 S ^TMP("PRCFARR",$J,4,0)="4^"_X_"^"_$P(PRCF12,"^",7)_"^"_Y_"^"_$P(PRCF1,"^",8)_"^"_Z_"^",$P(^(0),U,9)=""
 G EN^PRCFARR0
FAMT I 'X S X="" Q
 S X=$P(X,".")_$E($P(X,".",2)_"00",1,2) Q
W1 W !!,"Receiving Report is incomplete.  Cannot transmit!",$C(7) Q
GETBN(PRCSTA,PRCX) ;Get Batch #
 N PRCFDA,X,Y
 I $P(^PRC(442,PRCFPO,11,PRCFPR,0),U,20)]"" S PRCX=$P(^(0),U,20) Q
 S X=PRCSTA_"-RRT-00",DIC=422.2,DIC(0)="XL",DLAYGO=422.2 D ^DIC K DIC,DLAYGO
 I +Y<1 S PRCX=-1 Q
 S PRCFDA=+Y
 I $G(PRCFA8)=1 D LOCK KILL PRCFA8 QUIT
 D LOCK1 QUIT
 ;
LOCK ;Process Receiving Report Option.
 L +^PRCF(422.2,PRCFDA):3
 E  D  Q:LCKFLG
 . S LCKFLG=1
 . DO EN^DDIOL("Record in use please try later.") Q
 ;
 I +$P(Y,U,3) S $P(^PRCF(422.2,PRCFDA,0),U,2)=500
 S PRCX=$P($G(^PRCF(422.2,PRCFDA,0)),U,2)+1
 S:PRCX>999 PRCX=1 S $P(^PRCF(422.2,PRCFDA,0),U,2)=PRCX
 L -^PRCF(422.2,PRCFDA)
 Q
 ;
LOCK1 ;Get LOCK for tasked process.  If unable to obtain a LOCK
 ;after 5 minutes (300 seconds) exit and give the user an email.
 L +^PRCF(422.2,PRCFDA):300
 E  D LCKMSG S LCKFLG=1 Q
 ;
 I +$P(Y,U,3) S $P(^PRCF(422.2,PRCFDA,0),U,2)=500
 S PRCX=$P($G(^PRCF(422.2,PRCFDA,0)),U,2)+1
 S:PRCX>999 PRCX=1 S $P(^PRCF(422.2,PRCFDA,0),U,2)=PRCX
 L -^PRCF(422.2,PRCFDA)
 Q
 ;
LCKMSG ;Send user a message
 N XMDUZ,MSG,MSG1
 S MSG="Error: Receiving Report NOT queued, "
 S MSG=MSG_"unable to obtain the batch transaction "
 S MSG1="       number. Please try again."
 K ^TMP("PRCFARR",$J)
 S ^TMP("PRCFARR",$J,1,0)=MSG
 S ^TMP("PRCFARR",$J,2,0)=MSG1
 S XMDUZ=$S($D(DUZ)#2:DUZ,1:.5)
 S XMY(XMDUZ)=""
 S XMSUB="RECEIVING REPORT "_$P(^PRC(442,PRCFA("PODA"),0),"^",1)
 S XMSUB=XMSUB_" PARTIAL #: "_PRCFA("PARTIAL")
 S XMTEXT="^TMP(""PRCFARR"","_$J_","
 S XMY(XMDUZ)=""
 D ^XMD
 K ^TMP("PRCFARR",$J)
 Q
