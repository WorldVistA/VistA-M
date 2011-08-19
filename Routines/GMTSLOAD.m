GMTSLOAD ;SLC/JER - Loads Ad Hoc Summary Type ; 02/27/2002
 ;;2.7;Health Summary;**23,30,36,37,49**;Oct 20, 1995
 ;                  
 ; External References
 ; DBIA 10026  ^DIR
 ; DBIA 10141  BMES^XPDUTL
 ; DBIA 10141  MES^XPDUTL
 ;                    
MAIN ; Controls branching and execution
 N DIC,DIROUT,DIRUT,DIR,GMI,GMW,GMTJ,GMTNM,GMTSEG,GMTSFUNC,GMTSI,GMTSIFN,GMTSWHL,INCLUDE,S2,X,Y
 W !!,"This option rebuilds the Ad Hoc Health Summary to include ALL components",!
 W "alphabetized by name.  If you wish, you may exclude DISABLED components.",!
 S DIR(0)="Y",DIR("A")="Do you wish to continue",DIR("B")="NO",DIR("?")="Answer ""Y"" or ""N"", ""NO"" to exit this option."
 D ^DIR Q:Y=0  W !
 I $S($D(DIRUT):1,$D(DIROUT):1,1:0) Q
 S DIR("?")="Answer ""Y"" or ""N"", ""YES"" to include DISABLED components."
 S DIR("A")="Should DISABLED components be included",DIR("B")="YES"
 D ^DIR
 I $S($D(DIRUT):1,$D(DIROUT):1,1:0) Q
 S INCLUDE=Y
ENPOST ; Entry point from Post-init
 ;   Call with INCLUDE=0 to exclude DISABLED components
 ;   Call with INCLUDE=1 to include DISABLED components
 N NEWREC,GMTSTYP,DLAYGO
 S DLAYGO=142
 S DIC=142,DIC(0)="LXF",X="GMTS HS ADHOC OPTION" S Y=$$TYPE^GMTSULT K DIC
 I +Y'>0 D NOFILE Q
 S (GMTSIFN,GMTSTYP)=+Y,NEWREC=+$P(Y,U,3)
 S:'$D(^GMT(142,GMTSIFN,1,0)) ^(0)="^142.01IA^0^0"
 S GMTNM="" F GMI=1:1 S GMTNM=$O(^GMT(142.1,"B",GMTNM)) Q:GMTNM']""  S GMTJ=$O(^(GMTNM,0)) Q:GMTJ'>0  D LOAD
 S GMTSI=0 I 'NEWREC F  S GMTSI=$O(^GMT(142,GMTSIFN,1,GMTSI)) Q:GMTSI'>0  D PURGE^GMTSRN
 D BMES^XPDUTL(" Rebuilding Ad Hoc Summary")
 D RNMBR^GMTSRN
 D MES^XPDUTL(" Done")
 Q
NOFILE ; GMTS HS ADHOC OPTION Summary Type is missing
 D MES^XPDUTL(" ")
 D BMES^XPDUTL("** GMTS AD HOC OPTION Summary Type is missing **")
 Q
 ;                  
LOAD ; Loads GMTSEG(GMI)=Sequence ^ Component ^ Occurrence Limit ^
 ;   Time Limit ^^ Hospital Location ^ ICD Text Displayed ^
 ;   Provider Narratived Displayed ^ CPT Modifier Displayed
 ;                   
 ; Needs GMTJ     Pointer to Component  142.1
 ;       GMTSTYP  Pointer to Type       142
 ;       GMI      Pointer to Structure  142.01 in GMTSEG(GMI)
 ;
 N COMP,TYPE,OCC,TIME,GMSEQ,HOSPLOC,ICDTEXT,PROVNARR,CPTMOD
 Q:'$D(^GMT(142.1,GMTJ,0))
 S GMSEQ=$O(^GMT(142,"AE",GMTJ,GMTSTYP,0))
 I GMSEQ>0 D
 . S COMP=$P($G(^GMT(142.1,GMTJ,0)),U,5),TYPE=$P($G(^GMT(142,GMTSTYP,1,GMSEQ,0)),U,3)
 . S OCC=$S(COMP="Y":TYPE,1:"")
 . S COMP=$P($G(^GMT(142.1,GMTJ,0)),U,3),TYPE=$P($G(^GMT(142,GMTSTYP,1,GMSEQ,0)),U,4)
 . S TIME=$S(COMP="Y":TYPE,1:"")
 . S COMP=$P($G(^GMT(142.1,GMTJ,0)),U,10),TYPE=$P($G(^GMT(142,GMTSTYP,1,GMSEQ,0)),U,6)
 . S HOSPLOC=$S(COMP="Y":TYPE,1:"")
 . S COMP=$P($G(^GMT(142.1,GMTJ,0)),U,11),TYPE=$P($G(^GMT(142,GMTSTYP,1,GMSEQ,0)),U,7)
 . S ICDTEXT=$S(COMP="Y":TYPE,1:"")
 . S COMP=$P($G(^GMT(142.1,GMTJ,0)),U,12),TYPE=$P($G(^GMT(142,GMTSTYP,1,GMSEQ,0)),U,8)
 . S PROVNARR=$S(COMP="Y":TYPE,1:"")
 . S COMP=$P($G(^GMT(142.1,GMTJ,0)),U,14),TYPE=$P($G(^GMT(142,GMTSTYP,1,GMSEQ,0)),U,9)
 . S CPTMOD=$S((COMP="Y"&(TYPE'="N")):"Y",(COMP="Y"&(TYPE="N")):"N",1:"")
 E  D
 . S OCC=$S($P(^GMT(142.1,GMTJ,0),U,5)="Y":10,1:"")
 . S TIME=$S($P(^GMT(142.1,GMTJ,0),U,3)="Y":"1Y",1:"")
 . S HOSPLOC=$S($P(^GMT(142.1,GMTJ,0),U,10)="Y":"Y",1:"")
 . S ICDTEXT=$S($P(^GMT(142.1,GMTJ,0),U,11)="Y":"L",1:"")
 . S PROVNARR=$S($P(^GMT(142.1,GMTJ,0),U,12)="Y":"Y",1:"")
 . S CPTMOD=$S($P(^GMT(142.1,GMTJ,0),U,14)="Y":"Y",1:"")
 D SETSEG
 Q
 ;                  
SETSEG ; Set Segment
 ;  GMTSEG(GMI)
 S GMI=+($G(GMI)) Q:GMI=0  N OFF S OFF=$S($P(^GMT(142.1,GMTJ,0),U,6)="P":1,$P(^(0),U,6)="T":1,1:0)
 I (+($G(INCLUDE))=0),(OFF=1) Q
 S GMTSEG(GMI)=(5*GMI)_U_GMTJ_U_OCC_U_TIME_U_U_HOSPLOC_U_ICDTEXT_U_PROVNARR_U_CPTMOD
 I GMSEQ>0 D SETSEL
 Q
SETSEL ; Sets up selection items
 ;  GMTSEG(GMI,GMSEL)=Selection item
 N GMSEL,GMITEM,GMW,S2
 S GMSEL=0 F  S GMSEL=$O(^GMT(142,GMTSTYP,1,+GMSEQ,1,GMSEL)) Q:GMSEL'>0  S GMITEM=^(GMSEL,0) S GMTSEG(GMI,GMSEL)=GMITEM
 Q
