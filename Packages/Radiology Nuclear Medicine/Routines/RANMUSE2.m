RANMUSE2 ;HISC/SWM-Nuclear Medicine Usage reports ;9/3/97  14:37
 ;;5.0;Radiology/Nuclear Medicine;**65**;Mar 16, 1998;Build 8
 ;
 ;Supported IA #10061 reference to DEM^VADPT
 ;
SET ; There are 2 parts:  set local arrays and ^tmp()
 ;
 ; part 1 -- raseqd(),raseqi(),ranumd(),ranumi() so to reduce
 ;   div and img-typ names to a single number, and so to reduce
 ;   the length of the ^tmp() string
 ; raseqd("division name")=sequence number for alpha sort order
 ; raseqi("imaging type name")=sequence number for alpha sort order
 ; ranumd(sequence number for alpha sort order)="division name"
 ; ranumi(sequence number for alpha sort order)="imaging type name"
 ;
 S RA1=0 F  S RA1=$O(^RA(79,RA1)) Q:'RA1  S RA2=$P($G(^(RA1,0)),U) S:RA2 RASEQD($P($G(^DIC(4,+RA2,0)),U))=""
 S RA1="",RA2=1 F  S RA1=$O(RASEQD(RA1)) Q:RA1=""  S RASEQD(RA1)=RA2,RANUMD(RA2)=RA1,RA2=RA2+1
 ;
 S RA1=0 F  S RA1=$O(^RA(79.2,RA1)) Q:'RA1  S RA2=$P($G(^(RA1,0)),U) S:RA2]"" RASEQI(RA2)=""
 S RA1="",RA2=1 F  S RA1=$O(RASEQI(RA1)) Q:RA1=""  S RASEQI(RA1)=RA2,RANUMI(RA2)=RA1,RA2=RA2+1
 ;
 ; part 2 -- ^TMP($J,"RA",div,imgtyp,S3,S4,patnam,caseno)
 ;   S3 = sort field 3, either radiopharm/whoadmin    or      examdttm
 ;   S4 = sort field 4, either examdttm     or    radiopharm/whoadmin
 ;
 ; Loop thru ^RADPTN("AB" to select recs within requested date range
 ;
 S RA0=RADTBEG-.0001
S1 S RA0=$O(^RADPTN("AB",RA0)) Q:RA0=""  Q:RA0>RADTEND  S RA1=0
S2 S RA1=$O(^RADPTN("AB",RA0,RA1)) G:RA1="" S1
 S RAN0=$G(^RADPTN(RA1,0)) G:RAN0="" S2
 S RADFN=$P(RAN0,U) G:RADFN="" S2
 S RADTI=9999999.9999-$P(RAN0,U,2) G:RADTI="" S2
 S RACNI=$O(^RADPT(RADFN,"DT",RADTI,"P","B",$P(RAN0,U,3),0)) G:RACNI="" S2
 D EXTRACT
 G S2
EXTRACT ;
 S P02=$G(^RADPT(RADFN,"DT",RADTI,0)) Q:P02=""
 S P03=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)) Q:P03=""
 S RADIVNAM=$P($G(^DIC(4,+$P(P02,U,3),0)),U)
 Q:'$D(^TMP($J,"RA D-TYPE",RADIVNAM))  ; div not selected
 S RAIMGNAM=$P($G(^RA(79.2,+$P(P02,U,2),0)),U)
 Q:'$D(^TMP($J,"RA I-TYPE",RAIMGNAM))  ; img typ not selected
 S RA2=0
