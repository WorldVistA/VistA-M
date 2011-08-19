GMTSDGA2 ; SLC/MKB,KER - Treating Spec for HS ; 02/27/2002
 ;;2.7;Health Summary;**28,49**;Oct 20, 1995
 ;                    
 ; External References
 ;   DBIA    17  ^DGPM(
 ;   DBIA  1003  ^DGS(41.1
 ;   DBIA  3145  ^DIC(42.4
 ;   DBIA  3147  ^DIC(45.7
 ;   DBIA 10015  EN^DIQ1 (file 41.1)
 ;   DBIA 10011  ^DIWP
 ;                    
TSOUT ; Treating Speciality Output
 S X=+VAIP(13,1) D REGDT4^GMTSU S DDT=X
 S X=ADATE D MTIM^GMTSU S ADT=ADT_" "_X
 S TS=$P($G(^DIC(45.7,+VAIP(8),0)),U,2) S SPEC=$S($D(^DIC(42.4,+TS,0)):$P(^(0),U),1:"UNKNOWN")
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ADT,?21,$E(SPEC,1,25),?48,"(",DDT,")",?63,$E($P(VAIP(7),U,2),1,15),!
 K ^UTILITY($J,"W") I $D(^DGPM(ADA,"DX")) F GMJ=1:1:$P(^DGPM(ADA,"DX",0),"^",4) S X=^DGPM(ADA,"DX",GMJ,0),DIWL=27,DIWR=71,DIWF="C46R" D ^DIWP
 I $D(^UTILITY($J,"W")) D CKP^GMTSUP Q:$D(GMTSQIT)  W ?21,"Diag: " S GMJ=$O(^UTILITY($J,"W",0)) Q:'GMJ  S GMJ1=0 F GMZ=0:0 S GMJ1=$O(^UTILITY($J,"W",GMJ,GMJ1)) Q:'GMJ1  D CKP^GMTSUP Q:$D(GMTSQIT)  W ?27,^UTILITY($J,"W",GMJ,GMJ1,0),!
 K DIWL,DIWF,DIWR,^UTILITY($J,"W")
 Q
FADM ; Future Scheduled admission output
 N GMDT,NODE,X
 K ^TMP("GMFADM",$J)
 D GETFADM
 Q:'$D(^TMP("GMFADM",$J))
 S GMC=1
 S GMDT=0
 F  S GMDT=$O(^TMP("GMFADM",$J,GMDT)) Q:GMDT'>0  D
 . I FLAG>1,'GMTSNPG D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 . D CKP^GMTSUP Q:$D(GMTSQIT)
 . S FLAG=2
 . S NODE=$G(^TMP("GMFADM",$J,GMDT))
 . S X=$P(NODE,U) D REGDT4^GMTSU
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W X," (Future)",?23,$E($P(NODE,U,5),1,24)
 . I $P(NODE,U,6)>0 W ?49,"Expected LOS: ",$P(NODE,U,6),!
 . D CKP^GMTSUP Q:$D(GMTSQIT)  D
 . . I $P(NODE,U,2)]"" W "Admitting Diagnosis: ",$P(NODE,U,2)
 . . W ?51,"Provider: ",$E($P(NODE,U,3),1,15),!
 K ^TMP("GMFADM",$J)
 Q
GETFADM ; Get future scheduled admission data
 N DA,DIQ,DIC,DR
 Q:'$D(^DGS(41.1,"B",DFN))
 K ^TMP("GMFADM",$J)
 S DA=0,DIC=41.1,DR="2;3;4;5;6;8;9;10;13;17"
 F  S DA=$O(^DGS(41.1,"B",DFN,DA)) Q:DA'>0  D
 . N GMFADM,DIQ,RESDT,ADDX,PROV,SUR,LOC,LOS
 . S DIQ="GMFADM",DIQ(0)="IE"
 . D EN^DIQ1
 . ;   Quit if reservation day is past, 
 . ;   admission cancel or patient admitted
 . Q:GMFADM(41.1,DA,13,"I")]""!(GMFADM(41.1,DA,17,"I")]"")!(GMFADM(41.1,DA,2,"I")<DT)
 . S RESDT=GMFADM(41.1,DA,2,"I"),ADDX=GMFADM(41.1,DA,4,"I")
 . S PROV=GMFADM(41.1,DA,5,"E"),SUR=GMFADM(41.1,DA,6,"E")
 . ;   LOC will contain either ward or treating specialty
 . S LOC=$S(GMFADM(41.1,DA,10,"I")="W":GMFADM(41.1,DA,8,"E"),GMFADM(41.1,DA,10,"I")="T":GMFADM(41.1,DA,9,"E"),1:"")
 . S LOS=GMFADM(41.1,DA,3,"I")
 . S ^TMP("GMFADM",$J,9999999-RESDT)=RESDT_U_ADDX_U_PROV_U_SUR_U_LOC_U_LOS
 Q
