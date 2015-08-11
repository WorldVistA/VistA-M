ORY391 ; ISL/JER - Anticoagulation Management Installation ;11/26/14  08:59
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**391**;Dec 17, 1997;Build 11
 ;;Per VHA Directive 2004-038, this routine should not be modified
 Q
PRE ; Pre-install routine
 N DA,DIK
 ; find/delete ORAM SITE PARAMETERS template
 D BMES^XPDUTL(" Executing Pre-Install Routine...")
 S DA=$$FIND1^DIC(8989.52,"","X","ORAM SITE PARAMETERS","","","")
 S DIK="^XTV(8989.52,"
 D ^DIK
 Q
POST ; Post-install routine
 D REGRPCS
 D PARAM
 Q
 ;
REGRPCS ; Register RPCS
 D BMES^XPDUTL(" Registering RPCs with Context Menu ORAM ANTICOAGULATION CONTEXT...")
 D REGISTER("ORAM ANTICOAGULATION CONTEXT","ORWLEX GETFREQ")
 D REGISTER("ORAM ANTICOAGULATION CONTEXT","ORWLEX GETI10DX")
 D REGISTER("ORAM ANTICOAGULATION CONTEXT","ORWPCE LEXCODE")
 D REGISTER("ORAM ANTICOAGULATION CONTEXT","ORWPCE4 LEX")
 Q
 ;
