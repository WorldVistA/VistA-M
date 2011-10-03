RAUTL11 ;HISC/CAH,FPT,GJC,SS-Utility File Maintenance ;4/21/97  11:59
 ;;5.0;Radiology/Nuclear Medicine;**18,35,34**;Mar 16, 1998
 ;
 ;Last modification : by SS, SEP 30,2000 for P18 
HEAD ; Header
 I $E(IOST,1,2)="C-"!(RAPG>0) W:$Y>0 @IOF
 S RAPG=RAPG+1
 W !?62,"Page: ",RAPG,!?62,"Date: ",RADATE
 W !!?(IOM-$L(RAHDR)\2),RAHDR,!,RALINE,!
 Q
ORDELSH ;Called by the 'List Exams with Inactive/Invalid Statuses' option.
 ;Exams with statuses whose 'Order' field is blank are printed
 N RADATE,RAHDR,RALINE,RAOUT,RAPG,Y
 S RAHDR="Exams with Inactive/Invalid Statuses"
 S (RAPG,RAOUT)=0,$P(RALINE,"=",(IOM+1))="",Y=DT
 X ^DD("DD") S RADATE=Y
 K %ZIS S %ZIS="MQ" W ! D ^%ZIS I POP D Q2 Q
 I $D(IO("Q")) D  W ! Q
 . S ZTDESC="Rad/Nuc Med List Exams with Inactive/Invalid Statuses",ZTSAVE("RA*")=""
 . S ZTRTN="2^RAUTL11" D ^%ZTLOAD
 . W !?5,$S($D(ZTSK):"Request Queued!",1:"Request Cancelled!")
 . Q
 D 2
 Q
2 ;
 N A,B,C,D,E,F,FT,G,H,HD,I,J,K,L,LN,RACASE,RAEXDT,RAPAT,RAPROC,RARPT
 N RASSN,X,Y,Y1,Y2 D HEAD
 S (A,F)=0,FT="No evidence of inactive/invalid exams was detected."
 S HD(1)="Exam Status: ",HD(2)="Imaging Type: "
 S $P(LN(1),"*",($L(HD(1))-1))="",$P(LN(2),"*",($L(HD(2))-1))=""
 F  S A=$O(^RA(72,A)) Q:A'>0  D  Q:RAOUT
 . S B=$G(^RA(72,A,0)) Q:B']""
 . S C=$P(B,U),D=$P(B,U,3),E=$P($G(^RA(79.2,+$P(B,U,7),0)),U)
 . I D']"",($D(^RADPT("AS",A))) D
 .. I $Y'<(IOSL-4) S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD
 .. W !,HD(1),C
 .. W ?45,HD(2),$E($S(E]"":E,1:"Unknown"),1,20),!,LN(1),?45,LN(2),!
 .. S F=1,G=0
 .. F  S G=$O(^RADPT("AS",A,G)) Q:G'>0  S H=0 D  Q:RAOUT
 ... S J=$G(^RADPT(G,0))
 ... F  S H=$O(^RADPT("AS",A,G,H)) Q:H'>0  S I=0 D  Q:RAOUT
 .... S K=$G(^RADPT(G,"DT",H,0))
 .... F  S I=$O(^RADPT("AS",A,G,H,I)) Q:I'>0  D  Q:RAOUT
 ..... S L=$G(^RADPT(G,"DT",H,"P",I,0))
 ..... S RAPAT=$P($G(^DPT(+$P(J,U),0)),U)
 ..... S RASSN=$P($G(^DPT(+$P(J,U),0)),U,9),RARPT=+$P(L,U,17)
 ..... I RARPT D
 ...... S Y1=$P($G(^RARPT(RARPT,0)),U,5)
 ...... S Y2=$P($G(^DD(74,5,0)),U,2)
 ...... S RARPT("STAT")=$$XTERNAL^RAUTL5(Y1,Y2)
 ...... Q
 ..... S Y=$P(K,U) X ^DD("DD") S RAEXDT=Y
 ..... S RACASE=$P(L,U),RAPROC=$P($G(^RAMIS(71,+$P(L,U,2),0)),U)
 ..... I $Y'<(IOSL-4) D  Q:RAOUT
 ...... S RAOUT=$$EOS^RAUTL5() Q:RAOUT  D HEAD
 ...... W !,HD(1),C,?45,HD(2),$E($S(E]"":E,1:"Unknown"),1,20)
 ...... W !,LN(1),?45,LN(2),!
 ...... Q
 ..... W !,"Patient: ",$S(RAPAT]"":RAPAT,1:"Unknown")
 ..... W ?45,"SSN: ",$E(RASSN,1,3)_"-"_$E(RASSN,4,5)_"-"_$E(RASSN,6,9)
 ..... W !,"Exam Date: ",$S(RAEXDT]"":RAEXDT,1:"Unknown")
 ..... W ?45,"Case #: ",$S(RACASE]"":RACASE,1:" --- ")
 ..... I RARPT D
 ...... W !,"Reported: Yes",?45,"Report Status: "
 ...... W $S(RARPT("STAT")]"":$E(RARPT("STAT"),1,19),1:"Unknown")
 ...... Q
 ..... W !,"Procedure: ",$S(RAPROC]"":RAPROC,1:"Unknown"),!
 ..... Q
 .... Q
 ... Q
 .. Q
 . Q
 I 'F W !?(IOM-$L(FT)\2),FT
 S:$D(ZTQUEUED) ZTREQ="@" D ^%ZISC
