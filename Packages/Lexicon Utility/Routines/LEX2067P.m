LEX2067P ;ISL/KER - LEX*2.0*67 Pre/Post Install ;06/03/2009
 ;;2.0;LEXICON UTILITY;**67**;Sep 23, 1996;Build 4
 ;              
 ; Variables NEWed or KILLed Elsewhere
 ;    LEXTEST           Variable used for testing only
 ;                      This variable is not set
 ;               
 ; Global Variables
 ;    ^LEX(             N/A
 ;    ^LEXM(            N/A
 ;               
 ; External References
 ;    IX1^DIK             ICR  10013
 ;    $$NOW^XLFDT         ICR  10103
 ;    BMES^XPDUTL         ICR  10141
 ;    HOME^%ZIS           ICR  10086
 ;    ^%ZTLOAD            ICR  10063
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
 N LEXEDT,LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXB,LEXCD,LEXSTR,LEXLAST,LEXOK S LEXOK=0 D IMP
 S LEXEDT=$G(^LEXM(0,"CREATED")) D:LEXOK>0 LOAD D CON
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
PRE ; Pre-Install              (N/A for this patch)
 Q
 ;            
CON ; Conversion of data
 N LEXTX,Y,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTQUEUED,ZTREQ
 S LEXTX=" Fixing ""AVA"" cross-reference in the CODE file #757.02  " D BMES^XPDUTL(LEXTX)
 K ^LEX(757.02,"AVA","482.41 "),^LEX(757.02,"AVA","041.11 ")
 N DA,DIK S DIK="^LEX(757.02," F DA=304492,316463,316464,332669,318848,332656 D IX1^DIK
 S ZTRTN="CONT^LEX2067P",ZTDESC="Fixing AVA Cross-Reference File #757.02",ZTIO="",ZTDTH=$H D ^%ZTLOAD D HOME^%ZIS
 Q
CONT ;
 N DA,DIK,LEXBEG,LEXCK,LEXDIF,LEXELP,LEXEND,LEXERR,LEXERRT,LEXFI,LEXIDX,LEXIDXT,LEXIEN,LEXNDS,LEXOK,LEXSO,LEXSTR,LEXTC,LEXTX
 N LEXFI,LEXTX S LEXFI="757.02" S LEXTX=" Fixing ""AVA"" cross-reference in the CODE file #757.02  "
 S LEXCK="^ICD^10D^ICP^10P^CPT^CPC^DS4^NAN^HHC^NIC^SNM^SM3^OMA^SCC^",LEXBEG=$$NOW^XLFDT,(LEXNDS,LEXERR)=0
 S LEXSTR="",LEXFI=757.02,LEXIDX="AVA",LEXIDXT="^LEX(757.02,""AVA"",CODE,EXP,SAB,IEN)"
 N LEXQUIET S LEXQUIET=""
 F  S LEXSTR=$O(^LEX(LEXFI,LEXIDX,LEXSTR)) Q:'$L(LEXSTR)  D
 . N LEXEXP S LEXEXP=0  F  S LEXEXP=$O(^LEX(LEXFI,LEXIDX,LEXSTR,LEXEXP)) Q:+LEXEXP'>0  D
 . . N LEXSAB S LEXSAB="" F  S LEXSAB=$O(^LEX(LEXFI,LEXIDX,LEXSTR,LEXEXP,LEXSAB)) Q:'$L(LEXSAB)  D
 . . . N LEXIEN S LEXIEN=0 F  S LEXIEN=$O(^LEX(LEXFI,LEXIDX,LEXSTR,LEXEXP,LEXSAB,LEXIEN)) Q:+LEXIEN'>0  D
 . . . . N LEXOK,LEXSO,LEXEX,LEXSR,LEXSB S LEXNDS=LEXNDS+1
 . . . . S LEXEX=$P($G(^LEX(757.02,+LEXIEN,0)),"^",1),LEXSO=$P($G(^LEX(757.02,+LEXIEN,0)),"^",2)
 . . . . S LEXSR=$P($G(^LEX(757.02,+LEXIEN,0)),"^",3),LEXSB=$E($P($G(^LEX(757.03,+LEXSR,0)),"^",1),1,3)
 . . . . I $L(LEXSAB)'=3!(LEXCK'[("^"_LEXSAB_"^")) D  Q
 . . . . . S LEXERR=LEXERR+1 K:'$D(LEXTEST) ^LEX(LEXFI,LEXIDX,LEXSTR,LEXEXP,LEXSAB,LEXIEN)
 . . . . . I '$D(ZTQUEUED) W:'$D(LEXQUIET) !,?8,LEXFI,?19,LEXIDX,?26,LEXSTR,?48,"  ",LEXIEN,?58,"Invalid Source ",$G(LEXSAB)
 . . . . I '$L(LEXEX)!('$L(LEXSO))!($L(LEXSB)'=3) D  Q
 . . . . . S LEXERR=LEXERR+1 K:'$D(LEXTEST) ^LEX(LEXFI,LEXIDX,LEXSTR,LEXEXP,LEXSAB,LEXIEN)
 . . . . . I '$D(ZTQUEUED),'$L(LEXEX) W:'$D(LEXQUIET) !,?8,LEXFI,?19,LEXIDX,?26,LEXSTR,?48,"  ",LEXIEN,?58,"Invalid Expression (null)"
 . . . . . I '$D(ZTQUEUED),'$L(LEXSO) W:'$D(LEXQUIET) !,?8,LEXFI,?19,LEXIDX,?26,LEXSTR,?48,"  ",LEXIEN,?58,"Invalid Code (null)"
 . . . . . I '$D(ZTQUEUED),$L(LEXSB)'=3 W:'$D(LEXQUIET) !,?8,LEXFI,?19,LEXIDX,?26,LEXSTR,?48,"  ",LEXIEN,?58,"Invalid Source ",$G(LEXSB)
 . . . . S LEXOK=1 S:LEXSTR='(LEXSO_" ") LEXOK=0 S:LEXEXP'=LEXEX LEXOK=0 S:LEXSAB'=LEXSB LEXOK=0 I 'LEXOK D
 . . . . . S LEXERR=LEXERR+1 K:'$D(LEXTEST) ^LEX(LEXFI,LEXIDX,LEXSTR,LEXEXP,LEXSAB,LEXIEN)
 . . . . . S:$L(LEXSO)&($L(LEXEX))&($L(LEXSB))&(LEXCK[("^"_LEXSB_"^")) ^LEX(LEXFI,LEXIDX,(LEXSO_" "),LEXEX,LEXSB,LEXIEN)=""
 . . . . . I '$D(ZTQUEUED) W:'$D(LEXQUIET) !,?8,LEXFI,?19,LEXIDX,?26,LEXSTR,?48,"  ",LEXIEN,?58,"Data doesn't match Record"
 S LEXIEN=0 F  S LEXIEN=$O(^LEX(LEXFI,LEXIEN)) Q:+LEXIEN'>0  D
 . N DA,DIK,LEXEX,LEXSO,LEXSR,LEXSB S DA=LEXIEN,LEXSR=$P($G(^LEX(LEXFI,+DA,0)),"^",3),LEXSO=$P($G(^LEX(LEXFI,DA,0)),U,2)
 . S LEXEX=$P($G(^LEX(LEXFI,DA,0)),U,1),LEXSB=$E($P($G(^LEX(757.03,+LEXSR,0)),"^",1),1,3) Q:$L(LEXSB)'=3  Q:'$L(LEXSO)  Q:+LEXEX'>0
 . I LEXCK[("^"_LEXSB_"^"),'$D(^LEX(757.02,"AVA",(LEXSO_" "),LEXEX,LEXSB,DA)) D
 . . S LEXERR=LEXERR+1 I '$D(ZTQUEUED) W:'$D(LEXQUIET) !,?8,LEXFI,?19,LEXIDX,?30,"Missing ",LEXSO,"/",LEXSB,?58,"  ",DA
 . . S:'$D(LEXTEST) ^LEX(757.02,"AVA",(LEXSO_" "),LEXEX,LEXSB,DA)=""
 . I LEXCK'[("^"_LEXSB_"^"),$D(^LEX(757.02,"AVA",(LEXSO_" "),LEXEX,LEXSB,DA)) D
 . . S LEXERR=LEXERR+1
 . . I '$D(ZTQUEUED) W:'$D(LEXQUIET) !,?8,LEXFI,?19,LEXIDX,?26,LEXSO,?48,"  ",DA,?58,"Invalid Source" W:'$D(LEXTEST)&('$D(LEXQUIET)) " - Deleted"
 . . K:'$D(LEXTEST) ^LEX(757.02,"AVA",(LEXSO_" "),LEXEX,LEXSB,DA)
 S LEXERR=$S(+LEXERR>0:LEXERR,1:"") I '$D(ZTQUEUED),+LEXERR>0 W:'$D(LEXQUIET) !,+LEXERR," Error",$S(+LEXERR>1:"s",1:"")," found"
 Q
IMP ; Call IMP in Environment Check
 K LEXBUILD,LEXFY,LEXIGHF,LEXLREV,LEXPTYPE,LEXQTR,LEXREQP N LEXF
 S LEXF=$P($T(+1)," ",1) S:$E(LEXF,$L(LEXF))="P" LEXF=$E(LEXF,1,($L(LEXF)-1)) Q:'$L(LEXF)
 S LEXF="IMP^"_LEXF Q:'$L($T(@LEXF))  D @LEXF S:$L(LEXBUILD) LEXOK=1
 Q
