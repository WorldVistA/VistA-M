FBAAV01 ;AISC/GRR - ELECTRONICALLY TRANSMIT FEE DATA CONTINUED ;6/15/2009
 ;;3.5;FEE BASIS;**89,98,108,123,158**;JAN 30, 1995;Build 94
 ;;Per VA Directive 6402, this routine should not be modified.
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
STRING ; called from FBAAV0 to build 'B3' payment record; also called by DSIFPAY5 (FBCS) with DBIA# 5093
 ;
 S FBPICN=$$PADZ(FBPICN,30)
 ;
 ; build 1st line
 S FBSTR=3_FBAASN_FBSSN_FBPAYT_FBPNAMX_FBVID_"  "_FBAP_FBAAON_FBSUSP
 S FBSTR=FBSTR_FBPOV_FBPATT_FBTD_FBTT_FBDIN_FBINVN
 S FBSTR=FBSTR_$E(PAD,1,33)_FBST_FBCTY_FBZIP ; reserved for foreign addr
 S FBSTR=FBSTR_$E(FBPSA,1,3)_FBCPT_FBPOS_FBHCFA_FBVTOS_FBPD
 S FBSTR=FBSTR_+$P($G(FBY),U,2)_$E(PAD,1,8)_FBPICN ;Internal Control Number
 S FBSTR=FBSTR_$S(+FBY:$$AUSDT^FBAAV3(+FBY),1:FBDIN)_FBADMIT_FBDOB_"~"
 D STORE
 ;
 ; build 2nd line
 S FBSTR=FBUNITS_FBAUTHF_FBMOD1_FBMOD2_FBMOD3_FBMOD4
 S FBADJR1=$S($D(FBCRARC(1)):$P(FBCRARC(1),U,2),1:""),FBADJR1=$$RJ^XLFSTR(FBADJR1,5," ")
 S FBADJR2=$S($D(FBCRARC(2)):$P(FBCRARC(2),U,2),1:""),FBADJR2=$$RJ^XLFSTR(FBADJR2,5," ")
 S FBSTR=FBSTR_FBADJR1_FBADJR2
 S FBADJA1=$S($D(FBCRARC(1)):$P(FBCRARC(1),U,3),1:0),FBADJA1=$$AUSAMT^FBAAV3(FBADJA1,9,1)
 S FBADJA2=$S($D(FBCRARC(2)):$P(FBCRARC(2),U,3),1:0),FBADJA2=$$AUSAMT^FBAAV3(FBADJA2,9,1)
 S FBSTR=FBSTR_FBADJA1_FBADJA2
 S FBSTR=FBSTR_FBNPI_FBCSID_FBEDIF_FBCNTRN
 ;
 ; FB*3.5*123 - esg - Check to make sure IPAC variables are defined
 I '$D(FBIA)!'$D(FBDODINV) D IPAC(K,L,M,N,.FBIA,.FBDODINV)    ; set and format the IPAC variables if coming from FBCS
 ;
 S FBSTR=FBSTR_FBIA_FBDODINV_"~"          ; FB*3.5*123 - IPAC data formatted in FBAAV0 or below in IPAC
 D STORE
 ;
 ; 3rd line
 S FBSTR=FBFPPSID ; FPPS Claim Number
 S FBSTR=FBSTR_FBAUTHNUM ;AUTHORIZATION NUMBER
 S FBLNITM=$$RJ^XLFSTR(FBLNITM,3,0) ;fpps line item
 S FBSTR=FBSTR_FBLNITM
 S FBSTR=FBSTR_FBAMTC ;Service Line Billed Amount = Claimed Amount
 ;
 S FBADJG=$S($D(FBCRARC(1)):$P(FBCRARC(1),U),1:""),FBADJG=$$RJ^XLFSTR(FBADJG,2," ")
 S FBRRC1=$S($D(FBCRARC(1)):$P(FBCRARC(1),U,4),1:""),FBRRC1=$$RJ^XLFSTR(FBRRC1,6," ")
 S FBRRC2=$S($D(FBCRARC(1)):$P(FBCRARC(1),U,5),1:""),FBRRC2=$$RJ^XLFSTR(FBRRC2,6," ")
 S FBSTR=FBSTR_FBADJG_FBRRC1_FBRRC2
 ;
 S FBADJG=$S($D(FBCRARC(2)):$P(FBCRARC(2),U),1:""),FBADJG=$$RJ^XLFSTR(FBADJG,2," ")
 S FBRRC1=$S($D(FBCRARC(2)):$P(FBCRARC(2),U,4),1:""),FBRRC1=$$RJ^XLFSTR(FBRRC1,6," ")
 S FBRRC2=$S($D(FBCRARC(2)):$P(FBCRARC(2),U,5),1:""),FBRRC2=$$RJ^XLFSTR(FBRRC2,6," ")
 S FBSTR=FBSTR_FBADJG_FBRRC1_FBRRC2
 ; 
 F FBI=3:1:5 D
 . S FBADJG=$S($D(FBCRARC(FBI)):$P(FBCRARC(FBI),U),1:""),FBADJG=$$RJ^XLFSTR(FBADJG,2," ")
 . S FBADJR=$S($D(FBCRARC(FBI)):$P(FBCRARC(FBI),U,2),1:""),FBADJR=$$RJ^XLFSTR(FBADJR,5," ")
 . S FBRRC1=$S($D(FBCRARC(FBI)):$P(FBCRARC(FBI),U,4),1:""),FBRRC1=$$RJ^XLFSTR(FBRRC1,6," ")
 . S FBRRC2=$S($D(FBCRARC(FBI)):$P(FBCRARC(FBI),U,5),1:""),FBRRC2=$$RJ^XLFSTR(FBRRC2,6," ")
 . S FBADJA=$S($D(FBCRARC(FBI)):$P(FBCRARC(FBI),U,3),1:0),FBADJA=$$AUSAMT^FBAAV3(FBADJA,9,1)
 . S FBSTR=FBSTR_FBADJG_FBADJR_FBRRC1_FBRRC2_FBADJA
 ;
 S FBSTR=FBSTR_$$RJ^XLFSTR(FBPYMTH,1," ")
 S FBSTR=FBSTR_" "  ;Additional Payment Indicator
 S FBSTR=FBSTR_" "  ;Additional Payment Type
 S FBSTR=FBSTR_$$PADZ(0,30)  ;Parent Internal Control Number
 ;
 S FBSTR=FBSTR_"~$"
 D STORE
 ;
 K FBPICN,FBY
 K FBIA,FBDODINV      ; FB*3.5*123 kill IPAC variables after using them. They will get rebuilt by the next claim.
 Q
 ;
