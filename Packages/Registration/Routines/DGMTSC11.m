DGMTSC11 ;ALB/RMO - Means Test Screen Marital Status/Dependent Cont. ; 25 JAN 92
 ;;5.3;Registration;**25,45,688**;Aug 13, 1993;Build 29
 ;
EDTV1(MTVER) ;Edit dependent child data (new entry point)
 ;
 ; MTVER : Means Test Version (Optional)
 ;           Null or 0 - Version 0
 ;                   1 - Version 1
 ;
 S V1ENT=1 ;* MTVER was NEWed
 S:('$D(MTVER)) MTVER=0  ;*No value for MTVER was received
EDT ; Old Entry point for existing integrations - Edit dependent child data
 S EDTSET=0  ;* If MTVER exists it was defined in the partition and should not be KILLed
 ;
 ;* If MTVER is defined ($G value is 0 or 1) do not reset MTVER or KILL MTVER
 ;* If MTVER is not defined ($G Value is 0 because undefined); old version, KILL MTVER
 I (+$G(MTVER)<1),'$D(MTVER) S MTVER=0 S EDTSET=1
 N DA,DGERR,DGFIN,DGINI,DGIRI,DIE,DR
 D GETIENS^DGMTU2(DFN,+DGPRI,DGMTDT) G EDTQ:DGERR
 S DA=DGIRI,DIE="^DGMT(408.22,"
 S:(+MTVER<1) DR="[DGMT ENTER/EDIT DEPENDENTS]"
 S:(+MTVER=1) DR="[DGMT V1 ENTER/EDIT DEPENDENTS]"
 D ^DIE
 S:'$D(DGFIN) DGFL=$S($D(DTOUT):-2,$D(DUOUT):-1,($D(Y))=10:-1,1:0)
 ;
 ;* If MTVER was not defined because entry point for old version, KILL MTVER
 ;* If MTVER defined by calling version 1 entry point, do not KILL (NEW values will be KILLed)
 I EDTSET,'$D(V1ENT) K MTVER
 K EDTSET,V1ENT
EDTQ Q
