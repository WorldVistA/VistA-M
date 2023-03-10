VPRHS ;SLC/MKB -- HealthShare utilities ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8,10,15,16,17,19,25,27**;Sep 01, 2011;Build 10
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DPT                         10035
 ; %ZTLOAD                      10063
 ; DDE                           7008
 ; DICN                         10009
 ; DIK                          10013
 ; MPIF001                       2701
 ; VADPT                         3744
 ; XLFDT                        10103
 ; XUPROD                        4440
 ;
 Q
 ;
ON() ; -- return 1 or 0, if monitoring is on
 Q $P($G(^VPR(1,0)),U,2)
 ;
EN(DFN) ; -- subscribe a patient for data event monitoring
 Q:'$G(DFN)  Q:$D(^VPR(1,2,+DFN,0))
 ;S ^VPR(1,2,+DFN,0)=+DFN,^VPR(1,2,"B",+DFN,+DFN)=""
 N X,Y,DA,DIC,DINUM
 S DIC="^VPR(1,2,",DIC(0)="ULFNX",DA(1)=1,(DINUM,X)=+DFN
 D FILE^DICN
 Q
 ;
UN(DFN) ; -- unsubscribe
 Q:'$G(DFN)  Q:'$D(^VPR(1,2,+DFN,0))
 ;K ^VPR(1,2,+DFN,0),^VPR(1,2,"B",+DFN,+DFN)
 N DA,DIK
 S DA(1)=1,DA=+DFN,DIK="^VPR(1,2,"
 D ^DIK
 Q
 ;
SUBS(DFN) ; -- return 1 or 0, if patient is subscribed or not
 Q $D(^VPR(1,2,+$G(DFN),0))
 ;
QUE(DFN) ; -- create task to POST a Patient update
 Q:'$P($G(^VPR(1,0)),U,2)        ;monitoring disabled
 Q:$G(DFN)<1  Q:'$$SUBS(DFN)     ;not subscribed
 Q:$P($G(^VPR(1,2,+DFN,0)),U,2)  ;task exists
 ; create task
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC,ZTSK
 S ZTRTN="PAT^VPRHS",ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,,,10)
 S ZTDESC="Task single VPR SDA Patient Container update"
 S ZTIO="",ZTSAVE("DFN")="" D ^%ZTLOAD
 S:$G(ZTSK)>0 $P(^VPR(1,2,DFN,0),U,2)=ZTSK
 Q
 ;
PAT ; -- post Patient update [TASK]
 Q:'$P($G(^VPR(1,0)),U,2)                     ;monitoring disabled
 S DFN=+$G(DFN) Q:DFN<1  Q:'$D(^DPT(DFN,0))   ;not valid
 Q:'$$SUBS(DFN)  I $$MERGED(DFN) D UN(DFN) Q  ;not subscribed
 D POST(DFN,"Patient",DFN_";2")
 S $P(^VPR(1,2,DFN,0),U,2)="",ZTREQ="@"       ;clear task
 Q
 ;
PX ; -- post an encounter update
 G TASK^VPRENC ;moved in VPR*1*19
 ;
VALID(PAT) ; -- return 1 or 0, if valid patient for HealthShare
 S PAT=+$G(PAT) I PAT<1 Q 0                 ;invalid pointer
 I '$D(^DPT(DFN,0)) Q 0                     ;invalid entry
 I $G(^DPT(PAT,.35)) Q 0                    ;death date
 I $$TESTPAT^VADPT(PAT),$$PROD^XUPROD Q 0   ;no test pats in prod
 I $$MERGED(PAT) Q 0                        ;no merged-from pats
 I '$G(^DPT(PAT,"MPI")) Q 0                 ;no ICN
 Q 1
 ;
