EDPFMOVE ;SLC/MKB - Move local ER Visits to EDIS
 ;;1.0;EMERGENCY DEPARTMENT;;Sep 30, 2009;Build 74
 ;
EN ; -- Option EDP CONVERSION to copy local data
 I '$D(^DIZ(172006,0)) W !!,"You have no ER data to convert." H 1 Q
 I $G(^XTMP("EDP-CONV","X"))="DONE" W !!,"The data conversion has completed." H 1 Q
 ;
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT,EDPDIV
 W !!,"This option will copy ER configuration and visit data at your site"
 W !,"to the new Emergency Department application.  For each division,"
 W !,"your local configuration data will be copied first, followed by all"
 W !,"currently active patient visits.  A task will then be queued to"
 W !,"populate previous, closed visits in the national application files"
 W !,"to allow reports to continue to function."
 S EDPDIV=$$SELDIV Q:'EDPDIV
 I '$$AREA(EDPDIV) W !!,"Please create a Tracking Area for this division.",! Q
 D SELCVT Q:EDPDIV="^"
 W !!,"DO NOT PROCEED UNTIL YOU ARE READY TO USE THE NEW EDIS PACKAGE!!",!
 S DIR(0)="YA",DIR("A")="Are you ready? ",DIR("B")="NO"
 D ^DIR Q:'Y
 ;
E1 ; -- start here
 D CONFIG
 D ACTIVE
 ; -- task LOOP
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSYNC,ZTSK
 S ZTSK=$P($G(^XTMP("EDP-CONV","D",EDPDIV)),U,4) I ZTSK D  Q:$G(ZTSK)
 . D STAT^%ZTLOAD N STS S STS=+$G(ZTSK(1))
 . I STS=1!(STS=2) W !,"Visit conversion is still running." Q
 . K ZTSK
 . ; STS=4!(STS=5) K ZTSK Q  ;never ran or errored out
 . ; STS=3!(STS=0) K ZTSK Q  ;completed or undefined
 S ZTRTN="LOOP^EDPFMOVE",ZTIO="",ZTDTH=$H,ZTSAVE("EDPDIV")=""
 S ZTDESC="Copy old ER data to new EDIS application"
 D ^%ZTLOAD I $G(ZTSK) D  Q
 . W !,"Task #"_ZTSK_" started to copy closed visits."
 . S $P(^XTMP("EDP-CONV","D",EDPDIV),U,4)=ZTSK
 W !,"ERROR -- Task to copy closed visits NOT started!"
 Q
 ;
CONFIG ; -- convert site configuration
 N EDPI,MSG,N,I,X0,XMZ K XMMG
 S EDPI=$P($G(^XTMP("EDP-CONV","D",EDPDIV)),U) ; = ien^0^0 in post-init
 I EDPI="" W !,"Configuration data for "_$$NAME^XUAF4(EDPDIV)_" has already been copied." Q
 I EDPI=-1 W !,"Configuration data for "_$$NAME^XUAF4(EDPDIV)_" will not be copied." Q
 W !,"Copying local configuration ... "
 F  S EDPI=$O(^DIZ(172012,EDPI)) Q:EDPI<1  D  Q:$D(XMMG)
 . K MSG S MSG(1)="command=convertConfiguration",N=1
 . S X0=$G(^DIZ(172012,EDPI,0))
 . S N=N+1,MSG(N)="SITE="_EDPDIV
 . S N=N+1,MSG(N)="TZ="_$$TZ^XLFDT
 . F I=2,3,5 S N=N+1,MSG(N)=I_"="_$G(^DIZ(172012,EDPI,I))
 . ; include acuities and statuses for default colors
 . S I=0 F  S I=$O(^DIZ(172007,"D",EDPDIV,I)) Q:I<1  D
 .. S X0=$G(^DIZ(172007,I,0)) Q:'$P(X0,U,6)  ;inactive
 .. S $P(X0,U,3)=$$EXTERNAL^DILFD(172007,2,"",$P(X0,U,3))
 .. S $P(X0,U,4)=$$EXTERNAL^DILFD(172007,3,"",$P(X0,U,4))
 .. S N=N+1,MSG(N)="ACU"_I_"="_X0
 . S I=0 F  S I=$O(^DIZ(172009,I)) Q:I<1  S X0=$G(^(I,0)) D
 .. S $P(X0,U,2)=$$EXTERNAL^DILFD(172009,1,"",$P(X0,U,2))
 .. S $P(X0,U,3)=$$EXTERNAL^DILFD(172009,2,"",$P(X0,U,3))
 .. S N=N+1,MSG(N)="STS"_I_"="_X0
 . D SEND^EDPFMON(.MSG)
 S $P(^XTMP("EDP-CONV","D",EDPDIV),U)="" ;done
 Q
 ;
