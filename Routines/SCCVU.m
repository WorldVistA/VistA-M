SCCVU ;ALB/RMO,TMP - Encounter Conversion Utilities; [ 08/02/95  10:15 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
INACT(SCDT) ; -- Check if encounter is "inactive"
 ;An inactive encounter is "an encounter which occurred prior
 ;to the beginning of the last fiscal year" 
 ; Input  -- SCDT     Date
 ; Output -- 1=Yes and 0=No
 N X,X1,X2
 S X1=($E(DT,1,3)-$S($E(DT,4,5)>9:1,1:2))_"1001",X2=-1 D C^%DTC
 Q $S(SCDT>X:0,1:1)
 ;
CON(SCOE) ; -- Check if encounter has already been converted
 ; Input  -- SCOE     Outpatient encounter IEN
 ; Output -- 1=Yes and 0=No
 N SCOE0,SCORG,Y
 S SCOE0=$G(^SCE(+SCOE,0)),SCORG=+$P(SCOE0,U,8)
 I SCORG=1 D  ;appointment
 . S Y=+$P($G(^DPT(+$P(SCOE0,U,2),"S",+SCOE0,0)),U,23)
 I SCORG=2 D  ;add/edit
 . S Y=+$P($G(^SDV($$SDVIEN(+$P(SCOE0,U,2),+SCOE0),"CS",+$P(SCOE0,U,9),0)),U,9)
 I SCORG=3 D  ;disposition
 . S Y=+$P($G(^DPT(+$P(SCOE0,U,2),"DIS",9999999-SCOE0,0)),U,19)
 Q +$G(Y)
 ;
PAUSE ;
 N DIR
 W ! S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR W !
 Q
 ;
CCREATE(SCOE) ; Check if encounter or its visit was created by the conversion
 ;  routines
 ; SCOE = ien of the encounter
 ; RETURNS: 
 ;     0 if neither the encounter nor the visit were created by the
 ;       conversion
 ;     1 if the encounter and visit were created by the conversion
 ;     2 if the visit only was created by the conversion
 ;
 N SCCVNV,STAT
 ;
 S STAT=0
 ; In encounter, if conversion completed flag is set, the visit had to
 ;  have been created by the conversion routines
 S SCCVNV=$G(^SCE(SCOE,"CNV"))
 I +SCCVNV,$P(SCCVNV,U,4) S STAT=1 ; encounter created and completed
 I 'SCCVNV,$P(SCCVNV,U,4) S STAT=2 ; encounter not created, but completed
 Q STAT
 ;
OK(SCMODE) ; -- is it ok to allow conversion and re-conversion (for testing)
 ;  input:      SCMODE := 1 - interactive | 0 - silent
 ;
 N SCOK
 S SCOK=1  ; <<-- set this flag to 1 allow all functionality, 0 otherwise
 IF SCMODE,SCOK=0 D
 . W !!,"Conversion functionality is disabled." D PAUSE
 Q +$G(SCOK)
 ;
SDVIEN(DFN,DATE) ; -- get sdv ien for patient/date-time
 Q +$G(^SDV("ADT",+DFN,+$P(DATE,".")))
 ;
ENDDATE() ; -- conversion end date
 N Y
 S Y=$$FMDATE^SCDXUTL()
 IF Y S Y=$$FMADD^XLFDT(Y,-1)
 IF 'Y S Y=2960930
 Q Y
 ;
