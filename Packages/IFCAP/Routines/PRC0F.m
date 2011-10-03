PRC0F ;WISC/PLT/BGJ-IFCAP A/E/D FILE UTILITY ;10/19/95  9:15 AM
V ;;5.1;IFCAP;**28**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ;invalid entry
 ;
DINUM ;called from ^dd(,.01,0)
 S DINUM=+X
 QUIT
 ;
INP411 ;
 ;Entry for 'Station Number'(D0) must match entry for 'Station'(X)
 I $G(D0),X'=D0 S X="" Q
 N Y
 S Y="" I X?3N D DIC^PRCFU S:+Y<1 X="" I +Y>0 S:$P(^DIC(4,+Y,99),U)?3N PRCF("INST")=+Y,X=$P(^DIC(4,+Y,99),U),DINUM=X S:$P(^DIC(4,+Y,99),U)'?3N X=""
 QUIT
 ;
 ;add FMS sub-allowance account in file 420.141
 ;PRCA is data ~1=station #,~2=bbfy,~3=fund,~4=a/o,~5=program
 ;          ~6=fcp/prj,~7=object class,~8=job
 ;PRCB=fund control number
A420D141(PRCA,PRCB) ;add new record in file 420.141
 S $P(PRCA,"~",2)=$P($$YEAR^PRC0C($P(PRCA,"~",2)),"^",1)
 S PRCA("DR")="1///"_PRCB
 D ADD^PRC0B1(.PRCA,.A,"420.141;^PRCD(420.141,")
 QUIT A
 ;
 ;get appropriation for file 421 TDAs
 ;A - DA number          B - Station Number
 ;C - four digit BBFY    D - two digit fiscal year
 ;E - fund control point
 ;F - returns site-fiscal year-appropriation-program
APP421(A) ; determine appropriation for file 421
 N B,C,D,E,F,X
 S X=^PRCF(421,A,0)
 S B=$P(X,"-"),D=$P(X,"-",2),E=$P(+$P(X,"^",2)," ")
 S C=$E($P(X,"^",23),2,3),C=+$$YEAR^PRC0C(C)
 S F=$$ACC^PRC0C(B,E_"^"_D_"^"_C),F=B_"-"_D_"-"_$P(F,"^",11)_"-"_$P(F,"^",5)_"-"_$P(F,"^",2)
 QUIT F
 ;
 ;PRCA DATA ^1=STATION #, ^2=CP #, ^3=txn type code (410,1)
 ;          ^4= form type # (optional), ^5 obl date, ^6=obl amt, ^7 p.o/obl # free text (410,24)
 ;          ^8= prority of request (410,7.5) optional
 ;          ^9=FILE 442 ri (optional), ^10=fy/qtr date
 ;          ^11=BBFY (4-DIGIT)
 ;.x - returned value = file 410 ri
A410(X,PRCA) ;add obligated entry in file 410
 N PRC,PRCIRI,PRCB
 N A,B,Y,Z
 K X
 S:$P(PRCA,"^",8)="" $P(PRCA,"^",8)="ST"
 S PRC("SITE")=$P(PRCA,"^"),PRCRI(420)=+PRC("SITE"),PRCRI(420.01)=+$P(PRCA,"^",2)
 S PRC("CP")=$P($G(^PRC(420,PRCRI(420),1,PRCRI(420.01),0)),"^")
 S PRCB=$S($P(PRCA,"^",10):$P(PRCA,"^",10),1:$P(PRCA,"^",5))
 S PRCB=$$DATE^PRC0C(PRCB,"I"),PRC("FY")=$E(PRCB,3,4),PRC("QTR")=$P(PRCB,"^",2)
 S PRC("BBFY")=$S($P(PRCA,"^",11):$P(PRCA,"^",11),1:$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),PRC("CP"),1))
 S X=PRC("SITE")_"-"_PRC("FY")_"-"_$P(PRC("CP")," ")
 S Z=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," ")
 D EN1^PRCSUT3,EN2^PRCSUT3 S:'$D(DA) DA="" S PRCRI(410)=DA
 I 'PRCRI(410) S X=PRCRI(410) QUIT
 S X="1////"_$P(PRCA,"^",3)_";3////"_$P(PRCA,"^",4)_";5////"_$P(PRCA,"^",5)_";7.5////"_$P(PRCA,"^",8)_";7////"_$P(PRCA,"^",5)_";30////"_$P(PRCA,"^",6)_";40////"_$G(DUZ)_";450////O"
 S X(1,410,1)="26////"_$P(PRCA,"^",5)_";25////"_$P(PRCA,"^",6)_";23////"_$P(PRCA,"^",5)_";24////"_$P(PRCA,"^",7)
 D EDIT^PRC0B(.X,"410;^PRCS(410,;"_PRCRI(410),"")
 I $G(PRCFA("PODA"))'="",$P($G(^PRC(442,PRCFA("PODA"),0)),"^",2)=25 F I=1,3,8 S $P(^PRCS(410,PRCRI(410),4),"^",I)=0
 S X=PRCRI(410)
 K I QUIT
