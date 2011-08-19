RARTUVR2 ;HISC/FPT,SWM -Unverified Reports ;11/26/97  07:57
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
PRINT ; print entries
 S RACNT(0)=RACNT(0)+1
 D HDR
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAOUT=1 Q:RAOUT=1
 I ^TMP($J,"RAUVR",RADIVNME,RAITNAME)=0 D NEGRPT D  Q
 . I RACNT(0)<RACNT S RAOUT=$$EOS^RAUTL5()
 . Q
 F RARS="S","R","U" Q:RAOUT!(RAOUT)  D
 . I ($Y+4)>IOSL S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HDR
 . S RASTRING=$S(RARS="S":"STAFF^STFCNT",RARS="R":"RESIDENT^RESCNT",1:"UNKNOWN^UNKCNT")
 . D:RABD="B" HOURAGE
 . W !,"* ",$P(RASTRING,U),": ",^TMP($J,RADIVNME,RAITNAME,$P(RASTRING,U,2))," *"
 . S RAFL=0,RAIPNAME=""
 . F  S RAIPNAME=$O(^TMP($J,RADIVNME,RAITNAME,RARS,RAIPNAME)) Q:RAIPNAME=""  D  Q:RAOUT
 .. I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAOUT=1 Q:RAOUT=1
 .. D PRTB
 .. Q:RAOUT  D:RABD="D" PRTD
 .. Q
 . W !!
 . Q
 W !
 Q:RAOUT  I RACNT(0)<RACNT S RAOUT=$$EOS^RAUTL5()
 Q
HDR ; header
 W:$Y>0 @IOF W !?$S(IOM<81:20,1:IOM-90),">>>>> Unverified Reports ("_$S(RABD="B":"brief",1:"detailed")_") <<<<<" S RAPAGE=RAPAGE+1 W ?$S(IOM<81:70,1:IOM-10),"Page: ",RAPAGE
 W !,"Division: ",?10,RADIVNME,?$S(IOM<81:43,1:IOM-37),"Report Date Range:",?$S(IOM<81:62,1:IOM-18),$$FMTE^XLFDT(BEGDATE)
 W !,"Imaging Type: ",RAITNAME,?$S(IOM<81:62,1:IOM-18),$$FMTE^XLFDT(ENDDATE),!,"Run Date: ",RARUNDAT,?$S(IOM<81:45,1:IOM-35),"Total Unverified Reports: ",^TMP($J,"RAUVR",RADIVNME,RAITNAME),!
 Q
 ;
NEGRPT ; negative reports
 W !!?$S(IOM<81:26,1:IOM-84),"***************************"
 W !?$S(IOM<81:26,1:IOM-84),"*  No Unverified Reports  *"
 W !?$S(IOM<81:26,1:IOM-84),"***************************",!
 Q
PRTB I ($Y+4)>IOSL S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HDR
 I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAOUT=1 Q:RAOUT=1
 W:RABD="D" !,RAEQUAL
 D:RABD="D" HOURAGE
 S RA1=50+$L(RACUT(3))+21
 W !,$J(^TMP($J,RADIVNME,RAITNAME,RARS,RAIPNAME),3)," "
 W $E(RAIPNAME,1,20)
 W ?29,$S($G(^TMP($J,RADIVNME,RAITNAME,RARS,RAIPNAME,"H",1)):$J(^(1),$L(RACUT(3))),1:$J(0,$L(RACUT(3)))),?39,$S($G(^(2)):$J(^(2),$L(RACUT(3))),1:$J(0,$L(RACUT(3))))
 W ?49,$S($G(^(3)):$J(^(3),$L(RACUT(3))),1:$J(0,$L(RACUT(3)))),?59,$S($G(^(4)):$J(^(4),$L(RACUT(3))+2),1:$J(0,$L(RACUT(3))+2))
 Q
