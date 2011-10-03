ORWCH ; SLC/KCM/SCM - GUI calls specific to CPRS Chart;01:34 PM  15 Dec 1997 [10:52 AM 13 JUN 2002]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,109,149**;Dec 17, 1997
SAVESIZ(ORERR,NAM,VAL) ; save the bounds for a particular control
 ; NAM=frmName or frmName.ctrlName  VAL=left,top,width,height
 D EN^XPAR(DUZ_";VA(200,","ORWCH BOUNDS",NAM,VAL,.ORERR)
 Q
LOADSIZ(VAL,NAM)        ; return the bounds for a particular control
 I NAM="" S VAL="" Q
 S VAL=$$GET^XPAR(DUZ_";VA(200,","ORWCH BOUNDS",NAM,"I")
 Q
 ;
LDFONT(VAL,NAM) ; load the user's preferred font size
 S VAL=$$GET^XPAR(DUZ_";VA(200,","ORWCH FONT SIZE",1,"I")
 Q
SAVEALL(OK,LST) ; save the list of sizing information
 N I,TYP,NAM,VAL,PAR,ORERR
 S (I,OK)="" F  S I=$O(LST(I)) Q:'I  D
 . S TYP=$P(LST(I),U),NAM=$P(LST(I),U,2),VAL=$P(LST(I),U,3)
 . S PAR="ORWCH "_$S(TYP="B":"BOUNDS",TYP="W":"WIDTH",TYP="C":"COLUMNS")
 . D EN^XPAR(DUZ_";VA(200,",PAR,NAM,VAL,.ORERR)
 . I ORERR S OK=OK_LST(I)_":"_ORERR_U
 ; Other clean up: kill off global for sharing DFN
 K ^TMP("ORWCHART",$J),^TMP("ORECALL",$J),^TMP("ORWORD",$J)
 K ^TMP("ORWDXMQ",$J)
 Q
SAVECOL(OK,COL) ;save report column sizing information
 N NAM,VAL,ORERR
 S OK="",NAM=$P(COL,"^"),VAL=$P(COL,"^",2)
 D EN^XPAR(DUZ_";VA(200,","ORWCH COLUMNS REPORTS",NAM,VAL,.ORERR)
 I ORERR S OK=COL_":"_ORERR
 Q
LOADALL(LST) ; load all the sizing related paramters
 N ORBOUNDS,ORWIDTHS,ORCOLMNS,ILST S ILST=0
 D GETLST^XPAR(.ORBOUNDS,DUZ_";VA(200,","ORWCH BOUNDS")
 D GETLST^XPAR(.ORWIDTHS,DUZ_";VA(200,","ORWCH WIDTH")
 D GETLST^XPAR(.ORCOLMNS,DUZ_";VA(200,","ORWCH COLUMNS")
 S ILST=ILST+1,LST(ILST)="~Bounds"
 S I="" F  S I=$O(ORBOUNDS(I)) Q:'I  S ILST=ILST+1,LST(ILST)="i"_ORBOUNDS(I)
 S ILST=ILST+1,LST(ILST)="~Widths"
 S I="" F  S I=$O(ORWIDTHS(I)) Q:'I  S ILST=ILST+1,LST(ILST)="i"_ORWIDTHS(I)
 S ILST=ILST+1,LST(ILST)="~Columns"
 S I="" F  S I=$O(ORCOLMNS(I)) Q:'I  S ILST=ILST+1,LST(ILST)="i"_ORCOLMNS(I)
 Q
SAVFONT(ORERR,VAL)      ; save the user's preferred font size
 D EN^XPAR(DUZ_";VA(200,","ORWCH FONT SIZE",1,VAL,.ORERR)
 Q
 ;
CLRUSR ; clear size & position settings for user
 ; called from ORW CLEAR SIZES USER
 N DIC,DIR,DIK,ORERR,ENT,Y
 W !,"Clear GUI size & position settings for selected user -"
 S DIC=200,DIC(0)="AEMQ" D ^DIC  Q:Y<1
 S ENT=+Y_";VA(200,"
 S DIR(0)="Y",DIR("A")="Clear sizes for "_$P(Y,U,2),DIR("B")="YES"
 D ^DIR Q:Y'=1
 D NDEL^XPAR(ENT,"ORWCH BOUNDS",.ORERR) I ORERR W !,ORERR
 D NDEL^XPAR(ENT,"ORWCH WIDTH",.ORERR) I ORERR W !,ORERR
 D NDEL^XPAR(ENT,"ORWCH COLUMNS",.ORERR) I ORERR W !,ORERR
 D DEL^XPAR(ENT,"ORWCH FONT SIZE",1,.ORERR) I ORERR W !,ORERR
 W !,"Settings cleared."
 Q        ;
 ; -- are the following calls still used?
 ;
GETPOS(VAL) ; returns the position and size information for CPRSChart
 ; VAL=WindowState^Size^Position^PageSplit,PageSplit...
 N I,ORX
 S VAL=$$GET^XPAR(DUZ_";VA(200,","ORWCH MAINFORM STATE",1,"I")_U
 S VAL=VAL_$$GET^XPAR(DUZ_";VA(200,","ORWCH MAINFORM SIZE",1,"I")_U
 S VAL=VAL_$$GET^XPAR(DUZ_";VA(200,","ORWCH MAINFORM POSITION",1,"I")_U
 D GETLST^XPAR(.ORX,DUZ_";VA(200,","ORWCH PAGE SPLIT","Q")
 S ORX="",I=0 F  S I=$O(ORX(I)) Q:'I  S $P(ORX,",",+ORX(I))=$P(ORX(I),U,2)
 S VAL=VAL_ORX
 Q
SETPOS(OK,X) ; records window size and position info for the current user
 ; X=WindowState^Size^Position^PageSplit,PageSplit...
 N I,X4,ORERR S OK=1
 D EN^XPAR(DUZ_";VA(200,","ORWCH MAINFORM STATE",1,$P(X,U),.ORERR)
 D EN^XPAR(DUZ_";VA(200,","ORWCH MAINFORM SIZE",1,$P(X,U,2),.ORERR)
 D EN^XPAR(DUZ_";VA(200,","ORWCH MAINFORM POSITION",1,$P(X,U,3),.ORERR)
 S X4=$P(X,U,4)
 F I=1:1:$L(X4,",") I +$P(X4,",",I) D
 . D EN^XPAR(DUZ_";VA(200,","ORWCH PAGE SPLIT",I,$P(X4,",",I),.ORERR)
 Q
