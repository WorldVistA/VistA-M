LRAPV ;AVAMC/REG/WTY - ANAT PATH REPORTS NOT VERIFIED ;1/17/02
 ;;5.2;LAB SERVICE;**72,201,259,317**;Sep 27, 1994
 ;
 ;Reference to ^DIC supported by IA #916
 ;
A ;Initialize some variables
 N LRI,LRFILE,LRFILE1,LRFILE2,LRPD,LRA
 D ^LRAP G:'$D(Y) END
 S LR("AU1")=$S(LRSS="AU":1,1:0)
 S:'LR("AU1") LRFILE="^LR(LRPD,LRSS,LRI",LRFILE1=LRFILE_",1.2,"
 S:LR("AU1") LRFILE="^LR(LRPD,LRSS",LRFILE1="^LR(LRPD,84,"
ASK ;Ask which option to run
 W !!?3,"1) List of Unverified ",LRO(68)," Reports"
 W !?3,"2) List of Unverified ",LRO(68)," Supplementary Reports"
 W !?3,"3) List of ",LRO(68)," Reports Missing SNOMED Codes"
 W !!,"Select 1,2 or 3: "
 R X:DTIME
 I X=""!(X[U) D END Q
 I X'?1N!("123"'[X) D  G ASK
 .W $C(7),!!,"Enter a single numeric digit 1,2 or 3"
 ;Give date ranges
 S LRB=X D B^LRU
 I Y<0 D END Q
DEV ;Get Device Info
 W !
 S %ZIS="Q" D ^%ZIS
 I POP W ! D END Q
 I $D(IO("Q")) D  Q
 .S ZTDESC="LIST OF ACC UNVERIF,MISSING SNOMED OR CPT"
 .S ZTSAVE("LR*")="",ZTRTN="QUE^LRAPV"
 .D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued, #",ZTSK W !
 .K ZTSK,IO("Q") D HOME^%ZIS
 .D END
QUE ;
 U IO W:IOST["C-" @IOF
 S LRSDT=LRSDT-.01,LRLDT=LRLDT+.99
 D XR^LRU,L^LRU,S^LRU,H S LR("F")=1
 F  S LRSDT=$O(^LR(LRXR,LRSDT)) Q:'LRSDT!(LRSDT>LRLDT)!(LR("Q"))  D Y
 D END
 Q
Y ;Get patient info
 S LRPD=0 F  S LRPD=$O(^LR(LRXR,LRSDT,LRPD)) Q:'LRPD!(LR("Q"))  D
 .S X=^LR(LRPD,0),Y=$P(X,"^",3),(LRDPF,X)=$P(X,"^",2)
 .S X=^DIC(X,0,"GL"),X=@(X_Y_",0)"),LRP=$P(X,"^"),SSN=$P(X,"^",9)
 .D SSN^LRU
 .I 'LR("AU1") D I Q
 .I LR("AU1") D SEL
 Q
I ;Order through the cross reference
 S LRI=0 F  S LRI=$O(^LR(LRXR,LRSDT,LRPD,LRI)) Q:'LRI!(LR("Q"))  D
 .D:$Y>(IOSL-6) H Q:LR("Q")
 .I $P($P($G(@(LRFILE_$S('LR("AU1"):",0)",1:")"))),"^",6)," ")'=LRABV Q
 .D SEL
 Q
SEL ;
 D:LRB=1 RPT
 D:LRB=2 SUPP
 D:LRB=3 SNO
 Q
N ;
 Q
RPT ;Unverified reports
 S X=$G(@(LRFILE_$S('LR("AU1"):",0)",1:")")))
 I $L(X),'$P(X,"^",$S('LR("AU1"):11,1:15)) D
 .S LRDATE=@(LRFILE_$S('LR("AU1"):",0)",1:")"))
 .D W
 Q
SUPP ;Unverified Supplementary Reports
 ;If RELEASE SUPPLEMENTARY REPORT is null, or if RELEASE SUPP
 ;  REPORT MODIFIED is set to 1, then supp report is unverified
 S (LRA,LRC)=0 F  S LRA=$O(@(LRFILE1_"LRA)")) Q:'LRA!(LRC)  D
 .I '$P(@(LRFILE1_"LRA,0)"),"^",2) S LRC=1
 .;Flag if released supp has been modified but not yet released
 .I 'LRC,$P(@(LRFILE1_"LRA,0)"),"^",3) S LRC=1
 I LRC D
 .S LRDATE=@(LRFILE_$S('LR("AU1"):",0)",1:")"))
 .D W
 Q
SNO ;Missing SNOMED
 S LRC=0
 S:'LR("AU1") LRFILE2=LRFILE_",2"
 S:LR("AU1") LRFILE2="^LR(LRPD,""AY"""
 I '$D(@(LRFILE2_")")) S LRC=1
 I 'LRC,'+$P($G(@(LRFILE2_",0)")),"^",4) S LRC=1
 I LRC D
 .S LRDATE=@(LRFILE_$S('LR("AU1"):",0)",1:")"))
 .D W
 Q
W ;Write the report
 W !,$$FMTE^XLFDT(LRDATE,"D"),?19,$J($P(LRDATE,"^",6),5),?32,LRP
 W ?63,SSN
 I 'LR("AU1") D
 .S LRA=0 F  S LRA=$O(^LR(LRPD,LRSS,LRI,97,LRA)) Q:'LRA!(LR("Q"))  D
 ..S B=^LR(LRPD,LRSS,LRI,97,LRA,0)
 ..D:$Y>(IOSL-6) H1 Q:LR("Q")  W !?3,B
 Q
H ;Header
 I LRQ>0,IOST?1"C-".E D  Q:LR("Q")
 .K DIR S DIR(0)="E"
 .D ^DIR W !
 .S:$D(DTOUT)!(X[U) LR("Q")=1
 W:LRQ>0 @IOF S LRQ=LRQ+1
 S X="N",%DT="T" D ^%DT,D^LRU
 W !,Y,?22,LRQ(1),?(IOM-10),"Pg: ",LRQ
 W !,LRO(68)," (",LRABV,") "
 I LRB<3 W "UNVERIFIED" W:LRB=2 " SUPPLEMENTARY" W " REPORTS"
 W:LRB=3 "REPORTS MISSING SNOMED CODING"
 W !,"BY DATE SPECIMEN TAKEN FROM ",LRSTR," TO ",LRLST
 W !,"DATE",?15,"Accession number",?32,"Patient",?66,"SSN",!,LR("%")
 Q
H1 ;
 D H Q:LR("Q")  W !?19,$J($P(LRDATE,"^",6),5),?32,LRP,?63,SSN
 Q
END ;
 W:IOST?1"P-".E @IOF D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K %,DIR,DTOUT,DUOUT,DIRUT,X,Y
 D V^LRU
 Q
