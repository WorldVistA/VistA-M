DGPTTS1 ;ALB/AS/ADL - FACILITY TREATING SPECIALTY AND 501 MOVEMENTS, cont. ; 11/28/89 @12
 ;;5.3;Registration;**26,64,418,510,478**;Aug 13, 1993
 ;;ADL;Update for CSV Project;;Mar 28, 2003
 ;
 ;build DGA array w/patient's last treat spec of the day as of 11:59 pm
 ;
LOOP ;
 S DGNEXT=$O(^DGPM("ATS",DFN,DGPMCA,DGPREV))
 F DGNEXT=DGNEXT:0 Q:($P(DGPREV,".")'=$P(DGNEXT,"."))!('DGNEXT)  S DGNEXT=$O(^DGPM("ATS",DFN,DGPMCA,DGNEXT))
 S X=$O(^DGPM("ATS",DFN,DGPMCA,DGPREV,0)),DGA(9999999.999999-$E(DGPREV,1,14))=$S($D(^DIC(45.7,+X,0)):$P(^(0),"^",2),1:0)_"^"_$O(^DGPM("ATS",DFN,DGPMCA,DGPREV,X,0)) I DGNEXT>0 S DGPREV=DGNEXT G LOOP
 S DGPREV=0,X=$S($D(^DIC(42,+$P(DGPMAN,"^",6),0)):$P(^(0),"^",3),1:0) I "^NH^D^"[(U_X_U)!($P(^(0),"^",17)=1) D ASIH^DGPTTS2 ;p-418
 ;
LOOP1 ; -- compare specs between mvts ; sort out xfr if spec did't change
 S DGSAVE=DGPREV
 S DGPREV=$O(DGA(DGPREV)),DGNEXT=$O(DGA(DGPREV)),X=+DGA(DGPREV) I DGNEXT S Y=+DGA(DGNEXT) I (X=Y)!((X=70)&(Y=71))!((X=71)&(Y=70)) K DGA(DGNEXT) S DGPREV=DGSAVE I $O(DGA(DGPREV))>0 G LOOP1
 ;
 ; -- is mvt during adm
 I DGPREV<+DGPMAN!($P(DGPREV,".")'<$S(DGDT:$P(+DGDT,"."),1:9999999)) S (DG1,DG2)=+$P(DGA(DGPREV),"^",2) D DEL:$S('$D(^DGPM(DG1,"PTF")):0,1:$P(^("PTF"),"^",2)]"") G LOOPQ
 ;
 ; build ^UTILITY for mvts whose spec changed
 ;I X=70!(X=71) S X2=DGPREV,X1=$S(DGNEXT]"":DGNEXT,DGDT]"":DGDT,1:DT) D ^%DTC S $P(DGA(DGPREV),"^",1)=$S(X>45:71,1:70)
 S X=$S($D(^DGPM($P(DGA(DGPREV),"^",2),"PTF")):^("PTF"),1:""),^UTILITY($J,"T",DGPREV)=$P(DGA(DGPREV),"^",2)_"^"_+DGA(DGPREV)_"^"_$P(X,"^",2)_"^"_$P(X,"^",3)_"^"_$S($D(^DGPM($P(DGA(DGPREV),"^",2),0)):$P(^(0),"^",8),1:"")
