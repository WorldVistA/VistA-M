PXRRLCSC ;ISL/PKR - PCE reports locations selection criteria routines. ;4/8/97
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**12,18,20,72,189**;Aug 12, 1996;Build 13
 ;;Reference to FileMan call Institution file (#4) supported by DBIA 10090.
 ;;Reference to ^DIC(40.7 supported by DBIA 93-C.
 ;
 ;=======================================================================
BYLOC ;Ask if the report should be broken down by clinic location or clinic
 ;stop
 N X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"L:Location;"
 S DIR(0)=DIR(0)_"S:Stop"
 S DIR("A")="Do you want totals by Clinic Location or Clinic Stop?"
 S DIR("B")="L"
 D ^DIR K DIR
 I Y="L" S $P(PXRRLCSC,U,3)=1
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 Q
 ;
 ;=======================================================================
CSTOP ;Get a list of clinic stop codes.
 K DTOUT,DUOUT
 S NCS=0
 S DIC("A")="Select CLINIC STOP: "
 W !
NSTOP ;Select the clinic stop codes.
 S DIC=40.7
 S DIC(0)="AEMQZ"
 I NCS'<1 S DIC("A")="Select another CLINIC STOP: "
 D ^DIC K DIC
 I X=(U_U) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 I (NCS=0)&(+Y=-1) W !,"You must select a clinic stop!" G CSTOP
 I +Y'=-1 D  G NSTOP
 . S NCS=NCS+1
 .;Save the external form of the name, the IEN, and the stop code.
 . S PXRRCS(NCS)=$P(Y(0,0),U,1)_U_$P(Y,U,1)_U_$P(Y(0),U,2)
 ;Sort the clinic stop list into alphabetical order.
 S NCS=$$SORT^PXRRUTIL(NCS,"PXRRCS",2)
 Q
 ;
 ;=======================================================================
FACILITY ;Get the facility list.
 N IC,STATION,X,Y
 K DIRUT,DTOUT,DUOUT
 S NFAC=0
 S DIC("B")=+$P($$SITE^VASITE,U,3)
 S DIC("A")="Select FACILITY: "
 W !
FAC ;Select the facilities.
 S DIC=4
 S DIC(0)="AEMQZ"
 I NFAC'<1 S DIC("A")="Select another FACILITY: "
 D ^DIC K DIC
 I X=(U_U) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 I +Y'=-1 D  G FAC
 . S NFAC=NFAC+1
 . S PXRRFAC(NFAC)=Y_U_Y(0,0)
 ;
 ;Save the facility names and station.
 F IC=1:1:NFAC D
 . S X=$P(PXRRFAC(IC),U,1)
 . ;S STATION=$P($G(^DIC(4,X,99)),U,1)
 . S STATION=$$GET1^DIQ(4,X_",",99,"I")
 . S PXRRFACN(X)=$P(PXRRFAC(IC),U,2)_U_STATION
 ;
 ;Ask user whether they want to display non-va sites
 S DIR(0)="Y"_U_"N:No;"
 S DIR(0)=DIR(0)_"Y:Yes"
 W !
 S DIR("A")="Do you want to display encounters at Non-VA sites "
 S DIR("B")="NO"  ; Changed from N to NO - *189
 D ^DIR K DIR
 I +Y=1 D
 . S NFAC=NFAC+1
 . S PXRRFACN("*")="NON-VA^*"
 . S PXRRFAC(NFAC)="*^NON-VA^NON-VA"
 . S NONVA=1
 ;
 ;Sort the facility list into alphabetical order.
 S NFAC=$$SORT^PXRRUTIL(NFAC,"PXRRFAC",2)
 Q
 ;
 ;=======================================================================
HLOC ;Build a list of hospital locations.
 N IEN,SC,X,Y
 K DTOUT,DUOUT
 S NHL=0
 S DIC="^SC("
 S DIC(0)="AEQMZ"
 S DIC("A")="Select HOSPITAL LOCATION: "
 W !
NHLOC I NHL'<1 S DIC("A")="Select another HOSPITAL LOCATION: "
 D ^DIC
 I X=(U_U) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 I +Y'=-1 D  G NHLOC
 . S NHL=NHL+1
 . S IEN=$P(Y,U,1)
 .;Get the stop code.
 . S X=$P(^SC(IEN,0),U,7)
 . I +X>0 S SC=$P(^DIC(40.7,X,0),U,2)
 . E  S SC="Unknown"
 . I $L(SC)=0 S SC="Unknown"
 .;Save the IEN, the external form of the name, and the stop code.
 . S PXRRLCHL(NHL)=IEN_U_$P(Y(0,0),U,1)_U_SC
 .;Save the external form of the name, then IEN, and the stop code.
 . S PXRRLCHL(NHL)=$P(Y(0,0),U,1)_U_IEN_U_SC
 E  K DIC
 I $D(DUOUT) G HLOC
 I (NHL=0)&(+Y=-1) W !,"You must select a hospital location!" G HLOC
 ;Sort the hospital location list into alphabetical order.
 S NHL=$$SORT^PXRRUTIL(NHL,"PXRRLCHL",2)
 Q
 ;
 ;=======================================================================
LOC(ADEF,BDEF) ;Establish the location selection criteria.
 N X,Y
LOC0 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="S"_U_"HA:All Hospital Locations (with encounters);"
 S DIR(0)=DIR(0)_"HS:Selected Hospital Locations;"
 S DIR(0)=DIR(0)_"CA:All Clinic Stops (with encounters);"
 S DIR(0)=DIR(0)_"CS:Selected Clinic Stops"
 S DIR("A")=ADEF
 S DIR("B")=BDEF
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S PXRRLCSC=Y_U_Y(0)
 ;
 ;If locations are to be selected individually get the list.
 I Y="HS" D HLOC
 I $D(DTOUT) Q
 I $D(DUOUT) G LOC0
 I Y="CS" D CSTOP
 I $D(DTOUT) Q
 I $D(DUOUT) G LOC0
 Q
 ;
 ;=======================================================================
NEWPAGE ;Allow the user to decide if they want each location to start on a new
 ;page.
 N X,Y
 K DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="YA0"
 S DIR("A")="Want to start each location on a new page:  "
 S DIR("B")="Y"
 W !
 D ^DIR K DIR
 I $D(DIROUT) S DTOUT=1
 I $D(DTOUT)!($D(DUOUT)) Q
 S PXRRLCNP=Y_U_Y(0)
 Q
 ;
