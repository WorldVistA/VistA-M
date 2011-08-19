IB20PT ;ALB/CPM - IB V2.0 POST-INITIALIZATION ROUTINE ; 05-AUG-92
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ;
 ; Perform one-time post init items
 ;
 I +$G(^DD(350,0,"VR"))<2 D
 .D HOME^%ZIS
 .D ^IB20PT5 ;  variety of one-time items
 .D ^IB20PT3 ;  table pointer resolution
 ;
 ; Run at every installation
 ;
 D ^IBONIT ;    install protocols
 D ^IB20PT4 ;   install list templates
 D ^IB20PT2 ;   install imp/exp utility package entry
 D ^IB20PT7 ;   add new rate types and revenue codes
 D ^IB20PT71 ;  remove options from menus
 D ^IB20PT8 ;   install routines from other packages
 ;
 ; Do this as the very last thing in the install
 ;
 I +$G(^DD(350,0,"VR"))<2 D
 .D HOME^%ZIS
 .D ^IB20PT1 ;  insurance file post-init conversion
 ;
 ; Installation has completed - display final messages
 ;
 D NOW^%DTC S IBEDT=$H
 W !!,">>> Initialization Complete at " S Y=% D DT^DIQ
 I $D(IBBDT) D
 .S IBDAY=+IBEDT-(+IBBDT)*86400 ;additional seconds of over midnight
 .S X=IBDAY+$P(IBEDT,",",2)-$P(IBBDT,",",2)
 .W !,"    Elapse time for initialization was: ",X\3600," Hours,  ",X\60-(X\3600*60)," Minutes,  ",X#60," Seconds"
 D MSG
 K IBBDT,IBEDT,IBDAY,X,I
 Q
 ;
 ;
MSG W !!!,$TR($J("",79)," ","*")
 W !!,"The installation of Integrated Billing Version 2.0 has completed."
 ;
 W !!,"Please remember to re-compile all templates, by typing D ALL^IBEFUTL1"
 W !,"in programmer mode, on all of your systems."
 ;
 W !!,"Please be sure that the Means Test nightly billing compilation (option"
 W !,"IB MT NIGHT COMP) is scheduled to run.  If it is not, it should be"
 W !,"scheduled to run early each morning (after the G&L Recalculation)."
 W !,"Be sure that it is not scheduled twice!!"
 ;
 W !!,"The Integrated Billing DGCR* routines have been converted to the IB*"
 W !,"namespace.  The following DGCR* routines are still required on your system:"
 W !!?8,"DGCRNS     DGCRAMS   DGCRP3"
 W !!,"These routines were exported with this version."
 W !!!,"The following DGCR* routines are now obsolete and may be deleted from"
 W !,"your system:",!
 F I=1:1 S X=$P($T(RTN+I),";;",2,99) Q:X=""  W !,X
 ;
 W !!!,"The following IB* routines are now obsolete and may be deleted from"
 W !,"your system:",!!,"IBACKIN   IBEP      IBEHCFA   IBEHCF1   IBOHCTP   IBOHCP"
 W !!,$TR($J("",79)," ","*")
 Q
 ;
RTN ;Obsolete routines
 ;;DGCRA     DGCRA0    DGCRA1    DGCRA2    DGCRA3    DGCRA31   DGCRA32   DGCRAMS1
 ;;DGCRAMS2  DGCRB     DGCRB1    DGCRB2    DGCRBB    DGCRBB1   DGCRBB2   DGCRBR
 ;;DGCRBULL  DGCRC     DGCRCC    DGCRCC1   DGCRCC2   DGCRCPT   DGCRMENU  DGCRNQ
 ;;DGCRNQ1   DGCROBL   DGCROMBL  DGCRONS1  DGCRONS2  DGCRONSC  DGCROPV   DGCROPV1
 ;;DGCROPV2  DGCRORT   DGCRORT1  DGCROST   DGCROST1  DGCROTR   DGCROTR1  DGCROTR2
 ;;DGCROTR3  DGCROTR4  DGCRP     DGCRP0    DGCRP1    DGCRP2    DGCRP4    DGCRPAR
 ;;DGCRPAR1  DGCRSC1   DGCRSC2   DGCRSC3   DGCRSC4   DGCRSC4A  DGCRSC4B  DGCRSC4C
 ;;DGCRSC5   DGCRSC6   DGCRSC61  DGCRSC7   DGCRSC8   DGCRSC8H  DGCRSCE   DGCRSCE1
 ;;DGCRSCH   DGCRSCH1  DGCRSCP   DGCRSCU   DGCRSCV   DGCRST    DGCRST1   DGCRST2
 ;;DGCRST3   DGCRST4   DGCRST5   DGCRTN    DGCRTP    DGCRU     DGCRU1    DGCRU2
 ;;DGCRU3    DGCRU4    DGCRU5    DGCRU6    DGCRU61   DGCRU62   DGCRU63   DGCRU7
 ;;DGCRU71   DGCRVA    DGCRVA0   DGCRVA1   DGCRXX    DGCRXX1   DGCRXX10  DGCRXX11
 ;;DGCRXX12  DGCRXX13  DGCRXX14  DGCRXX15  DGCRXX16  DGCRXX17  DGCRXX18  DGCRXX19
 ;;DGCRXX2   DGCRXX3   DGCRXX4   DGCRXX5   DGCRXX6   DGCRXX7   DGCRXX8   DGCRXX9   
