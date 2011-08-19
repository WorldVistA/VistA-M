PXRMLPHS ; SLC/PJH,PKR - Run Health Summaries from Patient List ;03/26/2007
 ;;2.0;CLINICAL REMINDERS;**4,6**;Feb 04, 2005;Build 123
 ; 
 ;External Ref DBIA #398
 ;
HSA(LISTIEN) ;Run health summary for all patients on this patient list.
 N HSIEN,PLNODE
 ;Initialise
 D FULL^VALM1
 ;Reset screen mode
 W IORESET
 ;
 ;Select Health Summary
 D HSEL(.HSIEN) Q:$D(DTOUT)!$D(DUOUT)
 ;
 S PLNODE="PXRMLPHS"_$J_$$NOW^XLFDT
 K ^XTMP(PLNODE)
 S ^XTMP(PLNODE,0)=$$FMADD^XLFDT(DT,2)_U_DT_"HSI LIST"
 D SORT(LISTIEN,PLNODE)
 D QUE(HSIEN,PLNODE)
 Q
 ;
HSEL(IEN) ;Select Health Summary Type
 N X,Y,DIC
HS1 S DIC=142,DIC(0)="QAEMZ"
 S DIC("A")="Select HEALTH SUMMARY TYPE: "
 W !
 D ^DIC
 I X="" W !,"A health summary type name must be entered" G HS1
 I X=(U_U) S DTOUT=1
 I Y=-1 S DUOUT=1
 I $D(DTOUT)!$D(DUOUT) Q
 ;Return HS ien
 S IEN=$P(Y,U)
 Q
 ;
HSI(PLNODE) ;Print health summary for selected patients.
 N HSIEN
 ;Initialise
 D FULL^VALM1
 ;Reset screen mode
 W IORESET
 ;
 ;Select Health Summary
 D HSEL(.HSIEN) Q:$D(DTOUT)!$D(DUOUT)
 D QUE(HSIEN,PLNODE)
 Q
 ;
PRINT(HSIEN,PLNODE) ;Print HS for Patient List IEN
 N DFN,DIROUT,SUB
 ;Print HS for each patient
 S SUB=0
 F  S SUB=$O(^XTMP(PLNODE,SUB)) Q:(SUB="")!$D(DIROUT)  D
 .S DFN=^XTMP(PLNODE,SUB)
 .D ENX^GMTSDVR(DFN,HSIEN,"","") ; DBIA #398
 ;
 ;Clear workfile
 K ^XTMP(PLNODE)
 Q
 ;
QUE(HSIEN,PLNODE) ;Determine whether the report should be queued.
 N PXRMQUE,%ZIS,ZTDESC,ZTRTN,ZTSK,ZTSAVE
 S %ZIS="M"
 S ZTDESC="Patient List Health Summaries - print"
 S ZTRTN="PRINT^PXRMLPHS(HSIEN,PLNODE)"
 S ZTSAVE("HSIEN")=""
 S ZTSAVE("PLNODE")=""
 S PXRMQUE=$$DEVICE^PXRMXQUE(ZTRTN,ZTDESC,.ZTSAVE,.%ZIS,1)
 S VALMBCK="R"
 Q
 ;
SORT(LISTIEN,PLNODE) ;Sort workfile as required
 N DATA,DFN,IND,PNAME
 ;Build the list in alphabetical order.
 S IND=0
 F  S IND=$O(^PXRMXP(810.5,LISTIEN,30,IND)) Q:'IND  D
 .S DATA=$G(^PXRMXP(810.5,LISTIEN,30,IND,0)) Q:DATA=""
 .S DFN=$P(DATA,U) Q:'DFN
 .;DBIA #10035
 .S PNAME=$P(^DPT(DFN,0),U,1) Q:PNAME=""
 .S ^XTMP(PLNODE,PNAME)=DFN
 Q
 ;
