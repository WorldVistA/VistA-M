DG53653Y ;BAJ - Patch DG*5.3*653 Install Utility Routine ; 10/17/05 10:36am
 ;;5.3;Registration;**653**;AUG 13, 1993;Build 2
 Q
 ;
701 ;Catastrophic Disability 'Decided By' Can Not Be 'HINQ'
 S @ROOT@(.01)="CD 'DECIDED BY' CANNOT BE HINQ"
 S @ROOT@(2)="CD 'DECIDED BY' CANNOT BE 'HINQ'"
 S DGWP(1,0)="Enter the name of the VA staff physician who made the "
 S DGWP(2,0)="decision that the patient was catastrophically disabled."
 Q
 ;
702 ;Catastrophic Disability 'Decided By' Not Valid
 S @ROOT@(.01)="CD 'DECIDED BY' NOT VALID"
 S @ROOT@(2)="CD 'DECIDED BY' IS NOT VALID"
 S DGWP(1,0)="Enter the name of the VA staff physician who made the "
 S DGWP(2,0)="decision that the patient was catastrophically disabled."
 Q
 ;
703 ;Catastrophic Disability 'Decided By' Required
 S @ROOT@(.01)="CD 'DECIDED BY' IS REQUIRED"
 S @ROOT@(2)="CD 'DECIDED BY' IS REQUIRED"
 S DGWP(1,0)="Enter the name of the VA staff physician who made the "
 S DGWP(2,0)="decision that the patient was catastrophically disabled."
 S DGWP(3,0)="This is a required field."
 Q
 ;
704 ;'Catastrophic Disability Review Date' Required
 S @ROOT@(.01)="CD 'REVIEW DATE' IS REQUIRED"
 S @ROOT@(2)="CD 'REVIEW DATE' IS REQUIRED"
 S DGWP(1,0)="Enter the date that a review to determine Catastrophic Disability "
 S DGWP(2,0)="was made.  This review may be a medical record review or"
 S DGWP(3,0)="physical exam review."
 Q
 ;
705 ;'Catastrophic Disabilty Review Date' Invalid
 S @ROOT@(.01)="CD 'REVIEW DATE' IS INVALID"
 S @ROOT@(2)="CD 'REVIEW DATE' SHOULD BE A MEDICAL RECORD OR PHYS EXAM REVIEW DATE"
 S DGWP(1,0)="Enter the date that a review to determine Catastrophic Disability "
 S DGWP(2,0)="was made.  This review may be a medical record review or"
 S DGWP(3,0)="physical exam review."
 Q
 ;
706 ;'CD Condition Score' Not Valid
 S @ROOT@(.01)="CD CONDITION SCORE NOT VALID"
 S @ROOT@(2)="CD 'CONDITION SCORE MUST BE A VALID ENTRY"
 S DGWP(1,0)="The exact criteria for the score are determined by the"
 S DGWP(2,0)="CATASTROPHIC DISABILITY REASONS file (#27.17).  This file"
 S DGWP(3,0)="also contains the help text for responding to SCORE."
 Q
 ;
707 ;'CD Review Date' Greater Than 'CD Date Of Determination'.
 S @ROOT@(.01)="CD REVIEW DT AFTER DECISION DT"
 S @ROOT@(2)="CD REVIEW DATE IS AFTER DATE OF DECISION"
 S DGWP(1,0)="The Catastrophic Disability Review Date must be before "
 S DGWP(2,0)="the date of decision."
 Q
 ;
708 ;'CD Status Affected Extremity' Invalid
 S @ROOT@(.01)="CD AFFECTED EXTREMITY INVALID"
 S @ROOT@(2)="CD AFFECTED EXTREMITY IS INVALID"
 S DGWP(1,0)="If completed, AFFECTED EXTREMITY must be one of "
 S DGWP(2,0)="the following codes: "
 S DGWP(3,0)="                RUE:RIGHT UPPER EXTREMITY"
 S DGWP(4,0)="                LUE:LEFT UPPER EXTREMITY"
 S DGWP(5,0)="                RLE:RIGHT LOWER EXTREMITY"
 S DGWP(6,0)="                LLE:LEFT LOWER EXTREMITY"
 Q
 ;
709 ;'CD Status Diagnoses' Not Valid
 S @ROOT@(.01)="CD DIAGNOSIS IS NOT VALID"
 S @ROOT@(2)="CD STATUS DIAGNOSIS IS NOT VALID"
 S DGWP(1,0)="The status diagnosis must be a valid diagnosis in the "
 S DGWP(2,0)="CD Reasons File (#27.17)."
 Q
 ;
710 ;'CD Status Procedure' Not Valid
 S @ROOT@(.01)="CD PROCEDURE IS NOT VALID"
 S @ROOT@(2)="CD STATUS PROCEDURE IS NOT VALID"
 S DGWP(1,0)="The status procedure must be a valid procedure in the "
 S DGWP(2,0)="CD Reasons File (#27.17)."
 Q
 ;
711 ;'CD Status Reason' Not Present
 S @ROOT@(.01)="CD REASON IS NOT PRESENT"
 S @ROOT@(2)="CD STATUS REASON IS REQUIRED FOR EACH COND, DX AND PROC ENTERED"
 S DGWP(1,0)="A CD status reason is required for each CD "
 S DGWP(2,0)="Condition, Diagnosis and Procedure "
 S DGWP(3,0)="that is entered."
 Q
 ;
712 ;'Date Of Catastophic Disability Decision' Not Valid
 S @ROOT@(.01)="CD DATE OF DECISION NOT VALID"
 S @ROOT@(2)="CD DATE OF DECISION MUST BE A VALID DATE"
 S DGWP(1,0)="Enter the date the catastrophic disability determination was "
    S DGWP(2,0)="made. This must be a valid date."
 Q
 ;