MERGED(DFN) ; -- return 1 or 0, if patient is being merged
 I $P($G(^DPT(+$G(DFN),0)),U)["MERGING INTO" Q 1
 I $G(^DPT(+$G(DFN),-9)) Q 1
 Q 0
 ;
POST(DFN,TYPE,ID,ACT,VST,RES) ; -- post an update to
 ;  ^VPR(1,2,DFN,"AVPR",TYPE,ID) = seq#
 ;  ^VPR("AVPR",seq#,DFN) = ICN ^ TYPE ^ ID ^ U/D ^ VISIT#
 Q:'$P($G(^VPR(1,0)),U,2)                   ;monitoring disabled
 S DFN=+$G(DFN),TYPE=$G(TYPE),ID=$G(ID)
 Q:DFN<1  Q:TYPE=""                         ;incomplete request
 N ICN S ICN=$$GETICN^MPIF001(DFN) Q:ICN<0  ;ICN required
 ; add to ^VPR if not subscribed
 I '$$SUBS(DFN) D:$$VALID(DFN) NEW(DFN,ICN) Q
 I $$MERGED(DFN) D UN(DFN) Q                ;no merged-from pats
 S ACT=$S($G(ACT)="@":"D",1:"U")
P1 ;may enter here from VPRHSX1 manual update option
 N SEQ,STR S SEQ=$$NUM
 S STR=$G(ICN)_U_$G(TYPE)_U_$G(ID)_U_$G(ACT)_U_$G(VST)
 S ^VPR("AVPR",SEQ,DFN)=STR
 ; use * for subscript (whole container) if ID is null
 S ^VPR(1,2,DFN,"AVPR",TYPE,$S($G(ID)="":"*",1:ID))=SEQ ;_U_$G(ACT)_U_$G(VST)
 I $P($G(^VPR(1,0)),U,5) D XTMP(SEQ,DFN,STR) ;tracking option
 S RES=SEQ
 Q
 ;
NUM() ; -- return existing SEQ of record, or increment
 ; SAC EXEMPTION 2019-04-29 : Use of $I
 N X,Y S X=$S(ID="":"*",1:ID)
 S Y=+$G(^VPR(1,2,DFN,"AVPR",TYPE,X)) I '$D(^VPR("AVPR",Y,DFN)) S Y=0
 I Y'>0 S Y=$I(^VPR(1,1))
 Q Y
 ;
NEW(DFN,ICN) ; -- post a new $$VALID patient to 
 ; ^VPR(1,2,DFN,"ANEW")  = seq#
 ; ^VPR("ANEW",seq#,DFN) = ICN
 Q:$G(DFN)<1  Q:$G(^VPR(1,2,DFN,"ANEW"))
 I $G(ICN)<1 S ICN=$$GETICN^MPIF001(DFN) Q:ICN<0
 N SEQ S SEQ=$I(^VPR(1,1))
 S ^VPR("ANEW",SEQ,DFN)=ICN,^VPR(1,2,DFN,"ANEW")=SEQ
 I $P($G(^VPR(1,0)),U,5) D XTMP(SEQ,DFN,(ICN_"^ANEW")) ;tracking option
 Q
 ;
DEL(LIST,SEQ) ; -- remove ^VPR(LIST,SEQ) nodes
 N DFN,DATA,TYPE,ID
 S LIST=$G(LIST),SEQ=+$G(SEQ) Q:LIST=""  Q:SEQ<1
 S DFN=+$O(^VPR(LIST,SEQ,0)) I DFN<1 Q
 I LIST="ANEW" K ^VPR("ANEW",SEQ,DFN),^VPR(1,2,DFN,"ANEW") Q
 S DATA=$G(^VPR(LIST,SEQ,DFN)) K ^VPR("AVPR",SEQ,DFN)
 S TYPE=$P(DATA,U,2) Q:TYPE=""  ;error
 S ID=$P(DATA,U,3) S:ID="" ID="*"
 K ^VPR(1,2,DFN,"AVPR",TYPE,ID)
 Q
 ;
XTMP(SEQ,DFN,X) ; -- save data for 3 days for debugging
 N D S D=$P($H,",")
 I '$D(^XTMP("VPRHS-"_D,0)) D
 . L +^XTMP("VPRHS-"_D,0):3
 . S ^XTMP("VPRHS-"_D,0)=$$FMADD^XLFDT(DT,4)_U_DT_"^VPR update log for HealthShare"
 . L -^XTMP("VPRHS-"_D,0)
 S ^XTMP("VPRHS-"_D,SEQ,DFN)=X
 Q
 ;
GET(DFN,NAME,ID,VPRQ,MTYPE,VPRY,VPRR) ; -- return VistA data in @VPRY@(#)
 N VPRNM,VPRFN,VPRE,VPRX,VPRZ,VPRMAX,VPRSRC,VPRCTR,VPRC0
 N VPRI,VPRJ,VPRK,VPRN
 ;
 ; define default return arrays
 S VPRY=$G(VPRY,$NA(^TMP("VPR GET",$J))),VPRI=0 K @VPRY
 S VPRR=$G(VPRR,$NA(^TMP("VPR ERR",$J))),VPRJ=0 K @VPRR
 ;
 ; validate Patient
 S DFN=+$G(DFN),VPRQ("patient")=DFN
 I DFN<1!'$D(^DPT(DFN,0)) G GTQ
 ;
 ; validate/find Container
 S VPRNM=$G(NAME),VPRSRC=$G(VPRQ("source"))
 I $L(VPRNM,";")>1 S VPRSRC=$P(VPRNM,";",2),VPRNM=$P(VPRNM,";") G:VPRNM="" GTQ
 S VPRCTR=+$O(^VPRC(560.1,"C",VPRNM,0)) G:VPRCTR<1 GTQ
 S ID=$G(ID) I VPRNM="Patient",'ID&DFN S ID=DFN_";2"
 I $G(VPRQ("max")) S VPRMAX=+VPRQ("max")
 ;
GT1 ; update one record for ECR
 I ID'="",ID'="*" D  G GTQ
 . S VPRFN=+$P(ID,";",2),ID=$P(ID,";")
 . I 'VPRFN!(ID="") Q  ;D ERROR("Invalid ID: "_ID_";"_VPRFN) Q
 . S VPRK=+$O(^VPRC(560.1,"F",VPRFN,VPRCTR,0))
 . S VPRC0=$G(^VPRC(560.1,VPRCTR,1,VPRK,0)),VPRE=$P(VPRC0,U,2)
 . ; if deleting a record saved in XTMP, switch entities
 . N SEQ S SEQ=$G(VPRQ("sequence"))
 . I $G(SEQ),$P($G(^XTMP("VPR-"_+SEQ,ID)),U,4)="D",$P(VPRC0,U,3) S VPRE=$P(VPRC0,U,3)
 . I 'VPRE Q  ;D ERROR("Missing Entity: "_VPRNM_" file #"_VPRFN) Q
 . S VPRI=VPRI+1,@VPRY@(VPRI)=$$GET1^DDE(+VPRE,ID,.VPRQ,1,.VPRR)
 . S VPRJ=+$O(@VPRR@("A"),-1) ;#errors
 ;
GTA ; retrieve whole container for patient re/load
 I 'VPRSRC,$P($G(^VPRC(560.1,VPRCTR,0)),U,3) D  Q
 . S VPRE=$P($G(^VPRC(560.1,VPRCTR,0)),U,3)
 . D GET^DDE(VPRE,,.VPRQ,1,.VPRMAX,.VPRY,.VPRR)
 . S VPRJ=+$O(@VPRR@("A"),-1) S:VPRJ @VPRR@(0)=VPRJ ;#errors
 ; 
 S VPRX=$NA(^TMP("VPRHS",$J)),VPRZ=$NA(^TMP("VPRHS ERR",$J))
 S VPRK=0 F  S VPRK=$O(^VPRC(560.1,VPRCTR,1,VPRK)) Q:VPRK<1  S VPRC0=$G(^(VPRK,0)) D
 . S VPRFN=+VPRC0 Q:'VPRFN  I VPRSRC,VPRFN'=VPRSRC Q
 . S VPRE=+$P(VPRC0,U,2) Q:VPRE<1  K @VPRX,@VPRZ
 . ;I 'VPRE D ERROR("Missing Entity for "_VPRNM_" file #"_VPRFN) Q
 . D GET^DDE(VPRE,,.VPRQ,1,.VPRMAX,.VPRX,.VPRZ)
 . S VPRN=0 F  S VPRN=$O(@VPRX@(VPRN)) Q:VPRN<1  S VPRI=VPRI+1,@VPRY@(VPRI)=@VPRX@(VPRN)
 . S VPRN=0 F  S VPRN=$O(@VPRZ@(VPRN)) Q:VPRN<1  S VPRJ=VPRJ+1,@VPRR@(VPRJ)=@VPRZ@(VPRN)
 K @VPRX,@VPRZ
 ;
GTQ ; return data and exit
 S @VPRY@(0)=VPRI,@VPRR@(0)=VPRJ
 Q
 ;
ERROR(MSG) ; -- return error MSG
 S VPRJ=+$G(VPRJ)+1
 S @VPRR@(VPRJ)=$G(MSG)
 Q
 ;
ENTITY(CONT,FN,ACT) ; -- find Entity
 N Y,C,I,C0 S Y=""
 S CONT=$G(CONT),FN=+$G(FN),ACT=$G(ACT)
 S C=$S(CONT:CONT,$L(CONT):+$O(^VPRC(560.1,"C",CONT,0)),1:0)
 S I=+$O(^VPRC(560.1,C,1,"B",FN,0)),C0=$G(^VPRC(560.1,C,1,I,0))
 S Y=$P(C0,U,$S(ACT="D":3,1:2))
 Q Y
 ;
TEST(ENTITY,ID,DFN,SEQ) ; -- test and display a single record
 N Z,IN,ERR,DONE
 S ENTITY=$G(ENTITY),ID=$G(ID)
 S:$G(DFN) IN("patient")=DFN
 S:$G(SEQ) IN("sequence")=SEQ
 S Z=$$GET1^DDE(ENTITY,ID,.IN,1,.ERR)
 I $O(ERR(0)) W !,$G(ERR(1))
 I $L(Z) D XML^VPRHST1(Z)
 Q
