ACKQDWLU ;AUG/JLTP BIR/PTD HCIOFO/BH-QUASAR Utility Routine ; [ 04/25/96 10:03 ]
 ;;3.0;QUASAR;**1**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
WLSTATUS(ACKDA,ACKDIV,ACKWLMSG) ; determine the status for each division
 ; input :  ACKDA=identifier of month to be compiled
 ;      
 ;          array ACKDIV passed by reference (.ACKDIV) containing
 ;           the divisions selected for compilation
 ;          array ACKWLMSG passed by reference (.ACKWLMSG)
 ; output : ACKWLMSG=status^oktocontinue^message
 ;     and  ACKWLMSG(DIV)=null
 ;   where  status=0, 1, 2 or 3 (for information only)
 ;          oktocontinue=true, false or unknown (1, 0 or '?') 
 ;          message=text message for user
 ;          DIV=list of Divisions the message applies to
 ;           [ ACKWLMSG(DIV) corresponds to ACKDIV(DIV) ]
 N DIVNUM,DIVIEN,DIVMSG
 K ACKWLMSG
 ;
 ; the following section checks each division to determine the worst
 ;  case. it builds the array ACKWLMSG in the following way
 ;   ACKWLMSG=0^0^message - error, do not proceed.
 ;   ACKWLMSG=1^0^msg,ACKWLMSG(DIV)=null - if one or more 
 ;    divisions are currently compiling or have been verified.
 ;   ACKWLMSG=2^?^msg,ACKWLMSG(DIV)=null - if no divisions are
 ;    compiling and none have been verified, but one or more have been
 ;    compiled.
 ;   ACKWLMSG=3^1^msg - no division have been compiled, ok to continue
 S ACKWLMSG=5,DIVNUM=""
 F  S DIVNUM=$O(ACKDIV(DIVNUM)) Q:DIVNUM=""  D
 . S DIVIEN=$P(ACKDIV(DIVNUM),U,1) ; get division IEN
 . S DIVMSG=$$WLSTADIV(ACKDA,DIVIEN) ; determine status of this division
 . ; if this division is no worse than the current status then ignore
 . I +DIVMSG>ACKWLMSG Q
 . ; if this division is same as curr status then add to array
 . I +ACKWLMSG=+DIVMSG S:+ACKWLMSG<3 ACKWLMSG(DIVNUM)="" Q
 . ; if this division is worse than curr status then refresh array
 . K ACKWLMSG S ACKWLMSG=DIVMSG S:+ACKWLMSG<3 ACKWLMSG(DIVNUM)=""
 . ;
 Q ACKWLMSG
 ;
WLSTADIV(ACKDA,DIVIEN) ; determine status of ACKDIV for month ACKDA
 N MSG
 I '$D(^ACK(509850.7,ACKDA,5,DIVIEN,0)) D  Q MSG
 . S MSG="3^1^Capitation Report Not Generated"
 I $P(^ACK(509850.7,ACKDA,5,DIVIEN,0),U,8) D  Q MSG
 . S MSG="1^0^Capitation Report Already Verified"
 I $P(^ACK(509850.7,ACKDA,5,DIVIEN,0),U,4) D  Q MSG
 . S MSG="2^?^Capitation Report Already Generated"
 I $P(^ACK(509850.7,ACKDA,5,DIVIEN,0),U,2) D  Q MSG
 . S MSG="1^0^Capitation Report Already Running - Not Completed"
 Q "4^1^Capitation report Cleared down"
 ;
STAQES(ACKWLMSG) ;  Non Interactive run in the background
 ; input: ACKWLMSG as created in $$WLSTATUS above
 ; output: 1 if ok to continue, 0 if not
 ;
 ;  If user not allowed to continue then exit
 I $P(ACKWLMSG,U,2)=0 Q 0
 ;  Report not generated - set up record and continue     
 I $P(ACKWLMSG,U,1)=3,$P(ACKWLMSG,U,2)=1 Q 2
 ;  Data deleted from file - Okay to go
 I $P(ACKWLMSG,U,1)=4,$P(ACKWLMSG,U,2)=1 Q 1
 ;  Remaining option is a query - Already been run so quit
 I $P(ACKWLMSG,U,2)="?" Q 0
 Q
 ;
 ;
STAQES1(ACKDA,ACKDIV,ACKWLMSG) ;  Interactive Version run in the foreground
 ;
 ;  Input=ACKDA    -  Site ID and run date selected
 ;        ACKDIV   -  Cretated in ^ACKQDWL
 ;        ACKWLMSG -  Created in WLSTATUS (above)
 ;
 N ACKX,DIR,Y,DIRUT,DUOUT,DTOUT,ACKDIVNO
 ;  Display message and associated Divisions
 ;  If status is okay quit passing back 1
 I $P(ACKWLMSG,U,2)=1 Q 1
 ;  If user is not aloud to continue display problem and quit with "0"
 I $P(ACKWLMSG,U,2)=0 D DISPLAY Q 0
 ;
 ;  Remaining option is a query i.e. $P(ACKWLMSG,U,2)="?"
 ;
 S ACKDIVNO="" W !
 W $P(ACKWLMSG,U,3)_" for the following Division(s) ",!!
 F  S ACKDIVNO=$O(ACKWLMSG(ACKDIVNO)) Q:ACKDIVNO=""  D
 . W ?54,$P(ACKDIV(ACKDIVNO),U,3),!
 ;
 S DIWL=1,DIWR=80,DIWF=""
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Continue",DIR("A",1)=$P(ACKWLMSG,U,3)
 S DIR("?")="Answer Y for YES or N for NO."
 S DIR("??")="^W !?5,""If you answer YES, I will re-generate capitation"
 S DIR("??")=DIR("??")_" data.  This will"",!?5,""overwrite existing "
 S DIR("??")=DIR("??")_"capitation data for the chosen month."""
 D ^DIR
 S X=Y
 ;  If user has entered YES clean up files also check that all Division
 ;  levels have been created if no set them up  
 I X D CLEAN
 Q X
 ;
 ;
