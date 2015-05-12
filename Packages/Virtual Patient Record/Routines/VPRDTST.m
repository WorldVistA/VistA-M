VPRDTST ;SLC/MKB -- Test VistA data XML RPC ;10/18/12 6:26pm
 ;;1.0;VIRTUAL PATIENT RECORD;**4**;Sep 01, 2011;Build 6
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; DIC                           2051
 ; DIR                          10026
 ;
EN ; -- test GET^VPRD, write results to screen
 N DFN,TYPE,TEXT,START,STOP,MAX,ID,IN,OUT,IDX
 F  S DFN=$$PATIENT Q:DFN<1  D 
 . F  S TYPE=$$DOMAIN Q:"^"[TYPE  D
 .. D RPC W !!
 .. K TEXT,START,STOP,MAX
 Q
 ;
RPC ; -- get search parameters, run and display
 I TYPE="document" S TEXT=$$SHOW Q:TEXT="^"
 S START=$$START Q:START="^"
 I START S STOP=$$STOP(START) Q:STOP="^"
 S MAX=$$TOTAL Q:MAX="^"
 ; ID=$$ITEM
 ;
 S:$L($G(TEXT)) IN("text")=TEXT
 D GET^VPRD(.OUT,+$G(DFN),$G(TYPE),$G(START),$G(STOP),$G(MAX),$G(ID),.IN)
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
 F I=1:1 S X=$P($T(TYPE+I),";",3) Q:X=99  S DIR(0)=DIR(0)_$P(X,":",1,2)_";",VPR(+X)=$P(X,":",3)
 D ^DIR S:Y Y=VPR(Y)
 Q Y
 ;
TYPE ;;CODE:NAME:TAG
 ;;1:ALLERGIES/REACTIONS:allergy
 ;;2:APPOINTMENTS:appointment
 ;;3:CLINICAL PROCEDURES:clinicalProcedure
 ;;4:CONSULTS:consult
 ;;5:DEMOGRAPHICS:demographics
 ;;6:DOCUMENTS:document
 ;;7:EXAMS:exam
 ;;8:HEALTH FACTORS:factor
 ;;9:IMMUNIZATIONS:immunization
 ;;10:INSURANCE:insurance
 ;;11:LAB RESULTS:lab
 ;;12:LABS BY ACCESSION:accession
 ;;13:LABS BY ORDER:panel
 ;;14:MEDS:med
 ;;15:OBSERVATIONS (CLiO):observation
 ;;16:ORDERS:order
 ;;17:PATIENT EDUCATION:education
 ;;18:PATIENT RECORD FLAGS:flag
 ;;19:PROBLEMS:problem
 ;;20:PROCEDURES (ALL):procedure
 ;;21:RADIOLOGY EXAMS:xray
 ;;22:SKIN TESTS:skin
 ;;23:SURGERIES:surgery
 ;;24:VISITS:visit
 ;;25:VITALS:vital
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
