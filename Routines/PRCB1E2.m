PRCB1E2 ;WISC/PLT-PRCB1E continue ;3/4/97  15:59
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
 ;prcduz - user id #
 ;prcopt data ^1=option #, ^2=yyyy-q, ^3=station #, ^4=cp ri
 ;prcdes = description
 ;
 ;prca = prcopt, prcb=fund control point ri
CPBAL(PRCA,PRCB) ;carry forward cp ballance
 N PRC,PRCRI,PRCC,PRCD,PRCCOM
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
 S PRCCOM=$P(A,"^",1+PRC("QTR"))
 I +PRCCOM=0 S PRC("MSG")=PRC("CP")_" Qtr "_$E($P(PRCOPT,"^",2),3,999)_" adjusted with $"_$J(PRCCOM,0,2)_"."
 ;zero out from CP quarter balances
 S A=$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),PRC("CP"),1)
 S X=PRC("SITE")_"-"_PRC("FY")_"-"_$P(PRC("CP")," ")
 S Z=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," ")
 D EN1^PRCSUT3 S PRC("TXNTO")=X D EN2^PRCSUT3 S PRCRI(410)=DA
 I 'PRCRI(410) S PRC("MSG")="Note: CP balance adjust 'to' fails for "_$P(PRC("CP")," ")_"   $"_$J(PRCCOM,10,2) D EN^DDIOL(PRC("MSG")) G MM
 S A="1///A;40////"_DUZ_";449////"_$P(PRCA,"^",5)_";450////O;25.5////Y;24////QTRADJ;26///T"
 D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),A)
 D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),"25////"_PRCCOM)
 ;adjust new CP quarter balance
 S PRCCOM=-PRCCOM
 S A=$P(PRCOPT,"^",7),PRC("FY")=$E(A,3,4),PRC("QTR")=$P(A,"-",2)
 S A=$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),PRC("CP"),1)
 S X=PRC("SITE")_"-"_PRC("FY")_"-"_$P(PRC("CP")," ")
 S Z=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," ")
 D EN1^PRCSUT3 S PRC("TXNFR")=X D EN2^PRCSUT3 S PRCRI(410)=DA
 I 'PRCRI(410) S PRC("MSG")="Note: CP balance adjust 'from' fails for "_$P(PRC("CP")," ")_"   $"_$J(PRCCOM,10,2) D EN^DDIOL(PRC("MSG")) G MM
 S A="1///A;40////"_DUZ_";449////"_$P(PRCA,"^",6)_";450////O;25.5////Y;24////QTRADJ;26///T"
 D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),A)
 D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),"25////"_PRCCOM)
 S PRC("MSG")=PRC("CP")_" Qtr "_$E($P(PRCOPT,"^",2),3,999)_" adjusted with $"_$J(PRCCOM,0,2)_"."
MM D EN^DDIOL($J($P(PRC("CP")," "),8)_"  "_$E($P(PRC("CP")," ",2,999)_$J("",40),1,40)_"  (ADJ) $"_$J(PRCCOM,0,2)) D:+PRCCOM'=0
 . N A,B,X,Y,XMY
 . D NAMES^PRCBBUL
 . S X(1)=PRC("MSG")
 . D:$O(XMY("")) MM^PRC0B2(PRCDES,"X(",.XMY)
 . QUIT
 QUIT
