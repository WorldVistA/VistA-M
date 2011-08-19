GMTSXAW ; SLC/KER - List Parameters/Allowable             ; 02/27/2002
 ;;2.7;Health Summary;**47,49**;Oct 20, 1995
 Q
 ;                                
EN ; Main Entry Point for Health Summary
 K GMTSALW Q:'$L($$UNM^GMTSXAW3(+($G(DUZ))))
 D ALW("ORWRP HEALTH SUMMARY TYPE LIST",.GMTSALW,+($G(DUZ)),"GMTS") Q
EN2(X) ; Entry for User X
 K GMTSALW N GMTSUSR S GMTSUSR=+($G(X)) Q:'$L($$UNM^GMTSXAW3(+($G(GMTSUSR))))
 D ALW("ORWRP HEALTH SUMMARY TYPE LIST",.GMTSALW,GMTSUSR,"GMTS") Q
DEF(X) ; Default Entities for HS Typye List
 ;                    
 ;   Use
 ;      DIV  Division          If exist
 ;      SYS  System            Exported Entity
 ;      SRV  Service           If exist
 ;      OTL  OERR Team List    If exist
 ;      USR  User              Exported Entity
 ;      CLS  User Class        If exist
 ;                    
 ;   Exclude
 ;      DEV  Device
 ;      PKG  Package
 ;      LOC  Location
 ;      TEA  PCMM Team
 ;      BED  Room/Bed
 ;                    
 N GMTSI,GMTSEP,GMTSES,GMTSEA,GMTSC,GMTSPAR,GMTSMSG,GMTSX,GMTSALW
 S (GMTSI,GMTSC)=0,GMTSX="",GMTSPAR=$$HSD^GMTSXAW3 Q:+GMTSPAR=0 ""
 D LST^GMTSXAW3(GMTSPAR,.GMTSALW)
 F  S GMTSI=$O(^TMP("DILIST",$J,"ID",GMTSI)) Q:+GMTSI=0  D
 . S GMTSES=+($G(^TMP("DILIST",$J,"ID",GMTSI,.01))) Q:+GMTSES'>0
 . S GMTSEP=+($G(^TMP("DILIST",$J,"ID",GMTSI,.02))) Q:+GMTSEP'>0
 . S GMTSEA=$$EAB^GMTSXAW3(+($G(GMTSEP)))
 . Q:$L(GMTSEA)'=3  S GMTSX(+GMTSES)=GMTSEA
 S GMTSI=0 F  S GMTSI=$O(GMTSX(GMTSI)) Q:+GMTSI=0  S:$G(GMTSX(GMTSI))?3U X=$G(X)_";"_GMTSX(GMTSI)
 S X=$$UP^GMTSXA($$TRIM^GMTSXA(X,";"))
 K ^TMP("DILIST",$J)
 Q X
 ;            
ALW(GMTSPAR,GMTSALW,GMTSUSR,GMTSPKG) ; Allowable Entities
 ;            
 ;   GMTSPAR     Parameter Name                     Required
 ;  .GMTSALW     Output Ary for Allowable Entities  Required
 ;   GMTSUSR     User (pointer)                     Required
 ;   GMTSPKG     Package Prefix (text)              Optional
 ;            
 N GMTSPDEF,GMTSI,GMTSEC,GMTSPV,GMTSLL,GMTSUN,GMTSCALL
 S GMTSPKG=$G(GMTSPKG),GMTSPAR=$G(GMTSPAR),GMTSUSR=$G(GMTSUSR)
 Q:'$L($$UNM^GMTSXAW3(+($G(GMTSUSR))))
 S GMTSPDEF=$$PDI^GMTSXAW3(GMTSPAR) Q:+GMTSPDEF=0  D ALWD(GMTSPDEF,.GMTSALW) S GMTSI=""
 F  S GMTSI=$O(GMTSALW("B",GMTSI)) Q:GMTSI=""  D
 . S GMTSEC=+($O(GMTSALW("B",GMTSI,0))) Q:GMTSEC=0  D
 . . S GMTSLL=GMTSI,GMTSCALL=GMTSLL_"^GMTSXAW2" D GET
 Q
CHK(GMTSALW,GMTSUSR,GMTSPKG) ; Check values Only
 ;            
 ;  .GMTSALW     Output Array for values            Required
 ;   GMTSUSR     User (pointer)                     Required
 ;   GMTSPKG     Package Prefix (namespace)         Optional
 ;            
 N GMTSCHK S GMTSCHK=1 D V2
 Q
VAL(GMTSALW,GMTSUSR,GMTSPKG) ; All Values and Pointers
 ;            
 ;  .GMTSALW     Output Array for values            Required
 ;   GMTSUSR     User (pointer)                     Required
 ;   GMTSPKG     Package Prefix (namespace)         Optional
 ;            
V2 ; Get Values and Pointers
 N GMTSU,GMTSPV S GMTSU=+($G(GMTSUSR)) S:+($G(GMTSUSR))=0 GMTSU=+($G(DUZ))
 N GMTSUSR S GMTSUSR=GMTSU Q:'$L($$UNM^GMTSXAW3(+($G(GMTSUSR))))
 N GMTST,GMTSI,GMTSEC,GMTSLL,GMTSCALL,GMTSVAL S GMTSPKG=$G(GMTSPKG),GMTSVAL=1
 S GMTSEC=0,GMTST="DEV;DIV;SYS;PKG;LOC;SRV;OTL;USR;CLS"
 F GMTSI=1:1 Q:'$L($P(GMTST,";",GMTSI))  S GMTSLL=$P(GMTST,";",GMTSI),GMTSCALL=GMTSLL_"^GMTSXAW2" D GET
 Q
 ;            
