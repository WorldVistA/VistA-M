SPNLGICP ; ISC-SF/GMB - SCD GATHER CURRENT PATIENT DATA; 4 JUL 94 [ 07/12/94  8:19 AM ] ;6/23/95  11:30
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
GATHER(DFN) ;
 ; DFN       Patient's internal entry number in the Patient file
 ; Data will be rolled up into the following global:
 ; ^TMP("SPN",$J,"CP",   (The node at this level has the total patient count)
 ; with the following nodes:
 ; name^ssn)        "Deceased", if dead; "", otherwise
 N VADM,VA,NAME,SSN,STATUS
 D DEM^VADPT ; Get patient demographics
 S NAME=VADM(1)
 S SSN=VA("PID")
 S STATUS=$S(VADM(6)>0:"Deceased",1:"")
 S ^TMP("SPN",$J,"CP",NAME_"^"_SSN)=STATUS
 S ^("CP")=$G(^TMP("SPN",$J,"CP"))+1 ; count of current patients
 Q
