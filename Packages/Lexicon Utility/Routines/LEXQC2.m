LEXQC2 ;ISL/KER - Query - Changes - Save ;04/21/2014
 ;;2.0;LEXICON UTILITY;**62,80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^TMP("LEXQC")       SACC 2.3.2.5.1
 ;    ^TMP("LEXQCO")      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    None
 ;               
 ; Local Variables NEWed in LEXQC
 ;    LEXCDT              Versioning Date
 ;               
EN ; Code Set Changes Main Entry Point
 Q:'$D(^TMP("LEXQC",$J))  N LEXTC S LEXTC=$$TC Q:+LEXTC'>0
 Q:$G(LEXCDT)'?7N  N LEXSID,LEXT S LEXT=" "_LEXTC_" Code Set change"
 S:+LEXTC>1!(LEXTC<1) LEXT=LEXT_"s"
 S LEXT=LEXT_" found for "_$$SD^LEXQM($G(LEXCDT)) D BL,TL(LEXT)
 F LEXSID="ICD","ICC","ICP","10D","10P","CPT","CPC","MOD","RAN" D SRC
 Q
SRC ;   By Source - ICD/ICC/ICP/10D/10P/CPT/CPC/MOD/RAN
 Q:"^ICD^ICC^10D^10P^ICP^CPT^CPC^MOD^RAN^"'[("^"_$G(LEXSID)_"^")
 Q:'$D(^TMP("LEXQC",$J,LEXSID))  N LEXCHG S LEXCHG=""
 F  S LEXCHG=$O(^TMP("LEXQC",$J,LEXSID,LEXCHG)) Q:'$L(LEXCHG)  D CHG
 Q
CHG ;   By Change - ACT/INA/REV/REU/REA
 Q:"^ICD^ICP^10D^10P^CPT^CPC^MOD^RAN^"'[("^"_$G(LEXSID)_"^")
 Q:'$L($G(LEXCHG))  N LEXCNAM,LEXSCT,LEXSNAM S LEXSNAM=""
 S LEXSNAM=$$NAM(LEXSID) Q:'$L($G(LEXSNAM))  S LEXCNAM=$$CHT(LEXCHG)
 Q:'$L(LEXCNAM)  S LEXSCT=+($G(^TMP("LEXQC",$J,LEXSID,LEXCHG,0)))
 Q:LEXSCT'>0  S:LEXSCT>1 LEXSNAM=LEXSNAM_"s" S LEXT=LEXSNAM_" "_LEXCNAM
 S LEXT=LEXT_$J(" ",(67-$L(LEXT)))_$J(LEXSCT,5) D BL,TL(("   "_LEXT))
 D LST
 Q
LST ;   List Codes
 Q:'$L($G(LEXSID))  Q:'$L($G(LEXCHG))
 Q:'$D(^TMP("LEXQC",$J,LEXSID,LEXCHG,1))
 N LEXS,LEXSC,LEXSO,LEXSOE,LEXLC,LEXSTR,LEXMAX,LEXLEN
 S LEXLEN=8 S:LEXSID="10D"!(LEXSID="10P") LEXLEN=10
 S (LEXLC,LEXSC)=0,(LEXS,LEXSTR)="",LEXMAX=10 S:LEXLEN=10 LEXMAX=8
 F  S LEXS=$O(^TMP("LEXQC",$J,LEXSID,LEXCHG,1,LEXS))  Q:'$L(LEXS)  D
 . N LEXN S LEXN=$G(^TMP("LEXQC",$J,LEXSID,LEXCHG,1,LEXS))
 . S LEXSO=$$TM^LEXQM($P(LEXN,"^",2)) Q:'$L(LEXSO)
 . S LEXSOE=$$FM(LEXSO,LEXLEN) S LEXSC=LEXSC+1
 . I LEXSC<LEXMAX S LEXSTR=LEXSTR_LEXSOE Q
 . I LEXSC'<LEXMAX D  Q
 . . S LEXSTR=$$TM^LEXQM(LEXSTR)
 . . S LEXLC=+LEXLC+1 D:LEXLC=1 BL D TL(("      "_LEXSTR))
 . . S LEXSC=1,LEXSTR=LEXSOE Q
 S LEXSTR=$$TM^LEXQM(LEXSTR)
 I $L(LEXSTR) S LEXLC=+LEXLC+1 D:LEXLC=1 BL D TL(("      "_LEXSTR))
 Q
 ;
 ; Miscellaneous
FM(X,Y) ;   Format
 S X=$G(X),Y=+($G(Y)) Q:+Y'>0 X  S X=X_$J(" ",(Y-$L(X)))
 Q X
BL ;   Blank Line
 D TL(" ") Q
TL(X) ;   Text Line
 N LEXI S LEXI=+($O(^TMP("LEXQCO",$J," "),-1))+1
 S ^TMP("LEXQCO",$J,LEXI)=$G(X),^TMP("LEXQCO",$J,0)=LEXI
 Q
TC(X) ;   Total Changes Found
 N LEXNN,LEXNC,LEXT S LEXT=0 S LEXNN="^TMP(""LEXQC"","_$J_")"
 S LEXNC="^TMP(""LEXQC"","_$J_","
 F  S LEXNN=$Q(@LEXNN) Q:'$L(LEXNN)!(LEXNN'[LEXNC)  D
 . I LEXNN[",0)" S LEXT=LEXT+($G(@LEXNN))
 S X=LEXT
 Q X
SH ;   Show Temp Global
 N NN,NC W !! S NN="^TMP(""LEXQC"","_$J_")",NC="^TMP(""LEXQC"","_$J_","
 F  S NN=$Q(@NN) Q:'$L(NN)!(NN'[NC)  W !,NN,"=",@NN
 Q
NAM(X) ; Source Name
 Q:$G(X)="ICD" "ICD-9 Diagnosis Code"
 Q:$G(X)="ICP" "ICD-9 Procedure Code"
 Q:$G(X)="ICC" "ICD Complication/Comorbidity (CC) Flag"
 Q:$G(X)="10D" "ICD-10 Diagnosis Code"
 Q:$G(X)="10P" "ICD-10 Procedure Code"
 Q:$G(X)="CPT" "CPT-4 Procedure Code"
 Q:$G(X)="CPC" "HCPCS Procedure Code"
 Q:$G(X)="MOD" "CPT Modifier Code"
 Q:$G(X)="RAN" "CPT Modifier Range"
 Q ""
CHT(X) ; Change Text
 Q:$G(X)="ACT" "Added"
 Q:$G(X)="INA" "Inactivated"
 Q:$G(X)="REV" "Revised"
 Q:$G(X)="UPD" "Updated"
 Q:$G(X)="REU" "Re-used"
 Q:$G(X)="REA" "Re-Activated"
 Q ""
