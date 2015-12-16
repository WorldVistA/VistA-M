MAGBRTE4 ;WOIFO/EdM,DAC - Process Routing Rule Evaluation Queue ; 10 Dec 2014 3:14 PM
 ;;3.0;IMAGING;**11,30,51,85,54,39,156**;Mar 19, 2002;Build 10;Dec 10, 2014
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
EVAL ;
 N ACTIVE ;--- Switch that controls start/stop queue processor
 N ANY ;------ Flag: processed any rule
 N CONS ;----- Switch that indicates whether or not site has "consolidated" code
 N KEYWORD ;-- Array with all keywords
 N MAGFILE1 ;- Name of file
 N XMSG ;----- Message counter
 ;
 F I="MAGEVAL","MAGEVALSTUDY" K ^XTMP(I,ZTSK)
 D LOG^MAGBRTE5("Started at "_$H)
 S XMSG=1,CONS=$$CONSOLID^MAGBAPI()
 S PLACE=$S(CONS:$O(^MAG(2006.1,"B",LOCATION,"")),1:1)
 L +^MAGDICOM(2006.563,1,"EVAL",LOCATION):0 E  D  Q
 . D LOG^MAGBRTE5("A rule evaluator is already running for "_$$GET1^DIQ(4,LOCATION,.01))
 . Q
 S ^MAGDICOM(2006.563,1,"EVAL")=1
 ;
 S I="" F  S I=$O(RULES(I)) Q:I=""  D
 . N D0,D1,D2,L,Q1
 . S X=RULES(I),D0=$P(X,"^",1),Q1=$P(X,"^",2),L=$L(X,"^")
 . I L=3 S RULE(D0,Q1)=$P(X,"^",3) Q
 . I Q1="ACTION" S RULE(D0,Q1,$P(X,"^",3))=$P(X,"^",4,L) Q
 . I Q1'="CONDITION" D LOG^MAGBRTE5("Rule "_D0_" has a qualifier """_Q1_""".") Q
 . I L=5 S RULE(D0,Q1,$P(X,"^",3),$P(X,"^",4))=$P(X,"^",5) Q
 . S RULE(D0,Q1,$P(X,"^",3),$P(X,"^",4),$P(X,"^",6),$P(X,"^",5))=$P(X,"^",7)
 . Q
 K RULES
 ;
 S ACTIVE=1 F  D  Q:'ACTIVE
 . S ANY=0
 . S ACTIVE=+$G(^MAGDICOM(2006.563,1,"EVAL")) I 'ACTIVE D  Q
 . . D LOG^MAGBRTE5("Stopped at "_$H)
 . . Q
 . D
 . . N IMAGE,QPTR,QPTR2,STATUS,X
 . . D:'CONS ADD^MAGBAPI(0,"EVAL")
 . . D:CONS ADD^MAGBAPI(0,"EVAL",PLACE)
 . . S QPTR2=$O(^MAGQUEUE(2006.031,"B","EVAL",""))
 . . S QPTR=$S(QPTR2:$P(^MAGQUEUE(2006.031,QPTR2,0),"^",2),1:"")
 . . ; Get next queue pointer value
 . . S:'CONS QPTR=$O(^MAGQUEUE(2006.03,"B","EVAL",QPTR))
 . . S:CONS QPTR=$O(^MAGQUEUE(2006.03,"C",PLACE,"EVAL",QPTR))
 . . I QPTR="" Q  ; Nothing to do
 . . ;
 . . S X=$G(^MAGQUEUE(2006.03,QPTR,0))
 . . ; After an error, sometimes the entry is purged,
 . . ; but the cross reference is still present.
 . . ; In such a case, remove the cross reference.
 . . I X="" D  Q
 . . . K:'CONS ^MAGQUEUE(2006.03,"B","EVAL",QPTR)
 . . . K:CONS ^MAGQUEUE(2006.03,"C",PLACE,"EVAL",QPTR)
 . . . Q
 . . ;
 . . S IMAGE=$P(X,"^",7),ANY=1
 . . I IMAGE,$D(^MAG(2005,IMAGE,0)) D
 . . . S STATUS=$$RULES() Q:STATUS'<0
 . . . I STATUS["NO NETWORK LOCATION" D  Q
 . . . . D LOG^MAGBRTE5("Image "_IMAGE_" has no files associated with it")
 . . . . Q
 . . . D LOG^MAGBRTE5("*** EVAL queue error: "_STATUS_" ***")
 . . . Q
 . . D DQUE^MAGQBUT2(QPTR)
 . . Q
 . H:'ANY 1
 . D:'$D(^XTMP("MAGEVAL",ZTSK)) XTINIT^MAGDRPC5,LOG^MAGBRTE5("^XTMP was cleaned up.")
 . Q
 L -^MAGDICOM(2006.563,1,"EVAL",LOCATION)
 Q
 ;
RULES() ; To be called from above
 ; IMAGE ;---- IEN for image (2005)
 ; LOCATION ;- Location from which queue entry originates
 N ACTION ;--- Action to be taken (SEND)
 N C ;-------- Loop-variable for looping through parameters and conditions
 N D ;-------- Data type
 N DS ;------- Data type enclosed in space-characters
 N F ;-------- ...
 N METMSG ;--- Message to be issued when rule is evaluated
 N O ;-------- Operator
 N OK ;------- Flag: indicates whether or not rule is met
 N RDT ;------ Current date (don't use DT, process might run over midnight)
 N STUDYUID ;- Study UID
 N V ;-------- Value for property as specified in rule
 N VAL ;------ Actual value of property
 N VRS ;------ String of Queue Entry numbers when rule(s) are met
 N X ;-------- Scratch variable
 ;
 S VRS=""
 ;
 D KEYWORD^MAGBRTK
 ;
 D FILEFIND^MAGDFB(IMAGE,"FULL",0,0,.MAGFILE1)
 Q:MAGFILE1<0 MAGFILE1
 ;
 S STUDYUID=$P($G(^MAG(2005,IMAGE,"PACS")),"^",1)
 S X=$P($G(^MAG(2005,IMAGE,0)),"^",10)
 S:X STUDYUID=$P($G(^MAG(2005,X,"PACS")),"^",1)
 ;
 S RULE=0 F  S RULE=$O(RULE(RULE)) Q:'RULE  D
 . S METMSG=$G(RULE(RULE,"ACTION"))
 . S X=" (",C=0 F  S C=$O(RULE(RULE,"ACTION",C)) Q:'C  D
 . . S METMSG=METMSG_X_$G(RULE(RULE,"ACTION",C)),X=", "
 . . Q
 . S:X'=" (" METMSG=METMSG_")"
 . S:METMSG="" METMSG="Rule #"_RULE
 . I (STUDYUID="")!(ZTSK="")!(RULE="") Q  ; P156 DAC - Prevent deleted groups from causing hard crashes
 . S OK=$G(^XTMP("MAGEVALSTUDY",ZTSK,STUDYUID,RULE))
 . I OK="" S OK=1,C=0 F  S C=$O(RULE(RULE,"CONDITION",C)) Q:'C  D  Q:'OK
 . . S F=$G(RULE(RULE,"CONDITION",C,"KW")) Q:F=""
 . . S X=$G(KEYWORD("CONDITION",F),"^DICOM^MAGBRTE3(F,""OUT"",.VAL)")
 . . K VAL D @$P(X,"^",2,9)
 . . ; If the field is not defined, the test passes...
 . . Q:$D(VAL)'=1  ; We won't deal with multiple values just yet...
 . . ;
 . . S V=$G(RULE(RULE,"CONDITION",C,"VA"))
 . . S D=$G(RULE(RULE,"CONDITION",C,"DT"))
 . . S O=$G(RULE(RULE,"CONDITION",C,"OP"))
 . . S:D="" D="S"
 . . S DS=" "_D_" "
 . . D:" S CS DS IS LO LT OB OW PN SH ST "[DS
 . . . N WILD ;-- Wildcard to be matched
 . . . S WILD=$$WLDMATCH^MAGBRTE5(VAL,V)
 . . . I O="=",'WILD S OK=0 Q
 . . . I O="!=",WILD S OK=0 Q
 . . . Q
 . . D:" DT DA TM "[DS
 . . . Q:O'="="  ; Only "within range" comparisons allowed currently
 . . . ;
 . . . N A ;--- Flag: indicates whether at least one time-frame matches
 . . . N B ;--- Begin date/time
 . . . N E ;--- End date/time
 . . . N I ;--- Loopcounter
 . . . N M ;--- Date/time mask
 . . . N N ;--- Loopcounter (time-frames)
 . . . N %T ;-- FileMan internal variable
 . . . N VV ;-- Actual value
 . . . N WD ;-- Weekday
 . . . N X1 ;-- FileMan API parameter value -- date
 . . . N X2 ;-- FileMan API parameter value -- date
 . . . ;
 . . . ; convert the literal date/time field into the format for comparison
 . . . S VV=VAL
 . . . ;
 . . . S (A,N)=0 F  S N=$O(RULE(RULE,"CONDITION",C,"VA",N)) Q:'N  D
 . . . . N T,VB,VC,VE
 . . . . S M=$G(RULE(RULE,"CONDITION",C,"VA",N,"M"))
 . . . . S B=$G(RULE(RULE,"CONDITION",C,"VA",N,"B"))
 . . . . S E=$G(RULE(RULE,"CONDITION",C,"VA",N,"E"))
 . . . . S T=1
 . . . . I $E(M,1,3)="HOL" S:$$GET1^DIQ(40.5,+$E(VV,5,11),.01)="" T=0 ; IA 10038
 . . . . I $E(M,1,3)="DDD",$E(B,1,3)'=$E(VAL,1,3) S T=0
 . . . . S (VB,VC,VE)=""
 . . . . F I=4:1:$L(M) S:$E(M,I)?1U VC=VC_$E(VV,I),VB=VB_$E(B,I),VE=VE_$E(E,I)
 . . . . S:VB>VC T=0
 . . . . S:VE<VC T=0
 . . . . S:T A=1
 . . . . Q
 . . . S:'A OK=0
 . . . Q
 . . Q
 . S ^XTMP("MAGEVALSTUDY",ZTSK,STUDYUID,RULE)=OK
 . S METMSG(OK,METMSG)=""
 . S RDT=$$NOW^XLFDT()\1
 . Q:'OK
 . S ACTION=$G(RULE(RULE,"ACTION"))
 . Q:ACTION=""
 . I ACTION="SEND" D  Q
 . . N D,PRI,X
 . . S X=$G(RULE(RULE,"ACTION",1))
 . . I X="" S METMSG(0,"No location for rule "_RULE)="" Q
 . . D VALDEST^MAGDRPC1(.D,X)
 . . I D<0 S METMSG(0,"Cannot find location """_X_""".")="" Q
 . . S PRI=$$PRI($G(RULE(RULE,"PRIORITY")),IMAGE)
 . . S VRS=$$VRS^MAGBRTE5(VRS,$$SEND^MAGBRTE5(IMAGE,D,PRI,1,LOCATION))
 . . Q
 . I ACTION="DICOM" D  Q
 . . N D,PRI,X
 . . S X=$G(RULE(RULE,"ACTION",1))
 . . I X="" S METMSG(0,"No location for rule "_RULE)="" Q
 . . S D=$O(^MAG(2006.587,"B",X,""))
 . . I D="" S METMSG(0,"Cannot find location """_X_""".")="" Q
 . . S PRI=$$PRI($G(RULE(RULE,"PRIORITY")),IMAGE)
 . . S VRS=$$VRS^MAGBRTE5(VRS,$$SEND^MAGBRTE5(IMAGE,D,PRI,2,LOCATION))
 . . Q
 . I ACTION="BALANCE" D BALANCE^MAGBRTE5(IMAGE,.RULE) Q
 . ;
 . ; Other actions to be inserted here...
 . ;
 . Q
 ;
 ; Note: we may have:
 ;    Rule 1: If CR, send to XXX
 ;    Rule 2: If CT, send to XXX
 ; For a CR, this would cause an entry of
 ;    METMSG(0,"SEND(XXX)") for rule 2
 ; and an entry of
 ;    METMSG(1,"SEND(XXX)") for rule 1
 ; and for a CT it would be the other way around.
 ; So, first remove all "failed" entries that were successful
 ; for a different rule.
 ;
 S X="" F  S X=$O(METMSG(1,X)) Q:X=""  D
 . D LOG^MAGBRTE5("Image "_IMAGE_": "_X)
 . K METMSG(0,X)
 . Q
 S X="" F  S X=$O(METMSG(0,X)) Q:X=""  D
 . D LOG^MAGBRTE5("Image "_IMAGE_": Do not "_X)
 . Q
 Q VRS
 ;
 ;
PRI(PRI,IMAGE) N C,D0,D1,D2,O,P,R,X
 S PRI=$S(PRI="HIGH":750,PRI="NORMAL":500,PRI="LOW":250,1:500)
 S X=$G(^MAG(2005,IMAGE,2))
 S P=$P(X,"^",6) Q:P'=74 PRI
 S R=$P(X,"^",7) Q:'R PRI
 S C=$P($G(^RARPT(R,0)),"^",1) Q:C="" PRI  ; IA 1171
 S D0=$O(^RADPT("ADC",C,"")) Q:'D0 PRI  ; IA 1172
 S D1=$O(^RADPT("ADC",C,D0,"")) Q:'D1 PRI  ; IA 1172
 S D2=$O(^RADPT("ADC",C,D0,D1,"")) Q:'D2 PRI  ; IA 1172
 S O=$P($G(^RADPT(D0,"DT",D1,"P",D2,0)),"^",11) Q:'O PRI  ; IA 1172
 S X=$P($G(^RAO(75.1,O,0)),"^",6) ; IA 3074
 Q PRI+$S(X=1:20,X=2:10,1:0)
 ;
