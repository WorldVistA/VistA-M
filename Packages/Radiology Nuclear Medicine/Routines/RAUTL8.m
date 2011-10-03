RAUTL8 ;HISC/CAH-Utility routines ;05/19/09  12:02
 ;;5.0;Radiology/Nuclear Medicine;**45,72,99,90**;Mar 16, 1998;Build 20
 ;
 ;Called by File 70, Exam subfile, Procedure Fld 2 Input transform
 ;RA*5*45: modified -  logic in PRC1, ASK, ASK1, & MES1 subroutines
 ;          removed -  MES subroutine
 ;RA*5*72 03/23/2006 BAY/GJC/KAM Remedy Call 136200 Correct UNDEF issue
 ;RA*5.0*99 added utility for pt age and pt sex
 ;
 ;Supported IA #10061 reference to ^VADPT
 ;Supported IA #10103 reference to ^XLFDT
 ;Supported IA #10142 reference to EN^DDIOL
 ;Supported IA #2056 reference to GET1^DIQ and GETS^DIQ
 ;Supported IA #10104 reference to UP^XLFSTR
 ;Supported IA #10076 reference to ^XUSEC
 ;Supported IA #2055 reference to EXTERNAL^DILFD
 ;Supported IA #2378 reference to ORCHK^GMRAOR
 ;
PRC G PRC1:'$D(^RADPT(DA(2),"DT","AP",X)) ; check for C.M. reaction
 N RADUP S RADUP=+$$DPDT^RAUTL8(X,.DA)
 I RADUP D ASK Q:'$D(X)
PRC1 ; Check for C.M. reaction on this patient
 ; +X is the IEN of the Rad/Nuc Med Procedure in file 71
 ; RA*5*72 - Changed next line to preserve variables
 N RAGMRAOR S RAGMRAOR=$$GMRAOR(DA(2)) Q:RAGMRAOR'=1
 D CONTRAST^RAUTL2(+X) ;displays contrast(s) associated with procedure
 ;use RAPMSG for CONTRAST REACTION MESSAGE field 25, file 79
 S RAPMSG=$G(^RA(79,+$P(^RADPT(DA(2),"DT",DA(1),0),"^",3),"CON"))
 D:RAPMSG'="" EN^DDIOL("..."_RAPMSG_"...","","!?3")
 D EN^DDIOL("","","!") ;line feed
 K RAPMSG
 D:$P($G(^RAMIS(71,+X,0)),U,20)="Y" MES1 ;message only if CM used
 Q
ASK ; Prompt user for yes/no response
 N RAX D EN^DDIOL("Procedure is already entered for this date. Is it ok to continue? No// ","","!!?3")
ASK1 R RAX:DTIME
 S:'$T!(RAX="")!(RAX["^")!("Nn"[$E(RAX)) RAX="N"
 K:RAX="N" X Q:'$D(X)
 I "Yy"'[$E(RAX) S RAPMSG(1)="Enter 'YES' to register patient for this procedure, or 'NO' to edit the",RAPMSG(2)="above procedure. No// ",RAPMSG(1,"F")="!!?3",RAPMSG(2,"F")="!?3" D EN^DDIOL(.RAPMSG) K RAPMSG G ASK1
 Q
 ;
MES1 ; display procedure acceptance message
 R !?5,"...Type 'OK' to acknowledge or '^' to select another procedure   ==> ",RAX:DTIME
 S RAX=$$UP^XLFSTR(RAX)
 I '$T!(RAX["^")!(RAX="OK") K:RAX'="OK" X K RAX,RAI Q
 G MES1
 ;
STATSEL ;Select one or more order statuses
 ;INPUT VARIABLES:
 ;   RANO() array contains status codes prohibited from selection
 ;OUTPUT VARIABLES:
 ;   RAST is a string of status codes selected (ex: 1^3^8)
 ;   RAORST() is an array of selected status codes and status names
 ;     (ex:   RAORST(1)="DISCONTINUED", RAORST(3)="HOLD", ... )
 K RAST,RAORST W ! S RAORSTS=$P(^DD(75.1,5,0),U,3) F I=1:1 S X=$P(RAORSTS,";",I) Q:X=""  S X1=$P(X,":",1) I '$D(RANO(X1)) S X2=$P(X,":",2),RAORST(X1)=X2
 W !!,"Select statuses to include on report.",! S X1="" F  S X1=$O(RAORST(X1)) Q:X1=""  W !?5,$J(X1,2,0)_"   "_RAORST(X1)
