RASITE ;HISC/CAH,FPT,GJC AISC/MJK,RMO-IRM Menu ;1/2/97  16:11
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
2 ;;Device Specifications
 F  D  Q:%
 . W !!,"Do you want to see a 'help' message on printer assignment"
 . S %=2 D YN^DICN
 . I %=0 W !!?3,"Enter 'Yes' to see the help message, or 'No' not to."
 . Q
 I %=-1 D Q2 QUIT
 I %=1 D DEVHLP
21 ; Select a location and answer the default printer prompts.
 W ! S DIC="^RA(79.1,",DIC(0)="AELMQ",DIC("A")="Select Imaging Location: ",DLAYGO=79.1 D ^DIC K DIC,DLAYGO G Q2:Y<0
 S DA=+Y,DIE="^RA(79.1,",DR="[RA SITE MANAGER]" D ^DIE
 K DE,DQ,DIE,DR D Q2 G 21
Q2 K %,%W,%X,%Y,C,D,D0,D1,DA,DI,DIWF,DIWL,DIW,DIWR,DIWT,DLAYGO,DN,I,POP,RAI,RAJ,X,Y,Z
 K DISYS,RA791,RA792
 Q
 ;
3 ;;Failsoft Parameters
 S DIC="^RA(79.2,",DIC(0)="AEMQ" D ^DIC K DIC G:Y<0 Q3 S DA=+Y,DIE="^RA(79.2,",DIE("NO^")="",DR="[RA IMAGE PARAMETERS]" D ^DIE K %,%DT,%X,%Y,D,D0,D1,DA,DE,DI,DLAYGO,DQ,DIE,DR,DIC,X
Q3 K I,POP,DDER,DDH,DISYS Q
 ;
5 ;;Imaging Type Activity Log
 S L=0,DIC="^RA(79.2,",FLDS="[RA ACTIVITY LOG]",FR="A",TO="ZZZZ",BY="#.01" D EN1^DIP K FR,TO,FLDS,BY,DHD,POP Q
 ;
DD71 ;entry point for input transform, 71.03, .01 field
 ;imaging type in procedure file should have associated AMIS codes
 ; radiology - AMIS codes ien's are 1:26
 ; nuclear medicine - AMIS codes ien is 25:27
 Q:'$D(DA(1))
 N RAIMAG,RAIMAGA S RAIMAG=$$ITYPE(DA(1)),RAIMAGA=$P(RAIMAG,U,3)
 Q:$S(RAIMAGA="NM"&(X=25):1,RAIMAGA="NM"&(X=26):1,RAIMAGA="NM"&(X=27):1,RAIMAGA'="NM"&(X'>26):1,1:0)
 W !?5,"Select Radiology AMIS codes for Radiology imaging type procedures,",!?5,"Nuclear Medicine AMIS codes for Nuclear Medicine procedures",*7
 K X Q
ITYPE(X) ;get image type for procedure in 71
 ;INPUT = IEN of Rad/Nuc Med Procedure file, in X
 ;OUTPUT = IEN of imaging type file (79.2)^name (.01)^abbreviation (3)
 S RASERIES=$S($P($G(^RAMIS(71,+X,0)),U,6)="S":1,1:0)
 S X=+$P($G(^RAMIS(71,X,0)),U,12)
 Q $$IMAG(X)
IMAG(X) ;set string of passed image type
 ;INPUT=ien of image type, in x
 ;OUTPUT=Internal Entry Number of image type^name (.01)^abbreviation (3)
 N Y
 S Y=$G(^RA(79.2,X,0))
 Q +X_U_$P(Y,U)_U_$P(Y,U,3)
DEVHLP ; Display printer assignment help text to the user.
 D HOME^%ZIS W @IOF
 W !,"Default Printer Assignments:",!,"----------------------------"
 W !,"There are six imaging location parameters that the coordinator will"
 W !,"not be able to enter.  They are the default printers; specifically,the"
 W !,"default flash card/exam label, jacket label, request, request cancellation,"
 W !,"radiopharmaceutical dosage ticket, and report printers.  Once you have"
 W !,"assigned these printer names to a location, the module will automatically"
 W !,"route output to the appropriate printer without having to ask the user."
 W !,"NOTE:  If you have more than one imaging location within an imaging type"
 W !,"the Division parameter 'Ask Imaging Location' must be set to 'yes' in"
 W !,"order to print cancelled requests on the request cancellation printer."
 Q
