PSGOEM1 ;BIR/CML3-MORE HELP MESSAGES ;16 DEC 97 / 1:37 PM 
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
ENCTM ;
 W !!,"Enter a 'Y' if the patient is being transferred to another ward (or service).   Enter an 'N' if not.  Enter an '^' if you no longer want to discontinue th",$S($D(PSGORD):"is",1:"ese")," order",$S($D(PSGORD):"",1:"s"),"." Q
