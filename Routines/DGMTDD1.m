DGMTDD1 ;ALB/MIR,JAN,AEG,ERC,BAJ - DD calls from income screening files ; 12/8/06 3:35pm
 ;;5.3;Registration;**180,313,345,401,653,688**;Aug 13, 1993;Build 29
 ;
 ; This routine contains miscellaneous input transform and other DD
 ; calls from income screening files.
 ;
 ;
SSN ; called from the input transform of the SSN field in file 408.13
 N %,L,DGN,DGPAT,PATNAME,PREVX,KANS
 ;with DG*5.3*653 Pseudo SSNs will be allowed for spouse/dependents
 I X'?9N&(X'?3N1"-"2N1"-"4N)&(X'?9N1"P")&(X'?3N1"-"2N1"-"4N1"P"),(X'?1"P")&(X'?1"p") W !,"Response must be either nine numbers, be in the format nnn-nn-nnnn",!,"or include a ""P"" for a Pseudo SSN." K X Q
 I X="P"!(X="p") D PSEU S X=L K L G SSNQ
 I X["P" D PSEU I X'=L K X,L W !!,$C(7),"Invalid Pseudo SSN, type ""P"" for valid one." Q
 I X["P" G SSNQ
 I X'?.AN F %=1:1:$L(X) I $E(X,%)?1P S X=$E(X,0,%-1)_$E(X,%+1,999),%=%-1
 I X'?9N K X Q
 I $D(X) S L=$E(X,1) I L=9 W !,*7,"The SSN must not begin with 9." K X Q
 I $D(X),$E(X,1,3)="000" W !,*7,"First three digits cannot be zeros." K X Q
 ;
 ; warning if the spouse's/dependent's SSN is found in the PATIENT file
 ; and spouse/dependent is not a veteran.  spouse/dependent is a veteran
 ; if name, sex, DOB match.
 ;
 ; input (OPTIONAL)
 ;    ANS(.01) = NAME,  ANS(.02) = SEX,  ANS(.03) = DOB
 ;
 ; if newly entered values (those not yet committed to dbase) not 
 ; supplied then pull current detail from the Person Income file
 ; (#408.13) for this dependent.
 I '$G(ANS(.01)),'$G(ANS(.02)),'$G(ANS(.03)) D
 . N REC,FLD
 . D GETS^DIQ(408.13,DA,".01;.02;.03","I","REC")
 . F FLD=".01",".02",".03" S ANS(FLD)=REC(408.13,DA_",",FLD,"I")
 . S KANS=1
 E  S KANS=0
 ;
 S DGN=$O(^DPT("SSN",X,0)) G:'DGN SSDEP S DGPAT=$G(^DPT(DGN,0))
 I $P(DGPAT,"^",3)=ANS(.03),($P(DGPAT,"^",2)=ANS(.02)),($P(DGPAT,"^")=ANS(.01)) G SSDEP
 S PATNAME=$P(DGPAT,"^") D WARN Q
 ;
SSDEP ; warning if spouse's/dependent's SSN is found in file 408.13 and
 ; name, sex, DOB don't match
 S DGN=$O(^DGPR(408.13,"SSN",X,0)) G:'DGN SSNQ S DGPAT=$G(^DGPR(408.13,DGN,0))
 I $P(DGPAT,"^",3)=ANS(.03),($P(DGPAT,"^",2)=ANS(.02)),($P(DGPAT,"^")=ANS(.01)) G SSNQ
 S PATNAME=$P($G(^DGPR(408.13,DGN,0)),"^") D WARN Q
 ;
SSNQ K:KANS ANS Q
 ;
 ;
PSEU ;create a Pseudo SSN using same algorithm as file 2 in PSEU^DGRPDD1
 S KANS=""
 I $G(ANS(.01))']""!($G(ANS(.03))'?7N) D
 . S DGNODE0=^DGPR(408.13,DA,0)
 . S ANS(.01)=$P(DGNODE0,U),ANS(.03)=$P(DGNODE0,U,3)
 I $D(ANS(.01)) S NAM=ANS(.01)
 I $D(ANS(.03)) S DOB=ANS(.03)
 I $G(DOB)="" S DOB=2000000
 S L1=$E($P(NAM," ",2)),L3=$E(NAM),NAM=$P(NAM,",",2),L2=$E(NAM)
 S Z=L1 D CON S L1=Z
 S Z=L2 D CON S L2=Z
 S Z=L3 D CON S L3=Z
 S L=L2_L1_L3_$E(DOB,4,7)_$E(DOB,2,3)_"P"
 Q
CON ;
 S Z=$A(Z)-65\3+1 S:Z<0 Z=0
 Q
 ;
WARN ; printed WARNING message to alert user that spouse/dependent SSN be
 ; that of a veteran in Patient/Income Person File.
 W !,*7,"Warning - ",X," belongs to patient ",PATNAME
 K DIR S PREVX=X,DIR(0)="YA",DIR("A")="Are you sure this is the correct SSN? ",DIR("B")="YES" D ^DIR
 I Y=1 S X=PREVX K PREVX,DIR("B") Q
 E  K DIR("B"),X Q
 ;
REL ; called from the input transform of the RELATIONSHIP field of file 408.12...sets DIC("S")
 N DGNODE,DGX,SEX
 S DGNODE=$G(^DGPR(408.12,DA,0)),DGX=$P(DGNODE,"^",2) Q:'DGNODE
 I DGX,(DGX<3) S DIC("S")="I Y="_DGX Q
 S DGX=$P(DGNODE,"^",3),SEX=$P($G(@("^"_$P(DGX,";",2)_+DGX_",0)")),"^",2)
 S DIC("S")="I Y>2,(""E"_SEX_"""[$P(^(0),""^"",3))"
 I $P(DGNODE,U,2)>6 I $$CNTDEPS^DGMTU11(+DGNODE)>18 S DIC("S")=DIC("S")_",(Y>6)"
 I $D(DGTYPE),DGTYPE="C" S DIC("S")=DIC("S")_",(Y<7)"
 Q
