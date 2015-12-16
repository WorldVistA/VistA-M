DGPTTS2 ;ALB/JDS/PLT - FACILITY TREATING SPECIALTY AND 501 MOVEMENTS, cont. ;6/3/15 11:13am
 ;;5.3;Registration;**549,478,884**;Aug 13, 1993;Build 31
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 S NX=$O(^UTILITY($J,"T",0)),DGDR=0 Q:NX'>0  S T(NX)=^(NX),I2=$P(T(NX),U,4),B(501)=U
 F I=0:0 S I=$O(^DGPT(PTF,"M",I)) Q:I'>0  D
 .N FLD,DGFDA,DGMSG
 .F FLD=20:1:25 S DGFDA(45.02,I_","_PTF_",",FLD)="@"
 .D FILE^DIE("","DGFDA","DGMSG")
LOOP1 K:$D(PR) T(PR) S PR=NX,NX=$O(^UTILITY($J,"T",NX)) G Q:NX'>0 S T(NX)=^(NX),T(PR)=^(PR)
 S I1=+$P(T(NX),U,3),I2=$S($O(^(NX)):$P(^(NX),U,3),1:0),DGDOC=$P(T(NX),U,5) F I=PR,NX S DG1(I)=$P(T(I),U,2)
 D ADT1:I1'>0,ONE:$P(T(PR),U,4)'=I1,LOL
 S A=$S($D(^DGPT(PTF,"M",I1,0)):^(0),1:"") I $P(A,U,1,4)'=(I1_U_DG1(PR)_U_LOL_U_LOP)!($P(A,U,10)'=NX) S DR=$S('A:".01///"_I1_";",1:"")_"2////"_DG1(PR)_";3///"_LOL_";4///"_LOP_";10////"_NX D TD5
 I $P(T(PR),U,4)'=I1 S DR="53///"_I1,DA=+T(PR),DIE="^DGPM(" D ^DIE
 G LOOP1
 ;
ADT1 F  L +^DGPT(PTF,"M",0):1 I $T QUIT
 S:'$D(^DGPT(PTF,"M",0)) ^DGPT(PTF,"M",0)="^45.02AI^1^1"
 F I=0:0 S I=$O(^DGPT(PTF,"M",I)) Q:I'>0  S I1=I
 S I1=I1+1,J=^DGPT(PTF,"M",0),^(0)=$P(J,U,1,2)_U_I1_U_($P(J,U,4)+1) L -^DGPT(PTF,"M",0)
 N DGFDA,DGMSG
 S DGFDA(45.02,I1_","_PTF_",",.01)=I1
 D FILE^DIE("","DGFDA","DGMSG")
 S T(NX)=$P(T(NX)_"^^",U,1,2)_U_I1
 S DA=+T(NX),DR="52///"_I1,DIE="^DGPM(" D ^DIE
 QUIT
 ;
ONE ;delete in one ien/save in another ien for 25 icd codes and node 300
 N DR,DGDR,DGA,DGB,DGC
 S I2=$P(T(PR),U,4) QUIT:'I2
 S DGA="DR",DGB="DGDR",DGC=0
 S J=$S($D(^DGPT(PTF,"M",I2,0)):^(0),1:0) G O1:'J S (DR,DGDR)="" F I=4:1:15 I I'=10 S:$P(J,U,I) @DGA=$G(@DGA)_I_"///@;",@DGB=$G(@DGB)_I_"////"_$P(J,U,I)_";"
 S J=$G(^DGPT(PTF,"M",I2,81)) I J]"" F I=1:1:15 I $P(J,U,I) S @DGA=$G(@DGA)_(I/100+81)_"///@;",@DGB=$G(@DGB)_(I/100+81)_"////"_$P(J,U,I)_";" S:$L(@DGB)>220 DGC=DGC+1,DGA="DR(1,45.02,DGC)",DGB="DGDR(1,45.02,DGC)"
 S J=$G(^DGPT(PTF,"M",I2,82)) I J]"" F I=1:1:25 I $P(J,U,I)]"" S @DGA=$G(@DGA)_(I/100+82)_"///@;",@DGB=$G(@DGB)_(I/100+82)_"////"_$P(J,U,I)_";" S:$L(@DGB)>220 DGC=DGC+1,DGA="DR(1,45.02,DGC)",DGB="DGDR(1,45.02,DGC)"
 S J=$S($D(^DGPT(PTF,"M",I2,300)):^(300),1:"") I J]"" F I=2:1:7 I $P(J,U,I)]"" S @DGA=$G(@DGA)_"300.0"_I_"///@;",@DGB=$G(@DGB)_"300.0"_I_"////"_$P(J,U,I)_";" S:$L(@DGB)>220 DGC=DGC+1,DGA="DR(1,45.02,DGC)",DGB="DGDR(1,45.02,DGC)"
 S I1=I2 D TD5:DR]"" K DR S I1=$P(T(NX),U,3) M DR=DGDR D TD5:DR]""
 QUIT
 ;
