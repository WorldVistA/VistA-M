GMRCPH ;SLC/DLT - Process XQORM HELPS ;5/20/98  14:20
 ;;3.0;CONSULT/REQUEST TRACKING;**1**;DEC 27, 1997
URGHELP ;Process help for Urgency prompt when adding consults/requests
 W !!,"Select one of the urgencies below to indicate how soon the results are needed"
 D DISP^XQORM1 W !!
 Q
PLHELP ;Process help for Place of Consultation
 W !!,"Select the prefered place to see the patient for this consult/request"
 D DISP^XQORM1 W !!
 Q
TYPEHELP ;Process help for Type of Consult
 W !!,"The Specialty chosen for this consult has specified common consult types they"
 W !,"process.  You may select one of these types to furthur define the type of"
 W !,"Consult for this patient.  This is an optional prompt."
 D DISP^XQORM1 W !!
 Q
PROCHELP ;Process help for Procedure which may be selected
 W !!,"Select a procedure from the list of procedures below."
 W !!,"This is the list of common procedures/tests/treatments which may be ordered."
 W !,"The procedure will print on a computer generated Consult Form, but will be "
 W !,"processed as a direct order for the procedure."
 D DISP^XQORM1 W !!
 Q
MEDHELP ;Process Medicine Procedure Types help
 W !!,"Select a Procedure Type from the list of Medicine Procedures below."
 W !!,"Once you have selected a Procedure Type, its related Service will"
 W !,"be determined in the Consult/Request Tracking system.  All consults"
 W !,"and requests for this service will be displayed.  When ""AR"", associate"
 W !,"results is selected, the only results you will be able to select from"
 W !,"are those results related to the Procedure Type selected here."
 D DISP^XQORM1 W !!
 Q
