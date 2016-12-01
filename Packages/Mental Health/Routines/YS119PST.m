YS119PST ;SLC/KCM - Patch 119 post-init - PCL-5 ; 9/15/2015
 ;;5.01;MENTAL HEALTH;**119**;Dec 30, 1994;Build 40
 Q
 ;
POST ; Post-init calls for patch 119
 D PCL5
 D FIXTESTS^YS119PS0
 Q
PCL5 ; Update the PCL-5 definitions
 D FIXDATE^YS119PS3 ; update the date prompt
 D UPDPCLQ  ; update the PCL-5 questions
 D UPDCPLX  ; update tests that are scored by DLL only
 D DROPPCL  ; disable the PCL tests replaced by PCL-5
 D ADDSCLS  ; add scales for cluster B-E scores
 D UPDPCLR  ; update PCL-5 report
 N TSTIEN   ; make sure definition reloaded by clients 
 S TSTIEN=$$FINDTEST^YS119PS0("PCL-5")
 D UPDDT^YS119PS0(TSTIEN)
 Q
UPDPCLQ ; Update the PCL-5 questions
 N QUES,PCL5,CONTENT,DESIG,QIEN,X0
 ; set up the replacement questions
 S QUES("10.")=$P($T(Q10),";;",2,99)
 S QUES("14.")=$P($T(Q14),";;",2,99)
 S QUES("15.")=$P($T(Q15),";;",2,99)
 S QUES("16.")=$P($T(Q16),";;",2,99)
 ; get the ien for PCL-5
 S PCL5=$O(^YTT(601.71,"B","PCL-5",0))
 ; loop through PCL-5 content, find the questions with matching "designator"
 S CONTENT=0 F  S CONTENT=$O(^YTT(601.76,"AC",PCL5,CONTENT)) Q:'CONTENT  D
 . S X0=^YTT(601.76,CONTENT,0),DESIG=$P(X0,U,5)
 . Q:'$L(DESIG)        ; no designator
 . Q:'$D(QUES(DESIG))  ; no matching replacement
 . S QIEN=$P(X0,U,4)
 . ;
 . N WP,DIERR
 . S WP(1)=QUES(DESIG)
 . D WP^DIE(601.72,QIEN_",",1,"","WP")
 . I $D(DIERR) D BMES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 . D CLEAN^DILF
 Q
 ;
UPDCPLX ; Update complex (DLL-scored) test entries
 N IDX,TSTNM,TSTIEN
 S IDX=0 F  S IDX=IDX+1,TSTNM=$P($T(DLLTEST+IDX),";;",2) Q:TSTNM="zzzzz"  D
 . S TSTIEN=$O(^YTT(601.71,"B",TSTNM,0)) Q:'TSTIEN
 . D FLD2DLL(TSTIEN) ; update TAG and ROUTINE for special scoring
 Q
FLD2DLL(TSTIEN) ; update record to contain DLL^YTSCORE
 N FDA,DIERR
 S FDA(601.71,TSTIEN_",",91)="DLL"
 S FDA(601.71,TSTIEN_",",92)="YTSCORE"
 D FILE^DIE("","FDA")
 I $D(DIERR) D BMES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 Q
DROPPCL ; Disable the other PCL tests
 N TSTNM,TSTIEN
 F TSTNM="PCLC","PCLM","PCLS","NEOPI" D
 . S TSTIEN=$O(^YTT(601.71,"B",TSTNM,0)) Q:'TSTIEN
 . D FLD2DROP(TSTIEN) ; change OPERATIONAL to "Dropped"
 . D UPDDT^YS119PS0(TSTIEN)
 Q
FLD2DROP(TSTIEN) ; update OPERATIONAL field to be "Dropped"
 N FDA,DIERR
 S FDA(601.71,TSTIEN_",",10)="D"
 D FILE^DIE("","FDA")
 I $D(DIERR) D MES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 Q
ADDSCLS ; add scales for PCL-5
 N PCL5,GRP,SCALE,KEYID
 S KEYID=9725
 S PCL5=$O(^YTT(601.71,"B","PCL-5",0))  ; PCL-5 ien
 S GRP=$O(^YTT(601.86,"AC",PCL5,1,0))   ; ScaleGroup, Sequence 1 ien
 D ADDSCALE(.SCALE,990,GRP,2,"Cluster B") I SCALE D ADDKEYS(SCALE,1,5)
 D ADDSCALE(.SCALE,991,GRP,3,"Cluster C") I SCALE D ADDKEYS(SCALE,6,7)
 D ADDSCALE(.SCALE,992,GRP,4,"Cluster D") I SCALE D ADDKEYS(SCALE,8,14)
 D ADDSCALE(.SCALE,993,GRP,5,"Cluster E") I SCALE D ADDKEYS(SCALE,15,20)
 Q
