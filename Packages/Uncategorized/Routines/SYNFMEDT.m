SYNFMEDT ;OSE/SMH - Unit Tests for Synthetic Medications;Jun 11 2018
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 D EN^%ut($T(+0),2,1)
 QUIT
 ;
STARTUP ; M-Unit Startup
 ; ZEXCEPT: DFN,DRGRXN
 N DA,DIK
 S DRGRXN=313195
 S DFN=1
 N DRG S DRG=$$ADDDRUG^SYNFMED(DRGRXN) ; This finds it and also creates it; but normally it will be there from previous test runs
 D KILLONEDRUG(DRG)
 ;
 ; Delete patient rx data
 N DIU S DIU(0)="" ; Tell the pharmacy package that we are Fileman doing dirty cleanup work.
 N PSOI F PSOI=0:0 S PSOI=$O(^PS(55,DFN,"P",PSOI)) Q:'PSOI  D
 . N RXIEN S RXIEN=^PS(55,DFN,"P",PSOI,0)
 . I $D(^PSRX(RXIEN,"OR1")) N ORNUM S ORNUM=$P(^("OR1"),U,2) S DA=ORNUM,DIK="^OR(100," D ^DIK
 . S DIK="^PSRX(",DA=RXIEN D ^DIK
 S DA=DFN,DIK="^PS(55," D ^DIK
 ;
 QUIT
 ;
SHUTDOWN ; M-Unit Shutdown
 ; ZEXCEPT: DFN,DRGRXN
 K DFN
 K DRGRXN
 QUIT
 ;
