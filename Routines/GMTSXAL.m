GMTSXAL ; SLC/KER - List Parameters/Get List              ; 02/27/2002
 ;;2.7;Health Summary;**47,49,66**;Oct 20, 1995
 Q
 ;                          
 ; External References in GMTSXAL
 ;   DBIA  2992  ^XTV(8989.5,
 ;   DBIA  2056  $$GET1^DIQ
 ;   DBIA  2263  GETLST^XPAR
 ;                
GETLIST(GMTSL,GMTSUSR,GBL,ERR) ; Get Health Summary Type Parameter List
 N GMTSCP,GMTSCPL,GMTSPRE,GMTSDEF,ROOT
 I '$G(GBL) K GMTSL S ROOT=$NA(GMTSL)
 I $G(GBL) D  Q:$G(ERR)
 . I $E($G(GMTSL),1)'="^" S ERR="19^"_$$EZBLD^DIALOG(19) Q
 . S ROOT=GMTSL
 S @ROOT=0
 S GMTSUSR=+($G(GMTSUSR)) Q:+GMTSUSR'>0  Q:'$L($$UNM^GMTSXAW3(GMTSUSR))
 S GMTSCPL=$$CPL(GMTSUSR),GMTSPRE=$$PRE(GMTSUSR)
 D GETLST(.ROOT,GMTSUSR,GMTSCPL,GMTSPRE)
 I $D(GMTSIDX) D
 . S @ROOT@("AC","PRE")=GMTSPRE,@ROOT@("AC","CPL")=GMTSCPL_"^"_$S(+($G(GMTSCPL))'>0:"Overwrite",1:"Append")
 . N GMTSI,GMTST,GMTSTO,GMTSTC,GMTSTCT,GMTSV,GMTSC
 . S GMTSTO="",(GMTSC,GMTSTC,GMTSTCT,GMTSI)=0
 . F  S GMTSI=$O(@ROOT@(GMTSI)) Q:+GMTSI=0  D
 . . S GMTSV=$G(@ROOT@(GMTSI)),GMTST=$G(@ROOT@("C",GMTSI)) Q:'$L(GMTST)
 . . S GMTSC=GMTSC+1,@ROOT@("A",GMTST,0)=GMTSC,@ROOT@("A",GMTST,GMTSC)=GMTSV
 . . S:GMTST'=GMTSTO GMTSTC=GMTSTC+1,GMTSTCT=0
 . . S GMTSTCT=GMTSTCT+1
 . . S @ROOT@("AB",0)=GMTSTC,@ROOT@("AB",+GMTSTC,0)=GMTSTCT,@ROOT@("AB",+GMTSTC,GMTSTCT)=GMTST_"^"_GMTSV,GMTSTO=GMTST
 . K @ROOT@("B"),@ROOT@("C") S GMTST="" F  S GMTST=$O(@ROOT@("A",GMTST)) Q:GMTST=""  D
 . . S GMTSI=0 F  S GMTSI=$O(@ROOT@("A",GMTST,GMTSI)) Q:+GMTSI=0  D
 . . . S GMTSC=+($G(@ROOT@("A",GMTST,GMTSI)))
 . . . S GMTSV=$P($G(@ROOT@("A",GMTST,GMTSI)),"^",2)
 . . . S:+GMTSC>0 @ROOT@("B",+GMTSC,GMTSI)=""
 . . . S:$L(GMTSV)>0 @ROOT@("BA",GMTSV,GMTSI)=""
 Q
 ;                      
GETILIST(GMTSL,GMTSUSR) ; Get Indexed Health Summary Types Parameter List
 S GMTSUSR=+($G(GMTSUSR)) Q:GMTSUSR=0  Q:'$L($$UNM^GMTSXAW3(GMTSUSR))
 N GMTSIDX S GMTSIDX=1 D GETLIST(.GMTSL,GMTSUSR)
 Q
 ;                            
GETLST(ROOT,GMTSUSR,GMTSCPL,GMTSPRE) ; Get List
 ;                            
 ; Health Summary Version of call in GETHS^ORWRP:
 ;                         
 ;   D GETLST^XPAR(.ORHSPARM,"ALL",
 ;                   "ORWRP HEALTH SUMMARY TYPE LIST","N")
 ;                            
 ; Merges Health Summary Parameters for display in the
 ; Health Summary Types on the Reports Tab.  National
 ; Health Summary Types (remote data views) are grouped 
 ; together and added to the list separately.  For a 
 ; National Health Summary Type to be included on the list,
 ; it must first be defined in the parameters file.
 ; The merge of parameters is accomplished by either 
 ; appending or over-writing the parameters to the list.
 ;                            
 ; Input Variables
 ;                    
 ;   GMTSL    Local Array of Health Summary Parameters 
 ;                            
 ;   GMTSCPL  Compile Method
 ;                            
 ;     GMTSCPL=1   <DEFAULT>  Append Parameters to List
 ;     GMTSCPL=0   Overwrite Parameters (by entity)
 ;                            
 ;   GMTSPRE  Precedence of Entities
 ;                            
 ;     Having defined how the list is to be created using
 ;     GMTSCPL (Append or Overwrite), this variable 
 ;     defines the order that each entity will be 
 ;     referenced (first, second, etc.)
 ;                            
 ;       FORMAT   Series of 3 Characters, Uppercase taken
 ;                from the PARAMETER ENTITY file delimited
 ;                by semi-colons
 ;                            
 ;                Default value:  $$DEF^GMTSXAW
 ;                            
LST ; Create List
 ;
 N DIC,DTOUT,DUOUT,GMTSE,GMTSENT,GMTSER,GMTSI,GMTSLI,GMTSLL,GMTSLN
 N GMTSPAR,GMTSYS,GMTSAD,GMTSAR,GMTST,GMTSV,GMTSVAL,GMTSII
 N GMTSUP,GMTSEI,GMTSIV,GMTSEV,GMTSN,GMTSCHK,X,Y
 K ^TMP($J,"GMTSLL"),^TMP($J,"GMTSLN"),^TMP($J,"GMTSTYP")
 S GMTSUSR=+($G(GMTSUSR)) Q:GMTSUSR=0  Q:'$L($$UNM^GMTSXAW3(GMTSUSR))
 S GMTSCPL=$G(GMTSCPL),GMTSPRE=$G(GMTSPRE)
 S:'$L(GMTSCPL) GMTSCPL=0 S:'$L(GMTSPRE) GMTSPRE=$$DEF^GMTSXAW
 S (GMTSPAR,X)="ORWRP HEALTH SUMMARY TYPE LIST"
 S GMTSAD="GMTS HS ADHOC OPTION",GMTSAR="GMTS HS REMOTE ADHOC OPTION"
 S GMTSYS=$$SYSV^GMTSXAW3,GMTSUP=$$UVP^GMTSXAW3(+GMTSUSR),GMTSPAR=+($$PDI^GMTSXAW3(GMTSPAR)) Q:GMTSPAR'>0  S GMTSENT="",U="^"
 D CHK^GMTSXAW(.GMTSCHK,GMTSUSR,"GMTS")
 F  S GMTSENT=$O(^XTV(8989.5,"AC",GMTSPAR,GMTSENT)) Q:GMTSENT=""  D BYE
 K @ROOT D BUILD^GMTSXAB
 K:'$D(GMTSIDX) @ROOT@("B"),@ROOT@("C") S (GMTSI,GMTSN)=0
 F  S GMTSI=$O(@ROOT@(GMTSI)) Q:+GMTSI=0  S GMTSN=GMTSN+1
 S:+GMTSN>0 GMTSL=GMTSN
 K ^TMP($J,"GMTSLL"),^TMP($J,"GMTSLN"),^TMP($J,"GMTSTYP")
 Q 
BYE ;   By Entity
 Q:'$L(GMTSENT)  Q:GMTSENT'[";"  Q:+GMTSENT=0  Q:'$L($P(GMTSENT,";",2))  Q:'$D(GMTSCHK("CHK",GMTSENT))
 S GMTSVAL=$P($G(@(U_$P(GMTSENT,";",2)_+($P(GMTSENT,";",1))_",0)")),U,1)
 Q:'$L(GMTSVAL)  K GMTSL,GMTSER Q:'$L($G(GMTSPAR))  Q:'$L($G(GMTSENT))
 D GETLST^XPAR(.GMTSL,GMTSENT,GMTSPAR,"B",.GMTSER) Q:+($G(GMTSER))>0
 S GMTSLI=0 F  S GMTSLI=$O(GMTSL(GMTSLI)) Q:+GMTSLI=0  D BYP
 Q
BYP ;   By Parameter
 S GMTST=$$ABR^GMTSXAW3(GMTSENT) N GMTSII,GMTSEI,GMTSIV,GMTSEV,GMTSIEN,GMTSVAL,GMTSND,GMTSNM,GMTSHT
 S GMTSII=$P($G(GMTSL(GMTSLI,"N")),"^",1) Q:'$L(GMTSII)
 S GMTSEI=$P($G(GMTSL(GMTSLI,"N")),"^",2) Q:'$L(GMTSEI)
 S GMTSIV=$P($G(GMTSL(GMTSLI,"V")),"^",1) Q:'$L(GMTSIV)
 S GMTSEV=$P($G(GMTSL(GMTSLI,"V")),"^",2) Q:'$L(GMTSEV)
 S GMTST=$S(GMTSPRE["NAT"&(+($G(^GMT(142,+GMTSIV,"VA")))>0):"NAT",1:$G(GMTST))
 S GMTSND=$S(GMTSPRE["NAT"&(+($G(^GMT(142,+GMTSIV,"VA")))>0):"^TMP($J,""GMTSLN"")",1:"^TMP($J,""GMTSLL"")")
 D SAV
 Q
SAV ;   Save Parameters
 N GMTSI Q:'$L($G(GMTSL(GMTSLI,"V")))  S GMTSVAL=GMTSL(GMTSLI,"V"),GMTSHT=+GMTSVAL,GMTSNM=$P(GMTSVAL,"^",2)
 S GMTSI=(+($O(@GMTSND@(" "),-1)+1))
 I GMTSNM=GMTSAD!(GMTSNM=GMTSAR) D SAVD Q
 S @GMTSND@(GMTSI,"N")=$G(GMTSL(GMTSLI,"N"))
 S @GMTSND@(GMTSI,"V")=$G(GMTSVAL)
 S @GMTSND@(GMTSI,"E")=$G(GMTSENT)
 S ^TMP($J,"GMTSTYP",GMTST,GMTSI)=$G(GMTSVAL)
 S:$L(GMTSNM) ^TMP($J,"GMTSTYP",GMTST,"B",GMTSNM,GMTSI)=""
 S:GMTSHT>0 ^TMP($J,"GMTSTYP",GMTST,"C",GMTSHT,GMTSI)=""
 Q
SAVD ;   Save Adhoc and Remote Adhoc Parameters
 N GMTSAT,GMTSC,GMTSI S GMTSND=$G(GMTSND) Q:'$L(GMTSND)  Q:GMTSND="^TMP($J,""GMTSLN"")"
 I GMTSNM=GMTSAD S GMTSI=(+($O(@GMTSND@("ADH"," "),-1)+1)),GMTSAT="ADH"
 I GMTSNM=GMTSAR S GMTSI=(+($O(@GMTSND@("RAD"," "),-1)+1)),GMTSAT="RAD"
 Q:'$L($G(GMTST))  Q:'$L($G(GMTSAT))  Q:'$L($G(GMTSNM))  Q:'$L($G(GMTSVAL))  Q:'$L($G(GMTSHT))  Q:$D(^TMP($J,"GMTSTYP",GMTST,GMTSAT,"B",GMTSNM))
 S @GMTSND@("GMTSAT",GMTSI,"N")=$G(GMTSL(GMTSLI,"N"))
 S @GMTSND@("GMTSAT",GMTSI,"V")=$G(GMTSL(GMTSLI,"V"))
 S @GMTSND@("GMTSAT",GMTSI,"E")=$G(GMTSENT)
 S @GMTSND@("GMTSAT","B",GMTSVAL,GMTSI)=""
 S @GMTSND@("GMTSAT","C",GMTSEI_"^"_GMTSVAL,GMTSI)=""
 S GMTSC=+($O(@GMTSND@("GMTST",GMTSAT," "),-1))+1
 S ^TMP($J,"GMTSTYP",GMTST,GMTSAT,GMTSC)=$G(GMTSVAL)
 S:$L(GMTSNM) ^TMP($J,"GMTSTYP",GMTST,GMTSAT,"B",GMTSNM,GMTSC)=""
 S:GMTSHT>0 ^TMP($J,"GMTSTYP",GMTST,GMTSAT,"C",GMTSHT,GMTSC)=""
 Q
 ;                            
 ; Miscellaneous
NUM(X) ;   Number of Types for User X
 N GMTSUSR,GMTSL,GMTSI,GMTSN S GMTSUSR=+($G(X)),(GMTSI,GMTSN)=0 Q:GMTSUSR=0 0 Q:'$L($$UNM^GMTSXAW3(GMTSUSR)) 0
 D GETLIST(.GMTSL,GMTSUSR) Q:+($G(GMTSL))>0 +($G(GMTSL))
 F  S GMTSI=$O(GMTSL(GMTSI)) Q:+GMTSI=0  S GMTSN=GMTSN+1
 S X=GMTSN Q X
DEF(X) ; Defaults    <compile> ^ <precedence> 
 N DIERR,GMTSUSR,GMTSSIC,GMTSSIP,GMTSSCPL,GMTSPRE
 S GMTSSIC=1,GMTSSIP=$$DEF^GMTSXAW
 S GMTSUSR=+($G(X)),X=""
 Q:+GMTSUSR=0 (GMTSSIC_"^"_GMTSSIP)
 Q:'$L($$UNM^GMTSXAW3(+GMTSUSR)) (GMTSSIC_"^"_GMTSSIP)
 S GMTSCPL=$$GET1^DIQ(142.98,(GMTSUSR_","),10,"I")
 S:GMTSCPL="" GMTSCPL=GMTSSIC
 S GMTSPRE=$$GET1^DIQ(142.98,(GMTSUSR_","),11)
 S:GMTSPRE="" GMTSPRE=GMTSSIP
 S X=GMTSCPL_"^"_GMTSPRE
 Q X
CPL(X) ;   Compile Method
 N DIERR,GMTSITE,GMTSUSR,GMTSCPL S GMTSUSR=+($G(X))
 S GMTSITE=$P($G(^GMT(142.98,"ASITE")),"^",1)
 S GMTSITE=$S($L(GMTSITE):+GMTSITE,1:1) I GMTSUSR=.5 S X=GMTSITE Q X
 S GMTSCPL=$$GET1^DIQ(142.98,(GMTSUSR_","),10,"I")
 S:'$L(GMTSCPL) GMTSCPL=GMTSITE
 S X=GMTSCPL
 Q X
PRE(X) ;   Precedence
 N GMTSUSR,GMTSPRE,GMTSDEF,GMTSC,GMTSI,GMTSA,GMTS S GMTSUSR=+($G(X))
 S (GMTSDEF,X)=$$DEF^GMTSXAW Q:+GMTSUSR=0 X  S GMTSPRE=$$GET1^DIQ(142.98,(GMTSUSR_","),11),GMTSC="^"_$TR($$DEF^GMTSXAW,";","^")_"^"
 S GMTS="" F GMTSI=1:1 Q:GMTSI>$L(GMTSPRE,";")  D
 . S GMTSA=$P($G(GMTSPRE),";",GMTSI) Q:$L(GMTSA)'=3  Q:GMTSA'="NAT"&(GMTSC'[("^"_GMTSA_"^"))  Q:GMTS[(";"_GMTSA)  S GMTS=GMTS_";"_GMTSA
 S GMTSPRE=$$TRIM^GMTSXA(GMTS,";") S:'$L(GMTSPRE) GMTSPRE=GMTSDEF
 S X=GMTSPRE
 Q X
