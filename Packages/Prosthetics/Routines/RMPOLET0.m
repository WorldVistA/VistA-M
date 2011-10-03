RMPOLET0 ;EDS/PAK - HOME OXYGEN LETTERS ;7/24/98
 ;;3.0;PROSTHETICS;**29,46**;Feb 09, 1996
 ;
START ;
 N LST,TXT,TRXS,LTRX
 ;
 Q:'$$SITE
 S LST=$$LST I 'LST G EXIT
 D:LST=2 PURGE
 D LTRCR  ; generate letter code to prosthetics letter IEN xref
 K ^TMP($J)
 ; build patient list work file from current list (GENOLST) or
 ; generate new patient letter list work file (GENLST)
 D GENLST:LST'=1,GENOLST(0):LST=1
 ;
 D SELECT^RMPOLETA
 ;       
 L -^TMP("RMPO","LETTERPRINT")
 G EXIT
 Q
 ;
SITE() ;find the site if the site is not multidivisional
 ;
 ;Initialize, if necessary
 D HOSITE^RMPOUTL0  ; output RMPO("STA") - station number
 W @IOF K ^TMP($J)
 I '$G(RMPOREC) W !!,*7,"You must choose a Home Oxygen Site.",!! Q 0
 S RMPOXITE=RMPOREC
 Q 1
 ;
LST() ;Check Letters List       
 N LST
 ;
 S LST=0
 I $D(^RMPR(665,"ALTR")) D  ; if already a patient list in existance exit
 . S %=2
 . W !,"A list of patient letters to be printed already exists",!
 . W !,"Do you wish to reprint the current list" D YN^DICN
 . I %=1 S LST=1
 . E  S %=2 W !,"Do you wish to generate a new list which will discard any edits" D YN^DICN S:%=1 LST=2
 E  S LST=3
 I LST S TXT=$S(LST=1:"work with current",LST=2:"regenerate",1:"generate new") S:'$$LOCK(TXT) LST=0
 Q LST
 ;
LTRCR ; build local array CROSS REFERENCE of H.O. letter Code to Letter
 ;
 ; ! assumes a letter code can have many letter templates but one    !
 ; ! template is of a particluar type e.g. a 30,60,90 & 120 Day H.O. !
 ; ! letters are all of type "B" : prescription pending expiry.      !
 ;
 ; O/P : LTRX("A",Letter Code,Prosthetics Letter IEN)
 ;       LTRX("B",Prosthetics Letter IEN)=Letter Code
 ;  
 N LTRIEN,REC
 ;
 S LTRIEN=0 F  S LTRIEN=$O(^RMPR(669.9,RMPOXITE,"RMPOLET",LTRIEN)) Q:LTRIEN<1  D
 . S REC=^RMPR(669.9,RMPOXITE,"RMPOLET",LTRIEN,0),RMPOLTR=$P(REC,U),RMPOLCD=$P(REC,U,2)
 . I RMPOLCD'="",(RMPOLTR'="") S LTRX("A",RMPOLCD,RMPOLTR)="",LTRX("B",RMPOLTR)=RMPOLCD
 Q
 ;
GENLST ; generate patient letter list
 N REC,ADT,IADT
 ;
 S Z=""
 F  S Z=$O(^RMPR(665,"AHO",Z)) Q:Z=""  D
 .S RMPODFN=0
 . F  S RMPODFN=$O(^RMPR(665,"AHO",Z,RMPODFN)) Q:RMPODFN=""  D
 .. N TRXS
 .. ;
 .. Q:$P(^RMPR(665,RMPODFN,"RMPOA"),U,7)'=RMPOXITE  ; ignore patient from another station
 .. ;Get patient demographic data
 .. S DFN=RMPODFN K VADM D DEM^VADPT
 .. ;Do not collect patient if expired
 .. Q:$G(VADM(6))
 .. S REC=$G(^RMPR(665,RMPODFN,"RMPOA")) Q:REC=""  ; not a H.O. patient
 .. S ADT=$P(REC,U,2),IADT=$P(REC,U,3)  ; get Activation & InActivation DaTes
 .. Q:ADT=""  ; quit if not an active H.O. patient
 .. D FNDTRX  ; build Xref of transactions (TRX) to letter type for this patient
 .. S RMPORX=$P($G(^RMPR(665,RMPODFN,"RMPOB",0)),U,3)  ; get active prescription
 .. ; check if new patient or inactivation letter required
 .. Q:$$NACT
 .. ; get active patient prescription and evaluate letter requirement
 .. Q:'$D(^RMPR(665,RMPODFN,"RMPOB",0))
 .. Q:RMPORX<1  ; quit if no active prescription    
 .. D EXPR
 Q
 ;
