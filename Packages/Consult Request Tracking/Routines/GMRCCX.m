GMRCCX ;SFVAMC/DAD - Consult Closure Tool: Config File Utilities ;01/20/17 15:19
 ;;3.0;CONSULT/REQUEST TRACKING;**89**;DEC 27, 1997;Build 62
 ;Consult Closure Tool
 ;
 ; IA#   Usage      Component
 ; --------------------------
 ; 1058  Private    MDEL^DDSUTL
 ; 1058  Private    MLOAD^DDSUTL
 ; 2051  Supported  LIST^DIC
 ; 2052  Supported  $$GET1^DID
 ; 2053  Supported  UPDATE^DIE
 ; 2054  Supported  CLEAN^DILF
 ;
LOOKUP(GMX,GM0,GMFILE) ;
 ; *** Process additions/deletions [-]XXX*
 ; Called from the pre-lookup transform nodes
 ; ^DD(123.0331 -> 123.0336,.01,7.5)
 N GMFDA,GMIEN,GMLST,D0,D1,DA,DIC,DIERR
 N DIHELP,DIMSG,DUOUT,DIRUT,DIROUT,DO,DTOUT,X,Y
 I ($G(GMX)?1.E1"*"),($G(GM0)>0) D
 . S GMLST=$NA(^TMP("DILIST",$J))
 . S GMFDA=$NA(^TMP("GMCTR-FDA",$J))
 . S GMIEN=$NA(^TMP("GMCTR-IEN",$J))
 . K @GMLST,@GMFDA,@GMIEN
 . I $E(GMX)="-" D
 .. D DEL(.GMX,GM0,GMFILE)
 .. Q
 . E  D
 .. D ADD(.GMX,GM0,GMFILE)
 .. Q
 . K @GMLST,@GMFDA,@GMIEN
 . Q
 Q
 ;
ADD(GMX,GM0,GMFILE) ;
 ; *** Process additions XXX* (Copy/Mod of LOOKE^XPDET)
 N GMDATA,GMIENS,GMINDX,GMPOIN,GMSCRN
 S GMPOIN=$$GET1^DID(GMFILE,.01,"","SPECIFIER")
 S GMPOIN=$TR(GMPOIN,$TR(GMPOIN,"0123456789."))
 S GMSCRN=$$DICS(GMFILE)
 S GMX=$P(GMX,"*",1)
 D LIST^DIC(GMPOIN,"","","","*","",GMX,"",GMSCRN)
 I $G(@GMLST@(0))>0 D
 . S GMINDX=0
 . F  S GMINDX=$O(@GMLST@(2,GMINDX)) Q:GMINDX'>0  D
 .. S GMDATA=$G(@GMLST@(2,GMINDX))
 .. I GMDATA>0 D
 ... S GMIENS="?+"_GMINDX_","_GM0_","
 ... S @GMFDA@(GMFILE,GMIENS,.01)=GMDATA
 ... S @GMIEN@(GMINDX)=GMDATA
 ... Q
 .. Q
 . I $D(@GMFDA) D
 .. D UPDATE^DIE("",GMFDA,GMIEN)
 .. I '$D(DIERR),$D(DDS),$D(@GMIEN) D MLOAD^DDSUTL(GMIEN)
 .. D CLEAN^DILF
 .. Q
 . S GMX=""
 . Q
 E  D
 . K GMX
 . Q
 Q
 ;
DEL(GMX,GM0,GMFILE) ;
 ; *** Process deletions -XXX* (Copy/Mod of DEL^XPDET)
 N GM1,GMIENS,GMINDX
 S GMX=$P(GMX,"*",1),GMX=$E(GMX,2,$L(GMX)-1)
 D LIST^DIC(GMFILE,","_GM0_",","","","*","",GMX)
 I $G(@GMLST@(0))>0 D
 . S GMINDX=0
 . F  S GMINDX=$O(@GMLST@(2,GMINDX)) Q:GMINDX'>0  D
 .. S GM1=$G(@GMLST@(2,GMINDX))
 .. I GM1>0 D
 ... S GMIENS=GM1_","_GM0_","
 ... S @GMFDA@(GMFILE,GMIENS,.01)="@"
 ... Q
 .. Q
 . I $D(@GMFDA) D
 .. D UPDATE^DIE("",GMFDA)
 .. I '$D(DIERR),$D(DDS) D MDEL^DDSUTL($NA(@GMLST@(2)))
 .. D CLEAN^DILF
 .. Q
 . S GMX=""
 . Q
 E  D
 . K GMX
 . Q
 Q
 ;
DICS(GMFILE) ;
 ; *** DIC("S") data screens
 ; Called from ADD^GMRCCX and
 ; ^DD(123.0331 -> 123.0336,.01,0 & 12.1)
 N GMSCRN
 ; Disabled consult services are not selectable
 S GMSCRN(123.0331)="I $P(^(0),U,2)'=9"
 ; Inactive consult procedures are not selectable
 S GMSCRN(123.0332)="I $P(^(0),U,2)'>0"
 ; Only consult order items are selectable
 S GMSCRN(123.0333)="I ($P(^(0),U,3)="""")&(^(0)?1""GMRC""1(1""R"",1""T"").E)"
 ; Only active clinical procedures are selectable
 S GMSCRN(123.0334)="I $P(^(0),U,9)=1"
 ; Only clinics are selectable
 S GMSCRN(123.0335)="I $P(^(0),U,3)=""C"""
 ; Only titles are selectable
 S GMSCRN(123.0336)="I $P(^(0),U,4)=""DOC"""
 Q $G(GMSCRN(+$G(GMFILE)),"I 1")
 ;
