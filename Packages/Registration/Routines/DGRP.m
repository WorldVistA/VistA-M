DGRP ;ALB/MRL - REGISTRATION ENTRY POINT ;06 JUN 88@2300
 ;;5.3;Registration;**108,114,250**;Aug 13, 1993
 ;
EN W ! S DIC="^DPT(",DIC(0)="AEQMZ" S:$S(('$D(DGRPV)#2):0,DGRPV:0,1:1) DIC(0)=DIC(0)_"L" D ^DIC
 I +Y'>0 D QQ^DGRPP Q
 K DIRUT,DUOUT,DTOUT
 S DFN=+Y I $P(Y,"^",3) D NEW
 K DA,DIC
 Q
 ;
 ; The following tags are used by external packages.  Input DFN as
 ; IEN of PATIENT file.  Consistency checker is automatically called.
 ; Screen edit allowed if DGRPV=0
 ;
ENED S DGRPV=0
EN1 I $G(DGRPV)=0 L +^DPT(DFN):3 E  D MSG Q
 D ^DGRPV
 I $G(DGRPV)=0 L -^DPT(DFN)
EN2 I $G(DGRPV)=0 L +^DPT(DFN):3 E  D MSG Q
 D ^DGRP1
 D DISPMAS^DGMTCOU1(DFN) ;DIPLAY MT FILE CP STATUS
 I $G(DGRPV)=0 L -^DPT(DFN)
 Q
 ;
VIEW S DGRPV=1 D EN Q:$S(('$D(Y)#2):1,Y'>0:1,1:0)  D EN1 G VIEW
ELV S DGRPV=1,DGELVER=1 D EN Q:$S(('$D(Y)#2):1,Y'>0:1,1:0)  D  G ELV
 . L +^DPT(DFN):3 E  D MSG Q
 . D ENED
 . L -^DPT(DFN)
ELVD Q:'$D(DFN)#2  S DGELVER=1,DGRPV=0 D EN1 Q
 ;
NEW ;if new patient xecute new patient dr string (from patient type)
 ;called from DG10, DGPMV, DGRPTU and DGREG
 ;
 ;use DGRPX as scratch variable
 I $D(^DPT(DFN,"TYPE")),$D(^DG(391,+^("TYPE"),"DR")),^("DR")]"" X ^("DR") S DIE="^DPT(",DA=DFN D ^DIE
 K DGRPX Q
 ;
MSG ;If lock fails:
 W *7,!!,"Patient is being edited. Try again later."
 Q
 ;
 ;
RTNS ;The following is the numbering scheme for the DGRP routines
 ;
 ;  DGRP    : routine driver for registration screens
 ;  DGRP_n  : routine for screen n where 1<=n<=15
 ;  DGRPE*  : screen edit routines where line tag xy contains the
 ;            DR string to edit.  x = screen number, y = edit item
 ;  DGRPH   : help processor to display editable screens/data elements
 ;  DGRPP   : screen processor (controls display of high intensity, etc)
 ;  DGRPU   : utility routine (contains screen header, etc.)
 ;  DGRPV   : defines variables necessary for registration screens
 ;
 ;  DGRPC*  : consistency checker
 ;  DGRPD*  : data displays (pt inquiries)
 ;
 ;Variables set:
 ;
 ;  DGRPV   : 0 allows edit of data ; 1 for view
 ;  DGELVER : 1 if eligibility verification ; '$D otherwise
 ;
 ;
 ;
FILE ; The following are the numbering schemes for fields in the
 ; TYPE OF PATIENT file
 ;
 ; Fields 1-15 will be a set of codes denoting whether or not a certain
 ;        screen is on or off for that type of patient.  Only certain
 ;        screens can be turned off, so not all field numbers will be
 ;        taken.
 ;
 ;        Data from these fields can be found on node S in the same
 ;        piece position as the field number.
 ;
 ; Fields 11-149 will be a set of codes denoting whether a certain data
 ;        element is on or off for editing.  The field number is equal
 ;        to SCREEN #_ITEM #.
 ;
 ;        Items in these field numbers are on the E node in the same
 ;        piece position as the field number.
 ;
 ;        note:  because fileman does not take more than 100 pieces on
 ;               a node, items on screen 10 or higher were put on node
 ;               E10 on piece SCREEN#_ITEM#-100.
 ;
 Q
