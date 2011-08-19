PRCB1E1 ;WISC/PLT/BGJ-PRCB1E continue ;1/8/97  12:55
V ;;5.1;IFCAP;**145**;Oct 20, 2000;Build 3
 ;Per VHA Directive 2004-038, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;prcduz - user id #
 ;prcopt data ^1=option #, ^2=yyyy-q, ^3=station #, ^4=cp ri
 ;prcdes = description
TMEN ;carry forward 
 N PRCA,PRCB,PRCD,PRCE,PRCDI,PRCRICB,PRCLOCK,PRCRI
 N A,B,C
 I $D(ZTQUEUED) D KILL^%ZTLOAD
 ;from quarter, prcopt data ^5=from qtr bd, ^6=to qtr bd, ^7=to fy (yyyy)-qtr
 I $P(PRCOPT,"^",2)'?4N1"-"1N D EN^DDIOL("CARRY FORWARD FAILS WITH WRONG YEAR FORMAT.") QUIT
 S A=$P(PRCOPT,"^",2),A=$$QTRDATE^PRC0D(+A,$P(A,"-",2))
 S $P(PRCOPT,"^",5)=$P(A,"^",7)
 ;to quarter
 S A=$$DATE^PRC0C($P(A,"^",8)+100,"H"),A=$$QTRDATE^PRC0D(+A,$P(A,"^",2))
 S $P(PRCOPT,"^",6)=$P(A,"^",7),$P(PRCOPT,"^",7)=$P(A,"^")_"-"_$P(A,"^",2)
 S PRCDES=PRCDES_" to "_$E($P(PRCOPT,"^",7),3,999)
 D EN^DDIOL(PRCDES)
 S A=$$DATE^PRC0C("T","E"),A=$P(A,"^",4)_"/"_$P(A,"^",5)_"/"_$P(A,"^",3)
 S PRC("SITE")=$P(PRCOPT,"^",3)
 D EN^DDIOL("Station: "_PRC("SITE")_"          Printed on "_A)
 S B=3 D ICLOCK^PRC0B("^PRCS(410,"""_PRCOPT_""",",.B)
 I 'B D EN^DDIOL("   Another Carry Forward job is running, try later!") QUIT
 I $P(PRCOPT,"^")=3 D FCPBAL(PRCOPT,$P(PRCOPT,"^",4)),CPBAL^PRCB1E2(PRCOPT,$P(PRCOPT,"^",4)) I 1
 E  I $P(PRCOPT,"^")=1,$P(PRCOPT,"^",2)["-4",$P(^PRC(411,PRC("SITE"),0),"^",25)'="Y" D EN^DDIOL("The outstanding requests are not carried forward to the new fiscal year.") I 1
 E  S PRCRI(420.01)=0 F  S PRCRI(420.01)=$O(^PRC(420,+PRC("SITE"),1,PRCRI(420.01))) Q:PRCRI(420.01)>9998!'PRCRI(420.01)  S PRCD=$G(^(PRCRI(420.01),0)) I PRCD]"",'$P(PRCD,"^",19) D
 . D:"1"[$P(PRCOPT,"^") FCPUOB(PRCOPT,+PRCD)
 . D:"2"[$P(PRCOPT,"^") FCPBAL(PRCOPT,+PRCD),CPBAL^PRCB1E2(PRCOPT,+PRCD)
 . QUIT
 I "1"[$P(PRCOPT,"^"),$P(^PRC(420,+PRC("SITE"),0),"^",9)<$P(PRCOPT,"^",6) D EDIT^PRC0B(.X,"420;^PRC(420,;"_(+PRC("SITE")),"9////"_$P(PRCOPT,"^",6),"SL")
 D DCLOCK^PRC0B("^PRCS(410,"""_PRCOPT_""",")
 D EN^DDIOL("End of Report at "_$$NOW^PRC5A)
EXIT QUIT
 ;
 ;prca = prcopt, prcb=fund control point ri
FCPUOB(PRCA,PRCB) ;carry forward all unobligated request to new quarte and
 N PRC,PRCRI,PRCC,PRCD,PRCE,PRCF,PRCG
 N A,B,C,X,Y
 S PRC("SITE")=$P(PRCA,"^",3),PRCRI(420)=+PRC("SITE"),PRCRI(420.01)=+PRCB
 S PRC("CP")=$P($G(^PRC(420,PRCRI(420),1,PRCRI(420.01),0)),"^")
 S PRCC=$$QTRDT^PRC0G(PRCRI(420)_"^"_PRCRI(420.01)_"^"_+$P(PRCA,"^",2)_"^"_"F")
 QUIT:$P(PRCA,"^",5)'<$P(PRCC,"^",2)  ;last qtr always open
 S PRCD=$P(PRCA,"^",5)_"-"_PRC("SITE")_"-"_$P(PRC("CP")," ")_"-",PRCE=PRCD_"~"
 F  S PRCD=$O(^PRCS(410,"RB",PRCD)),PRCRI(410)=0 QUIT:PRCD]PRCE!'PRCD  D
 . F  S PRCRI(410)=$O(^PRCS(410,"RB",PRCD,PRCRI(410))) Q:'PRCRI(410)  D
 .. S PRCF=$G(^PRCS(410,PRCRI(410),0)),PRCG=$P(PRCF,"^",12),PRCH=-$P($G(^(4)),"^",8)
 .. ;credit back the approved requests committed charge
 .. I PRCG="A" S B=$P(PRCA,"^",2) D EBAL^PRCSEZ(PRCRI(420)_"^"_PRCRI(420.01)_"^"_$E(B,3,4)_"^"_$P(B,"-",2)_"^"_PRCH,"C")
 .. I "EA"[PRCG D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),"449////"_$P(PRCA,"^",6),"LS")
 .. ;if approved charge to new quarter
 .. I PRCG="A" S B=$P(PRCA,"^",7) D EBAL^PRCSEZ(PRCRI(420)_"^"_PRCRI(420.01)_"^"_$E(B,3,4)_"^"_$P(B,"-",2)_"^"_-PRCH,"C")
 .. I "EA"[PRCG W !,$P(PRCF,"^",1),?20,$S(PRCG="E":"ENTERED",1:"APPROVED")
 .. QUIT
 QUIT
 ;
 ;prca = prcopt, prcb=fund control point ri
FCPBAL(PRCA,PRCB) ;carry forward cp ballance
 N PRC,PRCRI,PRCC,PRCD,PRCCOM,PRCOBL
 N A,B,C,X,Y,Z,DA
 S PRC("SITE")=$P(PRCA,"^",3),PRCRI(420)=+PRC("SITE"),PRCRI(420.01)=+PRCB
 S PRC("CP")=$P($G(^PRC(420,PRCRI(420),1,PRCRI(420.01),0)),"^")
 S PRCC=$$QTRDT^PRC0G(PRCRI(420)_"^"_PRCRI(420.01)_"^"_+$P(PRCA,"^",2)_"^"_"F")
 QUIT:$P(PRCA,"^",5)'<$P(PRCC,"^",2)  ;last qtr always open
 S A=$P(PRCOPT,"^",2),PRC("FY")=$E(A,3,4),PRC("QTR")=$P(A,"-",2)
 L +^PRC(420,PRCRI(420),1,PRCRI(420.01),4,PRC("FY"),0):5
 E  S PRC("MSG")="Note: Carry forward from "_$P(PRC("CP")," ")_" failed. File locked by another user." D EN^DDIOL(PRC("MSG")) QUIT
 S A=$G(^PRC(420,PRCRI(420),1,PRCRI(420.01),4,PRC("FY"),0))
 L -^PRC(420,PRCRI(420),1,PRCRI(420.01),4,PRC("FY"),0)
 QUIT:A=""
 S PRCCOM=-$P(A,"^",1+PRC("QTR")),PRCOBL=-$P(A,"^",5+PRC("QTR"))
 I +PRCOBL=0 S PRC("MSG")=PRC("CP")_" Qtr "_$E($P(PRCOPT,"^",2),3,999)_" closed. $"_$J(PRCOBL,0,2)_" carried forward."
 ;zero out from quarte balances
 S A=$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),PRC("CP"),1)
 S X=PRC("SITE")_"-"_PRC("FY")_"-"_$P(PRC("CP")," ")
 S Z=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," ")
 D EN1^PRCSUT3 S PRC("TXNTO")=X D EN2^PRCSUT3 S PRCRI(410)=$G(DA)
 I 'PRCRI(410) S PRC("MSG")="Note: Carry forward 'to' fails for "_$P(PRC("CP")," ")_"   $"_$J(PRCOBL,10,2) D EN^DDIOL(PRC("MSG")) G MM
 S A="1///C;40////^S X=PRCDUZ;42////^S X=PRCDUZ;449////"_$P(PRCA,"^",5)_";450////O;35////"_PRCOBL_";24////"_"TO "_$E($P(PRCA,"^",7),3,999)
 D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),A)
 ;carry forward from qtr balances to new quarter
 S PRCOBL=-PRCOBL
 S A=$P(PRCOPT,"^",7),PRC("FY")=$E(A,3,4),PRC("QTR")=$P(A,"-",2)
 S A=$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),PRC("CP"),1)
 S X=PRC("SITE")_"-"_PRC("FY")_"-"_$P(PRC("CP")," ")
 S Z=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," ")
 D EN1^PRCSUT3 S PRC("TXNFR")=X D EN2^PRCSUT3 S PRCRI(410)=$G(DA)
 I 'PRCRI(410) S PRC("MSG")="Note: Carry forward 'from' fails for "_$P(PRC("CP")," ")_"   $"_$J(PRCOBL,10,2) D EN^DDIOL(PRC("MSG")) G MM
 S A="1///C;40////^S X=PRCDUZ;42////^S X=PRCDUZ;449////"_$P(PRCA,"^",6)_";450////O;35////"_PRCOBL_";24////"_"FROM "_$E($P(PRCA,"^",2),3,999)
 D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),A)
 S PRC("MSG")=PRC("CP")_" Qtr "_$E($P(PRCOPT,"^",2),3,999)_" closed. $"_$J(PRCOBL,0,2)_" carried forward."
MM D EN^DDIOL($J($P(PRC("CP")," "),8)_"  "_$E($P(PRC("CP")," ",2,999)_$J("",40),1,40)_"  (CEI) $"_$J(PRCOBL,0,2)) D:+PRCOBL'=0
 . N A,B,X,Y,XMY
 . D NAMES^PRCBBUL
 . S X(1)=PRC("MSG")
 . D:$O(XMY("")) MM^PRC0B2(PRCDES,"X(",.XMY)
 . QUIT
 QUIT
