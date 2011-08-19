DVBHIQM ;ISC-ALBANY/PKE,DLM,PHH/WASH-MAIL DELIVERY PROGRAM ;3/23/06
 ;;4.0;HINQ;**49,57,61**;03/25/92;Build 19
 G EN
LIN Q:CT>50  S CT=CT+1,A1=A_CT_",0)",@A1=T1 Q
DD S:Y Y=$S($E(Y,4,5):$P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC","^",+$E(Y,4,5))_" ",1:"")_$S($E(Y,6,7):+$E(Y,6,7)_",",1:"")_($E(Y,1,3)+1700)_$P("@"_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),"^",Y[".") Q
 ;
EN I $D(X(1)),$E(X(1),1,5)'="ERROR" S DFN=$E(X(1),8,21),XMDUZ=.5,XMSUB="HINQ response for " I DFN?14"0" S DFN=0,XMSUB="HINQ Transaction Test "
 I DFN'?14" " K DVBREQST
 S DFN=+DFN I $D(DUZ) S XMORIG=DUZ
 E  QUIT
 I '+XMORIG QUIT
 ;
 S (DVBASK,DVBASKER)=0
 I DFN=0 G SUBJ
 ;
MAILGP K XMY,DVBXMY
 I $D(^XMB(3.8,"B","DVBHINQ")) S N=0,N=$O(^("DVBHINQ",N)) Q:'N  F DVBU=0:0 S DVBU=$O(^XMB(3.8,N,1,"B",DVBU)) Q:'DVBU  S XMY(DVBU)=""
REQ ;
 ;replace direct global lookup of div with GETS^DIQ - DVB*4*49
 I $D(^DVB(395.5,DFN,0)) D
 . N DVBARR,DVBERR
 . D GETS^DIQ(395.5,DFN_",",9,"E","DVBARR","DVBERR")
 . S DVBDIV=$G(DVBARR(395.5,DFN_",",9,"E"))
 F DVBU=0:0 S DVBU=$O(^DVB(395.5,DFN,1,DVBU)) Q:'DVBU  S:$D(^(DVBU,0)) DVBXMY(DVBU)=$P(^(0),U,2) ;for latest requestor dvbasker
 I '$D(DVBDIV) K DVBDIV
 ;
 F DVBU=0:0 S DVBU=$O(DVBXMY(DVBU)) Q:'DVBU  I DVBXMY(DVBU)>DVBASK S DVBASK=DVBXMY(DVBU),DVBASKER=DVBU  D
 .I $D(^XUSEC("DVBHINQ",DVBU)) S XMY(DVBU)=""
 ;
SUBJ S U="^",XMY(XMORIG)="",XMSUB=XMSUB_$S($D(^DPT(DFN,0)):$P(^(0),"^",1),1:" ")_" /requested by "_$S(DVBASKER:$S($D(^VA(200,DVBASKER,0)):$P(^(0),U),1:""),1:"")_$S('DVBASKER:$S($D(^VA(200,DUZ,0)):$P(^(0),U),1:""),1:"")
 ;
 K ^TMP($J) S CT=0,(A,XMTEXT)="^TMP($J,",BL="",$P(BL," ",36)=" "
 ;
 I $D(DVBREQST) S Y=DVBREQST D DATA,LIN,SEGM S T1="" D LIN
 ;
 I $D(^DPT(DFN,0)) D DPT,LIN,WARN,SEGM
 ;
 K DVBDIV,DVBREQST,DVBASK,DVBASKER,T9,L1,F1,F2,F3,F3,F4,F5,Y,S,S1,C,DVBXMY,DVBU,N
 ;exit point for errors
 I $D(DVBERR) S T1="       HINQ Error = "_DVBERR D LIN
 I $D(DVBERR) D ERR1
 I $D(DVBERR1) S T1="       Inquiry Data Submitted = "_DVBERR1 D LIN G ERR^DVBHQM3
 I $D(DVBOTM),$D(DVBNETER) S Y=DVBOTM D DD S T1=" Message out Time => "_Y D LIN
 I $D(DVBNETER) S T1=" IDCU Network Error" D LIN S T1=" "_DVBNETER D LIN I $D(DVBREQUE) S Y=DVBREQUE D DD S T1=" "_"Request has been retransmitted"_$S($L(DVBREQUE):" at "_Y,1:"") D LIN G ERR^DVBHQM3
 I $D(DVBNETER),'$D(DVBREQUE) S T1=" Request NOT retransmitted" D LIN G ERR^DVBHQM3
 S:X(1)["HINQ" X(1)=$E(X(1),1,6) S:$D(X(2)) X(2)=$E(X(2),1,6)
 ;
 G:$D(DVBABREV) EN^DVBHQM4
 G EN^DVBHQM1
 ;
DPT S (S,C,T9)=""
 S T1=$P(^DPT(DFN,0),U),Y=$P(^(0),U,3),T9=$P(^(0),U,9) D DD S T1=T1_" "_Y_" SSN:"_T9 S:$D(^(.31)) C=$P(^(.31),U,3) S:$D(^(.32)) S=$P(^(.32),U,8) S T1=T1_$S($L(C):" C-#:"_C,1:"")_$S($L(S):" S-#:"_S,1:"")_$S($D(DVBDIV):" Div:"_DVBDIV,1:"") Q
 ;
WARN Q:$D(DVBABREV)  ;don't compare multiple values for abrev return
 I $L(T9),$D(DVBSSN),DVBSSN?9N,+DVBSSN'=+T9 S T1="***  SSN from patient file does not match SSN from VBA  ***" D LIN
 I $L(C),$D(DVBCN),+DVBCN'=+C S T1="***  C-# from patient file does not match C-# from VBA  ***" D LIN
 I $L(S),$D(DVBSN)>9 S S1=1 F N=0:0 S N=$O(DVBSN(N)) Q:'N  I +DVBSN(N)=+S K S1 Q
 I $D(S1) S T1="***  S-# from Patient file does not match a S-# from VBA  ***" D LIN
 Q
 ;
SEGM Q:'$D(DVBBAS(2))
 I '$P(DVBBAS(2),U,35),'$P(DVBBAS(2),U,36),'$P(DVBBAS(2),U,37),'$P(DVBBAS(2),U,38) Q
 S T1="   WARNING: Error Indicators for " F N=38:-1:35 I $P(DVBBAS(2),U,N) S T1=T1_" "_$S(N=38:"BASIC",N=37:"STATISTICAL",N=36:"DIAGNOSTIC",N=35:"FUTURE",1:"")_","
 S T1=$E(T1,1,$L(T1)-1) D LIN
 Q
 ;
DATA S F1=$F(Y,"NM"),F2=$F(Y,"/",F1),F3=$F(Y,"SS",F2),F4=$F(Y,"CN",F2),F5=$F(Y,"SN",F2),T1=" Data Requested:"_$S(F1:" "_$E(Y,3,F2-2),1:"")_$S(F3:"  SS# "_$E(Y,F3,F3+8),1:"")_$S(F4:"  C# "_$E(Y,F4,F4+8),1:"")_$S(F5:"  S# "_$E(Y,F5,F5+8),1:"") Q
ERR1 ;set inquiry info into error text
 N DVBZZ,DVBZZZ
 S DVBZZZ=""
 S DVBZZ=$S($G(DVBZ)]"":DVBZ,$G(DVBZ0)]"":DVBZ0,$G(DVBZ1)]"":DVBZ1,1:"")
 ;DVB*4*54 - strip password from string before creating err msg- ERC
 I $G(DVBZZ)]"",$E(DVBZZ,$L(DVBZZ)-3,$L(DVBZZ))?4U S DVBZZ=$E(DVBZZ,1,$L(DVBZZ)-4)
 I DVBZZ["SS" S DVBZZZ="SS"_$E($P(DVBZZ,"SS",2),1,9)
 I DVBZZ["CN" S DVBZZZ=DVBZZZ_"  CN"_$E($P(DVBZZ,"CN",2),1,9)
 I DVBZZ["SN" S DVBZZZ=DVBZZZ_"  SN"_$E($P(DVBZZ,"SN",2),1,9)
 I $G(DVBZZZ)]"" S DVBERR1=DVBZZZ
 Q
