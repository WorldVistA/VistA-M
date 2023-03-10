RAUTL13 ;HISC/CAH-Utility OMA Loc selector, Pt Loc change, Submit-to loc scrn ; Oct 12, 2022@10:15:27
 ;;5.0;Radiology/Nuclear Medicine;**194**;Mar 16, 1998;Build 1
 ;
 ;Routine/Global             IA          Type
 ;-------------------------------------------
 ;^XUSEC(sec. key name,DUZ)  10076       (S)
 ;
IPOP ;Determine if current pt loc is different than requesting loc
 ;INPUT VARIABLES:
 ;   RAORD0=Zeroeth node of order record from file 75.1
 ;OUTPUT VARIABLES:
 ;   RALOCN=Name of current loc (or 'UNKNOWN' if not definable)
 ;   RARLOCN=Defined only if requesting loc different from current loc.
 ;           Value is Name of requesting loc
 ;To update pt loc, get requesting loc, determine if IP or OP
 ;RARLOC=IEN of req'g loc in File 44, RARLOCN=Req'g loc name
 ;RARIPOP="I" if inpatient req. loc, "O" if outpatient req. loc
 S RARLOC=+$P(RAORD0,U,22),RARLOCN=$S($D(^SC(RARLOC,0)):$P(^(0),"^"),1:"UNKNOWN")
 K RARIPOP S X=$G(^SC(RARLOC,42)) S RARIPOP=$S($L($G(^DIC(42,+X,0))):"I",1:"O")
 ;RAIPLOC=IEN of Inp Loc in File 42, RAIPLOCN=Name of Inp Loc
 ;RACIPOP="I" if currently inpatient, or "O" if currently Outpatient
 S DFN=RADFN D INP^VADPT S RAIPLOC=$P($G(VAIN(4)),U,1),RAIPLOCN=$P($G(VAIN(4)),U,2),RACIPOP=$S($L(RAIPLOC):"I",1:"O"),RAIN44=+$G(^DIC(42,+RAIPLOC,44))
 I '$L(RAIPLOC) D OP G IPOPQ ;If pt currently outp
 ;Continue only if patient currently inp.
 I RAIN44'=RARLOC S RALOCN=RAIPLOCN G IPOPQ ;if loc change
 I RAIN44=RARLOC S RALOCN=RAIPLOCN K RARLOCN G IPOPQ ;if no change
 Q
OP I RARIPOP="O",RACIPOP="O" S RALOCN=RARLOCN K RAIPLOCN,RAIPLOC,RARLOCN Q
 I RARIPOP="I",RACIPOP="O" S RALOCN="DISCHARGED"
 Q
IPOPQ K RAIN44,RAIPLOC,VAIN,RAIPLOCN,RACIPOP,RARIPOP,RARLOC,RALOC,X
 Q
 ;
