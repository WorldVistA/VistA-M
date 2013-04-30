ORY4 ;SLB/MKB-postinit for OR*3.0*4 ;4/30/98  15:52
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**4**;Dec 17, 1997
 ;
EN ; -- check orderables, dialogs, display groups
 N DA,DIK S DIK="^DD(101.416,",DA(1)=101.416,DA=.04 D ^DIK
 D OI^ORSETUP1 ; reset orderables pointers in quick orders
 D DLG ;         fix DG,SD,SR dialogs
 N ORSEQ,ORX
 F ORSEQ=1:1 S ORX=$T(DG+ORSEQ) Q:ORX["ZZZZZ"  D ADD ; add new groups
 Q
 ;
ADD ; -- add new group to file, to LAB as member
 N X,Y,DA,DIC,DR,DIE,DLAYGO
 S DIC="^ORD(100.98,",DIC(0)="LX",DLAYGO=100.98,DIE=DIC
 S Y=+$O(^ORD(100.98,"B",$P(ORX,";",5),0))
 I Y'>0 S X=$P(ORX,";",3) D ^DIC Q:Y'>0  ; error msg??
 S DA=+Y,DR=".01///"_$P(ORX,";",3)_";2///"_$P(ORX,";",4)_";3///"_$P(ORX,";",5) D ^DIE
 K X,Y,DA S DA(1)=+$O(^ORD(100.98,"B","LAB",0)) Q:'DA(1)
 S DIC="^ORD(100.98,"_DA(1)_",1,",X=$P(ORX,";",5) D ^DIC
 Q
 ;
DG ;;NAME;Mixed Name;SHORT NAME
 ;;ELECTRON MICROSCOPY;Electron Microscopy;EM
 ;;SURGICAL PATHOLOGY;Surg. Path.;SP
 ;;AUTOPSY;Autopsy;AU
 ;;CYTOLOGY;Cytology;CY
 ;;ZZZZZ
 ;
DLG ; -- add save/restore calls to DG,SD,SR dialogs
 N X,ORPKG,ORDLG,ENTRY,EXIT S ORDLG=0
 F X="DG","SD","SR" S X=$O(^DIC(9.4,"C",X,0)) S:X ORPKG(X)=""
 F  S ORDLG=$O(^ORD(101.41,ORDLG)) Q:ORDLG'>0  S X=+$P($G(^(ORDLG,0)),U,7) I $D(ORPKG(X)) D
 . S ENTRY=$G(^ORD(101.41,ORDLG,3)),EXIT=$G(^(4))
 . S:ENTRY'["SAVE^ORXD" ENTRY="D SAVE^ORXD"_$S($L(ENTRY):" "_ENTRY,1:"")
 . S:EXIT="D REBLD^ORCMENU" EXIT=""
 . I $L(EXIT),EXIT["REBLD^ORCMENU" S EXIT=$P(EXIT," D REBLD^ORCMENU")
 . S:EXIT'["RSTR^ORXD" EXIT=EXIT_$S($L(EXIT):" ",1:"")_"D RSTR^ORXD"
 . S ^ORD(101.41,ORDLG,3)=ENTRY,^(4)=EXIT
 Q
