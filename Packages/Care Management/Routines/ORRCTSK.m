ORRCTSK ;SLC/MKB -- Patient Task file #102.3 utilities ; 25 Jul 2003  9:31 AM
 ;;1.0;CARE MANAGEMENT;;Jul 15, 2003
 ;
 ; ID = "TSK:"_task# everywhere below
 ;
PATS(ORY,ORUSR) ; -- Return list of patients for whom ORUSR has tasks due
 ; in @ORY@(PAT) = #tasks ^ 1 if any are high priority
 ;    @ORY@(PAT,ID) = * if high priority, else null
 ; [from ORRCDPT]
 N ORPROV,DUE,PAT,CNT,ABN,IFN,X0
 S ORY=$NA(^TMP($J,"ORRCTSK")) K @ORY
 S ORUSR=+$G(ORUSR),DUE=$S($G(DT):DT,1:$P($$NOW^XLFDT,"."))
 S PAT=0 F  S PAT=+$O(^ORRT(102.3,"DUE",PAT)) Q:PAT<1  D
 . I $D(^TMP($J,"ORRCLST")),'$D(^TMP($J,"ORRCY",PAT)) Q  ;pt not on list
 . S ORPROV=$$PROV(ORUSR,PAT),(CNT,ABN,IFN)=0
 . F  S IFN=+$O(^ORRT(102.3,"DUE",PAT,IFN)) Q:IFN<1  D
 .. S X0=$G(^ORRT(102.3,IFN,0)) I $P(X0,U,5),$P($P(X0,U,5),".")>DUE Q
 .. I $P(X0,U,2)'=+ORUSR,'ORPROV Q  ;not linked provider
 .. S @ORY@(PAT,"TSK:"_IFN)=$S($P(X0,U,4)="H":"*",1:"")
 .. S CNT=CNT+1 S:$P(X0,U,4)="H" ABN=1
 . I CNT S @ORY@(PAT)=CNT_U_ABN
 Q
 ;
IDS(ORY,PAT) ; -- Return due tasks for PAT
 ; in @ORY@(PAT) = #tasks ^ 1 if any are high priority
 ;    @ORY@(PAT,ID) = * if high priority, else null
 ; [from ORRCDPT1]
 N DUE,CNT,ABN,IFN,X0
 S ORY=$NA(^TMP($J,"ORRCTSK")) K @ORY
 S DUE=$S($G(DT):DT,1:$P($$NOW^XLFDT,".")),CNT=0,ABN=""
 S IFN=0 F  S IFN=+$O(^ORRT(102.3,"DUE",PAT,IFN)) Q:IFN<1  D
 . S X0=$G(^ORRT(102.3,IFN,0)) I $P(X0,U,5),$P($P(X0,U,5),".")>DUE Q
 . S @ORY@(PAT,"TSK:"_IFN)=$S($P(X0,U,4)="H":"*",1:"")
 . S CNT=CNT+1 S:$P(X0,U,4)="H" ABN=1
 S:CNT @ORY@(PAT)=CNT_U_ABN
 Q
 ;
PROV(USR,PAT) ; -- Return 1 or 0, if USR is a provider for PAT
 N Y,LIST S Y=0 S USR=+$G(USR),PAT=+$G(PAT)
 I +$G(^DPT(PAT,.104))=USR S Y=1 G PVQ ;Prim Prov
 I +$G(^DPT(PAT,.1041))=USR S Y=1 G PVQ ;Attending Prov
 S PAT=PAT_";DPT(",LIST=0
 F  S LIST=+$O(^OR(100.21,"AB",PAT,LIST)) Q:LIST<1  I $G(^OR(100.21,LIST,1,USR,0)) S Y=1 Q
PVQ Q Y
 ;