OMA ;Select One/Many/All locations within current imaging type p194
 ;INPUT VARIABLES:
 ;      RACCESS array must be defined if imaging location
 ;        access is to be screened.  Otherwise, use gets to choose from
 ;        all imaging locations
 ;      RAIMGTY must be defined if imaging locations access is to be
 ;        screened by sign-on imaging type
 ;      RANOSCRN - if defned no screening is done regardless of whether
 ;        RAIMGTY and RACCESS are defined
 ;      RAOPT("SCH") optional: iff 'Log of Scheduled Requests by Procedure' [RA ORDERLOG]
 ;        entry (set)/exit (killed) action on option
 ;      RAOPT("P/H") optional: iff 'Pending/Hold Rad/Nuc Med Request Log' [RA ORDERPENDING]
 ;        entry (set)/exit (killed) action on option
 ;OUTPUT VARIABLES:
 ;        RALOC(Rad loc name, IEN of 79.1) array
 ;
 ;Note: 'Log of Scheduled Requests by Procedure' calls RAPSET so RACCESS array & RAIMGTY will be defined.
 ;I '$D(RACCESS(DUZ,"LOC")) W !,"You do not have access to any Imaging Locations.  See your ADPAC." K DIR S DIR(0)="E" D ^DIR K DIR S RAQUIT=1 G Q
 K ^TMP($J,"RADLOCS")
 ;If user can access more than one loc of current imaging type,
 ;prompt user to select loc(s)
 I '$G(RALOC1) D  ;<--- I have access to only one location (rad) and I am still allowed to select more than one rad i-loc
 .;even pending/hold, when one loc assigned, allows me to select all imaging locations p194
 .N RAARRY,RADIC,RAUTIL
 .S RADIC="^RA(79.1,",(RAARRY,RAUTIL)="RADLOCS",RADIC(0)="QEAMZ"
 .S RADIC("A")="Select Imaging Location(s): "
 .I $D(RAIMGTY),'$D(RANOSCRN) D  ;hit by SCHEDULE LOG i-type always defined p194
 ..S RADIC("S")="N RA0791 S RA0791=$G(^RA(79.1,+Y,0)) I $P(RA0791,U,6)=+$O(^RA(79.2,""B"",RAIMGTY,0))"
 ..I $D(RAOPT("SCH"))#2,('$D(^XUSEC("RA ALLOC",DUZ))#2) S RADIC("S")=RADIC("S")_",($P(RA0791,U,19)="""")"
 ..Q
 .;pending/hold access all i-loc regardless of modality but check user for RA ALLOC
 .;No RA ALLOC? Disallow inactive locs. If RA ALLOC allow active/inactive i-locs
 .;to be selected p194
 .I $D(RANOSCRN)#2,($D(RAOPT("P/H"))#2),('$D(^XUSEC("RA ALLOC",DUZ))#2) D
 ..S RADIC("S")="N RA0791 S RA0791=$G(^RA(79.1,+Y,0)) I $P(RA0791,U,19)="""""
 ..Q
 .D EN1^RASELCT(.RADIC,RAUTIL,RAARRY)
 .Q
 S I="" F  S I=$O(^TMP($J,"RADLOCS",I)) Q:I=""  S J="" F  S J=$O(^TMP($J,"RADLOCS",I,J)) Q:J=""  S RALOC(I,J)=""
Q K I,J,RADIC,RAUTIL,RAARRY,^TMP($J,"RADLOCS")
 Q
SUBMIT(DA,Y) ;Called from file 75.1, field 20 (imaging location) screen
 ; returns 1 if location being screened has same imaging type as
 ; procedure ordered.
 ; DA is the IEN of file 75.1, Y is the IEN of the entry in file
 ; 79.1 that is being screened.
 Q:$P($G(^RA(79.1,+Y,0)),U,19)]"" 0 ; inactive location
 N RALOC,RALOCI,RAPROC,RAPROCI
 S RALOC=$G(^RA(79.1,+Y,0))
 S RALOCI=$G(^RA(79.2,$P(RALOC,U,6),0)) I '$L(RALOCI) Q 0
 S RAPROC=+$P($G(^RAO(75.1,DA,0)),U,2),RAPROCI=+$P($G(^RAMIS(71,RAPROC,0)),U,12)
 I RAPROCI=$P(RALOC,U,6) Q 1
 Q 0
SUBMITQ(DA,Y) ;Called from file 71.3, field 8 (imaging location) screen
 ; returns 1 if location being screened has same imaging type as
 ; the common procedure.
 ; DA is the IEN of file 71.3, Y is the IEN of the entry in file
 ; 79.1 that is being screened.
 N RALOC,RALOCI,RAPROC,RAPROCI
 S RALOC=$G(^RA(79.1,+Y,0)) Q:$P(RALOC,"^",19)]"" 0 ; inactive location
 S RALOCI=$G(^RA(79.2,+$P(RALOC,U,6),0)) I '$L(RALOCI) Q 0
 S RAPROC=+$P($G(^RAMIS(71.3,DA,0)),U)
 S RAPROCI=+$P($G(^RAMIS(71,RAPROC,0)),U,12)
 I RAPROCI=$P(RALOC,U,6) Q 1
 Q 0
INLO(X) ; Determine if the Imaging Location is inactive
 ; Pass in the IEN of the Imaging Location (most of the time +RAMLC)
 ; Pass back '1' if inactive, '0' if active.
 Q $S($P($G(^RA(79.1,+X,0)),U,19)']"":0,1:1)
 ;
OPTCHK() ;check if one of the two options listed below:
 ; 'Log of Scheduled Requests by Procedure' -or-
 ; 'Pending/Hold Rad/Nuc Med Request Log' invoke
 ; this sub-routine. p194
 ;returns:
 ; 0 if either option in the comments invokes OPTCHK
 ; else 1
 ;
 Q $S($D(RAOPT("SCH"))#2:0,$D(RAOPT("P/H"))#2:0,1:1)