713 ;'Date Of Catastophic Disability Decision' Required
 S @ROOT@(.01)="CD DATE OF DECISION REQUIRED"
 S @ROOT@(2)="CD DATE OF DECISION IS REQUIRED"
 S DGWP(1,0)="The 'Date of Catastrophic Disability Decision is required if the patient "
 S DGWP(2,0)="is catastrophically disabled.  Enter the date the catastrophic disability  "
 S DGWP(3,0)="determination was made. This must be a valid date."
 Q
 ;
714 ;'Facility Making Catastrophic Disability Determination' Not Valid
 S @ROOT@(.01)="CD FACILITY IS NOT VALID"
 S @ROOT@(2)="FACILITY MAKING CD DETERMINATION MUST BE A VALID FACILITY"
 S DGWP(1,0)="The Facility Making Catastrophic Disability Determination must be "
 S DGWP(2,0)="a valid facility and defined in the INSTITUTION file (#4)."
 Q
 ;
715 ;'Method Of Determination' Is A Required Value
 S @ROOT@(.01)="CD METHOD IS REQUIRED"
 S @ROOT@(2)="CD METHOD OF DETERMINATION IS REQUIRED"
 S DGWP(1,0)="Method of Determination is a required field. Possible values are:"
 S DGWP(2,0)="      2:MEDICAL RECORD REVIEW:"
 S DGWP(3,0)="      3:PHYSICAL EXAMINATION "
 S DGWP(4,0)="The valid codes may vary depending on the Institution."
 Q
 ;
716 ;'Method Of Determination' Not Valid
 S @ROOT@(.01)="CD METHOD IS NOT VALID"
 S @ROOT@(2)="CD METHOD OF DETERMINATION IS NOT VALID"
 S DGWP(1,0)="Method of Determination is a required field. Possible values are:"
 S DGWP(2,0)="      2:MEDICAL RECORD REVIEW:"
 S DGWP(3,0)="      3:PHYSICAL EXAMINATION "
 S DGWP(4,0)="The valid codes may vary depending on the Institution."
 Q
 ;
717 ;Not Enough Diagnoses/Procedures/Conditions To Qualify For CD Status
 S @ROOT@(.01)="CD NOT ENOUGH TO QUALIFY"
 S @ROOT@(2)="NOT ENOUGH DX/PROC/CON TO QUALIFY FOR CD STATUS"
 S DGWP(1,0)="Not Enough Diagnoses/Procedures/Conditions To "
 S DGWP(2,0)="qualify For CD Status'"
 Q
 ;
718 ;'Permanent Status Indicator' Not Valid
 S @ROOT@(.01)="CD PERMANENT INDICATOR INVALID"
 S @ROOT@(2)="CD PERMANENT STATUS INDICATOR SHOULD BE 1,2 OR 3"
 S DGWP(1,0)="The Permanent Status Indicator should be one of the following: "
 S DGWP(2,0)="        1:PERMANENT"
 S DGWP(3,0)="        2:NOT PERMANENT"
 S DGWP(4,0)="        3:UNKNOWN "
 Q
 ;
719 ;'Veteran Catastrophically Disabled?' Field Must Have A Response
 S @ROOT@(.01)="CD STATUS UNSPECIFIED"
 S @ROOT@(2)="CD STATUS MUST BE SPECIFIED"
 S DGWP(1,0)="Indicate if the Veteran is Catastrophically Disabled."
 S DGWP(2,0)="This is a required field"
 Q
 ;
720 ;Veteran Has Enough Diagnoses/Procedures/Conditions To Qualify For CD Status
 S @ROOT@(.01)="CD ENOUGH TO QUALIFY"
 S @ROOT@(2)="PT HAS ENOUGH DX/PROC/COND TO QUALIFY FOR CD STATUS"
 S DGWP(1,0)="The Veteran Has Enough Diagnoses/Procedures/Conditions To Qualify For CD "
 S DGWP(2,0)="Status"
 Q
721 ;
 Q
722 ;
 Q
 ;
723 ;Catastrophic Disability Review Date is required to be a precise date
 S @ROOT@(.01)="CD REVIEW DATE MUST BE PRECISE"
 S @ROOT@(2)="CD REVIEW DATE MUST BE A PRECISE CALENDAR DATE"
 S DGWP(1,0)="Inconsistency results when the Review date is not a precise calendar date."
 Q
 ;
724 ;Catastrophic Disability Date of Decision is required to be a precise date
 S @ROOT@(.01)="CD DECISION DT MUST BE PRECISE"
 S @ROOT@(2)="CD DECISION DATE MUST BE A PRECISE CALENDAR DATE"
 S DGWP(1,0)="Inconsistency results when the Data of Decision is not a precise calendar date."
 Q
 ;
725 ;An Affected Extremity is required for each procedure code received for a Catastrophic Disabled Veteran
 S @ROOT@(.01)="CD EXTREMITY REQUIRED"
 S @ROOT@(2)="AFFECTED EXTREMITY IS REQUIRED FOR EACH PROCEDURE REC'D"
 S DGWP(1,0)="An Affected Extremity is required for each procedure code received "
 S DGWP(2,0)="for a Catastrophically Disabiled veteran"
 Q
 ;
726 ;A score is required for each condition code entered for catastrophically disabled determinations
 S @ROOT@(.01)="CD SCORE REQUIRED"
 S @ROOT@(2)="A VALID SCORE IS REQUIRED FOR EACH CONDITION CODE"
 S DGWP(1,0)="A score is required for each condition code entered for catastrophically "
 S DGWP(2,0)="disabled determinations "
 Q
 ;
