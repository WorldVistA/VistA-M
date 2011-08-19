RAPERR1 ;HIRMFO/GJC,CAH-Prt Img Locs missing/invalid Stop codes ;10/30/96  09:20
 ;;5.0;Radiology/Nuclear Medicine;**13**;Mar 16, 1998
BSTP(X) ; Check for bad stop codes (DSS ID) per Imaging Location
 ; Make sure each imaging location points to an entry in the
 ;  Hospital Location file #44 that is a 'COUNT' clinic, with
 ;  no appointment patterns allowed, Stop Code on file 44 entry
 ;  should match DSS ID on Imaging loc, division for imaging loc
 ;  should match the Institution of the file 44 entry
 N RAERR,RASTOP,RAY S RAERR="Invalid Stop Code: ",RAY=X_","
 D GETS^DIQ(40.7,RAY,".01;1;2","","RASTOP")
 S RAERR=RAERR_" ("_RASTOP(40.7,RAY,1)_") "_RASTOP(40.7,RAY,.01)
 I $G(RASTOP(40.7,RAY,2))]"" S RAERR=RAERR_" (Inactive)"
 Q RAERR
CK700(X) ;Check for a 700-level stop code as a DSS ID
 N RAERR,RASTOP,RAY S RAERR="",RAY=X_","
 D GETS^DIQ(40.7,RAY,"1","","RASTOP")
 I $G(RASTOP(40.7,RAY,1))?1"7"2N D
 . S RAERR="700-series noncredit Stop Code being used"
 . Q
 Q RAERR
ISTOP ; Check the validity of the stop code on the Imaging Locations file.
 N RACNT K ^TMP($J,"RAPERR") S (RACNT,RAILOC,RAISTP,RAOUT)=0
 F  S RAILOC=$O(^RA(79.1,RAILOC)) Q:RAILOC'>0  D
 . K RAMSG S RA791(0)=$G(^RA(79.1,RAILOC,0))
 . Q:$P(RA791(0),"^",21)=2  ; no credit method for this location
 . S X=+$P(RA791(0),"^",22),RA44=+$P(RA791(0),U) ;RA44 = ptr to file 44
 . I '$D(^SC(RA44)) D
 .. S RAMSG="Broken pointer - Hospital Location file 44 entry missing",RACNT=RACNT+1
 .. S ^TMP($J,"RAPERR",RAILOC,RACNT)=RAMSG
 .. Q
 . S RA44(0)=$G(^SC(RA44,0)) D  ;get 0th node of file 44
 .. I $P(RA44(0),U,3)'="C" D
 ... S RAMSG="Hospital Location file 44 entry not CLINIC type",RACNT=RACNT+1
 ... S ^TMP($J,"RAPERR",RAILOC,RACNT)=RAMSG
 ... Q
 .. I X,($P(RA44(0),U,7)'=X) D
 ... S RAMSG="Hospital Location Stop Code doesn't match Imaging Loc's DSS ID",RACNT=RACNT+1
 ... S ^TMP($J,"RAPERR",RAILOC,RACNT)=RAMSG
 ... Q
 .. I $P(RA44(0),U,17)="Y" D
 ... S RAMSG="Hospital Location is a NON-COUNT clinic",RACNT=RACNT+1
 ... S ^TMP($J,"RAPERR",RAILOC,RACNT)=RAMSG
 ... Q
 .. I $G(^RA(79.1,RAILOC,"DIV"))="" D
 ... S RAMSG="No Rad/Nuc Med Division assigned to this imaging location",RACNT=RACNT+1
 ... S ^TMP($J,"RAPERR",RAILOC,RACNT)=RAMSG
 .. E  I +$G(^RA(79.1,RAILOC,"DIV"))'=$P(RA44(0),U,4) D
 ... S RAMSG="Institution on Hosp Loc entry doesn't match Rad/NM Div of Imaging Loc",RACNT=RACNT+1
 ... S ^TMP($J,"RAPERR",RAILOC,RACNT)=RAMSG
 ... Q
 .. Q
 . I 'X D  Q
 .. S RAMSG="Missing DSS ID",RACNT=RACNT+1
 .. S ^TMP($J,"RAPERR",RAILOC,RACNT)=RAMSG
 .. Q
 . S RAMSG=$$CK700(X) I RAMSG]"" D
 .. S RACNT=RACNT+1,^TMP($J,"RAPERR",RAILOC,RACNT)=RAMSG
 .. Q
 . I '$D(^RAMIS(71.5,"B",+X))!($P(^DIC(40.7,+X,0),U,3)) D
 .. S RAMSG=$$BSTP(X),RACNT=RACNT+1,^TMP($J,"RAPERR",RAILOC,RACNT)=RAMSG
 .. Q
 . Q
 I $D(^TMP($J,"RAPERR")) D
 . S (RAILOC,RAOUT)=0
 . F  S RAILOC=$O(^TMP($J,"RAPERR",RAILOC)) Q:RAILOC'>0  D  Q:RAOUT
 .. I $Y>(IOSL-4) D HDG^RAPERR Q:RAOUT
 .. W !!,"Imaging Location: ",$$GET1^DIQ(44,+$P(^RA(79.1,RAILOC,0),"^"),.01) S RACNT=0
 .. F  S RACNT=$O(^TMP($J,"RAPERR",RAILOC,RACNT)) Q:RACNT'>0  D  Q:RAOUT
 ... I $Y>(IOSL-4) D HDG^RAPERR W:'RAOUT !
 ... Q:RAOUT  W !?3,$G(^TMP($J,"RAPERR",RAILOC,RACNT))
 ... Q
 .. Q
 . K ^TMP($J,"RAPERR")
 . Q
 E  D
 . I $Y>(IOSL-4) D HDG^RAPERR Q:RAOUT
 . W !!,"All Imaging Location crediting data is valid."
 . Q
 Q
