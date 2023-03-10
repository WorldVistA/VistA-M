DGPTFM5 ;ALB/MTK/ADL/PLT - PTF ENTRY/EDIT-3 ;11 MAR 91  15:15
 ;;5.3;Registration;**510,606,850,884,1057**;Aug 13, 1993;Build 17
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;;ADL;Update for CSV Project;;Mar 26, 2003
 ;
 S DGZS0=DGZS0+1
EN D MOB:'$D(S) S S(DGZS0,1)=$S($D(S(DGZS0,1)):S(DGZS0,1),1:"") G NEXM:S(DGZS0,1)="" S (S1,S(DGZS0))=$S($D(^DGPT(PTF,"S",S(DGZS0,1),0)):^DGPT(PTF,"S",S(DGZS0,1),0),1:"")
WR ;
 N EFFDATE,IMPDATE
 D EFFDATE^DGPTIC10(PTF)
 W @IOF,HEAD,?72 S Z="<401-"_DGZS0_">" D Z^DGPTFM
 W !,?30,"Initial Date Of Service: ",$$EXTERNAL^DILFD(45,14,,$G(DGIDTS))  ; DG*5.3*1057
 S L=+S(DGZS0),Y=L D D^DGPTUTL W !! S Z=1 D Z W "Date of Surg: " S Z=Y,Z1=28 D Z1 W "Chief Surg: ",$$EXTERNAL^DILFD(45.01,4,,$P(S1,U,4))
 W !,"    Anesth Tech: ",$$EXTERNAL^DILFD(45.01,6,,$P(S1,U,6)),?45,"First Asst: ",$$EXTERNAL^DILFD(45.01,5,,$P(S1,U,5))
 W !,"  Source of pay: ",$$EXTERNAL^DILFD(45.01,7,,$P(S1,U,7))
 W ?46,"Surg spec: ",$E($S($D(^DIC(45.3,+$P(S1,U,3),0)):$P(^(0),U,2),1:""),1,23)
 W !! S Z=2 D Z W "  Surg/pro: ",$$GETLABEL^DGPTIC10(EFFDATE,"P") ;,!?7
 ;F I=1:1:5 S L=$P(S1,U,I+7) I L'="" D
 D PTFICD^DGPTFUT(401,PTF,S(DGZS0,1),.DGX401)
 S I=0 F  S I=$O(DGX401(I)) QUIT:'I  S L=+DGX401(I) D
 . S DGPTTMP=$$ICDDATA^ICDXCODE("PROC",+L,EFFDATE)
 . D WRITECOD^DGPTIC10("PROC",+L,EFFDATE,2,1,7) W $S(+DGPTTMP<1!('$P(DGPTTMP,U,10)):"*",1:"")
 . I $Y>(IOSL-4) D PGBR W @IOF,HEAD,?72 N Z S Z="<401-"_DGZS0_">" D Z^DGPTFM W !
 . QUIT
 K DGX401
 ;-- kidney transplant source
 S DG300=$S($D(^DGPT(PTF,"S",S(DGZS0,1),300)):^(300),1:"") D:DG300]"" PRN3^DGPTFM8 K DG300
 W !!
JUMP F I=$Y:1:19 W !
X S DGNUM=$S($D(S(DGZS0+1)):401_"-"_(DGZS0+1),1:"MAS") G 401^DGPTFJC:DGST
 W "Enter <RET> to continue, 1-2 to edit,",!,"'S' to add a Surgical segment, '^N' for screen N, or '^' to abort:<",DGNUM,">// " R X:DTIME K DGNUM G Q:X="^",NEXM:X="",^DGPTFJ:X?1"^".E,ADD:X="S"!(X="s")
X1 I X'=1,X'=2,X'="1-2" G PR
X2 S DGCODSYS=$$CODESYS^DGPTIC10(PTF),DR=$S(DGCODSYS="ICD10":"[DG401-10P]",1:"[DG401]"),DGJUMP=X,DGSUR=+S(DGZS0,1)
 N ICDVDT,ICPTVDT,EFFDATE,IMPDATE
 D EFFDATE^DGPTIC10(PTF)
 ;S (ICDVDT,ICPTVDT)=$S($D(PTF):$$GETDATE^ICDGTDRG(PTF),1:DT)
 S (ICDVDT,ICPTVDT)=$S($G(EFFDATE)'="":EFFDATE,$D(PTF):$$GETDATE^ICDGTDRG(PTF),1:DT)
 K DA S DIE="^DGPT(",(DGPTF,DA)=PTF D ^DIE K DA,DR,DA
 D CHK401^DGPTSCAN K DGPTF,DGSUR D MOB G EN
PR W !,"Enter '^' to stop the display and edit of data",!,"'^N' to jump to screen #N (appears in upper right of screen '<N>'",!,"<RET> to continue on to the next screen or 1-2 to edit:"
 W !?10,"1-Surgical information",!?10,"2-Surgical/Procedure Codes"
 W !,"You may also enter any combination of the above, separated by commas(ex:1,3,5)",!
 R !!,"Enter <RET>: ",X:DTIME G WR
 Q
NEXM S DGZS0=DGZS0+1 G ^DGPTFM:'$D(S(DGZS0)) G EN
 ;
ADD ;add 401 surgery record
 K SUR S DGZS0=0 S:'$D(^DGPT(PTF,"S",0)) ^(0)="^45.01DA^^"
 S DIC="^DGPT("_PTF_",""S"",",DIC(0)="QEALM",DA(1)=PTF D ^DIC G ^DGPTFM:+Y'>0!('$D(^DGPT(PTF,"S",+Y)))
 D MOB I SU F I=1:1:SU S:S(I,1)=+Y DGZS0=I
 G ^DGPTFM:'DGZS0 S SUR(DGZS0)=+Y,X="1,2" G X2
MOB K S,S1,S2 S I=0,S2=0 F I1=1:1 S I=$O(^DGPT(PTF,"S",I)) Q:'I  S S(I1)=^(I,0),S(I1,1)=I I S(I1)']"" K S(I1) S I1=I1-1
 S SU=I1-1 Q
Q G Q^DGPTF
 Q
1 ;;.01;2;3;4;5;6;7
2 ;;8;9;10;11;12
 Q
Z I 'DGN S Z=$S(IOST="C-QUME"&($L(DGVI)'=2):Z,1:"["_Z_"]") W @DGVI,Z,@DGVO
 E  W "   "
 Q
Z1 F I=1:1:(Z1-$L(Z)) S Z=Z_" "
 W Z
 Q
 ;
PGBR N DIR,X,Y S DIR(0)="E",DIR("A")="Enter RETURN to continue" D ^DIR QUIT
 ;
