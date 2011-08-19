IBDFDE5 ;ALB/AAS - AICS Manual Data Entry, Loader routine for 357.6 ; 19-APR-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**40**;APR 24, 1997
 ;
% G ^IBDFDE
 ;
 ;
COMPLST ; -- procedure, compile form list arrays in ^tmp
 ;    ^tmp("ibd-lText",$j,form,package interface,list,text,cnt,n)=entry number
 ;    ^tmp("ibd-lCode",$j,form,package interface,list," "_code,cnt,n)= entry number
 ;    ^tmp("ibd-lst",$j,form,package inteface,list)=display text^display code^input value^ optional caption^ optional term^selectable?
 ;
 N IBDI,FORM,PI,IEN,CNT,CH,CODE
 I '$G(IBDF("PI"))!('$G(IBDF("IEN")))!('$G(IBDFMIEN)) G COMPQ
 S PI=IBDF("PI"),IEN=IBDF("IEN"),FORM=IBDFMIEN
 ;
 ;K ^TMP("IBD-LST",$J,FORM,PI,IEN),^TMP("IBD-LTEXT",$J,FORM,PI,IEN),^TMP("IBD-LCODE",$J,FORM,PI,IEN)
 K ^TMP("IBD-LTEXT",$J,FORM,PI,IEN),^TMP("IBD-LCODE",$J,FORM,PI,IEN)
 ;
 ;M ^TMP("IBD-LST",$J,FORM,PI,IEN)=CHOICE
 K CHOICE
 ;
 ; -- Expand choices
 S HDR=""
 S IBDI=0 F  S IBDI=$O(^TMP("IBD-LST",$J,FORM,PI,IEN,IBDI)) Q:'IBDI  S CH=$G(^(IBDI)) D
 .I $P(CH,"^",7)=0 S HDR=$P(CH,"^") Q
 .I $P(CH,"^",8)="" S $P(^TMP("IBD-LST",$J,FORM,PI,IEN,IBDI),"^",8)=HDR
 .;
 .; -- build array of text
 .I $P(CH,"^",1)'="" D
 ..I '$D(^TMP("IBD-LTEXT",$J,FORM,PI,IEN,$E($$UP^XLFSTR($P(CH,"^",1)),1,80))) S ^TMP("IBD-LTEXT",$J,FORM,PI,IEN,$E($$UP^XLFSTR($P(CH,"^",1)),1,80),1)=IBDI Q
 ..S CNT=$O(^TMP("IBD-LTEXT",$J,FORM,PI,IEN,$E($$UP^XLFSTR($P(CH,"^",1)),1,80),""),-1)
 ..S ^TMP("IBD-LTEXT",$J,FORM,PI,IEN,$E($$UP^XLFSTR($P(CH,"^",1)),1,80),CNT+1)=IBDI
 .;
 .; -- build array of codes
 .S CODE=$S($P(CH,"^",2)'="":$P(CH,"^",2),1:$P(CH,"^",3)) Q:CODE=""
 .I '$D(^TMP("IBD-LCODE",$J,FORM,PI,IEN," "_CODE,1)) S ^TMP("IBD-LCODE",$J,FORM,PI,IEN," "_CODE,1)=IBDI Q
 .S CNT=$O(^TMP("IBD-LCODE",$J,FORM,PI,IEN," "_CODE,""),-1) S ^TMP("IBD-LCODE",$J,FORM,PI,IEN," "_CODE,CNT+1)=IBDI
 ;
COMPQ Q
 ;
MDCOMP(FORM) ; -- compile form for manual data entry into ^xtmp
 ; -- ^xtmp("ibd"_form,0) := date ^ date
 ;    ^xtmp("ibd"_form, "ibd-obj", n) := object listing for form
 ;    ^xtmp("ibd"_form, "ibd-lst", pkg interface, list, n) := listing of each list
 ;    ^xtmp("ibd"_form, "ibd-lst", pkg interface, list ,"code", " "_code, n) := code index
 ;    ^xtmp("ibd"_form, "ibd-lst", pkg interface, list "text", text, n) := text index
 ;
 ; -- before converting to xtmp must resolve compile issues,
 ;    such as when form is in use for data entry etc.
 ;    need schema for locks...think about this
 ;    remember to check old logic for changes
 ;
 N I,J,X,Y,NAM,IBDOBJ
 G:$G(^IBE(357,+$G(FORM),0))="" MDCQ
 S NAM="IBD"_FORM
 L +^XTMP(NAM):10 I '$T W !!,"form is in use, data entry compile failed",! S IBQUIT=1 G MDCQ
 K ^XTMP(NAM) ; make sure ibdfde locks so doesn't kill when in use
 S ^XTMP(NAM,0)=$$FMADD^XLFDT(DT,90)_"^"_DT
 D FRMLSTI^IBDFRPC(.IBDOBJ,FORM,"",1)
 M ^XTMP(NAM,"IBD-OBJ")=IBDOBJ
 K IBDOBJ
 ;
 ; -- build entry for lists
 S X=0 F  S X=$O(^XTMP(NAM,"IBD-OBJ",X)) Q:'X  S Y=^(X) D
 .Q:$P($G(^IBE(357.6,+$P(Y,"^",2),0)),"^",14)  ;dyanamic lists get compiled by ibdfde2 and then killed
 .I $P(Y,"^",5)="LIST" D MDCLIST(FORM,$P(Y,"^",2),$P(Y,"^",6))
 ;
MDCQ L -^XTMP(NAM)
 Q
 ;
MDCLIST(FORM,PI,LIST) ; -- Compile one list
 N I,J,X,Y,IBDF,CH,CODE
 G:$G(^IBE(357.6,+$G(PI),0))=""!($G(^IBE(357.2,+$G(LIST),0))="")!($G(^IBE(357,+$G(FORM),0))="") MDCLQ
 S IBDF("PI")=PI,IBDF("IEN")=LIST,IBDF("TYPE")="LIST"
 K ^XTMP("IBD"_FORM,"IBD-LST",PI,LIST)
 D OBJLST^IBDFRPC1(.CH,.IBDF)
 M ^XTMP("IBD"_FORM,"IBD-LST",PI,LIST)=CH
 ;
 ; -- Expand choices
 S HDR=""
 S IBDI=0 F  S IBDI=$O(^XTMP("IBD"_FORM,"IBD-LST",PI,LIST,IBDI)) Q:'IBDI  S CH=^(IBDI) D
 .I $P(CH,"^",7)=0 S HDR=$P(CH,"^") Q
 .I $P(CH,"^",8)="" S $P(^XTMP("IBD"_FORM,"IBD-LST",PI,LIST,I),"^",8)=HDR
 .;
 .; -- build array of text
 .I $P(CH,"^",1)'="" D
 ..I '$D(^XTMP("IBD"_FORM,"IBD-LST",PI,LIST,"TEXT",$$UP^XLFSTR($P(CH,"^",1)))) S ^XTMP("IBD"_FORM,PI,LIST,"TEXT",$$UP^XLFSTR($P(CH,"^",1)),1)=IBDI Q
 ..S CNT=$O(^XTMP("IBD"_FORM,"IBD-LST",PI,LIST,"TEXT",$$UP^XLFSTR($P(CH,"^",1)),""),-1)
 ..S ^XTMP("IBD"_FORM,"IBD-LST",PI,LIST,"TEXT",$$UP^XLFSTR($P(CH,"^",1)),CNT+1)=IBDI
 .;
 .; -- build array of codes
 .S CODE=$S($P(CH,"^",2)'="":$P(CH,"^",2),1:$P(CH,"^",3)) Q:CODE=""
 .I '$D(^XTMP("IBD"_FORM,"IBD-LST",PI,LIST,"CODE"," "_CODE,1)) S ^XTMP("IBD"_FORM,"IBD-LST",PI,LIST,"CODE"," "_CODE,1)=IBDI Q
 .S CNT=$O(^XTMP("IBD"_FORM,"IBD-LST",PI,LIST,"CODE"," "_CODE,""),-1) S ^XTMP("IBD"_FORM,"IBD-LST",PI,LIST,"CODE"," "_CODE,CNT+1)=IBDI
 .Q
 ;
MDCLQ Q
 ;
18 ; -- Post init for data entry patch
 D 14,CLNTMP,XREF,PIDIM,PIUP
 Q
 ;
14 ;Populate the .14 FIELD IN FILE 357.96
 S ZTIO="",ZTDTH=$H,ZTRTN="DQ^IBDFDE5",ZTDESC="IBD-Patch 2 populate 357.96;.14" D ^%ZTLOAD
 D BMES^XPDUTL("Queing the Conversion to populate the .14 field (NO APPOINTMENT ENTRY) of file 357.96 ENCOUNTER FORM TRACKING......")
 Q
 ;
DQ ;
 N IBDFIFN,IBDFCLIN,IBDFAPPT,IBDFDFN
 S IBDFIFN=0
 F  S IBDFIFN=$O(^IBD(357.96,IBDFIFN)) Q:'IBDFIFN  S IBDFNODE=$G(^IBD(357.96,IBDFIFN,0)) S IBDFDFN=$P(IBDFNODE,"^",2),IBDFAPPT=$P(IBDFNODE,"^",3) I IBDFDFN,IBDFAPPT D
 .S DIE="^IBD(357.96,",DA=IBDFIFN
 .I $D(^DPT(+IBDFIFN,"S",IBDFAPPT)) S DR=".14////0"
 .E  S DR=".14////1"
 .D ^DIE K DA,DR,DIE
 ;W !!,"DONE"
 Q
CLNTMP ; -- kill tmp globals, on load, forces rebuild with updates
 K ^TMP("IBD-LST"),^TMP("IBD-OBJ")
 Q
 ;
XREF ;
 D BMES^XPDUTL("Removing 'RECD' cross-reference on PRINTED FORM ID field")
 S DA=0
 F  S DA=$O(^DD(357.96,.01,1,DA)) Q:DA<1  I $G(^(DA,0))="357.96^RECD^MUMPS" S DIK="^DD(357.96,.01,1,",DA(2)=357.96,DA(1)=.01 D ^DIK K DIK
 ;
 D BMES^XPDUTL("Removing 'RECD2' cross-reference on DATE/TIME RECEIVED IN VISTA field")
 S DA=0
 F  S DA=$O(^DD(357.96,.06,1,DA)) Q:DA<1  I $G(^(DA,0))="357.96^RECD2^MUMPS" S DIK="^DD(357.96,.06,1,",DA(2)=357.96,DA(1)=.06 D ^DIK K DIK
 ;
 D BMES^XPDUTL("Removing 'RECD3' cross-reference on DATE/TIME PRINTED field")
 S DA=0
 F  S DA=$O(^DD(357.96,.05,1,DA)) Q:DA<1  I $G(^(DA,0))="357.96^RECD3^MUMPS" S DIK="^DD(357.96,.05,1,",DA(2)=357.96,DA(1)=.05 D ^DIK K DIK
 K DA
 K ^IBD(357.96,"RECD")
 Q
 ;
PIDIM ;
 D BMES^XPDUTL("Updating PCE DIM OUTPUT TRANSFORM in file 357.6")
 N IBD,LINE,PKG,NOD14,IEN
 F IBD=1:1 S LINE=$P($T(OUTTRANS+IBD),";;",2) Q:LINE=""  D
 .S PKG=$P(LINE,"^",2)
 .S NOD14=$P(LINE,"^",3,99)
 .S IEN=+$O(^IBE(357.6,"B",$E(PKG,1,30),0))
 .Q:IEN<1
 .I $P($G(^IBE(357.6,IEN,0)),"^")=PKG S ^IBE(357.6,IEN,14)=NOD14
 Q
OUTTRANS ;;
 ;;61^INPUT PROVIDER^S Y=$$DSPLYPRV^IBDFN9(Y)
 ;;62^INPUT VISIT TYPE^S Y=$$DSPLYCPT^IBDFN9(Y)
 ;;102^PX INPUT VISIT TYPE^S Y=$$DSPLYCPT^IBDFN9(Y)
 ;;
PIUP ;
 D BMES^XPDUTL("Updating Package Interface File for Data Entry")
 N PKG,ENT,RTN,DYN,NODE18,IEN
 F IBD=1:1 S LINE=$P($T(UPDATE+IBD),";;",2) Q:LINE=""  D
 .S PKG=$P(LINE,"^",2)
 .S ENT=$P(LINE,"^",3)
 .S RTN=$P(LINE,"^",4)
 .S DYN=$P(LINE,"^",5)
 .S NOD18=$P(LINE,"^",6,99)
 .S IEN=+$O(^IBE(357.6,"B",$E(PKG,1,30),0))
 .Q:IEN<1
 .I $P($G(^IBE(357.6,IEN,0)),"^")=PKG D
 ..S ^IBE(357.6,IEN,18)=NOD18
 ..I $G(ENT)'="" S $P(^IBE(357.6,IEN,0),"^",2)=ENT
 ..I $G(RTN)'="" S $P(^IBE(357.6,IEN,0),"^",3)=RTN
 ..I $G(DYN)'="" S $P(^IBE(357.6,IEN,0),"^",14)=DYN
 Q
 ;
UPDATE ;;
 ;;59^INPUT PROCEDURE CODE (CPT4)^^^^S IBDF("OTHER")="81^I '$P(^(0),U,4)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"CPT Procedure Code")
 ;;61^INPUT PROVIDER^PRVDR^IBDFN4^1^S IBDF("OTHER")="200^$$SCREEN^IBDFDE10(+Y)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"Provider")
 ;;62^INPUT VISIT TYPE^^^^S IBDF("OTHER")="357.69^I '$P(^(0),U,4)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"Visit Type (EM) Code")
 ;;69^INPUT DIAGNOSIS CODE (ICD9)^^^^S IBDF("OTHER")="80^I '$P(^(0),U,9)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"Diagnosis Code")
 ;;74^PX INPUT PATIENT ACTIVE PROBLEM^DSELECT^GMPLENFM^1^D LIST^IBDFDE2(.IBDSEL,.IBDF,"Active Problem")
 ;;91^PX INPUT EDUCATION TOPICS^^^^S IBDF("OTHER")="9999999.09^I '$P(^(0),U,3)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"Patient Education")
 ;;92^PX INPUT EXAMS^^^^S IBDF("OTHER")="9999999.15^I '$P(^(0),U,4)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"Exam")
 ;;93^PX INPUT HEALTH FACTORS^^^^S IBDF("OTHER")="9999999.64^I '$P(^(0),U,10),$P(^(0),U,10)=""F"",'$P(^(0),U,11)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"Health Factors")
 ;;94^PX INPUT IMMUNIZATION^^^^S IBDF("OTHER")="9999999.14^I '$P(^(0),U,7)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"Immunizations")
 ;;97^PX INPUT SKIN TESTS^^^^S IBDF("OTHER")="9999999.28^I '$P(^(0),U,3)" D LIST^IBDFDE2(.IBDSEL,.IBDF,"Skin Tests")
 ;;99^PX INPUT VITALS^^^^D HNDPR^IBDFDE3(.IBDSEL,.IBDF)
 ;;103^GMP INPUT CLINIC COMMON PROBLEMS^^^^S IBDF("LEXICON")=1,IBDF("OTHER")="757.01^" D LIST^IBDFDE2(.IBDSEL,.IBDF,"Diagnosis, Problem, or Term")
 ;;
 ;; -- Example of setting up a date/time prompt
 ;;95^PX INPUT CHECKOUT TIME^^^^S IBDF("ASKDATE")=1 D HNDPR^IBDFDE3(.IBDSEL,.IBDF) K IBDF("ASKDATE")
 ;;
 ;; -- Example of setting up a multiple choice field
 ;;100^PX INPUT VISIT CLASSIFICATION^^^^D MULT^IBDFDE4(.IBDSEL,.IBDF)
 ;;
