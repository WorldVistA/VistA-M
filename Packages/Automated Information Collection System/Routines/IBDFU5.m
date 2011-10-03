IBDFU5 ;ALB/CJM - ENCOUNTER FORM (utilities) ;JAN 16,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
TOPNBOT(BLOCK,TOP,BOT) ;finds the top and bottom of the block - pass TOP and BOT by reference
 N NODE
 S NODE=$G(^IBE(357.1,BLOCK,0))
 S TOP=+$P(NODE,"^",4),BOT=(TOP+(+$P(NODE,"^",7)))-1
 Q
RUSURE(NAME) ;obtains verification from the user for deletion- returns 1 if answered YES, otherwise NO
 ;if NAME is defined it will be used in the prompt
 N RET
 S RET=1
 K DIR S DIR(0)="Y",DIR("A")=$S(NAME="":"Are you sure",1:"Are you sure "_NAME_" should be deleted"),DIR("B")="NO"
 D ^DIR K DIR I (Y<1)!$D(DIRUT) S RET=0
 Q RET
PAUSE ;
 N ANS
 W !,$C(7),"Press RETURN to continue..." R ANS:DTIME
 Q
 ;
NOGRPHCS ;sets graphics variables to "_" and "|"
 S (IOVL,IOBLC,IOBRC)="|",(IOHL,IOTRC,IOTLC)="_"
 Q
 ;
HELP1 ;displays a list of the record's fields from file 357.6, IB PACKAGE INTERFACE file - EXECUTABLE HELP FOR FIELDS IN THE DATA FIELD FILE
 ;
 ;INPUT - D0 is a pointer to a DATA FIELD (file 357.5)
 ;
 N RTN
 Q:'$G(D0)
 W !,"WHAT DATA SHOULD BE PRINTED IN THE SUBFIELD? CHOOSE FROM:"
 S RTN=$P($G(^IBE(357.5,D0,0)),"^",3) Q:'RTN
 D SHOWDATA
 Q
HELP2 ;displays a list of the record's fields from file 357.6, IB PACKAGE INTERFACE file - EXECUTABLE HELP FOR FIELDS IN THE SELECTION LIST FILE
 ;
 ;INPUT - D0 should be a pointer to a SELECTION LIST
 ;
 N RTN
 W !,"WHAT DATA SHOULD BE PRINTED IN THIS SUBCOLUMN? CHOOSE FROM:"
 Q:'$G(D0)
 S RTN=$P($G(^IBE(357.2,D0,0)),"^",11) Q:'RTN
 D SHOWDATA
 W !,"You can also enter 0 if you want the item number entered in the subcolumn.",!
 Q
 ;
HELP3 ;displays a list of the record's fields from file 357.6, IB PACKAGE INTERFACE file - used to display available data to the user before he enters a data field label
 ;
 ;INPUT - D0 is a pointer to a DATA FIELD (file 357.5)
 N RTN
 W !,"Available Data:"
 Q:'$G(D0)
 S RTN=$P($G(^IBE(357.5,D0,0)),"^",3) Q:'RTN
 D SHOWDATA
 Q
 ;
HELP4 ;displays a list of the record's fields from file 357.6, IB PACKAGE INTERFACE file - used to display to the user the available data before a subcolumn to a selection list
 ;
 ;INPUT - D0 should be a pointer to a SELECTION LIST
 ;
 N RTN
 W !,"Available Data:"
 Q:'$G(D0)
 S RTN=$P($G(^IBE(357.2,D0,0)),"^",11) Q:'RTN
 D SHOWDATA
 Q
HELP5 ;for number of columns in list
 I $G(IBDEVICE("LISTMAN")) D FULL^VALM1
 W !!,"A selection list COLUMN contains items on the list. It may consist of several",!,"subcolumns. For example, a typical column may have three subcolumns, one"
 W !,"containing a code, the second a description, and the third a marking area for",!,"the user to indicate his selections from the list. Besides going down the",!,"form, the list can can go across the form by having multiple columns."
 W !!,"Entering the number of columns is optional. By default the entire block will",!,"be filled with the list.",!
 I $G(IBDEVICE("LISTMAN")) D PAUSE^IBDFU5,RE^VALM4
 Q
 ;
