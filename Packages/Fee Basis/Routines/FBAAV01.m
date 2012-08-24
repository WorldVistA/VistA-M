FBAAV01 ;AISC/GRR - ELECTRONICALLY TRANSMIT FEE DATA CONTINUED ;6/15/2009
 ;;3.5;FEE BASIS;**89,98,108**,JAN 30, 1995;;Build 115
 ;;Per VHA Directive 2004-038, this routine should not be modified.
NEWMSG ;get new message number, reset line counter
 ;FBLN=line counter, FBFEE=FEE message counter, FBNVP=NVP message counter
 ;FBOKTX=1 if message pending, 0 otherwise
 S FBXMZ=0,FBJ=$G(J),FBK=$G(K) S:'$D(FBFEE) FBFEE=1 S:'$D(FBNVP) FBNVP=1
 S XMSUB=$S('$D(FBFLAG):"FEE BASIS MESSAGE # "_FBFEE,1:"FEE NON-VA HOSP TO PRICER MESSAGE # "_FBNVP),XMDUZ=DUZ
 S FBOKTX=0
 D XMZ^XMA2
 I '$D(XMZ)!(XMZ'>0) G NEWMSG
 S FBXMZ=XMZ,FBLN=0,FBOKTX=1,J=FBJ,K=FBK K XMZ
 Q
 ;
XMIT ;send message, increment message counter
 ;FBLN=line counter, FBFEE=FEE message counter, FBNVP=NVP message counter
 ;FBXMFEE(=FEE recipient array, FBXMNVP(=NVP recipient array
 S FBJ=J,FBK=K K XMY D ROUT
 S XMZ=FBXMZ,^XMB(3.9,XMZ,2,0)="^3.92A^"_FBLN_"^"_FBLN_"^"_DT
 S XMDUN=$P(^VA(200,DUZ,0),U) D ENT1^XMD
 S FBLN=0,FBOKTX=0
 D INCRM ;increment message counter
 S J=FBJ,K=FBK
 Q
 ;
ROUT ;set up recipients for message
 I $D(FBFLAG) S FBI=0 F  S FBI=$O(FBXMNVP(FBI)) Q:'FBI  S X=FBXMNVP(FBI),XMN=0,XMDF="" D INST^XMA21 K XMN,XMDF
 I '$D(FBFLAG) S FBI=0 F  S FBI=$O(FBXMFEE(FBI)) Q:'FBI  S X=FBXMFEE(FBI),XMN=0,XMDF="" D INST^XMA21 K XMN,XMDF
 S XMY(DUZ)="",XMDUZ=DUZ Q
 ;
INCRM ;increment message counter
 I $D(FBFLAG) S FBNVP=FBNVP+1
 E  S FBFEE=FBFEE+1
 Q
 ;
INCRL ;increment line counter
 S FBLN=FBLN+1 Q
 ;
STORE ;set message string
 D INCRL S ^XMB(3.9,FBXMZ,2,FBLN,0)=FBSTR
 Q
 ;
ADDRESS ;set up recipient array, FBXMFEE( for FEE router, FBXMNVP( for NVP router
 F VATNAME="FEE","NVP" D ^VATRAN G:VATERR ADDQ S FBI=0 F  S FBI=$O(VAT(FBI)) Q:'FBI  S FBVAR="FBXM"_VATNAME_"("_FBI_")" S @FBVAR=VAT(FBI)
ADDQ Q
 ;Following checks for Austin Name Field in Vendor file in order to continue transmitting that batch.
CKB3V F FB1=0:0 S FB1=$O(^FBAAC("AC",J,FB1)) Q:'FB1!($G(FBERR))  F FB2=0:0 S FB2=$O(^FBAAC("AC",J,FB1,FB2)) Q:FB2'>0!($G(FBERR))  D CHKV
 Q
CKB5V F FB1=0:0 S FB1=$O(^FBAA(162.1,"AE",J,FB1)) Q:'FB1!($G(FBERR))  I $G(^FBAA(162.1,FB1,0)) S FB2=+$P(^(0),"^",4) D CHKV
 Q
CKB9V F FB1=0:0 S FB1=$O(^FBAAI("AC",J,FB1)) Q:'FB1!($G(FBERR))  I $G(^FBAAI(FB1,0)) S FB2=+$P(^(0),"^",3) D CHKV
 Q
CHKV I $$CKVEN^FBAADV(FB2) W !!,*7,"VENDOR: ",$$VNAME^FBNHEXP(FB2)," Not approved in Austin yet.",!,"Batch # ",FBAABN," CANNOT BE TRANSMITTED!!!" S FBERR=1
 Q
 ;
STRING ;called from FBAAV0 to build 'B3' payment record
 ;
 S FBPICN=$$PADZ(FBPICN,30)
 ;
 ; build 1st line
 S FBSTR=3_FBAASN_FBSSN_FBPAYT_FBPNAMX_FBVID_"  "_FBAP_FBAAON_FBSUSP
 S FBSTR=FBSTR_FBPOV_FBPATT_FBTD_FBTT_FBDIN_FBINVN
 S FBSTR=FBSTR_$E(PAD,1,33)_FBST_FBCTY_FBZIP ; reserved for foreign addr
 S FBSTR=FBSTR_$E(FBPSA,1,3)_FBCPT_FBPOS_FBHCFA_FBVTOS_FBPD
 S FBSTR=FBSTR_+$P($G(FBY),U,2)_$E(PAD,1,8)_FBPICN
 S FBSTR=FBSTR_$S(+FBY:$$AUSDT^FBAAV3(+FBY),1:FBDIN)_FBADMIT_FBDOB_"~"
 D STORE
 ;
 ; build 2nd line
 S FBSTR=FBUNITS_FBAUTHF_FBMOD1_FBMOD2_FBMOD3_FBMOD4_FBADJR1_FBADJR2
 S FBSTR=FBSTR_FBADJA1_FBADJA2_FBNPI_FBCSID_FBEDIF_FBCNTRN
 S FBSTR=FBSTR_$E(PAD,1,32)_"~$" ; reserved for IPAC data
 D STORE
 ;
 K FBPICN,FBY
 Q
 ;
PADZ(X,Y) ;call to pad 'X' with leading zeros' to a field length of 'Y'
 ;
 I $S('$L(X):1,'Y:1,Y<$L(X):1,1:0) Q ""
 N Z S Z=0,$P(Z,0,Y)=0
 Q $E(Z,$L(X)+1,Y)_X
