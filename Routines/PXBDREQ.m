PXBDREQ ;ISL/JVS - DISPLAY REQUESTS ;6/17/03  10:29
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**73,124**;Aug 12, 1996
 ;
 ; Variable list
 ; These two variables represent the data that has been selected
 ;  to be saved in the v files by the user
 ;
 ;  REQ*=PROVIDER^PRIMARY^CPT^QUANTITY^POV^PRIMARY
 ;  REQI=Internal Values
 ;  REQE=External Values
 ;
REQ(NO) ;--Display the REQUESTED Data
 N ENTRY,VAR
 S VAR="N"_NO D @VAR
 Q
N4 ;---Fourth Method--for the CPT promts
 W !,"PROVIDER: ...Enter the provider associated with the CPT'S....."
 D UNDON^PXBCC
 W !,?5,"CPT: "
 F  W $C(32) Q:$X=(IOM-(4))
 W !
 D UNDOFF^PXBCC
 Q
N5 ;---Fifth Method--for the PROVIDER prompts
 W !,"PROVIDER: ...Select a Provider....."
 D UNDON^PXBCC
 W !
 F  W $C(32) Q:$X=(IOM-(4))
 W !
 D UNDOFF^PXBCC
 Q
 ;
N6 ;---Sixth Method--for the POV(DIAGNOSIS) prompts
 W !,"ICD CODE: ...Select a DIAGNOSIS Code....."
 D UNDON^PXBCC
 W !
 F  W $C(32) Q:$X=(IOM-(4))
 W !
 D UNDOFF^PXBCC
 Q
N7 ;---SEVENTH Method--for the STOP CODES prompts
 W !,"STOP CODE: ...Select an AMIS STOP Code....."
 D UNDON^PXBCC
 W !
 F  W $C(32) Q:$X=(IOM-(4))
 W !
 D UNDOFF^PXBCC
 Q
N8 ;---EIGHTH Method--for the ENCOUNTERS prompts
 W !,"ENCOUNTERS: ...Select an ENCOUNTER ....."
 D UNDON^PXBCC
 W !
 F  W $C(32) Q:$X=(IOM-(4))
 W !
 D UNDOFF^PXBCC
 Q
 ;
PRINT(NO) ;--Display the requested information
 N ENTRY,VAR
 S VAR="ZP"_NO D @VAR
 Q
ZP1 ;--PROVIDER AND PRIMARY
 I '$D(REQE) Q
 D LOC^PXBCC(1,10) W $P(REQE,"^",1)_"      "_$P(REQE,"^",2),IOELEOL
 Q
ZP2 ;--CPT PROCEDURE AND DESCRIPTION
 I '$D(REQE) Q
 S ENTRY=$P(REQE,"^",3) I ENTRY]"" D RREVH^PXBCC(1,10,ENTRY)
 Q
ZP3 ;--QUANTITY OF PROCEDURES
 I '$D(REQE) Q
 S ENTRY=$P(REQE,"^",4) I ENTRY]"" D RREV^PXBCC(1,45,ENTRY)
 Q
ZP4 ;--DIAGNOSIS
 I '$D(REQE) Q
 D LOC^PXBCC(1,10) W $P(REQE,"^",5)_"      "_$P(REQE,"^",6),IOELEOL
 Q
 ;
ZP5 ;--STOP CODE
 I '$D(REQE) Q
 S ENTRY=$P(REQE,"^",10) I ENTRY]"" D RREV^PXBCC(0,10,ENTRY)
 Q
 ;
ZP6 ;PX124
ZP7 ;
ZP8 ;
ZP9 ;
ZP10 ;
ZP11 ;
ZP12 ;
ZP13 ;
ZP14 ;
ZP15 ;
 I $D(REQE) D LOC^PXBCC(1,0) W "DIAGNOSIS: ",$P(REQE,"^",NO+6),IOELEOL
 Q
 ;               
RSET(CATEGORY) ; Reset the data in the REQ,REQI and REQE variables
 ; CATEGORY IS EQUAL TO FILE NEUMONICS (eg. CPT,POV,PRV)
 D @CATEGORY
 Q
CPT ;CPT CODES
 N PX124
 S $P(REQI,"^",3)="",$P(REQE,"^",3)="",$P(REQI,"^",8)=""
 S $P(REQI,"^",4)="",$P(REQE,"^",4)=""
 F PX124=12:1:22 S $P(REQI,"^",PX124)="",$P(REQE,"^",PX124)=""
 K REQ
 Q
PRV ;PROVIDER
 S $P(REQI,"^",1)="",$P(REQE,"^",1)="",$P(REQI,"^",7)=""
 S $P(REQI,"^",2)="",$P(REQE,"^",2)=""
 Q
POV ;PURPOSE OF VISIT
 S $P(REQI,"^",5)="",$P(REQE,"^",5)="",$P(REQI,"^",9)=""
 S $P(REQI,"^",6)="",$P(REQE,"^",6)=""
 Q
STP ;STOPCODES
 S $P(REQI,"^",10)="",$P(REQE,"^",10)=""
 S $P(REQI,"^",11)="",$P(REQE,"^",11)=""
 Q
 ;
