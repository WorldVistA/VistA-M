IBDFFV1 ;ALB/CMR - AICS FORM VALIDATION ; NOV 24,1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
 ; -- entry point from IBDFFV
 ; -- called to set up ^TMP with forms to be printed
 ;
 Q:('$D(VAUTD)&('$D(VAUTG))&('$D(VAUTC))&('$D(VAUTF)))!('$D(SORT))
 D FORM:+SORT=1,CLINIC:+SORT=2,GROUP:+SORT=3,DIV:+SORT=4
 Q
FORM ; -- $O through forms
 ;
 N FRM,FORM
 Q:'$D(VAUTF)
 S FRM=0 F  S FRM=$S(VAUTF:$O(^IBE(357,FRM)),1:$O(VAUTF(FRM))) Q:'FRM  S FORM=$P($G(^IBE(357,FRM,0)),U) I FORM]"" S ^TMP($J,"IBFV","F",FORM,FRM)=""
 Q
CLINIC ; -- $O through clinics
 ;
 N CLIN
 Q:'$D(VAUTC)
 S CLIN=0 F  S CLIN=$S(VAUTC:$O(^SD(409.95,"B",CLIN)),1:$O(VAUTC(CLIN))) Q:'CLIN  D CLIN
 Q
GROUP ; -- $O through groups
 ;
 N GRP,GROUP,CLIN
 Q:'$D(VAUTG)
 S GRP=0 F  S GRP=$S(VAUTG:$O(^IBD(357.99,GRP)),1:$O(VAUTG(GRP))) Q:'GRP  D
 .S GROUP=$P($G(^IBD(357.99,GRP,0)),U)
 .; -- find all clinics associated with group
 .S CLIN=0 F  S CLIN=$O(^IBD(357.99,GRP,10,"B",CLIN)) Q:'CLIN  D CLIN
 Q
DIV ; -- $O through divisions
 ;
 N CLIN,DIV
 Q:'$D(VAUTD)
 S CLIN="" F  S CLIN=$O(^SD(409.95,"B",CLIN)) Q:'CLIN  D
 .S DIV=$P($G(^SC(CLIN,0)),U,15) Q:'DIV
 .; -- quit if division for clinic is not a chosen division
 .I 'VAUTD,'$D(VAUTD(DIV)) Q
 .S:+DIV DIV=$P($G(^DG(40.8,+DIV,0)),U) Q:DIV']""
 .D CLIN
 Q
CLIN ; -- set up TMP nodes
 N SETUP,NAME
 S SETUP=$O(^SD(409.95,"B",CLIN,"")) Q:'SETUP
 S NAME=$P($G(^SC(CLIN,0)),U) Q:NAME=""
 I +SORT=2 S ^TMP($J,"IBFV","C",NAME,SETUP)="" Q
 I +SORT=3 S ^TMP($J,"IBFV","G",GROUP,NAME,SETUP)="" Q
 I +SORT=4 S ^TMP($J,"IBFV","D",DIV,NAME,SETUP)="" Q
 Q
