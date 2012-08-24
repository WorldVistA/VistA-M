PSOBPSSP ;BIRM/LE - ePharmacy Site Parameters Definition ;04/28/08
 ;;7.0;OUTPATIENT PHARMACY;**289,385**;DEC 1997;Build 27
 ;
DIV ; - Prompt for ePharmacy Site Parameters
 N DIC,DIE,DA,Y,PSODIV,DLAYGO,DTOUT,DUOUT
 W !!,"Regardless of any parameters defined, Refill-Too-Soon, Drug Utilization"
 W !,"Review (DUR), CHAMPVA and TRICARE rejects will always be placed on the"
 W !,"Third Party Payer Rejects - Worklist, also known as Pharmacy Reject Worklist."
 W !,"These parameters are uneditable and are the default parameters."
 N PSODIV,XX
 ;
DIV2 ;
 K DIC,DIE,DA,Y,PSODIV S PSODIV=""
 ; - Division/Site selection
 I '$G(PSOSITE) D ^PSOLSET I '$D(PSOPAR) W $C(7),!!,"Pharmacy Division Must be Selected!",! Q
 W !!
 S DIC("A")="Division: ",DIC=52.86,DIC(0)="ABEQL",DLAYGO=52.86 D ^DIC
 K DIC G:$D(DUOUT)!($D(DTOUT))!(Y=-1) EXIT I Y<0 W !,"A division must be entered to proceed.",!! G DIV2
 S PSODIV=$P(Y,"^")
 ;
 ;Prompt for REJECT WORKLIST DAYS and ALLOW ALL REJECTS fields
 K DIE,DA,DIC
 S DIE="^PS(52.86,",DA=PSODIV,DIC(0)="QEALZ",DR="1;4" D ^DIE
 G EXIT:$D(DUOUT)!($D(DTOUT))
 ;
CODES ;
 ;Prompt for Reject codes that will be allowed to pass to the Pharmacy Reject Worklist
 K DATA
 N XX1,XX2,XX3
 D GETS^DIQ(52.86,PSODIV_",","52.8651*","EI","DATA")
 I $D(DATA) D
 . W !!,"Previously defined override reject codes:",!!,"Code",?10,"Description",?70,"Auto Send"
 . W !,"-----",?10,"----------------------------------",?70,"---------"
 . S (XX1,XX2,XX3)="" F  S XX1=$O(DATA(52.8651,XX1)) Q:XX1=""  D
 .. I $D(DATA(52.8651,XX1,".01","E")) D
 ... W !,$J(DATA(52.8651,XX1,".01","E"),5)
 ... W ?10,$E($$GET1^DIQ(9002313.93,DATA(52.8651,XX1,".01","I")_",",.02),1,50)
 ... I $D(DATA(52.8651,XX1,1,"E")) W ?70,$J(DATA(52.8651,XX1,1,"E"),6)
 W !!
 ; 
 K DIC,DA,DIE
 S DIC="^PS(52.86,"_PSODIV_",1,",DA(1)=PSODIV,DIC(0)="QEALZ",DR=".01;1"
 D ^DIC I $D(DUOUT)!($D(DTOUT))!(Y=-1) K DIC,DA G DIV2
 S DA=+Y
 K DIE S DIE=DIC,DR=".01;1" D ^DIE
 K DIE,DR,DA,Y
 G CODES
 ;
EXIT ;
 K DIC,DIR,DIE,DA,DLAYGO,DATA
 Q
 ;
HELP ;Help text for CODES field (#.01) of REJECT CODE multiple(#52.8651)
 W !!,"*** Enter a valid third party reject code from the previously entered codes"
 W !,"*** above, enter a new code, or enter one from the provided listing below."
 W !,"*** Valid codes are those defined in BPS NCPDP REJECT CODES file (#9002313.93).",!!
 Q