TD5 S DA=I1,DIE="^DGPT("_PTF_",""M"",",DA(1)=PTF,DP=45.02 D ^DIE QUIT
 ;
LOL S DG1=$S(DGDT:DGDT,1:DT),(LOL,LOP)=0
 F I=DGADM:0 S I=$O(^DGPM("APTT2",DFN,I)) Q:I'>0!(I>DG1)  S J=$O(^DGPM("APTT2",DFN,I,0)) I $S('$D(^DGPM(J,0)):0,$P(^(0),"^",14)=DGPMCA:1,1:0) S C=+$P(^(0),"^",18) I C=1!(C=2)!(C=3) D LOL1
 QUIT
 ;
LOL1 S X2=$S(I<PR:PR,1:I),Y=$O(^DGPM("APTT2",DFN,I)),X1=$S(Y>PR&(Y'>NX):+Y,Y>NX!(Y<0):NX,1:X2) I X1>X2 D ^%DTC S Z=$S(C=1:"LOP",1:"LOL"),@Z=@Z+X K C,X,Y,X1,X2
 QUIT
 ;
ASIH S DGBDT=DGADM,DGEDT=$S(DGDT:DGDT,1:DT) D ASIH^DGUTL2
 S DIE="^DGPT(",DA=PTF,DR="77////"_DGREC D ^DIE
 K DE,DQ,DR,DA,DIE,DGBDT,DGEDT,DGMVTP QUIT
 ;
O1 ;filing saved movement 25 codes with poa and 300-node data
 Q:'$D(^UTILITY($J,"DEL",I2))
 N DR,DGA,DGB,A,B,J,J82
 S DR="",DGA=0,DGB="DR"
 S A=^UTILITY($J,"DEL",I2),B=0,J82=$G(^(I2,82))
 F I=1:1 S J=$P(A,", ",I) S:J=""&'B&$D(^UTILITY($J,"DEL",I2,81)) A=^(81),B=1,J=$P(A,", ",I),I=1,J=$P(A,", ",I) QUIT:J=""  S DGA=DGA+1 D
 . S @DGB=$G(@DGB)_$S(DGA<11:DGA>5+DGA+4,1:DGA-10/100+81)_"///"_J_";"_(DGA/100+82)_"////"_$P(J82,", ",DGA)_";"
 . I $L(@DGB)>220 S DGB="DR(1,45.02,"_(1+$O(DR(1,45.02,99),-1))_")"
 . QUIT
 S I1=$P(T(NX),U,3) D TD5:DR]"" K DR
 ;-- restore expanded codes
 Q:'$D(^UTILITY($J,300,I2))  S DR="",DGEX=^(I2) F I=2:1:7 S:$P(DGEX,U,I)]"" DR=DR_"300.0"_I_"////"_$P(DGEX,U,I)_";"
 D TD5:DR]""
 QUIT
Q S T(PR)=^UTILITY($J,"T",PR) I $P(T(PR),U,4)>1 S NX=1,T(1)="^^1" D ONE
 QUIT
CK ; -- checks for PTF# in ^DGPM and $D of the PTF in ^DGPT; Y = ifn of adm
 Q:$D(^DGPT(+$P(^DGPM(Y,0),"^",16),0))
 S Y=-1 W !,"warning:  A PTF record does not exist for this admission - cannot edit",!?10,"Treating Specialty.  MIS personnel and your supervisor should",!?10,"be notified."
 W "  The PTF option, 'Establish PTF record from Past",!?10,"Admission', may be used to create a PTF record." Q
 ;
