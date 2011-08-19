PXKCO ;ISL/JVS,ESW - Provider-Dx-CPT-VSIT at check-out ; 11/20/02 4:43pm
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**28,41,96**;Aug 12, 1996
 ;Routine-set varibles-Check-out
 ; VARIABLE LIST
 ;
 ; PXKAFT   = After picture of the encounter provider entry
 ; PXKBEF   = Before picture of the encounter provider entry
 ; PXKDFN   = The DFN of the patient(IEN in file 2 or 9000001)
 ; PXKNODA,PXKNODB = Before and After Enounter NODE
 ; PXKPR,PXKAPR,PXKBPR = PROVIDER IEN in VA(200
 ; PXKREF   = Reference to the temp global
 ; PXKSOR   = Source of data(CO,EF,WS,DE)
 ; PXKOE    = outpatient encounter IEN in SCE
 ; PXKOA    = Operating/attending(e.g "O" or "A")
 ; PXKORG   = Orginating process
 ; PXKPRI   = IFN of OUTPATIENT PROVIDER (#409.44) file entry
 ; PXKPS,PXKAPS = primary/secondary(e.g. "P" or "S")
 ; PXKVDT   = Visit date and time in fileman format
 ; PXKVST   = Encounter equavalent visit IEN in VISIT file
 ;
 W !,"This is NOT an entry point!!" Q
 ;
EN1 ;Pims Check-out entry point
 N VSIT
 I '$D(SDHDL) Q
 ;
EN ;---ENTRY POINT
 N PXKREF,PXKORG,STOP,PXKOE
 S PXKREF="^TMP(""SDEVT"",$J,SDHDL)",STOP=0
 ;
 ; -- SDHDL is the current process
 ;    It's always defined.
 ;
 S PXKORG=0
 F  S PXKORG=$O(@PXKREF@(PXKORG)) S:"1234"'[PXKORG STOP=1  Q:STOP=1  Q:'PXKORG  D
 .Q:STOP=1
 .N PXKNODB,PXKNODA
 .S PXKOE=0 F  S PXKOE=$O(@PXKREF@(PXKORG,"SDOE",PXKOE)) Q:'PXKOE  D
 ..K VSIT
 ..N NODE,NODE0,PXKDIV
 ..S PXKNODB=$G(@PXKREF@(PXKORG,"SDOE",PXKOE,0,"BEFORE"))
 ..S PXKNODA=$G(@PXKREF@(PXKORG,"SDOE",PXKOE,0,"AFTER"))
 ..S VSIT("IENB")=$P(PXKNODB,"^",5) ;BEFORE IEN
 ..S VSIT("IEN")=$P(PXKNODA,"^",5) ;VISIT IEN
 ..Q:$G(VSIT("IEN"))<1
 ..;
 ..S NODE0=$G(^AUPNVSIT(VSIT("IEN"),0))
 ..S NODE=$G(^AUPNVSIT(VSIT("IEN"),150))
 ..Q:NODE0=""
 ..;
 ..;gathering the changed data elements
 ..I $P(NODE0,U,21)'=$P(PXKNODA,U,13) S VSIT("ELG")=$P(PXKNODA,"^",13) ;ELIGIBILITY
 ..I $P(PXKNODB,U,3)'=$P(PXKNODA,U,3) S VSIT("DSS")=$P(PXKNODA,"^",3) ;CLINIC STOP CODE
 ..I $P(PXKNODB,U,11)'=$P(PXKNODA,U,11) S PXKDIV=$P($G(PXKNODA),"^",11) ;DIVISION
 ..I $D(PXKDIV) S VSIT("INS")=$S(+$P(NODE0,U,6)>0:$P(NODE0,U,6),+PXKDIV>0:$P($G(^DG(40.8,+PXKDIV,0)),"^",7),1:"") ;INSTITUTION; PX/96 - accept INSTITUTION if passed to PCE.
 ..;
 ..I '$D(VSIT("ELG")),'$D(VSIT("DSS")),'$D(VSIT("INS")) Q
 ..;
 ..;check for necessary changes to SVC and PRI
 ..I ($D(VSIT("DSS"))),($P(PXKNODA,U,8)'=4),(NODE]"") DO
 ...S VSIT("SVC")=$$SVC("A",VSIT("DSS"),$P(NODE,U,2),$P(PXKNODA,U,4))
 ...S VSIT("PRI")=$$PRI($P(NODE,U,3),VSIT("DSS"))
 ..;
 ..D UPD^VSIT
 ..K VSIT
 Q
 ;
SVC(SVC,DSS,PXKIO,LOC) ;
 ;This tag performs the same tests for the Service Catagory that are in
 ;the visit tracking routine VSITDEF.  This has been added as part of
 ;patch SD*5.3*66
 ;INPUTS  SVC - The service category to start with.
 ;        DSS - The Clinic stop code or DSS Identifier.
 ;      PXKIO - The Patient status.
 ;        LOC - The location of the visit.
 ;
 ;OUTPUT  SVC - The service category need based upon DSS and PXKIO
 ;
 I SVC="E" G SVCQ
 I $P(^DIC(40.7,+DSS,0),"^",1)["TELE" S SVC="T" G SVCQ ;any TELEphone
 I $O(^VSIT(150.1,"B",$P(^DIC(40.7,+DSS,0),"^",2),0)) S SVC="X"
 I SVC="",+DSS=$P($G(^SC(+LOC,0)),"^",7) S SVC="A"
 I SVC="" S SVC="X"
 I PXKIO S SVC=$S(SVC="A":"I",SVC="X":"D",1:SVC)
 E  S SVC=$S(SVC="I":"A",SVC="D":"X",1:SVC)
SVCQ Q SVC
 ;
PRI(PRI,DSS) ;
 ;This tag performs the same checks for the encounter type as in VSITDEF
 ;It has been added as part of SD*5.3*66
 ;INPUT  PRI - Encounter type
 ;       DSS - The Clinic stop code or DSS ID.
 ;
 ;OUTPUT PRI - The Encounter type based upon DSS
 ;
 I PRI="P",$O(^VSIT(150.1,"B",+$P($G(^DIC(40.7,+DSS,0)),"^",2),0)) S PRI="O"
 E  I PRI="O",'$O(^VSIT(150.1,"B",+$P($G(^DIC(40.7,+DSS,0)),"^",2),0)) S PRI="P"
 Q PRI
