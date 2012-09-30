RORP004 ;BP/KM - PATCH ROR*1.5*4 PRE-INSTALLATION ROUTINE ; 8/9/07 7:30am
 ;;1.5;CLINICAL CASE REGISTRIES;**4**;Feb 17, 2006;Build 3
 ;
 Q
PRE ;Preinstall tag
 N PDATE,%H
 W !,"Creating a backup copy of file 798.2 in ^XTMP"
 S %H=+$H+180 D YMD^%DTC S PDATE=X K X
 S ^XTMP("R0R",$J,0)=PDATE_U_DT_U_"Backup of file 798.2"
 M ^XTMP("ROR",$J,798.2)=^ROR(798.2)
 W !,"Backup complete"
 Q
