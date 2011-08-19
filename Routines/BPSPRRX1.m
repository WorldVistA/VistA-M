BPSPRRX1 ;ALB/SS - ePharmacy secondary billing ;16-DEC-08
 ;;1.0;E CLAIMS MGMT ENGINE;**8,9**;JUN 2004;Build 18
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
 ;display available plans and prompt the user to select the plan
 ;input:
 ; BPSDFN - patient's DFN
 ; BPSDOS - date of service
 ; BPRETAR - array to return details for the selected plan (by reference)
 ; BPSPRMT - prompt
 ; BPDEFPLN (optional) - default plan
 ;return: 0 if not selected
 ; "-110^No valid group insurance plans" if no plans 
 ;return: the GROUP INSURANCE PLAN ien (#355.3)
 ; and selected plan's details in BPRETAR
SELECTPL(BPSDFN,BPSDOS,BPRETAR,BPSPRMT,BPDEFPLN) ;
 N BPSRET,BPSARR
 S BPSRET=$$SELPLAN(BPSDFN,BPSDOS,"E",.BPSARR,"1,7,8,10,11,14,12,18",1,$S($L($G(BPSPRMT)):BPSPRMT,1:"SECONDARY INSURANCE POLICY"),"",$G(BPDEFPLN))
 Q:+BPSRET=-1 0
 Q:+BPSRET=-110 BPSRET
 Q:+BPSRET=0 0
 M BPRETAR=BPSARR("IBBAPI","INSUR",+$P(BPSRET,U,3))
 Q +$P(BPRETAR(8),U,1)
 ;
 ;select insurance from the list of the insurances which was built for the current user setting
 ;for the User Screen.
 ;input : 
 ; BPSDFN - patient's DFN
 ; BPSDOS - date of service
 ; BPSTAT - IBSTAT flag in INSUR^IBBAPI
 ; BPSARR - array to return results (by reference)
 ; BPSFLDS - IBFLDS in INSUR^IBBAPI (list of fields to return, "*" for all)
 ; BPSDISPL - display insurances before prompting for selection
 ; BPSMESS - message to display before prompt
 ; BPDEFPLN (optional) - default plan
 ;output : 1^name of the insurance or null
 ;0^ - if "^" or was not selected
SELPLAN(BPSDFN,BPSDOS,BPSTAT,BPSARR,BPSFLDS,BPSDISPL,BPSPRMPT,BPSMESS,BPDEFPLN) ;
 N BPSRET,BPSDFLT,BPSVAL
 N DIR,Y,X
 N BPX,BPCNT,BPTEL,BPCNT2
 S BPSDFLT=""
 S BPSRET=$$INSUR^IBBAPI(BPSDFN,BPSDOS,BPSTAT,.BPSARR,BPSFLDS)
 Q:'BPSRET "-110^No valid group insurance plans"
 W !,?4,"Insurance",?18,"COB",?23,"Subscriber ID",?37,"Group",?48,"Holder",?57,"Effective",?68,"Expires"
 W !,?4,"=============",?18,"====",?23,"=============",?37,"==========",?48,"========",?57,"==========",?68,"=========="
 S BPX=0
 I $G(BPSDISPL) F  S BPX=$O(BPSARR("IBBAPI","INSUR",BPX)) Q:BPX=""  D
 . W !,?1,BPX
 . W ?4,$E($P($G(BPSARR("IBBAPI","INSUR",BPX,1)),U,2),1,13)
 . W ?18,$E($P($G(BPSARR("IBBAPI","INSUR",BPX,7)),U,2),1,3)
 . W ?23,$E($P($G(BPSARR("IBBAPI","INSUR",BPX,14)),U,1),1,13)
 . W ?37,$E($P($G(BPSARR("IBBAPI","INSUR",BPX,8)),U,2),1,10)
 . W ?48,$E($P($G(BPSARR("IBBAPI","INSUR",BPX,12)),U,2),1,9)
 . W:+$G(BPSARR("IBBAPI","INSUR",BPX,10)) ?57,$$FMTE^XLFDT(+$G(BPSARR("IBBAPI","INSUR",BPX,10)),"5Z")
 . W:+$G(BPSARR("IBBAPI","INSUR",BPX,11)) ?68,$$FMTE^XLFDT(+$G(BPSARR("IBBAPI","INSUR",BPX,11)),"5Z")
 W !!
 S BPX=0,BPCNT=0
 S DIR("A")=BPSPRMPT
 I $L($G(BPSMESS))>0 D
 . S DIR("A","?")=BPSMESS
 . S DIR("A",1)=""
 . S DIR("A",2)=BPSMESS
 . S DIR("A",3)=""
 K ^TMP($J,"BPSPRRX1","LOOKUP")
 F  S BPX=$O(BPSARR("IBBAPI","INSUR",BPX)) Q:BPX=""  D
 . S BPCNT=BPCNT+1
 . S BPSVAL=$E($P($G(BPSARR("IBBAPI","INSUR",BPX,1)),U,2)_" ("_$P($G(BPSARR("IBBAPI","INSUR",BPX,7)),U,2)_") - "_$P($G(BPSARR("IBBAPI","INSUR",BPX,8)),U,2),1,60)
 . S ^TMP($J,"BPSPRRX1","LOOKUP",BPCNT,0)=BPSVAL_U_BPX
 . S ^TMP($J,"BPSPRRX1","LOOKUP","B",BPX,BPCNT)=""
 . I $G(BPDEFPLN)>0 I +BPSARR("IBBAPI","INSUR",BPX,8)=BPDEFPLN S BPSDFLT=BPX
 I BPCNT=0 Q "0^"
 S ^TMP($J,"BPSPRRX1","LOOKUP",0)=U_U_BPCNT_U_BPCNT
 ;set DIR variables
 S DIR(0)="P^TMP($J,""BPSPRRX1"",""LOOKUP"",:AEQMZ"
 I BPSDFLT'="" S DIR("B")=BPSDFLT ;$E(BPSDFLT,1,14)
 D ^DIR
 S BPX=$P($G(^TMP($J,"BPSPRRX1","LOOKUP",+Y,0)),U,2)
 K ^TMP($J,"BPSPRRX1","LOOKUP")
 I X="^" Q "-1^"
 I $TR($P(Y,U,2)," ")="" Q "0^"
 Q Y_U_BPX
 ;
