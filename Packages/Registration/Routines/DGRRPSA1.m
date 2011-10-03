DGRRPSA1 ; ALB/SGG - DG R&R PatientServices GET data - return XML ; 09/30/03
 ;;5.3;Registration;**557**;Aug 13, 1993
 ;
DOC ;
 ; Person Service Demogr
 ;
 ;
 ;
 ; Call: DO PATIENT^DGRRPSGT(.RESULT,.PARAMS)
 ; 
 ; Input Parameters:   (Rq) Required parameter  (Op) Optional parameter
 ;   
 ; (Rq) PARAMS("PatientId_Type") =      the three letters "DFN" or "ICN"
 ; (Rq) PARAMS("PatientId") =           the actual value of the patient DFN or ICN
 ; (Op) PARAMS(REQUESTED_DATE)=         Date to be used for ADT Movement List - defaults to DT
 ; (Op) PARAMS("PrimaryDemo") =         0 or 1 to request Primary Demographic Info
 ; (Op) PARAMS("SecondaryDemo") =       0 or 1 to request Secondary Demographic Info
 ; (Op) PARAMS("TertiaryDemo") =        0 or 1 to request Tertiary Demographic Info
 ; (Op) PARAMS("MainAddress") =         0 or 1 to request Main Address Info
 ; (Op) PARAMS("TemporaryAddress") =    0 or 1 to request Temporary Address Info
 ; (Op) PARAMS("ConfidentialAddress") = 0 or 1 to request Confidential Address Info
 ; (Op) PARAMS("ContactInfo") =         0 or 1 to request Contact Information
 ; (Op) PARAMS("ADTInfo") =             0 or 1 to request ADT Information
 ; (Op) PARAMS("EnrollEligibility") =   0 or 1 to request Enrollment/Eligibility Information
 ;           
 ; -- returns result array that contains XML document containing data for 
 ;    information requested by input parameters, Plus Identifier, Institution
 ;    and any Error information.
 ;
 ;
 ; The Primary routine of DGRRPS* is DGRRPSGT (GeT)
 ;
 ;
 ;--------------------------------------------------------------------------------------
 ;
 ;note that the DGRRPS* routines have been released as a sub patch to Mark Enfinger's team
 ;this includes the routines and 'DGRR PATIENT SERVICE QUERY'
 ;
 ;
 QUIT