REGISTER(OPTION,RPC) ; Call FM Updater to register each RPC
 ; Input  -- OPTION   Option file (#19) Name field (#.01)
 ;           RPC      RPC sub-file (#19.05) RPC field (#.01)
 ; Output -- None
 N FDA,FDAIEN,ERR,DIERR
 S FDA(19,"?1,",.01)=OPTION
 S FDA(19.05,"?+2,?1,",.01)=RPC
 D UPDATE^DIE("E","FDA","FDAIEN","ERR")
 Q
 ;
PARAM ; main (initial) parameter transport routine
 N ORENT,IDX,ROOT,REF,ORVAL,I
 D BMES^XPDUTL(" Installing List of Indications for Care...")
 S ROOT=$NAME(^TMP("ORAMY",$J)) K @ROOT
 D LOAD(ROOT)
 S IDX=0,ORENT="PKG.ORDER ENTRY/RESULTS REPORTING"
 F  S IDX=$O(@ROOT@(IDX)) Q:'IDX  D
 . N ORPAR,ORINST,ORIVAL,OREVAL,ORERR
 . S ORPAR=$P(@ROOT@(IDX,"KEY"),U),ORINST=$P(^("KEY"),U,2)
 . S ORIVAL=$P(@ROOT@(IDX,"VAL"),U),OREVAL=$P(^("VAL"),U,2)
 . D BMES^XPDUTL(" Installing "_ORINST_" = "_OREVAL)
 . D EN^XPAR(ORENT,ORPAR,ORINST,ORIVAL,.ORERR)
 . I +$G(ORERR)>0 D BMES^XPDUTL(" Error Occurred for "_ORINST_" = "_OREVAL_": "_$P(ORERR,U,2))
 K @ROOT
 Q
 ;
LOAD(ROOT) ; load data into ^TMP (expects ROOT to be defined)
 N I,REF
 S I=1,ROOT=$E(ROOT,1,$L(ROOT)-1)_","
 F  S REF=$P($T(DATA+I),";",3,999) Q:REF=""  D
 . N ORVAL
 . S ORVAL=$P($T(DATA+I+1),";",3,999)
 . S @(ROOT_REF)=ORVAL,I=I+2
 Q
 ;
DATA ; parameter data
 ;;1,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^A Fib
 ;;1,"VAL")
 ;;`508208^I48.91
 ;;2,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^A Flutter
 ;;2,"VAL")
 ;;`508209^I48.92
 ;;3,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^Act Prot C Res
 ;;3,"VAL")
 ;;`502779^D68.51
 ;;4,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^Acute MI (within 4 weeks)
 ;;4,"VAL")
 ;;`508039^I21.3
 ;;5,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^Antiphospholipid Synd
 ;;5,"VAL")
 ;;`502782^D68.61
 ;;6,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^CVA (unspecified sequela)
 ;;6,"VAL")
 ;;`508495^I69.30
 ;;7,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^Cerebrovascular Disease
 ;;7,"VAL")
 ;;`508391^I67.89
 ;;8,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^DVT Bilat LE Unspec Veins
 ;;8,"VAL")
 ;;`508955^I82.403
 ;;9,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^DVT LLE Unspecified Veins
 ;;9,"VAL")
 ;;`508954^I82.402
 ;;10,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^DVT RLE Unspecified Veins
 ;;10,"VAL")
 ;;`508953^I82.401
 ;;11,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^DVT Uspec veins, unspec LE
 ;;11,"VAL")
 ;;`508956^I82.409
 ;;12,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^DVT oth spec veins not in LE
 ;;12,"VAL")
 ;;`509045^I82.890
 ;;13,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^Enctr for Tx Drug Monitoring
 ;;13,"VAL")
 ;;`569128^Z51.81
 ;;14,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^Hypercoag State
 ;;14,"VAL")
 ;;`502781^D68.59
 ;;15,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^L/T (Current) Anticoag Tx
 ;;15,"VAL")
 ;;`569395^Z79.01
 ;;16,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^Lupus Anticoag Synd
 ;;16,"VAL")
 ;;`502783^D68.62
 ;;17,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^Old MI (> 4 wks, no curr symp)
 ;;17,"VAL")
 ;;`508064^I25.2
 ;;18,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^Oth Prim Thrombophilia
 ;;18,"VAL")
 ;;`502781^D68.59
 ;;19,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^PE
 ;;19,"VAL")
 ;;`508111^I26.99
 ;;20,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^Prothrombin Gene Mut
 ;;20,"VAL")
 ;;`502780^D68.52
 ;;21,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^TIA
 ;;21,"VAL")
 ;;`504577^G45.9
 ;;22,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^Valve-Mech
 ;;22,"VAL")
 ;;`569742^Z95.2
 ;;23,"KEY")
 ;;ORAM I10 INDICATIONS FOR CARE^Valve-Tissue
 ;;23,"VAL")
 ;;`569743^Z95.3
 ;;24,"KEY")
 ;;ORAM INDICATIONS FOR CARE^A Fib
 ;;24,"VAL")
 ;;`2557^427.31
 ;;25,"KEY")
 ;;ORAM INDICATIONS FOR CARE^A Flutter
 ;;25,"VAL")
 ;;`2558^427.32
 ;;26,"KEY")
 ;;ORAM INDICATIONS FOR CARE^Antiphospholipid Antibodies
 ;;26,"VAL")
 ;;`1052^286.9
 ;;27,"KEY")
 ;;ORAM INDICATIONS FOR CARE^Antithrombin III Deficiency
 ;;27,"VAL")
 ;;`1052^286.9
 ;;28,"KEY")
 ;;ORAM INDICATIONS FOR CARE^Apical Thrombus
 ;;28,"VAL")
 ;;`12480^429.79
 ;;29,"KEY")
 ;;ORAM INDICATIONS FOR CARE^Arterial Thrombosis
 ;;29,"VAL")
 ;;`2628^444.9
 ;;30,"KEY")
 ;;ORAM INDICATIONS FOR CARE^CAD (Coronary Art Dis)
 ;;30,"VAL")
 ;;`12989^414.00
 ;;31,"KEY")
 ;;ORAM INDICATIONS FOR CARE^CHF (Cong Heart Fail)
 ;;31,"VAL")
 ;;`9061^428.0
 ;;32,"KEY")
 ;;ORAM INDICATIONS FOR CARE^CVA
 ;;32,"VAL")
 ;;`2599^437.9
 ;;33,"KEY")
 ;;ORAM INDICATIONS FOR CARE^Cardiomyopathy
 ;;33,"VAL")
 ;;`2535^425.4
 ;;34,"KEY")
 ;;ORAM INDICATIONS FOR CARE^Carotid Stenosis - Plaque
 ;;34,"VAL")
 ;;`12857^433.10
 ;;35,"KEY")
 ;;ORAM INDICATIONS FOR CARE^Cerebrovascular Disease
 ;;35,"VAL")
 ;;`9069^436.
 ;;36,"KEY")
 ;;ORAM INDICATIONS FOR CARE^Clotted Graft
 ;;36,"VAL")
 ;;`12511^996.74
 ;;37,"KEY")
 ;;ORAM INDICATIONS FOR CARE^DVT
 ;;37,"VAL")
 ;;`15011^453.89
 ;;38,"KEY")
 ;;ORAM INDICATIONS FOR CARE^Enctr for Tx Drug Monitoring
 ;;38,"VAL")
 ;;`13529^V58.83
 ;;39,"KEY")
 ;;ORAM INDICATIONS FOR CARE^Hypercoag State
 ;;39,"VAL")
 ;;`13798^289.81
 ;;40,"KEY")
 ;;ORAM INDICATIONS FOR CARE^L/T (Current) Anticoag Use
 ;;40,"VAL")
 ;;`13194^V58.61
 ;;41,"KEY")
 ;;ORAM INDICATIONS FOR CARE^LV Thrombus
 ;;41,"VAL")
 ;;`12480^429.79
 ;;42,"KEY")
 ;;ORAM INDICATIONS FOR CARE^Mesenteric Thrombosis
 ;;42,"VAL")
 ;;`9212^557.0
 ;;43,"KEY")
 ;;ORAM INDICATIONS FOR CARE^PAD (Peripheral Art Dis)
 ;;43,"VAL")
 ;;`2622^443.9
 ;;44,"KEY")
 ;;ORAM INDICATIONS FOR CARE^PE
 ;;44,"VAL")
 ;;`13157^415.19
 ;;45,"KEY")
 ;;ORAM INDICATIONS FOR CARE^Prophylaxis S/P Ortho Surgery
 ;;45,"VAL")
 ;;`13755^V54.89
 ;;46,"KEY")
 ;;ORAM INDICATIONS FOR CARE^Recurrent DVT
 ;;46,"VAL")
 ;;`15003^453.79
 ;;47,"KEY")
 ;;ORAM INDICATIONS FOR CARE^Recurrent PE
 ;;47,"VAL")
 ;;`14990^416.2
 ;;48,"KEY")
 ;;ORAM INDICATIONS FOR CARE^TIA
 ;;48,"VAL")
 ;;`2591^435.9
 ;;49,"KEY")
 ;;ORAM INDICATIONS FOR CARE^Valve-Mech
 ;;49,"VAL")
 ;;`11527^V43.3
 ;;50,"KEY")
 ;;ORAM INDICATIONS FOR CARE^Valve-Tissue
 ;;50,"VAL")
 ;;`11516^V42.2
