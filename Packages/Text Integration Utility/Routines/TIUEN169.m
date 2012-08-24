TIUEN169 ; SLC/MAM - Environment Check Rtn for TIU*1*169 ; 7/28/2004
 ;;1.0;Text Integration Utilities;**169**;Jun 20, 1997
 ; External References
 ;   DBIA 3409  ^USR(8930,"B"
MAIN ; Check environment.  If problems found, warn but do not abort install.
 ; -- Check if done:
 I $G(^XTMP("TIU169","DONE"))="ALL" W !,"All Document Definitions for C&P Worksheets have already been",!," created. You won't need to rerun the option." Q
 I $O(^USR(8930,"B","CLINICAL COORDINATOR",""))="" W !,"I can't find User Class CLINICAL COORDINATOR. You won't be able to run",!,"the option that creates the Document Definitions without this class. See",!,"patch description.",!
 W !,"Remember to run option TIU169 DDEFS, C&P WORKSHEETS",!,"after installing the patch."
 Q
 ;
SETBASIC ; Set up basic data in ^TMP("TIU169",$J,"BASICS")
 N NUMBER
 ; -- Set ^TMP("TIU169",$J,"BASICS",[NUMBER],["INTTYPE" or "NAME"])
 ; -- Set basic data NAME and interior TYPE for new DDEFS into TMP.
 ;    Reference DDEFS by NUMBER.
 ;    Number parent-to-be BEFORE child.
 ;    Name MUST be upper case or ADDITEM fails
 S ^TMP("TIU169",$J,"BASICS",1,"INTTYPE")="DC"
 F NUMBER=2:1:58 S ^TMP("TIU169",$J,"BASICS",NUMBER,"INTTYPE")="DOC"
 F NUMBER=1:1:58 S ^TMP("TIU169",$J,"BASICS",NUMBER,"NAME")=$P($T(NAME+NUMBER),";;",2,99)
 Q
 ;
TIUDUPS(TIUDUPS,TIUDCDA) ; Set array TIUDUPS of potential duplicate DDEFS
 ; TIUDCDA = IEN of designated DC or 0 if none desig.
 ; Checks for Titles;
 ; If no DC designated, checks for DC too.
 N NUM
 S (TIUDUPS("INDC"),TIUDUPS("NOTINDC"))=0
 I $G(^XTMP("TIU169","DONE"))="ALL" Q
 F NUM=1:1:58 Q:'NUM  D
 . ; -- When looking for duplicates, ignore DDEF if
 . ;    previously created, designated,or skipped by this patch:
 . I $G(^XTMP("TIU169",NUM,"DONE")) Q
 . ; -- If site already has DDEF w/ same Name & Type as one
 . ;    we are exporting, set its number into array TIUDUPS:
 . N NAME,TYPE,TIUDA S TIUDA=0
 . S NAME=^TMP("TIU169",$J,"BASICS",NUM,"NAME")
 . S TYPE=^TMP("TIU169",$J,"BASICS",NUM,"INTTYPE")
 . F  S TIUDA=$O(^TIU(8925.1,"B",NAME,TIUDA)) Q:+TIUDA'>0  D
 . . Q:$P($G(^TIU(8925.1,+TIUDA,0)),U,4)'=TYPE
 . . I $$ISA^TIULX(+TIUDA,TIUDCDA) S TIUDUPS("INDC",NUM)=+TIUDA,TIUDUPS("INDC")=TIUDUPS("INDC")+1 I 1
 . . E  I TIUDA'=+DESDC S TIUDUPS("NOTINDC",NUM)=+TIUDA,TIUDUPS("NOTINDC")=TIUDUPS("NOTINDC")+1
 Q
 ;
LISTDUPS(TIUDUPS,INDCFLG) ; List duplicates by name
 ; TIUDUPS = array as set in TIUDUPS. Required.
 ; INDCFLG = 1: List dups in designated DC for skipping over
 ; INDCFLG '= 1: List dups not in designated DC - Quit
 N NUM,SUBSCPT,TIUCNT
 I '$G(INDCFLG),$G(TIUDUPS("NOTINDC",1)) D  Q
 . W !!,"You already have the Document Class exported by this patch, C&P EXAMINATION"
 . W !,"REPORTS. Please designate it or change its name (and print name)."
 I '$G(INDCFLG),$G(TIUDUPS("NOTINDC")) D
 . S SUBSCPT="NOTINDC"
 . W !!,"You already have the following DDEFS exported by this patch. I cannot create"
 . W !,"duplicates. Please change their names so they no longer match exported DDEFS,"
 . W !,"or if you are not using them, delete them. If you change the name of a DDEF"
 . W !,"you plan to continue using, remember to update its Print Name as well."
 . W !,"For help, contact Enterprise VistA Support."
 . W !!,"You may not run this option until these matches are eliminated."
 I $G(INDCFLG),$G(TIUDUPS("INDC")) D
 . S SUBSCPT="INDC"
 . W !!,"Your designated C&P Document Class already has matching Titles:"
 Q:'$D(SUBSCPT)
 S NUM=0
 F TIUCNT=1:1:10 S NUM=$O(TIUDUPS(SUBSCPT,NUM)) Q:'NUM  D
 . W !,"     "_^TMP("TIU169",$J,"BASICS",NUM,"NAME")
 I TIUDUPS(SUBSCPT)>8 W !,"... and more; ",TIUDUPS(SUBSCPT)," in all."
 Q
 ;
DESGNATE() ; Get Designated DC to create C&P titles under
 ; Returns:
 ; -1 - timeout, ^, lookup failed
 ;  0 - none designated; create new DC
 ;  DCIFN^DCNAME in 8925.1 - designated DC
 N TIUY,DTOUT,DUOUT,DIRUT,DIROUT
 W !,"I can create a new C&P Document Class or you can designate an existing one."
 W !,"If you designate an existing one, I will change its name to C&P EXAMINATION REPORTS. I will create the new C&P Titles under it, skipping any you already have."
 S TIUY=$$READ^TIUU("YO","Do you want to designate a Document Class","YES")
 I $D(DIRUT) Q -1
 I +TIUY'=1 Q 0
 N Y,DIC,DTOUT,DUOUT
 S DIC=8925.1,DIC(0)="ABEFQ",DIC("S")="I $P(^(0),U,4)=""DC"",$D(^TIU(8925.1,3,10,""B"",Y))"
 D ^DIC
 Q Y
 ;
NAME ; Names of DDEFS in order from 1 to 58
 ;;C&P EXAMINATION REPORTS
 ;;C&P EXAMINATION
 ;;C&P MULTIPLE EXAM
 ;;C&P ACROMEGALY
 ;;C&P AID AND ATTENDANCE OR HOUSEBOUND EXAM
 ;;C&P ARRHYTHMIAS
 ;;C&P ARTERIES, VEINS AND MISC
 ;;C&P AUDIO
 ;;C&P BONES
 ;;C&P BRAIN AND SPINAL CORD
 ;;C&P CHRONIC FATIGUE SYNDROME
 ;;C&P COLD INJURY PROTOCOL
 ;;C&P CRANIAL NERVES
 ;;C&P CUSHING'S SYNDROME
 ;;C&P DENTAL AND ORAL
 ;;C&P DIABETES MELLITUS
 ;;C&P DIGESTIVE CONDITIONS
 ;;C&P EAR DISEASE
 ;;C&P EATING DISORDERS
 ;;C&P ENDOCRINE DISEASES
 ;;C&P EPILEPSY AND NARCOLEPSY
 ;;C&P ESOPHAGUS AND HIATAL HERNIA
 ;;C&P EYE
 ;;C&P FEET
 ;;C&P FIBROMYALGIA
 ;;C&P GENERAL MEDICAL
 ;;C&P GENITOURINARY
 ;;C&P GULF WAR PROTOCOL
 ;;C&P GYNECOLOGICAL CONDITIONS AND DISORDERS OF THE BREAST
 ;;C&P HAND, THUMB AND FINGERS
 ;;C&P HEART
 ;;C&P HEMIC DISORDERS
 ;;C&P HIV-RELATED ILLNESS
 ;;C&P HYPERTENSION
 ;;C&P INFECTIOUS, IMMUNE AND NUTRITIONAL DISABILITIES
 ;;C&P INTESTINES
 ;;C&P JOINTS (SHOULDER, ELBOW, WRIST, HIP, KNEE, ANKLE)
 ;;C&P LIVER, GALL BLADDER, AND PANCREAS
 ;;C&P LYMPHATIC DISORDERS
 ;;C&P MENTAL DISORDERS
 ;;C&P MOUTH, LIPS, AND TONGUE
 ;;C&P MUSCLES
 ;;C&P NEUROLOGICAL DISORDERS
 ;;C&P NOSE, SINUS, LARYNX, AND PHARYNX
 ;;C&P PERIPHERAL NERVES
 ;;C&P PRISONER OF WAR PROTOCOL
 ;;C&P PTSD, INITIAL EVALUATION
 ;;C&P PTSD, REVIEW
 ;;C&P PULMONARY TUBERCULOSIS AND MYCOBACTERIAL DISEASES
 ;;C&P RECTUM AND ANUS
 ;;C&P RESIDUALS OF AMPUTATIONS
 ;;C&P RESPIRATORY
 ;;C&P SCARS
 ;;C&P SENSE OF SMELL AND TASTE
 ;;C&P SKIN DISEASES
 ;;C&P SPINE
 ;;C&P STOMACH, DUODENUM, AND PERITONEAL ADHESIONS
 ;;C&P THYROID AND PARATHYROID DISEASES
 Q