LOOPQ I $O(DGA(DGPREV)) G LOOP1
 ;
 ; look for mvts in ^DGPM that have a PTF mvt # entry
 ; but not in ^UTILITY.  If any are found, delete from ^DGPT.
 F DGPREV=0:0 S DGPREV=$O(^DGPM("ATS",DFN,DGPMCA,DGPREV)) Q:DGPREV'>0  S X=$O(^DGPM("ATS",DFN,DGPMCA,DGPREV,0)),(DG1,DG2)=$O(^DGPM("ATS",DFN,DGPMCA,DGPREV,+X,0)) I $D(^DGPM(+DG1,"PTF")),$P(^("PTF"),"^",2)]"" D DEL
 ;
 K Y S Y=+$O(^DGPM("APHY",DGPMCA,0)) I $D(^DGPM(Y,0)) S Y(0)=^(0),Y("PTF")=$S($D(^("PTF")):^("PTF"),1:"")
 I $D(Y)>10 S T("ADM")=Y_"^"_$S($D(^DIC(45.7,+$P(Y(0),"^",9),0)):$P(^(0),"^",2),1:"")_"^^"_$P(Y("PTF"),"^",3)_"^"_$P(Y(0),"^",8) K Y
 ;
 S DGDEL=$O(^UTILITY($J,"T",0))
 I DGDEL S T(DGDEL)=^(DGDEL),DG1=$P(T(DGDEL),"^",3) I DG1 S T(DGDEL)=$P(T(DGDEL),U,1,2),DGREC=$S($D(^DGPT(PTF,"M",DG1,0)):^(0),1:"") D MSG K DA S DIK="^DGPT("_PTF_",""M"",",DA(1)=PTF,DA=DG1 D ^DIK K DA S ^UTILITY($J,"T",DGDEL)=$P(T(DGDEL),U,1,2)
 K DGA K:$D(T(+DGDT)) T(DGDT)
 S DGAD=+DGPMAN F I=0:0 S I=$O(^UTILITY($J,"T",I)) Q:I'>0  S DGAD=I
 S DGREC1=$S($D(^DGPT(PTF,"M",1,0)):^(0),1:"")
 S DGREC=$S($D(^UTILITY($J,"T",DGAD)):^(DGAD),$D(T("ADM")):T("ADM"),1:"")
 I DGREC,$D(^DGPM(+DGREC,0)) D
 .N DGFDA,DGMSG
 .S DGFDA(405,(+DGREC)_",",53)=1
 .D FILE^DIE("","DGFDA","DGMSG")
 S DGREC=$P(DGREC,U,2)
 I DGDT W:'DGREC&'$D(ZTQUEUED) !,"No Treating Specialty Transfers",! S I1=1,DIE="^DGPT(",DA=PTF,DR="71///"_DGREC D ^DIE:DGREC S PR=DGAD,NX=DGDT D LOL^DGPTTS2 I $P(DGREC1,U,3,4)'=(LOL_U_LOP) S DR="3///"_LOL_";4///"_LOP,I1=1 D TD5^DGPTTS2 K DR
 I 'DGDT S PR=DGAD,NX=DT,I1=1 D LOL^DGPTTS2 I $P(DGREC1,U,2,4)'=(DGREC_U_LOL_U_LOP) S DR="3///"_LOL_";4///"_LOP_$S(DGREC:";2///"_DGREC,1:"") D TD5^DGPTTS2
 K DGSAVE,DR,DGREC1 D ^DGPTTS2 Q
DEL Q:$D(^UTILITY($J,"T",(9999999.999999-$E(DGPREV,1,14))))
 S DG1=$P(^DGPM(DG1,"PTF"),"^",2),DGREC=$S($D(^DGPT(PTF,"M",+DG1,0)):^(0),1:"") Q:DGREC']""  D MSG K DA S DIK="^DGPT("_PTF_",""M"",",DA(1)=PTF,DA=DG1 D ^DIK K DA
 S DA=DG2,DR="52///@;53///@",DIE="^DGPM(" D ^DIE Q
MSG S DGMSG="" F X=5:1:15 I X'=10 S DGPTTMP=$$ICDDX^ICDCODE(+$P(DGREC,U,X),$$GETDATE^ICDGTDRG(PTF)),DGMSG=DGMSG_$S(+DGPTTMP>0:$P(DGPTTMP,U,2)_", ",1:"")
 Q:DGMSG']""  S ^UTILITY($J,"DEL",DG1)=DGMSG
 ;-- save expanded codes 
 S DGMSG1=""
 I $D(^DGPT(PTF,"M",+DG1,300)) S DGEX=^(300) F X=2:1:7 S:$P(DGEX,U,X)]"" $P(DGMSG1,U,X)=$P(DGEX,U,X)
 S:DGMSG1]"" ^UTILITY($J,300,DG1)=DGMSG1
 K DGMSG1
 S Y=$P(DGREC,U,10) X ^DD("DD") S DGMSG="501 movement of "_$P(^DPT(DFN,0),U,1)_" of "_Y_" losing specialty "_$P(^DIC(42.4,$P(DGREC,U,2),0),U,1)_" was deleted by "_$P(^VA(200,DUZ,0),U,1)_" it contained diag "_$E(DGMSG,1,120)
 S:'$D(DGPMAN) DGPMAN=^DGPM(DGPMCA,0) D MSG^DGPTMSG1
 K DGEX Q
