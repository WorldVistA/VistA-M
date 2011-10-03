ACKQASU2 ;HCIOFO/BH-NEW/EDIT VISIT QUASAR UTILITIES  ; 04/01/99
 ;;3.0;QUASAR;**1**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 ;
ADD S ACKCNT=ACKCNT+1 Q
 ;
 ;
 ;
POST(ACKVIEN) ;
 K DIRUT,DTOUT
 ;
 N ACKEXPT,ACKK1,ACKK2,ACKARR,ACK,ACKSC,VAEL,ACKVSC,ACKVAO,ACKVRAD,ACKVENV
 ;
 ;  Clear away Update PCE Problem list and Diag provider if invalid
 N ACKPROB,ACKDD,ACKDREC,ACKDUP,ACKDPROV,ACKDIAG
 S ACKDIAG=0
 S ACKPROB=$$PROB^ACKQUTL4(ACKPCE,ACKDIV)
 F  S ACKDIAG=$O(^ACK(509850.6,ACKVIEN,1,ACKDIAG)) Q:'ACKDIAG  D
 . S ACKDREC=$G(^ACK(509850.6,ACKVIEN,1,ACKDIAG,0)) Q:'ACKDREC
 . S ACKDUP=$P(ACKDREC,"^",3)
 . S ACKDPROV=$P(ACKDREC,"^",4)
 . I 'ACKPROB D  Q
 . . I ACKDUP'=""!(ACKDPROV'="") D
 . . . K ACKDD
 . . . S ACKDD(509850.63,ACKDIAG_","_ACKVIEN_",",.13)=""
 . . . S ACKDD(509850.63,ACKDIAG_","_ACKVIEN_",",.14)=""
 . . . D FILE^DIE("","ACKDD","") K ACKDD
 . I ACKPROB D  Q
 . . I 'ACKDUP,ACKDPROV'="" D
 . . . K ACKDD
 . . . S ACKDD(509850.63,ACKDIAG_","_ACKVIEN_",",.14)=""
 . . . S ACKDD(509850.63,ACKDIAG_","_ACKVIEN_",",.13)=""
 . . . D FILE^DIE("","ACKDD","") K ACKDD
 ;
 ;------------------------------------------------
 D ELIG^VADPT S ACKSC=$P(VAEL(3),U,1) K VAEL
 ;                                     
GETDATA D GETS^DIQ(509850.6,ACKVIEN,"20;25;30;35","I","ACK")
 ;
 S ACKVSC=ACK(509850.6,ACKVIEN_",",20,"I")
 S ACKVAO=ACK(509850.6,ACKVIEN_",",25,"I")
 S ACKVRAD=ACK(509850.6,ACKVIEN_",",30,"I")
 S ACKVENV=ACK(509850.6,ACKVIEN_",",35,"I")
 ;
 K ACK
 ;
NULL ;  NUll out fields that should not bo present or have been set
 ;  incorrectly
 ;
 I ACKSC=0,ACKVSC'="" S ACK(509850.6,ACKVIEN_",",20)="" S ACKVSC=""
 ;
 I ACKAO=0,ACKVAO'="" S ACK(509850.6,ACKVIEN_",",25)=""
 I ACKRAD=0,ACKVRAD'="" S ACK(509850.6,ACKVIEN_",",30)=""
 I ACKENV=0,ACKVENV'="" S ACK(509850.6,ACKVIEN_",",35)=""
 ;
 I ACKSC=1,ACKVSC=1,ACKVAO'="" S ACK(509850.6,ACKVIEN_",",25)=""
 I ACKSC=1,ACKVSC=1,ACKVRAD'="" S ACK(509850.6,ACKVIEN_",",30)=""
 I ACKSC=1,ACKVSC=1,ACKVENV'="" S ACK(509850.6,ACKVIEN_",",35)=""
 I $D(ACK) D FILE^DIE("","ACK") K ACK
 ;
 D CHKVST^ACKQUTL8(ACKVIEN,.ACKARR,1)
 ;
 I ACKARR=0 D MINIMUM G EXIT              ; Minimum data not entered
 ;
 I ACKARR=-1 D CORRUPT,DELETE S ACKOUT=2  ; Corrupt
 ;
 I ACKARR=3 S ACKOUT=1 G EXIT             ; Everything is okay
 ;                                         
 I 'ACKPCE,ACKARR=2 S ACKOUT=1 G EXIT     ; Interface off and no Quasar
 ;                                        ; errors - Everything is okay
 ;
 I ACKPCE D
 . D PCE
 . S ACKK1="" F  S ACKK1=$O(ACKARR(1,ACKK1)) Q:ACKK1=""  D
 . . W !,"           ",ACKARR(1,ACKK1)
 . S ACKK2="" F  S ACKK2=$O(ACKARR(2,ACKK2)) Q:ACKK2=""  D
 . . W !,"           ",ACKARR(2,ACKK2)
 . S ACKEXPT=$$EXPT(ACKVIEN)
 . W !! D CHOICE1 W !!
 ;
 I 'ACKPCE D
 . D QUASAR
 . S ACKK1="" F  S ACKK1=$O(ACKARR(1,ACKK1)) Q:ACKK1=""  D
 . . W !,"           ",ACKARR(1,ACKK1)
 . W !! D CHOICE W !!
 ;
