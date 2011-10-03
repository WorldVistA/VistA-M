LEX2053P ;ISL/KER - LEX*2.0*53 Pre/Post Install ;06/06/2007
 ;;2.0;LEXICON UTILITY;**53**;Sep 23, 1996;Build 18
 ;              
 ; Variables NEWed or KILLed Elsewhere
 ;    None
 ;              
 ; Global Variables
 ;    ^LEXM
 ;              
 ; External References
 ;    None
 ;              
 Q
POST ; LEX*2.0*53 Post-Install
 ;            
 ; From IMP^LEX2053
 ;            
 ;      LEXBUILD   Build Name - LEX*2.0*nn
 ;      LEXPTYPE   Patch Type - Remedy or Quarterly
 ;      LEXFY      Fiscal Year - FYnn
 ;      LEXQTR     Quarter - 1st, 2nd, 3rd, or 4th
 ;      LEXIGHF    Name of Host File - LEX_2_nn.GBL
 ;      LEXLREV    Revision - nn
 ;      LEXREQP    Required Builds - build;build;build
 ;            
 N LEXEDT,LEXPTYPE,LEXLREV,LEXREQP,LEXBUILD,LEXIGHF,LEXFY,LEXQTR,LEXB,LEXCD,LEXRTN,LEXSTR,LEXSUBJ,LEXLAST D IMP^LEX2053
 S LEXEDT=$G(^LEXM(0,"CREATED")) D CON,LOAD
 I $D(^%ZOSF("DEL")) S LEXRTN="LEX2053A" D
 . N EXC,X,Y I +($$ROK(LEXRTN))>0 S (EXC,X)=$G(^%ZOSF("DEL")) D ^DIM I $D(X) S X=LEXRTN X EXC
 Q
LOAD ; Load Data from export global ^LEXM
 ;             
 ;      LEXSHORT   Send Short Message
 ;      LEXMSG     Flag to send Message
 ;            
 N LEXSHORT,LEXMSG S LEXSHORT="",LEXMSG=""
 S LEXSTR=$G(LEXPTYPE) S:$L($G(LEXFY))&($L($G(LEXQTR))) LEXSTR=LEXSTR_" for "_$G(LEXFY)_" "_$G(LEXQTR)_" Quarter"
 S U="^",LEXB=$G(^LEXM(0,"BUILD")) Q:LEXB=""  Q:LEXBUILD=""
 D:LEXB=LEXBUILD EN^LEXXGI
LQ ; Load Quit
 D KLEXM
 Q
 ;             
KLEXM ; Subscripted Kill of ^LEXM
 N I S I="" F  S I=$O(^LEXM(I)) Q:'$L(I)  K ^LEXM(I)
 Q
 ;            
PRE ; LEX*2.0*53 Pre-Install   (N/A for patch 53)
 Q
RX ; Re-Index
 N Y,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTRTN,ZTREQ,ZTQUEUED
 S ZTRTN="RXT^LEX2053P",ZTDESC="Re-Index CPT Modifier file 81.3",ZTIO="",ZTDTH=$H D ^%ZTLOAD
 D:+($G(ZTSK))>0 BMES^XPDUTL((" Re-Indexing CPT Modified file 81.3 (Task #"_+($G(ZTSK))_")"))
 D HOME^%ZIS K Y,ZTSK,ZTDESC,ZTDTH,ZTIO,ZTSAVE,ZTRTN
 Q
RXT ; Re-Index (tasked)
 S:$D(ZTQUEUED) ZTREQ="@" N MIEN,DA,DIK S MIEN=0 F  S MIEN=$O(^DIC(81.3,MIEN)) Q:+MIEN'>0  D
 . K ^DIC(81.3,MIEN,10,"B"),^DIC(81.3,MIEN,"M")
 . N RIEN S RIEN=0 F  S RIEN=$O(^DIC(81.3,MIEN,10,RIEN)) Q:+RIEN'>0  D
 . . N DA,DIK S DA(1)=MIEN,DA=RIEN,DIK="^DIC(81.3,"_DA(1)_",10," D IX1^DIK
 . K DA S DA=MIEN,DIK="^DIC(81.3," D IX1^DIK
 F DA=3,11,46,47 S DIK="^DIC(81.3," D IX1^DIK
 F DA=643,644,645,646,647 S DIK="^DIC(81.3," D IX1^DIK
 Q
ROK(X) ; Routine OK
 S X=$G(X) Q:'$L(X) 0  Q:$L(X)>8 0  X ^%ZOSF("TEST") Q:$T 1
 Q 0
CON ; Conversion of data    
 D EN^LEX2053A
 Q
