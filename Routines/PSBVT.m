PSBVT ;BIRMINGHAM/EFC-BCMA ORDER VARIABLES UTILITY ; 8/4/05 8:05am
 ;;3.0;BAR CODE MED ADMIN;**6,3,38**;Mar 2004;Build 8
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference/IA
 ; EN^PSJBCMA1/2829
 ; ^TMP("PSJ",$J/2828
 ;
PSJ(PSBX1) ;
 S ^TMP("TK PSJ",PSBX1)=""
 S PSBSCRT="^TMP(""PSB"",$J,""PSBORDA"")"
 K @PSBSCRT M @PSBSCRT=^TMP("PSJ",$J,PSBX1)
 S PSBDFN=DFN
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",0))
 S PSBON=+$P(PSBSCRT,U,3)  ; ord num w/o type
 S PSBONX=$P(PSBSCRT,U,3)  ; ord num w/  type "U" or "V"
 S PSBOTYP=$E(PSBONX,$L(PSBONX))
 S PSBPONX=$P(PSBSCRT,U,4)  ; prev ord num
 S PSBFON=$P(PSBSCRT,U,5)  ; foll ord num
 S PSBIVT=$P(PSBSCRT,U,6)  ; IV type
 S PSBISYR=$P(PSBSCRT,U,7)  ; intermit syrg
 S PSBCHEMT=$P(PSBSCRT,U,8)  ; chemo type
 S PSBCPRS=$P(PSBSCRT,U,9)  ; ords file entry (CPRS order #)
 S PSBFOR=$P(PSBSCRT,U,10)  ; reason for foll order
 Q:PSBSCRT=-1
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",1))
 S PSBMR=$P($G(^TMP("PSB",$J,"PSBORDA",1,0)),U,2) ;med rt
 S PSBMRAB=$P(PSBSCRT,U,1) ;med rt abbr
 S PSBNJECT=+$G(^TMP("PSB",$J,"PSBORDA",1,0))  ;Inj site
 S PSBIVPSH=+$P($G(^TMP("PSB",$J,"PSBORDA",1,0)),U,3) ;IV PUSH
 S PSBSCHT=$P(PSBSCRT,U,2)  ; sched type conversion
 S PSBSCH=$P(PSBSCRT,U,3)  ; sched
 S PSBOST=$P(PSBSCRT,U,4)  ; strt dte FM
 S PSBOSP=$P(PSBSCRT,U,5)  ; stp dte FM
 S PSBADST=$P(PSBSCRT,U,6)  ; admin times strin in NNNN- format
 S PSBOSTS=$P(PSBSCRT,U,7)  ; status
 S PSBNGF=$P(PSBSCRT,U,8)  ; not to be given flag
 S PSBOSCHT=$P(PSBSCRT,U,9)  ; origin sched type
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",2))
 S PSBDOSE=$P(PSBSCRT,U,1)  ; dosage ordered
 S PSBIFR=$P(PSBSCRT,U,2)  ; infusn rate
 S PSBSM=$P(PSBSCRT,U,3)  ; self med
 S PSBHSM=$P(PSBSCRT,U,4)  ; hospital supplied self med
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",3))
 S PSBOIT=$P(PSBSCRT,U,1)  ; order item IEN - > ^ORD(101.43)
 S PSBOITX=$P(PSBSCRT,U,2)  ; order item (expanded)_" "_dosage form
 I PSBOITX="" S PSBOITX="ZZZZ NO ORDERABLE ITEM"
 S PSBDOSEF=$P(PSBSCRT,U,3)  ; dosage form
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",4))
 S PSBOTXT=PSBSCRT  ; special inst/other print info
 ; get disp drug
 I $G(^TMP("PSB",$J,"PSBORDA",700,0)) F PSBX2=1:1:^TMP("PSB",$J,"PSBORDA",700,0) M PSBDDA(PSBX2)=^TMP("PSB",$J,"PSBORDA",700,PSBX2,0) S PSBDDA(PSBX2)="DD^"_PSBDDA(PSBX2) ; # of DDrug
 ;     "DD"^dispensed drug IEN -> ^PSDRUG() DRUG^dispensed drug name^units per dose^inactive date
 ; build unique id list
 ; add addits
 I $D(^TMP("PSB",$J,"PSBORDA",800)) S PSBX2="" F  S PSBX2=$O(^TMP("PSB",$J,"PSBORDA",800,PSBX2)) Q:PSBX2=""!(PSBX2="ERROR")  D
 .S PSBUIDA(PSBX2)="ID^"_PSBX2 F J=1:1:^TMP("PSB",$J,"PSBORDA",800,PSBX2,0) S PSBUIDA(PSBX2)=PSBUIDA(PSBX2)_"^"_"ADD;"_$P(^TMP("PSB",$J,"PSBORDA",800,PSBX2,J),U,1)
 ; add solutions
 I $D(^TMP("PSB",$J,"PSBORDA",900)) S PSBX2="" F  S PSBX2=$O(^TMP("PSB",$J,"PSBORDA",900,PSBX2)) Q:PSBX2=""!(PSBX2="ERROR")  D
 .I '$D(PSBUIDA(PSBX2)) S PSBUIDA(PSBX2)="ID^"_PSBX2
 .F J=1:1:^TMP("PSB",$J,"PSBORDA",900,PSBX2,0) S PSBUIDA(PSBX2)=PSBUIDA(PSBX2)_"^"_"SOL;"_$P(^TMP("PSB",$J,"PSBORDA",900,PSBX2,J),U,1)
 ;     "ID"   ^   (piece 2,3,)... = type;IEN of each add/sol for this ID ex. "SOL;4"
 ; get addits
 I $G(^TMP("PSB",$J,"PSBORDA",850,0)) F PSBX2=1:1:^TMP("PSB",$J,"PSBORDA",850,0) D
 .M PSBADA(PSBX2)=^TMP("PSB",$J,"PSBORDA",850,PSBX2,0)  ; number od additives (exists only for IV)
 .S PSBADA(PSBX2)="ADD^"_PSBADA(PSBX2)
 .S PSBBAGS=$P(PSBADA(PSBX2),U,5) I PSBBAGS'="" S PSBBAG=" IN BAG "_$P(PSBBAGS,",",1) F I=2:1 S X=$P(PSBBAGS,",",I) Q:X=""  S PSBBAG=PSBBAG_" AND "_X
 .S:PSBBAGS'="" $P(PSBADA(PSBX2),U,5)=PSBBAG,$P(PSBADA(PSBX2),U,6)=PSBBAGS
 ;     "ADD"^additive IEN -> ^PS(52.6) IV ADDITIVES^additive name^strength ^bottle
 ; get soluts
 I $G(^TMP("PSB",$J,"PSBORDA",950,0)) F PSBX2=1:1:^TMP("PSB",$J,"PSBORDA",950,0) M PSBSOLA(PSBX2)=^TMP("PSB",$J,"PSBORDA",950,PSBX2,0) S PSBSOLA(PSBX2)="SOL^"_PSBSOLA(PSBX2)  ; # of SOL
 ;   "SOL"^solution IEN -> ^PS(52.7) IV SOLUTIONS^solution name^volume
 K ^TMP("PSB",$J,"PSBORDA"),PSBX1,PSBX2
 Q
 ;
PSJ1(PSBPAR1,PSBPAR2) ; set the variables for an individual order
 S ^TMP("TK PSJ1",PSBPAR1,PSBPAR2)=""
 ;     PSBPAR1 = DFN
 ;     PSBPAR2 = ORDNER NUMBER 
 S PSBSCRT="^TMP(""PSB"",$J,""PSBORDA"")"
 K @PSBSCRT
 N PSBX
 K ^TMP("PSJ1",$J) D EN^PSJBCMA1(PSBPAR1,PSBPAR2,1)
 M @PSBSCRT=^TMP("PSJ1",$J) K ^TMP("PSJ1",$J)
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",0))
 S PSBDFN=PSBPAR1
 S PSBON=+$P(PSBSCRT,U,3)  ; ord num w/o type
 S PSBONX=$P(PSBSCRT,U,3)  ; ord num w/  type "U" or "V"
 S PSBOTYP=$E(PSBONX,$L(PSBONX))
 S PSBPONX=$P(PSBSCRT,U,4)  ; prev ord num
 S PSBFON=$P(PSBSCRT,U,5)  ; foll ord num
 S PSBIVT=$P(PSBSCRT,U,6)  ; IV type
 S PSBISYR=$P(PSBSCRT,U,7)  ; intermit syrg
 S PSBCHEMT=$P(PSBSCRT,U,8)  ; chemo type
 S PSBCPRS=$P(PSBSCRT,U,0)  ; ord file entry (CPRS order #)
 Q:PSBSCRT=-1
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",1))
 S PSBMD=$P(PSBSCRT,U,1)  ; prov IEN -> ^VA(200)
 S PSBMDX=$P(PSBSCRT,U,2)  ; prov name
 S PSBMR=$P(PSBSCRT,U,3)  ; med rt IEN -> ^PS(51.2)
 I $G(PSBMR)'="" S PSBMR=$P(PSBSCRT,U,13)  ;med rt
 S PSBMRAB=$P(PSBSCRT,U,4)  ;med rt abbr
 S PSBNJECT=+$G(^TMP("PSB",$J,"PSBORDA",1,0))  ;Inj site
 S PSBIVPSH=+$P($G(^TMP("PSB",$J,"PSBORDA",1,0)),U,2)  ;IV PUSH
 S PSBSM=$P(PSBSCRT,U,5)  ; self med
 S PSBSMX=$P(PSBSCRT,U,6)  ; expnd to YES/NO
 S PSBHSM=$P(PSBSCRT,U,7)  ; hospital supplied self med
 S PSBHSMX=$P(PSBSCRT,U,8)  ; expnd to YES/NO
 S PSBNGF=$P(PSBSCRT,U,9)  ; not to be given flag
 S PSBOSTS=$P(PSBSCRT,U,10)  ; ord status
 S PSBOSTSX=$P(PSBSCRT,U,11)  ; ord status expans
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",2))
 S PSBOIT=$P(PSBSCRT,U,1)  ; orderable item IEN -> ^ORD(101.43) ORDERABLE ITEM
 S PSBOITX=$P(PSBSCRT,U,2)  ; orderable item (expaned)_" "_ dosage form
 I PSBOITX="" S PSBOITX="ZZZZ NO ORDERABLE ITEM"
 S PSBDOSE=$P(PSBSCRT,U,3)  ; dosage ordered
 S PSBIFR=$P(PSBSCRT,U,4)  ; infusion rate
 S PSBSCH=$P(PSBSCRT,U,5)  ; sched
 S PSBDOSEF=$P(PSBSCRT,U,6)  ; dosage form
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",3))
 S PSBOTXT=$P(PSBSCRT,U,1)  ; UD special inst or IV other print info
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",4))
 S PSBSCHT=$P(PSBSCRT,U,1)  ; sched type conversion
 S PSBSCHTX=$P(PSBSCRT,U,2)  ; sched type expansion
 S PSBLDT=$P(PSBSCRT,U,3)  ; log-in date FM
 S PSBLDTX=$P(PSBSCRT,U,4)  ; exp MM/DD/YYYY HH:MM
 S PSBOST=$P(PSBSCRT,U,5)  ; start date FM
 S PSBOSTX=$P(PSBSCRT,U,6)  ; exp MM/DD/YYYY HH:MM
 S PSBOSP=$P(PSBSCRT,U,7)  ; stop date FM
 S PSBOSPX=$P(PSBSCRT,U,8) ; exp MM/DD/YYYY HH:MM
 S PSBADST=$P(PSBSCRT,U,9)  ; admin times string in NNNN- format
 S PSBOSCHT=$P(PSBSCRT,U,10)  ; original schedule type
 S PSBFREQ=$P(PSBSCRT,U,11)  ; frequency
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",5))
 S PSBVN=$P(PSBSCRT,U,1)  ; verify nurse IEN -> ^VA(200)
 S PSBVNX=$P(PSBSCRT,U,2)  ; nurse name
 S PSBVNI=$P(PSBSCRT,U,3) ; nurse initials
 S PSBVPH=$P(PSBSCRT,U,4)  ; verify pharm IEN -> ^VA(200)
 S PSBVPHX=$P(PSBSCRT,U,5)  ; pharm name
 S PSBVPHI=$P(PSBSCRT,U,6)  ; pharm initials
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",6))
 S PSBRMRK=$G(PSBSCRT)
 ;If DayOFWeek set frequen to NULL
 I $$PSBDCHK1^PSBVT1(PSBSCH) S PSBFREQ=""
 ; get dispensed drug
 I $G(^TMP("PSB",$J,"PSBORDA",700,0)) F PSBX=1:1:^TMP("PSB",$J,"PSBORDA",700,0) M PSBDDA(PSBX)=^TMP("PSB",$J,"PSBORDA",700,PSBX,0) S PSBDDA(PSBX)="DD^"_PSBDDA(PSBX) ; # of DDrug
 ;     "DD"^dispensed drug IEN -> ^PSDRUG() DRUG^dispensed drug name^units per dose^inactive date
 ; build unique id list
 ; add addits
 I $D(^TMP("PSB",$J,"PSBORDA",800)) S PSBX2="" F  S PSBX2=$O(^TMP("PSB",$J,"PSBORDA",800,PSBX2)) Q:PSBX2=""!(PSBX2="ERROR")  D
 .S PSBUIDA(PSBX2)="ID^"_PSBX2 F J=1:1:^TMP("PSB",$J,"PSBORDA",800,PSBX2,0) S PSBUIDA(PSBX2)=PSBUIDA(PSBX2)_"^"_"ADD;"_$P(^TMP("PSB",$J,"PSBORDA",800,PSBX2,J),U,1)
 ; add soluts
 I $D(^TMP("PSB",$J,"PSBORDA",900)) S PSBX2="" F  S PSBX2=$O(^TMP("PSB",$J,"PSBORDA",900,PSBX2)) Q:PSBX2=""!(PSBX2="ERROR")  D
 .I '$D(PSBUIDA(PSBX2)) S PSBUIDA(PSBX2)="ID^"_PSBX2
 .F J=1:1:^TMP("PSB",$J,"PSBORDA",900,PSBX2,0) S PSBUIDA(PSBX2)=PSBUIDA(PSBX2)_"^"_"SOL;"_$P(^TMP("PSB",$J,"PSBORDA",900,PSBX2,J),U,1)
 ;     "ID"   ^   (piece 2,3),... = type;IEN of each add/sol for this ID ex. "SOL;4"
 ; get addits
 I $G(^TMP("PSB",$J,"PSBORDA",850,0)) F PSBX=1:1:^TMP("PSB",$J,"PSBORDA",850,0) D
 .M PSBADA(PSBX)=^TMP("PSB",$J,"PSBORDA",850,PSBX,0)  ; num of addits
 .S PSBADA(PSBX)="ADD^"_PSBADA(PSBX)
 .S PSBBAGS=$P(PSBADA(PSBX),U,5) I PSBBAGS'="" S PSBBAG=" IN BAG "_$P(PSBBAGS,",",1) D
 ..F I=2:1 S X=$P(PSBBAGS,",",I) Q:X=""  S PSBBAG=PSBBAG_" AND "_X
 .S:PSBBAGS'="" $P(PSBADA(PSBX),U,5)=PSBBAG
 ;     "ADD"^additive IEN -> ^PS(52.6) IV ADDITIVES^additive name^strength^bottle
 ; get soluts
 I $G(^TMP("PSB",$J,"PSBORDA",950,0)) F PSBX=1:1:^TMP("PSB",$J,"PSBORDA",950,0) M PSBSOLA(PSBX)=^TMP("PSB",$J,"PSBORDA",950,PSBX,0) S PSBSOLA(PSBX)="SOL^"_PSBSOLA(PSBX)  ; # of SOLs
 ;   "SOL"   ^   solution IEN -> ^PS(52.7) IV SOLUTIONS^solution name^volume
 ; get label
 I $D(^TMP("PSB",$J,"PSBORDA",1000)) M PSBLBLA=^TMP("PSB",$J,"PSBORDA",1000)
 K ^TMP("PSB",$J,"PSBORDA")
 Q
 ;
LACTION ; get last action info
 S (PSBLADT,PSBLAIEN,PSBLASTS)=""
 I '$D(^PSB(53.79,"AORDX",PSBDFN,PSBONX)) Q
 S PSBLADT=$O(^PSB(53.79,"AORDX",PSBDFN,PSBONX,""),-1)
 S PSBLAIEN=$O(^PSB(53.79,"AORDX",PSBDFN,PSBONX,PSBLADT,""))
 S PSBLASTS=$P(^PSB(53.79,PSBLAIEN,0),U,9)
 Q
 ;
CLEAN ;
 K PSBONX,PSBPONX,PSBFON,PSBOTYP,PSBIVT,PSBISYR,PSBCHEMT,PSBMD,PSBMDX,PSBMR,PSBMRAB,PSBSM,PSBSMX,PSBHSM,PSBHSMX
 K PSBDFN,PSBNGF,PSBOSTS,PSBOSTSX,PSBOIT,PSBOITX,PSBDOSE,PSBIFR,PSBSCH,PSBDOSEF,PSBOTXT,PSBSCHT,PSBSCHTX
 K PSBLDT,PSBLDTX,PSBOST,PSBOSTX,PSBOSP,PSBOSPX,PSBADST,PSBOSCHT,PSBFREQ,PSBVN,PSBVNX,PSBVNI
 K PSBVPH,PSBVPHX,PSBVPHI,PSBDDA,PSBADA,PSBSOLA,PSBUIDA,PSBCPRS,PSBON,PSBRMRK,PSBNJECT,PSBIVPSH
 K PSBLADT,PSBLAIEN,PSBLASTS,PSBBAG,PSBBAGS,PSBLBLA,PSBFOR,PSBSCRT
 Q
