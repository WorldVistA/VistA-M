DG53653V ;CKN - Patch DG*5.3*653 Install Utility Routine ; 3/14/06 3:33pm
 ;;5.3;Registration;**653**;AUG 13, 1993;Build 2
 ; Called from DG53653U
 Q
 ;
301 S @ROOT@(.01)="PERSON LASTNAME REQUIRED"
 S @ROOT@(2)="PERSON MUST HAVE A LAST NAME"
 S DGWP(1,0)="The last name of the name components is not present."
 S DGWP(2,0)="This applies to patient, spouse and dependents."
 Q
 ;
302 Q  ;
 S @ROOT@(.01)="DATE OF BIRTH REQUIRED"
 S @ROOT@(2)="DATE OF BIRTH MUST BE ENTERED"
 S DGWP(1,0)="The person's date of birth is missing. This applies to"
 S DGWP(2,0)="patient, spouse and dependents. Year is the minimum"
 S DGWP(3,0)="data element that must be entered."
 Q
 ;
303 S @ROOT@(.01)="GENDER REQUIRED"
 S @ROOT@(2)="GENDER MUST BE ENTERED"
 S DGWP(1,0)="The person's gender value is missing. This applies to"
 S DGWP(2,0)="patient, spouse and dependents."
 Q
 ;
304 S @ROOT@(.01)="GENDER INVALID"
 S @ROOT@(2)="THE PERSON GENDER MUST BE EITHER MALE OR FEMALE"
 S DGWP(1,0)="The person has a gender value, but it is not either"
 S DGWP(2,0)="male or female. This applies to patient, spouse and"
 S DGWP(3,0)="dependents."
 Q
 ;
305 Q  ;Removed as duplicate
 S @ROOT@(.01)="VETERAN SSN MISSING"
 S @ROOT@(2)="VETERAN'S SSN IS MISSING"
 S DGWP(1,0)="The person's SSN is missing. This applies to the"
 S DGWP(2,0)="patient only."
 Q
 ;
306 S @ROOT@(.01)="VALID SSN/PSEUDO SSN REQUIRED"
 S @ROOT@(2)="PATIENT MUST HAVE A VALID SSN OR A PSEUDO SSN"
 S DGWP(1,0)="Patient must have a valid SSN or a Pseudo SSN."
 Q
 ;
307 S @ROOT@(.01)="PSEUDO SSN REASON REQUIRED"
 S @ROOT@(2)="PSEUDO SSN REASON IS MISSING"
 S DGWP(1,0)="If a Pseudo SSN number is entered for a person, spouse"
 S DGWP(2,0)="or dependents, then a reason must be entered."
 Q
 ;
308 ;
 S @ROOT@(.01)="DATE OF DEATH BEFORE DOB"
 S @ROOT@(2)="THE DATE OF DEATH IS BEFORE THE DATE OF BIRTH"
 S DGWP(1,0)="The Date of Death cannot be prior to the Date of Birth."
 Q
 ;
309 S @ROOT@(.01)="PATIENT RELATIONSHIP INVALID"
 S @ROOT@(2)="RELATIONSHIP TO PATIENT IS NOT A VALID VALUE"
 S DGWP(1,0)="The value of Relationship to Patient does not match"
 S DGWP(2,0)="one of the valid values."
 Q
 ;
310 S @ROOT@(.01)="DEPENDENT EFF. DATE REQUIRED"
 S @ROOT@(2)="DEPENDENT(S) EFFECTIVE DATE IS MISSING"
 S DGWP(1,0)="A dependent is present but the effective date is null."
 Q
 ;
311 Q  ;Duplicate with #16
 S @ROOT@(.01)="DATE OF DEATH IS FUTURE DATE"
 S @ROOT@(2)="DATE OF DEATH CANNOT BE A FUTURE DATE"
 S DGWP(1,0)="Date Of Death cannot be a future date."
 Q
 ;
312 S @ROOT@(.01)="PERSON MUST HAVE NATIONAL ICN"
 S @ROOT@(2)="PERSON MUST HAVE NATIONAL ICN"
 S DGWP(1,0)="Person does not have National ICN."
 Q
 ;
