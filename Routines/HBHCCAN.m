HBHCCAN ; LR VAMC(IRMS)/MJT-HBHC batch job to flag deleted outpatient encounters as cancelled appointments in ^HBHC(632) (visit) Form 4 Transmit Status, field 7, & Cancelled Appointment, field 6, called from ^HBHCAPPT ;9803
 ;;1.0;HOSPITAL BASED HOME CARE;**6,10**;NOV 01, 1993
 ; Also deletes record from ^HBHC(634 (transmit) file IF Form 4 Transmit Status, field 7, = "F" (filed)
START ; Initialization
 S $P(HBHCSP1," ",2)="",$P(HBHCZRO4,"0",5)=""
 ; HBHCBGDT set in ^HBHCAPPT
 S HBHCAPDT=HBHCBGDT
LOOP ; Loop thru ^HBHC(632) to flag visit nodes with cancelled appointments
 F  S HBHCAPDT=$O(^HBHC(632,"C",HBHCAPDT)) Q:(HBHCAPDT'>0)!(HBHCAPDT>HBHCLSDT)  S HBHCDFN=0 F  S HBHCDFN=$O(^HBHC(632,"C",HBHCAPDT,HBHCDFN)) Q:HBHCDFN'>0  D PROCESS
EXIT ; Exit module
 K DA,DIE,DIK,DR,HBHCAPDT,HBHCDATE,HBHCDFN,HBHCIEN,HBHCINFO,HBHCNOD0,HBHCPRV,HBHCREC,HBHCSP1,HBHCTIME,HBHCZRO4,X,Y,%DT
 Q
PROCESS ; Process outpatient encounters in SCE(409.68
 S HBHCNOD0=^HBHC(632,HBHCDFN,0)
 ; Cancelled appointment
 Q:($P(HBHCNOD0,U,7)]"")!($P(HBHCNOD0,U,8)="C")
 ; Set Cancelled Appointment (fld 6) & Form 4 Transmit Status (fld 7) to C (cancelled appointment) if outpatient encounter (OE) no longer exists, retaining obsolete data elements (e.g. OE, Dx, provider, CPT) for trouble-shooting purposes
 I $G(^SCE($P(HBHCNOD0,U,22),0))="" D:$P(HBHCNOD0,U,8)="F" DELETE S DIE="^HBHC(632,",DA=HBHCDFN,DR="6///C;7///C" D ^DIE
 Q
DELETE ; Delete ^HBHC(634 file record
 S HBHCTIME=$P(HBHCAPDT,".",2) S:$L(HBHCTIME)'=4 HBHCTIME=HBHCTIME_$E(HBHCZRO4,1,(4-($L(HBHCTIME))))
 S HBHCDATE=$E(HBHCAPDT,4,5)_$E(HBHCAPDT,6,7)_(1700+$E(HBHCAPDT,1,3))_HBHCTIME
 S HBHCPRV=+^HBHC(631.4,$P(HBHCNOD0,U,4),0) S:$L(HBHCPRV)'=4 HBHCPRV=HBHCPRV_HBHCSP1
 S HBHCINFO=$P(^DPT($P(HBHCNOD0,U),0),U,9)_HBHCDATE_HBHCPRV
 S HBHCIEN=0 F  S HBHCIEN=$O(^HBHC(634,HBHCIEN)) Q:HBHCIEN'>0  S HBHCREC=$E(^HBHC(634,HBHCIEN,0),9,33) I HBHCINFO=HBHCREC K DIK S DIK="^HBHC(634,",DA=HBHCIEN D ^DIK
 Q
