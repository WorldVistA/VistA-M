ORY99 ; slc/dcm - Patch 99 Post-init ;12/25/00  16:09
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**99**;Dec 17, 1997
POST ;Recompile/modify compiled print codes
 N I,X,Y
 S I=0,Y("^XTMP")="^TMP"
 F  S I=$O(^ORD(100.22,I)) Q:'I  I $G(^(I,1))["^XTMP" S X=^(1),^(1)=$$REPLACE^XLFSTR(X,.Y)
 K Y
 S I=0
 S Y("N Y,ORXPTMP")="N Y"
 S Y("S ORXPTMP=$$XTMP^ORPRS09(""ORP:""_$J,""Ord Text Print Fld"") M ^TMP(ORXPTMP)=Y")="M ^TMP(""ORP:"",$J)=Y"
 S Y("S ORXPTMP=$$XTMP^ORPRS09(""ORP:""_$J,""RX ADMIN"") M ^TMP(ORXPTMP)=Y")="M ^TMP(""ORP:"",$J)=Y"
 S Y("S ORXPTMP=$$XTMP^ORPRS09(""ORP:""_$J,""Lab Test Prnt Fld"") M ^TMP(ORXPTMP)=Y")="M ^TMP(""ORP:"",$J)=Y"
 S Y="^TMP(""""""_ORXPTMP_"""""")",Y(Y)="^TMP(""""ORP:"""",$J)"
 F  S I=$O(^ORD(100.22,I)) Q:'I  I $G(^(I,1))["XTMP^ORPRS09" S X=^(1),^(1)=$$REPLACE^XLFSTR(X,.Y)
 D RECMPL^ORPR00,ORP
 Q
ORP ;Look for ORP nodes
 N I
 S I=""
 F  S I=$O(^TMP(I)) Q:I=""  I $E(I,1,3)="OR:" K ^TMP(I)
 S I=""
 F  S I=$O(^XTMP(I)) Q:I=""  I $E(I,1,3)="OR:"!($E(I,1,4)="ORP:") K ^XTMP(I)
 Q
