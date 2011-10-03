PRCB1B ;WISC/PLT-Rollover fund control point balance ; 7/6/98 1000
V ;;5.1;IFCAP;**64,72**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
EN ;rollover fcp balance
 N PRCA,PRCB,PRCQCD,PRCOPT,PRCRI,PRCDI,A,B,PRCDES
 S PRCQCD=1
 S PRCA=$$DATE^PRC0C("T","E")
 S PRCA=$$QTRDATE^PRC0D(PRCA-($P(PRCA,"^",2)=1),$E(4123,$P(PRCA,"^",2)))
Q1 S PRC("FY")=$E(PRCA,3,4),PRC("QTR")=$P(PRCA,"^",2)
 S PRCF("X")="ABSFQ" D ^PRCFSITE G:'% EXIT
 ;check station rollover
 I $$NP^PRC0B("^PRC(420,"_+PRC("SITE")_",",0,8)=2 D  G EXIT
 . D EN^DDIOL("The rollover 'Transfer Funds to Another FCP' is not allowed for this station.")
 . QUIT
 S PRCC=$$QTRDATE^PRC0D(PRC("FY"),PRC("QTR"))
 S C=$P(PRCC,"^",8),C=$$DATE^PRC0C(C+100,"H"),C=$$QTRDATE^PRC0D(+C,$P(C,"^",2))
 S B="" F A=$P(C,"^",8):1 S:A-3#7'=6&(A-3#7) B=B+1 Q:B=PRCQCD
 S PRCB=$$DATE^PRC0C(A-1,"H") ;qtr closed date
 I $H'>$P(PRCB,"^",8) D EN^DDIOL("Please run this entered year/quarter after "_$P(PRCB,"^",4)_"/"_$P(PRCB,"^",5)_"/"_$P(PRCB,"^",3)) G Q1
Q2 S B="O^1:Single Year Appropriation Fund Control Points;2:Multiple Year Appropriation Fund Control Points"
 K X,Y S Y(1)="^W ""Enter an option number 1 to 2."""
 D SC^PRC0A(.X,.Y,"Select Number",B,"")
 S A=Y K X,Y
 G Q1:A=""!(A["^")
 S PRCOPT=+A
Q3 D FT^PRC0A(.X,.Y,"Description","O^1:60","")
 G:X["^"!(X="") Q2
 S PRCDES=X
 I PRCOPT=1 D SYFCP G Q1
Q4 F  D EN^DDIOL(" ") D  Q:PRCQT=1
 . S PRCDD=420.01,PRCQT=""
 . S X("S")="I $P(^(0),""^"",20)=1,'$P(^(0),""^"",19),$P(^(0),""^"",21),$$APP^PRC0C(PRC(""SITE""),PRC(""FY""),+Y)[""_/_"",Y-9999"
 . S PRCRI(420)=+PRC("SITE")
 . D LKUP^PRCB1B QUIT:PRCQT
 . I '$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),PRCRI(420.01)) D EN^DDIOL("  Beginning budget year required") QUIT
 . D MYFCP
 . QUIT
EXIT QUIT
 ;
LKUP ;lookup fcp
 N DA
 S DA=""
 S PRCDI="420;^PRC(420,;"_PRCRI(420)_"~420.01;^PRC(420,"_PRCRI(420)_",1,"
 D LOOKUP^PRC0B(.X,.Y,PRCDI,"AEMOQS","Select Multiple Year Fund Control Point: ")
 I Y<0!(X="") S PRCQT=1 K X QUIT
 K X S PRCRI(PRCDD)=+Y
 S PRCDI="420;^PRC(420,;"_PRCRI(420)_"~420.01;^PRC(420,"_PRCRI(420)_",1,;$"_PRCRI(420.01)
 QUIT
 ;
SYFCP ;single year fund control point
 S ZTDES="ROLLOVER FOR SINGLE YEAR FUND CONTROL POINT"
 S ZTRTN="TMEN^PRCB1B1" F A="PRC*","PRCC","DUZ*" S ZTSAVE(A)=""
 D ^PRCFQ
 QUIT
 ;
 ;
MYFCP ;
 S PRC("CP")=PRCRI(420.01)
 S PRCD=$G(^PRC(420,+PRC("SITE"),1,+PRC("CP"),0)) I PRCD]"",$P($G(^(5)),"^",7)<$P(PRCC,"^",7) D 
 . D FCPTRF^PRCB1B1
 . QUIT
 QUIT
 ;