ADDSCALE(SCALE,ID,GRP,SEQ,NM) ; add a new scale
 I $D(^YTT(601.87,"AC",GRP,SEQ)) D  Q  ; quit if scale already there
 . S SCALE=$O(^YTT(601.87,"AC",GRP,SEQ,0))
 ; if something already at ID, increment ID until empty node is found
 I $D(^YTT(601.87,ID)) F  S ID=ID+1 Q:'$D(^YTT(601.87,ID))
 ; use FM to add the new scale (PCL-5 Cluster x)
 N FDA,FDAIEN,DIERR
 S FDAIEN(1)=ID
 S FDA(601.87,"+1,",.01)=ID
 S FDA(601.87,"+1,",1)=GRP
 S FDA(601.87,"+1,",2)=SEQ
 S FDA(601.87,"+1,",3)=NM
 S FDA(601.87,"+1,",4)=NM
 D UPDATE^DIE("","FDA","FDAIEN")
 I $D(DIERR) D MES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 S SCALE=$S($D(DIERR):0,1:FDAIEN(1))
 D CLEAN^DILF
 Q
ADDKEYS(SCALE,FIRST,LAST) ; Add a set of scoring keys for PCL-5
 ; from: ADDSLCS expects: PCL5,KEYID
 N VALUES,VALUE,QNUM,QIEN,CIEN,X0,DESIG
 S VALUES(0)="Not at all"
 S VALUES(1)="A little bit"
 S VALUES(2)="Moderately"
 S VALUES(3)="Quite a bit"
 S VALUES(4)="Extremely"
 F QNUM=FIRST:1:LAST D
 . ; using designator, figure out the IEN for the question
 . S QIEN=0  ; QIEN=question IEN, CIEN=content IEN
 . S CIEN=0 F  S CIEN=$O(^YTT(601.76,"AC",PCL5,CIEN)) Q:'CIEN  D  Q:QIEN
 . . S X0=^YTT(601.76,CIEN,0),DESIG=$P(X0,U,5)
 . . I DESIG=(QNUM_".") S QIEN=$P(X0,U,4)
 . ; for the question (QIEN), add the 5 scoring keys for this scale
 . F VALUE=0:1:4 S KEYID=KEYID+1 D ADDKEY(KEYID,SCALE,QIEN,VALUES(VALUE),VALUE)
 Q
ADDKEY(ID,SCALE,QUESTION,TARGET,VALUE) ; add a new scoring key
 ; quit if key already there
 N EXISTS,I
 S EXISTS=0
 S I=0 F  S I=$O(^YTT(601.91,"AC",SCALE,I)) Q:'I  D  Q:EXISTS
 . I ($P(^YTT(601.91,I,0),U,3))=QUESTION,($P(^(0),U,4)=TARGET) S EXISTS=1
 Q:EXISTS
 ; if something already at ID, increment ID until empty node is found
 I $D(^YTT(601.91,ID)) F  S ID=ID+1 Q:'$D(^YTT(601.91,ID))
 ; use FM to add new key
 N FDA,FDAIEN,DIERR
 S FDAIEN(1)=ID
 S FDA(601.91,"+1,",.01)=ID
 S FDA(601.91,"+1,",1)=SCALE
 S FDA(601.91,"+1,",2)=QUESTION
 S FDA(601.91,"+1,",3)=TARGET
 S FDA(601.91,"+1,",4)=VALUE
 D UPDATE^DIE("","FDA","FDAIEN")
 I $D(DIERR) D MES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 Q
UPDPCLR ; update the PCL-5 report to include cluster information
 N PCL5,RPT,WP,I,X,DIERR
 S PCL5=$O(^YTT(601.71,"B","PCL-5",0))     ; PCL-5 ien
 S RPT=$O(^YTT(601.93,"C",PCL5,0)) Q:'RPT  ; Report ien
 F I=1:1 S X=$P($T(RPTFMT+I),";;",2,99) Q:X="zzzzz"  S WP(I)=X
 D WP^DIE(601.93,RPT_",",2,"","WP")
 I $D(DIERR) D MES^XPDUTL("ERROR: "_$G(^TMP("DIERR",$J,1,"TEXT",1)))
 D CLEAN^DILF
 Q
