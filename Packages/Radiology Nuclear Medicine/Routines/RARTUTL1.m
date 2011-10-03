RARTUTL1 ;HIRMFO/GJC-Utility to display Pharm & Radiopharm data ;11/18/97  13:28
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
 ;
RDIO1(RADA) ; Display Radiopharmaceutical default data for Report displays
 ; Input: RADA -> ien of the Nuc Med Exam Data record (file 70.2)
 ; Output: 'X' -> $S(X'="":'abnormal exit',1:'full display')
 ; *** Called only if $P(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0),U,28)>0 ***
 N RADARY,RAXIT,Y S RAXIT=0,X=""
 D GETS^DIQ(70.2,RADA_",","**","NE","RADARY") Q:'$D(RADARY) ""
 D WAIT^RART1:($Y+6)>IOSL&('$D(RARTVERF)) Q:X="T"!(X="P")!(X="^") X
 I X="C" W @IOF S X=""
 N RAIENS S RAIENS=""
 F  S RAIENS=$O(RADARY(70.21,RAIENS)) Q:RAIENS=""  D  Q:RAXIT
 . N RADOSE S RADOSE=$S($G(RADARY(70.21,RAIENS,7,"E"))]"":", "_$G(RADARY(70.21,RAIENS,7,"E"))_" mCi",1:"")
 . D WAIT^RART1:($Y+6)>IOSL&('$D(RARTVERF)) S:X="T"!(X="P")!(X="^") RAXIT=1
 . Q:RAXIT
 . I X="C" W @IOF S X=""
 . W !,"     Radiopharmaceutical: "_$G(RADARY(70.21,RAIENS,.01,"E"))_RADOSE
 . D WAIT^RART1:($Y+6)>IOSL&('$D(RARTVERF)) S:X="T"!(X="P")!(X="^") RAXIT=1
 . Q:RAXIT
 . I X="C" W @IOF S X=""
 . Q:$G(RADARY(70.21,RAIENS,8,"E"))=""&($G(RADARY(70.21,RAIENS,9,"E"))="")&($G(RADARY(70.21,RAIENS,11,"E"))="")&($G(RADARY(70.21,RAIENS,12,"E"))="")
 . N RACNT,RALNGTH S RACNT=0
 . F RADFLDS=8,9,11,12 D
 .. W:'RACNT&(RADFLDS=8) ! ; initial line feed, spacing
 .. I $G(RADARY(70.21,RAIENS,RADFLDS,"E"))]"" D
 ... W:RACNT=2 ! S:RACNT=2 RACNT=0 ; NEW LINE
 ... S RACNT=RACNT+1
 ... W:RADFLDS=8 $S(RACNT=2:" Adm'd on ",1:"      Adm'd on ")
 ... W:RADFLDS=9 $S(RACNT=2:" by ",1:"      by ")
 ... W:RADFLDS=11 $S(RACNT=2:" Route ",1:"      Route ")
 ... W:RADFLDS=12 $S(RACNT=2:" Site ",1:"      Site ")
 ... S RALNGTH=$L($G(RADARY(70.21,RAIENS,RADFLDS,"E")))
 ... I RACNT=2,((RALNGTH+$X)>IOM) D
 .... W $E($G(RADARY(70.21,RAIENS,RADFLDS,"E")),1,(IOM-($X-1)))
 .... Q
 ... E  W $G(RADARY(70.21,RAIENS,RADFLDS,"E"))
 ... Q
 .. Q
 . Q
 Q $G(X)
