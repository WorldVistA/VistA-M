GMTSMHCI ;SLC/WAT - HRMH PATIENT CONTACT INFO ;06/13/11  11:58
 ;;2.7;Health Summary;**99**;Oct 20, 1995;Build 45
 ;
 ;EXTERNAL CALLS
 ;ADD/OAD/KVA ^VADPT 10061
 ;Field # .134 PHONE NUMBER [CELLULAR] from Patient file 10035
 ;$$GET1^DIQ 2056
 ;
 ;
 ;Get contact data to display in TIU HS object.  The object is used in reminder dialog that MH professionals
 ;will use to f/u on missed patient apptointments.
 ;DATA PULLED BY THIS COMPONENT.
 ;patient phone numbers
 ;        cell
 ;        home
 ;        work
 ;
 ;;emergency contact: name, relationship, phone number
 ;;secondary emergency contact: name, relationship, phone number
 ;;secondary next of kin contact: name, relationship, phone number
 ;
PRINT  ;MAIN
 K ^TMP($J,"GMTS CONTACT INFO")
 N CNT,HMPHON,TAB,NODATA S CNT=0
 S NODATA="No data available"
 S ^TMP($J,"GMTS CONTACT INFO",CNT)="  Patient Phone Numbers:",CNT=CNT+1
 S TAB="        " ;8 SPACES
 D CELL
 D HOME
 D WORK
 S ^TMP($J,"GMTS CONTACT INFO",CNT)="",CNT=CNT+1
 D EMERGNOK
 D REPORT
 D KVA^VADPT
 Q
 ;
CELL ;GET CELL #
 N GMTSCELL S GMTSCELL=""
 S GMTSCELL=$$GET1^DIQ(2,DFN,.134)
 S ^TMP($J,"GMTS CONTACT INFO",CNT)=TAB_"Cell: "_$S($G(GMTSCELL)>0:GMTSCELL,1:NODATA),CNT=CNT+1
 Q
 ;
WORK ;work ph #
 N VAOA,WORK S VAOA=("A")=5 D OAD^VADPT
 I $G(VAERR)=1 S ^TMP($J,"GMTS CONTACT INFO",CNT)="PATIENT NOT FOUND",CNT=CNT+1 Q
 S ^TMP($J,"GMTS CONTACT INFO",CNT)=TAB_"Work: "_$S($G(VAOA(8))'="":VAOA(8),1:NODATA),CNT=CNT+1
 Q
 ;
HOME ;home phone
 N VAPA,VAERR,HOME D ADD^VADPT
 I $G(VAERR)=1 S ^TMP($J,"GMTS CONTACT INFO",CNT)="PATIENT NOT FOUND",CNT=CNT+1 Q
 S ^TMP($J,"GMTS CONTACT INFO",CNT)=TAB_"Home: "_$S($G(VAPA(8))'="":VAPA(8),1:NODATA),CNT=CNT+1
 Q
 ;
EMERGNOK ; emergency and NOK contacts.
 N I,VAOA,VAERR
 ;S:$G(VAERR)=1 ^TMP($J,"GMTS CONTACT INFO",CNT)="PATIENT NOT FOUND",CNT=CNT+1 Q
 F I=1,4,3 D
 .S VAOA("A")=I D OAD^VADPT Q:$G(VAERR)=1
 .S ^TMP($J,"GMTS CONTACT INFO",CNT)=$S(VAOA("A")=1:"  Emergency Contact: ",VAOA("A")=4:"  Secondary Emergency Contact: ",VAOA("A")=3:"  Secondary Next of Kin Contact"),CNT=CNT+1
 .S ^TMP($J,"GMTS CONTACT INFO",CNT)=TAB_"Name: "_$S($G(VAOA(9))'="":VAOA(9),1:NODATA),CNT=CNT+1
 .S ^TMP($J,"GMTS CONTACT INFO",CNT)=TAB_"Relationship: "_$S($G(VAOA(10))'="":VAOA(10),1:NODATA),CNT=CNT+1
 .S ^TMP($J,"GMTS CONTACT INFO",CNT)=TAB_"Phone: "_$S($G(VAOA(8))'="":VAOA(8),1:NODATA),CNT=CNT+1
 .S ^TMP($J,"GMTS CONTACT INFO",CNT)="",CNT=CNT+1
 Q
 ;
REPORT ;write to screen
 N LINE S LINE=""
 F  S LINE=$O(^TMP($J,"GMTS CONTACT INFO",LINE)) D  Q:LINE=""
 .Q:LINE=""
 .D CKP^GMTSUP Q:$D(GMTSQIT)
 .W:LINE=0 ^TMP($J,"GMTS CONTACT INFO",LINE)
 .W:LINE>0 !,^TMP($J,"GMTS CONTACT INFO",LINE)
 Q