DLLTEST ; tests scored by DLL
 ;;BAM-C
 ;;BAM-R
 ;;BASIS-24
 ;;BHS
 ;;BSI
 ;;BSL-23
 ;;CAM
 ;;CDR
 ;;DBAS
 ;;DERS
 ;;FAD
 ;;FAST
 ;;ISMI
 ;;MDQ
 ;;MINICOG
 ;;MMPI-2-RF
 ;;NEO-PI-3
 ;;POQ
 ;;QOLI
 ;;QOLIE-31
 ;;SBR II
 ;;SOCRATES 8A
 ;;SOCRATES 8D
 ;;SST-VOF
 ;;SST-VOI
 ;;STMS
 ;;VR-12
 ;;WHODAS 2
 ;;WHOQOL-BREF
 ;;WHYMPI
 ;;zzzzz
 ;
Q10 ;;Blaming yourself or someone else for the stressful experience or what happened after it?
Q14 ;;Trouble experiencing positive feelings (for example, being unable to feel happiness or have loving feelings for people close to you)?
Q15 ;;Irritable behavior, angry outbursts, or acting aggressively?
Q16 ;;Taking too many risks or doing things that could cause you harm?
 ;
RPTFMT ; PCL-5 report text
 ;;.| PCL-5| | Date Given: <.Date_Given.>| Clinician: <.Staff_Ordered_By.>| Location: <.Location.>| | Veteran: <.Patient_Name_Last_First.>| SSN: <.Patient_SSN.>| DOB: <.Patient_Date_Of_Birth.>
 ;;(<.Patient_Age.>)| Gender: <.Patient_Gender.>| | |             PCL-5 Score:  <-PCL-5->| | Cluster B (items  1-5) :  <-Cluster B->| Cluster C (items  6-7) :  <-Cluster C->| Cluster D (items  8-14):
 ;;  <-Cluster D->| Cluster E (items 15-20):  <-Cluster E->| |
 ;;| Interpretive Statement:| PCL-5 has a total score range of 0-80, with higher scores indicating greater PTSD symptom severity.| |
 ;;  0-10:  no or minimal symptoms reported| 11-20:  mild symptoms reported| 21-40:  moderate symptoms reported| 41-60:  severe symptoms reported| 61-80:  very severe symptoms reported|
 ;; | | Questions and Answers: | | The event you experienced was: <*Answer_6839*>| | The event happened: <*Answer_6840*>| |  1. 
 ;;Repeated, disturbing, and unwanted memories of the stressful experience?|     <*Answer_6841*>|  2. Repeated, disturbing dreams of the stressful experience?|     <*Answer_6842*>|  3. Suddenly feeling or
 ;; acting as if the stressful experience were actually happening again (as if you were actually back there reliving it)?|     <*Answer_6843*>|  4. Feeling very upset when something reminded you of the
 ;; stressful experience?|     <*Answer_6844*>|  5. Having strong physical reactions when something reminded you of the stressful experience (for example, heart pounding, trouble breathing, sweating)?|
 ;;     <*Answer_6845*>|  6. Avoiding memories, thoughts, or feelings related to the stressful experience?|     <*Answer_6846*>|  7. Avoiding external reminders of the stressful experience (for example,
 ;; people, places, conversations, activities, objects, or situations)?|     <*Answer_6847*>|  8. Trouble remembering important parts of the stressful experience?|     <*Answer_6848*>|  9. Having strong
 ;; negative beliefs about yourself, other people, or the world (for example, having thoughts such as: I am bad, there is something seriously wrong with me, no one can be trusted, the world is
 ;; completely dangerous)?|     <*Answer_6849*>| 10. Blaming yourself or someone else for the stressful experience or what happened after it?|     <*Answer_6850*>| 11. Having strong negative
 ;; feelings such as fear, horror, anger, guilt, or shame?|     <*Answer_6851*>| 12. Loss of interest in activities that you used to enjoy?|     <*Answer_6852*>| 13. Feeling distant or cut off from other
 ;; people?|     <*Answer_6853*>| 14. Trouble experiencing positive feelings (for example, being unable to feel happiness or have loving feelings for people close to you)?|     
 ;;<*Answer_6854*>| 15. Irritable behavior, angry outbursts, or acting aggressively?|     <*Answer_6855*>| 16. Taking too many risks or doing things that could cause you harm?|     <*Answer_6856*>| 17. Being
 ;; "superalert" or watchful or on guard?|     <*Answer_6857*>| 18. Feeling jumpy or easily startled?|     <*Answer_6858*>| 19. Having difficulty concentrating?|     <*Answer_6859*>| 20. Trouble falling
 ;; or staying asleep?|     <*Answer_6860*>
 ;;| | 0=not at all  1=a little bit  2=moderately  3=quite a bit  4=extremely
 ;;| | Information contained in this note is based on a self-report assessment and is not sufficient to use alone for diagnostic purposes.  Assessment results
 ;; should be verified for accuracy and used in conjunction with other diagnostic activities and procedures.|  $~
 ;;zzzzz
