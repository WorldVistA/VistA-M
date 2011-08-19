PXRMPCPY ; SLC/PJH - Copy Patient Lists. ;03/17/2003
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
COPY ;Copy patient list - protocol PXRM PATIENT LIST COPY
 ;
 W IORESET
 ;
 ;Select Patient List to copy
 N DIC,DUOUT,DTOUT,DIROUT,DIRUT,IENN,IENO,PLNAM,ROOT,SIEN,X,Y
 S ROOT="^PXRM(810.4",DIC=ROOT,DIC(0)="AEQ"
 S DIC("A")="Select the Patient List to Copy: "
 ;
 W ! D ^DIC I $D(DUOUT)!$D(DTOUT) Q
 S IENO=$P(Y,U,1) I IENO=-1 Q
 ;
 ;Select list to copy to
 D PLIST^PXRMLCR(.IENN) Q:'IENN
 ;Load list into ^TMP
 D LOAD^PXRMRULE("PXRMPCPY",IENN)
 ;Update new patient list
 D UPDLST^PXRMRULE("PXRMPCPY",IENN,"","")
 ;
 W !!,"Completed copy of '"_ORGNAME_"'"
 W !,"into '"_NAME_"'",! H 2
 Q
