RAUTL12 ;HISC/CAH,FPT,GJC-Utility Routine ;12/23/97  09:25
 ;;5.0;Radiology/Nuclear Medicine;**75**;Mar 16, 1998;Build 4
 ;
IMGTY(X,Y,Z) ; Determines the Imaging Type
 ; 'X' ->  either 'e', 'l', or 'p'
 ;         'e' means we determine the Imaging Type from the 'Registered
 ;         Exams' multiple in Rad/Nuc Med Patient file (70)
 ;         'l' means that we determine the Imaging Type from data in the
 ;         Imaging Locations file (79.1)
 ;         'p' means that we determine the Imaging Type from data in the
 ;         Rad/Nuc Med Procedures file (71)
 ;
 ; 'Y' ->  The value of D0 in the above files.
 ;
 ; 'Z' ->  The value of D1 in the Rad/Nuc Med Patient file (70).
 ; [ This routine passes back the Imaging Type in the external format ]
 N A,B,RAXYZ
 I X="e" D
 . S A=$G(^RADPT(+$G(Y),"DT",+$G(Z),0)),B=+$P(A,U,2)
 . S RAXYZ=$P($G(^RA(79.2,B,0)),U)
 . Q
 I X="l" D
 . S A=$G(^RA(79.1,+$G(Y),0)),B=+$P(A,U,6)
 . S RAXYZ=$P($G(^RA(79.2,B,0)),U)
 . Q
 I X="p" D
 . S A=$G(^RAMIS(71,+$G(Y),0)),B=+$P(A,U,12)
 . S RAXYZ=$P($G(^RA(79.2,B,0)),U)
 . Q
 Q RAXYZ
 ;
LOCK(X,Y) ; Lock the data global
 ; 'X' is the global root
 ; 'Y' is the record number
 N RALCKFLG,XY
 S RADUZ=+$G(DUZ),RALCKFLG=0,XY=X_Y
 L +@(XY_")"):5
 I '$T S RALCKFLG=1 D
 . W !?5,"This record is being edited by another user."
 . W !?5,"Try again later!",$C(7)
 . Q
 E  D
 . S ^TMP("RAD LOCKS",$J,RADUZ,X,Y)=""
 . Q
 Q RALCKFLG
 ;
UNLOCK(X,Y) ; Unlock the data global
 N XY S RADUZ=+$G(DUZ),XY=X_Y L -@(XY_")")
 K ^TMP("RAD LOCKS",$J,RADUZ,X,Y)
 Q
EXTRA(RAQI) ;Input is RAQI (Modifier)
 ;Output is AMIS Credit Indicator: RABILAT = BILATERAL,
 ;RAPORT = PORTABLE, and RAOR = OPERATING ROOM.
 S RAQI=$P($G(^RAMIS(71.2,RAQI,0)),U,2) S:RAQI="b" RABILAT="" S:RAQI="p" RAPORT="" S:RAQI="o" RAOR=""
 Q
  ;
DESDT(RAPRI) ; Obtain 'Date Desired (NOT appt date)' by DIR call.
 ; Input: IEN of procedure
 ; The 'Date Desired' is passed back in internal format.
 ; 75.1 -> Rad Orders File    Fld 21 -> Date desired
 N DIR,DIROUT,DIRUT,DUOUT,DTOUT,X,Y
 I '$D(RAPKG),($D(ORVP)),($D(ORL)),($D(ORNP)) D PROCMSG^RAUTL5(RAPRI)
 F  D  Q:Y'=""
 .S DIR("?",1)="The 'Date Desired' field contains the date for which the rad/nuc med exam"
 .S DIR("?",2)="is requested. 'Date Desired' is required and should not be interpreted as"
 .S DIR("?")="an appointment date."
 .S DIR(0)="75.1,21" D ^DIR
 .S:$D(DTOUT)#2!($D(DUOUT)#2) Y=-1
 .Q
 Q Y
 ;
PTLOC() ; Current patient location.  Used for entry: 'CURRENT PATIENT
 ; LOCATION' in the Label Print Fields file. (78.7)
 ; 'X' is the patient's DFN.  DFN must be a positive integer.
 N %,%H,%I,A,B,C,DFN,VAERR,VAIN,X,Y,Y1,Y2,Y3,Y4,Y5
 S Y=$$NOW^XLFDT(),Y1=$P(Y,"."),Y2=$E($P(Y,".",2),1,4)
 S Y3=$E(Y1,4,5)_"-"_$E(Y1,6,7)_"-"_(1700+$E(Y1,1,3))
 S Y4=$E(Y2,1,2)_":"_$E(Y2,3,4)
 S Y5=Y3_"@"_Y4,DFN=+$P($G(^RADPT(+$G(RADFN),0)),"^")
 Q:'+$G(DFN) "OP Unknown/"_Y5
 D INP^VADPT ; If currently an inpatient, grab the ward.
 I $P($G(VAIN(4)),"^",2)]"" D  Q Y
 . S Y=$E($P($G(VAIN(4)),"^",2),1,15)_"/"_Y5
 . Q
 ; If not currently an inpatient, check if last recorded patient location
 ; is a ward.  If it is a ward or operating room, pass back 'OP Unknown'.
 ; We do not have the benefit of PIMS updating our Rad/Nuc Med files.
 S X=+$P($G(^RADPT(+$G(RADFN),"DT",+$G(RADTI),"P",+$G(RACNI),0)),"^",11)
 S A=+$P($G(^RAO(75.1,X,0)),"^",22),B=$G(^SC(A,0)),C=$P(B,"^",3)
 Q:B']""!("WOR"[C) "OP Unknown/"_Y5
 Q $P(B,"^")_" (Req'g Loc)"
 ;
IMG() ; Select one/many/all imaging types.  This code will be used for ALL
 ; the options under the Procedure File Listings option as exported by
 ; Rad/Nuc Med version 5.  I-Types are not screened.
 ; Passes back '1' if I-Type(s) are selected, '0' if nothing selected.
 N RADIC,RAQUIT,RAUTIL,X,Y
 S RADIC="^RA(79.2,",RADIC(0)="QEAMZ"
 S RADIC("A")="Select Imaging Type: ",RADIC("B")="All"
 S RAUTIL="RA I-TYPE" W !! D EN1^RASELCT(.RADIC,RAUTIL)
 Q $S($D(^TMP($J,"RA I-TYPE"))\10:1,1:0)
 ;
LOC(RAX) ; Select one/many/all imaging locations.  L-Types are not
 ; screened.  Passes back '1' if L-Type(s) are selected, '0' if nothing
 ; selected.  Used for the option: 'Location Parameter List' (4^RASYS)
 N RADIC,RAQUIT,RAUTIL,X,Y
 S RADIC="^RA(79.1,",RADIC(0)="QEFAMZ"
 S RADIC("A")="Select Imaging Location: ",RADIC("B")="All"
 S:'RAX RADIC("S")="N RADT S RADT=$P(^(0),""^"",19) I $S('RADT:1,RADT>DT:1,1:0)"
 S RAUTIL="RA L-TYPE" W !! D EN1^RASELCT(.RADIC,RAUTIL)
 Q $S($D(^TMP($J,"RA L-TYPE"))\10:1,1:0)
