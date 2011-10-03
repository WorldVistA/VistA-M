ORYDLG ;SLC/MKB -- Postinit bulletin for order dialogs ;05/01/09  12:16
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**141,165,216,243,280**;Dec 17, 1997;Build 85
 ;
EN(PATCH,ORDLG,USERS) ; -- look for local copies of ORDLG(NAME) by package,
 ;    send list in bulletin to DUZ, POSTMASTER, USERS(DUZ) when done
 ;
 Q:$O(ORDLG(""))=""  ;none
 N ORZ,ORI,X,NM,I,OR0,PKG,DG,ORPKG,ORNATL,DLG,CNT,LR,PS
 S ORZ(1)="The following nationally exported order dialogs have been modified by"
 S X="this patch:   ",ORI=1,NM="" F  S NM=$O(ORDLG(NM)) Q:NM=""  D
 . S ORI=ORI+1,ORZ(ORI)=X_NM,X="              "
 . S I=+$O(^ORD(101.41,"AB",NM,0)),OR0=$G(^ORD(101.41,I,0))
 . S PKG=+$P(OR0,U,7),DG=+$P(OR0,U,5) S:PKG ORPKG(PKG,DG)=""
 . S:$P(NM," ")="LR" LR=1 S:"^PS^PSJ^PSO^PSH^"[(U_$P(NM," ")_U) PS=1
 D:$G(LR) LR D:$G(PS) PS ;reset FORMAT codes in changed dialogs
 S I=0 F I=1:1 S X=$T(NATL+I) Q:X["ZZZZZ"  S ORNATL($P(X,";",3))=""
 S ORI=ORI+1,ORZ(ORI)="Please review and compare the following locally created order dialogs"
 S ORI=ORI+1,ORZ(ORI)="that may be copies, for any necessary changes:",CNT=0
 S PKG=0 F  S PKG=$O(ORPKG(PKG)) Q:PKG<1  S DLG=0 D
 . F  S DLG=+$O(^ORD(101.41,"APKG",PKG,DLG)) Q:DLG<1  D
 .. S OR0=$G(^ORD(101.41,DLG,0))  Q:$P(OR0,U,4)'="D"
 .. Q:'$D(ORPKG(PKG,+$P(OR0,U,5)))  ;included DispGrp
 .. Q:$D(ORNATL($P(OR0,U)))  S CNT=CNT+1
 .. S ORI=ORI+1,ORZ(ORI)=$J(DLG,7)_"  "_$P(OR0,U)
EN1 I CNT>0 D  ;local copies found -> send bulletin
 . N XMDUZ,XMY,I,XMSUB,XMTEXT,DIFROM
 . S XMDUZ="PATCH OR*3*"_$G(PATCH)_" POSTINIT",XMY(.5)=""
 . S:$G(DUZ) XMY(DUZ)="" S I=0 F  S I=$O(USERS(I)) Q:I<1  S XMY(I)=""
 . S XMSUB=XMDUZ_" COMPLETED",XMTEXT="ORZ(" D ^XMD
 . D BMES^XPDUTL("Some national order dialogs have been modified in this patch;")
 . D MES^XPDUTL("a bulletin has been sent to the installer listing local copies that")
 . D MES^XPDUTL("may need to be reviewed and updated.")
 Q
 ;
NATL ;;Nationally exported dialogs
 ;;FHW1
 ;;FHW2
 ;;FHW3
 ;;FHW7
 ;;FHW8
 ;;FHW OP MEAL
 ;;FHW SPECIAL MEAL
 ;;GMRAOR ALLERGY ENTER/EDIT
 ;;GMRCOR CONSULT
 ;;GMRCOR REQUEST
 ;;GMRVOR
 ;;LR OTHER LAB TESTS
 ;;OR GWCOND CONDITION
 ;;OR GWDIAG DIAGNOSIS
 ;;OR GWINST DNR
 ;;OR GXACTV OTHER ACTIVITY ORDER
 ;;OR GXMISC GENERAL
 ;;OR GXMOVE ADMIT PATIENT
 ;;OR GXMOVE DISCHARGE
 ;;OR GXMOVE EVENT
 ;;OR GXMOVE TRANSFER
 ;;OR GXMOVE TREATING SPECIALTY
 ;;OR GXPARM CALL HO ON
 ;;OR GXSKIN DRESSING CHANGE
 ;;OR GXTEXT TEXT ONLY ORDER
 ;;OR GXTEXT WORD PROCESSING ORDER
 ;;ORWD GENERIC ACTIVITY
 ;;ORWD GENERIC DIET
 ;;ORWD GENERIC NURSING
 ;;ORWD GENERIC VITALS
 ;;PS MEDS
 ;;PSH OERR
 ;;PSJ OR PAT OE
 ;;PSJI OR PAT FLUID OE
 ;;PSO OERR
 ;;PSO SUPPLY
 ;;RA OERR EXAM
 ;;ZZZZZ
 ;
PS ; -- reset FORMAT values in PS dialogs
 N DRUG,OI,STR,DLGNM,DLG,PRMT,DA
 S DRUG=$$PTR("OR GTX DRUG NAME")
 S OI=$$PTR("OR GTX ORDERABLE ITEM"),STR=$$PTR("OR GTX STRENGTH")
 F DLGNM="PS MEDS","PSJ OR PAT OE","PSO OERR","PSO SUPPLY","PSH OERR" D
 . S DLG=$$PTR(DLGNM)
 . F PRMT=OI,STR D
 .. S DA=+$O(^ORD(101.41,DLG,10,"D",PRMT,0))
 .. S:DA $P(^ORD(101.41,DLG,10,DA,2),U,2)=("@"_DRUG)
 Q
 ; IV dialog
 S DLG=$$PTR("PSJI OR PAT FLUID OE"),PRMT=$$PTR("OR GTX INFUSION RATE")
 S DA=+$O(^ORD(101.41,DLG,10,"D",PRMT,0))
 I DA S $P(^ORD(101.41,DLG,10,DA,2),U,2)=("@"_$$PTR("OR GTX SCHEDULE"))
 Q
 ;
LR ; -- reset FORMAT value in LR dialog
 N DLG,PRMT,DA
 S DLG=$$PTR("LR OTHER LAB TESTS"),PRMT=$$PTR("OR GTX SPECIMEN")
 S DA=+$O(^ORD(101.41,DLG,10,"D",PRMT,0))
 I DA S $P(^ORD(101.41,DLG,10,DA,2),U,2)=("="_$$PTR("OR GTX COLLECTION SAMPLE"))
 Q
 ;
PTR(X) Q +$O(^ORD(101.41,"B",X,0))