PADZ(X,Y) ;call to pad 'X' with leading zeros' to a field length of 'Y'
 ;
 I $S('$L(X):1,'Y:1,Y<$L(X):1,1:0) Q ""
 N Z S Z=0,$P(Z,0,Y)=0
 Q $E(Z,$L(X)+1,Y)_X
 ;
IPAC(K,L,M,N,FBIA,FBDODINV) ; set IPAC variables if being called from FBCS
 ;        K - 162.03 subscript#1 - DFN
 ;        L - 162.03 subscript#2 - vendor ien
 ;        M - 162.03 subscript#3 - treatment date subfile ien
 ;        N - 162.03 subscript#4 - service provided subfile ien
 ; Output:
 ;     FBIA - formatted IPAC agreement ID# (pass by reference) - will be 10 characters in length
 ; FBDODINV - formatted DoD invoice# (pass by reference) - will be 22 characters in length
 ;
 N FBY2,FBY3,FBIPIEN
 S (FBIA,FBDODINV)=""
 I '$$IPACREQD^FBAAMP(L) G IPACX    ; IPAC data is not required so get out
 ;
 S FBY2=$G(^FBAAC(K,1,L,1,M,1,N,2))   ; 2 node of file 162.03
 S FBY3=$G(^FBAAC(K,1,L,1,M,1,N,3))   ; 3 node of file 162.03
 S FBIA=+$P(FBY3,U,6)      ; .05 field IPAC agreement ien
 S FBIA=$S(FBIA:$P($G(^FBAA(161.95,FBIA,0)),U,1),1:"")    ; IPAC agreement ID# or ""
 S FBDODINV=$P(FBY3,U,7)   ; IPAC DoD invoice#
 ;
 ; if IPAC agreement is not on file, but there is only one active IPAC on file for the vendor, then save it/use it
 I FBIA="" S FBIA=$$IPACID^FBAAMP(L,.FBIPIEN) I FBIA'="",FBIPIEN D
 . N FBIENS,FBIAFDA
 . S FBIENS=N_","_M_","_L_","_K_","
 . S FBIAFDA(162.03,FBIENS,.05)=FBIPIEN    ; ipac agreement ien
 . D FILE^DIE("","FBIAFDA")                ; update the database
 . Q
 ;
 ; if IPAC agreement is still not found, then report an error condition to Central Fee
 I FBIA="" S FBIA="9999999999"        ; error value to be sent to Central Fee so they reject it back to VistA
 ;
 ; if DoD invoice# is not on file, then attempt to use field# 49 PATIENT ACCOUNT NUMBER. use it/save it if it exists
 I FBDODINV="" S FBDODINV=$P(FBY2,U,16) I FBDODINV'="" D
 . N FBIENS,FBIAFDA
 . S FBIENS=N_","_M_","_L_","_K_","
 . S FBIAFDA(162.03,FBIENS,.055)=FBDODINV     ; DoD invoice#
 . D FILE^DIE("","FBIAFDA")                   ; update the database
 . Q
 ;
 ; if DoD invoice# is still not found, then report an error condition to Central Fee
 I FBDODINV="" S FBDODINV="9999999999999999999999"  ; error value to be sent to Central Fee
 ;
IPACX ;
 S FBIA=$$LJ^XLFSTR(FBIA,"10T")           ; IPAC agreement id#
 S FBDODINV=$$LJ^XLFSTR(FBDODINV,"22T")   ; DoD invoice#
 Q
 ;
