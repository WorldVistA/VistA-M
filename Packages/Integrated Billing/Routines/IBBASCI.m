IBBASCI ;OAK/ELZ - CIDC SWITCH UTILITIES ;16-DEC-2004
 ;;2.0;INTEGRATED BILLING;**260**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
 ;
CIDC(DFN) ; function to look up the status for DFN and switch
 N IBINS,IBSTAT
 S IBINS=$S('DFN:1,1:$$INSUR^IBBAPI(DFN))
 I IBINS<0 S IBINS=1
 S IBSTAT=$$STAT
 Q $S(IBSTAT=2:1,IBSTAT=0:0,IBSTAT=1&('IBINS):0,1:1)
 ;
STAT() ; looks up the status of the CIDC switch
 N IBPAR,IBENT
 D ENVAL^XPAR(.IBPAR,"IB CIDC INSURANCE CHECK")
 S IBENT=$O(IBPAR(""))
 Q $S('IBENT:1,$L($G(IBPAR(IBENT,1))):$G(IBPAR(IBENT,1)),1:1)
 ;
SET ; option to change switch data
 W !!,"The switch will change when CIDC prompts are displayed for related applications."
 W !,"When changing this option, great care should be executed for it will change the"
 W !,"display of CIDC prompts to both providers and back door users.",!!
 ;
 D EDITPAR^XPAREDIT("IB CIDC INSURANCE CHECK")
 ;
 Q
