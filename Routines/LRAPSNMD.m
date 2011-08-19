LRAPSNMD ;DALOI/WTY - Display/print SNOMED codes;08/06/01
 ;;5.2;LAB SERVICE;**259**;Sep 27, 1994
 ;
 Q
INIT(LRDFN,LRSS,LRI,LRSF,LRAA,LRAN,LRAD,LRDEM,LRDEV) ;
 ; This routine displays SNOMED codes and their description for the
 ; given record in the LAB DATA (#63) file.
 ;
 ; LRDFN - IEN of the patient's record in the LAB DATA file (#63)
 ;  LRSS - Anatomic Pathology section (i.e. "SP" for Surgical Pathology)
 ;   LRI - Inverse date/time specimen taken
 ;  LRSF - Anatomic Pathology sub-file number (i.e. 63.08 for Surg Path)
 ;  LRAA - IEN of the accession area in the ACCESSION (#68) file
 ;  LRAN - Accession Number
 ;  LRAD - Accession Date
 ; LRDEM - Demographics Array.  The following are used in the header 
 ;         code but are not required:
 ;         LRDEM("PNM") - Patient Name
 ;         LRDEM("PRO") - Provider
 ;         LRDEM("AUDT") - Autopsy Date
 ;         LRDEM("AUTYP") - Autopsy Type
 ;         LRDEM("DTH") - Date of Death
 ;         LRDEM("SSN") - Social Security Number
 ;         LRDEM("SEX") - Sex
 ;         LRDEM("AGE") - Age (or Age at Death for AU)
 ;         LRDEM("DOB") - Date of Birth
 ; LRDEV - 1 indicates use device handling in this routine
 ;         0 indicates use device handling of calling application
 ;
 N LRAU,LRQUIT,LRL
 Q:'$D(LRSS)!('$D(LRDFN))!('$D(LRSF))!('$D(LRAA))!('+$G(LRAN))
 Q:'+$G(LRAD)
 S $P(LRL,"-",79)=""
 S LRAU=$S(LRSS'="AU":0,1:1)
 Q:'LRAU&('$D(LRI))
MAIN ;
 S LRQUIT=0,LRDEV=+$G(LRDEV)
 D:LRDEV ASKDEV
 I $G(POP)!(LRQUIT) D END Q
 D REPORT
 D END
 Q
CHECK ;
 N LRSB
 I LRAU D  Q
 .S LRSB=$Q(^LR(LRDFN,"AY",0))
 .I $QS(LRSB,2)'="AY" D
 ..W !!,"No SNOMED codes found."
 ..S LRQUIT=1
 S LRSB=$Q(^LR(LRDFN,LRSS,LRI,2,0))
 I $QS(LRSB,4)'=2 D
 .W !!,"No SNOMED codes found."
 .S LRQUIT=1
 Q
ASKDEV ;
 W !
 S %ZIS="Q" D ^%ZIS
 I POP W ! S LRQUIT=1 Q
 I $D(IO("Q")) D
 .S ZTDESC="LIST OF SNOMED CODES FOR AN ACCESSION"
 .S ZTSAVE("LR*")="",ZTRTN="REPORT^LRAPSNMD"
 .D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued, #",ZTSK W !
 .K ZTSK,IO("Q") D HOME^%ZIS
 .S LRQUIT=1
 Q
REPORT ;
 U IO W:IOST["C-" @IOF
 N LRFILE,LRFILE1,LRFILE2,LRFILE3,LRCASE,LRX
 N LRA,LRA1,LRA2,LRIENS,LRIENS1,LRIENS2,LRIENS3
 N LRP1,LRP2,LRP3,LRP4,LRP5,LRDFP,LRPRFX,LRPG,LRACC,LRSEC
 S LRIENS=LRAN_","_LRAD_","_LRAA_","
 S LRACC=$$GET1^DIQ(68.02,LRIENS,15,"E")
 S LRSEC=$$GET1^DIQ(68,LRAA_",",.01)
 S (LRQUIT,LRPG)=0
 D HDR
 ;Print Specimens
 I 'LRAU D  Q:LRQUIT
 .W !,"Tissue Specimen(s): ",!
 .S LRX=0
 .F  S LRX=$O(^LR(LRDFN,LRSS,LRI,.1,LRX)) Q:LRX'>0!(LRQUIT)  D
 ..I $Y>(IOSL-5) D HDR Q:LRQUIT
 ..W ?5,$P($G(^LR(LRDFN,LRSS,LRI,.1,LRX,0)),U),!
 D CHECK
 Q:LRQUIT
 I LRAU D
 .S LRFILE="^LR(LRDFN,""AY"",",LRFILE1=63.2,LRIENS=LRDFN_",",LRCASE=1
 I 'LRAU D
 .S LRFILE="^LR(LRDFN,LRSS,LRI,2,"
 .S LRFILE1=+$$GET1^DID(LRSF,10,"","SPECIFIER")
 .S LRIENS=LRI_","_LRDFN_","
 .S LRCASE=+$$GET1^DIQ(69.2,LRAA_",",.05,"I")
 S LRA=0  F  S LRA=$O(@(LRFILE_"LRA)")) Q:LRA'>0!(LRQUIT)  D
 .;Topography
 .S LRIENS1=LRA_","_LRIENS
 .D WRITE(LRFILE1,LRIENS1,LRCASE,"T",0)
 .;Morphology
 .S LRA1=0
 .F  S LRA1=$O(@(LRFILE_"LRA,2,LRA1)")) Q:LRA1'>0!(LRQUIT)  D
 ..S LRFILE2=+$$GET1^DID(LRFILE1,4,"","SPECIFIER")
 ..S LRIENS2=LRA1_","_LRIENS1
 ..D WRITE(LRFILE2,LRIENS2,LRCASE,"M",5)
 ..;Etiology
 ..S LRA2=0
 ..F  S LRA2=$O(@(LRFILE_"LRA,2,LRA1,1,LRA2)")) Q:LRA2'>0!(LRQUIT)  D
 ...S LRFILE3=+$$GET1^DID(LRFILE2,1,"","SPECIFIER")
 ...S LRIENS3=LRA2_","_LRIENS2
 ...D WRITE(LRFILE3,LRIENS3,LRCASE,"E",10)
 .;Disease,Function,Procedure
 .F LRDFP="1;3","3;1","4;1.5" D
 ..S LRDFP(1)=$P(LRDFP,";"),LRDFP(2)=$P(LRDFP,";",2),LRA1=0
 ..F  S LRA1=$O(@(LRFILE_"LRA,LRDFP(1),LRA1)")) Q:LRA1'>0!(LRQUIT)  D
 ...S LRFILE2=+$$GET1^DID(LRFILE1,LRDFP(2),"","SPECIFIER")
 ...S LRIENS2=LRA1_","_LRIENS1
 ...S LRPRFX=$S(LRDFP(1)=1:"D",LRDFP(1)=3:"F",1:"P")
 ...D WRITE(LRFILE2,LRIENS2,LRCASE,LRPRFX,5)
 Q:LRQUIT
 W !!,$$CJ^XLFSTR("(End of Report)",IOM)
 Q
WRITE(LRP1,LRP2,LRP3,LRP4,LRP5) ;
 ;LRP1=File number
 ;LRP2=IEN string
 ;LRP3=Case (Upper or Lower)
 ;LRP4=Prefix
 ;LRP5=Tab position
 N LRSM
 S LRSM(1)=$$GET1^DIQ(LRP1,LRP2,.01)
 S:LRP3 LRSM(1)=$$LOW^XLFSTR(LRSM(1))
 S LRSM(2)=LRP4_"-"_$$GET1^DIQ(LRP1,LRP2,".01:2")
 W !?LRP5,LRSM(2)_": "_LRSM(1)
 I LRP4="P" D
 .S LRSM(3)=$$GET1^DIQ(LRP1,LRP2,.02,"I")
 .Q:LRSM(3)=""
 .W " (",$S('LRSM(3):"negative",LRSM(3)=1:"positive",1:"?"),")"
 I $Y>(IOSL-5) D HDR
 Q
HDR ;
 I LRPG>0,IOST?1"C-".E D  Q:LRQUIT
 .K DIR S DIR(0)="E"
 .D ^DIR W !
 .S:$D(DTOUT)!(X[U) LRQUIT=1
 W:LRPG>0 @IOF S LRPG=LRPG+1
 W !,LRSEC,?24,"SNOMED CODE LISTING",?49,"Acc: ",LRACC
 W:IOST'["BROWSE" ?71,"Pg: ",$J(LRPG,3)
 W !,"Patient: ",$G(LRDEM("PNM"))
 W ?49,$S(LRAU:"Resident: ",1:"Physician: ")
 W $E($G(LRDEM("PRO")),1,18)
 I LRAU D
 .W !,"Autopsy Date: ",$G(LRDEM("AUDT")),?35,$E($G(LRDEM("AUTYP")),1,12)
 .W ?49,"Date Died: ",$G(LRDEM("DTH"))
 W !,"ID: ",$G(LRDEM("SSN"))
 I 'LRAU D
 .W ?24,"Sex: ",$G(LRDEM("SEX")),?49,"DOB: ",$G(LRDEM("DOB"))
 .W ?71,"Age:",$J($G(LRDEM("AGE")),3)
 I LRAU D
 .W ?24,"DOB: ",$G(LRDEM("DOB")),?49,"Age At Death: ",$G(LRDEM("AGE"))
 .W ?72,"Sex: ",$G(LRDEM("SEX"))
 W !,LRL
 Q
END ;
 W:IOST?1"P-".E @IOF
 I LRDEV D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K %,DIR,DTOUT,DUOUT,DIRUT,X,Y
 Q
