PRCFHLP ;WISC/CLH-HELP PROMPTS FOR DIR ;2/21/92  4:26 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
CI ;certified invoice help
 W !!,$C(7),"This option is to be scheduled by IRM to run on a daily basis",!,"at a time before normal duties hours.",!!,"If you are unsure if the bulletins have been sent",!,"answer YES to run it now and check with your local IRM"
 W !,"Service to see if it's scheduled on a daily basis.",!!
 Q