DISPLAY ;  Display Divisions that have problems
 ;
 ;  Called from STAQES1
 ;
 S ACKDIVNO="" W !!
 W $P(ACKWLMSG,U,3),!!
 W "This error has been found for the following Division(s) ",!!
 F  S ACKDIVNO=$O(ACKWLMSG(ACKDIVNO)) Q:ACKDIVNO=""  D
 . W ?44,$P(ACKDIV(ACKDIVNO),U,3),!
 Q
 ;
CLEAN ;  Clean out previously generated data for selected divisions
 ;
 ;  Called from STAQES1
 ;
 N X,DIVIEN,ACK1
 S ACK1=""
 D WAIT^DICD
 F  S ACK1=$O(ACKDIV(ACK1)) Q:ACK1=""  D
 . S DIVIEN=$P(ACKDIV(ACK1),U,1)
 . I '$D(^ACK(509850.7,ACKDA,5,DIVIEN)) D CREATE1 Q
 . D STF
 . F X=1,2,3,5 D MDL(X,DIVIEN,ACKDA)
 Q
 ;
CREATE(ACKDA,ACKM,ACKDIV) ;  Create new date level entry on the workload file
 ;
 ;  Called from ^ACKQDWL
 ;  Input=ACKDA  -  Site ID and run date selected
 ;        ACKM   -  Date run selected in Fm format with '00' for day.
 ;        ACKDIV -  Array of Divisions created in ^ACKQDWL
 ;
 I '$D(^ACK(509850.7,ACKDA,0)) D
 . S DIC="^ACK(509850.7,",DIC(0)="L",DLAYGO=509850.7,ACKLAYGO=""
 . S X=ACKM,DINUM=ACKDA
 . D FILE^DICN
 ;
 ;  If they dont exisit create new Division levels in the Workload file
 N DIVIEN,ACK1,X
 S ACK1=""
 F  S ACK1=$O(ACKDIV(ACK1)) Q:ACK1=""  D
 . S DIVIEN=$P(ACKDIV(ACK1),U,1)
 . I $D(^ACK(509850.7,ACKDA,5,DIVIEN)) Q
 . D CREATE1
 Q
 ;
CREATE1 ;  Called from CLEAN code block
 S DIC="^ACK(509850.7,"_ACKDA_",5,"
 S DIC(0)="L",DIC("P")="509850.75P"
 S DA=DIVIEN,DA(1)=ACKDA,X=DIVIEN,DINUM=DIVIEN
 K DD,DO D FILE^DICN
 Q
 ;  
STF ;  Delete the Start and end time and Job number from record.
 ;  Called from CLEAN code block.
 N ACKX,DIE,DR,DA,SL,X,ACKARR
 S ACKARR(509850.75,DIVIEN_","_ACKDA_",",5.02)="@"
 S ACKARR(509850.75,DIVIEN_","_ACKDA_",",5.03)="@"
 S ACKARR(509850.75,DIVIEN_","_ACKDA_",",5.04)="@"
 D FILE^DIE("K","ACKARR")
 Q
 ;
MDL(FLD,DIVIEN,ACKDA) ;  Delete all entries from Multiple
 ;  Called from CLEAN code block.
 ;  Input=FLD    - Multiple field level being deleted (1,2 or 3)
 ;        DIVIEN - Division IEN #
 ;        ACKDA  - Site ID and run date selected
 ;
 N ACKARR,ACKSUB
 S ACKSUB="0"
 F  S ACKSUB=$O(^ACK(509850.7,ACKDA,5,DIVIEN,FLD,ACKSUB)) Q:'ACKSUB!(ACKSUB'?.N)  D
 . I FLD=1 S ACKARR(509850.751,ACKSUB_","_DIVIEN_","_ACKDA_",",.01)="@"
 . I FLD=2 S ACKARR(509850.752,ACKSUB_","_DIVIEN_","_ACKDA_",",.01)="@"
 . I FLD=3 S ACKARR(509850.753,ACKSUB_","_DIVIEN_","_ACKDA_",",.01)="@"
 . I FLD=5 S ACKARR(509850.755,ACKSUB_","_DIVIEN_","_ACKDA_",",.01)="@"
 I $D(ACKARR) D FILE^DIE("K","ACKARR")
 Q
        ;
ECSTAT ;  For EC Stats.
 ;
 N ACKCODE
 S ACK6=0
 F  S ACK6=$O(^ACK(509850.7,ACKDA,5,ACKVDVN,5,ACK6)) Q:ACK6=""!(ACK6'?.N)  D
 . S ACKREC=^ACK(509850.7,ACKDA,5,ACKVDVN,5,ACK6,0)
 . S ACKAUD=$P(ACKREC,U,2,4),ACKSPE=$P(ACKREC,U,5,7)
 . S ACKCODE=$P(ACKREC,U,1)
 . I $TR(ACKAUD,"^","")'="" D
 . . S ^TMP("ACKQDWLP",$J,"R",ACKVDVN,5,"A",ACKCODE)=ACKAUD
 . . S ^TMP("ACKQDWLP",$J,"S",5,"A",ACKCODE,ACKVDVN)=ACKAUD
 . I $TR(ACKSPE,"^","")'="" D
 . . S ^TMP("ACKQDWLP",$J,"R",ACKVDVN,5,"S",ACKCODE)=ACKSPE
 . . S ^TMP("ACKQDWLP",$J,"S",5,"S",ACKCODE,ACKVDVN)=ACKSPE
 Q