ACTIVE ; -- Loop through ER Locations, convert open visits first
 N EDPL,VST,XMZ
 S EDPL=$P($G(^XTMP("EDP-CONV","D",EDPDIV)),U,2) ; = ien^0^0 in post-init
 I EDPL="" Q  ;W !,"Active visits already copied." Q
 W !,"Copying currently active visits ... "
 F  S EDPL=$O(^DIZ(172008,"C",EDPDIV,EDPL)) Q:EDPL<1  D
 . S VST=$P($G(^DIZ(172008,EDPL,0)),U,5) Q:'VST
 . D EN1(VST,1) S ^XTMP("EDP-CONV",VST)=""
 . S $P(^XTMP("EDP-CONV","D",EDPDIV),U,2)=EDPL
 S $P(^XTMP("EDP-CONV","D",EDPDIV),U,2)="" ;done
 Q
 ;
LOOP ; -- Queued loop to send previous [closed] visits
 N EDPI
 S EDPI=$P($G(^XTMP("EDP-CONV","D",EDPDIV)),U,3)
 F  S EDPI=$O(^DIZ(172006,"E",EDPDIV,EDPI)) Q:EDPI<1  D
 . I $D(^XTMP("EDP-CONV",EDPI)) S $P(^XTMP("EDP-CONV","D",EDPDIV),U,3)=EDPI Q
 . D EN1(EDPI)
 . S $P(^XTMP("EDP-CONV","D",EDPDIV),U,3)=EDPI
 ;S ^XTMP("EDP-CONV","X")="DONE"
 Q
 ;
EN1(IEN,OPEN) ; -- convert single ER visit
 N I,X,Y,X0,DIZ
 F I=0,1,2,3,4,6,9 S DIZ(I)=$G(^DIZ(172006,IEN,I))
 I $O(^DIZ(172006,IEN,8,0)) M DIZ(8)=^DIZ(172006,IEN,8)
 S X=$P(DIZ(3),U),DIZ("SITE")=X                 ;Institution file ien
 S DIZ("TZ")=$$TZ^XLFDT                         ;Time Zone difference
 ; S:'$G(OPEN) DIZ("CLOSED")=1                  ;Closed visit
 ;
 ;include static file nodes used:
 S X=$P(DIZ(0),U,4) S:X DIZ("STS"_X)=$$STS(X)   ;Status
 I '$G(OPEN),X,$P($G(DIZ("STS"_X)),U,4)="GONE" S DIZ("CLOSED")=1
 S X=$P(DIZ(0),U,6) S:X DIZ("ARR"_X)=$$ARR(X)   ;Arrival Mode
 S X=$P(DIZ(3),U,2) S:X DIZ("LOC"_X)=$$LOC(X)   ;Location
 S X=$P(DIZ(4),U,2) S:X $P(DIZ(4),U,2)=$$NUR(X) ;RN->200
 S X=$P(DIZ(4),U,3) S:X DIZ("ACU"_X)=$$ACU(X)   ;Acuity
 S X=$P(DIZ(4),U,7) S:X DIZ("DEL"_X)=$$DEL(X)   ;Delay Reason
 S X=$P(DIZ(9),U,3) S:X DIZ("DIS"_X)=$$DIS(X)   ;Disposition
 I 'X S X=$P(DIZ(6),U,3) S:$L(X) DIZ("DIS"_X)=$$EXTERNAL^DILFD(172006,16,,X)_"^1^^^"_X
 S I=0 F  S I=$O(^DIZ(172006,IEN,7,I)) Q:I<1  S X0=$G(^(I,0)) D
 . S X=$P(X0,U,3) I X,'$D(DIZ("STS"_X)) S DIZ("STS"_X)=$$STS(X)
 . S X=$P(X0,U,4) I X,'$D(DIZ("ACU"_X)) S DIZ("ACU"_X)=$$ACU(X)
 . S X=$P(X0,U,5) I X,'$D(DIZ("LOC"_X)) S DIZ("LOC"_X)=$$LOC(X)
 . S X=$P(X0,U,7) S:X $P(X0,U,7)=$$NUR(X)       ;RN->200
 . S DIZ("MVT"_I)=X0
 ;
 ;send to nat'l file
 ;N MSG S MSG(1)="command=convertVisit",I=1
 ;S X="" F  S X=$O(DIZ(X)) Q:X=""  S I=I+1,MSG(I)=X_"="_DIZ(X)
 ;D SEND^EDPFMON(.MSG)
 ;
 D VST^EDPCONV(.DIZ)
 I $G(DIZ(230)) S ^DIZ(172006,IEN,230)=DIZ(230)
 Q
 ;
