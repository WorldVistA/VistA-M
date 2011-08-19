IBDFU9 ;ALB/CJM - ENCOUNTER FORM - post-selection action for package interface file, screen for data qualifiers;OCT 18,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
ASK ;post-slection action for package interface
 Q:'$D(VALMEVL)  ; only ask if in listman
 Q:DIC["358.6"
 N LINE,DA,ANS,TYPE
 S DA=+Y
 I $G(DA),$D(^IBE(357.6,DA,1)) D
 .S TYPE=$P($G(^IBE(357.6,DA,0)),"^",6)
 .;
 .; -- see if we can find a marker and quit if in fileman  
 .;
 .; -- in the case of reports, the post-selection action is not executed 
 .;    until after the report is created in the setup, so it's not useful
 .Q:TYPE=4
 .;
 .S TYPE=$S(TYPE=1:"type of data",TYPE=2:"type of data",TYPE=3:"type of data",TYPE=4:"report",1:"package interface")
 .S LINE=0 W ! F  S LINE=$O(^IBE(357.6,DA,1,LINE)) Q:'LINE  W !,$G(^IBE(357.6,DA,1,LINE,0))
 .W !!,"Are you sure this is the right "_TYPE_"?: "
 .R ANS:DTIME
 .I '$T S Y=-1 Q
 .I ANS["?" W !!,"Enter Y for YES if the data is correct.",!,"Enter N for NO if the data is not correct." D
 ..W !!,"Are you sure this is the right "_TYPE_"?: "
 ..R ANS:DTIME
 .I (ANS["^")!(ANS["?")!(ANS="")!("Yy"'[$E(ANS,1)) S Y=-1
 Q
 ;
DQGOOD(PI,QLFR) ;screen for data modifiers
 ;
 N NODE
 Q:'$G(PI) 0
 Q:'$G(QLFR) 0
 S NODE=$G(^IBE(357.6,PI,0))
 ;
 ;for selection interfaces, the list of data qualifiers is kept with the input interface
 I $P(NODE,"^",6)=3 S PI=$P(NODE,"^",13)
 Q:'PI 0
 Q $D(^IBE(357.6,PI,13,"B",QLFR_";IBD(357.98,"))
 ;
DTGOOD(PI,TYPE) ;screen for datatypes
 ;
 N NODE
 Q:'$G(PI) 0
 Q:'$G(TYPE) 0
 S NODE=$G(^IBE(357.6,PI,0))
 ;
 ;for selection interfaces, the list of data qualifiers is kept with the input interface
 I $P(NODE,"^",6)=3 S PI=$P(NODE,"^",13)
 Q:'PI 0
 Q $D(^IBE(357.6,PI,13,"B",TYPE_";IBE(359.1,"))