STAT W ! K DIR S DIR(0)="L" D ^DIR Q:'$D(Y(0))
 S RAST="" F I=1:1 S RASTX=$P(Y(0),",",I) Q:RASTX=""  I $D(RAORST(RASTX)) S RAST=RAST_"^"_RASTX
 S RAST=$E(RAST,2,99) I RAST="" W !,"  ?? Sorry, invalid status selection.  Please try again.",! G STAT
 S I="" F  S I=$O(RAORST(I)) Q:I=""  I RAST'[I K RAORST(I)
 K RASTX,I,X,X1,X2 Q
 ;
 ;INPUT TRANSFORM FOR SECONDARY INTERPRETING RESIDENT
S() ; do not enter primary OR SAME SEC in secondary interpreting resident
 I '$D(X)!('$D(DA(3))) G S2
 I '$D(^RADPT(DA(3),"DT",DA(2),"P",DA(1),0)) G S2
 I $D(^RADPT(DA(3),"DT",DA(2),"P",DA(1),"SRR","B",+Y)) Q 0 ;SAME SEC RES
 I $P(^RADPT(DA(3),"DT",DA(2),"P",DA(1),0),"^",12)=+Y Q 0
 Q 1
S2 I '$D(^RADPT(DA(2),"DT",DA(1),"P",DA,0)) Q 0
 I $D(^RADPT(DA(2),"DT",DA(1),"P",DA,"SRR","B",+Y)) Q 0 ;SAME SEC RES
 I $P(^RADPT(DA(2),"DT",DA(1),"P",DA,0),"^",12)=+Y Q 0
 Q 1
 ;INPUT TRANSFORM FOR SECONDARY INTERPRETING STAFF
SSR() ; do not enter primary OR SAME SEC in secondary interpreting staff
 I '$D(X)!('$D(DA(3))) G SSR2
 I '$D(^RADPT(DA(3),"DT",DA(2),"P",DA(1),0)) G SSR2
 I $D(^RADPT(DA(3),"DT",DA(2),"P",DA(1),"SSR","B",+Y)) Q 0 ;SAME SEC STF
 I $P(^RADPT(DA(3),"DT",DA(2),"P",DA(1),0),"^",15)=+Y Q 0
 Q 1
SSR2 I '$D(^RADPT(DA(2),"DT",DA(1),"P",DA,0)) Q 0
 I $D(^RADPT(DA(2),"DT",DA(1),"P",DA,"SSR","B",+Y)) Q 0 ;SAME SEC STF
 I $P(^RADPT(DA(2),"DT",DA(1),"P",DA,0),"^",15)=+Y Q 0
 Q 1
 ;INPUT TRANSFORM FOR PRIMARY INTERPRETING RESIDENT
 ; *** NOT USED - See EN ***
PRRS() ; do not enter secondary into primary interpreting resident screen
 ; called from input transform ^DD(70.03,12,0)
 I $D(^RADPT(DA(2),"DT",DA(1),"P",DA,"SRR","B",+Y)) Q 0
 Q 1
 ;INPUT TRANSFORM FOR PRIMARY INTERPRETING STAFF
 ; *** NOT USED - See EN ***
PSRS() ; do not enter secondary into primary interpreting staff screen
 ; called from input transform ^DD(70.03,15,0)
 I $D(^RADPT(DA(2),"DT",DA(1),"P",DA,"SSR","B",+Y)) Q 0
 Q 1
