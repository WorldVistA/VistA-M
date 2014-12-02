LEXSET ;ISL/KER - Setup Appl/User Defaults for Look-up ;04/21/2014
 ;;2.0;LEXICON UTILITY;**25,80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^TMP("LEXSCH")      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     DIC,x              Killed by calling application
 ;     LEXLL,LEXQ,LEXVDT  Killed by Speicial Lookup LEXA1
 ;     XTLKGBL,XTLKHLP    Killed by MTLU
 ;     XTLKKSCH,XTLKSAY   Killed by MTLU
 ;               
EN ; Namespace/subset are not known
 N DTOUT,DUOUT,LEXNS,LEXSS,LEXDS,LEXDW,LEXDR,LEXDP,LEXDA,LEXDB,LEXD0,LEXD,LEXDX
 S LEXNS=$$NS^LEXSET4 Q:LEXNS[U!($D(DTOUT))!($D(DUOUT))
 S LEXSS=$$SS^LEXSET4(LEXNS) Q:LEXSS[U!($D(DTOUT))!($D(DUOUT))
 D CONFIG(LEXNS,LEXSS)
 Q
CONFIG(LEXNS,LEXSS,LEXCDT) ;  Namespace/subset are known
 ;
 ; Input
 ; 
 ;   LEXNS   Namespace from file 757.2 'AN' index
 ;   LEXSS   Subset from file 757.2, 'AA' or 'AB' index
 ;   LEXCDT  Date to used to configure lookp
 ;   
 ; Output
 ; 
 ;   ^TMP(LEXSCH,$J) 
 ;   
 ;           Global array containing the following parameters
 ;              APP    Application (from LEXNS) 
 ;              DIS    Display format 
 ;              FIL    Filter 
 ;              FLN    File Number 
 ;              GBL    Global (Fileman DIC) 
 ;              IDX    Index used during the search 
 ;              LEN    Length of list to display 
 ;              LOC    Hospital Location 
 ;              OVR    Overwrite User Defaults flag 
 ;              SCT    Shortcuts 
 ;              SVC    Service 
 ;              UNR    Unresolved Narrative flag 
 ;              USR    User (DUZ) 
 ;              VDT    Versioning Date
 ;              VOC    Vocabulary 
 ;
 N LEXD,LEXSUB,LEXAP,LEXSHOW,LEXSCT,LEXUN,LEXQOK S LEXCDT=$P($G(LEXCDT),".",1)
 S:LEXCDT?7N LEXVDT=LEXCDT D VDT^LEXU S LEXCDT=$G(LEXVDT),LEXQOK=$D(LEXQ)
 N LEXA,LEXL,LEXS,LEXM,LEXD S LEXNS=$G(LEXNS),LEXSS=$G(LEXSS)
 S LEXQ=$S($D(LEXQ):+LEXQ,1:1) S:LEXNS="" LEXNS="LEX" S:LEXSS="" LEXSS="WRD"
 S:'$D(^LEXT(757.2,"AN",LEXNS)) LEXNS=$$NS^LEXDFN2(LEXNS)
 S:'$D(^LEXT(757.2,"AA",LEXSS))&('$D(^LEXT(757.2,"AB",LEXSS))) LEXSS=$$MD^LEXDFN2(LEXSS)
 N LEXUS,LEXO,LEXT
 S LEXA=$$NSIEN(LEXNS),LEXS=$$SSIEN(LEXSS)
 S LEXM=$$MDIEN(LEXSS),LEXL=$$ASIEN(LEXA)
 I +LEXA=0!(+LEXS=0) D DEF G SET
 D APP^LEXSET2(LEXA)
 I LEXM=0!(LEXM>0&(LEXM=LEXA)) D SUB^LEXSET2(LEXS)
 I LEXM>0,LEXM'=LEXA D MOD^LEXSET2(LEXM)
 D USR^LEXSET2(LEXA)
 D GEN^LEXSET2
 I +($G(LEXD("DF","OVR")))>0 D OVER^LEXSET3
 I +($G(LEXD("DF","OVR")))=0 D USER^LEXSET3
 S:$G(LEXCDT)?7N ^TMP("LEXSCH",$J,"VDT",0)=+($G(LEXCDT))
 S:$G(LEXCDT)?7N ^TMP("LEXSCH",$J,"VDT",1)="Version Date Check: "_$$FMTE^XLFDT($G(LEXCDT))
 D EN^LEXSET5 S:+($G(LEXQ))=1 ^TMP("LEXSCH",$J,"ADF",0)=1
SET ; Quit Setting Defaults
 I LEXQOK'>0 K LEXLL,LEXQ,LEXVDT
 Q
DEF ; Defaults if LEXNS or LEXSS are invalid
 S LEXD("DF","DIS")="ICD/CPT",LEXD("DF","DSP")="XTLK^LEXPRNT"
 S LEXD("DF","FLN")=757.01,LEXD("DF","GBL")="^LEX(757.01,"
 S LEXD("DF","LEXAP")=1,LEXD("DF","UNR")=0
 S LEXD("DF","HLP")="D XTLK^LEXHLP",LEXD("DF","IDX")="AWRD"
 S LEXD("DF","NAM")="Lexicon",LEXD("DF","OVR")=0
 S LEXD("DF","SUB")="WRD"
 Q
ALTDEF ; Defaults if LEXNS or LEXSS are invalid
 S (DIC,XTLKGBL,XTLKKSCH("GBL"))="^LEX(757.01,"
 S XTLKKSCH("DSPLY")="XTLK^LEXPRNT",XTLKKSCH("INDEX")="AWRD",XTLKHLP="D XTLK^LEXHLP"
 S XTLKSAY=1 S:'$L($G(DIC(0))) DIC(0)="EQM" S:'$L($G(X))&(DIC(0)'["A") DIC(0)="A"_DIC(0)
 S:DIC(0)["L" DIC(0)=$P(DIC(0),"L",1)_$P(DIC(0),"L",2) S:DIC(0)["I" DIC(0)=$P(DIC(0),"I",1)_$P(DIC(0),"L",2)
 S LEXAP=1,LEXLL=5,LEXUN=0,LEXSUB="WRD",LEXSHOW="ICD/CPT"
 Q
NSIEN(LEX) ; Get IEN for application based on namespace
 Q:'$L($G(LEX)) 0 Q:$D(^LEXT(757.2,"AN",LEX)) $O(^LEXT(757.2,"AN",LEX,0)) Q 0
SSIEN(LEX) ; Get IEN for subset based on subset
 Q:'$L($G(LEX)) 0
 Q:$D(^LEXT(757.2,"AA",LEX)) $O(^LEXT(757.2,"AA",LEX,0))
 S:$D(^LEXT(757.2,"AB",LEX)) LEX=$O(^LEXT(757.2,"AB",LEX,0))
 I +LEX>0,$D(^LEXT(757.2,LEX,5)) S LEX=$P(^LEXT(757.2,LEX,5),"^",2)
 I LEX'="",$D(^LEXT(757.2,"AA",LEX)) Q $O(^LEXT(757.2,"AA",LEX,0))
 Q 0
MDIEN(LEX) ; Get IEN for mode based on subset
 Q:'$L($G(LEX)) 0
 I $D(^LEXT(757.2,"AB",LEX)) S LEX=$O(^LEXT(757.2,"AB",LEX,0)) S LEX=+LEX Q LEX
 Q 0
ASIEN(LEX) ; Get IEN for application 
 Q:+($G(LEX))=0 0
 S LEX=+LEX Q:'$L($P($G(^LEXT(757.2,LEX,5)),"^",2))&('$L($P($G(^LEXT(757.2,LEX,0)),"^",2))) 0
 S:$L($P($G(^LEXT(757.2,LEX,5)),"^",2)) LEX=$P($G(^LEXT(757.2,LEX,5)),"^",2)
 S:$L($P($G(^LEXT(757.2,LEX,0)),"^",2)) LEX=$P($G(^LEXT(757.2,LEX,0)),"^",2)
 Q:$D(^LEXT(757.2,"AA",LEX)) $O(^LEXT(757.2,"AA",LEX,0))
 Q 0
