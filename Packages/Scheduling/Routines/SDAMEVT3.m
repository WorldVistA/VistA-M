SDAMEVT3 ;ALB/CAW - Disposition Event Driver Utilities ; 11/2/00 8:40am
 ;;5.3;Scheduling;**15,217**;Aug 13, 1993
 ;
BEFORE(DFN,SDDT,SDEVT,SDHDL) ;
 D CAPTURE("BEFORE",.DFN,.SDDT,.SDEVT,.SDHDL)
 Q
 ;
AFTER(DFN,SDDT,SDEVT,SDHDL) ;
 N SDDA,SDIS,DA,DR,DE,DQ,DIV,DIE,SDVSIT,SDINS,SDIV,X
 ;
 S SDIS=$G(^DPT(DFN,"DIS",9999999-SDDT,0))
 ; -- is the disposition good for opc credit?
 I ($P(SDIS,U,2)=0!($P(SDIS,U,2)=1)),$P(SDIS,U,6),'$P($G(^SCE(+$P(SDIS,U,18),0)),U,7) D
 .I SDEVT=9 W !!,*7,">>> This Disposition must be checked out."
 .D RESET(DFN,9999999-SDDT,SDHDL)
 .I $P(SDIS,U,18) D EN^SDCODEL($P(SDIS,U,18),1,SDHDL)
 ;
 ; -- is the disposition 'still' good for opc credit?
 I $P(SDIS,U,2)'=0,$P(SDIS,U,2)'=1,$P(SDIS,U,18) D
 .I '$$ASK D RESET(DFN,9999999-SDDT,SDHDL) Q
 .D EN^SDCODEL($P(SDIS,U,18),1,SDHDL)
 ;
 ; -- capture 'after' data
 D CAPTURE("AFTER",.DFN,.SDDT,.SDEVT,.SDHDL)
 ;
 ; -- has division changed
 I $P(^TMP("SDEVT",$J,SDHDL,3,"DIS",0,"BEFORE"),U,4)'=$P(^("AFTER"),U,4) S X=^("AFTER") I $P(X,U,18) S SDIV=$P(X,U,4),SDOE=$P(X,U,18) D  Q
 .;
 .;-- is a new visit entry needed
 .I $P($G(^AUPNVSIT(+$P($G(^SCE(SDOE,0)),U,5),0)),U,6) S SDINS=$P(^(0),U,6) I SDINS'=$P($G(^DG(40.8,SDIV,0)),U,7) D
 ..D ARRAY^SDVSIT(DFN,SDDT,.SDDA,.SDIS,.SDVSIT)
 ..D VISIT^SDVSIT0(.SDDT,.SDVSIT)
 ..I SDVSIT("VST") S DIE="^SCE(",DR=".05////"_SDVSIT("VST"),DA=SDOE D ^DIE
 ..D OE^SDAMEVT("AFTER",3,SDOE,SDHDL)
 ; If division has not changed AND patient has an Outpatient Encounter
 ; display Hospital Disposition Location
 S X=$G(^TMP("SDEVT",$J,SDHDL,3,"DIS",0,"AFTER")) I $P(X,U,18) S SDIV=$P(X,U,4),SDOE=$P(X,U,18) D
 .N PREVST,DIC,DA,DR,DIQ,DHL,Y,OK
 .S OK=0
 .S DIC="409.68",DR=".05",DA=SDOE,DIQ="PREVST(",DIQ(0)="I" D EN^DIQ1
 .F  D  Q:OK=1  ; Get Disposition Hospital Location
 ..S PREVST(0)=$G(PREVST("409.68",SDOE,".05","I"))
 ..S DIC=9000010,DA=PREVST(0),DR=".22",DIQ="DHL(",DIQ(0)="EI" D EN^DIQ1
 ..; Ask for Hospital location from those that can disposition
 ..S DA(1)=1,DIC="^PX(815,1,""DHL"",",DIC("P")=$P(^DD(815,401,0),"^",2)
 ..S DIC("B")=$G(DHL(9000010,PREVST(0),".22","E")) ; DHLocation
 ..S DIC(0)="AEOQ" D ^DIC
 ..I Y<0 W !!,$C(7),"Disposition Hospital Location is required." Q
 ..S DR=".22////"_$P(Y,"^",2),DIE=9000010,DA=PREVST(0)
 ..D ^DIE
 ..S OK=1
 Q
 ;
RESET(DFN,SDIDT,SDHDL) ;Reset Disposition Status
 N DA,DE,DQ,DIE,DR,SDOSTA
 S SDOSTA=$P($G(^TMP("SDEVT",$J,SDHDL,3,"DIS",0,"BEFORE")),"^",2)
 I $G(SDOSTA)]"" D
 .W !!,">>> Changing status back to ",$P($P(^DD(2.101,1,0),SDOSTA_":",2),";"),"..."
 .S DA=SDIDT,DA(1)=DFN,DR="1////"_SDOSTA
 .S DIE="^DPT("_DFN_",""DIS""," D ^DIE
 .W "done"
 Q
 ;
ASK() ;Ask if user is sure they want to change the disposition status
 N DIR,DTOUT,DUOUT,Y
 W !!,*7,">>> Changing the status of this disposition will delete any check out",!?4,"related information.  This information may include add/edits,",!?4,"classifications, providers and diagnoses."
 S DIR("A")="Are you sure you want to change the status"
 S DIR("B")="NO",DIR(0)="Y" W ! D ^DIR
 Q +$G(Y)
 ;
CAPTURE(SDCAP,DFN,SDDT,SDEVT,SDHDL) ;
 N SDDA,Z
 S SDDA=9999999-SDDT
 S (Z,^TMP("SDEVT",$J,SDHDL,3,"DIS",0,SDCAP))=$G(^DPT(DFN,"DIS",SDDA,0))
 D:$P(Z,U,18) OE^SDAMEVT(SDCAP,3,+$P(Z,U,18),SDHDL)
 Q
 ;
EVT(DFN,SDDT,SDEVT,SDHDL) ;
 D AFTER(.DFN,.SDDT,.SDEVT,SDHDL)
 D EVTGO^SDAMEVT2
 Q
