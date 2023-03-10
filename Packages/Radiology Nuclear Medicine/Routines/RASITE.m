RASITE ;HISC/CAH,FPT,GJC AISC/MJK,RMO - IRM Menu ; Sep 28, 2022@11:23:18
 ;;5.0;Radiology/Nuclear Medicine;**137,185,194**;Mar 16, 1998;Build 1
 ;
 ; Note: tag DD71 code removed with RA*5.0*194 
 ;
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
 D ARP ;After hours printer parameters (set/delete) ;P185/KLM
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
ITYPE(X) ;get image type for procedure in 71
 ;INPUT = IEN of Rad/Nuc Med Procedure file, in X
 ;OUTPUT = IEN of imaging type file (79.2)^name (.01)^abbreviation (3)
 S RASERIES=$S($P($G(^RAMIS(71,+X,0)),U,6)="S":1,1:0)
 S X=+$P($G(^RAMIS(71,X,0)),U,12)
 Q $$IMAG(X)
 ;
IMAG(X) ;set string of passed image type
 ;INPUT=ien of image type, in x
 ;OUTPUT=Internal Entry Number of image type^name (.01)^abbreviation (3)
 N Y
 S Y=$G(^RA(79.2,X,0))
 Q +X_U_$P(Y,U)_U_$P(Y,U,3)
 ;
DEVHLP ; Display printer assignment help text to the user.
 ;Add registered request printer to help text -P137/KLM
 ;185 - Add Alternate request printer to help text
 D HOME^%ZIS W @IOF
 W !,"Default Printer Assignments:",!,"----------------------------"
 W !,"There are seven imaging location parameters that the coordinator will"
 W !,"not be able to enter.  They are the default printers; specifically, the"
 W !,"default flash card/exam label, jacket label, request, registered request,"
 W !,"alternate request, request cancellation, radiopharmaceutical dosage ticket,"
 W !,"and report printers. Once you have assigned these printer names to a location,"
 W !,"the module will automatically route output to the appropriate printer"
 W !,"without having to ask the user. NOTE:  If you have more than one imaging"
 W !,"location within an imaging type the Division parameter 'Ask Imaging Location'"
 W !,"must be set to 'yes' in order to print cancelled requests on the request"
 W !,"cancellation printer."
 Q
ARP ;Set After Hours Request Printer parameters.
 ;Called from option RA DEVICE
 ;File 79.1 APR node contains the following parameters
 ;which should be set if an after hours printer (ARP;1) is defined
 ;ARP;1               81  ALTERNATE REQUEST PRINTER         <-Pntr  [P3.5']
 ;ARP;2               82  PRINTER USAGE?                                [S]
 ;ARP;3               83  AFTER HOURS BEGIN TIME                     [Ft13]
 ;ARP;4               84  AFTER HOURS END TIME                       [Ft13]
 ;ARP;5               85  AFTER HOURS WEEKEND?                          [S]
 ;ARP;6               86  AFTER HOURS HOLIDAY?                          [S]
 ;ARP;7               87  AFTER HOURS CATEGORY OF EXAM                  [S]
 ;ARPL;0              88  ALTERNATE PRT REQUESTING LOC    <-Mult [79.188PA]
 ; -0;1              .01   -ALTERNATE PRT REQUESTING LOC     <-Pntr  [P44']
 ;
 N RARP,RADA,RAPU,RADA1 S RADA1=DA
 K DR,DIE S DIE="^RA(79.1,"
 S RARP=$G(^RA(79.1,DA,"ARP"))
 I +RARP=0 D DEL Q  ;no printer defined
 S RAPU=$P(RARP,U,2) I $G(RAPU)="" W !,"Usage required - must delete..." D DEL Q  ;Usage not defined
 I RAPU=1 D  Q  ;check after hours params
 .I ($P($G(^RA(79.1,DA,"ARP")),U,3)="")!($P($G(^RA(79.1,DA,"ARP")),U,4)="") W !,"Time entries required - must delete..." D DEL Q
 .I $P(RARP,U,7)="" W !,"Category required - must delete..." D DEL Q  ;Category not defined
 .Q
 I RAPU=2 D  Q  ;check alt params
 .I ($P($G(^RA(79.1,DA,"ARP")),U,7)="")&('$O(^RA(79.1,DA,"ARPL",0))) W !,"Category or location required - must delete..." D DEL Q
 Q
SETIME(DA,RAFLD) ;called from [RA SITE MANAGER] input template
 ;RAFLD is 83 or 84 (begin time/end time)
 Q:DA=""!(RAFLD="")
 N DIR,Y
 S DIR(0)="79.1,"_RAFLD_"^^K:$$SCRX^RASITE(RAFLD,X) X"
 D ^DIR
 Q Y
SCRX(RAFLD,X) ;input transform (cannot add to DD)
 N %DT,Y
 S X="T@"_X,%DT="RS"
 D ^%DT I Y<0 Q 1
 S X=$E(Y_"0000",9,12)
 I RAFLD=83,(X<1200) Q 1
 I RAFLD=84,(X>1159) Q 1
 Q 0
DEL ;Required field missing - delete all
 K DR,DIE S DIE="^RA(79.1,"
 S DR="81///@;82///@;83///@;84///@;85///@;86///@;87///@" D ^DIE
 K DR,DIE
 S RADA=0 F  S RADA=$O(^RA(79.1,RADA1,"ARPL",RADA)) Q:RADA=""  D
 .S DA=RADA
 .S DA(1)=RADA1,DIE="^RA(79.1,"_DA(1)_",""ARPL"",",DR=".01///@" D ^DIE
 .Q
 Q