GENOLST(BTYP) ; Generate work file from current patient letter list
 N LTRIEN
 ;
 S RMPOLTR=0 F  S RMPOLTR=$O(^RMPR(665,"ALTR",RMPOLTR)) Q:RMPOLTR=""  D
 . S RMPODFN=0 F  S RMPODFN=$O(^RMPR(665,"ALTR",RMPOLTR,RMPODFN)) Q:RMPODFN=""  D
 . . S STA=$P(^RMPR(665,RMPODFN,0),U,2) Q:STA'=RMPO("STA")  ; ignore patients from another station
 . . S REC=$G(^RMPR(665,RMPODFN,"RMPOA")),ADT=$P(REC,U,2),IADT=$P(REC,U,3)
 . . S RMPORX=$P($G(^RMPR(665,RMPODFN,"RMPOB",0)),U,3)
 . . S LTRIEN=$O(^RMPR(669.9,RMPOXITE,"RMPOLET","B",RMPOLTR,0))
 . . S RMPOLCD=$P(^RMPR(669.9,RMPOXITE,"RMPOLET",LTRIEN,0),U,2)
 . . D EXTRCT(BTYP) S ^TMP($J,"RMPOLST",RMPOLCD,RMPODFN)=RMPOLTR
 Q
 ;
NACT() ; check if new patient letter or inactivation letter is required
 N FND,LST,DTE
 ;
 F RMPOLCD="A","C" D  Q:LST  ; Quit if letter placed on list
 . S (LST,FND)=0,RMPOLTR="",DTE=$S(RMPOLCD="A":ADT,1:IADT)
 . F  S RMPOLTR=$O(LTRX("A",RMPOLCD,RMPOLTR)) Q:RMPOLTR=""  D  Q:FND  Q:LST  ; for each VALID H.O. letter of given Letter Code
 . . I $O(TRXS(RMPOLCD,RMPOLTR,(DTE-1))) S FND=1 Q  ; quit if letter printed on or after de/activation
 . . D EXTRCT(0) S ^TMP($J,"RMPOLST",RMPOLCD,RMPODFN)=RMPOLTR S LST=1 ; add person to list as requiring appropriate letter
 Q FND
 ;
EXPR ; check if prescription is pending expiry
 N REC,LTR,EXP
 ;
 S RMPOLCD="B",REC=^RMPR(665,RMPODFN,"RMPOB",RMPORX,0)
 S RMPOEXP=$P(REC,U,3) Q:RMPOEXP<DT  ; quit if prescription already expired
 S X1=RMPOEXP,X2=DT D ^%DTC S RMPODAYS=X-1
 S RMPODAYS=$O(^RMPR(669.9,"ALTDY",RMPODAYS))
 Q:RMPODAYS=""  ;no letter for this expiry pending period (zero to n days)
 Q:'$D(^RMPR(669.9,"ALTDY",RMPODAYS,RMPOXITE))  ; ignore letters defined for other sites
 S LTR=$O(^RMPR(669.9,"ALTDY",RMPODAYS,RMPOXITE,0)) ;get FIRST letter assoc. with this expiry period
 S RMPOLTR=$P(^RMPR(669.9,RMPOXITE,"RMPOLET",LTR,0),U) ; get H.O. letter
 Q:$D(TRXS(RMPOLCD,RMPOLTR))  ; H.O. letter for this expiry period has been sent
 D EXTRCT(0) S ^TMP($J,"RMPOLST",RMPOLCD,RMPODFN)=RMPOLTR
 Q
 ;
