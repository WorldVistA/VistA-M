DGENCDRP ;ISA/Zoltan - Catastrophic Disability Eligibily Code Report;6/24/99
 ;;5.3;Registration;**232**;Aug 13,1993
REPORT ; Print a report of all patients having the CATASTROPHICALLY DISABLED
 ; Eligibility code.
 W:$X !!
 W "This routine will print a report of all patients having the",!
 W "inactivated CATASTROPHIC DISABILITY eligibility code.",!
 N PFX,L,DIC,FLDS,BY,DIOBEG,DIOEND
 D DT^DICRW ; Set up FM required variables.
 S PFX="^TMP($J,""DGENCDRP""," ; Partial global reference.
 S DIOBEG="D MAKELIST^DGENCDRP(""^TMP($J,""""DGENCDRP"""")"",$J'="_$J_")"
 S DIOEND="K ^TMP($J,""DGENCDRP"")"
 S L=0 ; No SORT prompt.
 S DIC="^DPT(" ; Global prefix.
 S FLDS="[DGENCD ELIG CODE]" ; Fields to print.
 S BY(0)=PFX ; Sorted list.
 S L(0)=2 ; Number of subscripts in sorted list.
 D EN1^DIP
 Q
MAKELIST(ARR,SILENT) ;
 ; Returns a list of patients having the CATASTROPHICALLY DISABLED
 ; Eligibility code as either their PRIMARY or SECONDARY Eligibility.
 K @ARR
 S SILENT=''$G(SILENT,0) ; Suppress screen output.
 N ELIG,DFN,X
 I 'SILENT D
 . W "Creating list of patients having the CATASTROPHICALLY DISABLED",!
 . W "Eligibility Code..."
 S ELIG=""
 F  S ELIG=$O(^DIC(8,"B","CATASTROPHICALLY DISABLED",ELIG)) Q:ELIG=""  D
 . ; "AEL" index ^DPT("AEL",DFN,elig)=""
 . ; Note this inex contains both primary eligibility (#.361) and
 . ;  Patient eligibilities (#361).
 . S DFN=""
 . F X=1:1 S DFN=$O(^DPT("AEL",DFN)) Q:DFN=""  W:X#10000'!SILENT "." I $D(^DPT("AEL",DFN,ELIG)) D ADD(ARR,DFN)
 Q
ADD(ARR,DFN) ; Add Patient to array.
 N NAME
 S NAME=$P(^DPT(DFN,0),"^",1)
 S @ARR@(NAME,DFN)=""
 Q