F1 S RA2=$O(^RADPTN(RA1,"NUC",RA2)) Q:RA2'=+RA2
 S RANUC=^RADPTN(RA1,"NUC",RA2,0)
 S RACN=$P(RAN0,U,3)
 S RADIOPH=$$EN1^RAPSAPI(+$P(RANUC,U),.01) ; Radiopharm Name
 I 'RAINPUT,RATITLE["Usage",'$D(^TMP($J,"RA EITHER",RADIOPH)) G F1 ;radioph not selectd
 S RAWHO=$P($G(^VA(200,+$P(RANUC,U,9),0)),U) ; who administered dose
 I RATITLE["Admin",RAWHO="" G F1 ;who admin dose is unknown
 I 'RAINPUT,RATITLE["Admin",'$D(^TMP($J,"RA EITHER",RAWHO)) G F1 ;who not selectd
 S RAXMDTM=$P(RAN0,U,2) ; exam date/time
 S RAPRC0=$G(^RAMIS(71,+$P(P03,U,2),0)) ; procedure 0-node
 S RAPRCNAM=$P(RAPRC0,U) ; procedure name
 S DFN=RADFN D DEM^VADPT
 S RAPATNAM=$P(VADM(1),U) ; patient name
 S RASSN=$P(VADM(2),U,2) ; ssn
 K VADM
 S RADOSE=$P(RANUC,U,7) ; dose administered
 S RADRAWN=$P(RANUC,U,4) ; activity drawn
 I 'RADOSE,'RADRAWN G F1 ; dose admin and drawn both null/zero
 ; ien of procedure sub-record with matching radiopharm
 ; if user changes default radiopharm entry, or
 ;    adds a radiopharm that's not defined in file 71 default radiopharm,
 ;    the high and low values would be unknown
 S RANUC1=$O(^RAMIS(71,+$P(P03,U,2),"NUC","B",+$P(RANUC,U),0))
 ; 0-node of procedure sub-record with matching radiopharm
 S:RANUC1 RANUC1=^RAMIS(71,+$P(P03,U,2),"NUC",+RANUC1,0)
 S RAHIGH=$P(RANUC1,U,5) ; high adult dose
 S RALOW=$P(RANUC1,U,6) ; low adult dose
 S RASTERSK=""
 I RADOSE>0,RALOW>0,RADOSE<RALOW S RASTERSK="*"
 I RADOSE>0,RAHIGH>0,RADOSE>RAHIGH S RASTERSK="*"
 D S3S4
 S ^TMP($J,"RA",RASEQD(RADIVNAM),RASEQI(RAIMGNAM),S3,S4,$E(RAPATNAM,1,15),RACN,RADIOPH)=RASSN_U_RADRAWN_U_RADOSE_U_RAHIGH_U_RALOW_U_RAWHO_U_RASTERSK_U_RAPRCNAM
 I '$D(^TMP($J,"RASUM",$S(RASORT:S3,1:S4),RACN,RASSN)) S ^(RASEQI(RAIMGNAM))=$G(^TMP($J,"RATUNIQ",RASEQD(RADIVNAM),RASEQI(RAIMGNAM)))+1,^(RASEQD(RADIVNAM))=$G(^TMP($J,"RATUNIQ",RASEQD(RADIVNAM)))+1
 S RAEITHER=$S(RATITLE["Usage":RADIOPH,1:RAWHO)
 I '$D(^TMP($J,"RASUM",$S(RASORT:S3,1:S4),RACN,RASSN,RAEITHER)) S ^(RAEITHER)=$G(^TMP($J,"RATUNIQ",RASEQD(RADIVNAM),RASEQI(RAIMGNAM),RAEITHER))+1,^(RAEITHER)=$G(^TMP($J,"RATUNIQ",RASEQD(RADIVNAM),RAEITHER))+1
 S ^(RASSN)=$G(^TMP($J,"RASUM",$S(RASORT:S3,1:S4),RACN,RASSN))+1
 S ^(RAEITHER)=$G(^TMP($J,"RASUM",$S(RASORT:S3,1:S4),RACN,RASSN,RAEITHER))+1
 ; img typ totals
 S:RASTERSK="*" ^(RAEITHER)=$G(^TMP($J,"RATOUTSD",RASEQD(RADIVNAM),RASEQI(RAIMGNAM),RAEITHER))+1
 S ^(RAEITHER)=$G(^TMP($J,"RATDRAWN",RASEQD(RADIVNAM),RASEQI(RAIMGNAM),RAEITHER))+RADRAWN
 S ^(RAEITHER)=$G(^TMP($J,"RATDOSE",RASEQD(RADIVNAM),RASEQI(RAIMGNAM),RAEITHER))+RADOSE
 ; "ratradio" is used for either radiopharm or who-admin-dose
 S ^(RAEITHER)=$G(^TMP($J,"RATRADIO",RASEQD(RADIVNAM),RASEQI(RAIMGNAM),RAEITHER))+1
 ; division totals
 S:RASTERSK="*" ^(RAEITHER)=$G(^TMP($J,"RATOUTSD",RASEQD(RADIVNAM),RAEITHER))+1
 S ^(RAEITHER)=$G(^TMP($J,"RATDRAWN",RASEQD(RADIVNAM),RAEITHER))+RADRAWN
 S ^(RAEITHER)=$G(^TMP($J,"RATDOSE",RASEQD(RADIVNAM),RAEITHER))+RADOSE
 S ^(RAEITHER)=$G(^TMP($J,"RATRADIO",RASEQD(RADIVNAM),RAEITHER))+1
 G F1
WRT S RASEQD=""
W1 S RASEQD=$O(^TMP($J,"RA",RASEQD)) Q:RASEQD=""  S RASEQI=""
W2 S RASEQI=$O(^TMP($J,"RA",RASEQD,RASEQI)) G:RASEQI="" W1 S S3=""
 S:RAPG>0 RAXIT=$$EOS^RAUTL5 Q:$G(RAXIT)  D PGHD^RANMUSE3,COLHD^RANMUSE3
W3 S S3=$O(^TMP($J,"RA",RASEQD,RASEQI,S3)) G:S3="" W2 S S4=""
W4 S S4=$O(^TMP($J,"RA",RASEQD,RASEQI,S3,S4)) G:S4="" W3 S RAPATNAM=""
W5 S RAPATNAM=$O(^TMP($J,"RA",RASEQD,RASEQI,S3,S4,RAPATNAM)) G:RAPATNAM="" W4 S RACN=""
W6 S RACN=$O(^TMP($J,"RA",RASEQD,RASEQI,S3,S4,RAPATNAM,RACN)) G:RACN="" W5 S RADIOPH=""
W7 S RADIOPH=$O(^TMP($J,"RA",RASEQD,RASEQI,S3,S4,RAPATNAM,RACN,RADIOPH)) G:RADIOPH="" W6 S RA1=^(RADIOPH)
 S RALONGCN=$S(RASORT:S3,1:S4),RALONGCN=$E(RALONGCN,4,7)_$E(RALONGCN,2,3)_"-"_RACN_"@"_$E($P(RALONGCN,".",2)_"000",1,4)
 S RASSN=$P(RA1,U),RADRAWN=$P(RA1,U,2),RADOSE=$P(RA1,U,3),RAHIGH=$P(RA1,U,4),RALOW=$P(RA1,U,5),RAWHO=$P(RA1,U,6),RASTERSK=$P(RA1,U,7)
 S RAPRCNAM=$P(RA1,U,8)
 I ($Y+4)>IOSL!(RAPG=0) S RAXIT=$$EOS^RAUTL5 Q:RAXIT  D PGHD^RANMUSE3,COLHD^RANMUSE3
 W !,RALONGCN,?16,$E(RAPATNAM,1,15),?32,RASSN,?44,$E(RADIOPH,1,15),?59,$J(RADRAWN,10,4),?69,$J(RADOSE,10,4),?79,$J(RALOW,10,4),?89,$J(RAHIGH,10,4),?100,$E(RAPRCNAM,1,15),?116,$E(RAWHO,1,15),?131,RASTERSK
 G W7
S3S4 ; set subscripts 3 and 4
 I RATITLE["Usage" D  Q
 . I RASORT S S4=$E(RADIOPH,1,15),S3=RAXMDTM
 . I 'RASORT S S3=$E(RADIOPH,1,15),S4=RAXMDTM
 . Q
 I RATITLE["Admin" D  Q
 . I RASORT S S4=$E(RAWHO,1,15),S3=RAXMDTM
 . I 'RASORT S S3=$E(RAWHO,1,15),S4=RAXMDTM
 . Q
 Q
