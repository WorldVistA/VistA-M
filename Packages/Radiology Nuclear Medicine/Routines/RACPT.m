RACPT ;HISC/GJC AISC/DMK-Procedure/CPT Stats Report ;12/29/00  11:27
 ;;5.0;Radiology/Nuclear Medicine;**26**;Mar 16, 1998
CHK D CHK^RACPT1 I $G(RAQUIT)!$G(RAPOP) G Q
START ; start processing
 U IO K ^TMP($J,"RA")
 S BEGDATE(0)=$E(BEGDATE,4,5)_"/"_$E(BEGDATE,6,7)_"/"_$E(BEGDATE,2,3)
 S ENDDATE(0)=$E(ENDDATE,4,5)_"/"_$E(ENDDATE,6,7)_"/"_$E(ENDDATE,2,3)
 S X="NOW",%DT="T" D ^%DT K %DT D D^RAUTL S RARUNDTE=Y
 S QQ="",$P(QQ,"=",80)="=",X=""
 S RASORT=$S(RASORT="B":"I,O",1:RASORT)
 F I=RABEG-.0001:0 S I=$O(^RADPT("AR",I)) Q:'I!(I>RAEND)  S RADFN="" F  S RADFN=$O(^RADPT("AR",I,RADFN)) Q:RADFN'>0  S RADTI=9999999.9999-I I $D(^RADPT(RADFN,"DT",RADTI,0)) S RAY=^(0) D MORE
DIV K RAIMAG
 F II=1:1 S RAI=$P(RASORT,",",II) Q:RAI=""  S RADIVN(0)="" F  S RADIVN(0)=$O(^TMP($J,"RA D-TYPE",RADIVN(0))) Q:RADIVN(0)=""  S RADIVN=0 F  S RADIVN=$O(^TMP($J,"RA D-TYPE",RADIVN(0),RADIVN)) Q:RADIVN'>0  D
 . S RAIMAG(0)=""
 . F  S RAIMAG(0)=$O(^TMP($J,"RA I-TYPE",RAIMAG(0))) Q:RAIMAG(0)=""  S RAIMAG=0 F  S RAIMAG=$O(^TMP($J,"RA I-TYPE",RAIMAG(0),RAIMAG)) Q:RAIMAG'>0  D
 .. S RAIMAG(1)=$E(RAIMAG(0),1,3)_"-"_RAIMAG
 .. I $O(^TMP($J,"RA",RAI,RADIVN,RAIMAG(1),""))="" S ^TMP($J,"RA",RAI,RADIVN,RAIMAG(1))="" Q  ;un-used Div-Img combin.
 .. S L="" F  S L=$O(^TMP($J,"RA",RAI,RADIVN,RAIMAG(1),L)) Q:L=""  S K="" F  S K=$O(^TMP($J,"RA",RAI,RADIVN,RAIMAG(1),L,K)) Q:K=""  D
 ... S ^TMP($J,"RA",RAI,RADIVN,RAIMAG(1),"COST")=^TMP($J,"RA",RAI,RADIVN,RAIMAG(1),L,K)*$P($G(^RAMIS(71,K,0)),U,10)+$G(^TMP($J,"RA",RAI,RADIVN,RAIMAG(1),"COST"))
 ... Q
 .. Q
 . Q
 S (RADIV,X,RAI)="",RAEXIT=0,PAGE=1
 F II=1:1 S RAI=$P(RASORT,",",II) Q:RAI=""!RAEXIT  D HANG^RACPT1:$$SRTPA^RACPT1(II) Q:RAEXIT  S RADIV="" F  S RADIV=$O(^TMP($J,"RA",RAI,RADIV)) Q:RADIV=""!RAEXIT  D GET
Q ;
 F I="RA","RA D-TYPE","RA I-TYPE","RA P-TYPE" K ^TMP($J,I)
 K BEGDATE,C,ENDDATE,I,II,J,K,L,PAGE,QQ,RABEG,RACAT,RACN,RACNI,CPT,RADFN
 K RADIV,RADIV1,RADIVN,RADTI,RAEND,RAEOPFLG,RAEXIT,RAI,RAIMAG,RAINPUT
 K RAPOP,RAPROC,RAQUIT,RARUNDTE,RASORT,RASW,RATOT,RAUT,RAX,RAY,RASV
 K %DT,DIR,DIROUT,DIRUT,DTOUT,DUOUT,RAMES,RANUMPRC,RAUTIL,X,Y,Z,ZTDESC
 K RACAN,ZTRTN,ZTSAVE,ZTSK,RACMLIST
 K:$D(RAPSTX) RACCESS,RAPSTX
 W ! D CLOSE^RAUTL
 K DDH,POP
 Q
 ; data storage description :
 ; ^tmp($j,"ra","o",499,"gen-1",36200,751)=2 ; two of this proc was done
 ; ^tmp($j,"ra","o",499,"gen-1",71021,59)=5 ; five of this proc was done
 ; ... etc.
 ; ^tmp($j,"ra","o",499,"gen-1","cost")=sum cost all procs this img typ
 ; ^tmp($j,"ra","o",499,"gen-1","done")=sum total no. procs this img typ