Q2 K DUOUT,I,POP
 Q
 ;
 ;called from RAO7PC1,saves TECH COMMENT in ^TMP($J,"RAE2",
SVTCOM(RA11DFN,RA11DTI,RA11CNI) ;P18 used for API call
 N RA11
 S RA11(0)=$G(^RADPT(RA11DFN,"DT",RA11DTI,"P",RA11CNI,0))
 Q:RA11(0)']""
 S RA11(1)=$G(^RAMIS(71,+$P(RA11(0),"^",2),0))
 S RA11(2)=$S($P(RA11(1),"^")]"":$P(RA11(1),"^"),1:"Unknown")
 S RA11(3)=$$GETTCOM(RA11DFN,RA11DTI,RA11CNI)
 S:RA11(3)'="" ^TMP($J,"RAE2",RA11DFN,RA11CNI,RA11(2),"TCOM",1)=RA11(3)
 Q
 ;
GETTCOM(RA11DFN,RA11DTI,RA11CNI) ;P18 returns most recent tech comment
 N RA11X,RA11XI
 S RA11X="",RA11XI=99999
 F  S RA11XI=$O(^RADPT(RA11DFN,"DT",RA11DTI,"P",RA11CNI,"L",RA11XI),-1) Q:+RA11XI=0  I RA11XI>0 S RA11X=$G(^RADPT(RA11DFN,"DT",RA11DTI,"P",RA11CNI,"L",RA11XI,"TCOM"),"") Q:RA11X'=""
 Q RA11X
 ;
 ;Outputs most recent tech comments.Arguments:
 ;RADFN,RADTI,RACNI,header(can be ""),left margin,right margin,
 ;number of lines in the bottom before checking bottom of screen,
 ;is NL before and after header,number of lines to output,
 ;put header even if no text 
PUTTCOM(RA18DFN,RA18DTI,RA18CNI,RA18HDR,RA18LFTM,RA18RGHM,RA18BOT,RANLHD,RAHDNL,RALINES,RAWRHDR) ;P18 outputs techcomm
 N RA18X,RA18XI
 S RA18X="",RA18X=$$GETTCOM(RA18DFN,RA18DTI,RA18CNI) I RA18X="" D  Q 0
 . I RAWRHDR=1 W:RANLHD ! W RA18HDR W:RAHDNL !
 . Q
 W:RANLHD ! W RA18HDR W:RAHDNL !
 Q:$$TXTOUT(RA18X,RA18LFTM,RA18RGHM,RA18BOT,RA18HDR,RALINES,RANLHD,RAHDNL,0)=-1 -1
 Q 1
 ;
CONTIN(RABTM) ;P18 screen check
 Q:$D(RARTVERF) 0 ;on-line verify or resident preverify--ENTIRE report
 I ($Y+RABTM)'>IOSL Q 0
 Q:$$EOS^RAUTL5()>0 -1
 W:$E(IOST,1,2)="C-" @IOF
 Q 1
 ;
 ;Prints text.Arguments:
 ;Text,Left margin,Right margin
 ;Number of lines in the bottom before screen check.if <0 don't check
 ;Header text displayed ONLY for next page;Max lines to output, Should place NL before header,
 ;Should place NL after header
 ;Should place header for continuation after screen check
