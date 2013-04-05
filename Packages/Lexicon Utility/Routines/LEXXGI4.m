LEXXGI4 ;ISL/KER - Global Import (Repair at Site) ;07/08/2012
 ;;2.0;LEXICON UTILITY;**51**;Sep 23, 1996;Build 77
 ;              
 ; Global Variables
 ;    ^TMP("LEXXGI4"      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    HOME^%ZIS           ICR  10086
 ;    ^%ZTLOAD            ICR  10063
 ;    ^DIK                ICR  10013
 ;    IX1^DIK             ICR  10013
 ;    $$UP^XLFSTR         ICR  10104
 ;    BMES^XPDUTL         ICR  10141
 ;    MES^XPDUTL          ICR  10141
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    LEXLOUD   NEWed, SET and KILLed in the Post-Install
 ;              routine LEX20nnP.  If set, the entry 
 ;              points ASL, AWRD, SSWRD and SUB will write
 ;              to the screen using MES^XPDUTL.
 ;     
AWRD ; Repair Word Index AWRD in Expression file #757.01
 N Y,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTQUEUED,ZTREQ S ZTRTN="AWRDT^LEXXGI4"
 S ZTDESC="Repair AWRD index in Expression file #757.01"
 S ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS I $D(LEXLOUD) D
 . S LEXT="  Re-Index the AWRD index of file #757.01 tasked"
 . S:+($G(ZTSK))>0 LEXT=LEXT_" (#"_+($G(ZTSK))_")" D MES^XPDUTL(LEXT)
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
AWRDT ;   Repair Word Index AWRD in Expression file #757.01 (task)
 ;     Subset Indexes Axxx
 N DA,DIK D SSWRD^LEXXGI4
 ;     Main Word AWRD Index
 S DIK="^LEX(757.01,",DIK(1)="2^AWRD" D ENALL^DIK
 ;     Replacement Words
 K DA S DIK="^LEX(757.05," D IXALL^DIK
 ;     Update String Lengths
 D ASL^LEXXGI4
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
ASL ; Recalculate ASL cross-reference
 N Y,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTQUEUED,ZTREQ S ZTRTN="ASLT^LEXXGI4"
 S ZTDESC="Recalculate ASL index in Expression file #757.01"
 S ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS I $D(LEXLOUD) D
 . S LEXT="  Re-index the ASL index of file #757.01 tasked"
 . S:+($G(ZTSK))>0 LEXT=LEXT_" (#"_+($G(ZTSK))_")" D MES^XPDUTL(LEXT)
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
ASLT ;   Recalculate ASL cross-reference (task)
 K ^TMP("LEXXGI4",$J,"ASL")
 N LEXTK,LEXFIR,LEXFC S (LEXFIR,LEXFC,LEXTK)=""
 F  S LEXTK=$O(^LEX(757.01,"AWRD",LEXTK)) Q:'$L(LEXTK)  D
 . N LEXP,LEXS,LEXC,LEXF,LEXTKN S LEXTKN=LEXTK
 . F  Q:$E(LEXTKN,1)'=" "  S LEXTKN=$E(LEXTKN,2,$L(LEXTKN))
 . F  Q:$E(LEXTKN,$L(LEXTKN))'=" "  S LEXTKN=$E(LEXTKN,1,($L(LEXTKN)-1))
 . S LEXF=$E(LEXTKN,1)
 . W:'$D(ZTQUEUED)&(LEXFIR'=LEXF)&(LEXFC'[LEXF) LEXF
 . S LEXFIR=LEXF S:LEXFC'[LEXF LEXFC=LEXFC_LEXF
 . F LEXP=1:1:$L(LEXTKN)  S LEXS=$E(LEXTKN,1,LEXP) D
 . . Q:'$L($G(LEXS))  Q:$D(^TMP("LEXXGI4",$J,"ASL",LEXS))
 . . S LEXC=$$SCT(LEXS)
 . . I LEXC>0 K ^LEX(757.01,"ASL",LEXS) D
 . . . K ^LEX(757.01,"ASL",LEXS)
 . . . S ^LEX(757.01,"ASL",LEXS,LEXC)=""
 . . S ^TMP("LEXXGI4",$J,"ASL",LEXS)=""
 K ^TMP("LEXXGI4",$J,"ASL")
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
SCT(X) ;   Recalculate ASL cross-reference (String Counter)
 N LEXC,LEXTK,LEXTKN,LEXO,LEXT,LEXS,LEXP
 S (LEXC,LEXTK)=$$UP^XLFSTR($G(X)),LEXT=0  Q:'$L(LEXTK) 0
 S:$L(LEXTK)>1 LEXO=$E(LEXTK,1,($L(LEXTK)-1))_$C(($A($E(LEXTK,$L(LEXTK)))-1))_"~"
 S:$L(LEXTK)=1 LEXO=$C(($A(LEXTK)-1))_"~"
 F  S LEXO=$O(^LEX(757.01,"AWRD",LEXO)) Q:'$L(LEXO)  Q:$E(LEXO,1,$L(LEXC))'=LEXC  D
 . N LEXM S LEXM=0 F  S LEXM=$O(^LEX(757.01,"AWRD",LEXO,LEXM)) Q:+LEXM'>0  D
 . . N LEXE S LEXE=0 F  S LEXE=$O(^LEX(757.01,"AWRD",LEXO,LEXM,LEXE)) Q:+LEXE'>0  D
 . . . S LEXT=LEXT+1
 S X=LEXT
 Q X
 ;
SSWRD ;   Repair Word Index Axxx in Sub-Set file #757.21
 N Y,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTQUEUED,ZTREQ S ZTRTN="SSWRDT^LEXXGI4"
 S ZTDESC="Repair Word Index Axxx in Sub-Set file #757.21"
 S ZTIO="",ZTDTH=$H D ^%ZTLOAD,HOME^%ZIS I $D(LEXLOUD) D
 . S LEXT="  Re-Index the AWRD index of file #757.01 tasked"
 . S:+($G(ZTSK))>0 LEXT=LEXT_" (#"_+($G(ZTSK))_")" D MES^XPDUTL(LEXT)
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
SSWRDT ;   Repair Word Index Axxx in Sub-Set file #757.21 (task)
 N DA,DIK K DA S DIK="^LEX(757.21," D IXALL^DIK
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
 ;
SUB ; Repair Subset Cross-References
 N ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,LEXT S ZTRTN="SUBT^LEXXGI4"
 S ZTDESC="Re-Index the Subsets file #757.21 (set logic only)"
 S ZTIO="",ZTDTH=$H D ^%ZTLOAD I $D(LEXLOUD) D
 . S LEXT="  Re-index file #757.21 tasked"
 . S:+($G(ZTSK))>0 LEXT=LEXT_" (#"_+($G(ZTSK))_")" D MES^XPDUTL(LEXT)
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 Q
SUBT ;   Repair Subset Cross-References (task)
 N LEXP3,LEXP4,LEXIEN S (LEXP3,LEXP4,LEXIEN)=0
 F  S LEXIEN=$O(^LEX(757.21,LEXIEN)) Q:+LEXIEN'>0  D
 . N DA,DIK S DA=+($G(LEXIEN))  D SUBFIX(DA) Q:'$D(^LEX(757.21,+LEXIEN,0))
 . S LEXP3=LEXIEN,LEXP4=LEXP4+1
 . S DA=LEXIEN,DIK="^LEX(757.21," D IX1^DIK
 S:LEXP3>0 $P(^LEX(757.21,0),"^",3)=LEXP3
 S:LEXP4>0 $P(^LEX(757.21,0),"^",4)=LEXP4
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
SUBFIX(X) ;   Repair Subset Cross-References (Fix 757.21)
 N DA,DIK,LEXEXP,LEXDFL S DA=+($G(X))
 Q:+DA'>0  Q:'$D(^LEX(757.21,+DA,0))
 S LEXEXP=+$G(^LEX(757.21,+DA,0))
 S LEXDFL=$P($G(^LEX(757.01,+LEXEXP,1)),"^",5)
 Q:+LEXDFL'>0  S DIK="^LEX(757.21," D ^DIK
 Q
