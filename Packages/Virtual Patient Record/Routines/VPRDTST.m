VPRDTST ;SLC/MKB -- Test VistA data XML RPC ;10/18/12 6:26pm
 ;;1.0;VIRTUAL PATIENT RECORD;**4,5**;Sep 01, 2011;Build 21
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
 .. K TEXT,START,STOP,MAX,IN,ID
 Q
 ;
RPC ; -- get search parameters, run and display
 I $$DOC(TYPE) S TEXT=$$SHOW Q:TEXT="^"
 N DONE S DONE=0
 I TYPE'="patient",TYPE'="flag",TYPE'="reminder" D  Q:DONE
 . S START=$S(TYPE'["insurance":$$START,1:"") I START="^" S DONE=1 Q
 . I START S STOP=$$STOP(START) I STOP="^" S DONE=1 Q
 . S MAX=$$TOTAL I MAX="^" S DONE=1 Q
 . I $$FILTERS(.IN)="^" S DONE=1 Q
 . I START="",MAX="",'$D(IN) S ID=$$ITEM S:ID="^" DONE=1
 ;
 Q:DONE
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
 S DIR(0)="SAO^",DIR("A")="Select DOMAIN: " D DIRL
 F I=1:1 S X=$P($T(TYPE+I),";",3) Q:X=99  S DIR(0)=DIR(0)_$P(X,":",1,2)_";",VPR(+X)=$P(X,":",3)
 S DIR("?")="Select the type of clinical data to extract from VistA for this patient"
 D ^DIR S:Y Y=VPR(Y)
 Q Y
 ;
TYPE ;;CODE:NAME:TAG
 ;;1:ALLERGIES/REACTIONS:allergy
 ;;2:APPOINTMENTS:appointment
 ;;3:CLINICAL PROCEDURES:clinicalProcedure
 ;;4:CONSULTS:consult
 ;;5:DEMOGRAPHICS:patient
 ;;6:DOCUMENTS:document
 ;;7:EXAMS:exam
 ;;8:FUNCTIONAL MEASUREMENTS:fim
 ;;9:HEALTH FACTORS:factor
 ;;10:IMMUNIZATIONS:immunization
 ;;11:INSURANCE:insurancePolicy
 ;;12:LAB RESULTS:lab
 ;;13:LABS BY ACCESSION:accession
 ;;14:LABS BY ORDER:panel
 ;;15:MEDS (by EXP DT):med
 ;;16:MEDS (by REL DT):pharmacy
 ;;17:OBSERVATIONS (CLiO):observation
 ;;18:ORDERS:order
 ;;19:PATIENT EDUCATION:educationTopic
 ;;20:PATIENT RECORD FLAGS:flag
 ;;21:PROBLEMS:problem
 ;;22:PROCEDURES (ALL):procedure
 ;;23:RADIOLOGY EXAMS:radiology
 ;;24:SKIN TESTS:skinTest
 ;;25:SURGERIES:surgery
 ;;26:VISITS:visit
 ;;27:VITALS:vital
 ;;28:WELLNESS REMINDERS:reminder
 ;;99
 ;
DIRL ; -- set up DIR("L") array
 S DIR("L",1)=" 1  ALLERGIES/REACTIONS           15  MEDS (by Expiration Date)"
 S DIR("L",2)=" 2  APPOINTMENTS                  16  MEDS (by Release Date)"
 S DIR("L",3)=" 3  CLINICAL PROCEDURES           17  OBSERVATIONS (CLiO)"
 S DIR("L",4)=" 4  CONSULTS                      18  ORDERS"
 S DIR("L",5)=" 5  DEMOGRAPHICS                  19  PATIENT EDUCATION"
 S DIR("L",6)=" 6  DOCUMENTS                     20  PATIENT RECORD FLAGS"
 S DIR("L",7)=" 7  EXAMS                         21  PROBLEMS"
 S DIR("L",8)=" 8  FUNCTIONAL MEASUREMENTS       22  PROCEDURES (ALL)"
 S DIR("L",9)=" 9  HEALTH FACTORS                23  RADIOLOGY EXAMS"
 S DIR("L",10)="10  IMMUNIZATIONS                 24  SKIN TESTS"
 S DIR("L",11)="11  INSURANCE                     25  SURGERIES"
 S DIR("L",12)="12  LAB RESULTS                   26  VISITS"
 S DIR("L",13)="13  LABS BY ACCESSION             27  VITALS"
 S DIR("L")="14  LABS BY ORDER                 28  WELLNESS REMINDERS"
 Q
 ;
DOC(X) ; -- Returns 1 or 0, if type X includes a document
 N Y S Y=0
 I X="document" S Y=1
 I X="accession" S Y=1
 I X="visit" S Y=1
 I X="surgery" S Y=1
 I X="radiology" S Y=1
 I X="procedure" S Y=1
 I X="clinicalProcedure" S Y=1
 I X="consult" S Y=1
 I X="fim" S Y=1
 Q Y
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
 ;
FILTERS(LIST) ; -- define additional filters for domain
 I "^document^insurancePolicy^lab^accession^panel^med^pharmacy^order^problem^"'[(U_TYPE_U) S Y="" G FQ
 N X,Y,DIR,DUOUT,DTOUT,NAME
F1 S DIR(0)="FAO^1:20",DIR("A")="Select FILTER: "
 S DIR("?")="Enter the name of an attribute, to filter this domain."
 D ^DIR S:$D(DTOUT) Y="^" I "^^"[Y G FQ
 S NAME=$$LOW^XLFSTR(Y),DIR("A")="        VALUE: " K X,Y
 S DIR("?")="Enter the value of the attribute, to filter this domain."
 D ^DIR S:$D(DTOUT) Y="^" I "^^"[Y G FQ
 S LIST(NAME)=Y G F1
FQ Q Y
 ;
ITEM() ; -- select an item ID to return
 N X,Y,DIR,DUOUT,DTOUT
 S DIR(0)="FAO^1:20",DIR("A")="ID: "
 S DIR("?")="Enter the id of an item to return."
 D ^DIR S:$D(DTOUT) Y="^"
 Q Y