ALWD(X,Y) ; Get Allowed Entities for Parameter 
 ;            
 ;   X       Parameter (pointer)                    Required
 ;  .Y       Output Array for Allowed Entities      Required
 ;            
 N GMTSPIEN,GMTSNAM,GMTSMSG,GMTSALW,GMTSLST,GMTSENT,GMTSPRE,GMTSCT,GMTSAL
 S GMTSAL="",GMTSCT=0,GMTSPIEN=+($G(X)) Q:X=0  K ^TMP("DILIST",$J)
 S GMTSNAM=$$PDN^GMTSXAW3(+GMTSPIEN) Q:'$L(GMTSNAM)
 D LST^GMTSXAW3(GMTSPIEN,.GMTSALW)
 S GMTSLST=0 F  S GMTSLST=$O(^TMP("DILIST",$J,"ID",GMTSLST)) Q:+GMTSLST=0  D
 . S GMTSENT=+($G(^TMP("DILIST",$J,"ID",GMTSLST,.02)))
 . S GMTSPRE=$$EAB^GMTSXAW3(+($G(GMTSENT))) Q:'$L(GMTSPRE)  S GMTSCT=GMTSCT+1
 . S Y(GMTSCT)=GMTSPRE_"^"_$$EFN^GMTSXAW3(+($G(GMTSENT)))_"^"_$$ENM^GMTSXAW3(+($G(GMTSENT)))_"^"_$$EMC^GMTSXAW3(+($G(GMTSENT)))
 . S Y("B",GMTSPRE,GMTSCT)=$G(Y(GMTSCT)),GMTSAL=GMTSAL_";"_$$UP^GMTSXA(GMTSPRE)
 K ^TMP("DILIST",$J) S Y("ALLOWABLE")=$$TRIM^GMTSXA(GMTSAL,";"),Y(0)=GMTSCT
 Q
 ; Parameter Entites
GET ;   Get Entities
 S GMTSLL=$G(GMTSLL),GMTSCALL=$G(GMTSCALL) Q:'$L($T(@GMTSCALL))  K GMTSPV D @GMTSCALL
 N GMTS,GMTSA,GMTSP,GMTSN,GMTSC,GMTSV S GMTS=0
 F  S GMTS=$O(GMTSPV(GMTS)) Q:+GMTS=0  D
 . S GMTSA=$G(GMTSPV(GMTS)),GMTSP=$P(GMTSA,"^",2)
 . Q:GMTSP'[";"  S GMTSN=$P(GMTSA,"^",3) Q:'$L(GMTSN)
 . S GMTSC=+($G(GMTSEC)),GMTSV=+($G(GMTSVAL))+($G(GMTSCHK))
 . S GMTSA=$P(GMTSA,"^",1) Q:$L(GMTSA)'=3
 . D SET^GMTSXAW3(GMTSA,GMTSP,GMTSN,.GMTSALW,GMTSC,GMTSV)
 Q
TST ;   Test entry
 N GMTSEC,GMTSI,GMTSLL,GMTSCALL,GMTSU,GMTSPV,GMTSPKG,GMTSN,GMTSC,GMTSA,GMTSP,GMTST,GMTSV
 S GMTSEC=0,GMTSPKG="GMTS" S:'$L($G(GMTST)) GMTST="DEV;DIV;SYS;PKG;LOC;SRV;OTL;USR;CLS",GMTSPKG="GMTS"
 S GMTSU=+($G(GMTSUSR)) S:GMTSU'>0 GMTSU=+($G(DUZ)) Q:GMTSU'>0  N GMTSUSR S GMTSUSR=GMTSU
 F GMTSI=1:1 Q:'$L($P(GMTST,";",GMTSI))  D
 . S GMTSLL=$P(GMTST,";",GMTSI),GMTSCALL=GMTSLL_"^GMTSXAW2"
 . W !!,GMTSLL,?8,$$EMC^GMTSXAW3($$ETI^GMTSXAW3(GMTSLL))
 . Q:'$L($T(@GMTSCALL))  K GMTSPV D @GMTSCALL Q:'$D(GMTSPV)
 . S GMTSEC=0 S:$L(GMTSLL) GMTSEC=+($O(GMTSALW("B",GMTSLL,0)))
 . S GMTSN="GMTSPV(0)",GMTSC="GMTSPV("
 . F  S GMTSN=$Q(@GMTSN) Q:GMTSN=""!(GMTSN'[GMTSC)  W !,GMTSN,"=",@GMTSN
 . N GMTS S GMTS=0 F  S GMTS=$O(GMTSPV(GMTS)) Q:+GMTS=0  D
 . . S GMTSA=$G(GMTSPV(GMTS)),GMTSP=$P(GMTSA,"^",2)
 . . Q:GMTSP'[";"  S GMTSN=$P(GMTSA,"^",3) Q:'$L(GMTSN)
 . . S GMTSC=+($G(GMTSEC)),GMTSV=+($G(GMTSVAL))+($G(GMTSCHK))
 . . S GMTSA=$P(GMTSA,"^",1) Q:$L(GMTSA)'=3
 . . D SET^GMTSXAW3(GMTSA,GMTSP,GMTSN,.GMTSALW,GMTSC,GMTSV)
 Q
