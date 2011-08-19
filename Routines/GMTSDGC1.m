GMTSDGC1 ; SLC/KER/SBW - Subroutines for Ext ADT Hist    ; 03/24/2004 [8/25/04 9:59am]
 ;;2.7;Health Summary;**5,35,47,71**;Oct 20, 1995
 ;
 ; External References
 ;   DBIA  3390  $$ICDDX^ICDCODE
 ;   DBIA    17  ^DGPM(
 ;   DBIA  1372  ^DGPT( fields 71,73,75 Read w/Fileman
 ;   DBIA   512  ^DGPMLOS
 ;   DBIA 10015  EN^DIQ1 (file #45)
 ;   DBIA 10011  ^DIWP
 ;                     
OTHER(DFN,PTF,CODE,GMVAIP,MDA) ; Additional data to include
 N LOS,ICD,DGPMIFN,GMI,GMX,NODIAG,GMTO,GMTNO,BD,BDSC,ATTN,WARD,AWS
 N DP,DSPL,OP,OPTR
 I CODE=1 D  Q  ;Other data for Admission entries
 . Q:$G(GMVAIP("DN",1))'=""
 . D GETDATA
 . I $G(GMVAIP("MF"))]"" D CKP^GMTSUP Q:$D(GMTSQIT)  W ?12,"Adm. Diag: ",GMVAIP("MF")
 . W ?64,"LOS: ",LOS,!
 . Q:'$D(ICD)
 . S GMI=0
 . F  S GMI=$O(ICD(GMI)) Q:'GMI  D CKP^GMTSUP Q:$D(GMTSQIT)  S GMX="" F  S GMX=$O(ICD(GMI,80,GMX)) Q:'GMX  D NXTICD
 I CODE=2 D  Q  ;Other data for Transfer entries
 . N TRFAC
 . S TRFAC=$P(^DGPM(MDA,0),U,5)
 . I $P($G(GMVAIP("WL")),U,2)]"" D CKP^GMTSUP Q:$D(GMTSQIT)  W ?19,$S($P(VAIP("MT"),U,2)'["TO":"To ",1:""),$P(VAIP("WL"),U,2),$S($L(TRFAC):"  at "_TRFAC,1:""),!
 I CODE=3 D  Q  ;Other data for Discharge entries
 . ; Discharge data
 . D GETDATA
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?11,"Bedsection: ",BDSC,?64,"LOS: ",LOS,!
 . S NODIAG=1,GMI=0
 . F  S GMI=$O(ICD(GMI)) Q:GMI'>0  S GMX=0 F  S GMX=$O(ICD(GMI,80,GMX)) Q:GMX'>0  D NXTICD
 . I NODIAG D CKP^GMTSUP Q:$D(GMTSQIT)  D
 . . W ?7,"Principal Diag: No discharge diagnosis available.",!
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?4,"Disposition Place: ",DSPL,!
 . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?4,"Outpat. Treatment: ",OPTR,!
 . I 'GMTSNPG D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 I CODE=6 D  Q  ;Other data for Treating Specialty entries
 . N DIWL,DIWF,DIWR,GMJ,GMJ1
 . K ^UTILITY($J,"W")
 . S DIWL=22,DIWR=78,DIWF="C56"
 . I $D(^DGPM(MDA,"DX")) D
 . . F GMJ=1:1:$P(^DGPM(MDA,"DX",0),"^",4) S X=^DGPM(MDA,"DX",GMJ,0) D ^DIWP
 . I $D(^UTILITY($J,"W")) D
 . . S GMJ=$O(^UTILITY($J,"W",0)) Q:'GMJ
 . . D CKP^GMTSUP Q:$D(GMTSQIT)  W ?14,"TS Diag: "
 . . S GMJ1=0
 . . F  S GMJ1=$O(^UTILITY($J,"W",GMJ,GMJ1)) Q:'GMJ1  D CKP^GMTSUP Q:$D(GMTSQIT)  W ?23,^UTILITY($J,"W",GMJ,GMJ1,0),!
 . K ^UTILITY($J,"W")
 Q
GETDATA ; Gets LOS, ICD and bedsection data
 N DIC,DR,DA,DIQ,GMTSI,X,PTFA
 S DGPMIFN=$G(GMVAIP("AN"))
 I DGPMIFN D ^DGPMLOS S LOS=+X
 I '$D(^DGPT(PTF,70)) D  Q
 . S (BDSC,DSPL,OPTR)="UNKNOWN"
 S DIC=45,DA=+PTF,DR="71;73;75;",DIQ="PTFA(" D EN^DIQ1
 S BDSC=$S(PTFA(45,+DA,71)]"":PTFA(45,+DA,71),1:"UNKNOWN")
 S OPTR=$S(PTFA(45,+DA,73)]"":PTFA(45,+DA,73),1:"UNKNOWN")
 S DSPL=$S(PTFA(45,+DA,75)]"":PTFA(45,+DA,75),1:"UNKNOWN")
 Q:'$D(^ICD9)
 S ICD=^DGPT(PTF,70),DIC=80,DR=".01;3"
 S ICDI=+$P(ICD,U,10) I +ICDI>0 D
 . S ICDX=$$ICDDX^ICDCODE(ICDI)
 . S ICD(1,80,ICDI,.01)=$P(ICDX,"^",2)
 . S ICD(1,80,ICDI,3)=$P(ICDX,"^",4)
 S ICDI=+$P(ICD,U,11) Q:+ICDI'>0
 S ICDX=$$ICDDX^ICDCODE(ICDI)
 S ICD(2,80,ICDI,.01)=$P(ICDX,"^",2)
 S ICD(2,80,ICDI,3)=$P(ICDX,"^",4)
 F GMTSI=16:1:24 S ICDI=+$P(ICD,U,GMTSI) I ICDI>0 D
 . S ICDX=$$ICDDX^ICDCODE(ICDI)
 . S ICD((GMTSI-13),80,ICDI,.01)=$P(ICDX,"^",2)
 . S ICD((GMTSI-13),80,ICDI,3)=$P(ICDX,"^",4)
 Q
NXTICD ; Print the next ICD
 S (GMTO,GMTNO)="" S GMTO=$G(ICD(GMI,80,GMX,3)),GMTNO=$G(ICD(GMI,80,GMX,.01))
 W:GMI=1 ?7,"Principal Diag: "
 W:GMI=2 ?17,"DXLS: "
 W:GMI=3 ?15,"ICD DX: "
 D CKP^GMTSUP Q:$D(GMTSQIT)  W ?23,GMTO,?69,GMTNO,!
 S NODIAG=0
 Q
