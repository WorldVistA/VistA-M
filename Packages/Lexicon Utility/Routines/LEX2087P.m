LEX2087P ;ISL/KER - LEX*2.0*87 Pre/Post Install ;06/14/2014
 ;;2.0;LEXICON UTILITY;**87**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables 
 ;    ^LEXM(              N/A
 ;               
 ; External References
 ;    ^DIC                ICR  10006
 ;    $$NOW^XLFDT         ICR  10103
 ;    $$PKGPAT^XPDIP      ICR   2067
 ;    MES^XPDUTL          ICR  10141
 ;               
 Q
POST ; Post-Install
 ;            
 ; From IMP in the Environment Check
 ;            
 ;      LEXBUILD   Build Name - LEX*2.0*nn
 ;      LEXPTYPE   Patch Type - Remedy or Quarterly
 ;      LEXFY      Fiscal Year - FYnn
 ;      LEXQTR     Quarter - 1st, 2nd, 3rd, or 4th
 ;      LEXIGHF    Name of Host File - LEX_2_nn.GBL
 ;      LEXLREV    Revision - nn
 ;      LEXREQP    Required Builds - build;build;build
 ;      
 ; Note:  The section IPL (Informational Patch List) must
 ;        be updated with each patch
 ;            
 N LEXEDT,LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXB,LEXCD,LEXSTR,LEXLAST,LEXOK,X,Y S LEXOK=0 D IMP
 S LEXEDT=$G(^LEXM(0,"CREATED")) D:LEXOK>0 LOAD,CON,IP
 Q
LOAD ; Load Data
 ;             
 ;      LEXSHORT   Send Short Message
 ;      LEXMSG     Flag to send Message
 ;            
 N LEXSHORT,LEXMSG S LEXSHORT="",LEXMSG=""
 S LEXSTR=$G(LEXPTYPE) S:$L($G(LEXFY))&($L($G(LEXQTR))) LEXSTR=LEXSTR_" for "_$G(LEXFY)_" "_$G(LEXQTR)_" Quarter"
 S U="^",LEXB=$G(^LEXM(0,"BUILD")) Q:LEXB=""  Q:$G(LEXBUILD)=""
 D:LEXB=LEXBUILD EN^LEXXGI
LQ ; Load Quit
 D KLEXM
 Q
 ;             
KLEXM ; Subscripted Kill of ^LEXM
 H 2 N DA S DA=0 F  S DA=$O(^LEXM(DA)) Q:+DA=0  K ^LEXM(DA)
 N LEX S LEX=$G(^LEXM(0,"PRO")) K ^LEXM(0)
 Q
 ;
IP ; Informational Patches
 N LEX,LEXP,LEXPS,LEXSQ,LEXT,LEXI,LEXE,LEXX,LEXC,LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXSUB,LEXOK D IMP S LEXSUB=""
 I $G(LEXPTYPE)="Code Set Update",$G(LEXFY)["FY",$L($G(LEXQTR)) S LEXSUB="Code Set "_LEXFY_" "_LEXQTR_" Qtr Update"
 S LEXC=0 F LEXI=1:1 D  Q:'$L(LEXX)
 . S LEXX="" S LEXE="S LEXX=$T(IPL+"_LEXI_")" X LEXE S:'$L($TR($G(LEXX),";","")) LEXX="" Q:'$L(LEXX)  S LEXPS=$P(LEXX,";;",2) S:$L(LEXPS,"*")=3 LEXC=LEXC+1
 I LEXC>0 S LEXT=" Informational Patch"_$S(+($G(LEXC))>1:"es",1:"") S:$L(LEXSUB) LEXT=LEXT_" for the "_LEXSUB S LEXT=LEXT_":" D MES^XPDUTL(LEXT)
 S LEXC=0 F LEXI=1:1 D  Q:'$L(LEXX)
 . S LEXX="" S LEXE="S LEXX=$T(IPL+"_LEXI_")" X LEXE S:'$L($TR($G(LEXX),";","")) LEXX="" Q:'$L(LEXX)  S LEXPS=$P(LEXX,";;",2) S:'$L(LEXPS) LEXX="" Q:'$L(LEXX)
 . S LEXSQ=+($P(LEXX,";;",3)) S:+LEXSQ>0 LEXPS=LEXPS_" SEQ #"_LEXSQ S LEXC=LEXC+1 D:LEXC=1 MES^XPDUTL(" ")
 . W:$D(LEXTEST) !,?5,LEXPS D:'$D(LEXTEST) IPU(LEXPS)
 D:LEXC>0 MES^XPDUTL(" ") N LEXTEST
 Q
IPU(X) ;   Patch Update
 N LEXID,LEXOP,LEXPC,LEXPK,LEXPKI,LEXPN,LEXPTI,LEXSQ,LEXT,LEXVR,LEXVRI,LEXAR
 S LEXPC=$G(X),LEXSQ=$P(LEXPC," ",2,299),LEXID=$P(LEXPC," ",1),LEXOP=""
 S LEXPK=$S($P(LEXPC,"*",1)="ICD":"DRG GROUPER",$P(LEXPC,"*",1)="ICPT":"CPT/HCPCS CODES",$P(LEXPC,"*",1)="LEX":"LEXICON UTILITY",1:"") Q:'$L(LEXPK)
 S LEXPKI=$$PIEN(LEXPK) Q:+LEXPKI'>0  S LEXVR=$P(LEXPC,"*",2) Q:'$L(LEXVR)  Q:LEXVR'["."  S LEXPN=$P(LEXPC,"*",3) Q:'$L(LEXPN)  Q:+LEXPN'>0
 S LEXAR=LEXPN_"^"_$$NOW^XLFDT_"^"_$G(DUZ)
 I $L($G(LEXBUILD)) S LEXOP=$$PKGPAT^XPDIP(LEXPKI,LEXVR,.LEXAR)
 S LEXVRI=$P(LEXOP,"^",1),LEXPTI=$P(LEXOP,"^",2)
 S LEXT="   "_LEXID,LEXT=LEXT_$J(" ",(17-$L(LEXT)))_LEXSQ,LEXT=LEXT_$J(" ",(28-$L(LEXT)))_LEXPK
 I $L(LEXOP),LEXPTI>0 S LEXT=LEXT_$J(" ",(46-$L(LEXT)))_"Patch History updated" D MES^XPDUTL(LEXT)
 I $L(LEXOP),LEXPTI'>0 S LEXT=LEXT_$J(" ",(46-$L(LEXT)))_"Patch History not updated" D MES^XPDUTL(LEXT)
 I '$L(LEXOP) D MES^XPDUTL(LEXT)
 Q
IPL ;   Patch List  ;;Patch;;Sequence #
 ;;ICD*18.0*68;;
 ;;;;;;
PRE ; Pre-Install              (N/A for this patch)
 Q
CON ; Conversion of data       (Post-Install Environment Check)
 D BMES^XPDUTL(" Converting DRG data to use Oct 1, 2015") D ICD9,ICD,ICDRS
 D POST^LEX2087A
 Q
ICD9 ; ICD9 Global
 N DA,DIK
 S DA(2)=502758,DA(1)=1,DA=2,DIK="^ICD9("_DA(2)_",68,"_DA(1)_",2,"
 I $D(^ICD9(DA(2),68,DA(1),2,DA,0)) D ^DIK
 S DA(2)=502758,DA(1)=1,DA=3,DIK="^ICD9("_DA(2)_",68,"_DA(1)_",2,"
 I $D(^ICD9(DA(2),68,DA(1),2,DA,0)) D ^DIK
 K ^ICD9("D","HYPERTENSION",502758,3141001,1,2)
 K ^ICD9("D","HYPERTENSIVE",502758,3141001,1,3)
 K ^ICD9("AD",30,"HYPERTENSION",502758,3141001,1,2)
 K ^ICD9("AD",30,"HYPERTENSIVE",502758,3141001,1,3)
 Q
ICD ; ICD global
 N LEXI,LEX9,LEX10 S LEX9=3141001,LEX10=3151001
 S LEXI=0 F  S LEXI=$O(^ICD(LEXI)) Q:+LEXI'>0  D
 . N LEXH S LEXH=0 F  S LEXH=$O(^ICD(LEXI,2,LEXH)) Q:+LEXH'>0  D
 . . N LEXD,LEXT,DA,DIK S LEXD=$P($G(^ICD(LEXI,2,LEXH,0)),"^",1)
 . . S LEXT=$P($G(^ICD(LEXI,2,LEXH,0)),"^",3) Q:LEXT'["ICD10"
 . . Q:LEXD'=LEX9  S DA=LEXI,DIK="^ICD(" D IX2^DIK
 . . S $P(^ICD(LEXI,2,LEXH,0),"^",1)=LEX10 D IX1^DIK
 Q
ICDRS ;
 N LEXI,LEX9,LEX10 S LEX9=3141001,LEX10=3151001
 S LEXI=0 F  S LEXI=$O(^ICDRS(LEXI)) Q:+LEXI'>0  D
 . N LEXD,DA,DIK S LEXD=$P($G(^ICDRS(LEXI,0)),"^",1)
 . Q:LEXD'=LEX9  S DA=LEXI,DIK="^ICDRS(" D IX2^DIK
 . S $P(^ICDRS(LEXI,0),"^",1)=LEX10 D IX1^DIK
 Q
 ;            
 ; Miscellaneous
PIEN(X) ;   Package IEN
 N DIC,DTOUT,DTOUT,Y S X=$G(X),DIC="^DIC(9.4,",DIC(0)="B" D ^DIC S X=+Y
 Q X
IMP ;   Call IMP in Environment Check
 K LEXBUILD,LEXFY,LEXIGHF,LEXLREV,LEXPTYPE,LEXQTR,LEXREQP N LEXF
 S LEXF=$P($T(+1)," ",1) S:$E(LEXF,$L(LEXF))="P" LEXF=$E(LEXF,1,($L(LEXF)-1)) Q:'$L(LEXF)
 S LEXF="IMP^"_LEXF Q:'$L($T(@LEXF))  D @LEXF S:$L(LEXBUILD) LEXOK=1
 Q
