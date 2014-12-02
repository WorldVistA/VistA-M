ORCXPND4 ; SLC/MKB,MA - Expanded Display cont ;06/24/11  11:44
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**67,306**;Dec 17, 1997;Build 43
 ;
PL ; -- problem list
 N ORPL,X,I,J,T,CNT,PROBLEM,II,CMTFLG,CNT1
 D DETAIL^GMPLUTL2(+ID,.ORPL)
 S PROBLEM=(LCNT+1)_U_ORPL("NARRATIVE") ; #^Provider Narrative
 S J=1,X(J)=$P(PROBLEM,U,2),J=J+1
 I $L($G(ORPL("SCTC")))!$L($G(ORPL("SCTD"))) D  I 1
 .I $P(ORPL("NARRATIVE")," (SCT")'=ORPL("SCTT") S X(J)="         SNOMED-CT: "_ORPL("SCTT"),J=J+1
 .I $L($G(ORPL("DIAGNOSIS")))&(ORPL("DIAGNOSIS")'="799.9")&($L($G(ORPL("ICDD")))) S X(J)="  Primary ICD-9-CM: "_$G(ORPL("DIAGNOSIS"))_$$PAD^ORUTL($G(ORPL("DIAGNOSIS")),6)_" ["_$G(ORPL("ICDD"))_"]",J=J+1
 E  I $L($G(ORPL("VHATC")))!$L($G(ORPL("VHATD"))) D  I 1
 .I $P(ORPL("NARRATIVE")," (VHAT")'=ORPL("VHATT") S X(J)="              VHAT: "_ORPL("VHATT"),J=J+1
 .I $L($G(ORPL("DIAGNOSIS")))&(ORPL("DIAGNOSIS")'="799.9")&($L($G(ORPL("ICDD")))) S X(J)="  Primary ICD-9-CM: "_$G(ORPL("DIAGNOSIS"))_$$PAD^ORUTL($G(ORPL("DIAGNOSIS")),6)_" ["_$G(ORPL("ICDD"))_"]",J=J+1
 E  I ORPL("DIAGNOSIS")'="799.9",$L($G(ORPL("ICDD"))) D
 .N ICDD,I S ICDD=$$WRAP^ORU2($G(ORPL("ICDD")),65)
 .F I=1:1:$L(ICDD,"|") S X(J)=$S(I=1:"ICD-9-CM TEXT: ",1:"              ")_$P(ICDD,"|",I),J=J+1
 I ORPL("ICD9MLTP")'="" F T=1:1:ORPL("ICD9MLTP") D
 . S X(J)=$S(T=1:"Secondary ICD-9-CM: ",T>1:"                  : ")_$P($G(ORPL("ICD9MLTP",T)),U)_$$PAD^ORUTL($P($G(ORPL("ICD9MLTP",T)),U),6)_" ["_$P($G(ORPL("ICD9MLTP",T)),U,2)_"]",J=J+1
 S X(J)="          ",J=J+1
 S X(J)="        Onset: "_ORPL("ONSET"),X(J)=X(J)_$J("SC Condition: ",61-$L(X(J)))_ORPL("SC"),J=J+1
 S X(J)="       Status: "_ORPL("STATUS")_$S($L(ORPL("PRIORITY")):"/"_ORPL("PRIORITY"),1:""),X(J)=X(J)_$J("Exposure: ",61-$L(X(J)))_$S('ORPL("EXPOSURE"):"NONE",1:ORPL("EXPOSURE",1)),J=J+1
 S X(J)="     Provider: "_ORPL("PROVIDER"),J=J+1
 S:ORPL("EXPOSURE")>1 X(J)=X(J)_$$REPEAT^XLFSTR(" ",61-$L(X(J)))_ORPL("EXPOSURE",2),J=J+1
 S X(J)="       Clinic: "_ORPL("CLINIC"),J=J+1
 S:ORPL("EXPOSURE")>2 X(J)=X(J)_$$REPEAT^XLFSTR(" ",61-$L(X(J)))_ORPL("EXPOSURE",3),J=J+1
PL1 S X(J)="          ",J=J+1
 S X(J)="     Recorded: "_$P(ORPL("RECORDED"),U)_", by "_$P(ORPL("RECORDED"),U,2),J=J+1
 S X(J)="      Entered: "_$P(ORPL("ENTERED"),U)_", by "_$P(ORPL("ENTERED"),U,2),J=J+1
 S X(J)="      Updated: "_ORPL("MODIFIED"),J=J+1
 S X(J)="          ",J=J+1,X(J)="Comments: ",CMTFLG=J,CNT=J,J=J+1
 S:ORPL("COMMENT")'>0 X(J)="   <None>",CNT=J
 I ORPL("COMMENT") F I=1:1:ORPL("COMMENT") D
 . S CNT=CNT+1,X(CNT)=$J($P(ORPL("COMMENT",I),U),8)_": "_$P(ORPL("COMMENT",I),U,3)
 . S CNT=CNT+1,X(CNT)="          "_$P(ORPL("COMMENT",I),U,2)
 S CNT=CNT+1,X(CNT)="          "
 F I=1:1:CNT S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=X(I)
 D:$D(IORVON) SETVIDEO^ORCXPND(+PROBLEM,1,$L($P(PROBLEM,U,2)),IORVON,IORVOFF)
 D:$D(IOUON) SETVIDEO^ORCXPND(CMTFLG,1,8,IOUON,IOUOFF)
PL2 ; Changes added to include PROBLEM LIST AUDIT TRAIL 8 Sep 99
 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="History:"
 D:$D(IOUON) SETVIDEO^ORCXPND(LCNT,1,7,IOUON,IOUOFF)
 I ORPL("AUDIT")=0 S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="   <No Changes>" Q
 I ORPL("AUDIT")>0 F II=1:1:ORPL("AUDIT") D COVPRT
 Q
 ;
COVPRT ; This will convert GMPL("AUDIT") to printable format and write it
 ; out to ^TMP("ORXPND",$J)
 N NODE,DATE,FLD,PROV,OLD,NEW,ROOT,CHNGE
 S NODE=ORPL("AUDIT",II,0)
 S DATE=$$DATE^ORCHTAB($P(NODE,U,3)),FLD=+$P(NODE,U),PROV=+$P(NODE,U,8)
 S:'PROV PROV=$P(NODE,U,4) S PROV=$P($G(^VA(200,PROV,0)),U) ;Entr vs Prov
 S OLD=$P(NODE,U,5),NEW=$P(NODE,U,6),LCNT=LCNT+1
 I +FLD=1101 D  Q
 . S NODE=ORPL("AUDIT",II,1) ; old note
 . S ^TMP("ORXPND",$J,LCNT,0)=$J(DATE,10)_": NOTE "_$$DATE^ORCHTAB($P(NODE,U,5))_" removed by "_PROV
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)="            "_$P(NODE,U,3)
 I +FLD=1.02 D  Q
 . S CHNGE=$S(NEW="H":"removed",OLD="T":"verified",1:"placed back on list")
 . S ^TMP("ORXPND",$J,LCNT,0)=$J(DATE,10)_": PROBLEM "_CHNGE_" by "_PROV
 S ^TMP("ORXPND",$J,LCNT,0)=$J(DATE,10)_": "_$P(NODE,U,2)_" changed by "_PROV,LCNT=LCNT+1
 I +FLD=.12 S ^TMP("ORXPND",$J,LCNT,0)=$J("from ",17)_$S(OLD="A":"ACTIVE",OLD="I":"INACTIVE",1:"UNKNOWN")_" to "_$S(NEW="A":"ACTIVE",NEW="I":"INACTIVE",1:"UNKNOWN") Q
 I (+FLD=.13)!(+FLD=1.07) S ^TMP("ORXPND",$J,LCNT,0)=$J("from ",17)_$$DATE^ORCHTAB(OLD)_" to "_$$DATE^ORCHTAB(NEW) Q
 I +FLD=1.14 S ^TMP("ORXPND",$J,LCNT,0)=$J("from ",17)_$S(OLD="A":"ACUTE",OLD="C":"CHRONIC",1:"UNSPECIFIED")_" to "_$S(NEW="A":"ACUTE",NEW="C":"CHRONIC",1:"UNSPECIFIED") Q
 I +FLD=302 D  Q
 . ; if NEW value non-null, register change
 . I NEW]"" D
 . . S ^TMP("ORXPND",$J,LCNT,0)=$J("from ",17)_OLD,LCNT=LCNT+1
 . . S ^TMP("ORXPND",$J,LCNT,0)=$J("to ",17)_NEW
 . ; otherwise, register removal
 . E  S ^TMP("ORXPND",$J,LCNT,0)=$J(OLD_$$PAD^ORUTL(OLD,6),23)_" removed."
 I +FLD>1.09 S ^TMP("ORXPND",$J,LCNT,0)=$J("from ",17)_$S(+OLD:"YES",OLD=0:"NO",1:"UNKNOWN")_" to "_$S(+NEW:"YES",NEW=0:"NO",1:"UNKNOWN") Q
 I "^.01^.05^1.01^1.04^1.05^1.06^1.08^"[(U_+FLD_U) D
 . S ROOT=$S(+FLD=.01:"ICD9(",+FLD=.05:"AUTNPOV(",+FLD=1.01:"LEX(757.01,",(+FLD=1.04)!(+FLD=1.05):"VA(200,",+FLD=1.06:"DIC(49,",+FLD=1.08:"SC(",1:"") Q:ROOT=""
 . S ^TMP("ORXPND",$J,LCNT,0)=$J("from ",17)_$S(OLD:$P(@(U_ROOT_OLD_",0)"),U),1:"UNSPECIFIED")
 . S LCNT=LCNT+1,^TMP("ORXPND",$J,LCNT,0)=$J("to ",17)_$S(NEW:$P(@(U_ROOT_NEW_",0)"),U),1:"UNSPECIFIED")
 Q