PRTD K ^TMP($J,"RA0") N RA1,RA2,RA3,RA4,RARPT,RADFN,RADTI,RACNI
 Q:'+$O(^TMP($J,RADIVNME,RAITNAME,RARS,RAIPNAME,0))
 S RARPT=0
 F  S RARPT=$O(^TMP($J,RADIVNME,RAITNAME,RARS,RAIPNAME,RARPT)) Q:'+RARPT  S X=^(RARPT) D  Q:RAOUT
 . I $D(ZTQUEUED) D STOPCHK^RAUTL9 S:$G(ZTSTOP)=1 RAOUT=1 Q:RAOUT=1
 . S RADFN=$P(X,U),RADTI=$P(X,U,2),RACNI=$P(X,U,3)
 . S RA1=$G(^RARPT(RARPT,0)),RA2=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))
 . S RA3=$P(RA1,U,6) ;date report entered
 . S DFN=RADFN D DEM^VADPT
 . S ^TMP($J,"RA0",RA3)=$E(VADM(1))_$$SSN^RAUTL_U_$P(RA1,U,5) ;pc1=1st initial of last name_ssn, pc2=report status
 . K VADM S X=$P(RA1,U,12) D SETX,APPEND ;pc3=pre-verif dt
 . S X=$$FMTE^XLFDT($P(RA1,U,3)),X=$E($P(X,"@",2),1,5),X=$S(X]"":"@"_X,1:"")
 . S X=$P(RA1,U)_X D APPEND ;pc4=day/case_exam hrmin
 . S X=$P(RA2,U,11) S X=$S(+X:$P($G(^RAO(75.1,X,0)),U,21),1:"") D SETX,APPEND ; pc5=date desired from file 75.1
 . S X=$P(RA2,U,2) D APPEND ;pc6=procedure pointer
 . Q
 S RA3=0 F  S RA3=$O(^TMP($J,"RA0",RA3)) Q:RA3=""  D  Q:RAOUT  W !
 . I ($Y+4)>IOSL S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HDR
 . S X=RA3 D SETX
 . W !,"Transcrip: ",X,?27,"ID: ",$P(^TMP($J,"RA0",RA3),U),?47
 . S X=$P(^(RA3),U,2) W $S(X="D":"DRAFT",X="PD":"PROB/DRAFT",X="R":"RELEASE",X="V":"VERIFIED",1:"")
 . W ?58,"Pre-ver: ",$P(^(RA3),U,3)
 . W !,"Exam Date: ",$P(^TMP($J,"RA0",RA3),U,4),?31,"Order Date Desired: ",$P(^(RA3),U,5)
 . I +$P(^(RA3),U,6) W:IOM<81 ! W ?$S(IOM<81:0,1:IOM-66),"Proc: ",$E($P($G(^RAMIS(71,$P(^(RA3),U,6),0)),U),1,60)
 . S Y(0)=RA2 D PHYS^RARTUVR1
 . Q
 Q
SETX I $L(X)=0 S X="" Q
 S RA4=$E($P($$FMTE^XLFDT(X),"@",2),1,5),RA4=$S(RA4]"":"@"_RA4,1:"")
 S X=$E(X,4,5)_$E(X,6,7)_$E(X,2,3)
 S X=X_RA4
 Q
APPEND S ^(RA3)=^TMP($J,"RA0",RA3)_U_X Q
HOURAGE W !,"Hours (age of report)",?29,$J(RACUT(1),$L(RACUT(3))),?39,$J(RACUT(2),$L(RACUT(3))),?49,$J(RACUT(3),$L(RACUT(3))),?59,">",$J(RACUT(3),$L(RACUT(3))+1)
 W !?29,$E(RADASH,1,$L(RACUT(3))),?39,$E(RADASH,1,$L(RACUT(3))),?49,$E(RADASH,1,$L(RACUT(3))),?59,$E(RADASH,1,$L(RACUT(3))+2)
 Q
