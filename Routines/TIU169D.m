TIU169D ; SLC/MAM - Data, etc for Option for TIU*1*169 ; 10/4/2004
 ;;1.0;Text Integration Utilities;**169**;Jun 20, 1997
 ;
ADDITEM(NUM,TIUDA,PIEN)  ; Add DDEF TIUDA to Parent; Return Item IEN
 N MENUTXT,TIUFPRIV,TIUFISCR
 N DIE,DR
 S TIUFPRIV=1
 N DA,DIC,DLAYGO,X,Y
 N I,DIY
 S DA(1)=PIEN
 S DIC="^TIU(8925.1,"_DA(1)_",10,",DIC(0)="LX"
 S DLAYGO=8925.14
 ; -- If TIUDA is say, x, and Parent has x as IFN in Item subfile,
 ;    code finds item x under parent instead of creating a new item,
 ;    so don't use "`"_TIUDA:
 S X=^TMP("TIU169",$J,"BASICS",NUM,"NAME")
 ; -- Make sure the DDEF it adds is TIUDA and not another w same name:
 S TIUFISCR=TIUDA ; activates item screen on fld 10, Subfld .01 in DD
 D ^DIC I Y'>0!($P(Y,U,3)'=1) S ^TMP("TIU169ERR",$J,NUM)="ADDITEM"
 Q Y
 ;
FILEITEM(NUM,PIEN,ITEMDA) ; File Menu Text for DDEF item ITEMDA
 ;under parent
 N TIUFPRIV,MENUTXT,ITEMFDA
 K TIUIERR
 S TIUFPRIV=1,MENUTXT=$G(^TMP("TIU169",$J,"DATA",NUM,"MENUTXT"))
 S ITEMFDA(8925.14,ITEMDA_","_PIEN_",",4)=MENUTXT
 D FILE^DIE("TE","ITEMFDA","TIUIERR")
 I $D(TIUIERR) S ^TMP("TIU169ERR",$J,NUM)="FILEITEM"
 Q
 ;
DELETE(TIUDA,PIEN,ITEMDA) ; Delete DDEF TIUDA; If parent PIEN and
 ;Item IEN ITEMDA sent, first delete item from parent
 N DA,DIK,X,Y,I
 I $G(PIEN),$G(ITEMDA) D
 . S DA(1)=PIEN,DA=ITEMDA,DIK="^TIU(8925.1,DA(1),10," D ^DIK
 N DA,DIK
 S DA=TIUDA,DIK="^TIU(8925.1," D ^DIK
 Q
 ;