LIST(ORY,ORPAT,ORUSR,ORDUE) ; -- Return incomplete[ORDUE] tasks [by ORUSR] for ORPAT
 ; in ORY(#) = ID^subject^date created^who created^patient^priority^due^date completed^who completed^date canceled^who canceled^items
 ; RPC = ORRC TASKS BY PATIENT
 N ORN,ORPROV,IFN,X0,X1,I,ITMS,X K ORY
 S ORN=0,ORPAT=+$G(ORPAT),ORPROV=$S($G(ORUSR):$$PROV(ORUSR,ORPAT),1:"")
 I $G(ORDUE) S ORDUE=$$HL7TFM^XLFDT(ORDUE)
 S IFN=0 F  S IFN=+$O(^ORRT(102.3,"DUE",ORPAT,IFN)) Q:IFN<1  D
 . S X0=$G(^ORRT(102.3,IFN,0)),X1=$G(^(1)),ITMS=""
 . I $G(ORDUE),$P(X0,U,5),$P($P(X0,U,5),".")>ORDUE Q  ;future-not due yet
 . I $G(ORUSR),$P(X0,U,2)'=+ORUSR,'ORPROV Q  ;not linked prov
 . F I=1,5,6,8 S X=$P(X0,U,I) I $L(X) S $P(X0,U,I)=$$FMTHL7^XLFDT(X)
 . S I=0 F  S I=$O(^ORRT(102.3,IFN,2,I)) Q:I<1  S X=$G(^(I,0)),ITMS=ITMS_$S($L(ITMS):"~",1:"")_X
 . S $P(X0,U,10)=ITMS,ORN=ORN+1,ORY(ORN)="TSK:"_IFN_U_X1_U_X0
 Q
 ;
DUE(ORY,ORPAT) ; -- Return tasks that are due for ORPAT
 ; in ORY(#) = ID^subject^date created^who created^patient^priority^due^date completed^who completed^date canceled^who canceled^items
 ; RPC = ORRC TASKS DUE BY PATIENT <not used>
 N ORDT S ORDT=$$FMTHL7^XLFDT($G(DT))
 D LIST(.ORY,ORPAT,,ORDT)
 Q
 ;
DETAIL(ORY,TASK) ; -- Return details of TASKs
 ; where TASK(#) = ID
 ; in ORY(#) = ID^subject^date created^who created^patient^priority^due^date completed^who completed^date canceled^who canceled^items
 ; RPC = ORRC TASKS BY ID
 N ORN,ORI,ID,IFN,X0,X1,ITMS,I,X S ORN=0 K ORY
 S ORI="" F  S ORI=$O(TASK(ORI)) Q:ORI=""  S ID=$G(TASK(ORI)) D
 . S IFN=+$P(ID,":",2),X0=$G(^ORRT(102.3,IFN,0)),X1=$G(^(1))
 . F I=1,5,6,8 S X=$P(X0,U,I) I $L(X) S $P(X0,U,I)=$$FMTHL7^XLFDT(X)
 . S ITMS="",I=0 F  S I=$O(^ORRT(102.3,IFN,2,I)) Q:I<1  S X=$G(^(I,0)),ITMS=ITMS_$S($L(ITMS):"~",1:"")_X
 . S $P(X0,U,10)=ITMS,ORN=ORN+1,ORY(ORN)=ID_U_X1_U_X0
 Q
 ;
NEW(ORY,DATA) ; -- Create new task
 ;   where DATA = [^]subject^date created^user^patient^priority^due^date completed^who completed^date canceled^who canceled^items
 ; returns ORY  = ID if successful, else 0^error message
 ; RPC = ORRC TASK ADD
 N DO,DIC,X,Y,I,ITMS S ORY=""
 I '$L($G(DATA)) S ORY="0^Missing data string" Q
 S DATA=U_DATA,ORY=$$VALID(.DATA) Q:'ORY  ;invalid data
 S DIC="^ORRT(102.3,",DIC(0)="",X=$P(DATA,U,3) S:X<1 X=$$NOW^XLFDT
 D FILE^DICN I Y<1 S ORY="0^Unable to create new task" Q
 S $P(^ORRT(102.3,+Y,0),U,2,9)=$P(DATA,U,4,11),^(1)=$P(DATA,U,2)
 S ^ORRT(102.3,"C",+$P(DATA,U,5),+Y)=""
 I '$P(DATA,U,8),'$P(DATA,U,10) S ^ORRT(102.3,"DUE",+$P(DATA,U,5),+Y)=""
 S ITMS=$P(DATA,U,12) I $L(ITMS) D
 . F I=1:1:$L(ITMS,"~") S X=$P(ITMS,"~",I) I $L(X) S ^ORRT(102.3,+Y,2,I,0)=X,^ORRT(102.3,+Y,2,"B",X,I)=""
 . S ^ORRT(102.3,+Y,2,0)="^102.31AV^"_I_U_I
 S ORY="TSK:"_+Y
 Q
 ;
VALID(DATA) ; -- Returns 1 or 0^error if DATA string is valid
 N X,Y,I,L S Y=1
 S X=$P(DATA,U) I $L(X),'$D(^ORRT(102.3,+$P(X,":",2),0)) S Y="0^Invalid task number" G VQ
 S X=$P(DATA,U,5) I X'=+X!(X<1)!'$D(^DPT(+X,0)) S Y="0^Missing or invalid patient ID" G VQ
 F I=4,9 S X=$P(X,U,I) I $L(X),X'=+X!(X<1)!'$D(^VA(200,+X,0)) S Y="0^Missing or invalid user ID" G VQ
 F I=3,7,8,10 S X=$P(DATA,U,I) I $L(X) D  Q:'Y
 . I $L(X)=12,$E(X,9,12)="0000" S X=$E(X,1,8) ;date only
 . S X=$$HL7TFM^XLFDT(X) I $L(X) S $P(DATA,U,I)=X Q  ;reformat
 . S Y="0^Invalid date "_$S(I=3:"created",I=7:"due",1:"completed")
 S X=$P(DATA,U,6) I $L(X),X'="L",X'="M",X'="H" S Y="0^Invalid priority" G VQ
 S X=$P(DATA,U,2) I '$L(X)!(X["^")!($L(X)>100) S Y="0^Invalid subject text" G VQ
 S X=$P(DATA,U,12) I $L(X) F I=1:1:$P(X,"~") S L=$P(X,"~",I) I $L(L),L'?3U1":".E S Y="0^Invalid linked item ID" Q
VQ Q Y
 ;
EDIT(ORY,TASK) ; -- Change existing tasks
 ;   where TASK(#) = ID^subject^date created^user^patient^priority^due^date completed^who completed^date canceled^who canceled^items
 ; returns ORY(#)  = ID^1 or ID^0^error, if successful or not
 ; RPC = ORRC TASK EDIT
 N ORI,DATA,ID,DA,I,X,Y,SUBJ,ITMS,X0 K ORY
 S ORI="" F  S ORI=$O(TASK(ORI)) Q:ORI=""  S DATA=$G(TASK(ORI)) D
 . S ID=$P(DATA,U),DA=+$P(ID,":",2)
 . I DA<1 S ORY(ORI)=ID_"^0^Invalid task number" Q
 . S X=$$VALID(.DATA) I X<1 S ORY(ORI)=ID_U_X Q
 . L +^ORRT(102.3,DA):5 I '$T S ORY(ORI)=ID_"^0^Another user is editing this task" Q
 . S SUBJ=$P(DATA,U,2),ITMS=$P(DATA,U,12),DATA=$P(DATA,U,3,11)
 . S X0=$G(^ORRT(102.3,DA,0)),^(0)=DATA,^(1)=SUBJ K ^(2) I $L(ITMS) D
 .. F I=1:1:$L(ITMS,"~") S X=$P(ITMS,"~",I) I $L(X) S ^ORRT(102.3,DA,2,I,0)=X,^ORRT(102.3,DA,2,"B",X,I)=""
 .. S ^ORRT(102.3,DA,2,0)="^102.31AV^"_I_U_I
 . I $P(X0,U)'=$P(DATA,U) K ^ORRT(102.3,"B",$P(X0,U),DA) S ^ORRT(102.3,"B",$P(DATA,U),DA)=""
 . I $P(X0,U,3)'=$P(DATA,U,3) K ^ORRT(102.3,"C",$P(X0,U,3),DA) S ^ORRT(102.3,"C",$P(DATA,U,3),DA)=""
 . K ^ORRT(102.3,"DUE",$P(X0,U,3),DA)
 . I '$P(DATA,U,6),'$P(DATA,U,8) S ^ORRT(102.3,"DUE",$P(DATA,U,3),DA)=""
 . S ORY(ORI)=ID_"^1" L -^ORRT(102.3,DA)
 Q
 ;
COMP(ORY,ORUSR,TASK) ; -- Complete tasks by ORUSR
 ;   where TASK(#) = ID
 ; returns ORY(#)  = ID^1 or ID^0^error, if successful or not
 ; RPC = ORRC TASK COMPLETE
 N X,Y,ID,DA,DR,DIE,ORI
 I $G(ORUSR)<1 S ORY(0)="0^Invalid user identifier" Q
 S DIE="^ORRT(102.3,",DR="6///NOW;7///"_+ORUSR
 S ORI="" F  S ORI=$O(TASK(ORI)) Q:ORI=""  S ID=TASK(ORI) D
 . S DA=+$P(ID,":",2) I DA<1 S ORY(ORI)=ID_"^0^Invalid task number" Q
 . L +^ORRT(102.3,DA):5 I '$T S ORY(ORI)=ID_"^0^Another user is editing this task" Q
 . D ^DIE S ORY(ORI)=ID_"^1" L -^ORRT(102.3,DA)
 Q
 ;
CANC(ORY,ORUSR,TASK) ; -- Cancel tasks by ORUSR
 ;   where TASK(#) = ID
 ; returns ORY(#)  = ID^1 or ID^0^error, if successful or not
 ; RPC = ORRC TASK CANCEL
 N X,Y,ID,DA,DR,DIE,ORI
 I $G(ORUSR)<1 S ORY(0)="0^Invalid user identifier" Q
 S DIE="^ORRT(102.3,",DR="8///NOW;9///"_+ORUSR
 S ORI="" F  S ORI=$O(TASK(ORI)) Q:ORI=""  S ID=TASK(ORI) D
 . S DA=+$P(ID,":",2) I DA<1 S ORY(ORI)=ID_"^0^Invalid task number" Q
 . L +^ORRT(102.3,DA):5 I '$T S ORY(ORI)=ID_"^0^Another user is editing this task" Q
 . D ^DIE S ORY(ORI)=ID_"^1" L -^ORRT(102.3,DA)
 Q
 ;
SUBJ(ORY,ORPAT) ; -- Return list of task subjects used for ORPAT
 ; as ORY(#) = task subject
 N ORI,ORN K ORY S ORN=0
 S ORI=0  F  S ORI=$O(^ORRT(102.3,"C",ORPAT,ORI)) Q:ORI<1  D
 . S X=$G(^ORRT(102.3,ORI,1)) Q:'$L(X)
 . S ORN=ORN+1,ORY(ORN)=X
 Q
