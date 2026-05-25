RACTCERN ;WOIFO/KLM - Standard Procedures Activation ; Jun 25, 2025@13:39
 ;;5.0;Radiology/Nuclear Medicine;**226**;Mar 16, 1998;Build 2
 ;
 ; Activate Cerner/Oracle standard procedures
 ;
EN1 ;Entry
 N RASEL,RAY,RACT
 ;Activate or Inactivate?
 N DIR,Y S DIR(0)="SO^1:Activate;2:Inactivate"
 S DIR("A")="Activate or Inactivate the new standard procedures?"
 D ^DIR Q:$D(DIRUT)  S RACT=+Y_U_$G(Y(0)) K DIRUT
 ; Next ask how they want to activate (one-at-a-time or what?)
 N DIR,Y S DIR(0)="SO^1:Choose Individual Procedures;2:By Modality;3:All"
 S DIR("A")="How do you want to "_$S(+RACT=1:"activate",1:"inactivate")_" the new Oracle/Cerner standard procedures?"
 D ^DIR Q:$D(DIRUT)  S RASEL=+Y_U_$G(Y(0)) K DIRUT
 D:+RASEL=1 1 D:+RASEL=2 2 D:+RASEL=3 3
 ;
 ;
 Q
1 ;Select individual procedures to activate
 K ^TMP($J,"RAPROCS")
 N RADATA S RADATA="RAPROCS"
 S RADIC="^RAMIS(71,",RADIC(0)="QEAMZ",RADIC("A")="Select Procedures(s): "
 S:+RACT=1 RADIC("S")="I $P($G(^RAMIS(71,+Y,0)),U,8)=""Y"",($P($G(^RAMIS(71,+Y,""I"")),U))]"""""
 S:+RACT=2 RADIC("S")="I $P($G(^RAMIS(71,+Y,0)),U,8)=""Y"",($P($G(^RAMIS(71,+Y,""I"")),U))="""""
 W ! D EN1^RASELCT(.RADIC,RADATA)
 K DIC,RADIC,RADATA
 N RAPR,RAIEN,RAERR,RAIENS,RAFDA
 W !!
 S RAPR="" F  S RAPR=$O(^TMP($J,"RAPROCS",RAPR)) Q:RAPR=""  D
 .S RAIEN=0 F  S RAIEN=$O(^TMP($J,"RAPROCS",RAPR,RAIEN)) Q:RAIEN=""  D
 ..I +RACT=1,(($G(^RAMIS(71,RAIEN,"I"))="")!($G(^RAMIS(71,RAIEN,"I"))>DT)) Q  ;already active
 ..I +RACT=2,($G(^RAMIS(71,RAIEN,"I"))]"")&($G(^RAMIS(71,RAIEN,"I"))<$$FMADD^XLFDT(DT,+1)) Q  ;already inactive
 ..S RAIENS=RAIEN_",",RAY=RAIEN
 ..K RAERR
 ..S:+RACT=1 RAFDA(71,RAIENS,100)="@" ;Remove inactive date
 ..S:+RACT=2 RAFDA(71,RAIENS,100)=$$FMADD^XLFDT(DT,-1) ;Set inactive date (T-1)
 ..D UPDATE^DIE("","RAFDA","RAIEN","RAERR")
 ..W:$D(RAERR(1,"DIERR"))#2 "There was an issue "_$S(+RACT=1:"activating",1:"inactivating")_" the procedure "_RAPR
 ..W:'$D(RAERR(1,"DIERR"))#2 RAPR_$S(+RACT=1:" Activated!",1:" Inactivated!"),!
 ..D OI
 ..Q
 .Q
 K ^TMP($J,"RAPROCS")
 Q
 ;
