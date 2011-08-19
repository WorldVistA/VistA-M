IVMLINS5 ;ALB/KCL - IVM INSURANCE UPLOAD EXTENDED HELP ; 01-FEB-94
 ;;2.0;INCOME VERIFICATION MATCH;**14**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
EXHLP ; - extended help for the IVM insurance upload
 ;
 ; - set screen to full scrolling region
 D FULL^VALM1
 ;
 W !!
 W !,?15,"***** IVM INSURANCE UPLOAD OPTION - EXTENDED HELP *****"
 W !," "
 W !,?3,"As part of the Income Verification Match process, requests for insurance"
 W !,?3,"are sent to the employers of veterans who do not report active health"
 W !,?3,"insurance information in DHCP.  If a health insurance policy is identified"
 W !,?3,"by the Health Eligibility Center (HEC), the patient policy information"
 W !,?3,"is electronically transmitted to the field facility.  Once the patient"
 W !,?3,"insurance policy has been received by the field facility, field personnel"
 W !,?3,"will then be able to review the information and either upload or reject"
 W !,?3,"the policy."
 W !," "
 W !,?3,"This option is used to either upload or reject updated insurance policy"
 W !,?3,"information.  The user will be presented with a list of patients having"
 W !,?3,"uploadable insurance policy information.  The user may then select"
 W !,?3,"patients from the list and view all insurance policy information currently"
 W !,?3,"on file for the patient.  The patient insurance policy information that"
 W !,?3,"has been received from HEC will be displayed next.  Once the"
 W !,?3,"user has viewed this information, they will have the option to either"
 W !,?3,"upload or reject the insurance policy information.  If the user chooses"
 W !,?3,"to upload the insurance policy information, a new insurance policy entry"
 W !,?3,"will be created for the patient and a message will be sent to"
 W !,?3,"HEC, notifying them that the insurance policy was uploaded.",!
 ;
 S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 ;
 W !!,?5,"If the user chooses to reject the insurance policy information the user"
 W !,?5,"will be required to enter a reason for why the insurance policy is "
 W !,?5,"being rejected.  Once a policy has been rejected, the patient will"
 W !,?5,"be removed from the list and a message will be sent to HEC,"
 W !,?5,"notifying them that the insurance policy was rejected."
 W !," "
 W !,?5,"MCCR has requested that the IVM INSURANCE UPLOAD option does"
 W !,?5,"NOT directly upload the updated insurance policy information"
 W !,?5,"sent from HEC.  Therefore this option will now allow the user"
 W !,?5,"to reject the information or transfer the data to a MCCR"
 W !,?5,"insurance module where authorized insurance personnel will"
 W !,?5,"have the ability to upload or reject.",!
 ;
 S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 S VALMBCK="R"
 Q
