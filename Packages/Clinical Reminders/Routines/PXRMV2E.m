PXRMV2E ; SLC/PKR - Environment check for PXRM*2.0. ;12/17/2004
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ;===============================================================
ENVCHK ;Perform an environment check. Check for the existence of the globals
 ;that are indexed. If they exist then the index for that global must
 ;be built before v2.0 can be installed.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,GNAME,NE,NG,NI,TEXTG,TEXTI,X,Y
 ;Ask if this is a Legacy system, if it is then don't require the
 ;index being built.
 S DIR(0)="Y"_U_"AO",DIR("B")="NO"
 W !,"Is this a Legacy system?"
 D ^DIR
 I Y Q
 S (NG,NI)=2
 ;
 ;LABORATORY TEST
 D CHECK(63,.NG,.TEXTG,.NI,.TEXTI)
 ;
 ;MENTAL HEALTH
 D CHECK(601.2,.NG,.TEXTG,.NI,.TEXTI)
 ;
 ;ORDERS
 D CHECK(100,.NG,.TEXTG,.NI,.TEXTI)
 ;
 ;PTF
 D CHECK(45,.NG,.TEXTG,.NI,.TEXTI)
 ;
 ;PHARMACY PATIENT
 D CHECK(55,.NG,.TEXTG,.NI,.TEXTI)
 ;
 ;PRESCRIPTION
 D CHECK(52,.NG,.TEXTG,.NI,.TEXTI)
 ;
 ;PROBLEM LIST
 D CHECK(9000011,.NG,.TEXTG,.NI,.TEXTI)
 ;
 ;RADIOLOGY
 D CHECK(70,.NG,.TEXTG,.NI,.TEXTI)
 ;
 ;V CPT
 D CHECK(9000010.18,.NG,.TEXTG,.NI,.TEXTI)
 ;
 ;V EXAM
 D CHECK(9000010.13,.NG,.TEXTG,.NI,.TEXTI)
 ;
 ;V IMMUNIZATION
 D CHECK(9000010.11,.NG,.TEXTG,.NI,.TEXTI)
 ;
 ;V PATIENT ED
 D CHECK(9000010.16,.NG,.TEXTG,.NI,.TEXTI)
 ;
 ;V POV
 D CHECK(9000010.07,.NG,.TEXTG,.NI,.TEXTI)
 ;
 ;V SKIN TEST
 D CHECK(9000010.12,.NG,.TEXTG,.NI,.TEXTI)
 ;
 ;VITAL MEASUREMENT
 D CHECK(120.5,.NG,.TEXTG,.NI,.TEXTI)
 ;
 I NI>2 S XPDABORT=1
 I $G(XPDABORT) D
 . S TEXTI(1)="Clinical Reminders v2.0 cannot be installed because the following indexes"
 . S TEXTI(2)="are not built:"
 . D EN^DDIOL(.TEXTI)
 E  D
 . S TEXTI(1)="Environment check passed, ok to install Clinical Reminders v2.0"
 . D EN^DDIOL(.TEXTI)
 ;
 I NG>2 D
 . S TEXTG(1)=" "
 . I NG=3 S TEXTG(2)="The following global does not have data or does not exist:"
 . I NG>3 S TEXTG(2)="The following globals do not have data or do not exist:"
 . S NG=NG+1,TEXTG(NG)="Because of this Clinical Reminder evaluation may not operate correctly on your system!"
 . D EN^DDIOL(.TEXTG)
 Q
 ;
 ;===============================================================
CHECK(FNUM,NG,TEXTG,NI,TEXTI) ;
 N GNAME,NE
 S GNAME=$$GET1^DID(FNUM,"","","NAME")
 S NE=$$GET1^DID(FNUM,"","","ENTRIES")
 I NE="" S NG=NG+1,TEXTG(NG)=" "_GNAME_" does not exist"
 I NE=0 S NG=NG+1,TEXTG(NG)=" "_GNAME_" does not have any data"
 I (NE>0)&'$D(^PXRMINDX(FNUM,"DATE BUILT")) S NI=NI+1,TEXTI(NI)=" "_GNAME
 Q
 ;