2 ;Select all procedures for modality to activate
 N RARY,RAPR,RAIEN,RAMOD,RAERR,RAIENS,RAFDA
 N DIR,Y S DIR(0)="PO^79.2:EMZ",DIR("A")="Select an Imaging Type to "_$S(+RACT=1:"activate",1:"inactivate")
 D ^DIR Q:$D(DIRUT)  S RAMOD=$G(Y) K DIRUT
 W !!
 S RAIEN=0 F  S RAIEN=$O(^RAMIS(71,"AIMG",+RAMOD,RAIEN)) Q:RAIEN=""  D
 .S RA71=$G(^RAMIS(71,RAIEN,0)) Q:$P(RA71,U,8)'="Y"
 .I +RACT=1,(($G(^RAMIS(71,RAIEN,"I"))="")!($G(^RAMIS(71,RAIEN,"I"))>DT)) Q  ;already active
 .I +RACT=2,($G(^RAMIS(71,RAIEN,"I"))]"")&($G(^RAMIS(71,RAIEN,"I"))<$$FMADD^XLFDT(DT,+1)) Q  ;already inactive
 .S RAIENS=RAIEN_",",RAY=RAIEN,RAPR=$P(RA71,U)
 .K RAERR
 .S:+RACT=1 RAFDA(71,RAIENS,100)="@" ;remove inactive date
 .S:+RACT=2 RAFDA(71,RAIENS,100)=$$FMADD^XLFDT(DT,-1) ;Set inactive date (T-1)
 .D UPDATE^DIE("","RAFDA","RAIEN","RAERR")
 .W:$D(RAERR(1,"DIERR"))#2 "There was an issue "_$S(+RACT=1:"activating",1:"inactivating")_" the procedure "_$G(RAPR)
 .W:'$D(RAERR(1,"DIERR"))#2 RAPR_$S(+RACT=1:" Activated!",1:" Inactivated!"),!
 .D OI
 .Q
 Q
3 ;Select All procedures (let er rip) - need to fix
 N RAIEN,RAPR,RAERR,RA71,RAIENS,RAFDA,DIRUT
 W !!
 N DIR,Y S DIR(0)="YO",DIR("A")="Are you sure you want to "_$S(+RACT=1:"activate",1:"inactivate")_" ALL of the Oracle/Cerner procedures"
 D ^DIR Q:$D(DIRUT)  I Y'=1 W !!,"OK, see you later..." Q
 K DIRUT,Y
 ; Get all new standard procedures to activate
 W !!
 ;
 S RAIEN=0 F  S RAIEN=$O(^RAMIS(71,RAIEN)) Q:RAIEN=""  D
 .S RA71=$G(^RAMIS(71,RAIEN,0)) Q:$P(RA71,U,8)'="Y"  ;Standard procedures only
 .S RAPR=$P(RA71,U) Q:$G(RAPR)=""
 .I +RACT=1,(($G(^RAMIS(71,RAIEN,"I"))="")!($G(^RAMIS(71,RAIEN,"I"))>DT)) Q  ;already active
 .I +RACT=2,($G(^RAMIS(71,RAIEN,"I"))]"")&($G(^RAMIS(71,RAIEN,"I"))<$$FMADD^XLFDT(DT,+1)) Q  ;already inactive
 .S RAIENS=RAIEN_",",RAY=RAIEN
 .K RAERR
 .S:+RACT=1 RAFDA(71,RAIENS,100)="@" ;remove inactive date
 .S:+RACT=2 RAFDA(71,RAIENS,100)=$$FMADD^XLFDT(DT,-1) ;Set inactive date (T-1)
 .D UPDATE^DIE("","RAFDA","RAIEN","RAERR")
 .W:$D(RAERR(1,"DIERR"))#2 "There was an issue "_$S(+RACT=1:"activating",1:"inactivating")_" the procedure "_$G(RAPR)
 .W:'$D(RAERR(1,"DIERR"))#2 RAPR_$S(+RACT=1:" Activated!",1:" Inactivated!"),!
 .D OI
 .Q
 Q
OI ;Update Orderable Item
 N RAENALL,RAFILE,RASTAT
 S RAENALL=0,RAFILE=71,RASTAT=1,RAY=RAY_"^"_RAPR_"^"_1
 D PROC^RAO7MFN(RAENALL,RAFILE,RASTAT,RAY)
 Q
