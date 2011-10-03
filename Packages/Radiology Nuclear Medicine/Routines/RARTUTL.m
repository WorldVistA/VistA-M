RARTUTL ;HIRMFO/GJC-Utility to display Pharm & Radiopharm data ;11/18/97  13:33
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
PHARM(RADA) ; Display Pharmaceutical default data
 ; Input: RADA -> ien for the Examinations (50) multiple.
 ;        in the following format: RACNI_","_RADTI_","_RADFN_","
 ; *** Called only if $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"RX",0)) ***
 N RA1,RACNT,RAPHARM,RASUB,X,Y S RA1="",RASUB=70.15
 D GETS^DIQ(70.03,RADA,"200*","NE","RAPHARM") Q:'$D(RAPHARM)
 I '$D(RAUTOE),($Y>(IOSL-4)) D HANG^RARTR2 Q:$D(RAOOUT)  D HD^RARTR
 F  S RA1=$O(RAPHARM(RASUB,RA1)) Q:RA1']""  D  Q:$D(RAOOUT)
 . S RACNT=0
 . I $G(RAPHARM(RASUB,RA1,.01,"E"))]"" D
 .. N RADOSE S RADOSE=$S($G(RAPHARM(RASUB,RA1,2,"E"))]"":", "_$G(RAPHARM(RASUB,RA1,2,"E")),1:"")
 .. W:'$D(RAUTOE) !,"     Pharmaceutical: ",$E($G(RAPHARM(RASUB,RA1,.01,"E")),1,40)_RADOSE
 .. S:$D(RAUTOE) ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="     Pharmaceutical: "_$E($G(RAPHARM(RASUB,RA1,.01,"E")),1,40)_RADOSE
 .. Q
 . I '$D(RAUTOE),($Y>(IOSL-4)) D HANG^RARTR2 Q:$D(RAOOUT)  D HD^RARTR
 . W:'$D(RAUTOE)&(($G(RAPHARM(RASUB,RA1,3,"E"))]"")!($G(RAPHARM(RASUB,RA1,4,"E"))]"")) !
 . I $G(RAPHARM(RASUB,RA1,3,"E"))]"" D
 .. S RACNT=RACNT+1
 .. I '$D(RAUTOE) D
 ... W "      Adm'd on "_$E($G(RAPHARM(RASUB,RA1,3,"E")),1,21)
 ... Q
 .. E  D
 ... S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="      Adm'd on "_$E($G(RAPHARM(RASUB,RA1,3,"E")),1,21)
 ... Q
 .. Q
 . I $G(RAPHARM(RASUB,RA1,4,"E"))]"" D
 .. S RACNT=RACNT+1
 .. I '$D(RAUTOE) D
 ... N RAX S RAX="""by "",$E($G(RAPHARM(RASUB,RA1,4,""E"")),1,30)"
 ... W:RACNT=1 "      ",@RAX W:RACNT=2 " ",@RAX
 ... Q
 .. E  D
 ... S:RACNT=2 ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_" by "_$E($G(RAPHARM(RASUB,RA1,4,"E")),1,30)
 ... S:RACNT=1 ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="      by "_$E($G(RAPHARM(RASUB,RA1,4,"E")),1,30)
 ... Q
 .. Q
 . Q
 Q
RDIO(RADA) ; Display Radiopharmaceutical default data for Report displays
 ; Input: RADA -> ien of the Nuc Med Exam Data record (file 70.2)
 ; *** Called only if $P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,28)>0 ***
 N RADARY,X,Y
 D GETS^DIQ(70.2,RADA_",","**","NE","RADARY") Q:'$D(RADARY)
 I '$D(RAUTOE),($Y>(IOSL-4)) D HANG^RARTR2 Q:$D(RAOOUT)  D HD^RARTR
 N RAIENS S RAIENS=""
 F  S RAIENS=$O(RADARY(70.21,RAIENS)) Q:RAIENS=""  D  Q:$D(RAOOUT)
 . N RADOSE S RADOSE=$S($G(RADARY(70.21,RAIENS,7,"E"))]"":", "_$G(RADARY(70.21,RAIENS,7,"E"))_" mCi",1:"")
 . I '$D(RAUTOE),($Y>(IOSL-4)) D HANG^RARTR2 Q:$D(RAOOUT)  D HD^RARTR
 . I '$D(RAUTOE) D
 .. W !,"     Radiopharmaceutical: "_$G(RADARY(70.21,RAIENS,.01,"E"))_RADOSE
 .. Q
 . E  D
 .. S ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))="     Radiopharmaceutical: "_$G(RADARY(70.21,RAIENS,.01,"E"))_RADOSE
 .. Q
 . Q:$G(RADARY(70.21,RAIENS,8,"E"))=""&($G(RADARY(70.21,RAIENS,9,"E"))="")&($G(RADARY(70.21,RAIENS,11,"E"))="")&($G(RADARY(70.21,RAIENS,12,"E"))="")
 . N RACNT,RALNGTH S RACNT=0
 . F RADFLDS=8,9,11,12 D  Q:'$D(RAUTOE)&($D(RAOOUT))
 .. W:'RACNT&(RADFLDS=8)&('$D(RAUTOE)) ! ; initial line feed, spacing
 .. S:'RACNT&(RADFLDS=8)&($D(RAUTOE)) ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=""
 .. I $G(RADARY(70.21,RAIENS,RADFLDS,"E"))]"" D
 ... W:RACNT=2 ! S:RACNT=2 RACNT=0 ; NEW LINE
 ... S RACNT=RACNT+1
 ... I '$D(RAUTOE) D
 .... I $Y>(IOSL-4) D HANG^RARTR2 Q:$D(RAOOUT)  D HD^RARTR W !
 .... W:RADFLDS=8 $S(RACNT=2:" Adm'd on ",1:"      Adm'd on ")
 .... W:RADFLDS=9 $S(RACNT=2:" by ",1:"      by ")
 .... W:RADFLDS=11 $S(RACNT=2:" Route ",1:"      Route ")
 .... W:RADFLDS=12 $S(RACNT=2:" Site ",1:"      Site ")
 .... S RALNGTH=$G(RADARY(70.21,RAIENS,RADFLDS,"E"))
 .... I RACNT=2,((RALNGTH+$X)>IOM) D
 ..... W $E($G(RADARY(70.21,RAIENS,RADFLDS,"E")),1,(IOM-($X-1)))
 ..... Q
 .... E  W $G(RADARY(70.21,RAIENS,RADFLDS,"E"))
 .... I $Y>(IOSL-4) D HANG^RARTR2 Q:$D(RAOOUT)  D HD^RARTR W !
 .... Q
 ... E  D
 .... S:RADFLDS=8 ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_$S(RACNT=2:" Adm'd on ",1:"      Adm'd on ")
 .... S:RADFLDS=9 ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_$S(RACNT=2:" by ",1:"      by ")
 .... S:RADFLDS=11 ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_$S(RACNT=2:" Route ",1:"      Route ")
 .... S:RADFLDS=12 ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_$S(RACNT=2:" Site ",1:"      Site ")
 .... S ^TMP($J,"RA AUTOE",RAACNT)=^TMP($J,"RA AUTOE",RAACNT)_$G(RADARY(70.21,RAIENS,RADFLDS,"E"))
 .... S:RACNT=2 ^TMP($J,"RA AUTOE",$$INCR^RAUTL4(RAACNT))=""
 .... S:RACNT=2 RACNT=0
 .... Q
 ... Q
 .. Q
 . Q
 Q
PHARM1(RADA) ; Display Pharmaceutical default data
 ; Input: RADA -> ien for the Examinations (50) multiple.
 ;        in the following format: RACNI_","_RADTI_","_RADFN_","
 ; Output: 'X' -> $S(X'="":'abnormal exit',1:'full display')
 ; *** Called only if $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"RX",0)) ***
 N RA1,RACNT,RAPHARM,RASUB,RAXIT,Y S (RA1,X)="",RASUB=70.15,RAXIT=0
 D GETS^DIQ(70.03,RADA,"200*","NE","RAPHARM") Q:'$D(RAPHARM) ""
 D WAIT^RART1:($Y+6)>IOSL&('$D(RARTVERF)) Q:X="T"!(X="P")!(X="^") X
 I X="C" W @IOF S X=""
 F  S RA1=$O(RAPHARM(RASUB,RA1)) Q:RA1']""  D  Q:RAXIT
 . S RACNT=0
 . I $G(RAPHARM(RASUB,RA1,.01,"E"))]"" D
 .. N RADOSE S RADOSE=$S($G(RAPHARM(RASUB,RA1,2,"E"))]"":", "_$G(RAPHARM(RASUB,RA1,2,"E")),1:"")
 .. W !,"     Pharmaceutical: ",$E($G(RAPHARM(RASUB,RA1,.01,"E")),1,40)_RADOSE
 .. Q
 . D WAIT^RART1:($Y+6)>IOSL&('$D(RARTVERF)) S:X="T"!(X="P")!(X="^") RAXIT=1
 . Q:RAXIT
 . I X="C" W @IOF S X=""
 . W:$G(RAPHARM(RASUB,RA1,3,"E"))]""!($G(RAPHARM(RASUB,RA1,4,"E"))]"") !
 . I $G(RAPHARM(RASUB,RA1,3,"E"))]"" D
 .. S RACNT=RACNT+1
 .. W "      Adm'd "_$E($G(RAPHARM(RASUB,RA1,3,"E")),1,21)
 .. Q
 . I $G(RAPHARM(RASUB,RA1,4,"E"))]"" D
 .. S RACNT=RACNT+1
 .. N RAX S RAX="""by "",$E($G(RAPHARM(RASUB,RA1,4,""E"")),1,30)"
 .. W:RACNT=1 "      ",@RAX W:RACNT=2 " ",@RAX
 .. Q
 . Q
 Q $G(X)