EN(X,FLD,RA) ;Input transform screen for Primary Staff, Primary Res
 ;Used by fields 70.03,12 & 70.03,15.  If 'Primary' is found in
 ; the 'Secondary' multiple then delete the 'Secondary' entry.
 ; X = 'Primary' IEN,  FLD = 'Secondary' mult. to check,  RA = DA array
 N DA,DEL,HDR,IEN,NODE,SAVEX,SUBDD,XREF
 S NODE=$S(FLD=60:"SSR",FLD=70:"SRR",1:""),SAVEX=X
 S SUBDD=$S(FLD=60:70.11,FLD=70:70.09,1:""),(IEN,DEL)=0
 I (NODE="")!(X'>0)!(FLD'>0)!(SUBDD'>0) Q
 F  S IEN=$O(^RADPT(RA(2),"DT",RA(1),"P",RA,NODE,"B",X,IEN)) Q:IEN'>0  D
 . S XREF=0
 . F  S XREF=$O(^DD(SUBDD,.01,1,XREF)) Q:XREF'>0  D
 .. S (D0,DA(3))=RA(2),(D1,DA(2))=RA(1),(D2,DA(1))=RA,(D3,DA)=IEN,X=SAVEX
 .. I $G(^DD(SUBDD,.01,1,XREF,2))]"" X ^(2)
 .. Q
 . K ^RADPT(RA(2),"DT",RA(1),"P",RA,NODE,IEN,0) S DEL=DEL+1
 . Q
 I DEL D
 . S HDR=$G(^RADPT(RA(2),"DT",RA(1),"P",RA,NODE,0)) Q:HDR=""
 . S HDR(3)=+$O(^RADPT(RA(2),"DT",RA(1),"P",RA,NODE,0))
 . S HDR(4)=$P(HDR,U,4)-DEL
 . S:HDR(3)'>0 HDR(3)="" S:HDR(4)'>0 HDR(4)=""
 . S $P(^RADPT(RA(2),"DT",RA(1),"P",RA,NODE,0),U,3,4)=HDR(3)_U_HDR(4)
 . Q
 S X=SAVEX
 Q
DPDT(RAPRC,RAY) ; Check for registration of duplicate procedures on the same
 ; date/time.  Called from PRC above.
 ; INPUT VARIABLES
 ; 'RAPRC' --> IEN of the procedure (71)
 ; 'RAY'   --> DA array i.e, DA, DA(1), & DA(2)
 ; OUTPUT VARIABLES
 ; 'RAFLG' --> RAFLG=1 procedure registered for this date/time
 ;         --> RAFLG=0 initial registration for procedure@date/time
 N RA72,RABDT,RACIEN,RAEDT,RAFLG,RAI S RAFLG=0
 S RABDT=RAY(1)\1,RAEDT=RABDT_".9999",RAI=RABDT-.0000001
 F  S RAI=$O(^RADPT(RAY(2),"DT","AP",RAPRC,RAI)) Q:RAI'>0!(RAI>RAEDT)  D  Q:RAFLG
 . Q:RAI=RAY(1)  ; At this point our exam status is 'WAITING FOR EXAM'
 . S RACIEN=$O(^RADPT(RAY(2),"DT","AP",RAPRC,RAI,0)) Q:'RACIEN
 . S RA72=+$P($G(^RADPT(RAY(2),"DT",RAI,"P",RACIEN,0)),U,3) ;xam stat
 . S RA72(3)=$P($G(^RA(72,RA72,0)),U,3)
 . I RA72(3)'=0 S RAFLG=1 ; cancelled exams are not taken into account
 . Q
 Q RAFLG
