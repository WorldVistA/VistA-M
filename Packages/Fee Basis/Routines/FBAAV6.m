FBAAV6 ;AISC/GRR,WOIFO/SAB - CREATE TRANSACTIONS TO SEND TO PRICER ;9/14/2009
 ;;3.5;FEE BASIS;**55,108**;JAN 30, 1995;Build 115
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 S FBFLAG=1,FBTXT=0
 S FBSTAT="P",FBJ=J D UPDT^FBAAUTL2 S J=FBJ F K=0:0 S K=$O(^FBAAI("AC",J,K)) Q:K'>0  S Y(0)=$G(^FBAAI(K,0)),Y(5)=$G(^FBAAI(K,5)) I Y(0)]"" D
 .I 'FBTXT S FBTXT=1 D NEWMSG^FBAAV01
 .D GOT
 D:FBTXT XMIT^FBAAV01 K FBFLAG Q
 ;
GOT N FBCDCNT,FBCSVDT,FBI,FBLNCNT,FBTL
 S FBCSVDT=$$FRDTINV^FBCSV1(K) ; code set version date
 S FBPAYT=$P(Y(0),"^",13),FBPAYT=$S(FBPAYT]"":$S(FBPAYT="R":"P",1:FBPAYT),1:"V"),FBVID=$P(Y(0),"^",3),FBVEN=FBVID I FBVID]"" S FBVID=$S($D(^FBAAV(FBVID,0)):$P(^(0),"^",17),1:$E(PAD,1,6))
 S:FBVID']"" FBVID=$E(PAD,1,6)
 S FB7078=$P(Y(0),"^",5) I FB7078]"" D
 .I FB7078["FB7078(",$D(^FB7078(+FB7078,0)) S FBFNY=^FB7078(+FB7078,0),FBFDT=$S($P(FBFNY,"^",15):$P(FBFNY,"^",15),1:$P(FBFNY,"^",4)),FBTDT=$S($P(FBFNY,"^",16):$P(FBFNY,"^",16),1:$P(FBFNY,"^",5))
 .I FB7078["FB583(",$D(^FB583(+FB7078,0)) S FBFNY=^FB583(+FB7078,0),FBFDT=$S($P(FBFNY,"^",5)]"":$P(FBFNY,"^",5),1:$P(FBFNY,"^",13)),FBTDT=$S($P(FBFNY,"^",6)]"":$P(FBFNY,"^",6),1:$P(FBFNY,"^",14))
 S X1=FBTDT,X2=FBFDT D ^%DTC S FBLOS=$S(X<1:1,1:X),FBFDT=$E(FBFDT,4,7)_($E(FBFDT,1,3)+1700)
 S FBTDT=$E(FBTDT,4,7)_($E(FBTDT,1,3)+1700),FBLOS=$E("000",$L(FBLOS)+1,3)_FBLOS,FBRESUB=+$P(Y(0),"^",25)
 S:+FBLOS>999 FBLOS="***"
 ;S:$L(FBLOS)>3 FBLOS="***" ; >999 not supported, *** to cause reject
 S FBDISP=$P(Y(0),"^",21) I FBDISP]"" S FBDISP=$S($D(^FBAA(162.6,FBDISP,0)):$P(^(0),"^",2),1:"00")
 S FBDISP=$E("00",$L(FBDISP)+1,2)_FBDISP,FBBILL=$P(Y(0),"^",22)+.00001,FBBILL=$P(FBBILL,".",1)_$E($P(FBBILL,".",2),1,2),FBBILL=$E("000000000",$L(FBBILL)+1,9)_FBBILL
 S FBCLAIM=$P(Y(0),"^",8)+.00001,FBCLAIM=$P(FBCLAIM,".",1)_$E($P(FBCLAIM,".",2),1,2),FBCLAIM=$E("000000000",$L(FBCLAIM)+1,9)_FBCLAIM
 S FBSTAT=$S(FBVEN']"":"",$D(^FBAAV(FBVEN,0)):$P(^(0),"^",5),1:"")
 S FBSTABR=$S(FBSTAT']"":"  ",$D(^DIC(5,FBSTAT,0)):$P(^(0),"^",2),1:"  "),FBSTABR=$E("  ",$L(FBSTABR)+1,2)_FBSTABR,FBAUTH=""
 I $L(FBSTABR)>2 S FBSTABR="**" ; ** to cause reject of invalid state
 I FB7078]"" S FBAUTH=$S(FB7078["FB583(":" ",$D(^FB7078(+FB7078,0)):$P(^(0),"^",6),1:" ")
 S FBAUTH=$$AUTH(FBAUTH)
 S DFN=+$P(Y(0),"^",4),FBMED=$P(Y(0),"^",23),FBMED=$S(FBMED="":"N",1:FBMED),Y(0)=$G(^DPT(DFN,0)) D PAT^FBAAUTL2 S FBLNAM=$E(FBFLNAM,1,12),FBSSN=$E(FBSSN,10)_$E(FBSSN,1,9)_" "
 ;
 S FBLNCNT=0 ; init invoice line counter
 D NEWLN
 ; compute total lines needed (2-5)
 S FBTL=($$LAST^FBCHEP1(K,"DX")+$$LAST^FBCHEP1(K,"PROC"))\13+2
 ; add rest of data for line 1
 S FBSTR=FBSTR_FBTL_FBLNAM_FBFI_FBMI_FBSEX_FBDOB_FBLOS
 S FBSTR=FBSTR_FBDISP_FBBILL_FBCLAIM_FBAUTH_FBPAYT_FBAACP_FBAAON_"Y"
 S FBSTR=FBSTR_FBVID_FBMED_$E(PAD,1,29)_FBTDT_FBSTABR_"  "
 D STORE
 ;
 S FBYDX=$G(^FBAAI(K,"DX"))
 S FBYPOA=$G(^FBAAI(K,"POA"))
 D NEWLN
 ; admitting Dx
 S FBADMTDX=$P($G(^FBAAI(K,5)),"^",9)
 ; NVH Pricer requested sending primary Dx if admit Dx not known
 I 'FBADMTDX S FBADMTDX=$P(FBYDX,"^")
 S FBCDCNT=1 ; count of codes for line
 S FBSTR=FBSTR_$$DX(FBADMTDX,FBCSVDT,"")
 ;
 ; loop thru Dx
 F FBI=1:1:25 Q:$P(FBYDX,"^",FBI)=""  D
 . S FBCDCNT=FBCDCNT+1
 . I FBCDCNT=14 D
 . . D STORE
 . . D NEWLN
 . . S FBCDCNT=1
 . S FBSTR=FBSTR_$$DX($P(FBYDX,"^",FBI),FBCSVDT,$P(FBYPOA,"^",FBI))
 K FBADMTDX,FBYDX,FBYPOA
 ;
 ; loop thru Proc
 S FBYPROC=$G(^FBAAI(K,"PROC"))
 F FBI=1:1:25 Q:$P(FBYPROC,"^",FBI)=""  D
 . S FBCDCNT=FBCDCNT+1
 . I FBCDCNT=14 D
 . . D STORE
 . . D NEWLN
 . . S FBCDCNT=1
 . S FBSTR=FBSTR_$$PROC($P(FBYPROC,"^",FBI),FBCSVDT)
 K FBYPROC
 ;
 ; pad remainder of the invoice last line with spaces
 S FBSTR=$$LJ^XLFSTR(FBSTR,131," ")
 D STORE
 Q
 ;
AUTH(X) ;Function call to provide the Admitting Regulation.
 ;X is equal to the internal entry number of the VA Admitting Reg file
 ;User is returned with an alpha dependent on the Admitting Reg chosen
 N CFR,FBCFR
 S CFR=$P($G(^DIC(43.4,+X,0)),"^",3) I '$G(CFR) Q "A"
 S FBCFR=$S(CFR="17.50b(a)(1)(i)":"A",CFR="17.50b(a)(1)(iii)":"B",CFR="17.50b(a)(1)(iv)":"C",CFR="17.50b(a)(3)":"H",CFR="17.50b(a)(4)":"D",CFR="17.50b(a)(5)":"E",CFR="17.50b(a)(6)":"F",CFR="17.50b(a)(8)":"G",1:"")
 I FBCFR="" S FBCFR=$S(CFR="17.50b(a)(9)":"I",CFR="17.80(a)(i)":"L",CFR="17.80(a)(iii)":"J",1:"A")
 Q FBCFR
 ;
NEWLN ; New Line
 S FBLNCNT=FBLNCNT+1 ; increment invoice line count
 S FBSTR=FBSSN_FBFDT_FBAASN_FBRESUB_FBLNCNT ; data at start of each line
 Q
 ;
STORE D STORE^FBAAV01
 Q
 ;
DX(FBDX,FBDATE,FBPOA) ; format diagnosis & POA for NVH Pricer
 ; Input
 ;   FBDX   = pointer to file 80 (ICD diagnosis)
 ;   FBDATE = fileman date
 ;   FBPOA  = (optional) poiner to file 161.94 (present on admission)
 ; Returns formatted string of 8 characters
 N FBRET,FBX,FBX2
 S FBRET="        "
 I FBDX D
 . S FBX=$$ICD9^FBCSV1(FBDX,FBDATE)
 . S:FBX["." FBX=$P(FBX,".",1)_$P(FBX,".",2)
 . Q:FBX=""
 . S FBX=FBX_$E("       ",$L(FBX)+1,7)
 . S FBX2=$S($G(FBPOA):$P($G(^FB(161.94,FBPOA,0)),"^"),1:"")
 . S:FBX2="" FBX2=" "
 . S FBRET=FBX_FBX2
 Q FBRET
 ;
PROC(FBPROC,FBDATE) ; format procedure for NVH Pricer
 ; Input
 ;   FBPROC = pointer to file 80.1 (ICD operation/procedure)
 ;   FBDATE = fileman date
 ; Returns formatted string of 8 characters
 N FBRET,FBX
 S FBRET="        "
 I FBPROC D
 . S FBX=$$ICD0^FBCSV1(FBPROC,FBDATE)
 . S:FBX["." FBX=$P(FBX,".",1)_$P(FBX,".",2)
 . Q:FBX=""
 . S FBX=FBX_$E("       ",$L(FBX)+1,7)
 . S FBRET=FBX_"*"
 Q FBRET
