VPRHST ;SLC/MKB -- Test HS utilities ;09/18/18 4:36pm
 ;;1.0;VIRTUAL PATIENT RECORD;**8**;Sep 01, 2011;Build 87
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; DIC                           2051
 ; DIR                          10026
 ;
EN ; -- test VPRHS, write results to screen
 N DFN,TYPE,VPRZTEST S VPRZTEST=1
 F  S DFN=$$PATIENT Q:DFN<1  D 
 . F  S TYPE=$$CONTNR Q:"^"[TYPE  D RUN W !!
 Q
 ;
RUN ; -- get search parameters, run and display
 N START,STOP,MAX,ID,FMT,IN,OUT,TOTAL,I,X,RTN,DONE
 S START=$$START Q:START="^"
 I START S STOP=$$STOP(START) Q:STOP="^"
 S MAX=$$TOTAL Q:MAX="^"
 ; ID=$$ITEM Q:ID="^"
 S FMT=$$FORMAT Q:FMT="^"
 ;
 S:$G(START) IN("start")=START
 S:$G(STOP) IN("stop")=STOP
 S:$G(MAX) IN("max")=MAX
 S:$D(ID) IN("id")=ID
 D GET^VPRHS(DFN,TYPE,,.IN,FMT,.OUT)
 ;
 S TOTAL=$O(@OUT@("A"),-1),RTN=$S(FMT:"XML",1:"JSON")_"^VPRHST1(X)"
 W !!,"#Results: "_TOTAL Q:TOTAL<1
 S I=0 F  S I=$O(@OUT@(I)) Q:I<1  D READ Q:$G(DONE)  W !,"Result #"_I,! S X=@OUT@(I) D @RTN Q:$G(DONE)
 K @OUT
 Q
 ;
READ ; -- continue?
 N X
 W !!,"Press <return> to continue ..." R X:DTIME
 S:X["^" DONE=1
 Q
 ;
PATIENT() ; -- select patient
 N X,Y,DIC
 S DIC=2,DIC(0)="AEQM" D ^DIC
 Q Y
 ;
CONTNR() ; -- select SDA container
 N X,Y,I,DIR,VPR
 S DIR(0)="SAO^",DIR("A")="Select CONTAINER: "
 F I=1:1 S X=$P($T(TYPE+I),";",3) Q:X=99  S DIR(0)=DIR(0)_X_";",VPR(+X)=$P(X,":",2)
 D ^DIR S:Y Y=VPR(Y)
 Q Y
 ;
TYPE ;;CODE:NAME
 ;;1:Patient
 ;;2:Encounter
 ;;3:AdvanceDirective
 ;;4:Alert
 ;;5:Allergy
 ;;6:Appointment
 ;;7:Problem
 ;;8:Diagnosis
 ;;9:Document
 ;;10:LabOrder
 ;;11:RadOrder
 ;;12:OtherOrder
 ;;13:Medication
 ;;14:Vaccination
 ;;15:Observation
 ;;16:PhysicalExam
 ;;17:Procedure
 ;;18:FamilyHistory
 ;;19:SocialHistory
 ;;20:Referral
 ;;21:MemberEnrollment
 ;;22:HealthConcern
 ;;99
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