EXTRCT(BTYP)  ;
 ;
 ; I/P : Build TYPe - 0=List, 1=Letter 
 ;
 ; quit if already generated demographic details for a patient
 Q:$D(^TMP($J,"RMPODEMO",RMPODFN))
 ;
 N INAME,INFO
 ;
 S INAME="",DFN=RMPODFN
 K VADM D DEM^VADPT,ADD^VADPT
 S NAME=VADM(1)_U_RMPODFN
 ; 
 ; if patient has an active prescription get date entered & expiry date else set dates = NULL
 I RMPORX'="" S RMPOEXP=$P(^RMPR(665,RMPODFN,"RMPOB",RMPORX,0),U,3),RMPORXDT=$P(^(0),U)
 E  S (RMPOEXP,RMPORXDT)=""
 ;
 ; get primary item
 S INAME="",RMPOITEM=$O(^RMPR(665,"AC","Y",RMPODFN,0))
 I RMPOITEM'="" D
 . S RMPOITEM=$P(^RMPR(665,RMPODFN,"RMPOC",RMPOITEM,0),U),RMPOITEM=$P(^RMPR(661,RMPOITEM,0),U)
 . S INAME=$P(^PRC(441,RMPOITEM,0),U,2)
 ;
 ;set the ^TMP($J,"RMPODEMO" global with patient demographics
 S INFO=VADM(1)_U_$P(VADM(2),U,2)_U_ADT_U_RMPOEXP_U_INAME
 S:BTYP=1 INFO=INFO_U_RMPORX_U_RMPORXDT_U_DT_U_$P(VADM(5),U)_U_VAPA(1)_U_VAPA(2)_U_VAPA(3)_U_VAPA(4)_U_$P(VAPA(5),U,2)_U_VAPA(6)
 S ^TMP($J,"RMPODEMO",RMPODFN)=INFO
 Q
FNDTRX  ; find letter TRX & hold in local array
 ;
 ; I/P : NONE
 ; O/P : TRXS(H.O. Letter Code,Prosthetics Letter,Transaction Printed Date)
 ;
 N TRX
 ;
 S TRX=0 F  S TRX=$O(^RMPR(665.4,"B",RMPODFN,TRX)) Q:TRX=""  D
 . 
 . Q:$P(^RMPR(665.4,TRX,0),U,6)'=RMPO("STA")  ; ignore letters from a different station
 . S RMPOLTR=$P(^RMPR(665.4,TRX,0),U,2) Q:'$D(LTRX("B",RMPOLTR))  ; ignore if not a H.O. letter transaction
 . S RMPOLCD=LTRX("B",RMPOLTR)  ; get H.O. Letter Code given H.O. Letter #
 . S TRXS(RMPOLCD,RMPOLTR,$P(^RMPR(665.4,TRX,0),U,3))=""  ; create local array
 Q
 ;
PURGE ; Purge current patient letter list
 S RMPOLTR=0 F  S RMPOLTR=$O(^RMPR(665,"ALTR",RMPOLTR)) Q:RMPOLTR=""  D
 . S RMPODFN=0 F  S RMPODFN=$O(^RMPR(665,"ALTR",RMPOLTR,RMPODFN)) Q:RMPODFN=""  D UPDLTR(RMPODFN,"@")
 Q
 ;
LOCK(TXT)  ;
 ; lock virtual list record 
 L +^TMP("RMPO","LETTERPRINT"):0 I '$T W !,"Cannot "_TXT_" list as list edit or printing is in progress" Q 0
 Q 1
 ;
UPDLTR(DA,VAL)  ; Update 'Letter to be sent' in Prosthetics Patient File
 ;
 ; I/P :
 ;     VAL - value to be inserted into field
 ;
 S DR="19.13///"_VAL,DIE="^RMPR(665," D ^DIE
 Q
 ;
EXIT G EXIT^RMPOLETA
  
