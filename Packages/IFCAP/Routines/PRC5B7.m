PRC5B7 ;WISC/PLT-IFCAP post install routine defined in package file ;10/31/94  3:40 PM
V ;;5.0;IFCAP;**27**;4/21/95
 ;
 ;invoke by the post initial installation field of package file.
EN ;
 D EN^DDIOL("IFCAP V5 RECONVERT FND/CPF-DOCUMENT STARTS at "_$$NOW^PRC5A)
 D FND^PRC5B1 ;convert fms FND document (add fund code in file 420.3)
 ;RESET FND-DOC CONVERTED START/ENDING TIME TO BE NIL
 D
 . N PRCRI
 . S PRCRI(420.92)=""
 . F  S PRCRI(420.92)=$O(^PRCU(420.92,"B","CPF",PRCRI(420.92))) Q:'PRCRI(420.92)  S PRCA=^PRCU(420.92,PRCRI(420.92),0),$P(PRCA,"^",5,6)="^",^(0)=PRCA
 . QUIT
 D CPF^PRC5B1 ;convert fms CPF document (fill-in fms field for file 420)
 D EN^DDIOL("IFCAP V5 RECONVERT FND/CPF-DOCUMENT ENDS at "_$$NOW^PRC5A)
 QUIT
 ;
START(PRCAFC) ;restart 442 conversion with options
 ;PRCAFC=1 if mo/so only and deleting fcp yearly accounting elements
 ;      =2 if not including mo/so
 ;      =3 if mo/so only
 ;      ='ALL' if reconvert all (including mo/so)
 ;deleting fcp yearly accounting elements
 D:PRCAFC=1!(PRCAFC="ALL") FCPFY,EN^PRC5B7A
 QUIT
 ;
FCPFY ;delete all fcp fiscal yearly accounting elements
 N PRCRI,PRCY
 S PRCRI(420)=0 F  S PRCRI(420)=$O(^PRC(420,PRCRI(420))) Q:'PRCRI(420)  D
 . S PRCRI(420.01)=0
 . F  S PRCRI(420.01)=$O(^PRC(420,PRCRI(420),1,PRCRI(420.01))) Q:'PRCRI(420.01)  D
 .. S PRCFY=11
 .. F  S PRCFY=$O(^PRC(420,PRCRI(420),1,PRCRI(420.01),4,PRCFY)) Q:'PRCFY  I $D(^(PRCFY,2)) K ^(2)
 .. QUIT
 . QUIT
 QUIT
 ;
 ;
CONVALL ;convert all 442 and generate mo/so
 S PRCAFC="ALL"
 QUIT
 ;
NEWMOSO ;build mo/so and delete fcp yearly accounting elements
 S PRCAFC=1
 QUIT
 QUIT
 ;
BOC ;reconvert boc with no mo/so
 S PRCAFC=2
 QUIT
 ;
REMOSO ;rebuild mo/so only without deleting fcp yearly account elements
 S PRCAFC=3
 QUIT
 ;
SPFCP() ;checkactive supply/general post fcp accounting elements
 N PRCRI,PRCA,A
 S PRCA="" D EN^DDIOL(" ")
 S PRCRI(420)=0 F  S PRCRI(420)=$O(^PRC(420,"AD",1,PRCRI(420))) Q:'PRCRI(420)  D
 . S A=$O(^PRC(420,PRCRI(420),1,"C","GPFS FMS CONVERSION",0))
 . I A,'$D(^PRC(420,PRCRI(420),1,A,5)) S A=""
 . S PRCRI(420.01)=0 F  S PRCRI(420.01)=$O(^PRC(420,"AD",1,PRCRI(420),PRCRI(420.01))) QUIT:'PRCRI(420.01)  I '$P($G(^PRC(420,PRCRI(420),1,PRCRI(420.01),0)),"^",19),'A S PRCA="*" W PRCRI(420),"-",PRCRI(420.01),"   "
 I PRCA["*" D EN^DDIOL("The above 'station-fcp' GENERAL POST fund control points have active status and the dummy 'GPFS FMS CONVERSION' has no ACCOUNTING ELEMENTS")
 D EN^DDIOL(" ")
 S PRCRI(420)=0 F  S PRCRI(420)=$O(^PRC(420,"AD",2,PRCRI(420))) Q:'PRCRI(420)  D
 . S PRCRI(420.01)=0 F  S PRCRI(420.01)=$O(^PRC(420,"AD",2,PRCRI(420),PRCRI(420.01))) QUIT:'PRCRI(420.01)  I '$P($G(^PRC(420,PRCRI(420),1,PRCRI(420.01),0)),"^",19),'$D(^(5)) S:PRCA'["#" PRCA=PRCA_"#" W PRCRI(420),"-",PRCRI(420.01),"   "
 . I PRCA["#" D EN^DDIOL("The above 'station-fcp' SUPPLY FUND control points have active status and have  no ACCOUNTING ELEMENTS.")
 I PRCA]"" D EN^DDIOL("You must correct this before you run option 3 or 4.")
 QUIT PRCA
 ;
CEIL96 ;reset 1 to 4 qtr code sheet released? field from PRC5B
 N PRCRI,PRCA,PRCB,PRCC
 N A
 S PRCRI(420)=0 F  S PRCRI(420)=$O(^PRC(420,PRCRI(420))) QUIT:'PRCRI(420)  D
 . S PRCA=PRCRI(420)_"-"_96,PRCB=PRCA F  S PRCB=$O(^PRCF(421,"B",PRCB)) QUIT:PRCB-PRCA!'PRCB  S PRCRI(421)=$O(^(PRCB,"")) I PRCRI(421),$P(PRCB,"-",3) D:$D(^PRCF(421,PRCRI(421),0))
 .. S PRCC=^PRCF(421,PRCRI(421),0),A=$P(PRCC,"^",2),A=$P(A," ")
 .. S PRCC=$$BBFY^PRCSUT(PRCRI(420),$P(PRCB,"-",2),A,1)
 .. S $P(^PRCF(421,PRCRI(421),0),"^",23)=PRCC-1700_"0000"
 .. I $D(^PRCF(421,PRCRI(421),4)) F PRCC=1:1:4 S $P(^(4),"^",PRCC)=""
 .. QUIT
 . QUIT
 QUIT
