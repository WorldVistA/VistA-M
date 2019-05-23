VPRHS ;SLC/MKB -- HealthShare utilities ;10/25/18  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;**8,10**;Sep 01, 2011;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^DDE                          7014
 ; ^DGS(41.1                     3796
 ; ^DPT                         10035
 ; %ZTLOAD                      10063
 ; DDE                           7008
 ; MPIF001                       2701
 ; SDAMA301                      4433
 ; XLFDT                        10103
 ; XLFSTR                       10104
 ;
 Q
 ;
ON() ; -- return 1 or 0, if monitoring is on
 Q $P($G(^VPR(1,0)),U,2)
 ;
EN(DFN) ; -- subscribe a patient for data event monitoring
 Q:'$G(DFN)  Q:$D(^VPR(1,2,+DFN,0))
 S ^VPR(1,2,+DFN,0)=+DFN,^VPR(1,2,"B",+DFN,+DFN)=""
 ;N X,Y,DA,DIC,DINUM
 ;S DIC="^VPR(1,2,",DIC(0)="UL",DA(1)=1,(DINUM,X)=+DFN
 ;D FILE^DICN
 Q
 ;
UN(DFN) ; -- unsubscribe
 Q:'$G(DFN)  Q:'$D(^VPR(1,2,+DFN,0))
 K ^VPR(1,2,+DFN,0),^VPR(1,2,"B",+DFN,+DFN)
 ;N DA,DIK
 ;S DA(1)=1,DA=+DFN,DIK="^VPR(1,2,"
 ;D ^DIK
 Q
 ;
SUBS(DFN) ; -- return 1 or 0, if patient is subscribed or not
 Q $D(^VPR(1,2,+$G(DFN),0))
 ;
QUE(DFN) ; -- create task to POST a Patient update
 Q:'$P($G(^VPR(1,0)),U,2)       ;monitoring disabled
 Q:DFN<1  Q:'$$SUBS(DFN)        ;not subscribed
 Q:$P($G(^VPR(1,2,DFN,0)),U,2)  ;task exists
 ; create task
 N ZTRTN,ZTDTH,ZTDESC,ZTIO,ZTSAVE,ZTUCI,ZTCPU,ZTPRI,ZTKIL,ZTSYNC,ZTSK
 S ZTRTN="PAT^VPRHS",ZTDTH=$$FMADD^XLFDT($$NOW^XLFDT,,,10)
 S ZTDESC="Task single VPR SDA Patient Container update"
 S ZTIO="",ZTSAVE("DFN")="" D ^%ZTLOAD
 S:$G(ZTSK)>0 $P(^VPR(1,2,DFN,0),U,2)=ZTSK
 Q
 ;
PAT ; -- post Patient update
 D POST^VPRHS(DFN,"Patient",DFN_";2")
 S $P(^VPR(1,2,DFN,0),U,2)="",ZTREQ="@"
 Q
 ;
POST(DFN,TYPE,ID,ACT,VST) ; -- post an update to
 ;  ^VPR("AVPR",seq#,DFN) = ICN ^ TYPE ^ ID ^ U/D ^ VISIT#
 ;
 Q:'$P($G(^VPR(1,0)),U,2)                   ;monitoring disabled
 S DFN=+$G(DFN),TYPE=$G(TYPE),ID=$G(ID)
 Q:DFN<1  Q:TYPE=""                         ;incomplete request
 N ICN S ICN=$$GETICN^MPIF001(DFN) Q:ICN<0  ;ICN required
 ; add to ^VPR if not subscribed, not dead
 I '$$SUBS(DFN),'$G(^DPT(DFN,.35)) D NEW(DFN,ICN) Q
 S ACT=$S($G(ACT)="@":"D",1:"U")
P1 ;may enter here from VPRHSX manual update option
 N SEQ S SEQ=$I(^VPR(1,1))
 S ^VPR("AVPR",SEQ,DFN)=ICN_U_$G(TYPE)_U_$G(ID)_U_$G(ACT)_U_$G(VST)
 Q
 ;
NEW(DFN,ICN) ; -- post a new patient to ^VPR("ANEW",seq#,DFN) = ICN
 Q:$G(DFN)<1  I $G(ICN)<1 S ICN=$$GETICN^MPIF001(DFN) Q:ICN<0
 N SEQ S SEQ=$I(^VPR(1,1))
 S ^VPR("ANEW",SEQ,DFN)=ICN
 Q
 ;
GET(DFN,NAME,ID,VPRQ,MTYPE,VPRY,VPRR) ; -- return VistA data in @VPRY@(#)
 N ICN,VPRNM,VPRFN,VPRE,VPRI,VPRN,VPRX,VPRMAX
 S DFN=$G(DFN),ICN=$P(DFN,";",2),DFN=+DFN
 Q:DFN<1  Q:'$D(^DPT(DFN))  S VPRQ("patient")=DFN
 ;
 S VPRNM=$G(NAME)  Q:VPRNM=""
 S ID=$G(ID),MTYPE=$G(MTYPE,1) ;XML
 I $G(VPRQ("max")) S VPRMAX=VPRQ("max")
 ;
 S VPRY=$G(VPRY,$NA(^TMP("VPR GET",$J))),VPRI=0 K @VPRY
 S VPRR=$G(VPRR,$NA(^TMP("VPR ERR",$J))) K @VPRR
 I VPRNM="Patient",'ID&DFN S ID=DFN_";2"
 ;
 ; update one record for ECR
 I ID'="" D  Q
 . S VPRFN=$P(ID,";",2),ID=$P(ID,";")
 . S VPRE=$O(^DDE("SDA",VPRNM,VPRFN,0)) Q:'VPRE  ;ERROR?
 . S VPRI=VPRI+1,@VPRY@(VPRI)=$$GET1^DDE(VPRE,ID,.VPRQ,MTYPE,.VPRR)
 ;
 ; pre-load of whole container for patient
 S VPRX=$NA(^TMP("VPRHS",$J))
 S VPRFN=0 F  S VPRFN=$O(^DDE("SDA",VPRNM,VPRFN)) Q:VPRFN<1  D
 . S VPRE=$O(^DDE("SDA",VPRNM,VPRFN,0)) K @VPRX
 . D:VPRE GET^DDE(VPRE,,.VPRQ,MTYPE,.VPRMAX,.VPRX,.VPRR)
 . Q:'$D(VPRX)  Q:+$G(@VPRX@(0))'>0
 . S VPRN=0 F  S VPRN=$O(@VPRX@(VPRN)) Q:VPRN<1  S VPRI=VPRI+1,@VPRY@(VPRI)=@VPRX@(VPRN)
 K @VPRX
 Q
 ;
ACTIVE ; -- find currently non-deceased, active patients
 N DFN S DFN=0
 F  S DFN=$O(^DPT(DFN)) Q:DFN<1  I '$G(^DPT(DFN,.35)) D
 . I $G(^DPT(DFN,.105)) D POST(DFN,"*") Q
 . I $O(^DPT(DFN,"S",DT)) D POST(DFN,"*")
 Q
 ;
APPTS(BEG,END,VPRY) ; -- return patients w/appointments
 N VPRX,VPRN,DFN,VPRDT,VPRI,VPRA
 S VPRY=$G(VPRY,$NA(^TMP("VPR PATS",$J))) K @VPRY
 I '$G(BEG) D   ;default = tomorrow, if not passed in
 . S BEG=$$FMADD^XLFDT(DT,1),END=BEG
 ; find patients with appointments
 S END=$G(END,BEG),VPRX(1)=BEG_";"_END
 S VPRX("SORT")="P",VPRX("FLDS")=1,VPRX(3)="R;I;NT"
 S VPRI=$$SDAPI^SDAMA301(.VPRX),VPRN=0 K VPRX
 S DFN=0 F  S DFN=$O(^TMP($J,"SDAMA301",DFN)) Q:DFN<1  S VPRX(DFN)=""
 ; find patients scheduled for admission
 S VPRDT=0 F  S VPRDT=$O(^DGS(41.1,"C",VPRDT)) Q:VPRDT<1!(VPRDT>END)  D
 . S VPRI=0 F  S VPRI=$O(^DGS(41.1,"C",VPRDT,VPRI)) Q:VPRI<1  D
 .. S VPRA=$G(^DGS(41.1,VPRI))
 .. Q:$P(VPRA,U,13)  Q:$P(VPRA,U,17)  ;cancelled or admitted
 .. S DFN=+VPRA S:DFN VPRX(DFN)=""
 ; build return array
 S (DFN,VPRN)=0
 F  S DFN=$O(VPRX(DFN)) Q:DFN<1  S VPRN=VPRN+1,@VPRY@(VPRN)=DFN
 S @VPRY@(0)=VPRN
 K ^TMP($J,"SDAMA301")
 Q
 ;
INPTS(VPRY) ; -- return current inpatients
 N DGPM,DFN,VPRN
 S VPRY=$G(VPRY,$NA(^TMP("VPR PATS",$J))),VPRN=0 K @VPRY
 S DGPM=0 F  S DGPM=$O(^DPT("ACA",DGPM)) Q:DGPM<1  D
 . S DFN=0 F  S DFN=$O(^DPT("ACA",DGPM,DFN)) Q:DFN<1  S VPRN=VPRN+1,@VPRY@(VPRN)=DFN
 S @VPRY@(0)=VPRN
 Q