SCRN(RADA,RARS,Y,RALVL) ; check if the primary or secondary int'ng staff
 ; or resident has access to a location or locations which have
 ; an imaging type which match the imaging type of the examination.
 ; This screen will also check the classification of the individual to 
 ; ensure that they are active and valid for the field being edited.
 ;
 ; Called from DD's: ^DD(70.03,12 - ^DD(70.03,15  - ^DD(70.03,60
 ;                   ^DD(70.03,70 - ^DD(70.09,.01 - ^DD(70.11,.01
 ;
 ; Input variables:  RADA-> DA array, maps to RADFN, RADTI & RACNI
 ;                   RARS-> Classification: Resident("R") or Staff("S")
 ;                      Y-> selected resident/staff
 ;                   RALVL-> "PRI"=Primary physician, "SEC"=Secondary
 ;
 ; Output variable: $S(1:I-Types & classification match, resident/staff
 ;                      ok,0:no match re-select resident/staff)
 ;
 I $S('$D(^VA(200,+Y,"RA")):1,'$P(^("RA"),U,3):1,DT'>$P(^("RA"),U,3):1,1:0),($D(^VA(200,"ARC",RARS,+Y)))
 Q:'$T 0 ; failed the classification part of the screen
 Q:$D(^XUSEC("RA ALLOC",+Y)) 1 ; Resident/Staff has access to all loc's!
 N RA7002,RACCESS
 ; adjust RADA() due Fileman's unpredictable retention of DA() levels
 I RALVL="SEC" D
 . I '$D(RADA(3)) S RA7002=$G(^RADPT(RADA(2),"DT",RADA(1),0))
 . I $D(RADA(3)),(RADA(2)'=RADA(3)) S RA7002=$G(^RADPT(RADA(3),"DT",RADA(2),0))
 . I $D(RADA(3)),(RADA(2)=RADA(3)) S RA7002=$G(^RADPT(RADA(2),"DT",RADA(1),0))
 I RALVL="PRI" S RA7002=$G(^RADPT(RADA(2),"DT",RADA(1),0))
 D VARACC^RAUTL6(+Y) ; set-up access array for selected resident/staff
 Q:'$D(RACCESS(+Y,"IMG",+$P(RA7002,"^",2))) 0 ; no i-type match
 Q 1
 ;
CMEDIA(RADFN,RADTI,RACNI) ;return the CM used with an exam
 ;input: RADFN=patient DFN, RADTI=inv. date/time of exam, RACNI=exam IEN
 ;return: contrast media administered to the patient during an exam
 N RAI,RAS S RAI=0,RAS=""
 F  S RAI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CM",RAI)) Q:'RAI  D
 .S RAI(0)=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"CM",RAI,0)),U)
 .S RAS=RAS_$$EXTERNAL^DILFD(70.3225,.01,"",RAI(0))_", "
 Q $P(RAS,", ",1,($L(RAS,", ")-1))
 ;
GMRAOR(RADA2) ;look for a contrast media reaction
 N D,D0,D1,D2,D3,DA,DC,DD,DFN,DG,DH,DI,DIC,DIE,DIEDA,DIEL,DIETMP,DIEXREF,DIFLD,DIIENS,DIOV,DIP,DK,DL,DLAYGO,DM,DN,DOV,DP,DQ,DR,X,Y
 Q $$ORCHK^GMRAOR(RADA2,"CM")
 ;
PTAGE(DFN,RADTST) ;return pt age, added by p#99
 ;input = DFN pt ien
 ;      = RADTST date to process pt age from; if blank, use today's date
 ;output = pt age
 N RADAYS,VADM,VA,VAERR,%,RAYSAVE,RAXSAVE
 M RAYSAVE=Y,RAXSAVE=X   ;save value of Y and X, patch #90
 S:RADTST="" RADTST=$$DT^XLFDT()
 D DEM^VADPT   ; $P(VADM(3),"^") DOB of patient, internal
 S RADAYS=$$FMDIFF^XLFDT(RADTST,$P(VADM(3),"^"),3)
 M X=RAXSAVE,Y=RAYSAVE
 Q RADAYS\365.25
 ;
PTSEX(DFN) ;return pt sex, added by p#99
 ;input = pt dfn
 ;output = pt sex (M=for MALE, F=for FEMALE)
 ;save value of Y and X; patch #90
 N VADM,VA,VAERR,%,RAYSAVE,RAXSAVE M RAYSAVE=Y,RAXSAVE=X D DEM^VADPT
 M Y=RAYSAVE,X=RAXSAVE
 Q $P(VADM(5),U)
PRSCR(RADFN,RADTI,RACNI,RAFRMT) ;return pregnancy screen
 ;input: radfn = pt dfn
 ;       radti = inverse dt
 ;       racni = ien of exam sub
 ;       rafrmt = E for External format or I for Internal format
 ;return = pregnancy screen
 N RAIENS,RAOUT
 S RAIENS=RACNI_","_RADTI_","_RADFN_","
 D GETS^DIQ(70.03,RAIENS,"32",RAFRMT,"RAOUT")
 Q $G(RAOUT(70.03,RAIENS,32,RAFRMT))
PRSCOM(RADFN,RADTI,RACNI) ;return pregnancy screen comment
 ;input: radfn = pt dfn
 ;       radti = inverse dt
 ;       racni = ien of exam sub
 ;return = pregnancy screen comment
 N RAIENS,RAOUT
 S RAIENS=RACNI_","_RADTI_","_RADFN_","
 D GETS^DIQ(70.03,RAIENS,"80","E","RAOUT")
 Q $G(RAOUT(70.03,RAIENS,80,"E"))
PRCEXA(RADFN) ;return a previous case exam
 ;input:  radfn = pt dfn
 ;
 ;output: racexa(0) =radti^racni, where radti=inverse date ien and racni=record ien
 N RADTIEN,RACNIEN
 S RADTIEN=$O(^RADPT(RADFN,"DT",0)),RACNIEN=9999,RACNIEN=$O(^RADPT(RADFN,"DT",RADTIEN,"P",RACNIEN),-1)
 Q RADTIEN_U_RACNIEN
PRACTO(RADFN) ;returns previous active order IEN of file #75.1 or null if no previous order
 ;input  radfn = pt dfn
 ;output  = ien of #75.1
 N RA751IEN,RA751PR
 S RA751PR=""
 S RA751IEN=" " F  S RA751IEN=$O(^RAO(75.1,"B",RADFN,RA751IEN),-1) Q:RA751IEN'>0!$G(RA751PR)  D
 .I $$GET1^DIQ(75.1,RA751IEN,5)="ACTIVE" S RA751PR=RA751IEN
 Q RA751PR
PAOE() ;Entry point to enter Pregnancy field of file 75.1.  This label is being called from
 ;RA ORDER EXAM input template.
 ;RETURN value:  0 if unsuccessful (up arrow, timeout or problem occured), 1 if successful.
 N DIR,DIROUT,DIRUT,DUOUT,DTOUT,Y,X S DIR(0)="75.1,13"
 S DIR("B")=$S($G(RAPREG)="y":"YES",$G(RAPREG)="n":"NO",$G(RAPREG)="u":"UNKNOWN",1:"")
 S DIR("A")="PREGNANT AT TIME OF ORDER ENTRY" D ^DIR
 Q:$D(DIRUT)!$D(DUOUT)!$D(DTOUT)!$D(DIROUT) 0
 S RAPREG=$P(Y,"^")
 Q 1
 ;
ASKSEX() ;RA*5.0*99 - Determine the sex of the patient by asking the user.
 ;Called from the RA ORDER EXAM compiled input template.
 ;
 ;Question: "THE SEX OF THIS PATIENT IS NOT AVAILABLE. IS PATIENT FEMALE"
 ;If 'Yes' Y=1; if 'No' Y=0
 ;The default presented to the user: 'No'
 ;
 ;Return: the place holder value ('Y' is reset in the RA ORDER EXAM input template)
 ;necessary for branching within that template.
 ;
 N DIR,DTOUT,DUOUT,DIROUT,DIRUT,RAY,X S RAY=Y S DIR(0)="Y",DIR("B")="No"
 S DIR("A")="THE SEX OF THIS PATIENT IS NOT AVAILABLE. IS PATIENT FEMALE"
 S DIR("?")="Enter 'YES' if patient is female, or 'NO' if patient is male."
 D ^DIR
 Q $S($D(DIRUT):"@999",Y=0:"@130",1:RAY)
 ;
ASKPREG() ;RA*5.0*99 - Evaluate the conditions to present the PREGNANCY
 ;SCREENING (70.03 ; 32) prompt to the user. Called from the RA EXAM EDIT
 ;input template & the RA REGISTER compiled input template.
 ;
 ;Input: RA0(17) (global) The IEN of the report associated with this exam.
 ;                Note: no IEN will exist when the case is being registered.
 ;        RADFN  (global) the IEN of the patient
 ;            Y  (global) the place holder for the RA EXAM EDIT input template. 
 ;
 ;Return: the place holder value (Y = $$ASKPREG^RAUTL8) necessary for
 ;branching within these templates.
 ;
 N %,DIERR,RAERR,RAGE,RAST,VAERR,X,RAY S RAY=Y
 S RAGE=$$PTAGE^RAUTL8(RADFN,""),Y=$G(RA0(17))_","
 D:+Y GETS^DIQ(74,Y,5,"I","RAST","RAERR")
 S RAST=$G(RAST(74,Y,5,"I"),"")
 I $$PTSEX^RAUTL8(RADFN)'="F"!((RAGE>55)!(RAGE<12))!(RAST="V")!(RAST="EF") S RAY="@8001"
 Q RAY
 ;
