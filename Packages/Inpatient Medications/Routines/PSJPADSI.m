PSJPADSI ;BIR/JCH PADE INBOUND SYSTEM SET UP ;8/25/15
 ;;5.0;INPATIENT MEDICATIONS;**317,337**;16 DEC 97;Build 9
 ;
 ; Reference to EDIT^XPAREDIT is supported by DBIA 2336.
 ; Reference to WIN^DGPMDDCF is supported by DBIA 1246.
 ; Reference to INP^VADPT is supported by DBIA 10061.
 ; Reference to ^DDIOL is supported by DBIA 10142.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^DIC(42 is supported by DBIA 10039.
 ; Reference to ^SC( is supported by DBIA 10040.
 ; Reference to NOW^XLFDT is supported by DBIA 10153.
 ;
 Q
 ;
ENCAB ; Setup Cabinet device in file 58.63
 N PSJPADQ
 F  Q:$G(PSJPADQ)!$G(DUOUT)!$G(DTOUT)  D PADEV
 Q
 ;
PADEV ;enter/edit PADE devices and VistA locations
 N DR,DA,DIC,DIE,X,Y,PSJPSYS,PSJPDEV,PADAR,DEVDA W !
 S PSJPSYS=""
 W ! D GETFILD(PSJPSYS,.DEVDA)
 I '$G(DEVDA) S PSJPADQ=1 Q
 I $G(DEVDA) D
 .I $G(DUOUT)!($G(DTOUT))!$G(PSJPADQ) K DUOUT,DTOUT Q
 .S DIE="^PS(58.63,",DA=+DEVDA,DR="[PSJ PADE DISPENSING DEVICE]" W ! D ^DIE
 .Q:'$G(DA)!$G(DUOUT)!$G(DTOUT)  N PSJPDEV S PSJPDEV=DA
 K DIE,DIC
 Q
 ;
GETFILD(PSJPSYS,DEVIEN) ; Get Device if it exists, or File Device if not
 N PSJDIV,D K DEVIEN,LAYGO S DEVIEN=""
 N DR,DIR,ERR,DEV,RESULT,TOT,RANGE,DEVPRMPT,PAD,PSJPNAM
 W ! S DIC="^PS(58.63,",DIC(0)="EALNMV",LAYGO="58.63",DR="1"
 S DR=1,DLAYGO=LAYGO
 D ^DIC K DIC I Y>0 S DEVIEN=+Y
 I Y<0 D DELBADSY^PSJPDRU1  ; If user aborted new device entry, may have left "?BAD" entry in 58.601 file due to invalid uniqueness key
 I $G(DEVIEN),$G(PSJPSYS) D
 .N FDA S FDA(58.63,DA,1)=PSJPSYS
 .S FDA(58.63,DA,12)=$$UPPER^PSJPDRUT($P($G(^PS(58.63,+DEVIEN,0)),"^"))
 .D FILE^DIE("","FDA","RESULT")
 Q
 ;
ENSYS ; Setup PADE Inbound System in file 58.601
 N PSJPADQ
 F  Q:$G(PSJPADQ)!$G(DUOUT)!$G(DTOUT)  D PADESYS
 Q
 ;
PADESYS ;enter/edit PADE inventory system
 N DR,DA,DIC,DIE,X,Y,PSJPSYS,PSJPDEV,PADAR,DEVDA,PSJPSNM,DLAYGO,PSJASKDN W !
 S Y=$$ENSYS^PSJPDRUT
 Q:$G(DUOUT)!$G(DTOUT)
 I Y<1 S PSJPADQ=1 Q
 S (DA,PSJPSYS)=+Y
 S DIE="^PS(58.601,",DR="[PSJ PADE INVENTORY]" D ^DIE
 S PSJPSNM=$P($G(^PS(58.601,+$G(PSJPSYS),0)),"^")
 I PSJPSNM=""!($G(PSJASKDN)=3) S PSJPADQ=1 Q
 F  Q:$G(PSJPADQ)!$G(DUOUT)!$G(DTOUT)  D GETDEV(PSJPSYS,.DEVDA) I $G(DEVDA) D
 .I $G(DUOUT)!($G(DTOUT))!$G(PSJPADQ) K DUOUT,DTOUT Q
 .N DIE,DA,DR,X,Y
 .S DIE="^PS(58.63,",DA=+DEVDA,DR="[PSJ PADE DISPENSING DEVICE]" W ! D ^DIE
 .W !! S DIR(0)="FO",DIR("A")="Press return to continue" D ^DIR Q
 K DIE,DIC,DTOUT,DUOUT,PSJPADQ
 Q
 ;
GETDEV(PSJPSYS,DEVIEN) ; Get device ien
 N PSJDIV K DEVIEN S DEVIEN=""
 N DIR,ERR,DEV,RESULT,TOT,RANGE,DEVPRMPT,PAD,PSJPNAM
 W ! S DIC="^PS(58.63,",DIC(0)="EAMV"
 D ^DIC K DIC I Y>0 S DEVIEN=+Y
 I $G(DEVIEN),$G(PSJPSYS) D
 .N FDA S FDA(58.63,DEVIEN_",",1)=PSJPSYS
 .S FDA(58.63,DEVIEN_",",12)=$$UPPER^PSJPDRUT($P($G(^PS(58.63,+DEVIEN,0)),"^"))
 .D FILE^DIE("","FDA","RESULT")
 S:'$G(DEVIEN)>0 PSJPADQ=1
 Q
 ;
WARDSCR(Y) ; Ward Location Y must be associated with division PSJDIV in PADE inbound system DA(3)
 N D0,X
 S D0=+Y D WIN^DGPMDDCF Q:$G(X) 1
 I $P(^DIC(42,D0,0),U,11)=$G(^PS(58.601,DA(3),"DIV",DA(2),0)) Q 1
 Q 0
 ;
WARDSCR2(Y,DDEV) ; Ward Location Y must be associated with division PSJDIV in PADE inbound system DA(3)
 N D0,X,DIV
 S D0=+Y
 Q:'$G(DDEV) 0
 S DIV=$P($G(^PS(58.63,+DDEV,2)),"^")
 Q:'DIV 0
 I $P(^DIC(42,D0,0),U,11)=DIV Q 1
 Q 0
 ;
CLCHK(QZ) ; Clinic Location QZ must be associated with division PSJDIV in PADE inbound system DA(3)
 N PSJDIV S PSJDIV=$G(^PS(58.601,DA(3),"DIV",DA(2),0))
 I $P(^SC(QZ,0),U,3)'="C" Q 0
 I $P(^SC(QZ,0),U,15)'=PSJDIV Q 0
 Q 1
 ;
CLCHK2(QZ,DDEV) ; Clinic Location QZ must be associated with division PSJDIV in PADE inbound system DA(3)
 N PSJDIV
 Q:'$G(DDEV) 0
 S PSJDIV=$P($G(^PS(58.63,+DDEV,2)),"^")
 Q:'PSJDIV 0
 I $P(^SC(QZ,0),U,3)'="C" Q 0
 I $P(^SC(QZ,0),U,15)'=PSJDIV Q 0
 Q 1
 ;
CGCHK(QZ) ; Clinic Group QZ must have at least one clinic associated with division PSJDIV in PADE inbound system DA(3)
 N PSJDIV,CL,CLIEN,GOTONE S PSJDIV=$G(^PS(58.601,DA(3),"DIV",DA(2),0))
 S GOTONE=0
 S CL=0 F  Q:$G(GOTONE)  S CL=$O(^PS(57.8,+QZ,1,CL)) Q:'CL  D
 .S CLIEN=+$G(^PS(57.8,+QZ,1,CL,0))
 .I $P(^SC(CLIEN,0),U,15)=PSJDIV S GOTONE=1
 Q:GOTONE 1
 Q 0
 ;
CGCHK2(QZ,DDEV) ; Clinic Group QZ must have at least one clinic associated with division PSJDIV in PADE inbound system DA(3)
 N PSJDIV,CL,CLIEN,GOTONE
 Q:'$G(DDEV) 0
 S PSJDIV=$P($G(^PS(58.63,+DDEV,2)),"^")
 Q:'PSJDIV 0
 S GOTONE=0
 S CL=0 F  Q:$G(GOTONE)  S CL=$O(^PS(57.8,+QZ,1,CL)) Q:'CL  D
 .S CLIEN=+$G(^PS(57.8,+QZ,1,CL,0))
 .I $P(^SC(CLIEN,0),U,15)=PSJDIV S GOTONE=1
 Q:GOTONE 1
 Q 0
 ;
WGCHK(QZ) ; Ward Group QZ must have at least one ward associated with division PSJDIV in PADE inbound system DA(3)
 N PSJDIV,WD,WDIEN,GOTONE S PSJDIV=$G(^PS(58.601,DA(3),"DIV",DA(2),0))
 S GOTONE=0
 S WD=0 F  Q:$G(GOTONE)  S WD=$O(^PS(57.5,+QZ,1,WD)) Q:'WD  D
 .S WDIEN=+$G(^PS(57.5,+QZ,1,WD,0))
 .I $P(^DIC(42,WDIEN,0),U,11)=PSJDIV S GOTONE=1
 Q:GOTONE 1
 Q 0
 ;
WGCHK2(QZ,DDEV) ; Ward Group QZ must have at least one ward associated with division PSJDIV in PADE inbound system DA(3)
 N PSJDIV,WD,WDIEN,GOTONE
 Q:'$G(DDEV) 0
 S PSJDIV=$P($G(^PS(58.63,+DDEV,2)),"^")
 Q:'PSJDIV 0
 S GOTONE=0
 S WD=0 F  Q:$G(GOTONE)  S WD=$O(^PS(57.5,+QZ,1,WD)) Q:'WD  D
 .S WDIEN=+$G(^PS(57.5,+QZ,1,WD,0))
 .I $P(^DIC(42,WDIEN,0),U,11)=PSJDIV S GOTONE=1
 Q:GOTONE 1
 Q 0
 ;
SYSHLP ; User help for PADE INVENTORY SYSTEM (#.01) field of PADE INVENTORY SYSTEM (#58.601) file
 N ARRAY
 S ARRAY(1)=" Enter the name of the Pharmacy Automated Dispensing Equipment (PADE)."
 S ARRAY(2)=" system. This must be the same as the System Name in the HL7 messages"
 S ARRAY(3)=" received from the PADE vendor interface."
 S ARRAY(4)=""
 D WRITE(.ARRAY)
 Q
 ;
DDEVHLP ; User help for DISPENSING DEVICE (#1) field of PADE INVENTORY SYSTEM (#58.601) file
 N ARRAY
 S ARRAY(1)="  Enter the name of the specific dispensing device, also known as"
 S ARRAY(2)="  a Station or Cabinet. This must match exactly the name of the"
 S ARRAY(3)="  device on the PADE system."
 S ARRAY(4)=""
 D WRITE(.ARRAY)
 Q
 ;
CBALHLP ; User help for CALCULATED DEVICE BALANCE (#1) field in DRUG (DEVICE) (#58.60111) sub-file.
 N ARRAY
 S ARRAY(1)=" CAUTION: The Calculated Device Balance is calculated using information"
 S ARRAY(2)=" received from the dispensing system. Verify the balance on the dispensing"
 S ARRAY(3)=" device before making edits to this field."
 S ARRAY(4)=""
 D WRITE(.ARRAY)
 Q
RBALHLP ; User help for REPORTED DEVICE BALANCE (#2) field in DRUG (DEVICE) (#58.60111) sub-file.
 N ARRAY
 S ARRAY(1)=" CAUTION: The Reported Device Balance is received directly from the"
 S ARRAY(2)=" dispensing system. Verify the balance on the dispensing device before"
 S ARRAY(3)=" making edits to this field, or correct the balance on the PADE system."
 S ARRAY(4)=""
 D WRITE(.ARRAY)
 Q
 ;
DRGINHLP ; User help for INACTIVE DATE/TIME (#3) field in the DRUG (DEVICE) (#58.60111) sub-file.
 N ARRAY
 S ARRAY(1)=" Enter the Date/Time a drug was completely removed from the device,"
 S ARRAY(2)=" indicating the drug will no longer be available from that device."
 S ARRAY(3)=""
 D WRITE(.ARRAY)
 Q
 ;
DIVHLP ; User help for DIVISION (#3) field, sub-file 58.6013.
 N ARRAY
 S ARRAY(1)=" Enter a Medical Center Division associated with this PADE inbound system."
 S ARRAY(2)=" PADE dispensing devices may be associated with Divisions so that PADE"
 S ARRAY(3)=" inventory may be updated accurately in VistA."
 S ARRAY(4)=""
 D WRITE(.ARRAY)
 Q
 ;
WRITE(ARRAY) ; Write contents of ARRAY to screen
 D EN^DDIOL(.ARRAY)
 Q
 ;
DWOIN(DWOTIM) ; Input Transform-Dispensed without orders-length of time after dispense that order creation is allowed
 N DWOVAL,UNIT,MULT,NUM
 S NUM=+DWOTIM
 S UNIT=$E($P(DWOTIM,NUM,2))
 Q:'$G(DWOTIM) 0
 S MULT=$S(UNIT="H":60,UNIT="D":1440,UNIT="M":1,UNIT="S":1/60,1:1)
 S DWOVAL=DWOTIM*MULT
 Q $$ROUND(DWOVAL)
 ;
ROUND(NUM) ; Round
 Q:'NUM 0
 N DIV,REM
 S DIV=NUM\1,REM=NUM#1
 S DIV=$S(REM<.5:DIV,1:DIV+1)
 Q DIV
 ;
ASKDONE() ; Ask next action
 N DIR,PSJSNAM,X,Y
 S PSJSNAM=$P($G(^PS(58.601,+$G(PSJPSYS),0)),"^")
 S DIR(0)="S^R:Re-edit "_PSJSNAM_" System;D:Edit "_$S(PSJSNAM]"":PSJSNAM_" ",1:"")_"PADE Devices;Q:Quit"
 S DIR("A",1)="Finished editing PADE System "_PSJSNAM
 S DIR("A")="(R)e-edit PADE system, edit (D)evice, or (Q)uit (R,D,Q)"
 D ^DIR S PSJASKDN=$S(Y="R":1,Y="D":2,1:3)
 Q PSJASKDN
 ;
DWODEV(CABNUM) ; Prompt for Dispensed Without Orders Mail Group for Device CABINET
 N DIC,DA,DR,X,Y,DIE,DR,CABNAME,PSJPSYS,DWOIEN,DP,DL,DI
 Q:'$G(CABNUM)
 D GETS^DIQ(58.63,+CABNUM,".01;1","IE","CABNAME")
 S CABNAME=$G(CABNAME(58.63,CABNUM_",",.01,"E"))
 S PSJPSYS=$G(CABNAME(58.63,CABNUM_",",1,"I"))
 Q:(CABNAME="")
 S DWOIEN=$$FIND1^DIC(58.6014,","_+$G(PSJPSYS)_",","","PC."_CABNAME)
 I 'DWOIEN D  Q:'DWOIEN
 .N DIC,DA,DR,X,Y,DIE,DR,DP,DL,DO,DI
 .S DIC="^PS(58.601,"_PSJPSYS_",2,",DIC(0)="ZL",DIC("P")="58.6014V"
 .S DA(1)=PSJPSYS,X=CABNUM_";PS(58.63,"
 .D FILE^DICN I Y>0 S DWOIEN=+Y
 Q:'DWOIEN
 W ! D EN^DDIOL("DWO ENTITY: "_CABNAME)
 S DIE="^PS(58.601,"_PSJPSYS_",2,",DA=+DWOIEN,DA(1)=+PSJPSYS,DR="1" D ^DIE
 Q
 ;
DRGFLAG(DFN,PSGORD,PSJDFLOC,ON,PSJNEWOE) ; Get flag indicating order is PADE order
 N PSJPSYS,PSJDRGCT,PSJLOC,PSJDSTK,PSJLOCTP,PSDRGTOT,PSDRUG,PSJRFND,X,Y,PSJNOTPD
 I '$G(PSGORD),$G(PSJNEWOE),$G(ON)["P" N PSGORD S PSGORD=$G(ON)  ; If new order, no order number passed in
 ; Patient DFN and order PSGORD are required, quit if not passed
 Q:'$G(DFN)!'$G(PSGORD) ""
 ;
 S PSJRFND=0
 ; Unit Dose Active, Pending, Non-Verified
 I PSGORD["U"!(PSGORD["P") D  Q PSJRFND
 .I $S(PSGORD["U":'$D(^PS(55,+$G(DFN),5,+$G(PSGORD),1)),1:'$D(^PS(53.1,+PSGORD,1))) S PSJRFND="" Q
 .N PSDDIEN
 .D:PSGORD["U" GETUDRG(DFN,PSGORD,.PSJLOC,.PSJLOCTP,.PSDRUG)
 .D:PSGORD["P" GETPDRG(DFN,PSGORD,.PSJLOC,.PSJLOCTP,.PSDRUG)
 .S PSJRFND=$$PSJRFND(DFN,PSGORD,.PSJLOC,.PSJLOCTP,.PSDRUG)
 ;
 ; Complex orders
 I PSGORD=+PSGORD D  Q PSJRFND
 .N PSJPRNT S PSJPRNT=+PSGORD
 .S PSGORD=0 F  S PSGORD=$O(^PS(53.1,"ACX",PSJPRNT,PSGORD)) Q:'PSGORD!$G(PSJRFND)  D
 ..Q:'$D(^PS(53.1,+PSGORD,0))  N PSDDIEN
 ..D GETPDRG(DFN,PSGORD_"P",.PSJLOC,.PSJLOCTP,.PSDRUG)
 ..S PSJRFND=$$PSJRFND(DFN,PSGORD_"P",.PSJLOC,.PSJLOCTP,.PSDRUG)
 ;
 Q PSJRFND
 ;
DRGSTOCK(DFN,PSGORD,PSJDFLOC,PS5345,DRGIEN) ; Get Quantity of Drug in PADE for patient DFN order PSGORD
 ; PSGORD = Clinic Order - find PADEs associated with the Clinic, return total quantity in all qualifying PADEs
 ; PSGORD = Regular UD order - find PADEs associated with patient's ward location, return total quantity in all PADEs
 ;
 N PSJPSYS,PSJDRGCT,PSJLOC,PSJDSTK,PSJLOCTP,PSDRGTOT,PSDRUG,PSDRFND,X,Y,PSJNOTPD
 S PSJDSTK="",PSDRGTOT=0
 ; Patient DFN and order PSGORD are required, quit if not passed
 I '$G(DFN) Q ""
 I '$G(PSGORD) D  I '$G(DRGIEN)!'$G(PSJLOC) Q ""
 .S PSGORD=""
 .I '$G(PSJDFLOC) D
 ..I '$G(VAIN(4)) N VAIN D INP^VADPT
 ..S PSJDFLOC=+$G(VAIN(4))_"WD"
 .S PSJLOCTP=$P(PSJDFLOC,+PSJDFLOC,2) Q:PSJLOCTP=""
 .S PSJLOC=+$G(PSJDFLOC)
 ;
 ;Get location and default drug ien for Active UD and NON-VERIFIED/PENDING UD order.
 ; If a specific drug was passed in via DRGIEN or PS5345 skip this and find balance for that drug
 I PSGORD["U"!(PSGORD["P") S PSDRFND="" D  Q:PSDRFND]"" PSDRFND
 .Q:$S(PSGORD["U":'$D(^PS(55,+$G(DFN),5,+$G(PSGORD),0)),1:'$D(^PS(53.1,+PSGORD,0)))
 .N PSDDIEN
 .D:PSGORD["U" GETUDRG(DFN,PSGORD,.PSJLOC,.PSJLOCTP,.PSDRUG)
 .D:PSGORD["P" GETPDRG(DFN,PSGORD,.PSJLOC,.PSJLOCTP,.PSDRUG)
 ;
 ; If pointer to DISPENSE DRUG multiple (#2) in INPATIENT USER PARAMETERS (#53.45) file is passed, get default drug ien
 I $G(PS5345) N TMP S TMP=+$G(^PS(53.45,+$G(PSJSYSP),2,+$G(PS5345),0)) I $G(TMP) S PSDRUG=TMP
 ; If a specific drug ien pointer to DRUG file (#50) is passed in, use that
 I $G(DRGIEN) S PSDRUG=+DRGIEN
 ;
 I '$G(PSDRUG) Q "NA"
 ;
 S PSDRGTOT=$$DRGQTY(PSDRUG,PSJLOCTP,PSJLOC)
 Q PSDRGTOT
 ;
GETUDRG(DFN,PSGORD,PSJLOC,PSJLOCTP,PSDRUG) ; Get UD order location and drug from UD multiple (#62) of PHARMACY PATIENT file (#55)
 ; 
 K PSJLOC,PSJLOCTP,PSDRUG N DDCNT,TMPDRG,TMPLOC
 S DDCNT=0 F  S DDCNT=$O(^PS(55,+$G(DFN),5,+PSGORD,1,DDCNT)) Q:'DDCNT  D
 .S TMPDRG=+$G(^PS(55,+DFN,5,+PSGORD,1,DDCNT,0))
 .S:TMPDRG PSDRUG(TMPDRG)=""
 .S:'$G(PSDRUG) PSDRUG=TMPDRG
 S TMPLOC=$G(^PS(55,+DFN,5,+PSGORD,8)),PSJLOCTP="CL" S PSJLOC=$S(+TMPLOC&$P(TMPLOC,"^",2):+TMPLOC,1:"")
 I 'PSJLOC N VAIN,VAINDT,VAHOW,VAROOT D INP^VADPT S PSJLOC=$G(VAIN(4)) S PSJLOCTP="WD"
 Q
 ;
GETPDRG(DFN,PSGORD,PSJLOC,PSJLOCTP,PSDRUG) ; Get UD order location and drug from NON VERIFIED/PENDING file (#53.1)
 ;
 K PSJLOC,PSJLOCTP,PSDRUG N DDCNT,TMPDRG,TMPLOC
 S DDCNT=0 F  S DDCNT=$O(^PS(53.1,+PSGORD,1,DDCNT)) Q:'DDCNT  D
 .S TMPDRG=+$G(^PS(53.1,+PSGORD,1,DDCNT,0))
 .S:TMPDRG PSDRUG(TMPDRG)=""
 .S:'$G(PSDRUG) PSDRUG=TMPDRG
 S TMPLOC=$G(^PS(53.1,+PSGORD,"DSS")),PSJLOCTP="CL" S PSJLOC=$S(+TMPLOC&$P(TMPLOC,"^",2):+TMPLOC,1:"")
 I 'PSJLOC N VAIN D INP^VADPT S PSJLOC=$G(VAIN(4)),PSJLOCTP="WD"
 I $D(PSDRUG)<10 D
 .N PSJOI S PSJOI=+$G(^PS(53.1,+PSGORD,.2))
 Q
 ;
DRGQTY(DRGIEN,LOCTYP,LOCIEN) ; Get PADE quantity for drug DRGIEN for location LOCIEN
 ;
 ; Input: DRGIEN - Drug IEN pointer to DRUG (#50) file
 ;        LOCTYP - Location Type - "WD"=Ward, "WG"=Ward Group, "CL"=Clinic, "CG"=Clinic Group
 ;        LOCIEN - Location IEN, if LOCTYP="WD" :  pointer to Ward (#42) 
 ;                               if LOCTYP="WG" :  Ward Group (#57.5) 
 ;                               if LOCTYP="CL" :  Clinic (#44)  
 ;                               if LOCTYP="CG" :  Clinic Group (#57.8) 
 ;
 N PSJPSYS,PSJDEV,PSJDRGCT,PSJCAB,PSJSUBFI
 S PSJDRGCT="NA"
 ; Get proper location subfile in PADE DISPENSING DEVICE (#58.63)
 S PSJSUBFI=$S(LOCTYP="WG":58.635,LOCTYP="WD":58.636,LOCTYP="CG":58.637,LOCTYP="CL":58.638,1:"")
 ; Bad location type
 Q:'PSJSUBFI PSJDRGCT
 ; Get total sum of quantities of drug DRGIEN in each cabinet
 S PSJCAB=0 F  S PSJCAB=$O(^PS(58.601,"DRG",DRGIEN,PSJCAB)) Q:'PSJCAB  D
 .I $$CABLOC(PSJCAB,PSJSUBFI,+LOCIEN) S PSJDRGCT=PSJDRGCT+$$GETCABCT(PSJCAB,DRGIEN)
 Q PSJDRGCT
 ;
CABLOC(PSJCAB,PSJSUBFI,LOCIEN) ; Return true if location LOCIEN is linked to cabinet PSJCAB
 ;
 N CABLOC,CLINAM,PARTIAL,CABSTAT
 ; If PADE device is Inactive, return false
 D GETS^DIQ(58.63,PSJCAB_",",4,"I","CABSTAT")
 Q:$G(CABSTAT("58.63",PSJCAB_",",4,"I"))="I" ""
 ; Check if ward is directly linked to cabinet
 D LIST^DIC(PSJSUBFI,","_+$G(PSJCAB)_",","@;.01","PI","","","","","I ^(0)="_+$G(LOCIEN),"","CABLOC")
 S CABLOC=$S($G(CABLOC("DILIST",1,0)):1,1:0)
 ; If no match and looking for ward, check all wards linked to cabinet's ward groups
 I 'CABLOC,($G(PSJSUBFI)=58.636) S CABLOC=$$CHKWG^PSJPAD50(PSJCAB,+LOCIEN)
 ; If no match and looking for clinic, check all clinics linked to cabinet's clinic groups
 I 'CABLOC,($G(PSJSUBFI)=58.638) S CABLOC=$$CHKCG^PSJPAD50(PSJCAB,+LOCIEN) I 'CABLOC D
 .; If no match and looking for clinic, check all clinic wildcards linked to cabinet
 .D GETS^DIQ(44,+LOCIEN,".01",,"CLINAM") D
 ..S CLINAM=$G(CLINAM(44,+LOCIEN_",",".01")),PARTIAL=$E(CLINAM,1,2)
 ..F  S PARTIAL=$O(^PS(58.63,"WC",PARTIAL)) Q:$E(PARTIAL,1,3)'=$E(CLINAM,1,3)!$G(CABLOC)  D
 ...Q:'($E(CLINAM,1,$L(PARTIAL))=PARTIAL)
 ...I $D(^PS(58.63,"WC",PARTIAL,PSJCAB)) S CABLOC=1
 Q CABLOC
 ;
GETCABCT(CAB,DRG) ; Get PADE count of drug DRG for cabinet CAB
 N SYSDA,DEVDA,DRGDA,CABCT,CABSTAT
 S CABCT=0
 S SYSDA=$O(^PS(58.601,"DRG",+$G(DRG),+$G(CAB),0)) Q:'SYSDA 0
 S DEVDA=$O(^PS(58.601,"DRG",+$G(DRG),+$G(CAB),SYSDA,0)) Q:'DEVDA 0
 S DRGDA=$O(^PS(58.601,"DRG",+$G(DRG),+$G(CAB),SYSDA,DEVDA,0)) Q:'DRGDA 0
 ;
 D GETS^DIQ(58.60111,DRGDA_","_DEVDA_","_SYSDA_",",2,"","CABCT")
 D GETS^DIQ(58.63,CAB_",",4,"I","CABSTAT")
 Q:$G(CABSTAT("58.63",CAB_",",4,"I"))="I" ""
 ;
 Q +$G(CABCT(58.60111,DRGDA_","_DEVDA_","_SYSDA_",",2))
 ;
PSJOE ; Set the PSJ PADE OE BALANCES kernel parameter
 ; 
 N PSJMSG,PSPARIEN,X,Y
 N DIR,X,Y,PSYSTAT
 S PSPARIEN=$$FIND1^DIC(8989.51,,,"PSJ PADE OE BALANCES")
 Q:'PSPARIEN
 S PSJMSG(0)=" "
 S PSJMSG(1)="The PSJ PADE OE INDICATORS Parameter toggles the display of the"
 S PSJMSG(2)="PADE flag (PD) in Inpatient Order Entry and the display of PADE"
 S PSJMSG(3)="drug balances during entry of an order's Dispense Drug"
 D EN^DDIOL(.PSJMSG)
 S DIR("B")=$$GET^XPAR("SYS","PSJ PADE OE BALANCES")
 I DIR("B") S DIR("B")=$$DEVSTCHK^PSJPDRU1(+$G(PSJPSYS))
 S DIR("B")=$S(DIR("B")="":"",DIR("B")=1:"YES",1:"NO")
 S DIR(0)="Y"
 S DIR("A")="DISPLAY PADE INDICATORS IN IOE"
 S DIR("?",1)=" This activates/deactivates PADE indicators in Inpatient"
 S DIR("?")=" Order Entry (IOE) for this vendor only."
 D ^DIR
 S PSYSTAT=$S(Y=1:1,Y=0:0,1:"")
 Q:PSYSTAT=""
 D DEVONOFF^PSJPDRU1(+$G(PSJPSYS),PSYSTAT)
 D INSYSPAR^PSJPDRU1(PSYSTAT)
 Q
 ;
 ;CHG^XPAR(ENT,PAR,INST,VAL,ERR) ; change parameter value for a given instance
 ;EDIT(Entity,Parameter)
 Q
 ;
PSJRFND(DFN,PSGORD,PSJLOC,PSJLOCTP,PSDRUG) ; Return a flag indicating all Dispense Drugs in the order are PADE drugs
 ;
 N PSJPDCHK S PSJPDCHK=1
 ; Quit if patient/order location not linked to PADE
 I $G(PSJLOCTP)="CL",$G(PSJLOC) S PSJPDCHK=$$PADECL^PSJPAD50(+$G(PSJLOC))
 I $G(PSJLOCTP)="WD",$G(PSJLOC) S PSJPDCHK=$$PADEWD^PSJPAD50(+$G(PSJLOC))
 Q:'$G(PSJPDCHK) ""
 ;
 S (PSJNOTPD,PSJRFND)=0
 S PSDDIEN=0 F  Q:PSJNOTPD  S PSDDIEN=$O(PSDRUG(PSDDIEN)) Q:'PSDDIEN!PSJNOTPD  D
 .N INACT,DDX S DDX=$O(^PS(53.45,+$G(PSJSYSP),2,"B",PSDDIEN,0)) I DDX S INACT=$P($G(^PS(53.45,+$G(PSJSYSP),2,DDX,0)),"^",3)
 .Q:$G(INACT)&($G(INACT)<$P($$FMADD^XLFDT($$NOW^XLFDT,1),"."))
 .S PSJRFND=$$DRGQTY(PSDDIEN,PSJLOCTP,PSJLOC)
 .S:'(PSJRFND?1.N) PSJNOTPD=1
 S:PSJNOTPD PSJRFND=""
 Q PSJRFND
