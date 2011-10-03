DG53653X ;TDM - Patch DG*5.3*653 Install Utility Routine ; 10/27/05 5:14pm
 ;;5.3;Registration;**653**;AUG 13, 1993;Build 2
 ; Called from DG53653U
 Q
 ;
501 S @ROOT@(.01)="POW STATUS INVALID"
 S @ROOT@(2)="POW STATUS INDICATED MUST BE EITHER YES, NO, OR UNKNOWN/NULL"
 S DGWP(1,0)="If completed, the value of POW Status Indicated must be either"
 S DGWP(2,0)="Yes, No, or Unknown."
 Q
 ;
502 S @ROOT@(.01)="MIL DIS RETIREMENT INVALID"
 S @ROOT@(2)="THE VALUE FOR MIL DIS RETIREMENT MUST BE EITHER YES,NO OR UNKNOWN/NULL"
 S DGWP(1,0)="The Value of Mil. Dis. Retirement is completed, but does not"
 S DGWP(2,0)="match any valid value.  (Note: This value is replacing"
 S DGWP(3,0)="Disability Retirement from Military.)"
 Q
 ;
503 S @ROOT@(.01)="DISCHARGE DUE TO DISAB INVALID"
 S @ROOT@(2)="THE VALUE FOR DISCH DUE TO DISAB MUST BE EITHER YES,NO,OR UNKNOWN/NULL"
 S DGWP(1,0)="The Value for Discharge Due to Disability is completed but"
 S DGWP(2,0)="not a valid value."
 Q
 ;
504 S @ROOT@(.01)="AGENT ORANGE EXPOSURE INVALID"
 S @ROOT@(2)="AGENT ORANGE EXPOSURE MUST BE EITHER YES, NO, OR UNKNOWN"
 S DGWP(1,0)="If completed, the value of Exposed to Agent Orange must be"
 S DGWP(2,0)="either Yes, No, or Unknown"
 Q
 ;
505 S @ROOT@(.01)="RADIATION EXPOSURE INVALID"
 S @ROOT@(2)="RADIATION EXPOSURE MUST BE EITHER YES, NO, OR UNKNOWN"
 S DGWP(1,0)="If completed, the value of Radiation Exposure Indicated must"
 S DGWP(2,0)="be either Yes, No, or Unknown."
 Q
 ;
506 S @ROOT@(.01)="ENV CONTAMINANTS EXP INVALID"
 S @ROOT@(2)="ENVIRONMENTAL CONTAMINANTS EXPOSURE MUST BE EITHER YES, NO, OR UNKNOWN"
 S DGWP(1,0)="If completed, the value of Environmental Contaminants must be"
 S DGWP(2,0)="Yes, No or Unknown."
 Q
 ;
507 S @ROOT@(.01)="RAD EXPOSURE METHOD INVALID"
 S @ROOT@(2)="RAD EXPOSURE METHOD MUST BE ENTERED SINCE RAD EXP INDICATOR IS YES"
 S DGWP(1,0)="Radiation Exposure Indicated is Yes and Radiation Exposure Method"
 S DGWP(2,0)="is null."
 Q
 ;
508 S @ROOT@(.01)="MST STATUS INVALID"
 S @ROOT@(2)="MST STATUS MUST BE YES, NO, OR DECLINES"
 S DGWP(1,0)="The value of MST Status is completed, but it does not match one"
 S DGWP(2,0)="of the values."
 Q
 ;
509 S @ROOT@(.01)="MST STATUS CHANGE DATE MISSING"
 S @ROOT@(2)="MST STATUS CHANGE DATE IS REQUIRED IF MST STATUS IS Y, N, OR D"
 S DGWP(1,0)="MST Status Change Date is required if MST Status is Yes, No, or"
 S DGWP(2,0)="or Declines to answer."
 Q
 ;
510 S @ROOT@(.01)="MST STATUS SITE REQUIRED"
 S @ROOT@(2)="SITE DETERMINING MST STATUS IS REQUIRED IF MST STATUS IS Y, N, OR D"
 S DGWP(1,0)="Site Determining MST Status is required if MST Status is Yes, No,"
 S DGWP(2,0)="or Declines to answer."
 Q
 ;
511 S @ROOT@(.01)="MST STATUS SITE INVALID"
 S @ROOT@(2)="SITE DETERMINING MST STATUS MUST BE A VAMC OR CLINIC"
 S DGWP(1,0)="The Site Determining MST Status is present, but the type of"
 S DGWP(2,0)=" Institution that it points to is not identified as a VA Medical"
 S DGWP(3,0)="Center or an Outpatient Clinic."
 Q
 ;
512 Q  ;Same as or conflicting with #60 in 38.6???
 S @ROOT@(.01)="AO EXPOSURE LOCATION MISSING"
 S @ROOT@(2)="AO EXPOSURE LOCATION IS MISSING AND EXPOSED TO AGENT ORANGE IS YES"
 S DGWP(1,0)="The Exposed to Agent Orange is Yes and the Agent Orange Exposure"
 S DGWP(2,0)="Location is null."
 Q
 ;
513 Q  ;Same as or conflicting with #72 in 38.6???
 S @ROOT@(.01)="MS ENTRY DATE REQUIRED"
 S @ROOT@(2)="MILITARY SERVICE ENTRY DATE (SED) MUST CONTAIN AT LEAST A YEAR DATE"
 S DGWP(1,0)="If completed, Military Service Entry Date (SED) must contain at"
 S DGWP(2,0)="least a year date."
 Q
 ;
514 Q  ;Same as or conflicting with #72 in 38.6???
 S @ROOT@(.01)="MS SEPARATION DATE REQUIRED"
 S @ROOT@(2)="MILITARY SERVICE SEPARATION DATE-SSD MUST CONTAIN AT LEAST A YEAR DATE"
 S DGWP(1,0)="If completed, Military Service Separation Date must contain at"
 S DGWP(2,0)="least a year date."
 Q
 ;
515 Q  ;Same as or conflicting with #74 in 38.6?
 S @ROOT@(.01)="CONFLICT FROM/TO DATE REQUIRED"
 S @ROOT@(2)="CONFLICT FROM/TO DATES DO NOT CONTAIN AT LEAST A MONTH AND YEAR DATE"
 S DGWP(1,0)="If present, Conflict From/To Dates must consist of at least a"
 S DGWP(2,0)="year date."
 Q
 ;
516 S @ROOT@(.01)="DOB INVALID-MEXICAN BORDER WAR"
 S @ROOT@(2)="DOB IS INCONSISTENT WITH ELIGIBILITY OF MEXICAN BORDER WAR"
 S DGWP(1,0)="DOB is Inconsistent With Eligibility Of Mexican Border War."
 Q
 ;
517 S @ROOT@(.01)="DOB INVALID-WORLD WAR I"
 S @ROOT@(2)="DOB IS INCONSISTENT WITH ELIGIBILITY OF WORLD WAR I"
 S DGWP(1,0)="DOB is Inconsistent With Eligibility Of World War I."
 Q
