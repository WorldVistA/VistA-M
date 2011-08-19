GMRAOR1 ;HIRMFO/RM,WAA-OERR UTILITIES ;8/2/04  15:13
 ;;4.0;Adverse Reaction Tracking;**21,41**;Mar 29, 1996;Build 8
EN1(DFN,ARRAY) ; This entry returns a list of patient allergies/adverse
 ; reactions.
 ; Input variables:
 ;     DFN = IEN of patient in Patient (2) file
 ;     ARRAY = Return array for Patient reactions.
 ;             If ARRAY="" or undefined default will be GMRARXN.
 Q:$G(DFN)'>0
 S ARRAY=$S($G(ARRAY)'="":ARRAY,1:ARRAY="GMRARXN") Q:ARRAY="GMRAL"
 K GMRARXN,GMRAL,@ARRAY
 D EN1^GMRADPT ; Get Patient Allergies
 I GMRAL D  ; If the patient has reaction then reprocess to OERR Fmt
 .N GMRAIEN,GMRADFN,%,GMRASVR
 .S GMRARXN=1,GMRAIEN=0
 .F  S GMRAIEN=$O(GMRAL(GMRAIEN)) Q:GMRAIEN<1  D
 ..S GMRARXN(GMRARXN)=$P(GMRAL(GMRAIEN),U,2)_U ; Get freetext of agent.
 ..; Loop through 120.85 file to find all observed reacting reports for
 ..; this reaction.  Grab severity and store only the highest value.
 ..S GMRADFN=0,%="",GMRASVR="" F  S GMRADFN=$O(^GMR(120.85,"C",GMRAIEN,GMRADFN)) Q:GMRADFN<1  S %=$P($G(^GMR(120.85,GMRADFN,0)),U,14) S:%>+GMRASVR GMRASVR=%
 ..S GMRARXN(GMRARXN)=GMRARXN(GMRARXN)_$S(GMRASVR=1:"MILD",GMRASVR=2:"MODERATE",GMRASVR=3:"SEVERE",1:"")_U_GMRAIEN
 ..;Loop through the S/S multiple and get the external format and possibly the date/time.
 ..S %=0 F  S %=$O(GMRAL(GMRAIEN,"S",%)) Q:%<1  S GMRARXN(GMRARXN,"S",%)=$P(GMRAL(GMRAIEN,"S",%),";")_$S($G(GMRAIDT):";"_$P(^GMR(120.8,GMRAIEN,10,$O(^GMR(120.8,GMRAIEN,10,"B",$P(GMRAL(GMRAIEN,"S",%),";",2),0)),0),U,4),1:"") ;21
 ..S GMRARXN=GMRARXN+1
 ..Q
 .S GMRARXN=1
 .Q
 E  S GMRARXN=GMRAL
 I ARRAY'="GMRARXN" M @ARRAY=GMRARXN K GMRARXN
 K GMRAL
 Q
SETNODE(ITEM,DATA) ;
 N VALUE
 S VALUE=""
 I ITEM[DATA S VALUE=ITEM Q VALUE
 I DATA="LOCAL" D  Q VALUE
 .I ITEM="" S VALUE="LOCAL" Q
 .I ITEM["REMOTE SITE(S)" S VALUE="LOCAL AND REMOTE SITE(S)"
 I DATA="REMOTE SITE(S)" D  Q VALUE
 .I ITEM="" S VALUE="REMOTE SITE(S)" Q
 .I ITEM["LOCAL" S VALUE="LOCAL AND REMOTE SITE(S)"
 Q VALUE
 ;
