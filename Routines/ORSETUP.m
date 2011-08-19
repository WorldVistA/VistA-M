ORSETUP ; SLC/MKB - OE3 Setup post-init ;7/26/97  15:51
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
PARAM ; -- Populate Parameters file
 D BMES^XPDUTL("Populating Parameters file ...")
 D ^ORXPAR,^ORPFCNVT
 Q
 ;
DGROUPS ; -- Update Display Group file
 D BMES^XPDUTL("Setting up Display Group file ...")
 D POST^ORSET98
 Q
 ;
ORDITMS ; -- Populate Orderable Items file
 N ORP S ORP=+$$PARCP^XPDUTL(ORCP) Q:ORP<0  ; already completed
 D BMES^XPDUTL("Populating Orderable Items file ...") G @ORP
0 D OI^ORSETUP1 I '$D(^ORD(101.43,"S.NURS")) S XPDQUIT=1 Q
 S ORP=$$UPCP^XPDUTL(ORCP,1) W:IOST?1"C-".E "."
1 D EN^GMRCPOS1 I '$D(^ORD(101.43,"S.CSLT")) S XPDQUIT=1 Q
 S ORP=$$UPCP^XPDUTL(ORCP,2) W:IOST?1"C-".E "."
2 D ^FHWORI I '$D(^ORD(101.43,"S.DIET")) S XPDQUIT=1 Q
 S ORP=$$UPCP^XPDUTL(ORCP,3) W:IOST?1"C-".E "."
3 D ALL^LR7OV2 I '$D(^ORD(101.43,"S.LAB")) S XPDQUIT=1 Q
 S ORP=$$UPCP^XPDUTL(ORCP,4) W:IOST?1"C-".E "."
4 D EN1^PSSHL1 I '$D(^ORD(101.43,"S.RX")) S XPDQUIT=1 Q
 S ORP=$$UPCP^XPDUTL(ORCP,5) W:IOST?1"C-".E "."
5 D ENALL^RAO7MFN I '$D(^ORD(101.43,"S.XRAY")) S XPDQUIT=1 Q
 S ORP=$$UPCP^XPDUTL(ORCP,-1) W:IOST?1"C-".E "."
 Q
 ;
DIALOGS ; -- Convert protocol menus, quick orders into Dialogs
 D BMES^XPDUTL("Converting protocol menus ...")
 D FRMT,^ORCONVRT
 Q
 ;
FRMT ; -- resolve format code ptrs for LR,PS dlgs
 N ORI,X,DLG,DA
 F ORI=1:1 S X=$T(DLG+ORI),X=$P(X,";",3) Q:X="ZZZZ"  D
 . S DLG=+$O(^ORD(101.41,"AB",$P(X,U),0)) Q:'DLG
 . S DA=+$O(^ORD(101.41,DLG,10,"B",$P(X,U,2),0)) Q:'DA
 . S $P(^ORD(101.41,DLG,10,DA,2),U,2)=$P(X,U,3)_+$O(^ORD(101.41,"AB",$P(X,U,4),0))
 Q
 ;
DLG ;; dialog^item position^item to use instead
 ;;LR OTHER LAB TESTS^4^=^OR GTX COLLECTION SAMPLE
 ;;PSO OERR^1^@^OR GTX INSTRUCTIONS
 ;;ZZZZ
 ;
URG ; -- set GMRCURGENCY protocols into 101.42
 N LAST,NAME,X,Y,DIC,DINUM,DLAYGO,I,CODE
 D BMES^XPDUTL("Adding Consult/Request urgencies to Order Urgency file ...")
 S DIC="^ORD(101.42,",DIC(0)="LX",DLAYGO=101.42
 S LAST=$O(^ORD(101.42,99),-1),NAME="GMRCURGENCY - "
 F  S NAME=$O(^ORD(101,"B",NAME)) Q:NAME'?1"GMRCURGENCY - ".E  S X=$P(NAME," - ",2) I '$D(^ORD(101.42,"B",X)) D
 . S DINUM=LAST+1 D FILE^DICN S:+Y>0 LAST=+Y S CODE=""
 . I Y'>0 D MES^XPDUTL(">>> Unable to add "_X_" urgency") Q
 . F I=1:1:4 I '$D(^ORD(101.42,"C","Z"_$E(X,1,I))) S CODE="Z"_$E(X,1,I) Q
 . S:$L(CODE) $P(^ORD(101.42,+Y,0),U,2)=CODE,^ORD(101.42,"C",CODE,+Y)=""
 Q
