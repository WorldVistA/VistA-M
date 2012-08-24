ORY8 ;SLC/MKB -- post-install for OR*3*8 ;4/13/98  08:52
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**8**;Dec 17, 1997
 ;
EN ; -- Rebuild ^ORD(101.41,"APKG") xref
 ;
 N IFN,PKG,NODE0 S IFN=0
 F  S IFN=$O(^ORD(101.41,IFN)) Q:IFN'>0  S NODE0=$G(^(IFN,0)) D
 . S PKG=$P(NODE0,U,7) I $P(NODE0,U,4)="Q",PKG'>0 D  ;get Pkg
 . . N DLG S DLG=$$DEFDLG^ORCD(IFN)
 . . I DLG S PKG=+$P($G(^ORD(101.41,DLG,0)),U,7)
 . . S:PKG $P(^ORD(101.41,IFN,0),U,7)=PKG
 . S:PKG ^ORD(101.41,"APKG",PKG,IFN)=""
 . I $D(^ORD(101.41,IFN,10,0)),$P(^(0),U,2)'["I" S $P(^(0),U,2)="101.412IA"
 Q
