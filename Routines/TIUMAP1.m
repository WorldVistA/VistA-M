TIUMAP1 ; ISL/JER - TIU/VHA Enterprise Document Type Ontology Mapper ;10/24/06  09:01
 ;;1.0;TEXT INTEGRATION UTILITIES;**211**;Jun 20, 1997;Build 26
PARSE(RESULT,TIUNM) ; Attempt to map each word to one of the LOINC axes - build parse tree
 N TIUI,TIUPTREE,TIUWORD,TIULOCAL,TIUY S TIULOCAL=TIUNM,TIUY=0
 S TIUPTREE=$NA(^TMP("TIUMAP",$J)) K @TIUPTREE
 ; Test whether each word maps to a Subject Matter Domain
 F TIUI=1:1:$L(TIUNM," ") S TIUWORD=$P(TIUNM," ",TIUI) Q:TIUWORD']""  D SMD(TIUPTREE,TIUWORD,.TIUNM,TIUI) Q:+$G(@TIUPTREE@("SubjectMatterDomain"))!+$G(DIRUT)
 Q:+$G(DIRUT)
 ; Test whether each REMAINING word maps to a Role
 F TIUI=1:1:$L(TIUNM," ") S TIUWORD=$P(TIUNM," ",TIUI) Q:TIUWORD']""  D ROLE(TIUPTREE,TIUWORD,.TIUNM,TIUI) Q:+$G(@TIUPTREE@("Role"))!+$G(DIRUT)
 Q:+$G(DIRUT)
 ; Test whether each REMAINING word maps to a Setting
 F TIUI=1:1:$L(TIUNM," ") S TIUWORD=$P(TIUNM," ",TIUI) Q:TIUWORD']""  D SET(TIUPTREE,TIUWORD,.TIUNM,TIUI) Q:+$G(@TIUPTREE@("Setting"))!+$G(DIRUT)
 Q:+$G(DIRUT)
 ; Test whether each REMAINING word maps to a Service
 F TIUI=1:1:$L(TIUNM," ") S TIUWORD=$P(TIUNM," ",TIUI) Q:TIUWORD']""  D SVC(TIUPTREE,TIUWORD,.TIUNM,TIUI) Q:+$G(@TIUPTREE@("Service"))!+$G(DIRUT)
 Q:+$G(DIRUT)
 ; Test whether each REMAINING word maps to a Document Type
 F TIUI=1:1:$L(TIUNM," ") S TIUWORD=$P(TIUNM," ",TIUI) Q:TIUWORD']""  D DTYP(TIUPTREE,TIUWORD,.TIUNM,TIUI) Q:+$G(@TIUPTREE@("DocumentType"))!+$G(DIRUT)
 Q:+$G(DIRUT)
 I $D(@TIUPTREE) D
 . N SMD,ROLE,SET,SVC,DTYP,SCRN,DIC,X S SCRN="I ",X=""
 . S SMD=$G(@TIUPTREE@("SubjectMatterDomain"))
 . S ROLE=$G(@TIUPTREE@("Role"))
 . S SET=$G(@TIUPTREE@("Setting"))
 . S SVC=$G(@TIUPTREE@("Service"))
 . S DTYP=$G(@TIUPTREE@("DocumentType"))
 . I DTYP="" S DTYP=+$O(^TIU(8926.6,"B","NOTE",0))_U_"NOTE"
 . I  W !,"No Document Type found...Setting Document Type to 'NOTE.'",!
 . Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !,"Now, we'll query the VHA Enterprise Standard Titles for an entry with:",!
 . Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !?12,"LOCAL Title: ",TIULOCAL
 . I +SMD D
 . . S SCRN=SCRN_"$P(^(0),U,4)="_+SMD
 . . S:X="" X=$P(SMD,U,2)
 . . Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !?2,"Subject Matter Domain: ",$P(SMD,U,2)
 . I +ROLE D
 . . S SCRN=SCRN_$S(SCRN="I ":"",1:",")_"$P(^(0),U,5)="_+ROLE
 . . S:X="" X=$P(ROLE,U,2)
 . . Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !?19,"Role: ",$P(ROLE,U,2)
 . I +SET D
 . . S SCRN=SCRN_$S(SCRN="I ":"",1:",")_"$P(^(0),U,6)="_+SET
 . . S:X="" X=$P(SET,U,2)
 . . Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !?16,"Setting: ",$P(SET,U,2)
 . I +SVC D
 . . S SCRN=SCRN_$S(SCRN="I ":"",1:",")_"$P(^(0),U,7)="_+SVC
 . . S:X="" X=$P(SVC,U,2)
 . . Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !?16,"Service: ",$P(SVC,U,2)
 . I +DTYP D
 . . S SCRN=SCRN_$S(SCRN="I ":"",1:",")_"$P(^(0),U,8)="_+DTYP
 . . S:X="" X=$P(DTYP,U,2)
 . . Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !?10,"Document Type: ",$P(DTYP,U,2)
 . Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !!,"First, we'll try an EXCLUSIVE match (i.e., ALL conditions met):"
 . S DIC("S")=SCRN_",'$$SCREEN^XTID(8926.1,"""",+Y_"","")",DIC=8926.1
 . S TIUY=$$ASK(X,.DIC) Q:+$G(DIRUT)
 . I +TIUY'>0,($L(SCRN,"$P")>2) D  Q:+$G(DIRUT)
 . . Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !!,"Since that failed, we'll try an INCLUSIVE match (i.e., ANY conditions met):"
 . . S SCRN=$$ANDTOOR(SCRN)
 . . S DIC("S")=SCRN_",'$$SCREEN^XTID(8926.1,"""",+Y_"","")",DIC=8926.1
 . . S TIUY=$$ASK(X,.DIC)
 I +TIUY'>0 D  Q:+$G(DIRUT)
 . N TIUCONT S TIUCONT=1
 . Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !!,$$EXPLAT," Let's try a manual look-up..."
 . Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !,"Again, your LOCAL Title is: ",TIULOCAL,!!,"  NOTE: Only ACTIVE Titles may be selected...",!
 . F  D  Q:+TIUCONT'>0
 . . N DIC S DIC=8926.1,DIC(0)="AEMQ",DIC("A")="Select VHA ENTERPRISE STANDARD TITLE: "
 . . S DIC("S")="I '$$SCREEN^XTID(8926.1,"""",+Y_"","")"
 . . S TIUY=$$ASK("",.DIC) I +TIUY>0 S TIUCONT=0 Q
 . . I '$$PAGE^TIUMAP2(TIULOCAL) S TIUCONT=0 Q 
 . . W !!,"You didn't select a VHA Enterprise Standard Title...",!
 . . S TIUCONT=$$READ^TIUU("Y","... Try to map "_TIULOCAL_" again","NO") W !
 . . S:+$G(DIRUT) TIUOUT=1
 Q:+TIUY'>0!+$G(DIRUT)
 S RESULT=+TIUY,RESULT(1)=TIUY_U_TIULOCAL
 Q
LOG(TIULOCAL,DA) ; Log a mapping failure
 N DIE,DR
 W !!,"Recording the unmapped LOCAL Title: ",TIULOCAL,!
 S ^XTMP("TIUMAP","FAIL",TIULOCAL,DA)=""
 S DIE=8925.1,DR="1502////^S X="_$$NOW^XLFDT_";1503////^S X="_DUZ D ^DIE
 ; Drop LOCK
 L -^TIU(8925.1,DA,15):1
 Q
EXPLAT() ; Random selector of explatives
 N EXP S EXP="AUGH!;OUCH!;YUCK!;BLECH!;OY VEY!;UFF DAH!"
 Q $P(EXP,";",$R(6)+1)
ANDTOOR(SCRN) ; Replaces AND operators with OR
 F  Q:'$F(SCRN,",$P")  S $E(SCRN,$F(SCRN,",$P")-3)="!"
 Q SCRN
SMD(RESULT,TIUWORD,TIUNM,TIUI) ; Is word a SMD?
 N TIUY S TIUY=0
 Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !,"Is """,TIUWORD,""" a Subject Matter Domain? "
 S TIUY=$$ASK(TIUWORD,8926.2) I +$G(DIRUT) Q
 ; First, inquire to the SMD file (#8926.2)
 I +TIUY>0 S @RESULT@("SubjectMatterDomain")=TIUY D PLUCK(.TIUNM,TIUWORD,TIUI) I 1
 ; That failing, try the SMD Synonyms File (#8926.72)
 E  D  Q:+$G(DIRUT)
 . W "No."
 . Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !,"Is """,TIUWORD,""" a SYNONYM for a Subject Matter Domain? "
 . S TIUY=$$ASK(TIUWORD,8926.72) Q:+$G(DIRUT)
 . I +TIUY>0 D
 . . S TIUY=+$P($G(^TIU(8926.72,+TIUY,0)),U,2)
 . . S TIUY=TIUY_U_$P($G(^TIU(8926.2,+TIUY,0)),U)
 . . S @RESULT@("SubjectMatterDomain")=TIUY
 . . D PLUCK(.TIUNM,TIUWORD,TIUI)
 I +TIUY'>0 W "No.",!
 Q
ROLE(RESULT,TIUWORD,TIUNM,TIUI) ; Is word a ROLE?
 N TIUY S TIUY=0
 Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !,"Is """,TIUWORD,""" a LOINC Role? "
 ; First, inquire to the ROLE file (#8926.3)
 S TIUY=$$ASK(TIUWORD,8926.3) Q:+$G(DIRUT)
 I +TIUY>0 S @RESULT@("Role")=TIUY D PLUCK(.TIUNM,TIUWORD,TIUI) I 1
 ; That failing, try the Role Synonyms File (#8926.73)
 E  D  Q:+$G(DIRUT)
 . W "No."
 . Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !,"Is """,TIUWORD,""" a SYNONYM for a LOINC Role? "
 . S TIUY=$$ASK(TIUWORD,8926.73) Q:+$G(DIRUT)
 . I +TIUY>0 D
 . . S TIUY=+$P($G(^TIU(8926.73,+TIUY,0)),U,2)
 . . S TIUY=TIUY_U_$P($G(^TIU(8926.3,+TIUY,0)),U)
 . . S @RESULT@("Role")=TIUY
 . . D PLUCK(.TIUNM,TIUWORD,TIUI)
 I +TIUY'>0 W "No.",!
 Q
SET(RESULT,TIUWORD,TIUNM,TIUI) ; Is word a SETTING?
 N TIUY S TIUY=0
 Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !,"Is """,TIUWORD,""" a Setting? "
 ; First, inquire to the Setting file (#8926.4)
 S TIUY=$$ASK(TIUWORD,8926.4) Q:+$G(DIRUT)
 I +TIUY>0 S @RESULT@("Setting")=TIUY D PLUCK(.TIUNM,TIUWORD,TIUI) I 1
 ; That failing, try the Setting Synonyms File (#8926.74)
 E  D  Q:+$G(DIRUT)
 . W "No."
 . Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !,"Is """,TIUWORD,""" a SYNONYM for a Setting? "
 . S TIUY=$$ASK(TIUWORD,8926.74) Q:+$G(DIRUT)
 . I +TIUY>0 D
 . . S TIUY=+$P($G(^TIU(8926.74,+TIUY,0)),U,2)
 . . S TIUY=TIUY_U_$P($G(^TIU(8926.4,+TIUY,0)),U)
 . . S @RESULT@("Setting")=TIUY
 . . D PLUCK(.TIUNM,TIUWORD,TIUI)
 I +TIUY'>0 W "No.",!
 Q
SVC(RESULT,TIUWORD,TIUNM,TIUI) ; Is word a SERVICE?
 N TIUY S TIUY=0
 Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !,"Is """,TIUWORD,""" a Service? "
 ; First, inquire to the Service file (#8926.5)
 S TIUY=$$ASK(TIUWORD,8926.5) Q:+$G(DIRUT)
 I +TIUY>0 S @RESULT@("Service")=TIUY D PLUCK(.TIUNM,TIUWORD,TIUI) I 1
 ; That failing, try the Role Synonyms File (#8926.75)
 E  D  Q:+$G(DIRUT)
 . W "No."
 . Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !,"Is """,TIUWORD,""" a SYNONYM for a Service? "
 . S TIUY=$$ASK(TIUWORD,8926.75) Q:+$G(DIRUT)
 . I +TIUY>0 D
 . . S TIUY=+$P($G(^TIU(8926.75,+TIUY,0)),U,2)
 . . S TIUY=TIUY_U_$P($G(^TIU(8926.5,+TIUY,0)),U)
 . . S @RESULT@("Service")=TIUY
 . . D PLUCK(.TIUNM,TIUWORD,TIUI)
 I +TIUY'>0 W "No.",!
 Q
DTYP(RESULT,TIUWORD,TIUNM,TIUI) ; Is word a DOCUMENT TYPE?
 N TIUY S TIUY=0
 Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !,"Is """,TIUWORD,""" a Document Type? "
 ; First, inquire to the Document Type file (#8926.6)
 S TIUY=$$ASK(TIUWORD,8926.6) Q:+$G(DIRUT)
 I +TIUY>0 S @RESULT@("DocumentType")=TIUY D PLUCK(.TIUNM,TIUWORD,TIUI) I 1
 ; That failing, try the Role Synonyms File (#8926.76)
 E  D  Q:+$G(DIRUT)
 . W "No."
 . Q:'$$PAGE^TIUMAP2(TIULOCAL)  W !,"Is """,TIUWORD,""" a SYNONYM for a Document Type? "
 . S TIUY=$$ASK(TIUWORD,8926.76) Q:+$G(DIRUT)
 . I +TIUY>0 D
 . . S TIUY=+$P($G(^TIU(8926.76,+TIUY,0)),U,2)
 . . S TIUY=TIUY_U_$P($G(^TIU(8926.6,+TIUY,0)),U)
 . . S @RESULT@("DocumentType")=TIUY
 . . D PLUCK(.TIUNM,TIUWORD,TIUI)
 I +TIUY'>0 W "No.",!
 Q
PLUCK(TIUNM,TIUWORD,TIUI) ; Pluck word from name
 N TIUOUT S TIUOUT=$P(TIUNM," ",TIUI) Q:TIUOUT'=TIUWORD
 S TIUNM=$S(TIUI=1:$P(TIUNM," ",2,$L(TIUNM," ")),1:$P(TIUNM," ",1,(TIUI-1))_$S(TIUI=$L(TIUNM," "):"",1:" "_$P(TIUNM," ",(TIUI+1),$L(TIUNM," "))))
 Q
CONFIRM(RESULT,DEFAULT) ; Show selected title to user, ask to confirm
 N TIUY,DUOUT,DTOUT,DIRUT S TIUY=0
 W !?5,"Ready to map LOCAL Title: ",$P(RESULT(1),U,3)," to",!,"VHA Enterprise Standard Title: ",$P(RESULT(1),U,2),"."
 S TIUY=$$READ^TIUU("YA","         ... OK? ",DEFAULT)
 I +TIUY'>0 S RESULT=0 K RESULT(1)
 Q
ASK(X,DIC) ; Call DIC to perform look-up
 N Y,TIUY,TIUSYN,TIUSNM S TIUY=0,TIUSNM=""
 S TIUSNM=$S(DIC=8926.72:"Subject Matter Domain",DIC=8926.73:"LOINC Role",DIC=8926.74:"Setting",DIC=8926.75:"Service",DIC=8926.76:"Document Type",1:"")
 S TIUSYN=$S(DIC=8926.72:8926.2,DIC=8926.73:8926.3,DIC=8926.74:8926.4,DIC=8926.75:8926.5,DIC=8926.76:8926.6,1:0)
 S:'$D(DIC(0)) DIC(0)="EM"
 S:TIUSYN&(DIC(0)'["Z") DIC(0)=DIC(0)_"Z"
 D ^DIC I $D(DTOUT)!$D(DUOUT) S DIRUT=1 S:X="^^" DIROUT=1
 I +Y>0 D
 . W !?4,"I found a match of: ",$P(Y,U,2)
 . I +TIUSYN,$D(Y(0)) W !?(22-$L(TIUSNM)),TIUSNM,": ",$P($G(^TIU(TIUSYN,+$P(Y(0),U,2),0)),U)
 . S TIUY=$$READ^TIUU("YA","         ... OK? ","Yes") W !
 . S:+TIUY'>0 Y=-1
 Q Y
