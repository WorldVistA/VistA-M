RAPROD2 ;HIRMFO/GJC-Display Med & Radiopharm values for exams ;12/12/96  13:35
 ;;5.0;Radiology/Nuclear Medicine;**45**;Mar 16, 1998
 ;
PHARM(RADA) ; Display Pharmaceutical default data for Exam displays
 ; Input: RADA -> ien for the Examinations (50) multiple.
 ;        in the following format: RACNI_","_RADTI_","_RADFN_","
 ; *** Called only if $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"RX",0)) ***
 N RA1,RACNT,RAHDR,RAPHARM,RASUB S RA1="",RASUB=70.15,RAXIT=0
 D GETS^DIQ(70.03,RADA,"200*","NE","RAPHARM") Q:'$D(RAPHARM)
 S RAHDR=$$CJ^XLFSTR("Medications",IOM,"-")
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 W !,RAHDR,!
 F  S RA1=$O(RAPHARM(RASUB,RA1)) Q:RA1']""  D  Q:RAXIT
 . S RACNT=0
 . I $G(RAPHARM(RASUB,RA1,.01,"E"))]"" D
 .. W "Med: ",$E($G(RAPHARM(RASUB,RA1,.01,"E")),1,32)
 .. S RACNT=RACNT+1
 .. Q
 . I $G(RAPHARM(RASUB,RA1,2,"E"))]"" D
 .. N RAX S RAX="""Dose Adm'd: "",$E($G(RAPHARM(RASUB,RA1,2,""E"")),1,32)"
 .. S RACNT=RACNT+1 W:RACNT=1 @RAX W:RACNT=2 ?39,@RAX
 .. Q
 . I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 . I RACNT=2 W ! S RACNT=0
 . I $G(RAPHARM(RASUB,RA1,4,"E"))]"" D
 .. N RAX S RAX="""Adm'd By: "",$E($G(RAPHARM(RASUB,RA1,4,""E"")),1,28)"
 .. S RACNT=RACNT+1 W:RACNT=1 @RAX W:RACNT=2 ?39,@RAX
 .. Q
 . I RACNT=2 W ! S RACNT=0
 . I $G(RAPHARM(RASUB,RA1,3,"E"))]"" D
 .. N RAX S RAX="""Date Adm'd: "",$E($G(RAPHARM(RASUB,RA1,3,""E"")),1,30)"
 .. S RACNT=RACNT+1 W:RACNT=1 @RAX W:RACNT=2 ?39,@RAX
 .. Q
 . W:$O(RAPHARM(RASUB,RA1)) !!
 . Q
 Q
RDIO(RADA) ; Display Radiopharmaceutical default data for Exam displays
 ; Input: RADA -> ien of the Nuc Med Exam Data record (file 70.2)
 ; *** Called only if $P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,28)>0 ***
 N RACNT,RADARY,RAFLDS,RAHDR,RAIENS,RAOPUT,X,Y
 S RAIENS="",RAXIT=0 D GETS^DIQ(70.2,RADA_",","**","NE","RADARY")
 Q:'$D(RADARY)  S RAHDR=$$CJ^XLFSTR("Radiopharmaceuticals",IOM,"-")
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 W !,RAHDR,!
 F  S RAIENS=$O(RADARY(70.21,RAIENS)) Q:RAIENS=""  D  Q:RAXIT
 . S (RACNT,RAFLDS)=0
 . F  S RAFLDS=$O(RADARY(70.21,RAIENS,RAFLDS)) Q:RAFLDS'>0  D  Q:RAXIT
 .. Q:$G(RADARY(70.21,RAIENS,RAFLDS,"E"))']""
 .. I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D HDR
 .. S RAOPUT=$$TRN1(RAFLDS)_$G(RADARY(70.21,RAIENS,RAFLDS,"E"))_$S(RAFLDS=2:" mCi",RAFLDS=4:" mCi",RAFLDS=7:" mCi",1:""),RACNT=RACNT+1
 .. W:RACNT=1 $E(RAOPUT,1,38) W:RACNT=2 ?39,$E(RAOPUT,1,39)
 .. W:RACNT=2 ! S:RACNT=2 RACNT=0
 .. Q
 . W:$O(RADARY(70.21,RAIENS)) !!
 . Q
 Q
TRN1(X) ; Translate Radiopharmaceutical field name to a shorter length.
 Q:X=.01 "Rpharm: " Q:X=2 "Dose (MD Override): " Q:X=3 "Prescriber: "
 Q:X=4 "Activity Drawn: " Q:X=5 "Drawn: " Q:X=6 "Measured By: "
 Q:X=7 "Dose Adm'd: " Q:X=8 "Date Adm'd: " Q:X=9 "Adm'd By: "
 Q:X=10 "Witness: " Q:X=11 "Route: " Q:X=12 "Site: "
 Q:X=12.5 "Site Text: " Q:X=13 "Lot #: " Q:X=14 "Volume: "
 Q:X=15 "Form: "
HDR ; Pharmaceutical/Radiopharmaceutical Header
 W @IOF,!,RAHDR,! S RACNT=0
 Q
 ;
CMHIST(RADFN,RADTI,RACNI) ;main body
 ;input: RADFN=DFN of the Rad/Nuc Med patient (file 2)
 ;       RADTI=exam date/time (inverse)
 ;       RACNI=ien of exam record (examinations sub-file 70.03)
 ;
 N X S RAHD="Contrast Media Edit History"
 S $P(RALINE,"-",(IOM+1))=""
 S RAPG=0 W:$E(IOST,1,2)="C-" @IOF ;clear screen
 D CMHDR S (RACMDT,RAXIT)=0
 ;$O down 'B' xref in ascending chronological order
 F  S RACMDT=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"AUD","B",RACMDT)) Q:'RACMDT  D  Q:RAXIT
 .S RAIEN=+$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"AUD","B",RACMDT,0))
 .;get_changed date/time, get_previous CM value, get_user
 .S RAY(0)=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"AUD",RAIEN,0))
 .S RAADT=$$FMTE^XLFDT($P(RAY(0),U),"1P"),RACMU=$P(RAY(0),U,2)
 .S:+$P(RAY(0),U,3) RAAU=$$GET1^DIQ(200,$P(RAY(0),U,3)_",",.01)
 .S X=$S($L(RACMU):$$CONTRAST^RACMHIS(RACMU),1:"")
 .I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D CMHDR
 .W !,RAADT,?40,$E($G(RAAU),1,35) W:X="" !
 .I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  D CMHDR
 .I X'="" D  D ^DIWW K ^UTILITY($J,"W")
 ..S DIWL=3,DIWR=70,DIWF="W" D ^DIWP
 ..Q
 .Q
EXIT ;clean up symbol table, message to user
 ;if there are no records to print, alert user
 W:'$D(RAY(0))#2 !,$$CJ^XLFSTR("*** No Records To Print ***",IOM)
 K RAADT,RAAU,RACH2,RACHNG2,RACMU,RAHD,RAIEN,RALINE,RAPG
 K RACMDT,RAY
 Q
 ;
CMHDR ; print header
 W:RAPG @IOF S RAPG=RAPG+1
 W !,$$CJ^XLFSTR(RAHD,IOM)
 W !,"Date/Time Changed",?40,"User",!?2,"Contrast Media"
 W !,$$CJ^XLFSTR(RALINE,IOM)
 Q
 ;