EXIT ;  One way out
 Q ACKOUT
 ;
 ;
MINIMUM ;  Minimum Data not entered. If New Visit user can either delete or 
 ;  re-edit the visit if user is editing a visit user only has option
 ;  to re-edit the visit.
 ;
 D DISPLAY
 I ACKVISIT="NEW" D  Q
 . K DIR
 . S DIR("A")="Enter RETURN to Re-Edit Visit or '^' to Quit and Delete"
 . S DIR(0)="E" D ^DIR K DIR
 . I $D(DTOUT)!$D(DIRUT) S X="^"  ;  Time out or Quit
 . I X="^" S ACKOUT=2 D DELETE Q
 . S ACKOUT=0 Q   ;  Entered <Return>
 ;
 I ACKVISIT="EDIT" D  Q
 . K DIR
 . S DIR("?")="This option will not Quit until Quasars Minimum Data Requirements have been entered"
 . S DIR("A")="Press RETURN to Re-edit Visit",DIR(0)="E"
 . D ^DIR
 . S ACKOUT=0 Q
 ;
 ;
DELETE ;  Delete the entry
 ;
 W !!,$C(7),"<<INCOMPLETE RECORD DELETED!!>>",!!
 S DIK="^ACK(509850.6,",DA=ACKVIEN D ^DIK
 Q
 ;
 ;
CORRUPT ;  Display corrupt data message
 ;
 W !!,"ERROR - This record has become corrupted.",!
 ;
 Q
 ;
QUASAR ;  Display Quasar heading and missing fields
 ;
 W !!,"   WARNING - ",!
 W "   The following are fields required by QUASAR that have not been entered.",!
 W "   Enter <RETURN> to re-enter this function or '^' to quit.",!!
 ;
 Q
 ;
PCE ;  Display PCE missing fields
 ;
 W @IOF
 W "  WARNING - ",!!
 W "  The following are fields required by QUASAR & PCE that have not been entered.",!
 Q
 ;
PCE1 W !,"         '^'        Quit & File the A&SP visit but do not send incomplete A&SP"
 W !,"                    visit to PCE.  Or,"
 ;
 Q
 ;
CHOICE ;  Display choice - either enter '^' to quit entry or <Return> to 
 ;  re-enter the template
 ;
 K DIR S DIR(0)="E" D ^DIR K DIR
 I +Y=1 S ACKOUT=0
 I +Y=0 S ACKOUT=1
 S:$D(DIRUT) ACKOUT=1
 K DIRUT,DTOUT
 Q
 ;
CHOICE1 ; Prompt for PCE choice - An Exception may not be set when the PCE Inte-
 ; -face is on so dont prompt user with 'Send to PCE' options if no
 ; exception is present (i.e. ACKEXPT=0). 
 ;
 ;     If EXCEPTION       '^' - Quit but not send to PCE      
 ;                         R - Re-enter the template
 ;                         C - Continue send with errors
 ;     '^' - Returns 2     C  - Returns 1      R  - Returns 0
 ;
 ;     If not EXCEPTION     '^' - Quit
 ;                           R - Re-enter the template
 ;                           C - Continue file with errors
 ;     '^' & C - Returns 2   R  - Returns 0
 ;
