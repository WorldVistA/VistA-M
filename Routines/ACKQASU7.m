ACKQASU7 ;HCIOFO/AG - New/Edit Visit Utilities  ;  04/01/99
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 ;
SHOWPCE(ACKGBL) ; display errors from COPYPCE stored in @ACKGBL
 ; this routine displays on the screen any errors found in the global
 ; referenced by ACKGBL that were created by COPYPCE^ACKQASU4.
 ; format for global is @ACKGBL=number or errors
 ;      @ACKGBL@(n)=field^int^ext^message
 ; returns:-   0 - continue, 1 - user typed '^' to exit
 N ACKERR,ACKECT,ACKLN,ACKTMP,ACKFLD,ACKINT,ACKEXT,ACKMSG,ACKTXT,ACKLF
 N DIRUT,ACKTAB,ACKLEN
 ;
 ; get number of errors, initialise line counter
 S ACKERR=@ACKGBL,ACKLN=0
 ;
 ; show header
 W !!?2,"ERROR - The following errors occurred while copying the PCE Visit"
 W !?2,"data into QUASAR. The fields in error are displayed below with the"
 W !?2,"reason they were rejected.",!
 S ACKLN=6
 ;
 ; display the errors
 F ACKECT=1:1:ACKERR D  Q:$D(DIRUT)
 . S ACKTMP=@ACKGBL@(ACKECT)
 . S ACKFLD=$P(ACKTMP,U,1),ACKINT=$P(ACKTMP,U,2),ACKEXT=$P(ACKTMP,U,3)
 . S ACKDTA=$S(ACKEXT="":ACKINT,1:ACKEXT)
 . S ACKTAB=$S($L(ACKDTA)>19:35,1:13+$L(ACKDTA)+2+5\5*5),ACKLEN=80-ACKTAB
 . W !?2,ACKFLD_":",?13,$E(ACKDTA,1,20)
 . S ACKMSG=$P(ACKTMP,U,4),ACKLF=0
 . F  Q:ACKMSG=""  D  Q:$D(DIRUT)
 . . S ACKTXT=$E(ACKMSG,1,ACKLEN) D   ; reset TXT (word wrap)
 . . . I ($E(ACKTXT,ACKLEN)?1P)!($E(ACKMSG,ACKLEN+1)?1P) Q
 . . . S ACKI=0 I $L(ACKTXT)=ACKLEN F ACKI=ACKLEN:-1:0 Q:$E(ACKTXT,ACKI)?1P
 . . . I ACKI S ACKTXT=$E(ACKTXT,1,ACKI) Q
 . . W:ACKLF ! W ?ACKTAB,ACKTXT S ACKLF=1
 . . S ACKLN=ACKLN+1 D PAUSE Q:$D(DIRUT)
 . . S ACKMSG=$P(ACKMSG,ACKTXT,2,999)
 . . F  Q:$E(ACKMSG)'=" "  S ACKMSG=$E(ACKMSG,2,999)
 ;
 ; all done
 I '$D(DIRUT) S ACKLN=0 D PAUSE
 ; return 1 if user chose to quit, 0 if they didn't
 Q $D(DIRUT)
 ;
PAUSE ;
 Q:ACKLN#15'=0
 W !!
 K DIR S DIR(0)="E" D ^DIR K DIR  ;  Return to Continue '^' to Exit
 W !
 Q
 ;
ACKAPMNT(ACKVD,ACKVTME,ACKCLIN,ACKPAT) ;
 ;
 ;  //First checks to see if Patient is an Inpatient if they are then
 ;  //dont display this message.
 ;  Checks to see if the visit entered corresponds to a Visit Within
 ;  Appointment Management.  If does'nt a warning is displayed - the
 ;  can continue or quit.  This is to remind/encorage users to enter
 ;  visits first through Appointment Management then pick them up 
 ;  in Quasar.
 ;
 ;  N VAIN D INP^VADPT I $P(VAIN(4),U,2)'="" Q 1
 ;
 N ACKK1,ACKT,ACKOKAY
 I ACKVTME="" G MESSAG
 ;
 S DFN=ACKPAT,VASD("C",ACKCLIN)="",VASD("T")=ACKVD,VASD("F")=ACKVD
 S VASD("W")="129"
 K ^UTILITY("VASD",$J) D SDA^VADPT     ; Call appointment utility 
 I '$D(^UTILITY("VASD",$J)) G MESSAG   ; Nothing returned=No appointment
 ;
 S ACKK1="",ACKOKAY=0
 F  S ACKK1=$O(^UTILITY("VASD",$J,ACKK1)) Q:ACKK1=""!(ACKOKAY)  D
 . S ACKT=$P(^UTILITY("VASD",$J,ACKK1,"I"),U,1)
 . S ACKT=$P(ACKT,".",2)
 . I ACKT=ACKVTME S ACKOKAY=1
 K ^UTILITY("VASD",$J)
 ;
 I ACKOKAY Q 1
 ;
MESSAG ;
 W !!!,"WARNING -",!
 W !,"You are Creating a Visit that does not exist within Appointment Management."
 W !,"This Visit will not be displayed within Appointment Management.",!
 ;
 N DIR,DUOUT,DTOUT,DIRUT
OK2 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you want to Continue "
 S DIR("?")="Answer YES to continue with New Visit Entry or NO to quit."
 D ^DIR
 I Y?1"^"1.E W !,"Jumping not allowed.",! G OK2
 S:$D(DIRUT) Y=0
 S:$D(DTOUT) Y=0
 Q Y
 ;
