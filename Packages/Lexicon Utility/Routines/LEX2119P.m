LEX2119P ;ISL/AEB - LEX*2.0*119 Pre/Post Install ;07/16/2018
 ;;2.0;LEXICON UTILITY;**119**;Sep 23, 1996;Build 5
 ;               
 ; Global Variables 
 ;    ^LEXM(              N/A
 ;               
 ; External References
 ;    ^DIC                ICR  10006
 ;    $$NOW^XLFDT         ICR  10103
 ;    $$PKGPAT^XPDIP      ICR   2067
 ;    MES^XPDUTL          ICR  10141
 ;    $$SITE^VASITE       ICR  10112
 ;    SENDMSG^XMXAPI      ICR   2729
 ;    $$NS^XUAF4          ICR   2171   
 ;    $$PROD^XUPROD       ICR   4440 
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
 ; Note:  All references to the patch number should be
 ;        checked and updated as necessary.
 ;   
 ;        The sub-routine (Informational Patch List) must
 ;        be updated with each patch.  It should include
 ;        (as a minimum) the patch names of all of the 
 ;        informational patches associated with the Lexicon
 ;        Patch.  This will update the Package file at the
 ;        site.
 ;  
 ;  Code insert to check for errant DD node in file #757 - tjh
 ;
 ;
 I $D(^DD(757,"B","PARENT"))!$D(^DD(757,"GL","PARENT"))!$D(^DD(757,"SB")) D
 .N FACNAME,FACNUM,FACPTR,HDISVFLG,HDISVTO,MSGTXT,PROD,STATDT,SUBJ,TYPE
 .S STATDT=$$FMTE^XLFDT($$NOW^XLFDT())
 .S PROD=$$PROD^XUPROD
 .S TYPE=$S(PROD=1:"PRODUCTION",1:"TEST")
 .;Get facility number and name of current location
 .S FACPTR=+$$SITE^VASITE()
 .S FACNUM=$P($$NS^XUAF4(FACPTR),"^",2)
 .S FACNAME=$P($$NS^XUAF4(FACPTR),"^",1)
 .;Build/send message
 .S SUBJ="Site: "_FACNUM_" in "_TYPE_" #757 DD Error"
 .;Deliver to STS staff
 .S HDISVTO("VHALEX@domain.ext")=""
 .;Unrestricted addressing
 .S MSGTXT=$NA(^TMP("HDISVAP1",$JOB,"MSGTXT"))
 .K @MSGTXT
 .S @MSGTXT@(1)="Data dictionary error (#757)"
 .S @MSGTXT@(2)=""
 .S @MSGTXT@(3)="Facility Name/Number: "_$G(FACNAME)_" - "_$G(FACNUM)
 .S @MSGTXT@(4)="  This is a "_$S(TYPE:"Production",1:"Test")_" system."
 .S @MSGTXT@(5)="Date/Time: "_$G(STATDT)
 .S @MSGTXT@(6)="Errant file #757 data dictionary"
 .S @MSGTXT@(7)=""
 .S HDISVFLG("ADDR FLAGS")="R"
 .;Message is info only
 .S HDISVFLG("FLAGS")="I"
 .;Message sender
 .S HDISVFLG("FROM")="Lexicon Patch #119 Install"
 .;Send message
 .D SENDMSG^XMXAPI(DUZ,SUBJ,MSGTXT,.HDISVTO,.HDISVFLG,.HDISVXMZ)
 .K @MSGTXT
 ;
 ;  End DD check
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
IPL ;   Patch List  ;;Patch;;Sequence # This is also where you would include the ICD patch number.
 ;;ICPT*6.0*86;;
 ;;ICD*18.0*95;;
 ;;;;;;
 Q
PRE ; Pre-Install              (N/A for this patch)
 Q
CON ; Conversion of data
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
