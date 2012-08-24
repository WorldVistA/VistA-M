LEX2076P ;ISL/KER - LEX*2.0*76 Pre/Post Install ;06/09/2010
 ;;2.0;LEXICON UTILITY;**76**;Sep 23, 1996;Build 3
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
 . S LEXSQ=+($P(LEXX,";;",3)) S:+LEXSQ>0 LEXPS=LEXPS_" SEQ #"_LEXSQ S LEXC=LEXC+1 D:LEXC=1 MES^XPDUTL(" ") D IPU(LEXPS)
 D:LEXC>0 MES^XPDUTL(" ")
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
 ;;ICPT*6.0*55;;
 ;;;;;;
PRE ; Pre-Install              (N/A for this patch)
 Q
CON ; Conversion of data       
 D C1,C2
 Q
C1 ;   Change 1 - 454057 - CVA/Stroke re-coded to ICD 434.91
 N DA,DIK,SHORT,EFF S SHORT="AC ILL-DEF CERBROVSC DIS",EFF=3041001
 K DA,DIK S DA=10200,DIK="^LEX(757.02," D IX2^DIK S ^LEX(757.02,DA,0)="9644^434.91^1^1947^0^^0" S DA=10200,DIK="^LEX(757.02," D IX1^DIK
 K DA,DIK S DA=10207,DIK="^LEX(757.02," D IX2^DIK S ^LEX(757.02,DA,0)="9646^434.91^1^1947^0^^0" S DA=10207,DIK="^LEX(757.02," D IX1^DIK Q
 K DA,DIK S DA=9069,DIK="^ICD9(" D IX2^DIK S ^ICD9(DA,0)="436.^HJCVs^"_SHORT_"^^1^^1^^^^^^^15^124^2781001"
 S ^ICD9(DA,67,0)="^80.067D^2^2",^ICD9(DA,67,2,0)=EFF_"^"_SHORT
 K DA,KIK S DA=9069,DIK="^ICD9(" D IX1^DIK
 Q
C2 ;   CChange 2 - Modifier File Description
 S ^DIC(81.3,"%D",0)="^^10^10^2940502^^^^"
 S ^DIC(81.3,"%D",1,0)="This table file contains the procedural coding modifiers.  Modifiers are"
 S ^DIC(81.3,"%D",2,0)="used to indicate that a service or procedure that has been performed has"
 S ^DIC(81.3,"%D",3,0)="been altered by some specific circumstance but not changed in its"
 S ^DIC(81.3,"%D",4,0)="definition or code."
 S ^DIC(81.3,"%D",5,0)=" "
 S ^DIC(81.3,"%D",6,0)="If an entry needs to be added, modified or deleted a patch will be issued"
 S ^DIC(81.3,"%D",7,0)="instructing the site how to make the change.  Otherwise, this table file"
 S ^DIC(81.3,"%D",8,0)="should not be edited in anyway by the site."
 S ^DIC(81.3,"%D",9,0)=" "
 S ^DIC(81.3,"%D",10,0)="Per VHA Directive 10-93-142, this file definition should not be modified."
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
