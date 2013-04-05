PSIV ;BIR/PR,MLM-MISC UTILITIES ;19 Mar 99 / 9:45 AM
 ;;5.0;INPATIENT MEDICATIONS;**7,16,29,38,53,56,72,58,110,181,267**;16 DEC 97;Build 158
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191
 ; Reference to ^PSSLOCK is supported by DBIA 2789
 ; Reference to ^%DTC is supported by DBIA 10000
 ; Reference to ^DIC is supported by DBIA 10006
 ; Reference to ^DIE is supported by DBIA 10018
 ; Reference to ^DIR is supported by DBIA 10026
 ; Reference to ^VALM is supported by DBIA 10118
 ; Reference to ^VALM1 is supported by DBIA 10116
 ; Reference to ^PS(51.1 is supported by DBIA 2177
 ;
ENGETP ;Enter here to select patient.
 K DIC S DIC("W")="W ""  "",$P(^(0),""^"",9) W:$D(^(.1)) ""  "",^(.1)",DIC="^DPT(",DIC(0)="QEM"
 D FULL^VALM1
GETP1 ;
 ;NEW arrays use in order checks
 NEW PSJEXCPT,PSJOCER
 S PSGPTMP=0,PPAGE=1,DFN=-1,X="Select PATIENT:^^^^1" D ENQ Q:"^"[X
 D EN^PSJDPT
 I Y<0 G ENGETP
 N PSGP,PSJACNWP S (PSGP,DFN)=+Y D ENBOTH^PSJAC S PSJORL=$$ENORL^PSJUTL($G(VAIN(4)))
 Q
 ;
ENYN ;Enter here for yes/no responses. This is a general reader that I have
 ;been phasing out with ^DICN
 S X=X_"^Y:YES;N:NO^YES,NO"
 ;
ENQ ;Enter here to read X. This is the general reader that I have
 ;been slowly phasing out
 S QUD=$P(X,"^",2) W !!,$P(X,"^")," " W:QUD]"" QUD,"// " R QUX:DTIME W:'$T $C(7) S:'$T QUX="^" S:QUX="" QUX=QUD I QUX["^"!(QUX["?") G KILL
 I $L(QUX)>500 W "    ??" G ENQ
 S:QUX?1L QUX=$C($A(QUX)-32)
 S QUD=";"_$P(X,"^",3)_";" G:QUD'[(";"_QUX_":") VAR S QUX1=$E(QUD,$F(QUD,QUX_":"),($F(QUD,";",$F(QUD,QUX_":"))-2)) G:QUX1[":" VAR W "    ",QUX1 G KILL
VAR F QUX1=1:1 S QUD=$P($P(X,"^",4),",",QUX1) Q:QUD=""  I $P(QUD,QUX)="" W $S($P(X,"^",2)=QUX:"    "_QUX,1:"")_$P(QUD,QUX,2,99) S QUX=QUD G KILL
PAT I $P(X,"^",5)]"",@$P(X,"^",5,999) G KILL
 W $C(7)," ???" G ENQ
KILL S X=QUX K QUX,QUX1,QUD,PSJDCEXP Q
 ;
ENADM ;Edit administration schedules.
 S DIC="^PS(51.1,",DIC(0)="QEAML",DLAYGO=51.1 D ^DIC K:+Y<0 %,DA,D0,DIC,DIE,DLAYGO,DR,Z,Y Q:'$D(Y)  S DIE=DIC,DR=".01;1",DA=+Y K DIC D ^DIE G ENADM
 ;
ENOW D NOW^%DTC S Y=% K %,%H,%I
 Q
 ;
ENC ;Get unit of measure for drug selected.
 S X=$P($P(";"_$P(Y,U,3),";"_X_":",2),";")
 Q
 ;
ENCHS ;Needs PSIVBR (Branch point)
 D ENGETP G:DFN<0 Q
 ;* Lock patient if calling FROM PSJI DELETE ORDER.
 I PSIVBR="D ENT^PSIVPGE",('$$L^PSSLOCK(DFN,1)) Q
OE N CONT S CONT=0
 F  Q:CONT  D ENCHS1
 Q:$D(ORVP)
 G ENCHS
ENCHS1 ;
 I '($$AA^PSJDPT(DFN)>0) S CONT=1 Q
 S PSJORQF=0,CONT=0
 S PSJPROT=2,PSJOL="",(PSGOP,PSGP)=DFN
 K PSJLMPRO D EN^VALM("PSJ LM BRIEF PATIENT INFO")
 S VALMCNT=30
 I PSIVBR="D PROCESS^PSIVRD",(PSJOL="N") D ORDNO^PSIVRD Q
 I $G(PSJNEWOE) S PSJOL="S"
 I PSJOL="S"!(PSJOL="L") F  Q:CONT  S P("PT")=PSJOL D
 . S PSJORQF=0,PSJNEWOE=0
 . D ENNB^PSIVACT
 . I '$D(^TMP("PSIV",$J)) D FULL^VALM1 W !!,?30,"NO ORDERS FOUND",! K DIR S DIR(0)="E" D ^DIR W @IOF S CONT=0
 . NEW PSJIVPRF S PSJIVPRF=1
 . S PSJOL=$S(",S,L,"[(","_$G(PSJOL)_","):PSJOL,1:"S")
 . D EN^VALM("PSJ LM IV OE")
 . I $G(VALMBCK)="Q" Q
 . S CONT=1
 ;* Unlock patient if come from PSJI DELETE ORDER
 I '$G(PSJORQF) S CONT=1
 I PSIVBR="D ENT^PSIVPGE" D UL^PSSLOCK(DFN)
 K PSJLMPRO
 Q
SELSO ;SELECT ORDER USING "SO" OPTION
 S PSGLMT=^TMP("PSJPRO",$J,0) D ENASR^PSGON,OV
 Q
SELNUM ;SELECT ORDERS WITH NUMBERS
 S PSGLMT=^TMP("PSJPRO",$J,0),X=$P(XQORNOD(0),"=",2) D ENCHK^PSGON,OV
 Q
OV ;
 I '$D(PSGODDD) S VALMBCK="R" Q
 N DONE
 F PSIVOV1=1:1:PSGODDD F PSIVOV2=1:1:$L(PSGODDD(PSIVOV1),",")-1 D
 .S ON=+$P(PSGODDD(PSIVOV1),",",PSIVOV2)
 .S ON=$$GTON(ON)
 .Q:'ON!$G(DONE)
 .D OV1
 S VALMBCK="Q"
 Q
GTON(X) ;
 ;Return the ON node from ^Tmp
 I $G(X)="" Q ""
 I $D(^TMP("PSIV",$J,"AB",X)) Q ^(X)
 I $D(^TMP("PSIV",$J,"NB",X)) Q ^(X)
 I $D(^TMP("PSIV",$J,"PB",X)) Q ^(X)
 I $D(^TMP("PSIV",$J,"XB",X)) Q ^(X)
 I $D(^TMP("PSIV",$J,"NDB",X)) Q ^(X)
 I $D(^TMP("PSIV",$J,"PDB",X)) Q ^(X)
 I $D(^TMP("PSIV",$J,"RDB",X)) Q ^(X)
 Q ""
OV1 ;
 S (ON,ON55,P("PON"))=9999999999-ON_$S(ON["V":"V",1:"P")
 I PSIVBR["D ^PSIVVW1" D
 . S VALMSG="Select either ""AL"" , ""LL"" or ""AL,LL"" for both"
 . S PSJORD=ON D EN^PSJLIPRF
 E  D
 . I PSIVBR="D ^PSIVOPT",'($$LS^PSSLOCK(PSGP,ON)) Q
 . X PSIVBR
 . D:PSIVBR="D ^PSIVOPT" UNL^PSSLOCK(PSGP,ON)
 K:'$D(DUOUT)&($G(Y)'=-1) DONE
 Q
 ;
 ;
ENU ;Get IV additive strength. Called from templates.
 N Y S Y=+^PS(55,DA(2),"IV",DA(1),"AD",DA,0),PSIVSTR=$$ENU^PSIVUTL(Y)
 Q
Q ;
 K ^TMP($J,"PSJPRE")
 K ^TMP("PSIV",$J),^TMP("PSJ",$J),^TMP("PSJPRO",$J),^TMP("PSJALL",$J),^TMP("PSJI",$J),^TMP("PSJON",$J)
 K DRG,DRGI,DRGN,DRGT,ERR,I,JJ,MI,N,N2,ON,ON55,P,P1,P3,P16,P17,PNOW,PS,PSGODD,PSGODDD,PSIV,PSIVAAT,PSIVACT,PSIVADM,PSIVAT
 K PSIVC,PSIVDT,PSIVFLAG,PSIVLN,PSIVNOW,PSIVNU,PSIVON,PSIVOV1,PSIVOV2,PSIVREA,PSIVSTR,PSIVSTRT,PSIVNOL,PSIVTYPE,PSJNKF
 K PSJORF,PSJORIFN,RDWARD,START,STOP,SCHED,USER,V,XT
 K %,%I,DIC,PSIVC,PSIVNU,PSIVON,PSIVREA,PSIVOV1,PSIVOV2,RDWARD,V,VAERR,VW,X,X2,Y,Y1,Z,Z1,Z2
 Q
