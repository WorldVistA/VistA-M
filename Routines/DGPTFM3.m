DGPTFM3 ;ALB/ADL - MASTER CPT RECORD ENTER/EDIT PART 2 ;5/5/05 7:35am
 ;;5.3;Registration;**517,590,594,635,696**;Aug 13, 1993
REQ ;CHECK FOR REQUIRED FIELDS IN CPT RECORDS.  RECORDS MISSING ONE OR MORE REQUIRED FIELDS ARE DELETED.
 S RFL=0 G REQQ:'$D(DGZPRF(DGZP,0))
 I '$P(^DGPT(PTF,"C",DGZPRF(DGZP,0),0),U,3) S DA(1)=PTF,DA=DGPSM,DIK="^DGPT("_PTF_",""C""," D  G REQQ
 .D ^DIK K DA W !!,"No CPT record has been filed because no performing provider was specified." S RFL=1
 S (I,FCPT)=0 D RESEQ(PTF)
 F J=1:1 S I=$O(^DGCPT(46,"C",PTF,I)) Q:'I  D:+^DGCPT(46,I,1)=+DGZPRF(DGZP)&'$G(^(9))
 .I $P(^DGCPT(46,I,0),U,4) S FCPT=1 Q
 .S DA=I,DIK="^DGCPT(46,",CPT=+^DGCPT(46,I,0) D ^DIK
 .W !!,"CPT " S N=$$CPT^ICPTCOD(CPT,$$GETDATE^ICDGTDRG(PTF)) W $P(N,U,2)," ",$P(N,U,3)," not filed because no diagnosis 1 was entered."
 .S RFL=1
 I FCPT K FCPT,I,J,N G REQQ
 S DA(1)=PTF,DA=DGZPRF(DGZP,0),DIK="^DGPT("_PTF_",""C"","
 D ^DIK K DA W !!,"No CPT record has been filed because no CPT codes were filed." S RFL=1 K FCPT,I,J,N
REQQ ;D RESEQ(PTF)
 Q  ;REQ
RESEQ(PTF)      ;A subroutine to check if a DGN in the DGCPT global has been deleted and the other DGN's need 
 ;to be moved down in sequence to fill the "gap" in the global
 N REC,CPTINFO,DGNARAY
 S REC=0
 F  S REC=$O(^DGCPT(46,"C",PTF,REC)) Q:REC=""  K DGNARAY S CPTINFO=^DGCPT(46,REC,0) D
 . F J=4:1:7,15:1:18 S DGNARAY(J)=$P(CPTINFO,U,J)
 . I $$CHKGAP(.DGNARAY) D RESEQDGN(.CPTINFO,.DGNARAY) S ^DGCPT(46,REC,0)=CPTINFO
 Q  ;RESEQ
CHKGAP(DGNARAY) ;Function call to determine if an inside DGN code has been deleted
 ;Back up in the DGNARAY array until a non-null DGN ien is found, then continuing backwards, 
 ;if a null ien is located, that means that an "inside" DGN was deleted
 S SEQ=999,END=1,MISSING=0
 F  S SEQ=$O(DGNARAY(SEQ),-1) Q:SEQ=""!MISSING  D
 . I DGNARAY(SEQ)'="" S END=1 Q
 . I DGNARAY(SEQ)="",END=1 S MISSING=1
 Q MISSING
 ;
RESEQDGN(CPTINFO,DGNARAY)       ;Subroutine to shift down DGN codes to replace any inside DGN's that were deleted by the user
 ;
 N I
 S SEQ="" K NOTNULL
 F  S SEQ=$O(DGNARAY(SEQ)) Q:SEQ=""  I DGNARAY(SEQ)'="" S NOTNULL(SEQ)=DGNARAY(SEQ)
 K DGNARAY S SEQ=""
 F I=4:1:7,15:1:18 S DGNARAY(I)=""
 F I=4:1:7,15:1:18 S SEQ=$O(NOTNULL(SEQ)) Q:SEQ=""  S DGNARAY(I)=NOTNULL(SEQ)
 F I=4:1:7,15:1:18 S $P(CPTINFO,U,I)=$G(DGNARAY(I))
 K NOTNULL
 Q  ;RESEQDGN
PF S PTF=D0,DFN=+^DGPT(D0,0) D MOB^DGPTFM2 S PS2=0,J=+DGZPRF
 G END:'$P(DGZPRF,U,3)
LOOP S Y=+DGZPRF(J),DGSTRT=$S(+$P(DGZPRF,U,4):$P(DGZPRF,U,4),1:4),DGLST=0
 D CL^SDCO21(DFN,+DGZPRF(J),"",.SDCLY),ICDINFO^DGAPI(DFN,PTF),XREF^DGPTFM21 ; load SCI info and DGN's for this service date
 D D^DGPTUTL W !,J,"-CPT Capture Date/Time: ",Y W:($P(DGZPRF,U,2)-1!($G(PGBRK))) " (cont.)"
 I $P(DGZPRF(J),U,2) W !,?5,"Referring or Ordering Provider: " S L=$P(DGZPRF(J),U,2) D PRV^DGPTFM
 W !,?5,"Rendering Provider: " S L=$P(DGZPRF(J),U,3) D PRV^DGPTFM
 I $P(DGZPRF(J),U,5) W !,?5,"Rendering Location: ",$P($G(^SC($P(DGZPRF(J),U,5),0)),U)
 S (L1,PGBRK)=0
 F K1=$P(DGZPRF,U,2):1 Q:'$D(DGZPRF(J,K1))  I '$G(DGZPRF(J,K1,9)) D  Q:$Y+$G(DGZPRF(J,K1+1,1))>16!($G(PGBRK))
 . S PS2=PS2+1,K=K1 W !,?2,PS2," " D CPT^DGPTUTL1
 . W !,?4 S $P(DS,"-",27)="" W DS," Related Diagnosis ",DS
 . F L1=DGSTRT:1:11 S DGLOC=$S(L1<8:L1,1:L1+7),CD=$P(DGZPRF(J,K1),U,DGLOC) I CD D  I $Y+$G(CKSCI)>16 S PGBRK=1 Q
 . . S N=$$ICDDX^ICDCODE(CD,$$GETDATE^ICDGTDRG(PTF)),N=$S(N:$P(N,U,2,99),1:"")
 . . S CD=$P(N,U) W !,?8,CD,"   ",$P(N,U,3)
 . . D CKSCI^DGPTFM($P(DGZPRF(J,K1),U,DGLOC))
 . S PS2(PS2)=J_U_K1,CD=1,DGLOC=0,DGSTRT=4
 I L1'=11,$S(L1<8:$P($G(DGZPRF(J,K1)),U,L1+1,7),1:"")_$P($G(DGZPRF(J,K1)),U,$S(L1<8:15,1:L1+8),18)?."^" S L1=11
 I L1=11 S $P(DGZPRF,U,1,2)=$S($D(DGZPRF(J,K1+1)):J_U_(K1+1),1:J+1_U_1),$P(DGZPRF,U,4)="",PGBRK=0
 E  S $P(DGZPRF,U,1,2)=J_U_K1,$P(DGZPRF,U,4)=L1+1
 S J=+DGZPRF I $D(DGZPRF(J)) D HEAD^DGPTFMO G LOOP
END I $E(IOST)="C" W ! S DIR(0)="E" D ^DIR K DIR
 K I,K1,L1,CD,N Q