PRINT ; Print out results from message array ^TMP("TIU169MSG",$J
 N TIUCNT,TIUCONT
 I $D(ZTQUEUED) S ZTREQ="@" ; Tell TaskMan to delete Task log entry
 I $E(IOST)="C-" W @IOF,!
 S TIUCNT="",TIUCONT=1
 F  S TIUCNT=$O(^TMP("TIU169MSG",$J,TIUCNT)) Q:TIUCNT=""  D  Q:'TIUCONT
 . S TIUCONT=$$SETCONT Q:'TIUCONT
 . W ^TMP("TIU169MSG",$J,TIUCNT),!
PRINTX Q
 ;
STOP() ;on screen paging check
 ; quits TIUCONT=1 if cont. ELSE quits TIUCONT=0
 N DIR,Y,TIUCONT
 S DIR(0)="E" D ^DIR
 S TIUCONT=Y
 I TIUCONT W @IOF,!
 Q TIUCONT
 ;
SETCONT() ; D form feed, Set TIUCONT
 N TIUCONT
 S TIUCONT=1
 I $E(IOST)="C-" G SETX:$Y+5<IOSL
 I $E(IOST)="C-" S TIUCONT=$$STOP G SETX
 G:$Y+8<IOSL SETX
 W @IOF
SETX Q TIUCONT
 ;
SETDATA ; Set more data for DDEFS
 ; Basic data set in TIUEN169.  See rtn TIUEN169 for numbered list of
 ;DDEF Names and Types.
 ; -- Set Print Name, Owner, Status, National, Exterior Type into
 ;    FILEDATA node of data array ^TMP("TIU169":
 ; -- First, set Docmt Class (#1):
 N NUM S NUM=1 D
 . S ^TMP("TIU169",$J,"FILEDATA",NUM,.03)=$G(^TMP("TIU169",$J,"BASICS",NUM,"NAME")) ;Name node MUST exist.  Using $G to ease testing of fewer DDEFS.
 . S ^TMP("TIU169",$J,"FILEDATA",NUM,.06)="CLINICAL COORDINATOR"
 . S ^TMP("TIU169",$J,"FILEDATA",NUM,.07)="ACTIVE"
 . S ^TMP("TIU169",$J,"FILEDATA",NUM,.13)="YES"
 . S ^TMP("TIU169",$J,"FILEDATA",1,.04)="DOCUMENT CLASS"
 ; -- Set Titles:
 N NUM F NUM=2:1:58 D
 . S ^TMP("TIU169",$J,"FILEDATA",NUM,.03)=$G(^TMP("TIU169",$J,"BASICS",NUM,"NAME"))
 . S ^TMP("TIU169",$J,"FILEDATA",NUM,.06)="CLINICAL COORDINATOR"
 . S ^TMP("TIU169",$J,"FILEDATA",NUM,.07)="INACTIVE"
 . S ^TMP("TIU169",$J,"FILEDATA",NUM,.13)="NO"
 . S ^TMP("TIU169",$J,"FILEDATA",NUM,.04)="TITLE"
 ; -- Set Parent and Menu Text into DATA nodes of ^TMP("TIU169":
 ; -- Set PIEN node = IEN of parent if known, or if not,
 ;    set PNUM node = DDEF# of parent                   
 ;    Parent must exist by the time this DDEF is created.
 ; -- Parent of DC is CL Progress Notes:
 S ^TMP("TIU169",$J,"DATA",1,"PIEN")=3 ;PN IEN is 3
 ; -- Parent of Titles is DC:
 N NUM F NUM=2:1:58 S ^TMP("TIU169",$J,"DATA",NUM,"PNUM")=1 ; DC DDEF #
 ; -- Menutext:
 F NUM=1:1:58 S ^TMP("TIU169",$J,"DATA",NUM,"MENUTXT")=$P($T(MENUTXT+NUM),";;",2,99)
 Q
 ;
MENUTXT ; Use $T to get menutext from this list. Cut off at 20 chars.
 ;;C&P Exam Reports
 ;;Examination
 ;;Multiple Exam
 ;;Acromegaly
 ;;A&A or Housebound
 ;;Arrhythmias
 ;;Arteries, Veins, Mis
 ;;Audio
 ;;Bones
 ;;Brain and Spinal Cor
 ;;Chronic Fatigue Synd
 ;;Cold Injury Protocol
 ;;Cranial Nerves
 ;;Cushing's Syndrome
 ;;Dental and Oral
 ;;Diabetes Mellitus
 ;;Digestive Conditions
 ;;Ear Disease
 ;;Eating Disorders
 ;;Endocrine Diseases
 ;;Epilepsy and Narcole
 ;;Esophagus & Hiatal H
 ;;Eye Examination
 ;;Feet
 ;;Fibromyalgia
 ;;General Medical
 ;;Genitourinary Exam
 ;;Gulf War
 ;;Gynecological Condit
 ;;Hand, Thumb, & Finge
 ;;Heart
 ;;Hemic Disorders
 ;;HIV-Related Illness
 ;;Hypertension
 ;;Infectious, Immune,
 ;;Intestines
 ;;Joints
 ;;Liver, Gall Bladder,
 ;;Lymphatic Disorders
 ;;Mental Disorders
 ;;Mouth, Lips, and Ton
 ;;Muscles
 ;;Neurological Disorde
 ;;Nose, Sinus, Larynx,
 ;;Peripheral Nerves
 ;;POW Protocol
 ;;PTSD, Initial
 ;;PTSD, Review
 ;;Pulmonary Tuberculos
 ;;Rectum and Anus
 ;;Residuals of Amputat
 ;;Respiratory
 ;;Scars
 ;;Sense of Smell and T
 ;;Skin Diseases
 ;;Spine
 ;;Stomach, Duodenum, P
 ;;Thyroid and Parathyr
 Q
 ;