LOC(X) ; -- Return 0-node for Location ien X
 N NODE,S S NODE=$G(^DIZ(172008,+$G(X),0))
 S S=$P(NODE,U,8) I S,'$D(DIZ("STS"_S)) S DIZ("STS"_S)=$$STS(S)
 Q NODE
 ;
ACU(X)    ; -- Return 0-node for Acuity ien X
 Q $G(^DIZ(172007,+$G(X),0))
 ;
STS(X) ; -- Return 0-node for Status ien X
 Q $G(^DIZ(172009,+$G(X),0))
 ;
DEL(X) ; -- Return 0-node for Delay Reason ien X
 Q $G(^DIZ(172011,+$G(X),0))
 ;
ARR(X) ; -- Return 0-node for Arrival Mode ien X
 Q $G(^DIZ(172014,+$G(X),0))
 ;
DIS(X) ; -- Return 0-node for Disposition ien X
 Q $G(^DIZ(172015,+$G(X),0))
 ;
PER(X) ; -- Return NAME^INITIALS for New Person ien X
 Q $P($G(^VA(200,+$G(X),0)),U,1,2)
 ;
NUR(X) ; -- Return #200 ptr for Nurse Staff ien X
 Q $P($G(^NURSF(210,+$G(X),0)),U)
 ;
SELDIV() ; -- Select division ien to convert
 N I,DIV,CNT,X,Y,DIC,DTOUT,DUOUT
 S I=0 F  S I=$O(^XTMP("EDP-CONV","D",I)) Q:I<1  S X=$G(^(I)) D
 . I $P(X,U)<1,$O(^DIZ(172006,"E",I,"A"),-1)'>$P(X,U,3) Q
 . S DIV(I)=$$NS^XUAF4(I),CNT=+$G(CNT)+1
 I '$O(DIV(0)) W !!,"There is no data to convert." Q
 S DIC=4,DIC(0)="AEQMN",DIC("S")="I $D(DIV(Y))"
 I $G(CNT)=1 S I=$O(DIV(0)),DIC("B")=$P(DIV(I),U,2)
 S DIC("A")="Select the division you wish to convert: "
 W !!,"Available divisions: "
 S I=0 F  S I=$O(DIV(I)) Q:I<1  W !,$P(DIV(I),U,2),?10,$P(DIV(I),U)
 D ^DIC S Y=$S(Y>0:+Y,1:0)
 Q Y
 ;
AREA(D) ; -- Return Tracking Area #231.9 ien for Division ien
 Q +$O(^EDPB(231.9,"C",+$G(D),0))
 ;
SELCVT ; -- Select what to convert: configuration, data, or both
 Q:$P($G(^XTMP("EDP-CONV","D",EDPDIV)),U)=""
 N X,Y,DIR,DTOUT,DUOUT
 S DIR(0)="YA" W !
 S DIR("A")="Do you wish to convert the configuration as well as the data? "
 S DIR("?",1)="Enter YES if you wish to convert this division's configuration as well"
 S DIR("?")="as the patient data, otherwise enter NO to convert only the data."
 D ^DIR I Y'=1,Y'=0 S EDPDIV="^" Q
 S $P(^XTMP("EDP-CONV","D",EDPDIV),U)=$S(Y=0:-1,1:+$O(^DIZ(172012,"B",EDPDIV,0)))
 Q
