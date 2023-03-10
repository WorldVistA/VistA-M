PSBVT ;BIRMINGHAM/EFC-BCMA ORDER VARIABLES UTILITY ;03/06/16 3:06pm
 ;;3.0;BAR CODE MED ADMIN;**6,3,38,68,74,70,83,106**;Mar 2004;Build 43
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference/IA
 ; EN^PSJBCMA1/2829
 ; ^TMP("PSJ",$J/2828
 ;
 ;*68 Define New Variable (IEN from Med Route file) in Tag PSJ which
 ;    uses the TMP global built by a previous call to PSJBCMA Api.
 ;*70 - define new variable, 1/0 flag for is a Clinic order
 ;    - 1489: Blended PSB*3*74 with PSB*3*70
 ;*83 - create remove string var from new rmst passed PSJBCMA1
 ;*106- add Hazardous Handle & Dispose flags
 ;
PSJ(PSBX1) ;
 S ^TMP("TK PSJ",PSBX1)=""
 S PSBSCRT="^TMP(""PSB"",$J,""PSBORDA"")"
 K @PSBSCRT M @PSBSCRT=^TMP("PSJ",$J,PSBX1)
 S PSBDFN=DFN
 ;
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",0))
 S PSBON=+$P(PSBSCRT,U,3)        ; ord num w/o type
 S PSBONX=$P(PSBSCRT,U,3)        ; ord num w/  type "U" or "V"
 S PSBOTYP=$E(PSBONX,$L(PSBONX)) ; "U" or "V"
 S PSBPONX=$P(PSBSCRT,U,4)       ; prev ord num
 S PSBFON=$P(PSBSCRT,U,5)        ; foll ord num
 S PSBIVT=$P(PSBSCRT,U,6)        ; IV type
 S PSBISYR=$P(PSBSCRT,U,7)       ; intermit syrg
 S PSBCHEMT=$P(PSBSCRT,U,8)      ; chemo type
 S PSBCPRS=$P(PSBSCRT,U,9)       ; ords file entry (CPRS order #)
 S PSBFOR=$P(PSBSCRT,U,10)       ; reason for foll order
 S PSBCLORD=$P(PSBSCRT,U,11)     ; clinic order Name (is a CO)     *70
 ;  send clinic file #44 ien ptr                                   *70
 S PSBCLIEN=$P(PSBSCRT,U,12)                 ;*70
 Q:PSBSCRT=-1
 ;
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",1))
 S PSBMR=$P($G(^TMP("PSB",$J,"PSBORDA",1,0)),U,2)     ; med rt
 S PSBMRAB=$P(PSBSCRT,U,1)       ; med rt abbr
 S PSBMRIEN=+$P($G(^TMP("PSB",$J,"PSBORDA",1,0)),U,4) ; med rt ien *68
 S PSBNJECT=+$G(^TMP("PSB",$J,"PSBORDA",1,0))         ; Inj site
 S PSBIVPSH=+$P($G(^TMP("PSB",$J,"PSBORDA",1,0)),U,3) ; IV PUSH
 S PSBSCHT=$P(PSBSCRT,U,2)       ; sched type conversion
 S PSBSCH=$P(PSBSCRT,U,3)        ; sched
 S PSBOST=$P(PSBSCRT,U,4)        ; strt dte FM
 S PSBOSP=$P(PSBSCRT,U,5)        ; stp dte FM
 S PSBADST=$P(PSBSCRT,U,6)       ; admin times str in NNNN- format
 S PSBOSTS=$P(PSBSCRT,U,7)       ; status
 S PSBNGF=$P(PSBSCRT,U,8)        ; not to be given flag
 S PSBOSCHT=$P(PSBSCRT,U,9)      ; origin sched type
 ;define 4 new MRR type fields                                     *83
 S PSBDOA=$P(PSBSCRT,U,12)       ; duration of administration
 S PSBRMST=$P(PSBSCRT,U,13)      ; removal times str in NNNN- format
 S PSBMRRFL=$P(PSBSCRT,U,14)     ; MRR flag (prompt removal bcma)
 S PSBOPRSP=$P(PSBSCRT,U,15)     ; Order previous Stop date/time
 ;
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",2))
 S PSBDOSE=$P(PSBSCRT,U,1)       ; dosage ordered
 S PSBIFR=$P(PSBSCRT,U,2)        ; infusn rate
 S PSBSM=$P(PSBSCRT,U,3)         ; self med
 S PSBHSM=$P(PSBSCRT,U,4)        ; hospital supplied self med
 ;
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",3))
 S PSBOIT=$P(PSBSCRT,U,1)        ; order item IEN - > ^ORD(101.43)
 S PSBOITX=$P(PSBSCRT,U,2)       ; order item (expand)_" "_dosage form
 I PSBOITX="" S PSBOITX="ZZZZ NO ORDERABLE ITEM"
 S PSBDOSEF=$P(PSBSCRT,U,3)      ; dosage form
 ;
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",4))
 S PSBOTXT=PSBSCRT               ; special inst/other print info
 ;
 ; if any order's medication components involved are flagged 1 for Hazardous, then the whole order is flagged with that hazardous condition.   *106
 ; so init Haz flags to 0 now, then only reset flags if '1 per each medical component tested later.                                            *106
 S (PSBHAZHN,PSBHAZDS)=0
 ;
 ;get disp drug
 I $G(^TMP("PSB",$J,"PSBORDA",700,0)) F PSBX2=1:1:^TMP("PSB",$J,"PSBORDA",700,0) D
 . M PSBDDA(PSBX2)=^TMP("PSB",$J,"PSBORDA",700,PSBX2,0)
 . S PSBDDA(PSBX2)="DD^"_PSBDDA(PSBX2)  ; # of DDrug
 . S:'PSBHAZHN PSBHAZHN=$P(PSBDDA(PSBX2),U,9)          ;*106
 . S:'PSBHAZDS PSBHAZDS=$P(PSBDDA(PSBX2),U,10)         ;*106
 ;     "DD" ^drug file(#50) IEN ^drug name ^units per dose ^inactive date ^ ^ ^high risk med ^remove med ^haz handle ^haz dispose
 ; build unique id list
 ; add additives
 I $D(^TMP("PSB",$J,"PSBORDA",800)) S PSBX2="" F  S PSBX2=$O(^TMP("PSB",$J,"PSBORDA",800,PSBX2)) Q:PSBX2=""!(PSBX2="ERROR")  D
 .S PSBUIDA(PSBX2)="ID^"_PSBX2 F J=1:1:^TMP("PSB",$J,"PSBORDA",800,PSBX2,0) S PSBUIDA(PSBX2)=PSBUIDA(PSBX2)_"^"_"ADD;"_$P(^TMP("PSB",$J,"PSBORDA",800,PSBX2,J),U,1)
 ; add solutions
 I $D(^TMP("PSB",$J,"PSBORDA",900)) S PSBX2="" F  S PSBX2=$O(^TMP("PSB",$J,"PSBORDA",900,PSBX2)) Q:PSBX2=""!(PSBX2="ERROR")  D
 .I '$D(PSBUIDA(PSBX2)) S PSBUIDA(PSBX2)="ID^"_PSBX2
 .F J=1:1:^TMP("PSB",$J,"PSBORDA",900,PSBX2,0) S PSBUIDA(PSBX2)=PSBUIDA(PSBX2)_"^"_"SOL;"_$P(^TMP("PSB",$J,"PSBORDA",900,PSBX2,J),U,1)
 ;     "ID"   ^   (piece 2,3,)... = type;IEN of each add/sol for this ID ex. "SOL;4"
 ; get additives
 I $G(^TMP("PSB",$J,"PSBORDA",850,0)) F PSBX2=1:1:^TMP("PSB",$J,"PSBORDA",850,0) D
 .M PSBADA(PSBX2)=^TMP("PSB",$J,"PSBORDA",850,PSBX2,0)  ; number of additives (exists only for IV)
 .S PSBADA(PSBX2)="ADD^"_PSBADA(PSBX2)
 .S PSBBAGS=$P(PSBADA(PSBX2),U,5) I PSBBAGS'="" S PSBBAG=" IN BAG "_$P(PSBBAGS,",",1) F I=2:1 S X=$P(PSBBAGS,",",I) Q:X=""  S PSBBAG=PSBBAG_" AND "_X
 .S:PSBBAGS'="" $P(PSBADA(PSBX2),U,5)=PSBBAG,$P(PSBADA(PSBX2),U,6)=PSBBAGS
 .S:'PSBHAZHN PSBHAZHN=$P(PSBADA(PSBX2),U,8)           ;*106
 .S:'PSBHAZDS PSBHAZDS=$P(PSBADA(PSBX2),U,9)           ;*106
 .D ZADD(2)          ;*only executes for TEST accounts
 ; "ADD" ^additive IEN PS(52.6) ^additive name ^strength ^bottle ^ ^high risk ^haz handle ^haz dispose
 ;
 ; get solutions
 I $G(^TMP("PSB",$J,"PSBORDA",950,0)) D
 .F PSBX2=1:1:^TMP("PSB",$J,"PSBORDA",950,0) D
 ..M PSBSOLA(PSBX2)=^TMP("PSB",$J,"PSBORDA",950,PSBX2,0)
 ..S PSBSOLA(PSBX2)="SOL^"_PSBSOLA(PSBX2)    ;# of SOL
 ..S:'PSBHAZHN PSBHAZHN=$P(PSBSOLA(PSBX2),U,8)         ;*106
 ..S:'PSBHAZDS PSBHAZDS=$P(PSBSOLA(PSBX2),U,9)         ;*106
 ..D ZSOL(2)         ;*only executes for TEST accounts
 ; "SOL" ^solution IEN PS(52.7) ^solution name ^volume ^ ^ ^high risk ^haz handle ^haz dispose
 ;
 K ^TMP("PSB",$J,"PSBORDA"),PSBX1,PSBX2
 Q
 ;
PSJ1(PSBPAR1,PSBPAR2,PSBIGS2B,PSBEXIST) ; set the variables for an individual order
 S ^TMP("TK PSJ1",PSBPAR1,PSBPAR2)=""
 ;     PSBPAR1 = DFN
 ;     PSBPAR2 = ORDER NUMBER 
 ;     PSBPAR3 = IGNORE "SEND TO BCMA" CLINIC PARAMETER (Label Invalidation)
 S PSBSCRT="^TMP(""PSB"",$J,""PSBORDA"")"
 K @PSBSCRT
 N PSBX
 K ^TMP("PSJ1",$J) D EN^PSJBCMA1(PSBPAR1,PSBPAR2,1,$G(PSBIGS2B),.PSBEXIST)
 M @PSBSCRT=^TMP("PSJ1",$J) K ^TMP("PSJ1",$J)
 ;
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",0))
 S PSBDFN=PSBPAR1
 S PSBON=+$P(PSBSCRT,U,3)        ; ord num w/o type
 S PSBONX=$P(PSBSCRT,U,3)        ; ord num w/  type "U" or "V"
 S PSBOTYP=$E(PSBONX,$L(PSBONX))
 S PSBPONX=$P(PSBSCRT,U,4)       ; prev ord num
 S PSBFON=$P(PSBSCRT,U,5)        ; foll ord num
 S PSBIVT=$P(PSBSCRT,U,6)        ; IV type
 S PSBISYR=$P(PSBSCRT,U,7)       ; intermit syrg
 S PSBCHEMT=$P(PSBSCRT,U,8)      ; chemo type
 S PSBCPRS=$P(PSBSCRT,U,9)       ; ord file entry (CPRS order #)
 S PSBCLORD=$P(PSBSCRT,U,11)     ; clinic order Name (is a CO)     *70
 ;  send clinic file #44 ien ptr                                   *70
 S PSBCLIEN=$S(PSBCLORD]"":$P(PSBSCRT,U,12),1:"")                 ;*70
 Q:PSBSCRT=-1
 ;
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",1))
 S PSBMD=$P(PSBSCRT,U,1)         ; prov IEN -> ^VA(200)
 S PSBMDX=$P(PSBSCRT,U,2)        ; prov name
 S PSBMR=$P(PSBSCRT,U,3)         ; med rt IEN -> ^PS(51.2)
 I $G(PSBMR)'="" S PSBMR=$P(PSBSCRT,U,13)              ; med rt
 S PSBMRAB=$P(PSBSCRT,U,4)  ;med rt abbr
 S PSBMRIEN=+$P($G(^TMP("PSB",$J,"PSBORDA",1,0)),U,4)  ; med rt ien added in PSB*3*74   ;[*70-1489]
 S PSBNJECT=+$G(^TMP("PSB",$J,"PSBORDA",1,0))          ; Inj site
 S PSBIVPSH=+$P($G(^TMP("PSB",$J,"PSBORDA",1,0)),U,2)  ; IV PUSH
 S PSBSM=$P(PSBSCRT,U,5)         ; self med
 S PSBSMX=$P(PSBSCRT,U,6)        ; expnd to YES/NO
 S PSBHSM=$P(PSBSCRT,U,7)        ; hospital supplied self med
 S PSBHSMX=$P(PSBSCRT,U,8)       ; expnd to YES/NO
 S PSBNGF=$P(PSBSCRT,U,9)        ; not to be given flag
 S PSBOSTS=$P(PSBSCRT,U,10)      ; ord status
 S PSBOSTSX=$P(PSBSCRT,U,11)     ; ord status expans
 ;
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",2))
 S PSBOIT=$P(PSBSCRT,U,1)        ; orderable item IEN -> ^ORD(101.43) ORDERABLE ITEM
 S PSBOITX=$P(PSBSCRT,U,2)       ; orderable item (expaned)_" "_ dosage form
 I PSBOITX="" S PSBOITX="ZZZZ NO ORDERABLE ITEM"
 S PSBDOSE=$P(PSBSCRT,U,3)       ; dosage ordered
 S PSBIFR=$P(PSBSCRT,U,4)        ; infusion rate
 S PSBSCH=$P(PSBSCRT,U,5)        ; sched
 S PSBDOSEF=$P(PSBSCRT,U,6)      ; dosage form
 ;
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",3))
 S PSBOTXT=$P(PSBSCRT,U,1)       ; UD specl inst or IV oth print info
 ;
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",4))
 S PSBSCHT=$P(PSBSCRT,U,1)       ; sched type conversion
 S PSBSCHTX=$P(PSBSCRT,U,2)      ; sched type expansion
 S PSBLDT=$P(PSBSCRT,U,3)        ; log-in date FM
 S PSBLDTX=$P(PSBSCRT,U,4)       ; exp MM/DD/YYYY HH:MM
 S PSBOST=$P(PSBSCRT,U,5)        ; start date FM
 S PSBOSTX=$P(PSBSCRT,U,6)       ; exp MM/DD/YYYY HH:MM
 S PSBOSP=$P(PSBSCRT,U,7)        ; stop date FM
 S PSBOSPX=$P(PSBSCRT,U,8)       ; exp MM/DD/YYYY HH:MM
 S PSBADST=$P(PSBSCRT,U,9)       ; admin times string in NNNN- format
 S PSBOSCHT=$P(PSBSCRT,U,10)     ; original schedule type
 S PSBFREQ=$P(PSBSCRT,U,11)      ; frequency
 ;define 4 new MRR type fields                                     *83
 S PSBDOA=$P(PSBSCRT,U,12)       ; duration of administration
 S PSBRMST=$P(PSBSCRT,U,13)      ; removal times str in NNNN- format
 S PSBMRRFL=$P(PSBSCRT,U,14)     ; MRR flag (prompt removal bcma)
 S PSBOPRSP=$P(PSBSCRT,U,15)     ; Order previous Stop date/time
 ;
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",5))
 S PSBVN=$P(PSBSCRT,U,1)         ; verify nurse IEN -> ^VA(200)
 S PSBVNX=$P(PSBSCRT,U,2)        ; nurse name
 S PSBVNI=$P(PSBSCRT,U,3)        ; nurse initials
 S PSBVPH=$P(PSBSCRT,U,4)        ; verify pharm IEN -> ^VA(200)
 S PSBVPHX=$P(PSBSCRT,U,5)       ; pharm name
 S PSBVPHI=$P(PSBSCRT,U,6)       ; pharm initials
 ;
 S PSBSCRT=$G(^TMP("PSB",$J,"PSBORDA",6))
 S PSBRMRK=$G(PSBSCRT)
 ;If DayOFWeek set frequen to NULL
 I $$PSBDCHK1^PSBVT1(PSBSCH) S PSBFREQ=""
 ;
 ; if any order's medication components involved are flagged 1 for Hazardous, then the whole order is flagged with that hazardous condition.   *106
 ; so init Haz flags to 0 now, then only reset flags if '1 per each medical component tested later.                                            *106
 S (PSBHAZHN,PSBHAZDS)=0
 ;
 ;get dispensed drug
 I $G(^TMP("PSB",$J,"PSBORDA",700,0)) F PSBX=1:1:^TMP("PSB",$J,"PSBORDA",700,0) D               ; # of DDrug
 . M PSBDDA(PSBX)=^TMP("PSB",$J,"PSBORDA",700,PSBX,0)
 . S PSBDDA(PSBX)="DD^"_PSBDDA(PSBX)
 . S:'PSBHAZHN PSBHAZHN=$P(PSBDDA(PSBX),U,9)         ;*106
 . S:'PSBHAZDS PSBHAZDS=$P(PSBDDA(PSBX),U,10)        ;*106
 ;     "DD" ^drug file(#50) IEN ^drug name ^units per dose ^inactive date ^ ^ ^high risk med ^remove med ^haz handle ^haz dispose
 ; build unique id list
 ; add additives
 I $D(^TMP("PSB",$J,"PSBORDA",800)) S PSBX2="" F  S PSBX2=$O(^TMP("PSB",$J,"PSBORDA",800,PSBX2)) Q:PSBX2=""!(PSBX2="ERROR")  D
 .S PSBUIDA(PSBX2)="ID^"_PSBX2 F J=1:1:^TMP("PSB",$J,"PSBORDA",800,PSBX2,0) S PSBUIDA(PSBX2)=PSBUIDA(PSBX2)_"^"_"ADD;"_$P(^TMP("PSB",$J,"PSBORDA",800,PSBX2,J),U,1)
 ; add solutions
 I $D(^TMP("PSB",$J,"PSBORDA",900)) S PSBX2="" F  S PSBX2=$O(^TMP("PSB",$J,"PSBORDA",900,PSBX2)) Q:PSBX2=""!(PSBX2="ERROR")  D
 .I '$D(PSBUIDA(PSBX2)) S PSBUIDA(PSBX2)="ID^"_PSBX2
 .F J=1:1:^TMP("PSB",$J,"PSBORDA",900,PSBX2,0) S PSBUIDA(PSBX2)=PSBUIDA(PSBX2)_"^"_"SOL;"_$P(^TMP("PSB",$J,"PSBORDA",900,PSBX2,J),U,1)
 ;     "ID"   ^   (piece 2,3),... = type;IEN of each add/sol for this ID ex. "SOL;4"
 ; get additives
 I $G(^TMP("PSB",$J,"PSBORDA",850,0)) F PSBX=1:1:^TMP("PSB",$J,"PSBORDA",850,0) D
 .M PSBADA(PSBX)=^TMP("PSB",$J,"PSBORDA",850,PSBX,0)  ; num of addits
 .S PSBADA(PSBX)="ADD^"_PSBADA(PSBX)
 .S PSBBAGS=$P(PSBADA(PSBX),U,5) I PSBBAGS'="" S PSBBAG=" IN BAG "_$P(PSBBAGS,",",1) D
 ..F I=2:1 S X=$P(PSBBAGS,",",I) Q:X=""  S PSBBAG=PSBBAG_" AND "_X
 .S:PSBBAGS'="" $P(PSBADA(PSBX),U,5)=PSBBAG
 .S:'PSBHAZHN PSBHAZHN=$P(PSBADA(PSBX),U,8)          ;*106
 .S:'PSBHAZDS PSBHAZDS=$P(PSBADA(PSBX),U,9)          ;*106
 .D ZADD(1)   ;*only executes for TEST accounts on piece 12
 ; "ADD" ^additive IEN PS(52.6) ^additive name ^strength ^bottle ^ ^high risk ^haz handle ^haz dispose
 ;
 ; get solutions
 I $G(^TMP("PSB",$J,"PSBORDA",950,0)) D
 .F PSBX=1:1:^TMP("PSB",$J,"PSBORDA",950,0) D
 ..M PSBSOLA(PSBX)=^TMP("PSB",$J,"PSBORDA",950,PSBX,0)
 ..S PSBSOLA(PSBX)="SOL^"_PSBSOLA(PSBX)  ; # of SOLs
 ..S:'PSBHAZHN PSBHAZHN=$P(PSBSOLA(PSBX),U,8)        ;*106
 ..S:'PSBHAZDS PSBHAZDS=$P(PSBSOLA(PSBX),U,9)        ;*106
 ..D ZSOL(1)  ;*only executes for TEST accounts on piece 12
 ; "SOL" ^solution IEN PS(52.7) ^solution name ^volume ^ ^ ^high risk ^haz handle ^haz dispose
 ;
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
 K PSBCLIEN,PSBCLORD   ;*70
 K PSBMRIEN   ;*68
 K PSBDOA,PSBRMST,PSBMRRFL,PSBOPRSP   ;*83
 K PSBHAZHN,PSBHAZDS   ;*106
 Q
 ;
ZADD(XX) ;appends pointer to Drug file #50 for additives - Results(12)   *106 piece 9 & 10 now have valid HAZ info
 ;*test mode only, drug ien stuffed in
 Q:$$PROD^XUPROD    ;quit if a production account
 S:XX=1 $P(PSBADA(PSBX),U,12)=$P($G(^PS(52.6,$P(PSBADA(PSBX),U,2),0)),U,2)
 S:XX=2 $P(PSBADA(PSBX2),U,12)=$P($G(^PS(52.6,$P(PSBADA(PSBX2),U,2),0)),U,2)
 Q
 ;
ZSOL(XX) ;appends pointer to Drug file #50 for solutions - Results(12)   *106 piece 8 & 9 now have valid HAZ info
 ;*test mode only, drug ien stuffed in
 Q:$$PROD^XUPROD    ;quit if a production account
 S:XX=1 $P(PSBSOLA(PSBX),U,12)=$P($G(^PS(52.7,$P(PSBSOLA(PSBX),U,2),0)),U,2)
 S:XX=2 $P(PSBSOLA(PSBX2),U,12)=$P($G(^PS(52.7,$P(PSBSOLA(PSBX2),U,2),0)),U,2)
 Q
