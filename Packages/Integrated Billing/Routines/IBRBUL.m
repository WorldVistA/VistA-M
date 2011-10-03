IBRBUL ;ALB/CJM-MEANS TEST HOLD CHARGE BULLETIN ;02-MAR-92
 ;;2.0;INTEGRATED BILLING;**70,95,121,153,195,347**;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ; This bulletin is sent even if the local site has chosen not to hold
 ; Means Test charges. In that case, IBHOLDP should be set = 0.
 ; requires: IBDD() = internal node in patient file of valid ins.
 ;           DUZ
 ;           X = 0 node of IB BILLING ACTION
 ;           IBHOLDP = 1 if charge on hold, = 0 otherwise
 ;           IBSEQNO = 1 if the charges are new, 3 if updated
BULL N XMSUB,XMY,XMDUZ,XMTEXT,IBX,IBDUZ,IBNAME,IBPID,IBBID,IBAGE,DFN
 S IBX=X,IBDUZ=DUZ
 K ^TMP($J,"IBRBUL")
 D PAT,HDR,PATLINE,CHRG,INS,BUF,MAIL
 K ^TMP($J,"IBRBUL")
 Q
MAIL ; Transmit mail
 N IBGRP S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="^TMP($J,""IBRBUL"","
 K XMY
 S IBGRP=$P($G(^XMB(3.8,+$P($G(^IBE(350.9,1,0)),U,11),0)),U)
 I IBGRP]"" S XMY("G."_IBGRP_"@"_^XMB("NETNAME"))=""
 D ^XMD
 Q
 ;Add a line to the text array
ADDLN(IBTXT) N IBC
 S IBC=$O(^TMP($J,"IBRBUL",""),-1)+1
 S ^TMP($J,"IBRBUL",IBC)=$G(IBTXT," ")
 Q
 ;
MAILTST ; for testing
 ;N IBC
 ;W !,XMSUB
 ;F IBC=1:1 Q:'$D(^TMP($J,"IBRBUL",IBC))  W !,^(IBC)
 Q
