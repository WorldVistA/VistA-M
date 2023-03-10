VPRHST ;SLC/MKB -- Test HS utilities ;09/18/18 4:36pm
 ;;1.0;VIRTUAL PATIENT RECORD;**8,25,27**;Sep 01, 2011;Build 10
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; %ZIS                         10086
 ; DIC                           2051
 ; DID                           2052
 ; DIR                          10026
 ;
EN ; -- test VPRHS, write results to screen
 N DFN,TYPE,VPRZTEST S VPRZTEST=1
 F  S DFN=$$PATIENT Q:DFN<1  D
 . F  S TYPE=$$SOURCE Q:"^"[TYPE  D RUN W !! ;$$CONTNR
 Q
 ;
RUN ; -- get search parameters, run and display
 N START,STOP,MAX,ID,FMT,IN,OUT,TOTAL,I,X,RTN,DONE,QUIT
 S START=$$START Q:START="^"
 I START S STOP=$$STOP(START) Q:STOP="^"
 S MAX=$$TOTAL Q:MAX="^"
 ; ID=$$ITEM Q:ID="^"
 S FMT=1 ;$$FORMAT Q:FMT="^"
 ;
 S:$G(START) IN("start")=START
 S:$G(STOP) IN("stop")=STOP
 S:$G(MAX) IN("max")=MAX
 D GET^VPRHS(DFN,TYPE,,.IN,1,.OUT)
 D ^%ZIS
 ;
 S TOTAL=$O(@OUT@("A"),-1),RTN=$S(FMT:"XML",1:"JSON")_"^VPRHST1(X)"
 W !!,"#Results: "_TOTAL Q:TOTAL<1
 S I=0 F  S I=$O(@OUT@(I)) Q:I<1  D  Q:$G(QUIT)
 . I '$G(DONE) D READ Q:$G(QUIT)
 . W !,"Result #"_I,! S X=@OUT@(I) D @RTN
 K @OUT
 D HOME^%ZIS
 Q
 ;
READ ; -- continue?
 N X K DONE,QUIT
 W !!,"Press <return> to continue or ^ to exit results ..." R X:DTIME
 S:X["^" QUIT=1
 Q
 ;
PATIENT() ; -- select patient
 N X,Y,DIC
 S DIC=2,DIC(0)="AEQM" D ^DIC
 Q Y
 ;
SOURCE() ; -- select SDA source
 N X,Y,DIC,DA,FN
 S DIC=560.1,DIC(0)="AEQMZ",DIC("A")="Select CONTAINER: "
 S DIC("S")="I $O(^(1,0))" D ^DIC I Y<1 Q "^"
 S DA=+Y,Y=$P(Y(0),U,2)
 I $P($G(^VPRC(560.1,DA,1,0)),U,4)>1 D
 . S FN=$$FILE(DA) S:FN>1 Y=Y_";"_FN
 . I FN="^" S Y="^"
 Q Y
 ;
FILE(CONT) ; -- select optional source file for CONTainer
 N I,X,Y,Z,DIR,GBL S CONT=$G(CONT)
 S CONT=$S(CONT:+CONT,$L(CONT):+$O(^VPRC(560.1,"C",CONT,0)),1:0)
 S DIR("A")="Select SOURCE FILE: ",DIR(0)="SAO^",Y=""
 F I=1:1 S X=$G(^VPRC(560.1,CONT,1,I,0)) Q:X=""  D
 . S Z=$$GET1^DID(+X,,,"NAME")
 . I Z="" S GBL="^DD(+X,0,""NM"")",Z=$O(@GBL@("")) ;subfile
 . S DIR(0)=DIR(0)_+X_":"_Z_";"
 S DIR("?")="Select a VistA source file for this container, or press return for all."
 K X D:CONT ^DIR
 Q Y
 ;
CONTNR() ; -- select SDA container
 N X,Y,DIC
 S DIC="^VPRC(560.1,",DIC(0)="AEQMZ",DIC("A")="Select CONTAINER: "
 S DIC("S")="I $O(^(1,0))" D ^DIC I Y<1 Q "^"
 S Y=$P($G(Y(0)),U,2)
 Q Y
 ;
START() ; -- select a start date
 N X,Y,DIR,DUOUT,DTOUT
 S DIR(0)="DAO^::AEPT",DIR("A")="Select START DATE: "
 S DIR("?")="Enter an optional date[.time] to begin searching for data"
 D ^DIR S:$D(DTOUT) Y="^"
 Q Y
 ;
STOP(START) ; -- select a stop date
 N X,Y,DIR,DUOUT,DTOUT
 S DIR(0)="DA^"_START_"::AEPT",DIR("A")="Select STOP DATE: "
 S DIR("?")="Enter a date[.time] after the START to end searching for data"
 D ^DIR S:$D(DTOUT) Y="^"
 Q Y
 ;
TOTAL() ; -- select the max# to return
 N X,Y,DIR,DUOUT,DTOUT
 S DIR(0)="NAO^1:99999",DIR("A")="Select TOTAL #items: "
 S DIR("?")="Enter an optional maximum number of items to return per VistA source for this container, up to 99999"
 D ^DIR S:$D(DTOUT) Y="^"
 Q Y
 ;
ITEM() ; -- select an item ID to return
 N X,Y,DIR,DUOUT,DTOUT
 S DIR(0)="FAO^1:20",DIR("A")="ID: "
 S DIR("?")="Enter the id of a record to return, if known; press return to view all records in this container."
 D ^DIR S:$D(DTOUT) Y="^"
 Q Y
 ;
FORMAT() ; -- select output format
 N X,Y,DIR,DUOUT,DTOUT
 S DIR(0)="SAO^0:JSON;1:XML;",DIR("A")="Select FORMAT: ",DIR("B")="XML"
 S DIR("?")="Choose your desired output format, XML or JSON"
 D ^DIR S:$D(DUOUT) Y="^"
 Q Y
