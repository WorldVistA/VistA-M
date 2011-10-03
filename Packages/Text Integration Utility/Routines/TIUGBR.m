TIUGBR ; SLC/MAM - ID Browse Action Subroutines: HASIDKID, HASIDDAD, DADORKID, IDTOP, LOADID, GETKIDS ;8/16/06  13:32
 ;;1.0;TEXT INTEGRATION UTILITIES;**100,211**;Jun 20, 1997;Build 26
 ; Similar to TIUBR, but for ID notes
 ;
GETKIDS(TIUDA) ; Set ID kids of TIUDA into array
 ;   ^TMP("TIUGKID",$J,REFERENCE DATE,TIUKID)="":
 N TIUKID,REFDATE
 S TIUKID=0
 F  S TIUKID=$O(^TIU(8925,"GDAD",+TIUDA,TIUKID)) Q:+TIUKID'>0  D
 . S REFDATE=+$G(^TIU(8925,TIUKID,13))
 . S ^TMP("TIUGKID",$J,REFDATE,TIUKID)=""
 Q
 ;
HASIDKID(DA) ; Function returns 1 if DA has ID kid, else 0. 
 N TIUY
 S TIUY=0
 I $O(^TIU(8925,"GDAD",+DA,0)) S TIUY=1
 Q TIUY
 ;
HASIDDAD(DA) ; Function returns ID parent of DA if DA has parent; else 0.
 Q +$G(^TIU(8925,DA,21),0)
 ;
DADORKID(DA) ; Function returns DA if DA has ID kid,
 ;or ID dad IFN if DA has ID dad, else 0.
 N TIUY
 S TIUY=0
 I $O(^TIU(8925,"GDAD",+DA,0)) S TIUY=DA G ORKIDX
 I +$G(^TIU(8925,DA,21)) S TIUY=^TIU(8925,DA,21)
ORKIDX Q TIUY
 ;
IDTOP(TIUDA,TIUL,SHORT,CURPRNT) ; Load entry-specific info:
 ;Title, [Location, Visit] for ID entry.
 ; Called by LOADTOP^TIUBR
 N TIUY,TIU,DFN
 I CURPRNT S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)="                         << Interdisciplinary Note >>"
 I SHORT S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)="                      << Interdisciplinary Note - Cont. >>"
 D GETTIU^TIULD(.TIU,+TIUDA)
 I 'SHORT D
 . S TIUL=$G(TIUL)+1,TIUY=""
 . S TIUY=$$SETSTR^VALM1("LOCATION: "_$P($G(TIU("LOC")),U,2),$G(TIUY),1,31)
 . I $L($G(TIU("WARD"))) S TIUY=$$SETSTR^VALM1("ADMISSION DATE: "_$P($G(TIU("EDT")),U,2),$G(TIUY),34,37) I 1
 . E  S TIUY=$$SETSTR^VALM1("VISIT DATE: "_$P($G(TIU("EDT")),U,2),$G(TIUY),38,33)
 . S @VALMAR@(TIUL,0)=TIUY
 S TIUL=+$G(TIUL)+1,TIUY=""
 S TIUY=$$SETSTR^VALM1("LOCAL TITLE: "_$P($G(TIU("DOCTYP")),U,2),$G(TIUY),1,67)
 S @VALMAR@(TIUL,0)=TIUY
 Q
 ;
LOADID(TIUDA,TIUL,TIUGDATA,TIUGWHOL) ; Load ID entry TIUDA for browse
 ; Requires TIUDA, array TIUL, TIUGDATA;
 ; Optional TIUGWHOL (see rtn TIUBR).
 N TIUREC,TIU,DFN
 I '$D(^TIU(8925,+TIUDA,0)) S VALMQUIT=1 Q
 ; ---- If ID Kid has focus, don't show it again ----
 ; I +$G(^TMP("TIU FOCUS",$J))=TIUDA Q
 S TIUL=+$G(TIUL)+1,@VALMAR@(TIUL,0)=""
 D GETTIU^TIULD(.TIU,+TIUDA)
 D INQUIRE(TIUDA,.TIUREC)
 ; ---- Load info missing from header since this is ID note entry: ----
 ; ---- Load dictation, transcription data, etc.: ----
 D LOADTOP^TIUBR(.TIUREC,TIUDA,.TIUL,TIUGDATA)
 ; ---- Load the remainder of the record: ----
 D LOADREC^TIUBR1(TIUDA,.TIUL,TIUGDATA,$G(TIUGWHOL))
 Q
 ;
INQUIRE(TIUDA,TIUREC) ; Inquire to document TIUDA and set TIUREC
 N DA,DIC,DIQ,DR
 S DA=TIUDA,DIC=8925,DIQ="TIUREC("
 S DR=".01;.02;.05;.09;1201;1202;1208;1209;1301;1307;1501;1502;1505;1506;89261"
 D EN^DIQ1
 Q