HDR ; formated for held charges
 N IBW,IBU,IBV,SL S IBW=$S('IBHOLDP:"NOT ON HOLD",1:"ON HOLD"),IBU=$S(IBSEQNO=1:"NEW ",IBSEQNO=3:"UPDATED ",1:""),IBV=$S(+$O(IBDD(0)):"active",1:"may have")
 ; if the parent event should have the soft-link that is needed to find
 ; the division
 S SL=$P(X,"^",16) S:SL SL=$G(^IB(SL,0)) S:'SL SL=X S SL=$P(SL,"^",4)
 S XMSUB=$E(IBNAME,1,8)_"("_IBBID_")"_" PATIENT CHRG W/INS"_"-"_$E($$DIV(SL),1,11)
 D ADDLN("The following patient has "_IBU_"charges "_IBW_" and "_IBV_" insurance.")
 D ADDLN("You need to immediately process the charges to the insurance company.")
 I +$$BUFFER^IBCNBU1(+$P(X,"^",2)) D
 . D ADDLN()
 . D ADDLN("This patient has entries in the Insurance Buffer that should be processed")
 . D ADDLN("before the charges.")
 Q
PAT ; gets patient demographic data
 N VAERR,VADM,X,VA
 S DFN=+$P(IBX,"^",2) D DEM^VADPT I VAERR K VADM
 S IBNAME=$$PR($G(VADM(1)),26),IBAGE=$$PR($G(VADM(4)),3),IBPID=$G(VA("PID")),IBBID=$G(VA("BID"))
 Q
PATLINE ; sets up lines with patient data 
 D ADDLN(),ADDLN("Name: "_IBNAME_"   Age    : "_IBAGE_"       Pt. ID: "_IBPID)
 Q
CHRG ; gets charge data and sets up charge lines
 N TP,FR,TO,IBND1,IBRXN,IBRX,IBRDT,IBRF,IENS
 S IBND1=$G(^IB(+$G(IBN),1)),(IBRX,IBRXN,IBRF,IBRDT)=0
 S FR=$$DAT1^IBOUTL($S($P(IBX,"^",14)'="":($P(IBX,"^",14)),1:$P(IBND1,"^",2)))
 S TO=$$DAT1^IBOUTL($S($P(IBX,"^",15)'="":($P(IBX,"^",15)),1:$P(IBND1,"^",2)))
 I $P(IBX,"^",4)["52:" S IBRXN=$P($P(IBX,"^",4),":",2),IBRX=$P($P(IBX,"^",8),"-"),IBRF=$P($P(IBX,"^",4),":",3)
 I $P(IBX,"^",4)["52:"  D
 .I IBRF>0 S IENS=+IBRF,IBRDT=$$SUBFILE^IBRXUTL(+IBRXN,IENS,52,.01)
 .E  S IENS=+IBRXN,IBRDT=$$FILE^IBRXUTL(IENS,22)
 S TP=$P(IBX,"^",3) S:TP TP=$P($G(^IBE(350.1,TP,0)),"^",3) S:TP TP=$P($$CATN^PRCAFN(TP),"^",2)
 D ADDLN("Type: "_$$PR(TP,28)_" Amount : $"_+$P(IBX,"^",7))
 D ADDLN("From: "_$$PR(FR,28)_" To     : "_TO)
 I IBRXN D ADDLN("Rx #: "_$$PR(IBRX_$S(IBRF'="":" ("_IBRF_")",1:""),28)_" Fill Dt: "_$$DAT1^IBOUTL(IBRDT)_"  Rls Dt: "_TO)
 Q
INS ; gets insurance data and sets up insurance lines
 N I,CO,P,G,GNB,W,E,Y,C,COV,COVD,COVFN,LEDT,LIM,PLN,X1,X2,Z0,IBCNT,P1,P2,P3,P4
 ;S IBDTIN=$P(IBX,"^",14)
 D ADDLN(),ADDLN("INSURANCE INFORMATION:")
 S I="" F  S I=$O(IBDD(I)) Q:'I  D
 .S LIM=0
 .S CO=$P(IBDD(I),"^",1),CO=$P(^DIC(36,CO,0),"^",1),CO=$$PR(CO,25)
 .S P=$$PR($P(IBDD(I),"^",2),21)
 .S P1=2.312,P2=6,P3=$P($G(IBDD(I)),"^",6) S P4=$$EXPAND^IBTRE(P1,P2,P3) S W=$$PR(P4,25)
 .S Y=$P(IBDD(I),"^",4) D:Y DD^%DT S E=Y
 .S G=$$PR($P(IBDD(I),"^",15),25)
 .S GNB=$P(IBDD(I),"^",3)
 .S PLN=$P(IBDD(I),"^",18)
 .D ADDLN(),ADDLN("Company: "_CO_" Policy#: "_P)
 .D ADDLN("Whose  : "_W_" Expires: "_E)
 .D ADDLN("Group  : "_G_" Group# : "_GNB)
 .Q:'PLN
 .D ADDLN(" Plan Coverage   Effective Date   Covered?      Limit Comments")
 .D ADDLN(" -------------   --------------   --------      --------------")
 .F  S LIM=$O(^IBE(355.31,LIM)) Q:'LIM  S COV=$P($G(^(LIM,0)),U),IBCNT=0,LEDT="" F  S LEDT=$O(^IBA(355.32,"APCD",PLN,LIM,LEDT)) Q:$S(LEDT="":IBCNT,1:0)  D  Q:LEDT=""
 ..S COVFN=+$O(^IBA(355.32,"APCD",PLN,LIM,+LEDT,"")),COVD=$G(^IBA(355.32,+COVFN,0))
 ..I COVD="" D ADDLN("  "_$$PR(COV,32)_"BY DEFAULT") Q
 ..S IBCNT=IBCNT+1
 ..S X1="  "_$S(IBCNT=1:COV,1:"") ;Don't duplicate category
 ..S X2=$$PR(X1,18)_$$PR($$DAT1^IBOUTL($P(LEDT,"-",2)),16)_$$PR($S($P(COVD,U,4):$S($P(COVD,U,4)<2:"YES",$P(COVD,U,4)=2:"CONDITIONAL",1:"UNKNOWN"),1:"NO"),14)
 ..I '$O(^IBA(355.32,COVFN,2,0)) D ADDLN(X2) Q
 ..S Z0=0 F  S Z0=$O(^IBA(355.32,COVFN,2,Z0)) Q:'Z0  D ADDLN($S(Z0=1:X2_$G(^IBA(355.32,COVFN,2,Z0,0)),1:$$PR("",48)_$G(^IBA(355.32,COVFN,2,Z0,0))))
 Q
PR(STR,LEN) ; pad right
 N B S STR=$E(STR,1,LEN),$P(B," ",LEN-$L(STR))=" "
 Q STR_$G(B)
DIV(SL) ; returns the division with the softlink as input
 N IBDIV,IBWARD,IBFILE,IBIEN
 S:SL[";" SL=$P(SL,";",1)
 S IBFILE=$P(SL,":",1),IBIEN=$P(SL,":",2)
 S IBDIV=""
 I IBFILE=409.68,IBIEN S IBDIV=$$SCE^IBSDU(IBIEN,11)
 I IBFILE=44,IBIEN S IBDIV=$P($G(^SC(IBIEN,0)),"^",15)
 I IBFILE=405,IBIEN S IBWARD=$P($G(^DGPM(IBIEN,0)),"^",6) I IBWARD S IBDIV=$P($G(^DIC(42,IBWARD,0)),"^",11)
 I IBDIV S IBDIV=$P($G(^DG(40.8,IBDIV,0)),"^",1)
 I IBDIV="" S IBDIV="DIV UNKNWN"
 Q IBDIV
 ;
BUF ;  gets insurance buffer entries and sets up lines to add to bulletin
 N DFN,IBBDA,IBB40,IBB60,IBX1,IBX2 S DFN=$P(IBX,U,2) Q:'DFN
 I '$$BUFFER^IBCNBU1(DFN) Q
 ;
 D ADDLN()
 D ADDLN("INSURANCE BUFFER:")
 S IBBDA=0 F  S IBBDA=$O(^IBA(355.33,"C",DFN,IBBDA)) Q:'IBBDA  D
 . S IBB40=$G(^IBA(355.33,IBBDA,40)),IBB60=$G(^IBA(355.33,IBBDA,60))
 . ;
 . D ADDLN()
 . S IBX1=$P($G(^IBA(355.33,IBBDA,20)),U,1),IBX2=$P(IBB60,U,4)
 . D ADDLN("Company: "_$$PR(IBX1,25)_"Policy#: "_$$PR(IBX2,21))
 . S IBX1=$$EXPAND^IBTRE(355.33,60.05,$P(IBB60,U,5)),IBX2=$$FMTE^XLFDT($P(IBB60,U,3))
 . D ADDLN("Whose  : "_$$PR(IBX1,25)_"Expires: "_IBX2)
 . S IBX1=$P(IBB40,U,2),IBX2=$P(IBB40,U,3)
 . D ADDLN("Group  : "_$$PR(IBX1,25)_"Group# : "_IBX2)
 Q
