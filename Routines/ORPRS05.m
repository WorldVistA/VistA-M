ORPRS05 ; slc/dcm - Order summary headers, footers, inerds ;6/10/97  15:42
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**11**;Dec 17, 1997
PTOP(PG,TITLE,SHORT,START,STOP) ;header for printouts
 ;PG=Page #
 ;TITLE=Report title
 ;SHORT=Format type (short or long)
 ;START=Internal start date^External start date
 ;STOP=Internal stop date^External Stop date
 Q:'$G(PG)  Q:'$D(TITLE)
 N ORHLINE S $P(ORHLINE,"=",IOM+1)=""
 W !?(IOM-$L(ORTIT)\2),ORTIT,?(IOM-($L(PG)+5)),$S('$G(SHORT):"Page "_PG,1:"")
 W ! I $L($P(START,"^",2)) D  W X
 . S X=$P(START,"^",2)_" thru "_$P(STOP,"^",2) I $$FMDIFF^XLFDT(+STOP,+START)<2 S X="For: "_$P($P(STOP,"^",2),"@")
 S X=$P($$HTE^XLFDT($H),":",1,2) W ?IOM-($L(X)+8),"Printed "_X
 W !,"Ord'd",?9,"ST",?13,"Item Ordered",?54,"Requestor   Start     Stop",!,ORHLINE
 Q
PBOT(PG,BOTTOM,NAME,SSN,DOB,AGE,WEIGHT,LOC,BED,SHORT) ;Footer for printouts
 ;PG=Page #
 ;BOTTOM=Page length
 ;NAME=Patient name
 ;SSN=SSN, DOB=DOB, AGE=Age, WEIGHT=Weight, LOC=Location, BED=bed
 ;SHORT=Report format (short or long)
 Q:'$G(PG)  Q:'$G(BOTTOM)  Q:'$D(NAME)  Q:'$D(SSN)  Q:'$D(DOB)  Q:'$D(AGE)  Q:'$D(LOC)
 N ORHLINE S $P(ORHLINE,"=",IOM+1)=""
 I '$G(SHORT) F I=$Y:1:(BOTTOM-6) W !
 W !,ORHLINE S X=DOB_" ("_AGE_")   "_"Wt (lb): "_$S($D(WEIGHT):WEIGHT,1:"  ")
 W !,NAME,"   ",SSN,?IOM-$L(X),X
 W !,LOC,$S($L($G(BED)):"/"_BED,1:"") W:'$G(SHORT) ?(IOM-($L(PG)+5)),"Page "_PG,!
 Q
CTOP(PG,SEND,EOP,TITLE,SHORT,LOC,BED,WARD,NAME,SSN,DOB,AGE,WEIGHT) ;Display header
 ;PG=Page #
 ;SEND=??
 ;EOP=??
 ;TITLE=Report title
 ;SHORT=Report format (short or long)
 Q:'$G(PG)  Q:'$D(TITLE)  Q:'$D(SHORT)
 I $G(SEND),$G(EOP) Q
 N ORHLINE S $P(ORHLINE,"=",IOM+1)=""
 W @IOF
 W !?(IOM-$L(TITLE)\2),TITLE I $G(PG) W ?IOM-$L(PG)-5,"Page "_PG
 I '$G(SHORT) D HDG
 W !,"Ord'd",?9,"St",?13,"Item Ordered",?54,"Requestor  Start     Stop",!,ORHLINE
 Q
HDG ;Print header
 Q:'$D(DOB)  Q:'$D(AGE)  Q:'$D(WEIGHT)  Q:'$D(NAME)  Q:'$D(SSN)
 I '$D(LOC),$G(WARD) S X=+$G(^DIC(42,+WARD,44)) S LOC=$P($G(^SC(X,0)),"^",2)
 S X=DOB_" ("_AGE_")   "_"Wt (lb): "_$S($D(WEIGHT):WEIGHT,1:"  ")
 S:'$D(BED) BED=""
 S X1=LOC_$S($L(BED):"/"_BED,1:"")
 W !,NAME,"   ",SSN,?39-($L(X1)\2),X1,?(79-$L(X)),X
 Q