T0 ; @TEST Test $$ETSRXN2VUID^SYNFMED API
 D CHKTF^%ut($$ETSRXN2VUID^SYNFMED(831533)["50.68~4031994~ERRIN 0.35MG TAB,28")
 D CHKTF^%ut($$ETSRXN2VUID^SYNFMED(70618)["50.6~4019880~PENICILLIN")
 D CHKTF^%ut($$ETSRXN2VUID^SYNFMED(198211)["50.68~4016607~SIMVASTATIN 40MG TAB,UD")
 D CHKTF^%ut($$ETSRXN2VUID^SYNFMED(313195)["50.68~4004891~TAMOXIFEN CITRATE 20MG TAB")
 D CHKTF^%ut($$ETSRXN2VUID^SYNFMED(1009219)["50.6~4030995~ALISKIREN/AMLODIPINE")
 D CHKTF^%ut($$ETSRXN2VUID^SYNFMED(309110)["50.68~4007024~CEPHALEXIN 125MG/5ML SUSP")
 D CHKTF^%ut($$ETSRXN2VUID^SYNFMED(2231)["50.6~4018891~CEPHALEXIN")
 D CHKTF^%ut($$ETSRXN2VUID^SYNFMED(10582)["50.6~4022126~LEVOTHYROXINE")
 QUIT
 ;
T1 ; @TEST Test get VUIDs
 D CHKTF^%ut($$RXN2VUI^SYNFMED(1014675)[4033356)
 D CHKTF^%ut($$RXN2VUI^SYNFMED(197379)[4014051)
 QUIT
 ;
T2 ; @TEST Get Local Matches for VUID (no actual tests as drug file is local)
 W " "
 W $$MATCHV1^SYNFMED(4004876)," "
 W $$MATCHV1^SYNFMED(4033365)," "
 W $$MATCHV1^SYNFMED(4014051)," "
 D SUCCEED^%ut
 QUIT
 ;
T3 ; @TEST Get Local Matches for RxNorm (no actual tests as drug file is local)
 W $$RXN2MEDS^SYNFMED(1014675)," " ; Ceterizine capsule
 W $$RXN2MEDS^SYNFMED(197379)," "  ; Atenolol 100
 W $$RXN2MEDS^SYNFMED(1085640)," " ;  Triamcinolone Acetonide 0.005 MG/MG Topical Ointment
 D SUCCEED^%ut
 QUIT
 ;
T4 ; @TEST Write Rx Using Drug IEN
 ; ZEXCEPT: DFN,DRGRXN
 N DA,DIK
 N DRUG S DRUG=$$ADDDRUG^SYNFMED(DRGRXN)
 N RXN S RXN=$$WRITERXPS^SYNFMED(DFN,DRUG,DT)
 N RXIEN S RXIEN=$$FIND1^DIC(52,,"QX",RXN,"B")
 N RX0 S RX0=^PSRX(RXIEN,0)
 N PAT S PAT=$P(RX0,U,2)
 N DRG S DRG=$P(RX0,U,6)
 D CHKEQ^%ut(PAT,1,"Patient is not correct")
 D CHKEQ^%ut(DRG,DRUG,"Drug is not correct")
 D CHKTF^%ut($O(^PSRX(RXIEN,"L",0)),"Label does not exist")
 D CHKTF^%ut($$GET1^DIQ(52,RXIEN,"RELEASED DATE/TIME","I"),"Release date/time doesn't exist")
 QUIT
 ;
T5 ; @TEST Write Rx Using Drug RxNorm SCD
 ; ZEXCEPT: DFN,DRGRXN
 N RXN S RXN=$$WRITERXRXN^SYNFMED(DFN,DRGRXN,DT) ; Tamoxifen Citrate 20mg tab
 N RXIEN S RXIEN=$$FIND1^DIC(52,,"QX",RXN,"B")
 N RX0 S RX0=^PSRX(RXIEN,0)
 N PAT S PAT=$P(RX0,U,2)
 N DRG S DRG=$P(RX0,U,6)
 N DRGNM S DRGNM=$P(^PSDRUG(DRG,0),U)
 D CHKEQ^%ut(PAT,1,"Patient is not correct")
 D CHKTF^%ut(DRGNM["TAMOXIFEN","Drug is not correct")
 D CHKTF^%ut($O(^PSRX(RXIEN,"L",0)),"Label does not exist")
 D CHKTF^%ut($$GET1^DIQ(52,RXIEN,"RELEASED DATE/TIME","I"),"Release date/time doesn't exist")
 QUIT
 ;
T55 ; @TEST Write an Rx with a bad Rxnorm number
 ; ZEXCEPT: DFN,DRGRXN
 N RXN S RXN=$$WRITERXRXN^SYNFMED(DFN,989892842342,DT) ; Tamoxifen Citrate 20mg tab
 D CHKTF^%ut(RXN<0)
 QUIT
 ;
T56 ; @TEST Write an Rx with no NDCs on the market
 ; ZEXCEPT: DFN,DRGRXN
 N RXN S RXN=$$WRITERXRXN^SYNFMED(DFN,282464,DT) ; Acetaminophen 160 MG Oral Tablet
 D CHKTF^%ut(RXN>0)
 QUIT
 ;
T57 ; @TEST Write an Rx with mulitple matches for drug
 ; doesn't cause a crash on my system, but here for George and company to test
 ; ZEXCEPT: DFN,DRGRXN
 N RXN S RXN=$$WRITERXRXN^SYNFMED(DFN,313782,DT) ; Acetaminophen 325 MG Oral Tablet
 D CHKTF^%ut(RXN>0)
 QUIT
 ;
T58 ; @TEST Write an Rx with Lirugatide (RXN # 897122)
 ; ZEXCEPT: DFN,DRGRXN
 N RXN S RXN=$$WRITERXRXN^SYNFMED(DFN,897122,DT) ; Acetaminophen 325 MG Oral Tablet
 D CHKTF^%ut(RXN>0)
 QUIT
VUI2VAPT ; @TEST Get VA Product IEN from VUID
 N L F L=1:1 N LN S LN=$T(VUI2VAPD+L) Q:LN["<<END>>"  Q:LN=""  D
 . N VUID S VUID=$P(LN,";",3)
 . N VAP S VAP=$P(LN,";",4)
 . D CHKEQ^%ut($$VUI2VAP^SYNFMED(VUID),VAP,"Translation from VUID to VA PRODUCT failed")
 QUIT
 ;
VUI2VAPD ; @DATA - Data for above test
 ;;4006455;5932
 ;;4002369;1784
 ;;4000874;252
 ;;4003335;2756
 ;;4002469;1884
 ;;4009488;9046^10090
 ;;<<END>>
 ;
T6 ; @TEST Get NDCs for a drug
 D CHKTF^%ut($$RXN2NDC^SYNFMED(198211)["16252050890")
 QUIT
 ;
T7 ; @TEST Analysis of meds that don't load
 N I,T F I=1:1 S T=$T(T7L+I),T=$P(T,";;",2) Q:T=""  D
 . N SCD S SCD=$$ETSCONV^SYNFMED(T)
 . I 'SCD QUIT
 . N % S %=$$GETDATA^ETSRXN(SCD)
 . D CHKTF^%ut(%)
 . D CHKTF^%ut($$ETSISSCD^SYNFMED(SCD)!$$ETSISBPCK^SYNFMED(SCD))
 QUIT
 ;
T7L ; @DATA
 ;;239981
 ;;308056
 ;;316049
 ;;316672
 ;;389128
 ;;392151
 ;;477045
 ;;564666
 ;;568530
 ;;573839
 ;;575020
 ;;575971
 ;;596927
 ;;602735
 ;;607015
 ;;608680
 ;;617944
 ;;646250
 ;;727316
 ;;727374
 ;;824184
 ;;831533
 ;;834060
 ;;834101
 ;;849437
 ;;849727
 ;;896188
 ;;904420
 ;;996741
 ;;997221
 ;;1000128
 ;;1000158
 ;;1020137
 ;;1049544
 ;;1049639
 ;;1091166
 ;;1094108
 ;;1111011
 ;;1359133
 ;;1366342
 ;;1536586
 ;;1602593
 ;;1648767
 ;;1803932
 ;;
T8 ; @TEST Add drugs for patients from T7L
 ; ZEXCEPT: DFN,DRGRXN
 N SYNI,SYNT F SYNI=1:1 S SYNT=$T(T7L+SYNI),SYNT=$P(SYNT,";;",2) Q:SYNT=""  D
 . ; W SYNT," "
 . N RXN S RXN=$$WRITERXRXN^SYNFMED(DFN,SYNT,DT)
 . ; W RXN,!
 . D CHKTF^%ut(RXN>0,RXN)
 QUIT
 ;
KILLDRUG ; [Public] Remove all Drug Data
 ; WARNING: DO NOT CALL THIS UNLESS YOU ARE ON A BRAND NEW SYSTEM AND ARE TESTING.
 D DT^DICRW ; Min FM Vars
 D MES^XPDUTL("Killing Drug (50)") D DRUG
 D MES^XPDUTL("Killing Pharmacy Orderable Item (OI) (50.7)") D PO
 D MES^XPDUTL("Killing Drug Text (51.7)") D DRUGTEXT
 D MES^XPDUTL("Killing IV Additives (52.6)") D IVADD
 D MES^XPDUTL("Killing IV Solutions (52.7)") D IVSOL
 D MES^XPDUTL("Killing Drug Electrolytes (50.4)") D DRUGELEC
 D MES^XPDUTL("Removing Pharmacy OIs from the Orderable Item (101.43)") D O
 D MES^XPDUTL("Syncing the Order Quick View (101.44)") D CPRS
 QUIT
 ;
KILLONEDRUG(DRG) ; [Public] Kill just one drug
 ; Called by the Unit Test
 ;
 ; Get OI
 N DIK,DA
 N OI S OI=+^PSDRUG(DRG,2)
 ;
 ; Delete drug
 S DA=DRG,DIK="^PSDRUG(" D ^DIK
 I 'OI QUIT
 ;
 ; Delete OI
 S DA=OI,DIK="^PS(50.7," D ^DIK
 ;
 ; Delete CPRS synced version of OI
 N OERROI S OERROI=$O(^ORD(101.43,"ID",OI_";99PSP",""))
 I OERROI S DIK="^ORD(101.43,",DA=OERROI D ^DIK
 ;
 ; Update CPRS view of pharmacy OIs
 D CPRS
 QUIT
 ;
RESTOCK ; [Public] Restock CPRS Orderable Items from new Drug & Pharmacy Orderable Item
 ; File. Public Entry Point.
 ; Call this after repopulating the drug file (50) and the pharmacy orderable
 ; item file (50.7)
 N PSOIEN ; Looper variable
 D DT^DICRW ; Establish FM Basic Variables
 ;
 ; Loop through Orderable Item file and call
 ; 1. The Active/Inactive Updater for the Orderable Item
 ; 2. the protocol file updater to CPRS Files
 S PSOIEN=0 F  S PSOIEN=$O(^PS(50.7,PSOIEN)) Q:'PSOIEN  D
 . D MES^XPDUTL("Syncing Pharamcy Orderable Item "_PSOIEN)
 . D EN^PSSPOIDT(PSOIEN),EN2^PSSHL1(PSOIEN,"MUP")
 D CPRS ; Update Orderable Item View files
 QUIT
 ;
 ; -- END Public Entry Points --
 ;
 ; -- The rest is private --
DRUG ; Kill Drug File; Private
 N DA,DIK
 S DIK="^PSDRUG("
 F DA=0:0 S DA=$O(^PSDRUG(DA)) Q:'DA  D ^DIK
 S $P(^PSDRUG(0),U,3,4)=""
 K ^DIA(50)
 QUIT
 ;
PO ; Kill Pharmacy Orderable Items; Private
 N %1 S %1=^PS(50.7,0)
 K ^PS(50.7)
 S ^PS(50.7,0)=%1
 S $P(^PS(50.7,0),"^",3,4)=""
 QUIT
 ;
DRUGTEXT ; Kill Drug Text Entries ; Private
 N %1 S %1=^PS(51.7,0)
 K ^PS(51.7)
 S ^PS(51.7,0)=%1
 S $P(^PS(51.7,0),"^",3,4)=""
 QUIT
 ;
IVADD ; Kill IV Additives ; Private
 N %1 S %1=^PS(52.6,0)
 K ^PS(52.6)
 S ^PS(52.6,0)=%1
 S $P(^PS(52.6,0),"^",3,4)=""
 QUIT
 ;
IVSOL ; Kill IV Solutions ; Private
 N %1 S %1=^PS(52.7,0)
 K ^PS(52.7)
 S ^PS(52.7,0)=%1
 S $P(^PS(52.7,0),"^",3,4)=""
 QUIT
 ;
DRUGELEC ; Kill Drug Electrolytes ; Private
 N %1 S %1=^PS(50.4,0)
 K ^PS(50.4)
 S ^PS(50.4,0)=%1
 S $P(^PS(50.4,0),"^",3,4)=""
 QUIT
 ;
O ; Kill off Pharamcy Order Items (Only!) in the Orderable Item file; Private
 N DA ; Used in For loop below
 N DIK S DIK="^ORD(101.43,"
 N I S I=0
 FOR  S I=$O(^ORD(101.43,"ID",I)) QUIT:I=""  DO
 . I I["PSP" S DA=$O(^ORD(101.43,"ID",I,"")) D ^DIK
 QUIT
 ;
CPRS ; Now, update the CPRS lists (sync with Orderable Item file) -
 ; Uses a CPRS API to do this; Private
 ; Next 3 variables are required as inputs
 N ATTEMPT S ATTEMPT=0 ; Attempt to Update
 N UPDTIME S UPDTIME=$HOROLOG ; Update Time
 N DGNM ; Dialog Name
 ; IVA RX -> Additives; IVB RX -> Solutions
 ; IVM RX -> Inpatient Meds for Outpatients
 ; NV RX -> Non-VA Meds ; O RX -> Outpatient
 ; UD RX -> Unit Dose
 FOR DGNM="IVA RX","IVB RX","IVM RX","NV RX","O RX","UD RX" DO
 . D MES^XPDUTL(" --> Rebuilding "_DGNM)
 . D FVBLD^ORWUL
 QUIT
 ;
