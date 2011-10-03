QAOSAHOC ;HISC/DAD-AD HOC REPORT INTERFACE FOR THE QA OCCURRENCE SCREEN FILE (#741) ;7/9/93  13:28
 ;;3.0;Occurrence Screen;;09/14/1993
EN ;
 S QAQMRTN="MENU^QAOSAHO2",QAQORTN="OTHER^QAOSAHOC",QAQDIC=741
 S QAQMHDR="Occurrence Screen"
 D ^QAQAHOC0
 K QAOSCLIN,QAOSEXCP,QAQFOUND
 Q
OTHER ;
 K DIS S QA=0
O1 W !!?3,"Do you want the report to include 'deleted' records"
 S %=2 D YN^DICN I %=-1 S QAQQUIT=1 Q
 I %=0 W !!?5,"Please answer Y(es) or N(o)" G O1
 I %=2 S DIS(QA)="I $P(^QA(741,D0,0),""^"",11)'=2",QA=1
O2 W !!?3,"Do you want the report to include 'exception to criteria' records"
 S %=2 D YN^DICN I %=-1 S QAQQUIT=1 Q
 I %'>0 W !!?5,"Please answer Y(es) or N(o)" G O2
 I %=2 D
 . S QAOSCLIN=+$O(^QA(741.2,"C",1,0)),QAOSEXCP=+$O(^QA(741.6,"B",3,0))
 . S DIS(QA)="I QAOSEXCP'=$P($G(^QA(741,D0,""REVR"",+$O(^QA(741,D0,""REVR"",""B"",QAOSCLIN,0)),0)),""^"",5)"
 . Q
O3 K QAQFOUND S QAQFOUND=0,DHIT="S QAQFOUND=1"
 S DIOEND="I 'QAQFOUND W !!,""No data found for this report !!"""
 Q