SHOWDATA ;displays a discription of the the record returned by the package interface
 ;
 ;INPUT - RTN - ptr to the package interface file
 N NODE,SUB,ROW,COL,LINE,DESCR,CANSHOW,IEN
 S NODE=$G(^IBE(357.6,RTN,2))
 ;
 ;piece 1 may not be displayable (an ien)
 S CANSHOW=$S($P(NODE,"^",17)=0:0,1:1)
 I 'CANSHOW S NODE=""
 ;
 F ROW=0:1:3 S LINE="" D  W:(LINE'="") !,LINE
 .F COL=1:1:2 S SUB=COL+(2*ROW) D  Q:LINE=""
 ..S DESCR=""
 ..I (SUB'=1) S NODE="",IEN=$O(^IBE(357.6,RTN,15,"C",SUB,0)) S:IEN NODE=$G(^IBE(357.6,RTN,15,IEN,0))
 ..I NODE="" I (COL=1&'$D(^IBE(357.6,RTN,15,"C",SUB+1)))!((COL'=1)&(DESCR="(not applicable)")) Q
 ..S DESCR=$P(NODE,"^") I DESCR'="" S DESCR=DESCR_" :"_$P(NODE,"^",2)_" char"
 ..I DESCR="" S DESCR="(N/A)"
 ..S LINE=LINE_$S(DESCR="":"",1:$$PADRIGHT^IBDFU("  "_SUB_"= "_DESCR,39))
 Q
 ;
RESET ;resets the scrolling area of the screen to that defined by List Manager
 ;I $G(IOSTBM)'="" S IOTM=IOSL-4,IOBM=IOSL W IOSC,@IOSTBM,IORC
 Q
VARIABLE(VAR) ;returns 0 if VAR is not syntactically a good local variable name, 1 otherwise
 N I,LEN,CHAR,GOOD
 S LEN=$L(VAR)
 S CHAR=$E(VAR)
 I '((CHAR?1A)!(CHAR="%")) Q 0
 S GOOD=1
 F I=2:1:LEN S CHAR=$E(VAR,I) I '((CHAR?1A)!(CHAR?1N)) S GOOD=0 Q
 Q GOOD
ID1 ;writes identifier for subcolumn of selection list (file 357.2)
 N NODE,TYPE,PIECE,IEN
 S NODE=$G(^(0)) Q:NODE=""
 W "HEADER=",$$PADRIGHT^IBDFU($P(NODE,U,2),27)_"  CONTENT="
 I $P(NODE,U,4)=1 D
 .S TYPE=$P($G(^IBE(357.2,D0,0)),"^",11) Q:'TYPE
 .S PIECE=+$P(NODE,U,5)
 .W:'PIECE "#COUNT"
 .W:PIECE $$DATANAME^IBDFU1B(TYPE,PIECE)
 I $P(NODE,U,4)=2 D
 .S TYPE=$P(NODE,U,6) Q:'TYPE
 .W $P($G(^IBE(357.91,TYPE,0)),U)
 Q
 ;
DFLTS() ;returns the default form if found, 0 otherwise
 N FORM
 S FORM=0 F  S FORM=$O(^IBE(357,"B","DEFAULTS",FORM)) Q:'FORM  Q:$P($G(^IBE(357,FORM,0)),"^",7)
 Q FORM
 ;
OKPIECE(PI,PIECE) ;returns 1 if the piece=PIECE is selectable for the package interface=PI, 0 otherwise
 ;
 I ('$G(PIECE))!('$G(PI)) Q 0
 N QUIT S QUIT=0
 I PIECE=1 S QUIT=$S($P($G(^IBE(357.6,PI,2)),"^",17)'=0:1,1:0)
 I PIECE'=1 S QUIT=$D(^IBE(357.6,PI,15,"C",PIECE))
 Q QUIT
