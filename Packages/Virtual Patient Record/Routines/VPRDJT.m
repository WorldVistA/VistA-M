VPRDJT ;SLC/MKB -- Test VistA data JSON RPC ;10/18/12 6:26pm
 ;;1.0;VIRTUAL PATIENT RECORD;**2**;Sep 01, 2011;Build 317
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; DIC                           2051
 ; DIR                          10026
 ;
EN ; -- test GET^VPRDJ, write results to screen
 N DFN,TYPE,TEXT,START,STOP,MAX,ID,IN,OUT,IDX
 F  S DFN=$$PATIENT Q:DFN<1  D 
 . F  S TYPE=$$DOMAIN Q:"^"[TYPE  D
 .. D RPC W !!
 .. K IN,TEXT,START,STOP,MAX
 Q
 ;
RPC ; -- get search parameters, run and display
 I TYPE="DOCUMENT" S TEXT=$$SHOW Q:TEXT="^"
 S START=$$START Q:START="^"
 I START S STOP=$$STOP(START) Q:STOP="^"
 S MAX=$$TOTAL Q:MAX="^"
 ; ID=$$ITEM
 ;
 S IN("patientId")=+$G(DFN)
 S IN("domain")=$G(TYPE)
 S:$L($G(TEXT)) IN("text")=TEXT
 S:$G(START) IN("start")=START
 S:$G(STOP) IN("stop")=STOP
 S:$G(MAX) IN("max")=MAX
 S:$D(ID) IN("id")=ID
 D GET^VPRDJ(.OUT,.IN)
 ;
 S IDX=OUT W !
 F  S IDX=$Q(@IDX) Q:IDX'?1"^TMP(""VPR"","1.N.E  Q:+$P(IDX,",",2)'=$J  W !,@IDX
 Q
 ;
PATIENT() ; -- select patient
 N X,Y,DIC
 S DIC=2,DIC(0)="AEQM" D ^DIC
 Q Y
 ;
DOMAIN() ; -- select domain
 N X,Y,I,DIR,VPR
 S DIR(0)="SAO^",DIR("A")="Select DOMAIN: "
 F I=1:1 S X=$P($T(TYPE+I),";",3) Q:X=99  S DIR(0)=DIR(0)_X_";",VPR(+X)=$P(X,":",2)
 D ^DIR S:Y Y=VPR(Y)
 I Y="RADIOLOGY" S Y="IMAGE"
 Q Y
 ;
TYPE ;;CODE:NAME
 ;;1:ALLERGY
 ;;2:APPOINTMENT
 ;;3:CONSULT
 ;;4:CPT
 ;;5:DOCUMENT
 ;;6:EDUCATION
 ;;7:EXAM
 ;;8:FACTOR
 ;;9:IMMUNIZATION
 ;;10:LAB
 ;;11:MED
 ;;12:OBSERVATION
 ;;13:ORDER
 ;;14:PATIENT
 ;;15:POV
 ;;16:PROBLEM
 ;;17:PROCEDURE
 ;;18:RADIOLOGY
 ;;19:SKIN
 ;;20:SURGERY
 ;;21:VISIT
 ;;22:VITAL
 ;;99
 ;
SHOW() ; -- true/false to include body of note
 N X,Y,DIR,DUOUT,DTOUT
 S DIR(0)="YAO",DIR("A")="Include the text of each document? "
 D ^DIR S:$D(DTOUT) Y="^"
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
 S DIR(0)="NAO^1:9999",DIR("A")="Select TOTAL #items: "
 S DIR("?")="Enter an optional maximum number of items to return, up to 9999"
 D ^DIR S:$D(DTOUT) Y="^"
 Q Y