MORE ;
 S (RAIMAG,Y)=$P(RAY,U,2),C=$P(^DD(70.02,2,0),U,2) Q:RAIMAG'>0
 D Y^DIQ S RAIMAG(0)=Y,RAIMAG(1)=$E(RAIMAG(0),1,3)_"-"_RAIMAG
 I $D(^TMP($J,"RA I-TYPE",RAIMAG(0),RAIMAG))[0 Q  ;img loc not selected
 S (RADIVN,Y)=$P(RAY,U,3),C=$P(^DD(70.02,3,0),U,2) Q:RADIVN'>0
 D Y^DIQ S RADIVN(0)=Y
 I $D(^TMP($J,"RA D-TYPE",RADIVN(0),RADIVN))[0 Q  ;div not selected
 S RACNI=0 F  S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P",RACNI)) Q:'RACNI  I $D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) S RAX=^(0) D SET
 Q
SET ;
 Q:'RACAN&($P($G(^RA(72,+$P(RAX,"^",3),0)),"^",3)=0)  ; quit if
 ; cancelled exams are not to be included & our exam is indeed cancelled
 S RADIV=$P(RAY,"^",3) Q:RADIV=""
 S (RAPROC,Y)=+$P(RAX,"^",2),C=$P(^DD(70.03,2,0),U,2) Q:RAPROC'>0
 D Y^DIQ S RAPROC(0)=Y
 I $D(^TMP($J,"RA P-TYPE",RAPROC(0),RAPROC))[0,RAINPUT=0 Q  ;proc not sel
 S RACAT=$S($D(^DIC(42,+$P(RAX,"^",6),0)):"I",1:"O")
 Q:RASORT'[RACAT  ;category of in/outpatient status not selected
 S CPT=$S($D(^RAMIS(71,RAPROC,0)):$P(^(0),"^",9),1:"") Q:CPT=""
 D:$G(RACMLIST) CMLIST^RAWKL1(.CPT)
 S ^TMP($J,"RA",RACAT,RADIV,RAIMAG(1),CPT,RAPROC)=$G(^TMP($J,"RA",RACAT,RADIV,RAIMAG(1),CPT,RAPROC))+1
 S ^TMP($J,"RA",RACAT,RADIV,RAIMAG(1),"DONE")=$G(^TMP($J,"RA",RACAT,RADIV,RAIMAG(1),"DONE"))+1
 Q
GET ;
 S RAIMAG(1)="",RAEOPFLG=0
 F  S RAIMAG(1)=$O(^TMP($J,"RA",RAI,RADIV,RAIMAG(1))) Q:RAIMAG(1)=""!RAEXIT  S RATOT(3)=0 D
 . S RAIMAG=+$P(RAIMAG(1),"-",2)
 . S RAIMAG(0)=$P($G(^RA(79.2,RAIMAG,0)),U)
 . I RAIMAG(0)="" S RAIMAG(0)="UNKNOWN"
 . D HED^RACPT1
 . I $O(^TMP($J,"RA",RAI,RADIV,RAIMAG(1),""))="" D  Q
 .. W !!,"No reports entered for the selected time frame."
 .. I ($O(^TMP($J,"RA",RAI,RADIV,RAIMAG(1)))]"")!($O(^TMP($J,"RA",RAI,RADIV))]"")!($O(^TMP($J,"RA",RAI))]"") S RAEOPFLG=1 D HANG^RACPT1
 .. Q
 . S CPT=""
 . F  S CPT=$O(^TMP($J,"RA",RAI,RADIV,RAIMAG(1),CPT)) Q:CPT=""!RAEXIT  S J=0 D
 .. F  S J=$O(^TMP($J,"RA",RAI,RADIV,RAIMAG(1),CPT,J)) Q:J'>0!RAEXIT  S RATOT=^(J) D PRINT^RACPT1 Q:RAEXIT
 .. Q
 . W !?12,"Total for this imaging type -->",?45,$J(^TMP($J,"RA",RAI,RADIV,RAIMAG(1),"DONE"),5),?63,$J(^("COST"),12,2)
 . I ($O(^TMP($J,"RA",RAI,RADIV,RAIMAG(1)))]"")!($O(^TMP($J,"RA",RAI,RADIV))]"") S RAEOPFLG=1 D HANG^RACPT1
 . Q
 Q
