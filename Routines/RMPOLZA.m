RMPOLZA ;EDS/PAK - HOME OXYGEN LETTERS ;5/27/03  10:34
 ;;3.0;PROSTHETICS;**29,77**;Feb 09, 1996
 ;
 ;RVD patch #77 - insure that dangling 'AC' x-ref will not cause
 ;                the undefined error.
 ; 
QUIT() ;
 ; Input: None
 ; Output:
 ;   Quit flag            -  1: time out on read 
 ;                           0: no time out on read
 ;
 Q ($D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT))
 ;
SITE(RMPRSITE)  ;find the site if the site is not multidivisional
 ;
 ; Input:
 ;   Prosthetics Site     - valid site ID held in file 669.9
 ; Output:
 ;   Site flag            -  0: no H.O. site selected
 ;                           1: H.O. site selected
 ;
 ; Non interactive call to pull site parameters if site supplied
 I RMPRSITE'="" D ^RMPRSIT M RMPO=RMPR S RMPOSITE=RMPO("STA") Q 1
 ;
 ; Interactive call requiring operator input
 D HOSITE^RMPOUTL0 Q:$G(QUIT) 0 ; output RMPO("STA") - station number
 W @IOF K ^TMP($J)
 I '$G(RMPOREC) W !!,*7,"You must choose a Home Oxygen Site.",!! Q 0
 S RMPOXITE=RMPOREC
 Q 1
 ;
EXTRCT ; Extract patient demographics
 ;
 ; Input:
 ;   RMPODFN              -  Patient IEN to NEW PERSON file
 ;   ADT                  -  Patient Rx activation date
 ; Output:
 ;   ^TMP($J,RMPOXITE,"RMPODEMO",RMPODFN)  -  LastName,FirstName^H.O. ActivateDate^
 ;   Rx Expiry Date^PrimaryItemName^Prescription^PrescriptionDate^TodaysDate^                                   
 ;   ^Sex^AddressLine1^AddressLine2^AddressLine3^City^State^Zip
 ;
 ; quit if already generated demographic details for a patient
 Q:$D(^TMP($J,RMPOXITE,"RMPODEMO",RMPODFN))
 ;
 N INAME,DFN,VAPA,INFO
 ;
 S INAME="",DFN=RMPODFN
 K VADM D DEM^VADPT,ADD^VADPT
 ; 
 ; if patient has an active prescription get date entered & expiry date else set dates = NULL
 I RMPORX'="",$D(^RMPR(665,RMPODFN,"RMPOB",RMPORX,0)) S RMPOEXP=$P(^RMPR(665,RMPODFN,"RMPOB",RMPORX,0),U,3),RMPORXDT=$P(^(0),U)
 E  S (RMPOEXP,RMPORXDT)=""
 ;
 ; get primary item
 S INAME="",RMPOITEM=$O(^RMPR(665,"AC","Y",RMPODFN,0))
 I RMPOITEM'="" D
 . Q:'$D(^RMPR(665,RMPODFN,"RMPOC",RMPOITEM,0))
 . S RMPOITEM=$P(^RMPR(665,RMPODFN,"RMPOC",RMPOITEM,0),U),RMPOITEM=$P(^RMPR(661,RMPOITEM,0),U)
 . S INAME=$P(^PRC(441,RMPOITEM,0),U,2)
 ;
 ;set the ^TMP($J,RMPOXITE,"RMPODEMO" global with patient demographics
 S INFO=VADM(1)_U_$P(VADM(2),U,2)_U_ADT_U_RMPOEXP_U_INAME
 S INFO=INFO_U_RMPORX_U_RMPORXDT_U_DT_U_$P(VADM(5),U)_U_VAPA(1)_U_VAPA(2)_U_VAPA(3)_U_VAPA(4)_U_$P(VAPA(5),U,2)_U_VAPA(6)
 S ^TMP($J,RMPOXITE,"RMPODEMO",RMPODFN)=INFO Q:'$D(RMPOLCD)!RMPOLCD=""
 Q
 ;
LOCK() ; lock virtual list record
 ;
 ; Input:        
 ;   JOB         -  1: job, 2: interactive
 ;
 ; Output:
 ;   None
 ;
 L +^TMP("RMPO",$J,RMPOXITE,"LETTERPRINT"):0
 I '$T W:'JOB !,"Cannot continue as list edit or printing is in progress" H 2 Q 0
 Q 1
 ;
UPDLTR(DA,VAL)  ; Update 'Letter to be sent' in Prosthetics Patient File
 ;
 ; I/P :
 ;     VAL - value to be inserted into field
 ;
 N DIE
 ;
 S DR="19.13///"_VAL,DIE="^RMPR(665," D ^DIE
 Q
 ;
SELN(TYP,TXT,MAX)     ;
 ;
 ; Input:
 ;   TYP(e)               -  section type: "L"ist of # 
 ;                                          single "N"umber
 ;   TeXT                 -  prompt text
 ;   MAX                  -  maximum valid number
 ;
 ; Output:
 ;   Y                    -  selected number or range of numbers 
 ;
 N DIR,Y
 ;
 D FULL^VALM1
 S DIR("A")=TXT,DIR(0)=TYP_"^1:"_MAX_":0"
 D ^DIR
 Q:$$QUIT^RMPOLZA 0
 I Y="" S VALMBCK="R",Y=0
 Q Y
