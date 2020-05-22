DGRPC ;ALB/MRL/PJR/PHH/EG/BAJ,TDM,LBD - CHECK CONSISTENCY OF PATIENT DATA ;6/29/11 3:50pm
 ;;5.3;Registration;**108,121,314,301,470,489,505,451,568,585,641,653,688,754,797,867,903,952**;Aug 13, 1993;Build 160
 ;Per VHA Directive 6402, this routine should not be modified.
 ;
 ; 315 added to OVER99 local variable by patch DG*5.3*903 which was submitted to OSEHRA
 ; on 04/02/2015 by HP. This update was authored by James Harris 2014-2015 
 ;
 ;line tags in routines correspond to IEN of file 38.6
 ;
 ;variables:  DGVT = 1 if VETERAN? = YES, 0 if NO
 ;    DGSC = 1 if SC? = YES, 0 if NO
 ;    DGCD = 0 node of file EC file (#8)
 ;        DGRPCOLD = old inconsistencies for pt (separated by ,s)
 ;   DGCHK = #s to check (separated by ,s)
 ;   DGLST = next # to check
 ;    DGER = inconsistencies found (separated by ,s)
 ;   DGNCK = 1 if missing key elig data...can't process further
 ;
 N ANYMSE,CONARR,CONCHK,CONERR,CONSPEC,LOC,I5,I6,DGPMSE
 N MSECHK,MSESET,MSERR,MSDATERR,RANGE,RANSET,OVER99
 D ON I $S(('$D(DFN)#2):1,'$D(^DPT(DFN,0)):1,DGER:1,1:0) G KVAR^DGRPCE:DGER
EN       S:'$D(DGEDCN)#2 DGEDCN=0 I DGEDCN W !!,"Checking data for consistency..."
 D START:DGEDCN
 F I=0,.13,.141,.121,.122,.22,.24,.3,.31,.311,.32,.321,.322,.33,.35,.36,.362,.38,.39,.52,.53,"TYPE","VET" S DGP(I)=$G(^DPT(DFN,I))
 ;Get MSEs from MSE sub-file #2.3216 (DG*5.3*797)
 I '$D(^DPT(DFN,.3216)) D MOVMSE^DGMSEUTL(DFN)
 D GETMSE^DGMSEUTL(DFN,.DGPMSE)
 ;get old inconsistencies
 S DGRPCOLD="," I $D(^DGIN(38.5,DFN)) F I=0:0 S I=$O(^DGIN(38.5,DFN,"I",I)) Q:'I  S DGRPCOLD=DGRPCOLD_I_","
 ;find consistencies to check/not check
 ; DG*5.3*653 modified to exclude checks numbered>99  BAJ  10/25/2005
 S DGCHK="," F I=0:0 S I=$O(^DGIN(38.6,I)) Q:'I!(I=99)  I $D(^(I,0)),$S(I=2:0,I=51:0,I=9:1,I=10:1,I=13:1,I=14:1,I=22:1,I=52:1,I=53:1,I=89:1,'$P(^(0),"^",5):1,1:0),I'=99 S DGCHK=DGCHK_I_","
 ; On following line patch DG*5.3*903 added 315 as a new consistency
 S OVER99=",301,303,304,306,307,308,313,314,315,402,403,406,407,501,502,503,504,505,506,507,516,517,"
 S DGVT=$S(DGP("VET")="Y":1,1:0),DGSC=$S($P(DGP(.3),"^",1)="Y":1,1:0),DGCD=$S($D(^DIC(8,+DGP(.36),0)):^(0),1:""),(DGCT,DGER,DGNCK)="" I 'DGVT,$D(^DG(391,+DGP("TYPE"),0)),$P(^(0),"^",2) S DGVT=2
 S DGLST=+$P(DGCHK,",",2) G @DGLST
1        S DGD=$P(DGP(0),"^",1) I DGD?1L.E!(DGD?.E1L.E)!(DGD="") S X=1 D COMB,NEXT I +DGLST'=2 G @DGLST
 S I1=0 F I=1:1:$L(DGD) Q:I1  S J=$E(DGD,I) I J?1NP,$A(J)>32,J'=",",J'="-",J'=".",J'="'" S I1=1
 I I1 S X=1 D COMB
 D NEXT I +DGLST'=2 G @DGLST
2        S I1=0 F I=0:0 S I=$O(^DPT(DFN,.01,I)) Q:'I!(I1)  I $P(^(I,0),"^",1)'?1A.E S I1=1
 I I1 S X=2 D COMB
 D NEXT I +DGLST>7!('DGLST) G @DGLST
3        ;
4        ;
5        ;
6        ;
7        F I=2,3,5,8,9 I $P(DGP(0),"^",I)="" S X=$S(I=2:3,I=3:4,I=5:5,I=8:6,1:7) D COMB:DGCHK[(","_X_",")
 S DGLST=7 G:DGCHK'[",7," FIND^DGRPC2 D NEXT I +DGLST'=8 G @DGLST
8        S I1=0,DGD=$G(^DPT(DFN,.11)) I '$P(DGD,"^",10) S I1=1,X=8 D COMB,NEXT G @DGLST
 I '$D(^HL(779.004,$P(DGD,"^",10))) S I1=1,X=8 D COMB,NEXT G @DGLST
 N STR8 S STR8="1,4,5,6,7" I $$FORIEN^DGADDUTL($P(DGD,"^",10)) S STR8="1,4"
 F T=1:1:$L(STR8,",") S I=$P(STR8,",",T) Q:I1  I $P(DGD,"^",I)="" S I1=1
 I I1 S X=8 D COMB
 D NEXT I +DGLST'=9 G @DGLST
9        I DGP("VET")="" S X=9,DGNCK=1 D COMB
 D NEXT I +DGLST'=10 G @DGLST
10       I $P(DGP(.3),"^",1)="" S X=10,DGNCK=1 D COMB
 D NEXT I +DGLST'=11 G @DGLST
11       I 'DGVT,DGSC S X=11 D COMB
 D NEXT I +DGLST'=12 G @DGLST
12       I DGSC,DGVT,$P(DGP(.3),"^",2)="" S X=12 D COMB
 D NEXT I +DGLST'=13 G @DGLST
13       I '$D(^DIC(21,+$P(DGP(.32),"^",3),0)) S X=13,DGNCK=1 D COMB
 D NEXT I +DGLST'=14 G @DGLST
14       I $P(DGCD,"^",1)="" S X=14,DGNCK=1 D COMB
 ;
 ;Check Patient Eligibilities multiple if Primary Elig Code defined
 I DGP(.36),'$D(^DPT(DFN,"E",+DGP(.36),0)) D PRI^VADPT60 ;5.3*301
 ;
 D NEXT I +DGLST'=15 G FIND^DGRPC2:+DGLST=35,@DGLST
15       I $P($G(^DPT(DFN,.15)),"^",2)]"",$P(DGP(.3),"^",7)="" S X=15 D COMB
 D NEXT I +DGLST'=16 G FIND^DGRPC2:+DGLST=35,@DGLST
16       D H^DGUTL I +DGP(.35)>DGTIME S X=16 D COMB
 D NEXT I +DGLST'=17 G FIND^DGRPC2:+DGLST=35,@DGLST
17       K DGDATE,DGTIME
 N SDARRAY,SDCLIEN,SDDATE
 S I1=0,DGD=DT
 S SDARRAY("FLDS")=3
 S SDARRAY(4)=DFN
 I +DGP(.35),$$SDAPI^SDAMA301(.SDARRAY) D
 .;if there is data hanging from the 101 subscript,
 .;then this is a valid appointment
 .;otherwise it is an error eg 01/21/2005
 .I $D(^TMP($J,"SDAMA301",101))=1 Q
 .S SDCLIEN=0
 .F  S SDCLIEN=$O(^TMP($J,"SDAMA301",DFN,SDCLIEN)) Q:'SDCLIEN!(I1)  D
 ..S SDDATE=0
 ..F  S SDDATE=$O(^TMP($J,"SDAMA301",DFN,SDCLIEN,SDDATE)) Q:'SDDATE!(I1)  D
 ...S X=$P($P(^TMP($J,"SDAMA301",DFN,SDCLIEN,SDDATE),"^",3),";")
 ...I X=""!(X="I") S I1=1
 K ^TMP($J,"SDAMA301")
 I I1 S X=17 D COMB
 ;
END      ; end of routine...find next check to execute (or goto end)
 S:DGNCK DGLST=35 G:DGCHK'[",35,"&(DGNCK) FIND^DGRPC2 D NEXT G @DGLST
 ;
COMB     ;record inconsistency
 S DGCT=DGCT+1,DGER=DGER_X_",",DGLST=X Q
 Q
 ;
NEXT     ; find the next consistency check to check (goto end if can't process further)
 S I=$F(DGCHK,(","_DGLST_",")),DGLST=+$E(DGCHK,I,999) I +DGLST,DGLST<18 Q
 I +DGLST,DGNCK,+DGLST>17,+DGLST<36 S DGLST=35 Q:DGCHK'[",35,"  G NEXT
 S:'+DGLST DGLST="END^DGRPC3" I +DGLST S DGLST=DGLST_"^DGRPC"_$S(+DGLST<43:1,+DGLST<79:2,1:3)
 Q
 ;
PAT      ;check inconsistencies for a selected patient
 D ON G KVAR^DGRPCE:DGER W !! S DIC="^DPT(",DIC(0)="AEQMZ",DIC("A")="Check consistency for which PATIENT: " D ^DIC K DIC G KVAR^DGRPCE:Y'>0 S DFN=+Y,DGEDCN=1 D DGRPC G PAT
 ;
START    ;record start time for checker
 S DGSTART=$H Q
 ;
TIME     ;record end time for checker
 Q:'$D(DGSTART)#2  S DGEND=$H,X=$P(DGSTART,",",2),X1=$P(DGEND,",",2)
 I +DGSTART=+DGEND S DGTIME=X1-X
 E  S DGTIME=(5184000-X)+X1
 I $S(DGCT:0,DGCON=1:1,1:0) G TIMEQ
 W !!,"===> ",$S(DGCT:DGCT,DGCON<2:"No",1:"All")," inconsistenc",$S(DGCT=1:"y",1:"ies")," ",$S('DGCON:"found",DGCON=1:"filed",1:"removed")," in ",DGTIME," second",$S(DGTIME=1:"",1:"s"),"..." H 1
TIMEQ    K DGSTART,DGEND,DGTIME,X,X1,DGCON Q
 ;
ON       ;check if checker is on
 S DGER=0 I $S('$D(^DG(43,1,0)):1,'$P(^(0),"^",37):1,1:0) S DGER=1
 S:'$D(DGEDCN) DGEDCN=0 W:DGER !!,"CONSISTENCY CHECKER TURNED OFF!!",$C(7) Q