TXTOUT(RA11TXT,RA11LM,RA11RM,RABT,RAHD,RALIN,RANLHD,RAHDNL,RA18ISHD) ;P18 outputs text
 Q:(RA11LM'<RA11RM) 0
 N DIWF,DIWL,DIWR,RAX,X,RALN,RA18EX,RA18A,RA18B,RA18C,RACHKBOT S (RA18EX,RAX)=0,RA18A="",RA18C=0
 S RACHKBOT=$S(RABT<0:0,1:1)
 S DIWF="|",DIWL=RA11LM,DIWR=RA11RM K ^UTILITY($J,"W")
 S X=RA11TXT
 D ^DIWP
 S RAX=0 F RALN=1:1 S RAX=$O(^UTILITY($J,"W",DIWL,RAX)) Q:RAX'>0!(RA18EX'=0)!(RA18C=-1)  D
 . S RA18B=+$O(^UTILITY($J,"W",DIWL,RAX)) ;is it last?
 . S X=$G(^UTILITY($J,"W",DIWL,RAX,0))
 . I RALN'<RALIN S RA18EX=1 D  Q
 .. S $P(RA18A," ",RA11RM-RA11LM-$L(X))="",X=X_RA18A
 .. S:+RA18B'=0 X=$E(X,1,RA11RM-RA11LM)_"(more...)" W ?DIWL,X
 .. Q
 . W ?DIWL,X
 . W:+RA18B>0 !
 . I RACHKBOT=1 S RA18C=$$CONTIN(RABT) Q:RA18C=-1
 . I RA18ISHD I RA18C=1 I RA18B W:RANLHD ! W RAHD W:RAHDNL !
 . Q
 Q $S(RA18C=-1:-1,1:0)
 ;
PUTTCOM2(RA18DFN,RA18DTI,RA18CN,RA18HDR,RA18LFTM,RA18RGHM,RA18BOT,RA18HDNL) ;P18 outputs techcomm using caseNo see PUTTCOM
 N RA18A S RA18A=$$FNDIN70M^RAO7XX(RA18DFN,RA18DTI,RA18CN,"T")
 Q:RA18A=0 0
 Q:$$PUTTCOM(RA18DFN,RA18DTI,$P(RA18A,"^",2),RA18HDR,RA18LFTM,RA18RGHM,RA18BOT,1,RA18HDNL,2,0)=-1 -1
 Q 0
 ;
VERONLY() ;outputs header with case info for Verify only menu option
 N RA18EX,RA18I S RA18EX=0 ;P18 for quit if uparrow inside PUTTCOM
 I '($D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0))#2) D  Q
 . W !!?2,"Case #: ",RACN," for ",RANME S RAXIT=1
 . W !?2,"Procedure: '",$E(RAPRC,1,45),"' has been deleted"
 . W !?2,"by another user!",$C(7)
 . Q
 W !
 S RA18EX=$$PUTTCOM2^RAUTL11(RADFN,RADTI,RACN,"Tech. Comment for case No. "_RACN_":",1,70,-1,1)
 Q:RA18EX=-1
 N RAPRTSET,RAMEMARR,RA1P18
 D EN2^RAUTL20(.RAMEMARR)
 I RAPRTSET D
 . S RA1P18=""
 . F  S RA1P18=$O(RAMEMARR(RA1P18)) Q:RA1P18=""!(RA18EX=-1)  I RA1P18'=RACNI D
 .. S RA18EX=$$PUTTCOM2^RAUTL11(RADFN,RADTI,+RAMEMARR(RA1P18),"Tech. Comment for case No. "_+RAMEMARR(RA1P18)_":",1,70,-1,1) Q:RA18EX=-1  ;
 .. Q
 . Q
 Q RA18EX
 ;------------
 ;Outputs tech comment using
 ;RADFN,RADTI,RACNI,activity log ien,header(can be ""),left margin,
 ;right margin,number of lines in the bottom 
 ;before checking bottom of screen,is NL after header,
 ;number of lines to output,header even if no comments 
PUTTCOM3(RA18DFN,RA18DTI,RA18CNI,RA18LOG,RA18HDR,RA18LFTM,RA18RGHM,RA18BOT,RANLHD,RAHDNL,RALINES,RAWRHDR) ;P18 outputs techcomm
 N RA18X,RA18XI,I
 S RA18X="",RA18X=$G(^RADPT(RA18DFN,"DT",RA18DTI,"P",RA18CNI,"L",RA18LOG,"TCOM"),"") I RA18X="" D  Q 0
 . I RAWRHDR=1 W:RANLHD ! W RA18HDR W:RAHDNL !
 . Q
 W:RANLHD ! W RA18HDR W:RAHDNL !
 Q:$$TXTOUT(RA18X,RA18LFTM,RA18RGHM,RA18BOT,RA18HDR,RALINES,RANLHD,RAHDNL,0)=-1 -1
 Q 1