DISP I ACKEXPT D PCE1
 S DIR("A")=" (C)ontinue or (R)enter "
 S DIR("B")="R"
 I ACKEXPT S DIR("?")=" Enter 'R' to Re-enter this function and amend data, 'C' to Continue and   send incomplete A&SP visit data to PCE or '^' to exit without sending     to PCE."
 I ACKEXPT'=1 S DIR("?")=" Enter 'R' to Re-enter this function and amend data or 'C' to Continue and file incomplete"
 I ACKEXPT S DIR(0)="S^R:Re-enter this function & amend data;C:Continue & send incomplete A&SP visit data to PCE;"
 I ACKEXPT'=1 S DIR(0)="S^R:Re-enter this function & amend data;C:Continue & file incomplete;"
 D ^DIR K DIR
 S:$D(DTOUT) X=U
 S:$D(DIRUT) ACKOUT=2
 I ACKEXPT I X="c"!(X="C") S ACKOUT=1
 I ACKEXPT'=1 I X="c"!(X="C") S ACKOUT=2
 I X="r"!(X="R") S ACKOUT=0
 I X="^" S ACKOUT=2
 ;                              
 Q 
 ;
UTLAUD ;
 N ACK,ACKRAV,ACKLAV,ACKI,ACKR1,ACKR2,ACKR3,ACKR4,ACKL1,ACKL2,ACKL3,ACKL4
 N ACKAR
 ;  Sets previous vist audiometric data into file
 ;
 I $L($G(ACKLAMD))>7 D  Q
 . F ACKI=1:1:16 S $P(^ACK(509850.6,ACKVIEN,4),U,ACKI)=$P(ACKLAMD,U,ACKI+1)
 ;
 ;
 ;  Calculates the average of the scores and sets the results into 
 ;  visit file
 ;
 D VALUES
 ;
 ;  Cannot calculate average if a null value exists
 I ACKR1=""!(ACKR2="")!(ACKR3="")!(ACKR4="") G LEFT
 S ACKRAV=ACKR1+ACKR2+ACKR3+ACKR4/4+.5\1 S:ACKRAV<0 ACKRAV=0
 S ACKAR(509850.6,ACKVIEN_",","4.06")=ACKRAV
 ;
LEFT ;  Cannot calculate average if a null value exists
 I ACKL1=""!(ACKL2="")!(ACKL3="")!(ACKL4="") Q
 S ACKLAV=ACKL1+ACKL2+ACKL3+ACKL4/4+.5\1 S:ACKLAV<0 ACKLAV=0
 S ACKAR(509850.6,ACKVIEN_",","4.12")=ACKLAV
 D FILE^DIE("K","ACKAR") K ACKAR
 ;
 Q
 ;
VALUES ;   Get value for calculation
 K ACK
 D GETS^DIQ(509850.6,ACKVIEN,"4.02;4.03;4.04;4.05;4.08;4.09;4.1;4.11","I","ACK")
 ;
 S ACKR1=ACK(509850.6,ACKVIEN_",",4.02,"I")
 S ACKR2=ACK(509850.6,ACKVIEN_",",4.03,"I")
 S ACKR3=ACK(509850.6,ACKVIEN_",",4.04,"I")
 S ACKR4=ACK(509850.6,ACKVIEN_",",4.05,"I")
 ;
 S ACKL1=ACK(509850.6,ACKVIEN_",",4.08,"I")
 S ACKL2=ACK(509850.6,ACKVIEN_",",4.09,"I")
 S ACKL3=ACK(509850.6,ACKVIEN_",",4.1,"I")
 S ACKL4=ACK(509850.6,ACKVIEN_",",4.11,"I")
 ;
 K ACK
 Q
 ;
EXPT(ACKVIEN) ;  Passes back 1 or zero depending if visit has an Exception
 ;          entry set up.
 N ACKEX
 S ACKEX=$$GET1^DIQ(509850.6,ACKVIEN_",",900,"I") I ACKEX="" Q 0
 I '$D(^ACK(509850.6,"AEX",ACKEX,ACKVIEN)) Q 0
 Q 1
 ;
 ;
DISPLAY ;
 W !!,"The following field(s) are required by QUASAR but have not been entered.",!!
 I $$GET1^DIQ(509850.6,ACKVIEN_",",5)="" W "     CDR Account",!
 I $$GET1^DIQ(509850.6,ACKVIEN_",",55)="" W "     Appointment Time",!
 W !!
 Q
 ;
