GMPLENFM ; SLC/MKB/KER -- Problem List Enc Form utilities ; 04/15/2002
 ;;2.0;Problem List;**3,4,7,26,35**;Aug 25, 1994;Build 26
 ;
 ; External References
 ;   DBIA 10082  ^ICD9(
 ;   DBIA 10006  ^DIC
 ;   DBIA  1609  CONFIG^LEXSET
 ;                    
ACTIVE ; List of Active Problems for DFN
 ;   Sets Global Array:                   
 ;   ^TMP("IB",$J,"INTERFACES",DFN,"GMP PATIENT ACTIVE PROBLEMS",#) =
 ;                      
 ;   Piece 1:  Problem text
 ;         2:  ICD code
 ;         3:  Date of Onset     00/00/00 format
 ;         4:  SC/NSC/""         serv-conn/not sc/unknown
 ;         5:  Y/N/""            serv-conn/not sc/unknown
 ;         6:  A/I/E/H/M/C/S/""      If problem is flagged as:
 ;                               A - Agent Orange
 ;                               I - Ionizing Radiation
 ;                               E - Environmental Contaminants
 ;                               H - Head/Neck Cancer
 ;                               M - Mil Sexual Trauma
 ;                               C - Combat Vet
 ;                               S - SHAD
 ;                                 - None
 ;         7:  Special Exposure  Full text of piece 6
 ;                    
 N IFN,PROB,CNT,GMPL0,GMPL1,SC,NUM,GMPLIST,GMPARAM,GMPLVIEW,GMPTOTAL
 N GMPDFN,NODE
 Q:$G(DFN)'>0  S GMPDFN=DFN,CNT=0,NODE=$G(^GMPL(125.99,1,0))
 S GMPARAM("VER")=$P(NODE,U,2),GMPARAM("REV")=$P(NODE,U,5)="R",GMPARAM("QUIET")=1
 S GMPLVIEW("ACT")="A",GMPLVIEW("PROV")=0,GMPLVIEW("VIEW")=""
 D GETPLIST^GMPLMGR1(.GMPLIST,.GMPTOTAL,.GMPLVIEW)
 F NUM=0:0 S NUM=$O(GMPLIST(NUM)) Q:NUM'>0  D
 . S IFN=GMPLIST(NUM) Q:IFN'>0
 . S GMPL0=$G(^AUPNPROB(IFN,0)),GMPL1=$G(^(1))
 . S PROB=$$PROBTEXT^GMPLX(IFN),CNT=CNT+1
 . I GMPARAM("VER"),$P(GMPL1,U,2)="T" S PROB="$"_PROB
 . S PROB=PROB_U_$P($G(^ICD9(+$P(GMPL0,U),0)),U)
 . S PROB=PROB_U_$$EXTDT^GMPLX($P(GMPL0,U,13)),SC=$P(GMPL1,U,10)
 . S PROB=PROB_U_$S(+SC:"SC^Y",SC=0:"NSC^N",1:"^")
 . S PROB=PROB_U_$$GMPL1
 . ;S PROB=PROB_U_$S($P(GMPL1,U,11):"A^Agent Orange",$P(GMPL1,U,12):"I^Ionizing Radiation",$P(GMPL1,U,13):"E^Env. Contaminants"
 . ;,$P(GMPL1,U,13):"H^Head/Neck Cancer",$P(GMPL1,U,16):"M^Mil Sexual Trauma",$P(GMPL1,U,17):"C^Combat Vet",$P(GMPL1,U,18):"S^SHAD",1:"^")
 . S ^TMP("IB",$J,"INTERFACES",+$G(DFN),"GMP PATIENT ACTIVE PROBLEMS",CNT)=PROB
 S ^TMP("IB",$J,"INTERFACES",+$G(DFN),"GMP PATIENT ACTIVE PROBLEMS",0)=CNT
 Q
 ;
SELECT ; Select Common Problems
 ;   Sets Global Array:
 ;   ^TMP("IB",$J,"INTERFACES","GMP SELECT CLINIC COMMON PROBLEMS")
 ;   Piece 1:  Pointer to Clinical Lexicon
 ;         2:  Problem Text
 ;         3:  ICD Code (null if unknown)
 ;            
 N X,Y,DIC,PROB D CONFIG^LEXSET("ICD","ICD")
 K ^TMP("IB",$J,"INTERFACES","GMP SELECT CLINIC COMMON PROBLEMS")
 S DIC("A")="Select PROBLEM: ",DIC(0)="AEQM",DIC="^LEX(757.01,"
 D ^DIC Q:+Y<0  S PROB=Y I +Y'>1 S PROB=+Y_U_X
 S PROB=PROB_U_$G(Y(1))
 S ^TMP("IB",$J,"INTERFACES","GMP SELECT CLINIC COMMON PROBLEMS")=PROB
 Q
 ;
DSELECT ; List of Active Problems for DFN
 ;   Sets Global Array"
 ;   ^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS",#) =
 ;            
 ;   Piece 1:  Problem IEN
 ;         2:  Problem Text
 ;         3:  ICD code
 ;         4:  Date of Onset     00/00/00 format
 ;         5:  SC/NSC/""         serv-conn/not sc/unknown
 ;         6:  Y/N/""            serv-conn/not sc/unknown
 ;         7:  A/I/E/H/M/C/S/""      If problem is flagged as:
 ;                               A - Agent Orange
 ;                               I - Ionizing Radiation
 ;                               E - Environmental Contaminants
 ;                               H - Head/Neck Cancer
 ;                               M - Mil Sexual Trauma
 ;                               C - Combat Vet
 ;                               S - SHAD
 ;                                 - None
 ;         8:  Special Exposure  Full text of piece 6
 ;                
 N IFN,PROB,CNT,GMPL0,GMPL1,SC,NUM,GMPLIST,GMPARAM,GMPLVIEW,GMPTOTAL,GMPDFN,NODE
 Q:$G(DFN)'>0  S GMPDFN=DFN,CNT=0,NODE=$G(^GMPL(125.99,1,0))
 S GMPARAM("VER")=$P(NODE,U,2),GMPARAM("REV")=$P(NODE,U,5)="R",GMPARAM("QUIET")=1
 S GMPLVIEW("ACT")="A",GMPLVIEW("PROV")=0,GMPLVIEW("VIEW")=""
 D GETPLIST^GMPLMGR1(.GMPLIST,.GMPTOTAL,.GMPLVIEW)
 F NUM=0:0 S NUM=$O(GMPLIST(NUM)) Q:NUM'>0  D
 . S IFN=GMPLIST(NUM) Q:IFN'>0
 . S GMPL0=$G(^AUPNPROB(IFN,0)),GMPL1=$G(^(1))
 . S PROB=$$PROBTEXT^GMPLX(IFN),CNT=CNT+1
 . I GMPARAM("VER"),$P(GMPL1,U,2)="T" S PROB="$"_PROB
 . S PROB=IFN_U_PROB
 . S PROB=PROB_U_$P($G(^ICD9(+$P(GMPL0,U),0)),U)
 . S PROB=PROB_U_$$EXTDT^GMPLX($P(GMPL0,U,13)),SC=$P(GMPL1,U,10)
 . S PROB=PROB_U_$S(+SC:"SC^Y",SC=0:"NSC^N",1:"^")
 . S PROB=PROB_U_$$GMPL1
 . ;S PROB=PROB_U_$S($P(GMPL1,U,11):"A^Agent Orange",$P(GMPL1,U,12):"I^Radiation",$P(GMPL1,U,13):"E^Contaminants",$P(GMPL1,U,13):"H^Head/Neck Cancer"
 . ;,$P(GMPL1,U,16):"M^Mil Sexual Trauma",$P(GMPL1,U,17):"C^Combat Vet",$P(GMPL1,U,18):"S^SHAD",1:"^")
 . S ^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS",CNT)=PROB
 S ^TMP("IB",$J,"INTERFACES","GMP SELECT PATIENT ACTIVE PROBLEMS",0)=CNT
 Q
 ;
GMPL1() ;Determine Treatment Factor, if any
 N NXTTF,TXFACTOR
 S TXFACTOR="^"
 F NXTTF=11,12,13,15,16,17,18 I $P(GMPL1,U,NXTTF) S TXFACTOR=$P("A^Agent Orange;I^Ionizing Radiation;E^Env. Contaminants;;H^Head/Neck Cancer;M^Mil Sexual Trauma;C^Combat Vet;S^SHAD",";",NXTTF-10) Q
 Q TXFACTOR
