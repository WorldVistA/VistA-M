ORWDGX ; SLC/KCM - Generic Orders calls for Windows Dialogs [ 08/05/96  8:21 AM ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243**;Dec 17, 1997;Build 242
 ;
ACT() N X,RSLT S X=^(0),RSLT=1
 I "DQ"'[$P(X,U,4) S RSLT=0
 S X1=$O(^ORD(100.98,"B","ACTIVITY",0))
 S X2=$O(^ORD(100.98,"B","NURSING",0))
 I "DQ"'[$P(X,U,4) S RSLT=0
 I RSLT,((U_X1_U_X2_U)'[(U_$P(X,U,5)_U)) S RSLT=0
 Q RSLT
NURS() N X,RSLT S X=^(0),RSLT=1
 I "DQ"'[$P(X,U,4) S RSLT=0
 I RSLT,($P(X,U,5)'=$O(^ORD(100.98,"B","NURSING",0))) S RSLT=0
 Q RSLT
OITEXT(Y,DLG)    ; Return Orderable Item Text given dialog or quick order
 S Y=$P(^ORD(101.41,DLG,0),U,2)
 Q
LOAD(LST,PAR)          ; Load a list of activity orders
 N I,ILST,DLG,NAM,TLST
 D GETLST^XPAR(.TLST,"ALL",PAR)
 S I=0,ILST=0 F  S I=$O(TLST(I)) Q:'I  D
 . S DLG=$P(TLST(I),U,2),NAM=$P(^ORD(101.41,+DLG,0),U,2)
 . S ILST=ILST+1,LST(ILST)=DLG_U_NAM
 Q
 ;
 N DLGTYP,OIDLG,FTDLG,OITYP,I,IFN
 S DLGTYP=$P(^ORD(101.41,DLG,0),U,4)
 S OIDLG=$O(^ORD(101.41,"B","OR GTX ORDERABLE ITEM",0))
 S FTDLG=$O(^ORD(101.41,"B","OR GTX FREE TEXT OI",0))
 I DLGTYP="D" D
 . S I=0,IFN=0 F  S I=$O(^ORD(101.41,DLG,10,I)) S X=^(I,0) D  Q:IFN
 . . I $P(X,U,2)=OIDLG S IFN=I,OITYP="O"
 . . I $P(X,U,2)=FTDLG S IFN=I,OITYP="F"
 . S Y="" I $L($G(^ORD(101.41,DLG,10,IFN,7))) X ^(7)
 . I OITYP="O" S Y=$P(^ORD(101.43,+Y,0),U,1)
 Q
VMDEF(LST)         ; Return dialog definition for vitals/measurements
 N ILST S ILST=0
 S LST($$NXT)="~Measurements" D MEASURE
 S LST($$NXT)="~Schedules" D VMSCHED
 Q
MEASURE ; Get measurements available
 S X="" F  S X=$O(^ORD(101.43,"S.V/M",X)) Q:X=""  D
 . S I=$O(^ORD(101.43,"S.V/M",X,0)),LST($$NXT)="i"_I_U_X
 S LST($$NXT)="dTPR B/P"      ; ** do this with a parameter
 Q
VMSCHED ; Get vitals/measurements schedules
 K ^TMP($J,"ORWDGX APGMRV")
 D AP^PSS51P1("GMRV",,,,"ORWDGX APGMRV")
 S X="" F  S X=$O(^TMP($J,"ORWDGX APGMRV","APGMRV",X)) Q:X=""  D
 . S I=$O(^TMP($J,"ORWDGX APGMRV","APGMRV",X,0)),LST($$NXT)="i"_I_U_X
 K ^TMP($J,"ORWDGX APGMRV")
 Q
NXT() ; Increment index into LST
 S ILST=ILST+1
 Q ILST
