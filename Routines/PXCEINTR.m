PXCEINTR ;ISL/dee - PCE List Manager call to do interview questions ;7/9/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**172**;Aug 12, 1996
 ;
 Q
 ;
GETVIEN() ;Ask the user which visit or to add a new one.
 N PXCEVIDX,PXCEVIEN
 S PXCEVIDX=$$SEL1^PXCE("",1)
 Q:PXCEVIDX="A" ""
 Q:PXCEVIDX'>0 -1
 S PXCEVIEN=$G(^TMP("PXCEIDX",$J,PXCEVIDX))
 ;Check that it is not related to a no show or canceled apppointment
 D APPCHECK^PXCESDAM(.PXCEVIEN)
 Q:'$D(PXCEVIEN) -1
 ;Cannot edit future visits
 I $P(+^AUPNVSIT(PXCEVIEN,0),".")>DT D  Q -1
 . W !!,$C(7),"Can not update future encounters."
 . D WAIT^PXCEHELP
 . K PXCEVIEN
 I $P(^AUPNVSIT(PXCEVIEN,0),"^",7)="E" D  Q -1
 . W !!,"You can not do the Checkout Interview on an Historical encounter."
 . D WAIT^PXCEHELP
 Q PXCEVIEN
 ;
INTRVIEW ;Do Interview form Encounter List.
 ; Allows the adding of new encounters.
 N PXCEVIEN
 S PXCEVIEN=$$GETVIEN
 Q:PXCEVIEN=-1
 ;
 N PXCEAPPM,PXCERET,PXCEWHAT
 S PXCEWHAT="ADDEDIT"
 I '$D(PXCEPAT) N PXCEPAT S PXCEPAT=""
 I '$D(PXCEHLOC) N PXCEHLOC S PXCEHLOC=""
 N PXREC S PXREC=0  ; PX*1.0*172 new logic added to dot structure below
 I PXCEVIEN>0 D  G:PXREC INTRVQ
 . S PXCEPAT=$P(^AUPNVSIT(PXCEVIEN,0),"^",5)
 . N PXDUZ,PXPTSSN S PXDUZ=DUZ,PXPTSSN=$P($G(^DPT(PXCEPAT,0)),U,9)
 . D SEC^PXCEEXP(.PXREC,PXDUZ,PXPTSSN)
 . I PXREC W !!,"Security regulations prohibit computer access to your own medical record." H 3 Q
 . S PXCEHLOC=$P(^AUPNVSIT(PXCEVIEN,0),"^",22)
 . I $$VSTAPPT^PXUTL1(PXCEPAT,+^AUPNVSIT(PXCEVIEN,0),$P(^(0),"^",22),PXCEVIEN) S PXCEAPPM=+^AUPNVSIT(PXCEVIEN,0),PXCEWHAT="INTV"
 S PXCERET=$$INTV^PXAPI(PXCEWHAT,"PX","PXCE DATA ENTRY",.PXCEVIEN,.PXCEHLOC,.PXCEPAT,$G(PXCEAPPM))
INTRVQ Q
 ;
SDINTRVW(PXCEWHAT) ;Do Interview form Appointment List.
 N PXCEVIEN
 N PXCEAPDT S PXCEAPDT=""
 I '$D(PXCEPAT) N PXCEPAT S PXCEPAT=""
 I '$D(PXCEHLOC) N PXCEHLOC S PXCEHLOC=""
 S PXCEVIEN=$$SELAPPM^PXCESDAM
 Q:PXCEVIEN=-1
 ; next 3 lines added per PX*1.0*172
 N PXREC,PXDUZ,PXPTSSN S PXDUZ=DUZ,PXPTSSN=$TR($G(PXCEPAT("SSN")),"-")
 D SEC^PXCEEXP(.PXREC,PXDUZ,PXPTSSN)
 I PXREC W !!,"Security regulations prohibit computer access to your own medical record." H 3 G SDINTRVQ
 I 'PXCEVIEN D
 . I PXCEWHAT'="INTV",PXCEWHAT'="ADQ" D
 .. W $C(7),!,"There is no Encounter for this Appointment."
 .. D WAIT^PXCEHELP
 .. K PXCEVIEN
 . E  S PXCEVIEN=""
 I '$D(PXCEVIEN) G SDINTRVQ
 N PXCERET
 S PXCERET=$$INTV^PXAPI(PXCEWHAT,"PX","PXCE DATA ENTRY",.PXCEVIEN,.PXCEHLOC,.PXCEPAT,PXCEAPDT)
SDINTRVQ Q
 ;
UPDATENC ;From the Update Encounter Screen
 I $P(^AUPNVSIT(PXCEVIEN,0),"^",7)="E" D  Q
 . W !!,"You can not do the Checkout Interview on an Historical encounter."
 . D WAIT^PXCEHELP
 D FULL^VALM1
 I $$INTV^PXAPI($S($$VSTAPPT^PXUTL1(PXCEPAT,+^AUPNVSIT(PXCEVIEN,0),+$G(PXCEHLOC),PXCEVIEN):"INTV",1:"ADDEDIT"),"PX","PXCE DATA ENTRY",PXCEVIEN,PXCEHLOC,PXCEPAT)
 Q
 ;
