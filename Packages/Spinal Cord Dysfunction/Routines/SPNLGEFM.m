SPNLGEFM ;ISC-SF/DAD - RETRIEVE DATA FROM FILE 154.1 ;10/25/2001
 ;;2.0;Spinal Cord Dysfunction;**2,16**;01/02/1997
 ;;
EXTRACT(RECN,FORMAT,FLAG) ;
 ;RECN...........This is an IEN in file 2.
 ;FORMAT.........This is determines whether the data will be in
 ;               internal or external format. (IS NOT USED IN THIS VERSION)
 ;FLAG...........This is set to 1 if there is an error retrieveing the
 ;               data.
 ;
 N SPNFD0,SPNFD1
 S (SPNFD0,FLAG)=0
 F  S SPNFD0=$O(^SPNL(154.1,"B",RECN,SPNFD0)) Q:SPNFD0'>0  D
 . I RECN'=$P($G(^SPNL(154.1,SPNFD0,0)),U) Q  ; *** Bad B xref
 . I "^1^2^"'[(U_$P($G(^SPNL(154.1,SPNFD0,0)),U,2)_U) Q
 . I $O(^SPNL(154.1,SPNFD0,1,0)) D  ; *** Clinician mult WITH data
 .. S ^TMP("SPNXMRK",$J,SPNFD0)=""
 .. S SPNFD1=0
 .. F  S SPNFD1=$O(^SPNL(154.1,SPNFD0,1,SPNFD1)) Q:SPNFD1'>0  D
 ... D ADDREC^SPNLGE("FM",$$GETFIM(SPNFD0,SPNFD1))
 ... Q
 .. Q
 . Q
 Q
 ;
GETFIM(SPNFD0,SPNFD1) ; *** Get FIM data (file #154.1)
 ;
 ;Required:
 ; SPNFD0 = FIM file (#154.1) IEN
 ;Optional:
 ; SPNFD1 = CLINICIAN multiple (#154.101) IEN
 ;Returns:
 ; FIM_Type ^ Respondent_Type ^ Date_Recorded ^ Eating ^ Grooming ^
 ; Bathing ^ Dressing_Upper_Body ^ Dressing_Lower_Body_From_Bath ^
 ; Toileting ^ Bladder_Management ^ Bowel_Management ^
 ; Xfer_To_Bed/Chair/Wheelchair ^ Xfer_To_Toilet ^ Xfer_To_Tub/Shower ^
 ; Walk/Wheelchair ^ Stairs ^ Comprehension ^ Expression ^
 ; Social_Interaction ^ Problem_Solving ^ Memory ^ Clinician ^
 ; Get_To_Places_Outside_Of_Home ^ Shopping ^
 ; Planning_And_Cooking_Own_Meals ^ Doing_Housework ^ Handling_Money ^
 ; Method_Ambulation_(Walking) ^ Method_Ambulation_(Wheelchair) ^
 ; Help_During_Last_2_Weeks ^ Number_Of_Hours_Of_Help ^
 ; Received_Most_Medical_Care ^ VA_Medical_Center_1 ^ VA_Medical_Center_2
 ;
 N SPNF,SPNFDATA,SPNPIECE,SPNSTAT
 S SPNPIECE="22^^12"
 F SPNF=0,2 D
 . S SPNFDATA(SPNF)=$G(^SPNL(154.1,SPNFD0,SPNF))
 . I $L(SPNFDATA(SPNF),U)'=$P(SPNPIECE,U,SPNF+1) D
 .. S $P(SPNFDATA(SPNF),U,$P(SPNPIECE,U,SPNF+1))=""
 .. Q
 . Q
 F SPNF=5:1:22 D  ; FIM Data
 . S $P(SPNFDATA(0),U,SPNF)=$$FIMLEVEL($P(SPNFDATA(0),U,SPNF))
 . Q
 S SPNFDATA(1)=$$CLIN($P($G(^SPNL(154.1,SPNFD0,1,+$G(SPNFD1),0)),U))
 F SPNF=10:1:12 S $P(SPNFDATA(2),U,SPNF)=""
 I $G(^SPNL(154,$P($G(^SPNL(154.1,SPNFD0,0)),U),3))'="" D
 .S SPNSTAT=$G(^SPNL(154,$P($G(^SPNL(154.1,SPNFD0,0)),U),3))
 .S $P(SPNFDATA(2),U,10)=$P(SPNSTAT,U) ; RECEIVED 
 .S $P(SPNFDATA(2),U,11)=$$STATNUMB($P(SPNSTAT,U,2)) ; VA1
 .S $P(SPNFDATA(2),U,12)=$$STATNUMB($P(SPNSTAT,U,3)) ; VA2
 .Q
 S $P(SPNFDATA(0),U,22)=$P(SPNFDATA(0),U,22)
 S $P(SPNFDATA(2),U,12)=$P(SPNFDATA(2),U,12)
 Q $P(SPNFDATA(0),U,2,22)_U_SPNFDATA(1)_U_$P(SPNFDATA(2),U,1,12)
 ;
STATNUMB(D0) ; *** Return: Station_Number
 ;  D0 = INSTITUTION file ($4) IEN
 Q $P($G(^DIC(4,+D0,99)),U)
 ;
FIMLEVEL(D0) ; *** Return: FIM_Level_Number
 ;  D0 = FIM LEVEL file (#154.11) IEN
 Q $P($G(^SPNL(154.11,+D0,0)),U)
 ;
CLIN(D0) ; *** Return Clinician_Name
 ;  D0 = NEW PERSON file (#200) IEN
 Q $P($G(^VA(200,+D0,0)),U)
