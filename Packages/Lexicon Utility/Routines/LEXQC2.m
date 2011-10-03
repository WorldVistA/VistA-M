LEXQC2 ;ISL/KER - Query - Code Set (CSV) - Save ;10/30/2008
 ;;2.0;LEXICON UTILITY;**62**;Sep 23, 1996;Build 16
 ;               
 ; Global Variables
 ;    ^TMP("LEXQC"        SACC 2.3.2.5.1
 ;    ^TMP("LEXQCO"       SACC 2.3.2.5.1
 ;               
 ; External References
 ;    None
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    LEXCDT              Code Set Date
 ;               
EN ; Code Set Changes Main Entry Point
 Q:'$D(^TMP("LEXQC",$J))  N LEXTC S LEXTC=$$TC Q:+LEXTC'>0  Q:$G(LEXCDT)'?7N
 N LEXSID,LEXT
 S LEXT=" "_LEXTC_" Code Set changes found for "_$$SD^LEXQM($G(LEXCDT)) D BL,TL(LEXT)
 F LEXSID="ICD","ICC","ICP","CPT","CPC","MOD","RAN" D SRC
 Q
SRC ;   By Source - ICD/ICC/ICP/CPT/CPC/MOD/RAN
 Q:'$L($G(LEXSID))  Q:"^ICD^ICC^ICP^CPT^CPC^MOD^RAN^"'[("^"_$G(LEXSID)_"^")  Q:'$D(^TMP("LEXQC",$J,LEXSID))
 N LEXCHG S LEXCHG="" F  S LEXCHG=$O(^TMP("LEXQC",$J,LEXSID,LEXCHG)) Q:'$L(LEXCHG)  D CHG
 Q
CHG ;   By Change - ACT/INA/REV/REU/REA
 Q:'$L($G(LEXSID))  Q:"^ICD^ICP^CPT^CPC^MOD^RAN^"'[("^"_$G(LEXSID)_"^")  Q:'$L($G(LEXCHG))  N LEXCNAM,LEXSCT,LEXSNAM S LEXSNAM=""
 I $E(LEXSID,1,2)="IC" D
 . S LEXSNAM=$S(LEXSID="ICD":"ICD Diagnosis Code",LEXSID="ICC":"ICD Complication/Comorbidity (CC) Flag",LEXSID="ICP":"ICD Procedure Code",1:"")
 I '$L(LEXSNAM),$E(LEXSID,1,2)'="IC" D
 . S LEXSNAM=$S(LEXSID="CPT":"CPT Procedure Code",LEXSID="CPC":"HCPCS Procedure Code",LEXSID="MOD":"CPT Modifier Code",LEXSID="RAN":"CPT Modifier Range",1:"")
 Q:'$L($G(LEXSNAM))  S LEXCNAM=$S(LEXCHG="ACT":"Added",LEXCHG="INA":"Inactivated",LEXCHG="REV":"Revised",LEXCHG="UPD":"Updated",LEXCHG="REU":"Re-used",LEXCHG="REA":"Re-Activated",1:"")
 Q:'$L(LEXCNAM)  S LEXSCT=+($G(^TMP("LEXQC",$J,LEXSID,LEXCHG,0))) Q:LEXSCT'>0  S:LEXSCT>1 LEXSNAM=LEXSNAM_"s"
 S LEXT=LEXSNAM_" "_LEXCNAM,LEXT=LEXT_$J(" ",(67-$L(LEXT)))_$J(LEXSCT,5) D BL,TL(("   "_LEXT)) D LST
 Q
LST ;   List Codes
 Q:'$L($G(LEXSID))  Q:'$L($G(LEXCHG))  Q:'$D(^TMP("LEXQC",$J,LEXSID,LEXCHG,1))
 N LEXS,LEXSC,LEXSO,LEXSOE,LEXLC,LEXSTR,LEXMAX S (LEXLC,LEXSC)=0,(LEXS,LEXSTR)="",LEXMAX=10
 F  S LEXS=$O(^TMP("LEXQC",$J,LEXSID,LEXCHG,1,LEXS))  Q:'$L(LEXS)  D
 . N LEXN S LEXN=$G(^TMP("LEXQC",$J,LEXSID,LEXCHG,1,LEXS)),LEXSO=$$TM^LEXQM($P(LEXN,"^",2)) Q:'$L(LEXSO)  S LEXSOE=$$FM(LEXSO)
 . S LEXSC=LEXSC+1 I LEXSC<LEXMAX S LEXSTR=LEXSTR_LEXSOE Q
 . I LEXSC'<LEXMAX S LEXSTR=$$TM^LEXQM(LEXSTR) S LEXLC=+LEXLC+1 D:LEXLC=1 BL D TL(("      "_LEXSTR)) S LEXSC=1,LEXSTR=LEXSOE Q
 S LEXSTR=$$TM^LEXQM(LEXSTR) I $L(LEXSTR) S LEXLC=+LEXLC+1 D:LEXLC=1 BL D TL(("      "_LEXSTR))
 Q
 ;
 ; Miscellaneous
FM(X) ;   Format
 S X=$G(X) S X=X_$J(" ",8-$L(X))
 Q X
BL ;   Blank Line
 D TL(" ") Q
TL(X) ;   Text Line
 I $D(LEXTEST) W !,$G(X) Q
 N LEXI S LEXI=+($O(^TMP("LEXQCO",$J," "),-1))+1 S ^TMP("LEXQCO",$J,LEXI)=$G(X),^TMP("LEXQCO",$J,0)=LEXI
 Q
CLR ;   Clear
 N LEXTEST,LEXCDT
 Q
TC(X) ;   Total Changes Found
 N LEXNN,LEXNC,LEXT S LEXT=0 S LEXNN="^TMP(""LEXQC"","_$J_")",LEXNC="^TMP(""LEXQC"","_$J_"," F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  I LEXNN[",0)" S LEXT=LEXT+($G(@LEXNN))
 S X=LEXT
 Q X
